Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965071AbVHZP7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbVHZP7e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 11:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbVHZP7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 11:59:34 -0400
Received: from santo.ucolick.org ([128.114.23.204]:12477 "EHLO
	smtp.ucolick.org") by vger.kernel.org with ESMTP id S965071AbVHZP7e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 11:59:34 -0400
Message-ID: <430F3C6B.7070303@ucolick.org>
Date: Fri, 26 Aug 2005 08:59:39 -0700
From: Richard Stover <richard@ucolick.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: waiting process in procfs read
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I submitted this as a bugzilla kernel bug report but was directed here.
Perhaps someone can help me.

I have a device driver developed with 2.4 kernels. I've ported
it to the 2.6 kernel (FC3) and it all works fine except for one
aspect of procfs.

My device driver sets up an entry in the /proc tree. A process
can open this entry and read from it. Normally the read blocks
until an event happens elsewhere in the device driver. When the
event happens the blocked process is woken up and the read
returns the information it was waiting for.

THE PROBLEM: In FC3 (2.6.11-13_FC3) the reading process blocks but it never
wakes up.

Here is a code fragment from the driver where the reading
process would block:

/*      Wait until the next image header has been read.         */
/*      But only wait if we are reading from the beginning.     */
       if (offset == 0) {

           printk("####%s waiting event %x\n",__FUNCTION__,
               (unsigned int)&dev->read_proc_wait);

           wait_event_interruptible(dev->read_proc_wait,(offset != 0));
           printk("####%s WOKE UP\n",__FUNCTION__);

/*          See if our sleep was interrupted by a signal.       */

           if (signal_pending(current)) {
               *buffer_location = my_buffer;
               printk("####%s returns error due to pending signal\n",__FUNCTION__);
               return -EINTR;
           }
       }


Here is a code fragment that is trying to wake up the blocked process:

/*      Wake up anyone waiting on reading /proc/readXw                  */
       printk(KERN_INFO "#### waking up anyone waiting on read_proc_wait event %x\n",
               (unsigned int)&dev->read_proc_wait);

       wake_up_interruptible(&dev->read_proc_wait);

I see the blocked process "waiting event..." message and I see the "waking up..."
message. But I never get the "WOKE UP" message and the waiting process never
returns.
If I kill the waiting process I do see "WOKE UP" and "returns error due to
pending signal"
messages so I know it has in fact been waiting. The address of dev->read_proc_wait
is the same in both the "waiting event..." and "waking up..." messages.
I've initialize dev->read_proc_wait just like several other event flags in the
same device driver: init_waitqueue_head(&(dev->read_proc_wait));

I can not see any reason why the waiting process wouldn't wake up. This code is
very similar to code used elsewhere in the driver where a process waits in an
ioctl call for a particular event to happen. That wait within an ioctl works fine.
The procfs read wait worked in Linux kernels up through RH9, 2.4.20-6 (with
appropriate code modifications for the earlier kernel).

If anybody has any suggestions I would appreciate the help. 


Thanks.

Richard Stover


----------------------------------------------------------------------
Richard Stover                       email: richard@ucolick.org
Detector Development Laboratory      http://www.ccd.ucolick.org
UCO/Lick Observatory                 Voice: 831-459-2139
Natural Sciences Bldg. 2, Room 160
University of California             FAX:   831-459-2298
Santa Cruz, CA 95064  USA            FAX:   831-426-5244 (Alternate)
----------------------------------------------------------------------


