Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751769AbVLGTCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbVLGTCk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 14:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbVLGTCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 14:02:40 -0500
Received: from mail.gmx.de ([213.165.64.20]:4249 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751770AbVLGTCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 14:02:39 -0500
X-Authenticated: #26515711
Subject: POSIX-timers: is this a bug?
From: Oliver Korpilla <Oliver.Korpilla@gmx.de>
Reply-To: Oliver.Korpilla@gmx.de
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 20:02:40 +0100
Message-Id: <1133982160.8611.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I`m not on list, so please CC me.

When setting a new timer with timer_create() one can supply a sigevent_t
structure, within one can supply a thread ID (by setting
->sigev_notify_thread_id and SIGEV_THREAD_ID | SIGEV_SIGNAL). You can
use this to get the thread signalled when the timer expires with the
given signal.

Even though the thread ID is asked for, in reality the PID is required -
as you can see in the code below. Because the associated task is located
by PID, not by PID. This collides with the API description for
timer_create(): 
"timer_create creates an interval timer based on the POSIX 1003.1b
standard using the clock type specified by which_clock. The timer ID is
stored in the timer_t value pointed to by created_timer_id.
The timer is started by timer_settime (3). If timer_event_spec is
non-NULL, it specifies the behavior on timer expiration.  If the
sigev_notify member of timer_event_spec is SIGEV_SIGNAL then the signal
specified by sigev_signo is sent to the process on expiration.
If the value is SIGEV_THREAD_ID then the sigev_notify_thread_id member
of timer_event_spec should contain the pthread_t id of the thread that
is to receive the signal."

As you can see below, the value is used as PID instead of as TID.
Printing out PID and TID of my thread has shown that both values clearly
differ.

Is this a bug?

With kind regards,
Oliver Korpilla

kernel/posix-timers.c (2.6.13.4):

static inline struct task_struct * good_sigevent(sigevent_t * event)
{
	struct task_struct *rtn = current->group_leader;

	if ((event->sigev_notify & SIGEV_THREAD_ID ) &&
	(!(rtn = find_task_by_pid(event->sigev_notify_thread_id)) ||
	rtn->tgid != current->tgid ||
	 (event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_SIGNAL))
		return NULL;

	if (((event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE) &&
	    ((event->sigev_signo <= 0) || 
		(event->sigev_signo > SIGRTMAX)))
		return NULL;

	return rtn;
}


