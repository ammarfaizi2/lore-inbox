Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWGCOfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWGCOfm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 10:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWGCOfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 10:35:42 -0400
Received: from gold.veritas.com ([143.127.12.110]:11442 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751193AbWGCOfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 10:35:41 -0400
X-IronPort-AV: i="4.06,201,1149490800"; 
   d="scan'208"; a="61099439:sNHT28573524"
Date: Mon, 3 Jul 2006 15:35:17 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: [patch 7/8] inode-diet: Use a union for i_blocks and i_size,
 i_rdev and i_devices
In-Reply-To: <20060703012711.1bbf3af8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0607031518170.6960@blonde.wat.veritas.com>
References: <20060703005333.706556000@candygram.thunk.org>
 <20060703010023.720991000@candygram.thunk.org> <20060703012711.1bbf3af8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 03 Jul 2006 14:35:41.0022 (UTC) FILETIME=[F56537E0:01C69EAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2006, Andrew Morton wrote:
> On Sun, 02 Jul 2006 20:53:40 -0400
> "Theodore Ts'o" <tytso@mit.edu> wrote:
> 
> > The i_blocks and i_size fields are only used for regular files.  So we
> > move them into the union, along with i_rdev and i_devices, which are
> > only used by block or character devices.
> 
> It appears that device nodes in tmpfs tripped this up.
> kernel BUG at mm/shmem.c:693!
> EIP is at shmem_delete_inode+0x89/0xa4

I'm happy for you to resolve that by moving the tmpfs BUG_ON up into
the truncation block just above it, patch below.  But note that this
also covers the case of long symbolic links, and I think tmpfs is not
alone in using i_blocks with long symbolic links; and would some file-
systems also use it with directories?  Looks to me like there's more
auditing needed before putting i_blocks into a union (and it might
help if we delete those many lines initializing i_blocks to 0:
they're probably done before the union diverges, but worrysome).

Hugh

--- 2.6.17-mm6/mm/shmem.c	2006-07-03 12:23:59.000000000 +0100
+++ linux/mm/shmem.c	2006-07-03 15:17:19.000000000 +0100
@@ -689,8 +689,8 @@ static void shmem_delete_inode(struct in
 			list_del_init(&info->swaplist);
 			spin_unlock(&shmem_swaplist_lock);
 		}
+		BUG_ON(inode->i_blocks);
 	}
-	BUG_ON(inode->i_blocks);
 	if (sbinfo->max_inodes) {
 		spin_lock(&sbinfo->stat_lock);
 		sbinfo->free_inodes++;
