Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbUEEA3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbUEEA3W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 20:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUEEA3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 20:29:22 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:29788 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261865AbUEEA3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 20:29:20 -0400
Date: Wed, 5 May 2004 01:29:13 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rmap 22 flush_dcache_mmap_lock
In-Reply-To: <1083711195.1660.3.camel@mulgrave>
Message-ID: <Pine.LNX.4.44.0405050112090.3076-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 May 2004, James Bottomley wrote:
> 
> I thought in a prior discussion with Andrea that there was a generic VM
> i_mmap loop that can take rather a long time, and thus we didn't want a

There is indeed, that's vmtruncate truncating pages out of all the
vmas which might contain it.  That loop is the one guarded by
i_shared_lock (i_shared_sem in 2.6.6 itself).

> spinlock for this, but a rwlock.  Since our critical regions in the
> cache flushing are read only, only i_mmap updates (which are short
> critical regions) take the write lock with irqsave, all the rest take
> the shared read lock with irq.

That's why I'm using the separate low-level tree_lock in addition
for your flush_dcache_page: it's not held over all that vmtruncate,
just at those moments someone needs to alter the i_mmap tree itself
in some way, very brief - not while someone is working on vmas in
that tree.  Yes, serializing you with the i_shared_lock would be
very bad news in some cases.

(I don't get your point about _irqsave for writes but _irq for
reads: do I need to do something like that?  I don't see why.)

Using an rwlock would provide another solution; but I'm dubious of
that solution since the majority of traffic on that lock would be
"w"s (inserting and removing vmas) rather than "r"s (scanning tree) -
at least, I think that would be the case on the hot paths of other
architectures than parisc and arm.  I'm guessing efficiency is
targetted at the opposite, "r"s much more common than "w"s.

> Unless you've eliminated this long scan from the generic VM, I think the
> idea is still better than a simple spinlock.

The long scan is not eliminated, but the spinlock I'm proposing
in this patch is (by design) quite independent of that - you can
flush_dcache_page to your heart's content while vmtruncate is in
progress, it wouldn't be locking it out at all.

Hugh

