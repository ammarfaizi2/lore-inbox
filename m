Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWFRRur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWFRRur (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 13:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWFRRur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 13:50:47 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:16565 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932275AbWFRRuq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 13:50:46 -0400
Date: Sun, 18 Jun 2006 18:50:45 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5]: ufs: missed brelse and wrong baseblk
Message-ID: <20060618175045.GX27946@ftp.linux.org.uk>
References: <20060617101403.GA22098@rain.homenetwork> <20060618162054.GW27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060618162054.GW27946@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2006 at 05:20:54PM +0100, Al Viro wrote:
> Comment more on the entire series than on this patch: scenario that causes
> trouble
> 	* foo is a sparse file on ufs with 8Kb block/1Kb fragment
> 	* process opens it writable and mmaps it shared
> 	* it proceeds to dirty the pages
> 	* fork
> 	* parent and child do msync() on pages next to each other
> 
> I.e. we try to write adjacent pages that sit in the same block.  At the
> same time.  Each will trigger an allocation and we'd better be very
> careful, or we'll end up allocating the same block twice.

FWIW, for folks who are not familiar with UFS: the important differences
between it and ext2 are
	* directory chunk size is fixed to 512, instead of being fs parameter
as in ext2
	* names in directory entries are NUL-terminated
	* there are two allocation units: fragment and block.  Each block
consists of 2^{parameter} fragments.  ext2 is what you get when parameter
is 0 (block == fragment).  UFS tends to use block:fragment == 8, but
1, 2 and 4 are also allowed.
	* equivalent of ext2 free block bitmap has bit per fragment.
	* "block" in "direct block", "indirect block", etc. is actually
a group of fragments.  The number of first fragment in group is stored
where ext2 would store the block number.
	* if there are indirect blocks, all those groups are simply full
blocks; they are aligned to block boundary and consist of block:fragment
ratio fragments.
	* if file is shorter than 12 * block size, we have no indirects and
all but the last direct one are full blocks.  I.e. the numbers we have
there are multiples of block:fragment ration and a full block is allocated
for each.   The last one consists of just enough fragments to reach the
end of file and may be not aligned.

IOW, it's _almost_ as if we had ext2 with all block numbers (in inode and
in indirect blocks) multiplied by block:fragment ratio.  The only exception
is for the last direct block of small files - these span fewer fragments
and may be unaligned.

The only subtle part is when we extend a small file; the last direct block
needs to be expanded and that may require relocation.

	* block may be bigger than page.  That can cause all sorts of fun
problems in interaction with our VM, since allocation can affect more than
one page and that has to be taken into account.

	* UFS2 supports ext.attributes; it has two fragment numbers in
inode; they refer to up to 2 blocks worth of data.  As with the data
of small files, the partial block doesn't have to be aligned.
