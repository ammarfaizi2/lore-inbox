Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267833AbTBROwE>; Tue, 18 Feb 2003 09:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267834AbTBROwE>; Tue, 18 Feb 2003 09:52:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57860 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267833AbTBROwB>;
	Tue, 18 Feb 2003 09:52:01 -0500
Date: Tue, 18 Feb 2003 15:02:01 +0000
From: Matthew Wilcox <willy@debian.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: fcntl and flock wakeups not FIFO?
Message-ID: <20030218150201.A22992@parcelfarce.linux.theplanet.co.uk>
References: <20030218010054.J28902@parcelfarce.linux.theplanet.co.uk> <3E5246C3.4090008@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E5246C3.4090008@nortelnetworks.com>; from cfriesen@nortelnetworks.com on Tue, Feb 18, 2003 at 09:44:19AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 09:44:19AM -0500, Chris Friesen wrote:
>   > That certainly isn't what's supposed to happen.  They should get woken
>   > up in-order.  The code in 2.4.18 seems to be doing that.  Are you
>   > doing anything clever with scheduling?

> static void locks_wake_up_blocks(struct file_lock *blocker,
> unsigned int wait)
> {
>      while (!list_empty(&blocker->fl_block)) {
>        struct file_lock *waiter = list_entry(blocker->fl_block.next,
>                                             struct file_lock, fl_block);
>        if (wait) {
>          locks_notify_blocked(waiter);
> 
>          /* Let the blocked process remove waiter from the
>           * block list when it gets scheduled.
>           */
>          current->policy |= SCHED_YIELD;
>          schedule();
>        } else {
>          /* Remove waiter from the block list, because by the
>           * time it wakes up blocker won't exist any more.
>           */
>          locks_delete_block(waiter);
>          locks_notify_blocked(waiter);
>        }
>      }
> }
> 
> It appears that if this function is called with a wait value of zero,
> all of the waiting processes will be woken up before the scheduler gets
> called.  This means that the scheduler ends up picking which process
> runs rather than the locking code.

Right.  That's why I asked whether you were doing something clever with
scheduling ;-)

> Looking through the file, there is no call chain on an unlock or on
> closing the last locked fd which can give a nonzero wait value, meaning
> that we will always end up with the scheduler making the decision in
> these cases.

I'm impressed that you chased it through ;-)  This logic is mostly gone
from 2.5 because I found it too hard to keep in my mind while working
on this file.

> Am I missing something?

Nope, it's true.  But the tasks get marked as runnable in the right order,
so the scheduler should be doing the right thing -- if any tasks really
have a better reason to run first (whether it's through RT scheduling
or through standard Unix priority scheduling) then they'll get the lock
first.  Otherwise, I'd've thought it should be first-runnable, first-run.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
