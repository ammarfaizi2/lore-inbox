Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVDDXUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVDDXUD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 19:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVDDXTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 19:19:12 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:19847 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261477AbVDDXRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 19:17:10 -0400
Subject: Re: scheduler/SCHED_FIFO behaviour
From: Steven Rostedt <rostedt@goodmis.org>
To: Arun Srinivas <getarunsri@hotmail.com>
Cc: juhl-lkml@dif.dk, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <BAY10-F37D1DA55DA1E869AA5A34DD93B0@phx.gbl>
References: <BAY10-F37D1DA55DA1E869AA5A34DD93B0@phx.gbl>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 04 Apr 2005 19:17:04 -0400
Message-Id: <1112656624.5147.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-05 at 04:36 +0530, Arun Srinivas wrote:
> I am scheduling 2 SCHED_FIFO processes and set them affinity( process A runs 
> on processor 1 and process B runs on processor 2), on a HT processor.(I did 
> this cause I wanted to run them together).Now, in schedule() I measure the 
> timedifference between when they are scheduled. I found that when I 
> introduce these 2 processes as SCHED_FIFO they are
> 
> 1)scheduled only once and run till completion ( they running time is around 
> 2 mins.)

If they are the highest priority task, and running as FIFO this is the
proper behavior.

> 2)entire system appears frozen....no mouse/key presses detected until the 
> processes exit.
> 

If X is not at a higher priority than the test you are running, it will
never get a chance to run.

> >From what I observed does it mean that even the OS / interrupt handler does 
> not occur during the entire period of time these real time processes run?? 
> (as I said the processes run in minutes).

The interrupts do get processed. Now the bottom halves and tasklets may
be starved if they are set at a lower priority than your test (ie. the
ksoftirqd thread). But most likely they are processed too.

> How can I verify that?
> 

#!/bin/sh
cat /proc/interrupts
run_test
cat /proc/interrupts

If the run_test takes 2 minutes, you should see a large difference in
the two outputs.

-- Steve

> Thanks
> Arun


