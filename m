Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266095AbSKOLCH>; Fri, 15 Nov 2002 06:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266108AbSKOLCG>; Fri, 15 Nov 2002 06:02:06 -0500
Received: from pc-62-31-74-27-ed.blueyonder.co.uk ([62.31.74.27]:22658 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S266095AbSKOLCG>; Fri, 15 Nov 2002 06:02:06 -0500
Date: Fri, 15 Nov 2002 11:08:30 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Alexander Viro <viro@math.psu.edu>,
       Andrew Morton <akpm@zip.com.au>
Cc: Stephen Tweedie <sct@redhat.com>, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Orlov allocator directory accounting bug
Message-ID: <20021115110830.D4512@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

In looking at the fix for the ext3 Orlov double-accounting bug, I
noticed a change to the sb->s_dir_count accounting, restoring a
missing s_dir_count++ when we allocate a new directory.

However, I can't find anywhere in the code where we decrement this
again on directory deletion, neither in ext2 nor in ext3, in 2.4 nor
in 2.5.

Patch below is against Ted's 2.4 Orlov-for-ext3 backport, but it looks
like we need something similar in both ext2 and ext3 in 2.5, too.

--Stephen

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="4200-orlov-dircount.patch"

--- linux-2.4-ext3merge/fs/ext3/ialloc.c.=K0023=.orig	Fri Nov 15 11:02:23 2002
+++ linux-2.4-ext3merge/fs/ext3/ialloc.c	Fri Nov 15 11:02:23 2002
@@ -263,9 +263,11 @@
 		if (gdp) {
 			gdp->bg_free_inodes_count = cpu_to_le16(
 				le16_to_cpu(gdp->bg_free_inodes_count) + 1);
-			if (is_directory)
+			if (is_directory) {
 				gdp->bg_used_dirs_count = cpu_to_le16(
 				  le16_to_cpu(gdp->bg_used_dirs_count) - 1);
+				EXT3_SB(sb)->s_dir_count--;
+			}
 		}
 		BUFFER_TRACE(bh2, "call ext3_journal_dirty_metadata");
 		err = ext3_journal_dirty_metadata(handle, bh2);

--r5Pyd7+fXNt84Ff3--
