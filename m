Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbTJAGcK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 02:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbTJAGcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 02:32:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:17550 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261988AbTJAGcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 02:32:07 -0400
Date: Tue, 30 Sep 2003 23:32:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: jun.nakajima@intel.com, davej@redhat.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, richard.brunner@amd.com
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata
 patch
Message-Id: <20030930233258.37ed9f7f.akpm@osdl.org>
In-Reply-To: <20031001061348.GE1131@mail.shareable.org>
References: <7F740D512C7C1046AB53446D3720017304AFCF@scsmsx402.sc.intel.com>
	<20031001053833.GB1131@mail.shareable.org>
	<20030930224853.15073447.akpm@osdl.org>
	<20031001061348.GE1131@mail.shareable.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> wrote:
>
> Andrew Morton wrote:
> > > Doesn't refusing to boot seem to heavy handed for this bug?  The buggy
> > > CPUs have been around for many years (it is practically the entire AMD
> > > line for the last 4 years or so), and nobody in userspace has
> > > complained about the 2.4 behaviour so far.  (Linux 2.4 behaviour is,
> > > of course, to ignore the errata).
> > 
> > That is the case at present.  But the 2.6 kernel was hitting this
> > erracularity daily.
> 
> We're talking about what to offer userspace now...  I think we all
> agree that the kernel itself shouldn't be allowed to hit it, one way
> or another.

Oh yes, if it hits in-kernel you get a dead box.




Looking at Andi's patch, it is also a dead box if the fault happens inside
down_write(mmap_sem).  That should be fixed, methinks.

And I think we're also a bit deadlocky if it happens inside down_read(),
because double down_read() is illegal because an intervening down_write()
from another thread can block the second down_read().  Or maybe not: the
rwsem semantics may have changed since I last looked.

And if the fault happens inside spinlock on a !CONFIG_PREEMPT kernel we end
up doing down_read() with spinlocks held, I think?

> > If some smart cookie decides to add prefetches to some STL implementation
> > or something, they are likely to start hitting it with the same frequency.
> 
> Especially now that GCC has intrinsics for prefetches, and GCC's
> optimiser can generate prefetches automatically (-fprefetch-loop-arrays).

Yup.  Although prefetch-loop-arrays doesn't sound like something which will
deref a dud pointer?

> ...
> I understand you're advocating a policy that says we can't do anything
> about old systems, but from 2.6 onwards apps can depend on not being
> hit by that erratum in userspace, is that right?

I expect this will be backported to 2.4 asap.

