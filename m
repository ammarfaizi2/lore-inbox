Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131248AbRCUJVC>; Wed, 21 Mar 2001 04:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131254AbRCUJUm>; Wed, 21 Mar 2001 04:20:42 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:27660 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131248AbRCUJUk>;
	Wed, 21 Mar 2001 04:20:40 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: nigel@nrg.org
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel 
In-Reply-To: <Pine.LNX.4.05.10103201920410.26853-100000@cosmic.nrg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 21 Mar 2001 20:19:54 +1100
Message-ID: <22991.985166394@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Gamble wrote:
> A task that has been preempted is on the run queue and can be
> rescheduled on a different CPU, so I can't see how a per-CPU counter
> would work.  It seems to me that you would need a per run queue
> counter, like the example I gave in a previous posting.

Ouch.  What about all the per cpu structures in the kernel, how do you
handle them if a preempted task can be rescheduled on another cpu?

 int count[NR_CPUS], *p;
 p = count+smp_processor_id(); /* start on cpu 0, &count[0] */
 if (*p >= 1024) {
   /* preempt here, reschedule on cpu 1 */
   *p = 1;  /* update cpu 0 count from cpu 1, oops */
  }

Unless you find every use of a per cpu structure and wrap a spin lock
around it, migrating a task from one cpu to another is going to be a
source of wierd and wonderful errors.  Since the main use of per cpu
structures is to avoid locks, adding a spin lock to every structure
will be a killer.  Or have I missed something?

