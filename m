Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVARFCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVARFCr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 00:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVARFCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 00:02:47 -0500
Received: from mail.joq.us ([67.65.12.105]:28570 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261232AbVARFCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 00:02:07 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@osdl.org>, Matt Mackall <mpm@selenic.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <20050111125008.K10567@build.pdx.osdl.net>
	<20050111205809.GB21308@elte.hu>
	<20050111131400.L10567@build.pdx.osdl.net>
	<20050111212719.GA23477@elte.hu> <87fz15j325.fsf@sulphur.joq.us>
	<20050115134922.GA10114@elte.hu> <874qhiwb1q.fsf@sulphur.joq.us>
	<871xcmuuu4.fsf@sulphur.joq.us> <20050116231307.GC24610@elte.hu>
	<87vf9xdj18.fsf@sulphur.joq.us> <20050117100633.GA3311@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: Mon, 17 Jan 2005 23:02:41 -0600
In-Reply-To: <20050117100633.GA3311@elte.hu> (Ingo Molnar's message of "Mon,
 17 Jan 2005 11:06:33 +0100")
Message-ID: <87llaruy6m.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Ingo Molnar <mingo@elte.hu> writes:

> * Jack O'Quin <joq@io.com> wrote:
>
>> Is it possible to call sched_setscheduler() with a thread ID instead
>> of a pid?  That's what I really need.  JACK sets and resets the thread
>> priorities from a different thread.
>
> yes. The PID arguments in these APIs are all treated as 'TIDs'. One day
> the APIs themselves might switch over to what POSIX specifies, and there
> will be new, thread-specific APIs - but at the moment they are all
> thread-granular.

In the absence of any documentation, I'm guessing about storing the
nice value in the priority field of the sched_param struct.  But, I
have not been able to figure out how to make that work.

While intializing the "realtime" thread, I modified JACK to do this
instead of setting SCHED_FIFO and the desired RT priority...

	policy = SCHED_OTHER;
	param.sched_priority = -20;

Is that even a reasonable guess?  It doesn't work.  

All the relevant pthread_xxx() services seem to return EINVAL given
these values.  When I change to use sched_setscheduler() instead of
pthread_setschedparam(), I get ESRCH.  Is the thread_t returned from
pthread_create() different from the thread ID used by the kernel?  If
so, how do I obtain the right value?

Is this stuff documented somewhere?  How is anyone expected to use it?

I'm attaching the relevant JACK thread.c source file, so you all can
appreciate how much "fun" it is trying to do realtime programming
under Linux.  BTW, the #ifdef JACK_USE_MACH_THREADS parts are the Mac
OS X version.  Much cleaner, isn't it?


--=-=-=
Content-Type: text/x-csrc
Content-Disposition: attachment; filename=thread.c
Content-Description: JACK threading interfaces

/*
  Copyright (C) 2004 Paul Davis
  
  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU Lesser General Public License as published by
  the Free Software Foundation; either version 2.1 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

  Thread creation function including workarounds for real-time scheduling
  behaviour on different glibc versions.

  $Id: thread.c,v 1.6 2004/09/15 14:59:06 joq Exp $

*/

#include <config.h>

#include <jack/thread.h>
#include <jack/internal.h>

#include <pthread.h>
#include <sched.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>

#ifdef JACK_USE_MACH_THREADS
#include <sysdeps/pThreadUtilities.h>
#endif

static inline void
log_result (char *msg, int res)
{
	char outbuf[500];
	snprintf(outbuf, sizeof(outbuf),
		 "jack_create_thread: error %d %s: %s",
		 res, msg, strerror(res));
	jack_error(outbuf);
}

int
jack_create_thread (pthread_t* thread,
		    int priority,
		    int realtime,
		    void*(*start_routine)(void*),
		    void* arg)
{
#ifndef JACK_USE_MACH_THREADS
	pthread_attr_t attr;
	int policy;
	struct sched_param param;
	int actual_policy;
	struct sched_param actual_param;
#endif /* !JACK_USE_MACH_THREADS */

	int result = 0;

	if (!realtime) {
		result = pthread_create (thread, 0, start_routine, arg);
		if (result) {
			log_result("creating thread with default parameters",
				   result);
		}
		return result;
	}

	/* realtime thread. this disgusting mess is a reflection of
	 * the 2nd-class nature of RT programming under POSIX in
	 * general and Linux in particular.
	 */

#ifndef JACK_USE_MACH_THREADS

	pthread_attr_init(&attr);
	policy = SCHED_FIFO;
	param.sched_priority = priority;
	result = pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
	if (result) {
		log_result("requesting explicit scheduling", result);
		return result;
	}
	result = pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
	if (result) {
		log_result("requesting joinable thread creation", result);
		return result;
	}
	result = pthread_attr_setscope(&attr, PTHREAD_SCOPE_SYSTEM);
	if (result) {
		log_result("requesting system scheduling scope", result);
		return result;
	}
	result = pthread_attr_setschedpolicy(&attr, policy);
	if (result) {
		log_result("requesting non-standard scheduling policy", result);
		return result;
	}
	result = pthread_attr_setschedparam(&attr, &param);
	if (result) {
		log_result("requesting thread priority", result);
		return result;
	}
	
	/* with respect to getting scheduling class+priority set up
	   correctly, there are three possibilities here: 

	   a) the call sets them and returns zero
	      ===================================

	      this is great, obviously.

	   b) the call fails to set them and returns an error code
	      ====================================================

  	      this could happen for a number of reasons,
	      but the important one is that we do not have the
	      priviledges required to create a realtime
	      thread. this could be correct, or it could be
	      bogus: there is at least one version of glibc
	      that checks only for UID in
	      pthread_attr_setschedpolicy(), and does not
	      check capabilities.
	      
	   c) the call fails to set them and does not return an error code
              ============================================================

	      this last case is caused by a stupid workaround in NPTL 0.60
	      where scheduling parameters are simply ignored, with no indication
	      of an error.
	*/

	result = pthread_create (thread, &attr, start_routine, arg);

	if (result) {

		/* this workaround temporarily switches the
		   current thread to the proper scheduler
		   and priority, using a call that
		   correctly checks for capabilities, then
		   starts the realtime thread so that it
		   can inherit them and finally switches
		   the current thread back to what it was
		   before.
		*/
		
		int current_policy;
		struct sched_param current_param;
		pthread_attr_t inherit_attr;
		
		current_policy = sched_getscheduler (0);
		sched_getparam (0, &current_param);
		
		result = sched_setscheduler (0, policy, &param);
		if (result) {
			log_result("switching current thread to rt for "
				   "inheritance", result);
			return result;
		}
		
		pthread_attr_init (&inherit_attr);
		result = pthread_attr_setscope (&inherit_attr,
						PTHREAD_SCOPE_SYSTEM);
		if (result) {
			log_result("requesting system scheduling scope "
				   "for inheritance", result);
			return result;
		}
		result = pthread_attr_setinheritsched (&inherit_attr,
						       PTHREAD_INHERIT_SCHED);
		if (result) {
			log_result("requesting inheritance of scheduling "
				   "parameters", result);
			return result;
		}
		result = pthread_create (thread, &inherit_attr, start_routine,
					 arg);
		if (result) {
			log_result("creating real-time thread by inheritance",
				   result);
		}
		
		sched_setscheduler (0, current_policy, &current_param);
		
		if (result)
			return result;
	}
	
	/* Still here? Good. Let's see if this worked... */

	result = pthread_getschedparam (*thread, &actual_policy, &actual_param);
	if (result) {
		log_result ("verifying scheduler parameters", result);
		return result;
	}

	if (actual_policy == policy &&
	    actual_param.sched_priority == param.sched_priority) {
		return 0;		/* everything worked OK */
	}

	/* we failed to set the sched class and priority,
	 * even though no error was returned by
	 * pthread_create(). fix this by setting them
	 * explicitly, which as far as is known will
	 * work even when using thread attributes does not.
	 */

	result = pthread_setschedparam (*thread, policy, &param);
	if (result) {
		log_result("setting scheduler parameters after thread "
			   "creation", result);
		return result;
	}

#else /* JACK_USE_MACH_THREADS */

	result = pthread_create (thread, 0, start_routine, arg);
	if (result) {
		log_result ("creating realtime thread", result);
		return result;
	}

	/* time constraint thread */
	setThreadToPriority (*thread, 96, TRUE, 10000000);
	
#endif /* JACK_USE_MACH_THREADS */

	return 0;
}

#if JACK_USE_MACH_THREADS 

int
jack_drop_real_time_scheduling (pthread_t thread)
{
	setThreadToPriority(thread, 31, FALSE, 10000000);
	return 0;       
}

int
jack_acquire_real_time_scheduling (pthread_t thread, int priority)
	//priority is unused
{
	setThreadToPriority(thread, 96, TRUE, 10000000);
	return 0;
}

#else /* !JACK_USE_MACH_THREADS */

int
jack_drop_real_time_scheduling (pthread_t thread)
{
	struct sched_param rtparam;
	int x;
	
	memset (&rtparam, 0, sizeof (rtparam));
	rtparam.sched_priority = 0;
	
	if ((x = pthread_setschedparam (thread, SCHED_OTHER, &rtparam)) != 0) {
		jack_error ("cannot switch to normal scheduling priority(%s)\n",
			    strerror (errno));
		return -1;
	}
        return 0;
}

int
jack_acquire_real_time_scheduling (pthread_t thread, int priority)
{
	struct sched_param rtparam;
	int x;
	
	memset (&rtparam, 0, sizeof (rtparam));
	rtparam.sched_priority = priority;
	
	if ((x = pthread_setschedparam (thread, SCHED_FIFO, &rtparam)) != 0) {
		jack_error ("cannot use real-time scheduling (FIFO/%d) "
			    "(%d: %s)", rtparam.sched_priority, x,
			    strerror (x));
		return -1;
	}
        return 0;
}

#endif /* JACK_USE_MACH_THREADS */

--=-=-=


Maybe someone can give me a clue what to do...
-- 
  joq

--=-=-=--
