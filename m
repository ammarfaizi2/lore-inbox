Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263952AbTDNV0w (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263954AbTDNV0w (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:26:52 -0400
Received: from [12.47.58.203] ([12.47.58.203]:44029 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263952AbTDNV0v (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 17:26:51 -0400
Date: Mon, 14 Apr 2003 14:38:13 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blockgroup_lock: hashed spinlocks for ext2 and ext3
Message-Id: <20030414143813.329609a6.akpm@digeo.com>
In-Reply-To: <1050350782.7912.400.camel@averell>
References: <200304131113.h3DBDvj2004773@hera.kernel.org>
	<1050350782.7912.400.camel@averell>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Apr 2003 21:38:36.0606 (UTC) FILETIME=[34A20DE0:01C302CE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> > +
> > +struct bgl_lock {
> > +	spinlock_t lock;
> > +} ____cacheline_aligned_in_smp;
> > +
> > +struct blockgroup_lock {
> > +	struct bgl_lock locks[NR_BG_LOCKS];
> > +};
> 
> Why don't you use per_cpu data for this ? It can be indexed as well
> with per_cpu() and it would safe a lot of space because the padding
> would not be all wasted. If you want more than NR_CPUS locks it could be
> done using a simple two level index scheme.

per_cpu data is statically allocated, at compile-time.  And it doesn't work
for modules.

These hashed locks need to be dynamically allocated (one per filesystem) and
they need to work from modules.

And this hashed lock is not a per-cpu thing.  (No locks are!) It just uses
NR_CPUS to decide how big the hash should be.

