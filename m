Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbVLVSOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbVLVSOS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbVLVSOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:14:18 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:8340 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030253AbVLVSOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:14:17 -0500
Date: Thu, 22 Dec 2005 10:12:49 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
cc: Nicolas Pitre <nico@cam.org>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 00/10] mutex subsystem, -V5
In-Reply-To: <Pine.LNX.4.64.0512220941320.4827@g5.osdl.org>
Message-ID: <Pine.LNX.4.62.0512221003540.7992@schroedinger.engr.sgi.com>
References: <20051222153717.GA6090@elte.hu> <Pine.LNX.4.64.0512221134150.26663@localhost.localdomain>
 <Pine.LNX.4.64.0512220941320.4827@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2005, Linus Torvalds wrote:

> On Thu, 22 Dec 2005, Nicolas Pitre wrote:
> 
> > On Thu, 22 Dec 2005, Ingo Molnar wrote:
> > 
> > > Changes since -V4:
> > > 
> > > - removed __ARCH_WANT_XCHG_BASED_ATOMICS and implemented
> > >   CONFIG_MUTEX_XCHG_ALGORITHM instead, based on comments from
> > >   Christoph Hellwig.
> > > 
> > > - updated ARM to use CONFIG_MUTEX_XCHG_ALGORITHM.
> > 
> > This is still not what I'd like to see, per my previous comments.
> > 
> > Do you have any strong reason for pursuing that route instead of going 
> > with my suggested approach?
> 
> I'd just prefer a 
> 
> 	<asm-generic/mutex-xchg-algo.h>
> 
> and then any architecture can do whatever they damn well want, and 
> anybody who doesn't want to, can just include that header file.
> 
> No #ifdef's, no config options, no "generic fallback". Just 
> unconditionally do the sane thing.
> 
> I'm with whoever HATES those stupid __ARCH_xxx #defines. It's a sign of 
> bad design. Either it's a generic algorithm (and it can be in 
> <asm-generic> or it's not). In no case should we ever have __ARCH_HAS_xxx 
> (and yes, that includes cases where we _currently_ use __ARCH_HAS_xxx).

Isnt there some other way to make all of this much easier to modify? Both 
the arch specific and the generic layers?

There are definitely arch specific improvements but there are also 
possible ways that the generic way of locking can be improved. Some of 
these may require changing the data structures.

F.e. I know a couple of architectures (embedded as well as different 
varieties of NUMA) that have special memory areas for locks that bypass 
the bus protocols in order to realize more efficient locking.

Large NUMA systems with lots of lock contention benefit if the one
trying to lock backs off for awhile. This is first of all a modification 
of the contention path. However, one could also want to locally block 
multiple lock attempts coming from the same node in order to reduce
contention on the NUMA interlink. See also my HBO proposal
http://marc.theaimsgroup.com/?l=linux-kernel&m=111696945030791&w=2

I would like some more flexible way of dealing with locks in general. The
code for the MUTEXes seems to lock us into a specific way of realizing 
locks again.


