Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266626AbSKOT2V>; Fri, 15 Nov 2002 14:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266631AbSKOT2V>; Fri, 15 Nov 2002 14:28:21 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:40007 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S266626AbSKOT2S>;
	Fri, 15 Nov 2002 14:28:18 -0500
Message-ID: <3DD54C74.2080808@mvista.com>
Date: Fri, 15 Nov 2002 13:35:16 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Levon <levon@movementarian.org>
CC: "'Zwane Mwaikambo'" <zwane@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: NMI handling rework for x86
References: <3DD47858.3060404@mvista.com> <20021115051207.GA29779@compsoc.man.ac.uk> <3DD5011F.9010409@mvista.com> <20021115174833.GB83229@compsoc.man.ac.uk> <3DD5444E.9070808@mvista.com> <20021115192842.GC83229@compsoc.man.ac.uk>
Content-Type: multipart/mixed;
 boundary="------------060405060906010902040905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060405060906010902040905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

John Levon wrote:

>>I have also created a kernel module that loops requesting and releasing 
>>the NMI, and counting the number of NMIs that actually get hit by the 
>>handler that is installed..  This is on a dual 2.8GHZ Pentium 4 machine 
>>with hyperthreading (so 4 processors, sort of).  I have six processes 
>>doing the request/release and some other processes eating CPU on each 
>>processor.  This has been running for almost three hours, about 
>>10,000,000 NMIs have occurred (around 1000/sec).  Around 4700 NMIs have 
>>been caught by the handler, meaning that it was a close race between the 
>>removal and the NMI occurring.  So it looks good.
>>    
>>
>
>Can you send me the test module so I don't have to bother writing one
>myself ?
>
>I'll try to test this weekend
>
Certainly.  It's attached.

Thanks,

-Corey


--------------060405060906010902040905
Content-Type: text/plain;
 name="test_nmi.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test_nmi.c"

#include <linux/config.h>
#include <linux/module.h>
#include <linux/miscdevice.h>
#include <linux/init.h>
#include <linux/errno.h>
#include <linux/nmi.h>
#include <linux/notifier.h>
#include <asm/atomic.h>

static atomic_t nmi_count = ATOMIC_INIT(0);
static atomic_t request_count = ATOMIC_INIT(0);

static int
do_nmi(void *dev_id, struct pt_regs *regs, int cpu, int handled)
{
	atomic_inc(&nmi_count);
	return NOTIFY_DONE;
}

static ssize_t do_read(struct file *file,
		       char        *buf,
		       size_t      count,
		       loff_t      *ppos)
{
	int rv;
	long last_jiffies = jiffies;
	struct nmi_handler nmi_handler =
	{
		.link     = LIST_HEAD_INIT(nmi_handler.link),
		.dev_name = "nmi_test",
		.dev_id   = NULL,
		.handler  = do_nmi,
		.priority = 0, /* Call us last. */
	};


	printk("NMI test: start test\n");

	for (;;) {
		if (signal_pending(current))
			return -ERESTARTSYS;
		
		rv = request_nmi(&nmi_handler);
		if (rv) {
			printk(KERN_WARNING
			       "NMI test: Can't register nmi handler\n");
			return rv;
		}

//		set_current_state(TASK_INTERRUPTIBLE);
//		schedule_timeout(1);

		release_nmi(&nmi_handler);

		atomic_inc(&request_count);
		if ((jiffies - last_jiffies) >= HZ) {
			last_jiffies = jiffies;
			printk("NMIs = %d, requests=%d\n",
			       atomic_read(&nmi_count),
			       atomic_read(&request_count));
		}
	}
	return 0;
}

static int do_open(struct inode *ino, struct file *filep)
{
	return 0;
}

static int do_close(struct inode *ino, struct file *filep)
{
	printk("NMI test: in close\n");
	return 0;
}

static struct file_operations nmi_test_fops = {
	.owner   = THIS_MODULE,
	.read    = do_read,
	.write   = NULL,
	.ioctl   = NULL,
	.open    = do_open,
	.release = do_close,
};

static struct miscdevice nmi_test_miscdev = {
	130,
	"nmi_test",
	&nmi_test_fops
};

static int __init nmi_test_init(void)
{
	int rv;

	rv = misc_register(&nmi_test_miscdev);
	if (rv < 0) {
		printk("NMI test: Unable to register misc device\n");
		return rv;
	}

	printk(KERN_INFO "NMI test by "
	       "Corey Minyard (minyard@mvista.com)\n");

	return 0;
}

static void __exit nmi_test_exit(void)
{
	/* Make sure no one can call us any more. */
	misc_deregister(&nmi_test_miscdev);
}
module_exit(nmi_test_exit);
module_init(nmi_test_init);
MODULE_LICENSE("GPL");

--------------060405060906010902040905--

