Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVB1Uos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVB1Uos (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 15:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVB1Uos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 15:44:48 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:44965 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261732AbVB1Uob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 15:44:31 -0500
Subject: Re: Scheduler question in __wake_up_common() - Real Time Apps
From: Steven Rostedt <rostedt@goodmis.org>
To: "Chad N. Tindel" <chad@tindel.net>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050228183036.GA22914@calma.pair.com>
References: <20050228183036.GA22914@calma.pair.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 28 Feb 2005 15:44:24 -0500
Message-Id: <1109623464.1452.98.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-28 at 13:30 -0500, Chad N. Tindel wrote:
> I have a question about the implementation in __wake_up_common() that I'm
> hoping someone might know the background on.  This function wakes up
> a specified number of tasks for a wait_queue.  I'm wondering why it doesn't
> wake up the tasks in priority order, so that for things following wake-one 
> semantics high priority tasks get woken up before lower priority tasks.
> 
> The only thing I can think of off the top of my head is that it simplifies the 
> O(1) implementation, but I'm wondering if maybe there is something else.
> 

I believe that it is just simpler the way it is. Otherwise you would
have to sort it each time you add a task to the wait queue, which will
probably just slow everything down with little gain. The higher priority
task will be scheduled before the others that are woken. So I don't see
a problem.  As the processes are woken up, the process waking up the
others is protected by spinlocks and interrupts being off. So you don't
have to worry about preemption and one taking over before a higher
priority process gets scheduled.  Maybe on on SMP, this might cause a
few extra schedules, but I still don't believe that you gain anything
with a sorted wake up.

As for the exclusive wait. That is merely implementing a FIFO. But extra
work must be done to make sure that you wake up others.  I can see your
point that a FIFO ignores priorities, but these are seldom used, except
that it is also used in the implementation of down.  But if you are
worried about that, then just use Ingo Molnar's RT patch where the down
implementation not only handles priorities, but also priority inversion.

-- Steve


> Thanks,
> 
> Chad
> -

