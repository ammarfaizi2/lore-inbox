Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268484AbTBWPMR>; Sun, 23 Feb 2003 10:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268488AbTBWPMD>; Sun, 23 Feb 2003 10:12:03 -0500
Received: from [195.223.140.107] ([195.223.140.107]:18566 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S268484AbTBWPLe>;
	Sun, 23 Feb 2003 10:11:34 -0500
Date: Sun, 23 Feb 2003 16:22:36 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@digeo.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>, t.baetzler@bringe.com,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: xdr nfs highmem deadlock fix [Re: filesystem access slowing system to a crawl]
Message-ID: <20030223152236.GC29467@dualathlon.random>
References: <200302191742.02275.m.c.p@wolk-project.de> <20030219174940.GJ14633@x30.suse.de> <200302201629.51374.m.c.p@wolk-project.de> <20030220103543.7c2d250c.akpm@digeo.com> <20030220215457.GV31480@x30.school.suse.de> <shs1y22zhm9.fsf@charged.uio.no> <20030220230430.GX9800@gtf.org> <15957.24787.735814.496471@charged.uio.no> <20030221094133.GH31480@x30.school.suse.de> <1045874441.25412.0.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045874441.25412.0.camel@rth.ninka.net>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 04:40:41PM -0800, David S. Miller wrote:
> On Fri, 2003-02-21 at 01:41, Andrea Arcangeli wrote:
> > On Fri, Feb 21, 2003 at 12:12:19AM +0100, Trond Myklebust wrote:
> > > >>>>> " " == Jeff Garzik <jgarzik@pobox.com> writes:
> > > 
> > >      > One should also consider kmap_atomic...  (bcrl suggest)
> > > 
> > > The problem is that sendmsg() can sleep. kmap_atomic() isn't really
> > > appropriate here.
> > 
> > 100% correct.
> 
> It actually depends upon whether you have sk->priority set
> to GFP_ATOMIC or GFP_KERNEL.

You must not disable preemption when entering sock_sendmsg no matter
sk->priority. disabling preemption inside sock_sendmsg is way too late
so even if you have such preemption bug in sock_sendmsg, it won't help.
you would need to disable preemption in the caller before doing the
kmap_atomic if something. And again that is a preemption bug.

Not to tell you'd need to allocate a big pool of atomic kmaps to do
that, and this would eat hundred megs of virtual address space since
it's replicated per-cpu. This is has even less sense, those machines
where the highmem deadlock triggers eats normal zone big time.

Really, the claim that it can be solved with atomic kmaps doesn't make
any sense to me, nor the fact the sock_sendmsg will not schedule if
called with GFP_ATOMIC. Of course it must not schedule if it can be
called from an irq with priority=GFP_ATOMIC, but this isn't the case
we're discussing here, an irq implicitly just disabled preemption by
design and calling sock_sendmsg from irq isn't really desiderable (even
if technically possible maybe with priority=GFP_ATOMIC according to you)
because it will take some time.

Andrea
