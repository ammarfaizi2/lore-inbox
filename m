Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVAGQVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVAGQVk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 11:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVAGQVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 11:21:40 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:56023 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S261493AbVAGQU7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 11:20:59 -0500
Message-Id: <200501071620.j07GKrIa018718@localhost.localdomain>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Christoph Hellwig <hch@infradead.org>, Lee Revell <rlrevell@joe-job.com>,
       Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Jack O'Quin" <joq@io.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM 
In-reply-to: Your message of "Fri, 07 Jan 2005 17:03:51 +0100."
             <20050107160350.GB29327@devserv.devel.redhat.com> 
Date: Fri, 07 Jan 2005 11:20:53 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [151.197.185.179] at Fri, 7 Jan 2005 10:20:54 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Fri, Jan 07, 2005 at 10:41:40AM -0500, Paul Davis wrote:
>> 
>> fine, so the mlock situation may have improved enough post-2.6.9 that
>> it can be considered fixed. that leaves the scheduler issue. but
>> apparently, a uid/gid solution is OK for mlock, and not for the
>> scheduler. am i missing something?
>
>I think you skipped a step. You don't have a scheduler requirement, you have
>a latency requirement. You currently *solve* that latency requirement via a
>scheduler "hack", yet is quite clear that the "hard" realtime solution is
>most likely not the right approach. Note that I'm not saying that you

Why is that clear? In just about every respect, realtime audio has the
same characteristics as hard realtime, except that nobody gets hurt
when a deadline is missed :) We have an IRQ source, and a deadline
(sometimes on the sub-msec range, but more typically 1-5msec) for the
work that has to be done. This deadline is tight enough that the task
essentially *has* to run with SCHED_FIFO scheduling, because doing
almost anything else instead will cause the deadline to be missed. 

>shouldn't get the latency that that currently provides, but the downsides
>(can hang the machine) are bad; a solution that solves that would be far
>preferable

OS X's deadline scheduler is arguably better, though I don't believe
it can actually offer the guarantees it claims to with 100%
reliability. But they are essentially do hard realtime via deadline
scheduling, combined with a task killer for any RT task that exceeds
its stated cycle consumption.

To do that in Linux would be great, but its really an addition to the
current scheduling mechanisms, not a replacement. The OS X realtime
task (its actually a Mach RT thread, to be more precise) can still
theoretically cause DOS *if* the kernel task killer was not present,
so its just the task killer that would be needed, presumably driven by
the timer interrupt.

>something like a soft realtime flag that acts as if it's the hard realtime
>one unless the app shows "misbehavior" (eg eats its timeslice for X times in
>a row) might for example be such a solution. And with the anti abuse
>protection it can run with far lighter privilegs.

i guess we're suggesting almost the same thing, except that i consider
this to be hard realtime plus a task killer, not "soft realtime
pretending to be hard realtime" :)

--p

