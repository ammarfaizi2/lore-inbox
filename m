Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbUKICBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbUKICBw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 21:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbUKIB74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 20:59:56 -0500
Received: from hqemgate00.nvidia.com ([216.228.112.144]:6156 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S261229AbUKIB4v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 20:56:51 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: SCHED_RR and kernel threads
Date: Mon, 8 Nov 2004 17:56:46 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B002A7F144@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SCHED_RR and kernel threads
thread-index: AcTF+MRL1bDguPKSQqaWQvuoMrTwgAABRguw
From: "Stephen Warren" <SWarren@nvidia.com>
To: "Con Kolivas" <kernel@kolivas.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Nov 2004 01:56:50.0563 (UTC) FILETIME=[60DCC530:01C4C5FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Con Kolivas [mailto:kernel@kolivas.org] 
> Stephen Warren writes:
>> I guess we could have most threads stay at SCHED_NORMAL, and just
make
>> the few critical threads SCHED_RR, but I'm getting a lot of push-back
on
>> this, since it makes our thread API a lot more complex.
>
>Your workaround is not suitable for the kernel at large.

You mean the official kernel.org kernel? I wasn't implying that the
patch should be part of that!

In our system we have literally EVERY single thread (kernel, user-space
daemons, and user-space applications) all setup as SCHED_RR with
identical priority at present, except a couple higher priority threads.
We did this initially for user-space by replacing /sbin/init with a
wrapper that set the scheduler policy and default priority, and verified
that this was inherited by all daemons & application threads. Then, we
found that the kernel threads could get starved in some situations,
hence the kernel change.

Our threading model dictates that every thread have a priority (so that
the thread model is portable between Linux, embedded RTOSs etc.), and in
Linux AFAIK, the only way to implement priorities is to use a real-time
scheduling policy. Some threads do a lot of calculation. We want to make
them equal (or probably, lower) priority to the kernel threads, so
therefore the kernel threads must then be SCHED_RR.

Can you elaborate on specific conditions that would cause the kernel
threads to suck up unusual amounts of CPU time?

In our application, keyboard processing is a real-time requirement, so
if that is performed in a kernel thread, that kernel thread should be
real-time. We basically want the control to insert e.g. the keyboard
processing kernel thread into the middle of our priority hierarchy,
rather than having it forced as the lowest possible priority.

I get the impression you're implying that scheduling doesn't work
correctly in this situation - that if kernel threads are set to
SCHED_RR, they can still lock out user-space threads of the same or
higher priority? Is this what you're saying, or do you mean that the
kernel threads can lock out user-space threads of *lower* priority,
which is to be expected. In all the RTOS's I've seen, all threads are
SCHED_RR, thus mimicking the situation we've creating by patching our
kernel...

-- 
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html
