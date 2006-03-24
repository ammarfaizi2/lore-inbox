Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWCXUBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWCXUBg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 15:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWCXUBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 15:01:36 -0500
Received: from THUNK.ORG ([69.25.196.29]:26338 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751357AbWCXUBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 15:01:35 -0500
Date: Fri, 24 Mar 2006 15:01:31 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Valerie Henson <val_henson@linux.intel.com>, Andrew Morton <akpm@osdl.org>,
       pbadari@gmail.com, linux-kernel@vger.kernel.org,
       Ext2-devel@lists.sourceforge.net, arjan@linux.intel.com,
       zach.brown@oracle.com
Subject: Re: [Ext2-devel] [RFC] [PATCH] Reducing average ext2 fsck time through fs-wide dirty bit]
Message-ID: <20060324200131.GE18020@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Valerie Henson <val_henson@linux.intel.com>,
	Andrew Morton <akpm@osdl.org>, pbadari@gmail.com,
	linux-kernel@vger.kernel.org, Ext2-devel@lists.sourceforge.net,
	arjan@linux.intel.com, zach.brown@oracle.com
References: <20060322011034.GP12571@goober> <1143054558.6086.61.camel@dyn9047017100.beaverton.ibm.com> <20060322224844.GU12571@goober> <20060322175503.3b678ab5.akpm@osdl.org> <20060324143239.GB14508@goober> <20060324192802.GK14852@schatzie.adilger.int>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060324192802.GK14852@schatzie.adilger.int>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 12:28:02PM -0700, Andreas Dilger wrote:
> The good news, is that fixing the "ext3 clearing indirect blocks" problem
> not only allows undelete to work again, but also improves truncate
> performance because (a) we only modify 1/32 of the blocks we would in the
> old case (we don't need to modify any {d,t,}indirect blocks), (b) we do
> indirect block walking in forward direction, and could submit {d,}indirect
> block requests in a batch instead of one-at-a-time.
> 
> Fix for this problem (inode is locked already):
> - create a modified ext3_free_branches() to do tree walking and call a
>   method instead of always calling ext3_free_data->ext3_clear_blocks
> - walk inode {d,t,}indirect blocks in forward direction, count bitmaps and
>   groups that will be modified (essentially NULL ext3_free_branches method)
> - try to start a journal handle for this many blocks + 1 (inode) +
>   1 (super) + quota + EXT3_RESERVE_TRANS_BLOCKS
>   - if journal handle is too large (journal_start() returns -ENOSPC) fall
>     back to old zero-in-steps method (vast majority of cases will be OK
>     because number of modified blocks is much fewer)
> - walk inode {d,t,}indirect blocks again deleting blocks via
>   ext3_free_blocks_sb() (updates group descriptor, bitmaps, quota), but
>   not journaling or modifying the indirect blocks
> - update i_size/i_disksize/i_blocks to new value, like ext2
> - close transaction

I would love to see something like this as well (the fact that we zero
out the indirect blocks on truncate/unlink has always bothered me).
However, the thing that scares me about this is that this means we now
have to maintain *two* horribly complicated pieces of code for which
it will be very easy for bugs to creep in.  

This would be a prime candidate for trying to add the same sort of
userspace test framework which Rusty and company did for netfilter, so
we can try to test for race conditions, corner cases, etc.

						- Ted
