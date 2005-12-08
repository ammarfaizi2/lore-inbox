Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965056AbVLHAKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbVLHAKz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 19:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbVLHAKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 19:10:55 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:57075 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S965056AbVLHAKy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 19:10:54 -0500
Message-ID: <439779F1.6000400@mvista.com>
Date: Wed, 07 Dec 2005 16:10:25 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oliver.Korpilla@gmx.de
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       libc-alpha@sources.redhat.com
Subject: Re: POSIX-timers: is this a bug?
References: <1133982160.8611.12.camel@localhost.localdomain>
In-Reply-To: <1133982160.8611.12.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Korpilla wrote:
> I`m not on list, so please CC me.
> 
> When setting a new timer with timer_create() one can supply a sigevent_t
> structure, within one can supply a thread ID (by setting
> ->sigev_notify_thread_id and SIGEV_THREAD_ID | SIGEV_SIGNAL). You can
> use this to get the thread signalled when the timer expires with the
> given signal.
> 
> Even though the thread ID is asked for, in reality the PID is required -
> as you can see in the code below. Because the associated task is located
> by PID, not by PID. This collides with the API description for
> timer_create(): 

The SIGEV_THREAD_ID option is an extension to the standard and, was 
not intended to be meaningful to user code.  The kernel, does use the 
PID value here.  The main usage intended for this option is for glibc 
to localize the handling of the SIGEV_THREAD option (which is to 
create a thread).  If glibc wants to do this thread creation work in a 
particular "helper" thread, it can change the SIGEV_THREAD to a 
SIGEV_THREAD_ID supplying the required PID, while, at the same time 
keeping track of the needed stuff to do the thread creation.  Thus the 
"helper" thread will get wakened when the timer expires and will 
create the thread.

Another possible way for this to work is for glibc to create the 
thread as part of the timer_create and put it into a sigwait() for the 
timers signal.  In this case, glibc would also want to specify the 
target thread using the SIGEV_THREAD_ID option.

> "timer_create creates an interval timer based on the POSIX 1003.1b
> standard using the clock type specified by which_clock. The timer ID is
> stored in the timer_t value pointed to by created_timer_id.
> The timer is started by timer_settime (3). If timer_event_spec is
> non-NULL, it specifies the behavior on timer expiration.  If the
> sigev_notify member of timer_event_spec is SIGEV_SIGNAL then the signal
> specified by sigev_signo is sent to the process on expiration.
> If the value is SIGEV_THREAD_ID then the sigev_notify_thread_id member
> of timer_event_spec should contain the pthread_t id of the thread that
> is to receive the signal."

So, it remains possible for glibc to make this conversion, or, 
possibly we have a man page error...

In any case, we should expect glibc to want a pthread_t here, which, 
of course, is meaningless to the kernel so it should either fail or be 
converted by glibc.
> 
> As you can see below, the value is used as PID instead of as TID.
> Printing out PID and TID of my thread has shown that both values clearly
> differ.
> 
> Is this a bug?
> 
> With kind regards,
> Oliver Korpilla
> 
> kernel/posix-timers.c (2.6.13.4):
> 
> static inline struct task_struct * good_sigevent(sigevent_t * event)
> {
> 	struct task_struct *rtn = current->group_leader;
> 
> 	if ((event->sigev_notify & SIGEV_THREAD_ID ) &&
> 	(!(rtn = find_task_by_pid(event->sigev_notify_thread_id)) ||
> 	rtn->tgid != current->tgid ||
> 	 (event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_SIGNAL))
> 		return NULL;
> 
> 	if (((event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE) &&
> 	    ((event->sigev_signo <= 0) || 
> 		(event->sigev_signo > SIGRTMAX)))
> 		return NULL;
> 
> 	return rtn;
> }
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
