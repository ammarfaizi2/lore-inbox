Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263188AbSJTQPC>; Sun, 20 Oct 2002 12:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263193AbSJTQPC>; Sun, 20 Oct 2002 12:15:02 -0400
Received: from [199.203.76.13] ([199.203.76.13]:23446 "EHLO
	optmail.optibase.com") by vger.kernel.org with ESMTP
	id <S263188AbSJTQPB>; Sun, 20 Oct 2002 12:15:01 -0400
Message-ID: <3DB2D7BC.5080809@optibase.com>
From: Constantine Gavrilov <const-g@optibase.com>
To: Dan Maas <dmaas@maasdigital.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problems implementing poll call
Date: Sun, 20 Oct 2002 18:20:12 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot. I get it now.

As far as races are concerned,  it should be OK. This is because my 
condition uses testbit() and interrupt handler uses setbit(). These 
operations are atomic even on SMP configurations. Right?

What do you think is of lower latency -- a poll() hook or an ioctl() hook?

One thing I could have with ioctl implementation was that I knew in 
kernel space that a timeout has occurred. With poll(), I do not know how 
to catch an error, because the poll function is called many times and I 
do not know which return is last. But it is not critical for me.

Dan Maas wrote:

>Hi Constantine, this is in reponse to your post on the Linux kernel
>list of 17 October...
>
>I think you should take a look at the poll() implementation of other
>drivers. You should call poll_wait() before testing the bit flag,
>regardless of whether you actually need to block or not.
>
>Note that poll_wait() does not block; it merely adds your device's
>wait queue to a list of items the user is waiting on. The actual
>blocking occurs in other kernel code after your poll() method
>returns... select() and poll() can make several passes over the file
>descriptors; wait_table may NULL if the kernel knows for sure it is
>not going to block and is just checking the status of your device.
>
>I think you also need to be a little more careful about race
>conditions in your sleeping code. If you write this:
>
>if(need_to_sleep) {
>	interruptible_sleep_on(...);
>}
>
>You create a potential race condition where need_to_sleep is changed
>by an interrupt between the if() check and the sleep_on(). To
>eliminate these races you need to set the task state to
>TASK_INTERRUPTIBLE, then check the 'need_to_sleep' condition, then
>schedule() to actually go to sleep. This way if the interrupt handler
>changes need_to_sleep after your if() statement, you will wake up
>immediately instead of staying asleep forever. For an example of this
>technique see the comments around line 1680 in my driver
>drivers/ieee1394/dv1394.c
>
>Regards,
>Dan
>


-- 
----------------------------------------
Constantine Gavrilov
Linux Leader
Optibase Ltd
7 Shenkar St, Herzliya 46120, Israel
Phone: (972-9)-970-9140
Fax:   (972-9)-958-6099
----------------------------------------



