Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVAWXm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVAWXm5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 18:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVAWXm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 18:42:57 -0500
Received: from mail.suse.de ([195.135.220.2]:8164 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261378AbVAWXc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 18:32:27 -0500
From: Andreas Gruenbacher <agruen@suse.de>
To: tridge@osdl.org
Subject: Re: [ea-in-inode 0/5] Further fixes
Date: Mon, 24 Jan 2005 00:32:16 +0100
User-Agent: KMail/1.7.1
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Andreas Dilger <adilger@clusterfs.com>, Alex Tomas <alex@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <20050120020124.110155000@suse.de> <16884.8352.76012.779869@samba.org> <200501232358.09926.agruen@suse.de>
In-Reply-To: <200501232358.09926.agruen@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501240032.17236.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 January 2005 23:58, Andreas Gruenbacher wrote:
> > Jan 23 06:54:38 dev4-003 kernel: journal_bmap: journal block not found at
> > offset 1036 on sdc1 Jan 23 06:54:38 dev4-003 kernel: Aborting journal on
> > device sdc1.
>
> Are you using data journaling on that filesystem? Does this test pass with
> the patches backed out? With an external journal?

There are 12 direct and 1024 indirect blocks on a filesystem with 4k 
blocksize, so block 1036 should be the first double-indirect block. It may be 
that something is messing up the double-indirect link or one of its fields. 
Interesting. Could you maybe try this patch as well?

Index: linux-2.6.11-rc1-mm2/fs/ext3/inode.c
===================================================================
--- linux-2.6.11-rc1-mm2.orig/fs/ext3/inode.c
+++ linux-2.6.11-rc1-mm2/fs/ext3/inode.c
@@ -2653,7 +2653,7 @@ static int ext3_do_update_inode(handle_t
 	} else for (block = 0; block < EXT3_N_BLOCKS; block++)
 		raw_inode->i_block[block] = ei->i_data[block];
 
-	if (EXT3_INODE_SIZE(inode->i_sb) > EXT3_GOOD_OLD_INODE_SIZE)
+	if (ei->i_extra_isize)
 		raw_inode->i_extra_isize = cpu_to_le16(ei->i_extra_isize);
 
 	BUFFER_TRACE(bh, "call ext3_journal_dirty_metadata");

Thanks,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH
