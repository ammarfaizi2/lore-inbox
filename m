Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932692AbWCIBB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932692AbWCIBB5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 20:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932690AbWCIBB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 20:01:57 -0500
Received: from ozlabs.org ([203.10.76.45]:42403 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751233AbWCIBB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 20:01:56 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17423.32377.460820.710578@cargo.ozlabs.ibm.com>
Date: Thu, 9 Mar 2006 12:01:45 +1100
From: Paul Mackerras <paulus@samba.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: David Howells <dhowells@redhat.com>, Matthew Wilcox <matthew@wil.cx>,
       Alan Cox <alan@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Paul@ozlabs.org, E.McKenney@ozlabs.org,
       " <paulmck@us.ibm.com>"@ozlabs.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
In-Reply-To: <20060309020851.D9651@jurassic.park.msu.ru>
References: <20060308154157.GI7301@parisc-linux.org>
	<31492.1141753245@warthog.cambridge.redhat.com>
	<29826.1141828678@warthog.cambridge.redhat.com>
	<20060308145506.GA5095@devserv.devel.redhat.com>
	<10095.1141838381@warthog.cambridge.redhat.com>
	<17423.22121.254026.487964@cargo.ozlabs.ibm.com>
	<20060309020851.D9651@jurassic.park.msu.ru>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky writes:

> On Thu, Mar 09, 2006 at 09:10:49AM +1100, Paul Mackerras wrote:
> > David Howells writes:
> > 
> > > > # define smp_read_barrier_depends()     do { } while(0)
> > > 
> > > What's this one meant to do?
> > 
> > On most CPUs, if you load one value and use the value you get to
> > compute the address for a second load, there is an implicit read
> > barrier between the two loads because of the dependency.  That's not
> > true on alpha, apparently, because of the way their caches are
> > structured.
> 
> Who said?! ;-)

Paul McKenney, after much discussion with Alpha chip designers IIRC.

> > The smp_read_barrier_depends is a read barrier that you
> > use between two loads when there is already a dependency between the
> > loads, and it is a no-op on everything except alpha (IIRC).
> 
> My "Compiler Writer's Guide for the Alpha 21264" says that if the
> result of the first load contributes to the address calculation
> of the second load, then the second load cannot issue until the data
> from the first load is available.

Sure, but because of the partitioned caches on some systems, the
second load can get older data than the first load, even though it
issues later.

If you do:

	CPU 0			CPU 1

	foo = val;
	wmb();
	p = &foo;
				reg = p;
				bar = *reg;

it is apparently possible for CPU 1 to see the new value of p
(i.e. &foo) but an old value of foo (i.e. not val).  This can happen
if p and foo are in different halves of the cache on CPU 1, and there
are a lot of updates coming in for the half containing foo but the
half containing p is quiet.

I added Paul McKenney to the cc list so he can correct anything I have
wrong here.

Paul.
