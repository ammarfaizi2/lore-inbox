Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311587AbSDDUzX>; Thu, 4 Apr 2002 15:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311614AbSDDUzO>; Thu, 4 Apr 2002 15:55:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43274 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311587AbSDDUzA>;
	Thu, 4 Apr 2002 15:55:00 -0500
Message-ID: <3CACBD74.FAED4B72@zip.com.au>
Date: Thu, 04 Apr 2002 12:54:12 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Linus Torvalds <torvalds@transmeta.com>, Dave Hansen <haveblue@us.ibm.com>,
        "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.8-pre1/kernel/exit.c change caused BUG() atboot 
 time
In-Reply-To: <Pine.LNX.4.33.0204041113410.12895-100000@penguin.transmeta.com> <1017948383.22303.537.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> ...
> Do you think it is better to deny preemption if state==TASK_ZOMBIE (note
> this requires code in preempt_schedule and the interrupt return path,
> since Ingo decoupled the two) or just disable preemption around critical
> regions caused by setting state to TASK_ZOMBIE ?
> 
> I suspect this is the first occurrence of a problem of this kind ... and
> the attached patch handles it.
> 

No, the problem goes deeper than this.

I have code which does, effectively:

sleeper()
{
	spin_lock(&some_lock);
	set_current_state(TASK_UNINTERRUPTIBLE);
	some_flag = 0;
	spin_unlock(&lock);
	schedule();
	if (some_flag == 0)
		i_am_horribly_confused();
}

waker()
{
	spin_lock(&some_lock);
	some_flag = 1;
	wake_up_process(sleeper);
	spin_unlock(&some_lock);
}

or something like that.  See __pdflush() and 
pdflush_operation() in http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.8-pre1/delalloc/dallocbase-60-pdflush.patch

The above code work fine, is nice and I want to keep
it that way.  But it fails on preempt.

The spin_unlock() in sleeper() can sometimes set
task->state to TASK_RUNNING(), so my schedule() call
just falls straight through.

Probably nobody has noticed this in other places because
most sleep/wakeup stuff tends to be done inside a loop;
the bogus "wakeup" is ignored.

Although it can be worked around at the call site, I
think this needs fixing.  Otherwise we have the rule
"spin_unlock will flip you into TASK_RUNNING 0.0001%
of the time if CONFIG_PREEMPT=y".  ug.

I have thought deeply about this, and I then promptly
forgot everything I thought about, but I ended up
concluding that the sanest way of resolving this is
inside __set_current_state().  If the new state is
TASK_RUNNING and the old state is not TASK_RUNNING
then enable preemption, call schedule() if necessary, etc.

It is not acceptable to just say "don't preempt a task
which is not in state TASK_RUNNING", because if an
interrupt happens against a CPU which is running a task
which is in state TASK_INTERRUPTIBLE (say), then that
wakeup won't be serviced until the task exits the kernel.

-
