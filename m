Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266009AbUJEVaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUJEVaS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 17:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266048AbUJEVaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 17:30:18 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:65255 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266009AbUJEVaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 17:30:08 -0400
Date: Tue, 5 Oct 2004 14:28:18 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Roland McGrath <roland@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>, jbarnes@sgi.com
Subject: Re: [PATCH] CPU time clock support in clock_* syscalls
In-Reply-To: <200410052122.i95LMntn007340@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0410051423140.29450@schroedinger.engr.sgi.com>
References: <200410052122.i95LMntn007340@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2004, Roland McGrath wrote:

> > Is there a standard for that? Or is it an opaque type that you have
> > defined this way?
>
> Of course there is no standard for the bits used in a clockid_t.  This is
> an implementation detail in POSIX terms.  POSIX defines function interfaces
> to return clockid_t values (clock_getcpuclockid, pthread_getcpuclockid).
> I have chosen the kernel-user ABI for Linux clockid_t's here, but that is
> only of concern to the kernel and glibc.

Maybe its best then to restrict this definition to glibc? Glibc can muck
around with these bits and then call either

clock_gettime(clocktype,&timespec)

or

clock_process_gettimer(pid, type/clocktype,&timespec)

That way the glibc guys have full control and the kernel does not have
to deal with the bit mongering.

> > Posix only defines a process and a thread clock. This is much more.
>
> Like I said the first time, it's three kinds of clocks.  One is what we
> will in future use to define POSIX's CPUTIME clocks in our POSIX
> implementation, and the other two are what we already use to define
> ITIMER_REAL/ITIMER_VIRTUAL in our existing POSIX implementation.

How will you provide the necessary hardware interface for the kernel
clocks?

> > I wonder how glibc will realize access to special timer hardware. Will
> > glibc be able load device drivers for timer chips?
>
> glibc has zero interest in doing any of that.  It will use the single new
> "best information" kernel interface when that is available, and it's the
> kernel's concern what the best information available from the hardware is.

Ok then we might best follow my above suggestion. Put the timer stuff
into a separate .c file as you have already done. Rename it to something
like process_clocks.c. posix-timers.c will then only be an interface to a
variety of hardware clocks that glibc may use at will.
