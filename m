Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267928AbUHETO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267928AbUHETO3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 15:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267891AbUHESbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 14:31:41 -0400
Received: from fmr05.intel.com ([134.134.136.6]:10437 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S267868AbUHESRd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:17:33 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
Date: Thu, 5 Aug 2004 11:16:57 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A011F93C2@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
Thread-Index: AcR6uuIFGVjAjBYgSMOrvZbCie115wAWyVuw
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Ulrich Drepper" <drepper@redhat.com>, "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <robustmutexes@lists.osdl.org>,
       "Rusty Russell" <rusty@rustcorp.com.au>, "Ingo Molnar" <mingo@elte.hu>,
       "Jamie Lokier" <jamie@shareable.org>
X-OriginalArrivalTime: 05 Aug 2004 18:16:58.0524 (UTC) FILETIME=[657B7DC0:01C47B18]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ulrich Drepper [mailto:drepper@redhat.com]
>
> Andrew Morton wrote:
> 
> > This fixes what appear to be some fairly significant shortcomings.  What do
> > the futex and NPTL people have to say about the gravity of the problems
> > which this solves, and the offered implementation?
> 
> This code will not be suppoerted by the glibc code.  Using these
> primitives would mean significant slowdown of all operations and this
> for problems which only a few people have.  I asked to get the useful
> parts of the code to be made available using the current futex interface
> (robust mutexes are useful) but Inaky and rest rest never acted on this
> and instead invented this completely incompatible interface.  IMO this
> code should not go into the mainstream kernel.  Let those who want to do
> realtime work bear the costs.

But I told you many times why it is not possible and you keep ignoring
those reasons.

Read the paper, read the slides. In a nutshell [again]: the idea of 
robustness requires that there is a concept of ownership and that the 
kernel knows about it. Futexes are just waitqueues, and as they are
used all around the code in glibc and other apps, the ownership concept
doesn't work with them.

[same thing applies to the advanced real-time features, priority 
inheritance and protection, as they require kernel knowledge about
ownership].

With the current futex interface it cannot be done--I tried and it 
resulted in a mess [lookup for rtfutex patches I sent last year].

On top of that, many people has voiced that the sys_futex() multiplexing
should have been unfolded long time ago.

The fusyn patch provides exactly the same capabilities than futexes
using the fuqueues [except for the requeue bits and the FUTEX_FD, that
should be quick to implement], albeit using different system calls.
It should not be hard to redirect sys_futex() to the sys_ufuqueue_*()
calls.

As people has pointed out already, there is a fast path--the slowdown
that we see is caused by the in-kernel overhead, and we are looking
into that, because even 10% is not acceptable.

[for the record, my belief is that it is caused because we need to
use IRQ locks--and a total of some more spinlocks to do the lock/
unlock operations in the kernel--this is what we are profiling now].

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
