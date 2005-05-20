Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVETQNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVETQNZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 12:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVETQNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 12:13:25 -0400
Received: from agf.customers.acn.gr ([213.5.17.156]:27784 "EHLO
	enigma.wired-net.gr") by vger.kernel.org with ESMTP id S261479AbVETQND
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 12:13:03 -0400
Message-ID: <001801c55d56$ccb5bc00$0101010a@dioxide>
From: "linux" <kernel@wired-net.gr>
To: "lkml" <linux-kernel@vger.kernel.org>
Subject: 2.6 workqueue's
Date: Fri, 20 May 2005 19:13:03 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
i am trying to use workqueues in a module, but sth strange happens.The
source code for the module skeleton is below:

#include <linux/module.h>
#include <linux/init.h>
#include <linux/param.h>
#include <linux/kernel.h>
#include <linux/string.h>
#include <linux/errno.h>
#include <linux/sched.h>
#include <linux/interrupt.h>
#include <linux/delay.h>
#include <linux/workqueue.h>


static DECLARE_WAIT_QUEUE_HEAD(mwait);

static int ppid=0;
static int pid=0;
static void start_nasworkq(void);
static void test_workq(void *data);


static struct workqueue_struct *wk;
static struct work_struct work;

static void start_nasworkq(void)
{
        wk=create_singlethread_workqueue("wk/0");
        INIT_WORK(&work,test_workq,(void *)NULL);
      queue_work(wk,&work); /* Standalone workqueue */
        schedule_work(&work); /* Shared workqueue */
}


static int __init init_thread(void)
{
        start_nasworkq();
        return 0;
}



static void test_workq(void *data)
{       int i=0;
        for(;;)
        {
                printk(KERN_INFO "test-workqueue: %d %s
%d\n",current->pid,current->comm,i++);
                ppid=current->pid;
                wait_event_interruptible_timeout(mwait,pid,5*HZ);
                if(pid) break;
        }
}

static void  __exit exit_threads(void)
{
        pid=1;
        wake_up(&mwait);
        destroy_workqueue(wk);

}

MODULE_LICENSE("GPL");

module_init(init_thread);
module_exit(exit_threads);




I compile and run this code into two different kernels (2.6.4 & 2.6.11.10)
but i dont have the same results ,
the first kernel freezes when inserts into the for(;;) loop but the first
printk shows the workqueue's name (current->comm) and after the
schedule_work() call the events/0 kernel thread, showing that the shared
queue works just fine,but it hangs the kernel.
The second kernel compilation( they have the same configuration ) doesnt
freeze at all and doesnt show the shared queue at all , that means that the
first call ( queue_work() ) queued the workqueue and the second just
scheduled what???

Why the first kernel freezes and the second not, why the first kernel shows
two different running contexts and the second not.???


Best regards,
Chris.

