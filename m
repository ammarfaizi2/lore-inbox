Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265242AbUD3Tzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265242AbUD3Tzs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 15:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265243AbUD3Tzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 15:55:48 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:62611 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S265242AbUD3Tzc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 15:55:32 -0400
Date: Fri, 30 Apr 2004 14:55:04 -0500
From: "Jose R. Santos" <jrsantos@austin.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, anton@samba.org, dheger@us.ibm.com,
       slpratt@us.ibm.com
Subject: [PATCH] dentry and inode cache hash algorithm performance changes.
Message-ID: <20040430195504.GE14271@rx8.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

err... Seems I've send this to the wrong list.  
Sending to linux-kernel this time :)

-----------------------------------------------------------------------

Hi Andrew,

Could you consider this patch for inclusion into mainline kernel?  It 
alleviates some issues seen with Linux when accessing millions of files
on machines with large amounts of RAM (+32GB).  Both algorithms are base
on some studies that Dominique Heger was doing on hash table efficiencies
in Linux.  The dentry hash table has been tested in small systems with 
one internal IDE hard disk as well as in large SMP with many fiberchanel
disks.  Dominique claims that in all the testing done, they did not see
one case were this has function provided worst performance and that in
most test they were seeing better performance.

The inode hash function was done by me base on Dominique's original work
and has only been stress tested with SpecSFS.  It provided a 3% 
improvement over the default algorithm in the SpecSFS results and speed 
ups in the response time of almost all filesystem operations the benchmark
stress.  With the better distribution is as also possible to reduce the 
number of inode buckets for 32 million to 16 million and still get a slightly
better results.

Anton was nice enough to provide some graphs that show the distribution 
before and after the patch at http://samba.org/~anton/linux/sfs/1/

Thanks 

-JRS

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1582  -> 1.1583 
#	         fs/dcache.c	1.70    -> 1.71   
#	          fs/inode.c	1.113   -> 1.114  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/04/30	jsantos@rx8.austin.ibm.com	1.1583
# Hash functions changes that show improvements on SpecSFS when a large amount of files is used (+20 Million).
# --------------------------------------------
#
diff -Nru a/fs/dcache.c b/fs/dcache.c
--- a/fs/dcache.c	Fri Apr 30 12:14:23 2004
+++ b/fs/dcache.c	Fri Apr 30 12:14:23 2004
@@ -28,6 +28,7 @@
 #include <asm/uaccess.h>
 #include <linux/security.h>
 #include <linux/seqlock.h>
+#include <linux/hash.h>
 
 #define DCACHE_PARANOIA 1
 /* #define DCACHE_DEBUG 1 */
@@ -799,8 +800,8 @@
 
 static inline struct hlist_head * d_hash(struct dentry * parent, unsigned long hash)
 {
-	hash += (unsigned long) parent / L1_CACHE_BYTES;
-	hash = hash ^ (hash >> D_HASHBITS);
+	hash += ((unsigned long) parent ^ GOLDEN_RATIO_PRIME) / L1_CACHE_BYTES;
+	hash = hash ^ ((hash ^ GOLDEN_RATIO_PRIME) >> D_HASHBITS);
 	return dentry_hashtable + (hash & D_HASHMASK);
 }
 
diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Fri Apr 30 12:14:23 2004
+++ b/fs/inode.c	Fri Apr 30 12:14:23 2004
@@ -671,8 +671,9 @@
 
 static inline unsigned long hash(struct super_block *sb, unsigned long hashval)
 {
-	unsigned long tmp = hashval + ((unsigned long) sb / L1_CACHE_BYTES);
-	tmp = tmp + (tmp >> I_HASHBITS);
+	unsigned long tmp = (hashval + ((unsigned long) sb) ^ (GOLDEN_RATIO_PRIME + hashval)
+			/ L1_CACHE_BYTES);
+	tmp = tmp + ((tmp ^ GOLDEN_RATIO_PRIME) >> I_HASHBITS);
 	return tmp & I_HASHMASK;
 }
 




