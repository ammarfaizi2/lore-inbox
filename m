Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265019AbSJPOpB>; Wed, 16 Oct 2002 10:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265022AbSJPOpA>; Wed, 16 Oct 2002 10:45:00 -0400
Received: from [199.203.76.13] ([199.203.76.13]:5078 "EHLO
	linux.optibase.co.il") by vger.kernel.org with ESMTP
	id <S265019AbSJPOoS>; Wed, 16 Oct 2002 10:44:18 -0400
Message-ID: <3DAD7CA1.7070807@optibase.com>
Date: Wed, 16 Oct 2002 16:50:09 +0200
From: Constantine Gavrilov <const-g@optibase.com>
Organization: Optibase
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Problem implementing poll method
Content-Type: multipart/mixed;
 boundary="------------060703010806070800070000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060703010806070800070000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


-- 
----------------------------------------
Constantine Gavrilov
Linux Leader
Optibase Ltd
7 Shenkar St, Herzliya 46120, Israel
Phone: (972-9)-970-9140
Fax:   (972-9)-958-6099
----------------------------------------


--------------060703010806070800070000
Content-Type: text/plain;
 name="let.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="let.txt"

Hi,

I have a problem implementing poll method.

I have written a driver for MPEG encoder card. The user-space SDK needs to be able to wait for a certain event that is reported by the interrupt handler. I have done it using ioctl method, like this:

	u32 timeout=milliseconds * HZ / 1000;

	set_bit(0, &dev->fintwait);
	if(test_bit(0, &dev->fintwait)) {
		interruptible_sleep_on_timeout(&dev->interrupt_queue,timeout);

		if (signal_pending(current)) {
			printk(KERN_ERR "optenc: IntWait restarted by signal\n");
			return -ERESTARTSYS;
		}

		if(test_bit(0, &dev->fintwait)) {
			printk(KERN_ERR "optenc: intwait timeout\n");
			..//returns wait timeout
		}
		else {
			...//returns wait OK
		}
	}
	//returns wait OK
	
The interrupt handler wakes up the queue and updates dev->fintwait like this:

	clear_bit(0, &dev->fintwait);
	wake_up_interruptible(&dev->interrupt_queue);
	

It worked very well for me. I wanted to implement the same wait using the poll method. So, my poll function looks like this:

unsigned int optenc_poll(struct file *filp, poll_table *wait_table)
{
	unsigned int mask = 0;
	struct mydev *dev = filp->private_data;
	
	set_bit(0, &dev->fintwait);
	if(test_bit(0, &dev->fintwait)) {
		poll_wait(filp, &dev->interrupt_queue, wait_table);
		if(test_bit(0, &dev->fintwait))
			return mask;
		else {
			mask |= POLLIN |POLLRDNORM;
			return mask;
		}
	}
	else {
		mask |= POLLIN |POLLRDNORM;
		return mask;
	}
}

Seems straightforward and the same thing as above. But, I have the following problems:

a) I have a lot of calls with wait_table = NULL and poll_wait does not block. I always do select on one file descriptor only and I never use zero timeout, so I do not understand the reason for it.

b) Even when wait_table is not NULL, poll_wait returns before (!!) interrupt handler wakes up the queue. I have checked it with printk. It always like this:

	set_bit
	poll_wait
	poll_wait returns and test_bit is true
	wake_up and clear_bit

It is like poll_wait does not seem to block and I have spurious calles with wait_table == NULL. Any ideas?


Just to verify, the user-space wait function looks like this :

BOOL Wait(int timeout)
{

	fd_set set;
	struct timeval tv;
	int retval;

	FD_ZERO(&set);
	FD_SET(fd, &set);
	tv.tv_sec = timeout/1000;
	tv.tv_usec = (timeout%1000)*1000;

	int rc=select(fd+1, &set, NULL, NULL, &tv);
	if(rc == -1) {
		PERROR("select");
		return FALSE;
	}
	if(rc == 1)
		return TRUE;
	else
		return FALSE;
}

I use 2.4.18-pre7ac1 and I have also checked stock RedHat's 2.4.9-34.

--------------060703010806070800070000--

