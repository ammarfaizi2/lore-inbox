Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268274AbUHXUaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268274AbUHXUaI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 16:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268276AbUHXUaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 16:30:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30638 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S268274AbUHXUaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 16:30:01 -0400
Date: Tue, 24 Aug 2004 22:29:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Peter Osterlund <petero2@telia.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Speed up the cdrw packet writing driver
Message-ID: <20040824202951.GA24280@suse.de>
References: <m33c2py1m1.fsf@telia.com> <20040823114329.GI2301@suse.de> <m3llg5dein.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3llg5dein.fsf@telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23 2004, Peter Osterlund wrote:
> Jens Axboe <axboe@suse.de> writes:
> 
> > On Sat, Aug 14 2004, Peter Osterlund wrote:
> > > Hi!
> > > 
> > > This patch replaces the pd->bio_queue linked list with an rbtree.  The
> > > list can get very long (>200000 entries on a 1GB machine), so keeping
> > > it sorted with a naive algorithm is far too expensive.
> > 
> > It looks like you are assuming that bio->bi_sector is unique which isn't
> > necessarily true. In that respect, list -> rbtree conversion isn't
> > trivial (or, at least it requires extra code to handle this).
> 
> I don't think that is assumed anywhere.
> 
> The pkt_rbtree_find() function returns the first node with a sector
> number >= s, even if there are multiple bios with bi_sector == s. Note
> that the code branches to the left if s == tmp->bio->bi_sector.
> 
> The pkt_rbtree_insert() function is careful to insert a bio after any
> already existing bios with the same sector number. Note that it
> branches to the right if s == tmp->bio->bi_sector.
> 
> The tree rotations done internally in rbtree.c also can't mess things
> up, because tree rotations don't change the inorder traversal order of
> a tree.

You are right, the code looks fine indeed. The bigger problem is
probably that a faster data structure is needed at all, having hundreds
of thousands bio's pending for a packet writing device is not nice at
all.

-- 
Jens Axboe

