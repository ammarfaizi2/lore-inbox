Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbTJAG5m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 02:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbTJAG5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 02:57:42 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:40838 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262028AbTJAG5l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 02:57:41 -0400
Date: Wed, 1 Oct 2003 07:57:05 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andrew Morton <akpm@osdl.org>
Cc: jun.nakajima@intel.com, davej@redhat.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, richard.brunner@amd.com
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Message-ID: <20031001065705.GI1131@mail.shareable.org>
References: <7F740D512C7C1046AB53446D3720017304AFCF@scsmsx402.sc.intel.com> <20031001053833.GB1131@mail.shareable.org> <20030930224853.15073447.akpm@osdl.org> <20031001061348.GE1131@mail.shareable.org> <20030930233258.37ed9f7f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930233258.37ed9f7f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Looking at Andi's patch, it is also a dead box if the fault happens inside
> down_write(mmap_sem).  That should be fixed, methinks.
> 
> And I think we're also a bit deadlocky if it happens inside down_read(),
> because double down_read() is illegal because an intervening down_write()
> from another thread can block the second down_read().  Or maybe not: the
> rwsem semantics may have changed since I last looked.
> 
> And if the fault happens inside spinlock on a !CONFIG_PREEMPT kernel we end
> up doing down_read() with spinlocks held, I think?

Ouch, ouch and ouch.  You're right, it is a serious problem with the
patch.  It is easy enough to fix by making the fault handler not take
mmap_sem if the fault's in the kernel address range.  (With apologies
to the folk running kernel mode userspace...)

> Yup.  Although prefetch-loop-arrays doesn't sound like something which will
> deref a dud pointer?

It might deref off the end of a mapped region.

> > I understand you're advocating a policy that says we can't do anything
> > about old systems, but from 2.6 onwards apps can depend on not being
> > hit by that erratum in userspace, is that right?
> 
> I expect this will be backported to 2.4 asap.

I agree, but there's going to be an installed base of _current_ 2.4
kernels, on these AMD CPUs, for some years to come.  App and library
writers will have to know about the erratum if they want to use the
prefetch instruction, for a while yet.

Btw, does anyone know if the "prefetchw" instruction is affected by
the erratum?  I see that in current 2.6, only the "prefetchnta"
instruction is disabled so presumably "prefetchw" is ok?

-- Jamie
