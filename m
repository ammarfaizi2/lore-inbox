Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267821AbTBROfB>; Tue, 18 Feb 2003 09:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267833AbTBROfB>; Tue, 18 Feb 2003 09:35:01 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:744 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S267821AbTBROe6>; Tue, 18 Feb 2003 09:34:58 -0500
Message-ID: <3E5246C3.4090008@nortelnetworks.com>
Date: Tue, 18 Feb 2003 09:44:19 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: fcntl and flock wakeups not FIFO?
References: <20030218010054.J28902@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
  >>I've been doing some experimenting with locking on 2.4.18 and have
  >>noticed that if I have a number of writers waiting on a lock, they are
  >>not woken up in the order in which they requested the lock.
  >>
  >>Is this expected? If so, what was the reasoning for this and are there
  >>any patches to give FIFO wakeups?
  >
  > That certainly isn't what's supposed to happen.  They should get woken
  > up in-order.  The code in 2.4.18 seems to be doing that.  Are you
  > doing anything clever with scheduling?


I have a potential cause here, but I'm not sure if it makes sense.  The
following code (slightly reformatted) is taken from locks.c in the
Mandrake 2.4.19-16mdk kernel.


static void locks_wake_up_blocks(struct file_lock *blocker,
unsigned int wait)
{
     while (!list_empty(&blocker->fl_block)) {
       struct file_lock *waiter = list_entry(blocker->fl_block.next,
                                            struct file_lock, fl_block);
       if (wait) {
         locks_notify_blocked(waiter);

         /* Let the blocked process remove waiter from the
          * block list when it gets scheduled.
          */
         current->policy |= SCHED_YIELD;
         schedule();
       } else {
         /* Remove waiter from the block list, because by the
          * time it wakes up blocker won't exist any more.
          */
         locks_delete_block(waiter);
         locks_notify_blocked(waiter);
       }
     }
}


It appears that if this function is called with a wait value of zero,
all of the waiting processes will be woken up before the scheduler gets
called.  This means that the scheduler ends up picking which process
runs rather than the locking code.

Looking through the file, there is no call chain on an unlock or on
closing the last locked fd which can give a nonzero wait value, meaning
that we will always end up with the scheduler making the decision in
these cases.

Am I missing something?

Chris




