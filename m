Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262120AbVAOE6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbVAOE6f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 23:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVAOE6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 23:58:34 -0500
Received: from mail.joq.us ([67.65.12.105]:25472 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262120AbVAOE6Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 23:58:25 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       paul@linuxaudiosystems.com, arjanv@redhat.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <200501071620.j07GKrIa018718@localhost.localdomain>
	<1105132348.20278.88.camel@krustophenia.net>
	<20050107134941.11cecbfc.akpm@osdl.org>
	<20050107221059.GA17392@infradead.org>
	<20050107142920.K2357@build.pdx.osdl.net>
	<87mzvkxxck.fsf@sulphur.joq.us> <20050111212139.GA22817@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: Fri, 14 Jan 2005 22:56:54 -0600
In-Reply-To: <20050111212139.GA22817@elte.hu> (Ingo Molnar's message of
 "Tue, 11 Jan 2005 22:21:39 +0100")
Message-ID: <87ekgnwaqx.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar <mingo@elte.hu> writes:

> what kind of non-audio workload was there during this test? 43 xruns
> arent nice but arent that bad either.

Audio playback through JACK didn't work well at all with nice --20,
even at relatively high latencies (23 msec cycle).  It was bad enough
that I would not want to use it for anything.  

The 1/2 second max delay was probably more of an issue than the number
of xruns.  Something really bad happened there.

> this will turn off starvation checking, for testing purposes. (to see
> whether there's anything else but anti-starvation causing xruns.)

I build a 2.6.10 kernel with just these two changes...

--- kernel/sched.c~	Fri Dec 24 15:35:24 2004
+++ kernel/sched.c	Wed Jan 12 23:48:49 2005
@@ -95,7 +95,7 @@
 #define MAX_BONUS		(MAX_USER_PRIO * PRIO_BONUS_RATIO / 100)
 #define INTERACTIVE_DELTA	  2
 #define MAX_SLEEP_AVG		(DEF_TIMESLICE * MAX_BONUS)
-#define STARVATION_LIMIT	(MAX_SLEEP_AVG)
+#define STARVATION_LIMIT	0
 #define NS_MAX_SLEEP_AVG	(JIFFIES_TO_NS(MAX_SLEEP_AVG))
 #define CREDIT_LIMIT		100
 
--- kernel/workqueue.c~	Fri Dec 24 15:35:40 2004
+++ kernel/workqueue.c	Fri Jan 14 19:34:10 2005
@@ -188,7 +188,7 @@
 
 	current->flags |= PF_NOFREEZE;
 
-	set_user_nice(current, -10);
+	set_user_nice(current, -5);
 
 	/* Block and flush all signals */
 	sigfillset(&blocked);

Since realtime-lsm was not available, I ran the test as root.  Overall
system performance was not good.  Trying to do mail with xemacs and
gnus (as I had done before) hung for long periods of time.

The test did not work correctly.  A number of segfaults occurred.  The
jackd server hung and had to be killed manually.

So, these results aren't worth much, but here's what it reported
(compared with earlier results)...


                                 With -R       Without -R      Without -R
                               (SCHED_FIFO)    (nice --20) (STARVATION_LIMIT=0)

************* SUMMARY RESULT ****************
Total seconds ran . . . . . . :   300
Number of clients . . . . . . :    20
Ports per client  . . . . . . :     4
Frames per buffer . . . . . . :    64
*********************************************
Timeout Count . . . . . . . . :(    1)          (    1)       (    2)	      
XRUN Count  . . . . . . . . . :     2               43            46	      
Delay Count (>spare time) . . :     0                0             0	      
Delay Count (>1000 usecs) . . :     0                0             0	      
Delay Maximum . . . . . . . . :  3130 usecs   501374 usecs       0 usecs 
Cycle Maximum . . . . . . . . :   960 usecs     1036 usecs       0 usecs 
Average DSP Load. . . . . . . :    34.3 %         34.3 %        19.5 %     

The "{Delay|Cycle} Maximum" values were apparently not reported
because jackd hung.  I suspect the DSP load went down because many of
the clients crashed.

I ran it again with -R on this kernel, just to check.  The DSP load
was back to 33.2%.  It performed as before, except the "{Delay|Cycle}
Maximum" values were also reported as zero.  Not sure why, don't have
time to debug it right now.  Running with -R did not impact other
interactive processes as badly as nice --20 on this kernel.

If you want, I can dig into this some more and try to figure out what
went wrong.  Did I make the exact changes you wanted?

If it's not interesting, I probably won't bother.
--
 joq
