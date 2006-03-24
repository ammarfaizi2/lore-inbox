Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWCXUwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWCXUwc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 15:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWCXUwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 15:52:32 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:12942 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1750742AbWCXUwb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 15:52:31 -0500
Date: Fri, 24 Mar 2006 13:52:29 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Valerie Henson <val_henson@linux.intel.com>, Andrew Morton <akpm@osdl.org>,
       pbadari@gmail.com, linux-kernel@vger.kernel.org,
       Ext2-devel@lists.sourceforge.net, arjan@linux.intel.com, tytso@mit.edu,
       zach.brown@oracle.com
Subject: Re: [Ext2-devel] [RFC] [PATCH] Reducing average ext2 fsck time through fs-wide dirty bit]
Message-ID: <20060324205229.GD11703@parisc-linux.org>
References: <20060322011034.GP12571@goober> <1143054558.6086.61.camel@dyn9047017100.beaverton.ibm.com> <20060322224844.GU12571@goober> <20060322175503.3b678ab5.akpm@osdl.org> <20060324143239.GB14508@goober> <20060324192802.GK14852@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060324192802.GK14852@schatzie.adilger.int>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 12:28:02PM -0700, Andreas Dilger wrote:
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

Could we try a different fallback in this case?  For example, attempt to
truncate only half as much?  Is this even allowed?

> - walk inode {d,t,}indirect blocks again deleting blocks via
>   ext3_free_blocks_sb() (updates group descriptor, bitmaps, quota), but
>   not journaling or modifying the indirect blocks
> - update i_size/i_disksize/i_blocks to new value, like ext2
> - close transaction

