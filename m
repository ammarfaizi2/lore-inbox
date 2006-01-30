Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWA3WBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWA3WBw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 17:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWA3WBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 17:01:52 -0500
Received: from science.horizon.com ([192.35.100.1]:37941 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932329AbWA3WBv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 17:01:51 -0500
Date: 30 Jan 2006 17:01:44 -0500
Message-ID: <20060130220144.14467.qmail@science.horizon.com>
From: linux@horizon.com
To: davids@webmaster.com
Subject: RE: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	It can tell the difference between the other thread getting
> the mutex first and it getting the mutex first. But it cannot tell the
> difference between an implementation that puts random sleeps before calls
> to 'pthread_mutex_lock' and an implementation that has the allegedly
> non-compliant behavior. That makes the behavior compliant under the
> 'as-if' rule.
> 
> 	If you don't believe me, try to write a program that prints
> 'non-compliant' on a system that has the alleged non-compliance but is
> guaranteed not to do so on any compliant system. It cannot be done.
> 
> 	In order to claim the alleged compliance, you would have to
> know that a thread waiting for a mutex did not get it. But there is no
> possible way you can know that another thread is waiting for the mutex
> (as opposed to being about to wait for it). So you can never detect the
> claimed non-compliance, so it's not non-compliance.

An excellent point, but the existence of pthread_mutex_trylock()
invalidates it.

To be very specific, the following will do the job:

volatile unsigned shared_variable;
pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;

void
thread_function()
{
	unsigned prev_value = shared_variable;

	for (;;) {
		unsigned cur_value, delta;
		if (pthread_mutex_trylock(&lock) == 0) {
			cur_value = ++shared_variable;
			pthread_mutex_unlock(&lock);
			delta = cur_value - prev_value;
		} else {
			/* Another thread is holding the lock. */
			pthread_mutex_lock(&lock);
			cur_value = ++shared_variable;
			pthread_mutex_unlock(&lock);
			delta = cur_value - prev_value;
			if (delta == 1)
				fatal("non-compliant");
		}
		/* Assuming we don't wrap */
		if (delta == 0)
			fatal("buggy as a roach motel");
	}
}

You need to run more than one instance of the thread_function()
to have a chance of triggering the non-compliant message, of course.
