Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265823AbUH3SaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265823AbUH3SaN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 14:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268657AbUH3S3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 14:29:36 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:26536 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S268834AbUH3SQh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 14:16:37 -0400
Subject: Re: JFS kernel BUG
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: James Spooner <james@endace.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <001001c48e7d$17c63b60$5440a8c0@zeus>
References: <001001c48e7d$17c63b60$5440a8c0@zeus>
Content-Type: text/plain
Message-Id: <1093877749.20837.26.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 30 Aug 2004 09:55:49 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-30 at 05:35, James Spooner wrote:
> I've encountered a problem writing large files onto a JFS
> filesystem under 2.6.8.1.  As follows.  What is interesting
> is that this bug is triggered as the file reaches the 512GB
> mark, co-incidence perhaps? :)
> 
> BUG at fs/jfs/jfs_xtree.c:1701 assert(p->header.nextindex == ((__u16)(2 +
> 1)))

I've just recently fixed this due to another bug report, but haven't
merged the patch yet.  Can you test it with this patch please?

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

diff -Nurp linux-2.6.9-rc1-mm1/fs/jfs/jfs_xtree.c linux/fs/jfs/jfs_xtree.c
--- linux-2.6.9-rc1-mm1/fs/jfs/jfs_xtree.c	2004-08-30 09:47:14.245002600 -0500
+++ linux/fs/jfs/jfs_xtree.c	2004-08-30 09:48:29.847509272 -0500
@@ -1622,7 +1622,6 @@ int xtExtend(tid_t tid,		/* transaction 
 	s64 xaddr;
 	struct tlock *tlck;
 	struct xtlock *xtlck = NULL;
-	int rootsplit = 0;
 
 	jfs_info("xtExtend: nxoff:0x%lx nxlen:0x%x", (ulong) xoff, xlen);
 
@@ -1678,8 +1677,6 @@ int xtExtend(tid_t tid,		/* transaction 
 	 * The xtSplitUp() will insert the entry and unpin the leaf page.
 	 */
 	if (nextindex == le16_to_cpu(p->header.maxentry)) {
-		rootsplit = p->header.flag & BT_ROOT;
-
 		/* xtSpliUp() unpins leaf pages */
 		split.mp = mp;
 		split.index = index + 1;
@@ -1691,16 +1688,21 @@ int xtExtend(tid_t tid,		/* transaction 
 		if ((rc = xtSplitUp(tid, ip, &split, &btstack)))
 			return rc;
 
+		/* get back old page */
+		XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
+		if (rc)
+			return rc;
 		/*
 		 * if leaf root has been split, original root has been
 		 * copied to new child page, i.e., original entry now
 		 * resides on the new child page;
 		 */
-		if (rootsplit) {
+		if (p->header.flag & BT_INTERNAL) {
 			ASSERT(p->header.nextindex ==
 			       cpu_to_le16(XTENTRYSTART + 1));
 			xad = &p->xad[XTENTRYSTART];
 			bn = addressXAD(xad);
+			XT_PUTPAGE(mp);
 
 			/* get new child page */
 			XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
@@ -1712,11 +1714,6 @@ int xtExtend(tid_t tid,		/* transaction 
 				tlck = txLock(tid, ip, mp, tlckXTREE|tlckGROW);
 				xtlck = (struct xtlock *) & tlck->lock;
 			}
-		} else {
-			/* get back old page */
-			XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
-			if (rc)
-				return rc;
 		}
 	}
 	/*
@@ -1790,7 +1787,6 @@ int xtTailgate(tid_t tid,		/* transactio
 	struct xtlock *xtlck = 0;
 	struct tlock *mtlck;
 	struct maplock *pxdlock;
-	int rootsplit = 0;
 
 /*
 printf("xtTailgate: nxoff:0x%lx nxlen:0x%x nxaddr:0x%lx\n",
@@ -1848,8 +1844,6 @@ printf("xtTailgate: xoff:0x%lx xlen:0x%x
 	 * The xtSplitUp() will insert the entry and unpin the leaf page.
 	 */
 	if (nextindex == le16_to_cpu(p->header.maxentry)) {
-		rootsplit = p->header.flag & BT_ROOT;
-
 		/* xtSpliUp() unpins leaf pages */
 		split.mp = mp;
 		split.index = index + 1;
@@ -1861,16 +1855,21 @@ printf("xtTailgate: xoff:0x%lx xlen:0x%x
 		if ((rc = xtSplitUp(tid, ip, &split, &btstack)))
 			return rc;
 
+		/* get back old page */
+		XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
+		if (rc)
+			return rc;
 		/*
 		 * if leaf root has been split, original root has been
 		 * copied to new child page, i.e., original entry now
 		 * resides on the new child page;
 		 */
-		if (rootsplit) {
+		if (p->header.flag & BT_INTERNAL) {
 			ASSERT(p->header.nextindex ==
 			       cpu_to_le16(XTENTRYSTART + 1));
 			xad = &p->xad[XTENTRYSTART];
 			bn = addressXAD(xad);
+			XT_PUTPAGE(mp);
 
 			/* get new child page */
 			XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
@@ -1882,11 +1881,6 @@ printf("xtTailgate: xoff:0x%lx xlen:0x%x
 				tlck = txLock(tid, ip, mp, tlckXTREE|tlckGROW);
 				xtlck = (struct xtlock *) & tlck->lock;
 			}
-		} else {
-			/* get back old page */
-			XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
-			if (rc)
-				return rc;
 		}
 	}
 	/*
@@ -1976,7 +1970,7 @@ int xtUpdate(tid_t tid, struct inode *ip
 	s64 nxaddr, xaddr;
 	struct tlock *tlck;
 	struct xtlock *xtlck = NULL;
-	int rootsplit = 0, newpage = 0;
+	int newpage = 0;
 
 	/* there must exist extent to be tailgated */
 	nxoff = offsetXAD(nxad);
@@ -2183,7 +2177,6 @@ int xtUpdate(tid_t tid, struct inode *ip
 
 	/* insert nXAD:recorded */
 	if (nextindex == le16_to_cpu(p->header.maxentry)) {
-		rootsplit = p->header.flag & BT_ROOT;
 
 		/* xtSpliUp() unpins leaf pages */
 		split.mp = mp;
@@ -2196,16 +2189,21 @@ int xtUpdate(tid_t tid, struct inode *ip
 		if ((rc = xtSplitUp(tid, ip, &split, &btstack)))
 			return rc;
 
+		/* get back old page */
+		XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
+		if (rc)
+			return rc;
 		/*
 		 * if leaf root has been split, original root has been
 		 * copied to new child page, i.e., original entry now
 		 * resides on the new child page;
 		 */
-		if (rootsplit) {
+		if (p->header.flag & BT_INTERNAL) {
 			ASSERT(p->header.nextindex ==
 			       cpu_to_le16(XTENTRYSTART + 1));
 			xad = &p->xad[XTENTRYSTART];
 			bn = addressXAD(xad);
+			XT_PUTPAGE(mp);
 
 			/* get new child page */
 			XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
@@ -2218,11 +2216,6 @@ int xtUpdate(tid_t tid, struct inode *ip
 				xtlck = (struct xtlock *) & tlck->lock;
 			}
 		} else {
-			/* get back old page */
-			XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
-			if (rc)
-				return rc;
-
 			/* is nXAD on new page ? */
 			if (newindex >
 			    (le16_to_cpu(p->header.maxentry) >> 1)) {
@@ -2336,8 +2329,6 @@ int xtUpdate(tid_t tid, struct inode *ip
 	xlen = xlen - nxlen;
 	xaddr = xaddr + nxlen;
 	if (nextindex == le16_to_cpu(p->header.maxentry)) {
-		rootsplit = p->header.flag & BT_ROOT;
-
 /*
 printf("xtUpdate.updateLeft.split p:0x%p\n", p);
 */
@@ -2352,16 +2343,22 @@ printf("xtUpdate.updateLeft.split p:0x%p
 		if ((rc = xtSplitUp(tid, ip, &split, &btstack)))
 			return rc;
 
+		/* get back old page */
+		XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
+		if (rc)
+			return rc;
+
 		/*
 		 * if leaf root has been split, original root has been
 		 * copied to new child page, i.e., original entry now
 		 * resides on the new child page;
 		 */
-		if (rootsplit) {
+		if (p->header.flag & BT_INTERNAL) {
 			ASSERT(p->header.nextindex ==
 			       cpu_to_le16(XTENTRYSTART + 1));
 			xad = &p->xad[XTENTRYSTART];
 			bn = addressXAD(xad);
+			XT_PUTPAGE(mp);
 
 			/* get new child page */
 			XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
@@ -2373,11 +2370,6 @@ printf("xtUpdate.updateLeft.split p:0x%p
 				tlck = txLock(tid, ip, mp, tlckXTREE|tlckGROW);
 				xtlck = (struct xtlock *) & tlck->lock;
 			}
-		} else {
-			/* get back old page */
-			XT_GETPAGE(ip, bn, mp, PSIZE, p, rc);
-			if (rc)
-				return rc;
 		}
 	} else {
 		/* if insert into middle, shift right remaining entries */


