Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262484AbULOSoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbULOSoM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 13:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbULOSoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 13:44:12 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:9700 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262470AbULOSnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 13:43:50 -0500
Date: Wed, 15 Dec 2004 10:43:42 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Roland McGrath <roland@redhat.com>
cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH 1/7] cpu-timers: high-resolution CPU clocks for POSIX
 clock_* syscalls
In-Reply-To: <200412142214.iBEMEvEI011636@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0412151010010.11994@schroedinger.engr.sgi.com>
References: <200412142214.iBEMEvEI011636@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2004, Roland McGrath wrote:

> > This yields some additional functionality and is an improvement to the
> > ABI. Why is CLOCK_*_CPUTIME_ID etc not directly supporting using
> > the kernel API? Otherwise the API will take only some of the posix
> > clocks defined in the kernel which may surprise authors of other c
> > libraries.
>
> It's mainly just to simplify the code.  The CPU clocks did not quite fit
> into the k_clock function-table model, though I think that was really the
> case more before some k_clock interface cleanups happened.  Now I think it
> might be possible to write k_clock hook functions that call into the
> posix_cpu_* functions for those small-integer constant clockid_t cases,
> though off hand what I would be more confident of would be to handle them
> in the existing special case calls.  i.e., if they are supported at all it
> might best be by having every call translate CLOCK_*_CPUTIME_ID to
> MAKE_*_CPUCLOCK(SCHED, 0) before the < 0 check.  I really don't see the
> need to support those values in the kernel interface, which never did
> before (though having them in linux/time.h).  But I would not object to it.
> I just strongly doubt anyone would ever use it.

I just reviewed the glibc patches and the kernel side and I would think
that your glibc code would be simplified by passing all CLOCK_* values
straight through and then calling your cputimer functions as needed in
the kernel as before. As also said before this would also make the
interface more intuitive and keep the existing semantics for clock_id's >
0. It would separate the most common use from the special functionality
intended for access to clocks of other processes/threads/(whatever you
want to call them).

The glibc side already is a mess and I would think that doing so
also would keep things cleaner on that side.

Also

Why are the hooks in sys_gettime and not in do_gettime? Is there any
reason that the existing user space transfer code in do_gettime not be
used? I would like to have all user space interfacing centralized in
posix-timers.c. clock specific code should not deal with user space
pointers. Do not merge do_clock_gettime and sys_clock_gettime.

posix-cpu-timers.c needs to have all user space interaction removed. If
you would like to make improvements to the code transferring to / from
user space them make them for the general case in posix-timers.c.

Ideally the integration of the cpu timers into posix-timers.c would
follow the general way that clock specific code is called as closely as
possible.
