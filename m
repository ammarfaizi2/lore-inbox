Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWCXVXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWCXVXQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 16:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWCXVXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 16:23:16 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:48799 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751433AbWCXVXP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 16:23:15 -0500
Date: Fri, 24 Mar 2006 14:23:12 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Valerie Henson <val_henson@linux.intel.com>, Andrew Morton <akpm@osdl.org>,
       pbadari@gmail.com, linux-kernel@vger.kernel.org,
       Ext2-devel@lists.sourceforge.net, arjan@linux.intel.com, tytso@mit.edu,
       zach.brown@oracle.com
Subject: Re: [Ext2-devel] [RFC] [PATCH] Reducing average ext2 fsck time through fs-wide dirty bit]
Message-ID: <20060324212312.GR14852@schatzie.adilger.int>
Mail-Followup-To: Matthew Wilcox <matthew@wil.cx>,
	Valerie Henson <val_henson@linux.intel.com>,
	Andrew Morton <akpm@osdl.org>, pbadari@gmail.com,
	linux-kernel@vger.kernel.org, Ext2-devel@lists.sourceforge.net,
	arjan@linux.intel.com, tytso@mit.edu, zach.brown@oracle.com
References: <20060322011034.GP12571@goober> <1143054558.6086.61.camel@dyn9047017100.beaverton.ibm.com> <20060322224844.GU12571@goober> <20060322175503.3b678ab5.akpm@osdl.org> <20060324143239.GB14508@goober> <20060324192802.GK14852@schatzie.adilger.int> <20060324205229.GD11703@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060324205229.GD11703@parisc-linux.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 24, 2006  13:52 -0700, Matthew Wilcox wrote:
> On Fri, Mar 24, 2006 at 12:28:02PM -0700, Andreas Dilger wrote:
> > Fix for this problem (inode is locked already):
> > - create a modified ext3_free_branches() to do tree walking and call a
> >   method instead of always calling ext3_free_data->ext3_clear_blocks
> > - walk inode {d,t,}indirect blocks in forward direction, count bitmaps and
> >   groups that will be modified (essentially NULL ext3_free_branches method)
> > - try to start a journal handle for this many blocks + 1 (inode) +
> >   1 (super) + quota + EXT3_RESERVE_TRANS_BLOCKS
> >   - if journal handle is too large (journal_start() returns -ENOSPC) fall
> >     back to old zero-in-steps method (vast majority of cases will be OK
> >     because number of modified blocks is much fewer)
> 
> Could we try a different fallback in this case?  For example, attempt to
> truncate only half as much?  Is this even allowed?

What you suggest IS essentially the fallback.  The current code will start
truncating at the end and grow the truncation until it can't any longer.
In order to make this operation correct w.r.t. recovery, it HAS to
zero out the already-truncated blocks, because the first transaction
may complete and commit, while the second may not.  The proposed new
behaviour is only acceptable because it ensures that the whole truncate
can be completed in a single transaction.


For a rough estimate of the allowable size of a "new" truncate
transaction, worst case truncate dirties every group in the filesystem.
A 2TB filesystem has 16384 groups, maximum transaction size:

  (16384 bitmaps + (16384 / 128) group desc + inode + super + quota)
  = 16518

requiring a journal size of 4x that is about 260MB (default journal
size is 128MB these days for large filesystems).  For the worst case 1
block/group this works out to a 64MB file, but in the vast majority of
cases we will have more than a single block per group, and could have
a full file truncate (up to 2TB file size) in the same (or smaller)
transaction size.  Best case is about 125MB/group (i.e. per 4kB of journal
transaction size).

With the absolute minimum journal size we could always truncate files
up to 1MB w/o fallback, and rougly up to 16GB (at 1/2 group chunks per
"extent") without fallback.

The current code needs ~33 4kB blocks per 128MB of file size.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

