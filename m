Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265658AbUAGVKv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 16:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265659AbUAGVKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 16:10:51 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:56297 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265658AbUAGVKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 16:10:49 -0500
Date: Wed, 7 Jan 2004 22:10:45 +0100
From: Jens Axboe <axboe@suse.de>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-rc1-tiny2
Message-ID: <20040107211045.GJ16720@suse.de>
References: <20040106054859.GA18208@waste.org> <20040107140640.GC16720@suse.de> <20040107185039.GC18208@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107185039.GC18208@waste.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07 2004, Matt Mackall wrote:
> On Wed, Jan 07, 2004 at 03:06:40PM +0100, Jens Axboe wrote:
> > On Mon, Jan 05 2004, Matt Mackall wrote:
> > > This is the fourth release of the -tiny kernel tree. The aim of this
> > > tree is to collect patches that reduce kernel disk and memory
> > > footprint as well as tools for working on small systems. Target users
> > > are things like embedded systems, small or legacy desktop folks, and
> > > handhelds.
> > > 
> > > Latest release includes:
> > >  - various compile fixes for last release
> > >  - actually include Andi Kleen's bloat-o-meter this time
> > >  - optional mempool removal
> > 
> > Your CONFIG_MEMPOOL is completely broken as you are no longer giving the
> > same guarentees (you have no reserve at all). Might as well change it to
> > CONFIG_DEADLOCK instead.
> 
> It's equivalent to a pool size of zero, yes, so deadlock odds are
> significantly higher with some usage scenarios. I'll add a big fat
> warning.

Precisely. In most scenarios it makes deadlocks possible, where it was
safe before (more below).

> On the other hand, the existence of pre-allocated mempools can greatly
> increase the likelihood of starvation, oom, and deadlock on the rest
> of the system, especially as it becomes a greater percentage of the
> total free memory on a small system. In other words, I had to cut this
> corner to make running in 2M work with my config. When I merge
> CONFIG_BLOCK, it'll be more generally useful.

It needs to be carefulled tuned, definitely.

> For the sake of our other readers, I'll point out that mempool doesn't
> intrinisically reduce deadlock odds to zero unless we have a hard
> limit on requests in flight that's strictly less than pool size.

That's not true, depends entirely on usage. It's not a magic wand. And
you don't need a hard limit, you only need progress guarentee. Typically
just a single pre-allocated object can make you 100% deadlock free, if
stacking is not involved. So for most cases, I think it would be much
better if you just hard wired min_nr to 1, that would move you from 90%
to 99% safe :-)

-- 
Jens Axboe

