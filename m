Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261625AbTCGPkK>; Fri, 7 Mar 2003 10:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261634AbTCGPkK>; Fri, 7 Mar 2003 10:40:10 -0500
Received: from ns.suse.de ([213.95.15.193]:10500 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261625AbTCGPkF>;
	Fri, 7 Mar 2003 10:40:05 -0500
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: Andrew Morton <akmp@zip.com.au>
Subject: [PATCH] Extended attribute sharing and debug macro typo in 2.5.64
Date: Fri, 7 Mar 2003 16:50:48 +0100
User-Agent: KMail/1.5
Cc: Tony.Dziedzic@storigen.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303071650.48105.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

Tony Dziedzic has found two bugs in the extended attributes code. Patches with 
explanations are attached. Could you please fold this into one of your next 
updates?

Thanks,
Andreas.

------------------------------------------------------------------------------
Extended attribute sharing on ext2/ext3 not working

The mb_cache_entry_insert function constantly returns an -EBUSY error
instead of 0, which causes the xattr cache that is needed by the xattr
sharing mechanism on ext2/ext3 to not share anything. This patch fixes
the problem. (It is possible that after applying this fix we will hit
bugs in code that wasn't used before.)

--- linux-2.5.64.orig/fs/mbcache.c	2003-03-07 16:24:07.000000000 +0100
+++ linux-2.5.64/fs/mbcache.c	2003-03-07 16:24:11.000000000 +0100
@@ -433,6 +433,7 @@
 		list_add(&ce->e_indexes[n].o_list,
 			 &cache->c_indexes_hash[n][bucket]);
 	}
+	error = 0;
 out:
 	spin_unlock(&mb_cache_spinlock);
 	return error;
Extended attributes debug macro oops


------------------------------------------------------------------------------
Oops in one of the xattr debug statements: The old_bh variable is NULL
if an inode that previously had no EA's assigned would share an EA block
with another inode. (This was hidden by the xattr sharing bug).

--- linux-2.5.64.orig/fs/ext2/xattr.c	2003-03-07 16:23:01.000000000 +0100
+++ linux-2.5.64/fs/ext2/xattr.c	2003-03-07 16:23:14.000000000 +0100
@@ -731,7 +731,7 @@
 			 * The old block will be released after updating
 			 * the inode.
 			 */
-			ea_bdebug(old_bh, "reusing block %ld",
+			ea_bdebug(new_bh, "reusing block %ld",
 				new_bh->b_blocknr);
 			
 			error = -EDQUOT;
--- linux-2.5.64.orig/fs/ext3/xattr.c	2003-03-07 16:22:55.000000000 +0100
+++ linux-2.5.64/fs/ext3/xattr.c	2003-03-07 16:23:21.000000000 +0100
@@ -732,7 +732,7 @@
 			 * The old block will be released after updating
 			 * the inode.
 			 */
-			ea_bdebug(old_bh, "reusing block %ld",
+			ea_bdebug(new_bh, "reusing block %ld",
 				new_bh->b_blocknr);
 			
 			error = -EDQUOT;

