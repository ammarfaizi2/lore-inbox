Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262998AbVALB7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262998AbVALB7d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 20:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263000AbVALB7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 20:59:33 -0500
Received: from mail.inter-page.com ([207.42.84.180]:22541 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S262998AbVALB7U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 20:59:20 -0500
From: "Robert White" <rwhite@casabyte.com>
To: "'selvakumar nagendran'" <kernelselva@yahoo.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: pipe_wait illustration needed
Date: Tue, 11 Jan 2005 17:59:13 -0800
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAA7xtIU7X1ME2CYTYfWWlaDQEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <20050111104919.64122.qmail@web60603.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy,

In order to understand the calling of schedule() you have to think in terms of time
and strangers.  In particular time passing irregularly and other programs/events
coming along and changing your state.  There are lots of good books that will do a
better version of explaining all this stuff that I, but I will give you the short
version.  If I make any mistakes, I am sure someone else will correct me... 8-)

First understand that you call schedule() and it runs other processes and such, but
_eventually_ that call will return unless something becomes catastrophically broken.

Do a "ps ae" on your linux command prompt and you will see a bunch of processes like
this example:

  PID TTY      STAT   TIME COMMAND
  259 tty1     S      0:00 /sbin/agetty 38400 tty1 linux
  260 tty2     S      0:00 /sbin/agetty 38400 tty2 linux
  261 tty3     S      0:00 /sbin/agetty 38400 tty3 linux
  262 tty4     S      0:00 /sbin/agetty 38400 tty4 linux
  263 tty5     S      0:00 /sbin/agetty 38400 tty5 linux
  264 tty6     S      0:00 /sbin/agetty 38400 tty6 linux
  543 pts/3    S      0:00 bash
  571 pts/2    S      0:00 bash
  576 pts/1    S      0:00 bash 
 8583 pts/3    R      0:00 ps ae

Each of the processes with the STAT (state) of "S" is sleeping, or, (essentially)
they called schedule() and that call has not returned yet.  [That isn't a perfect
truth, but it is close enough.]

The magic is actually in the line "current->state = TASK_INTERRUPTABLE".  If that
line weren't there, the schedule() call would look through the list of tasks for ones
that are still runable (that is "state == TASK_RUNNING") and then run the one that
had the highest priority (etc.)

So all sleeping tasks everywhere do three things, they volunteer to stop by making
their state something other than TASK_RUNNING, set up some means for the outside
world to switch their state *BACK* to TASK_RUNNING, and then they call schedule().

In the pipe_wait() example below, the "some means" part is the add_wait_queue().
When data arrives on the pipe (or whatever) which "inode" points at, some other
routine will find the PIPE_WAIT(*inode) thing, which is the anchor/head of a list of
waiting processes.  The add_wait_queue() call put the data object created by
DECLARE_WAITQUEUE() called "wait" which has a reference to "current" buried in it on
that list.  The wakeup() [or wakeup_interruptable() or whatever] call that this other
block of code calls just walks along the list and sets all the tasks objects,
including ours, to TASK_RUNNING.

The schedule() call doesn't return at that instant, but it does return as soon as
some task somewhere calls schedule() and our task is the highest priority task
available.

So semi-graphically:

US: Become TASK_INTERRUPTABLE
US: Get on "list"
US: call schedule()
Everything Else: goes about its business
Something: walks along "list" and makes all TASK_RUNABLE
Something or Something Else: call schedule()
US: schedule() returns
US: Get _off_ of "list"

To see the places where you could get woken up, go to your linux source directory and
run:

egrep --recursive -i 'wake.*PIPE_WAIT' .

These are the places that *might* bring you back to life.

Hope this helps,

Rob White,
Casabyte, Inc.



-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org]
On Behalf Of selvakumar nagendran
Sent: Tuesday, January 11, 2005 2:49 AM
To: linux-kernel@vger.kernel.org
Subject: pipe_wait illustration needed

Hello linux-experts,
    I can't understand this function pipe_wait defined
in linux/fs/pipe.c line by line,especially the lines
after add_wait_queue. If the process is added to the
wait queue and schedule() is called then after that a
new process will be selected and will be given the
CPU. So, the current process will be out of the way.
Then, how can the kernel reach the line 
remove_wait_queue. 
    Also, how the scheduler will know that the pipe
event has occurred and it's safe to set the process
state to TASK_RUNNING?

Thanks,
selva
----------------
/* Drop the inode semaphore and wait for a pipe event,
atomically */
void pipe_wait(struct inode * inode)
{
	DECLARE_WAITQUEUE(wait, current);
	current->state = TASK_INTERRUPTIBLE;
	add_wait_queue(PIPE_WAIT(*inode), &wait);
	up(PIPE_SEM(*inode));
	schedule();
	remove_wait_queue(PIPE_WAIT(*inode), &wait);
	current->state = TASK_RUNNING;
	down(PIPE_SEM(*inode));
}


		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

