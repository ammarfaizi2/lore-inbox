Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbQKFWdz>; Mon, 6 Nov 2000 17:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129331AbQKFWdg>; Mon, 6 Nov 2000 17:33:36 -0500
Received: from smtprch2.nortelnetworks.com ([192.135.215.15]:45744 "EHLO
	smtprch2.nortel.com") by vger.kernel.org with ESMTP
	id <S129066AbQKFWdd>; Mon, 6 Nov 2000 17:33:33 -0500
Message-ID: <3A07319B.7E2BD403@asiapacificm01.nt.com>
Date: Mon, 06 Nov 2000 22:32:59 +0000
From: "Andrew Morton" <morton@nortelnetworks.com>
Organization: Nortel Networks, Wollongong Australia
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.0-test4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: [patch] NE2000
In-Reply-To: <3A039E77.5DD87DF0@uow.edu.au> from "Andrew Morton" at Nov 4,
            0 08:45:01 am <200011061846.VAA20608@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <morton@asiapacificm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> 
> Hello!
> 
> > No, that code is correct, provided (current->state == TASK_RUNNING)
> > on entry.  If it isn't, there's a race window which can cause
> > lost wakeups.   As a check you could add:
> >
> >       if ((current->state & (TASK_INTERRUPTIBLE|TASK_UNINTERRUPTIBLE)) == 0)
> >               BUG();
> 
> Though it really cannot happen and really happens, as we have seen... 8)
> 
> In any case, Andrew, where is the race, when we enter in sleeping state?
> Wakeup is not lost, it is just not required when we are not going
> to schedule and force task to running state.

	set_current_state(TASK_INTERRUPTIBLE);
	add_wait_queue(...);
	/* window here */
	set_current_state(TASK_INTERRUPTIBLE);
	schedule();

If there's a wakeup by another CPU (or this CPU in an interrupt) in
that window, current->state will get switched to TASK_RUNNING.

Then it's immediately overwritten and we go to sleep.  Lost wakeup.

> I still do not see how it is possible that task runs in sleeping state.
> Apparently, set_current_state is forgotten somewhere. Do you see, where? 8)

Nope.  Is Jorge running SMP?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
