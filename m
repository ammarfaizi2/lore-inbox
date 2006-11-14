Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966314AbWKNUUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966314AbWKNUUb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 15:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966313AbWKNUUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 15:20:31 -0500
Received: from extu-mxob-2.symantec.com ([216.10.194.135]:28577 "EHLO
	extu-mxob-2.symantec.com") by vger.kernel.org with ESMTP
	id S965326AbWKNUUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 15:20:30 -0500
X-AuditID: d80ac287-a3cc9bb000002ee7-be-455a2502a36c 
Date: Tue, 14 Nov 2006 20:20:36 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Martin Bligh <mbligh@mbligh.org>
cc: Mel Gorman <mel@skynet.ie>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Boot failure with ext2 and initrds
In-Reply-To: <455A174E.3070601@mbligh.org>
Message-ID: <Pine.LNX.4.64.0611141959150.14484@blonde.wat.veritas.com>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061114184919.GA16020@skynet.ie>
 <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com> <455A174E.3070601@mbligh.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 14 Nov 2006 20:20:18.0219 (UTC) FILETIME=[4D5197B0:01C7082A]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2006, Martin Bligh wrote:
> Hugh Dickins wrote:
> > I expect you'll find it's
> > ext2-reservations-bring-ext2-reservations-code-in-line-with-latest-ext3.patch
> > which gets stuck in a loop there for me too: back it out and all seems fine.
> > 
> > It's not obvious which part of the patch is to blame: mostly it's
> > cleanup, but a few variables do change size: I'm currently narrowing
> > down to where a fix is needed.
> 
> Humpf. that was meant to be one of those "so obvious I can't screw it
> up" patches.

Never underestimate yourself, Martin ;)

> 
> typedef unsigned long ext2_fsblk_t;
> typedef int ext2_grpblk_t;
> 
> in ext2_alloc_blocks we do change from "unsigned long long" to
> "unsigned long" for new_blocks[], but akpm thinks that was garbage
> before (same for ext2_alloc_branch's current_block)

Yes, I agree, those particular changes looked just fine,
and indeed they're not to blame.

> 
> The ext2_grpblk_t ones all look innocuous.

Yes, those all looked like no-ops.  The guilty party is ext2_new_blocks:
i386, x86_64 and ppc64 are now happily building on ext2s with this patch
below (I've been lazy, could have deleted your "E2FSBLK" addition too).

But I haven't attempted to correlate it with the loops seen (with OOMs
too on the x86_64, no idea why, but they've likewise melted away with
this patch).  And I'm dubious whether it's the _right_ fix: the whole
mess of ints, unsigned longs and __u32s looks tricky to me, not some-
thing to sort out in a hurry - I'm only working with small filesystems
here (looped on a tmpfs file).  (And if ret_block really should be an
ext2_fsblk_t there, shouldn't ext2_new_blocks return an ext2_fsblk_t
rather than an int?)

I see Andrew's sent me an alternative patch to try, I'll give that
a whirl now; and see if just making ext2_new_blocks return an
ext2_fsblk_t would do it too.

Hugh

--- 2.6.19-rc5-mm2/fs/ext2/balloc.c	2006-11-14 12:10:07.000000000 +0000
+++ linux/fs/ext2/balloc.c	2006-11-14 19:34:06.000000000 +0000
@@ -1155,7 +1155,7 @@ int ext2_new_blocks(struct inode *inode,
 	struct buffer_head *gdp_bh;
 	int group_no;
 	int goal_group;
-	ext2_fsblk_t ret_block;		/* filesyetem-wide allocated block */
+	int ret_block;			/* filesystem-wide allocated block */
 	int bgi;			/* blockgroup iteration index */
 	int target_block;
 	int performed_allocation = 0;
@@ -1320,7 +1320,7 @@ allocated:
 
 	if (ret_block + num - 1 >= le32_to_cpu(es->s_blocks_count)) {
 		ext2_error(sb, "ext2_new_blocks",
-			    "block("E2FSBLK") >= blocks count(%d) - "
+			    "block(%d) >= blocks count(%d) - "
 			    "block_group = %d, es == %p ", ret_block,
 			le32_to_cpu(es->s_blocks_count), group_no, es);
 		goto out;
