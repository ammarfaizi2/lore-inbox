Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265697AbUHWQLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbUHWQLb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 12:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265887AbUHWQJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 12:09:24 -0400
Received: from av9-1-sn1.fre.skanova.net ([81.228.11.115]:22494 "EHLO
	av9-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S266163AbUHWQHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 12:07:51 -0400
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Speed up the cdrw packet writing driver
References: <m33c2py1m1.fsf@telia.com> <20040823114329.GI2301@suse.de>
From: Peter Osterlund <petero2@telia.com>
Date: 23 Aug 2004 18:07:28 +0200
In-Reply-To: <20040823114329.GI2301@suse.de>
Message-ID: <m3llg5dein.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> On Sat, Aug 14 2004, Peter Osterlund wrote:
> > Hi!
> > 
> > This patch replaces the pd->bio_queue linked list with an rbtree.  The
> > list can get very long (>200000 entries on a 1GB machine), so keeping
> > it sorted with a naive algorithm is far too expensive.
> 
> It looks like you are assuming that bio->bi_sector is unique which isn't
> necessarily true. In that respect, list -> rbtree conversion isn't
> trivial (or, at least it requires extra code to handle this).

I don't think that is assumed anywhere.

The pkt_rbtree_find() function returns the first node with a sector
number >= s, even if there are multiple bios with bi_sector == s. Note
that the code branches to the left if s == tmp->bio->bi_sector.

The pkt_rbtree_insert() function is careful to insert a bio after any
already existing bios with the same sector number. Note that it
branches to the right if s == tmp->bio->bi_sector.

The tree rotations done internally in rbtree.c also can't mess things
up, because tree rotations don't change the inorder traversal order of
a tree.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
