Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263786AbUEGU7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbUEGU7O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 16:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263789AbUEGU7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 16:59:14 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:62114 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263786AbUEGU7J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 16:59:09 -0400
Subject: Re: [Jfs-discussion] [CHECKER] Return Error code gets treated as
	dir_table index, resulting losses of other dir entries (JFS2.4, kernel
	2.4.19)
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Junfeng Yang <yjf@stanford.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       JFS Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       mc@cs.Stanford.EDU, Madanlal S Musuvathi <madan@stanford.edu>,
       "David L. Dill" <dill@cs.Stanford.EDU>
In-Reply-To: <Pine.GSO.4.44.0404301521130.14155-100000@elaine24.Stanford.EDU>
References: <Pine.GSO.4.44.0404301521130.14155-100000@elaine24.Stanford.EDU>
Content-Type: text/plain
Message-Id: <1083963526.11272.18.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 07 May 2004 15:58:46 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-30 at 17:23, Junfeng Yang wrote:
> static function add_index can fail by return -EPERM (and it is declared to
> return a unsigned 4-byte integer).  This error gets ignored by the caller,
> dtInsertEntry, which will treat the returned error code (u32)(-EPERM) as
> an index to dir_table.  This causes losses of directory entries in the
> same parent directory.

This patch makes the situation better.  Instead of returning -EPERM, it
returns zero.  It also cleans up behind itself to leave the index table
consistent.  At the time add_index is called, completely aborting the
operation is difficult, and jfs does attempt to deal with an invalid
index.  It will attempt to add a valid index table entry on subsequent
lookups.

===== jfs_dtree.c 1.29 vs edited =====
--- 1.29/fs/jfs/jfs_dtree.c	Fri May  7 10:32:20 2004
+++ edited/jfs_dtree.c	Fri May  7 10:38:37 2004
@@ -342,7 +342,6 @@
 	struct metapage *mp;
 	s64 offset;
 	uint page_offset;
-	int rc;
 	struct tlock *tlck;
 	s64 xaddr;
 
@@ -396,11 +395,11 @@
 		 * Allocate the first block & add it to the xtree
 		 */
 		xaddr = 0;
-		if ((rc =
-		     xtInsert(tid, ip, 0, 0, sbi->nbperpage,
-			      &xaddr, 0))) {
+		if (xtInsert(tid, ip, 0, 0, sbi->nbperpage, &xaddr, 0)) {
 			jfs_warn("add_index: xtInsert failed!");
-			return -EPERM;
+			memcpy(&jfs_ip->i_dirtable, temp_table,
+			       sizeof (temp_table));
+			goto clean_up;
 		}
 		ip->i_size = PSIZE;
 		ip->i_blocks += LBLK2PBLK(sb, sbi->nbperpage);
@@ -408,7 +407,9 @@
 		if ((mp = get_index_page(ip, 0)) == 0) {
 			jfs_err("add_index: get_metapage failed!");
 			xtTruncate(tid, ip, 0, COMMIT_PWMAP);
-			return -EPERM;
+			memcpy(&jfs_ip->i_dirtable, temp_table,
+			       sizeof (temp_table));
+			goto clean_up;
 		}
 		tlck = txLock(tid, ip, mp, tlckDATA);
 		llck = (struct linelock *) & tlck->lock;
@@ -438,12 +439,9 @@
 		 * This will be the beginning of a new page
 		 */
 		xaddr = 0;
-		if ((rc =
-		     xtInsert(tid, ip, 0, blkno, sbi->nbperpage,
-			      &xaddr, 0))) {
+		if (xtInsert(tid, ip, 0, blkno, sbi->nbperpage, &xaddr, 0)) {
 			jfs_warn("add_index: xtInsert failed!");
-			jfs_ip->next_index--;
-			return -EPERM;
+			goto clean_up;
 		}
 		ip->i_size += PSIZE;
 		ip->i_blocks += LBLK2PBLK(sb, sbi->nbperpage);
@@ -457,7 +455,7 @@
 
 	if (mp == 0) {
 		jfs_err("add_index: get/read_metapage failed!");
-		return -EPERM;
+		goto clean_up;
 	}
 
 	lock_index(tid, ip, mp, index);
@@ -472,6 +470,12 @@
 	release_metapage(mp);
 
 	return index;
+
+      clean_up:
+
+	jfs_ip->next_index--;
+
+	return 0;
 }
 
 /*

-- 
David Kleikamp
IBM Linux Technology Center

