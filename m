Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWCXT2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWCXT2G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 14:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWCXT2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 14:28:06 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:58789 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S964794AbWCXT2E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 14:28:04 -0500
Date: Fri, 24 Mar 2006 12:28:02 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Valerie Henson <val_henson@linux.intel.com>
Cc: Andrew Morton <akpm@osdl.org>, pbadari@gmail.com,
       linux-kernel@vger.kernel.org, Ext2-devel@lists.sourceforge.net,
       arjan@linux.intel.com, tytso@mit.edu, zach.brown@oracle.com
Subject: Re: [Ext2-devel] [RFC] [PATCH] Reducing average ext2 fsck time through fs-wide dirty bit]
Message-ID: <20060324192802.GK14852@schatzie.adilger.int>
Mail-Followup-To: Valerie Henson <val_henson@linux.intel.com>,
	Andrew Morton <akpm@osdl.org>, pbadari@gmail.com,
	linux-kernel@vger.kernel.org, Ext2-devel@lists.sourceforge.net,
	arjan@linux.intel.com, tytso@mit.edu, zach.brown@oracle.com
References: <20060322011034.GP12571@goober> <1143054558.6086.61.camel@dyn9047017100.beaverton.ibm.com> <20060322224844.GU12571@goober> <20060322175503.3b678ab5.akpm@osdl.org> <20060324143239.GB14508@goober>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060324143239.GB14508@goober>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 24, 2006  06:32 -0800, Valerie Henson wrote:
> However, half the reason
> I'm working on ext2 is the simplicity of the code - stubbing it out
> would solve the performance problem but not the complexity problem.

But by the same token, adding the ext3 reservation code to ext2 isn't
doing anything to improve the simplicity of the ext2 code.  That is
one reason why we've frowned upon adding any features to ext2, except
critical disk-format compatibility ones.

> Note that ext3's habit of clearing indirect blocks on truncate would
> break some things I want to do in the future. (Insert secret plans
> here.)

Ah, this is a long-standing ext3 wart that I've wanted to fix.  In the
vast majority of cases (especially when there is a large journal in use)
it is possible to do the truncate in a single transaction.  The only issue
is figuring out how big the transaction should be.

The good news, is that fixing the "ext3 clearing indirect blocks" problem
not only allows undelete to work again, but also improves truncate
performance because (a) we only modify 1/32 of the blocks we would in the
old case (we don't need to modify any {d,t,}indirect blocks), (b) we do
indirect block walking in forward direction, and could submit {d,}indirect
block requests in a batch instead of one-at-a-time.

Fix for this problem (inode is locked already):
- create a modified ext3_free_branches() to do tree walking and call a
  method instead of always calling ext3_free_data->ext3_clear_blocks
- walk inode {d,t,}indirect blocks in forward direction, count bitmaps and
  groups that will be modified (essentially NULL ext3_free_branches method)
- try to start a journal handle for this many blocks + 1 (inode) +
  1 (super) + quota + EXT3_RESERVE_TRANS_BLOCKS
  - if journal handle is too large (journal_start() returns -ENOSPC) fall
    back to old zero-in-steps method (vast majority of cases will be OK
    because number of modified blocks is much fewer)
- walk inode {d,t,}indirect blocks again deleting blocks via
  ext3_free_blocks_sb() (updates group descriptor, bitmaps, quota), but
  not journaling or modifying the indirect blocks
- update i_size/i_disksize/i_blocks to new value, like ext2
- close transaction

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

