Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbULNSgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbULNSgX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 13:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbULNSgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 13:36:23 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:22452 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261583AbULNSgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 13:36:13 -0500
Date: Tue, 14 Dec 2004 10:36:01 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Roland McGrath <roland@redhat.com>
cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH 1/7] cpu-timers: high-resolution CPU clocks for POSIX
 clock_* syscalls
In-Reply-To: <200412140355.iBE3t7KL008040@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0412140939010.1546@schroedinger.engr.sgi.com>
References: <200412140355.iBE3t7KL008040@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2004, Roland McGrath wrote:

> This patch provides support for thread and process CPU time clocks in
> the POSIX clock interface.  Both the existing utime and utime+stime
> information (already available via getrusage et al) can be used, as well
> as a new (potentially) more precise and accurate clock (which cannot
> distinguish user from system time).  The clock used is that provided by
> the `sched_clock' function already used internally by the scheduler.
> This gives a way for platforms to provide the highest-resolution CPU
> time tracking that is available cheaply, and some already do so (such as
> x86 using TSC).  Because this clock is already sampled internally by the
> scheduler, this new tracking adds only the tiniest new overhead to
> accomplish the bookkeeping.

Sounds good.

> This replaces the support contributed by Christoph Lameter, with the same
> goals.  It improves on that support in these ways:
>
> 1. The ABI encoding of clockid_t for CPU time clocks is changed.
>    The current code encodes PID_MAX_LIMIT as part of the ABI; this is a
>    poor ABI, since that has heretofore been an internal implementation
>    limit never exposed directly to userland as an ABI constraint.
>    The new ABI is expressed in the macros defined in <linux/posix-timers.h>.
>    Note that the small-integer constants are not supported by the kernel ABI.
>    Userland never wants to pass these anyway, they will always be
>    translated by compatibility code in glibc.  The caller's own thread
>    or process clock is expressed by using the encoding with a PID of zero.

This yields some additional functionality and is an improvement to the
ABI. Why is CLOCK_*_CPUTIME_ID etc not directly supporting using
the kernel API? Otherwise the API will take only some of the posix
clocks defined in the kernel which may surprise authors of other c
libraries.

> This allows per-thread clocks to be accessed only by other threads in
> the same process.  The only POSIX calls that access these are defined
> only for in-process use, and having this check is necessary for the
> userland implementations of the POSIX clock functions to robustly refuse
> stale clockid_t's in the face of potential PID reuse.

Posix does not prescribe any access limitations for those clocks and as
far as I understand the standard, access to all process clocks needs to
be possible. Access to to process time information is already in
some sense available via the standard ps command and its not restrictyed
at all.

> When this code is merged, it will be supported in glibc.
> I have written the support and added some test programs for glibc,
> which are what I mainly used to test the new kernel code.
> You can get those here:
> 	http://people.redhat.com/roland/glibc/kernel-cpuclocks.patch

It seems that this code does now support extra clocks like
CLOCK_REALTIME_HR, CLOCK_MONOTONIC_HR and CLOCK_SGI_CYCLE right?

Also glibc continues to provide a implementation for CLOCK_*_CPUTIME_ID
for other platforms and for older kernel releases that returns real time
instead of cpu time. You are continuing to make people write code that is
not portable. No willingness to make a clean break and confess your sins
against the posix standard?

The patches look fine to me. Still have to find time to test them
though.
