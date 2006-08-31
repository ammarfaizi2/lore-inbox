Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWHaXqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWHaXqQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 19:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWHaXqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 19:46:16 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:63697 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S932488AbWHaXqP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 19:46:15 -0400
Message-ID: <44F77653.6000606@student.ltu.se>
Date: Fri, 01 Sep 2006 01:52:51 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org, xfs-masters@oss.sgi.com, nathans@sgi.com
CC: xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.18-rc4-mm3 2/2] fs/xfs: Correcting error-prone boolean-statement
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Knutsson <ricknu-0@student.ltu.se>

Converting error-prone statement:
"if (var == B_FALSE)" into "if (!var)"
"if (var == B_TRUE)"  into "if (var)"
 
Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

Compile-tested
Please Cc: since I'm not on xfs@oss.sgi.com


 xfs_log.c    |    4 ++--
 xfs_vfsops.c |   16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)


diff -Narup a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
--- a/fs/xfs/xfs_log.c	2006-08-31 22:03:56.000000000 +0200
+++ b/fs/xfs/xfs_log.c	2006-09-01 00:14:02.000000000 +0200
@@ -3484,7 +3484,7 @@ xlog_verify_iclog(xlog_t	 *log,
 		/* clientid is only 1 byte */
 		field_offset = (__psint_t)
 			       ((xfs_caddr_t)&(ophead->oh_clientid) - base_ptr);
-		if (syncing == B_FALSE || (field_offset & 0x1ff)) {
+		if (!syncing || (field_offset & 0x1ff)) {
 			clientid = ophead->oh_clientid;
 		} else {
 			idx = BTOBBT((xfs_caddr_t)&(ophead->oh_clientid) - iclog->ic_datap);
@@ -3504,7 +3504,7 @@ xlog_verify_iclog(xlog_t	 *log,
 		/* check length */
 		field_offset = (__psint_t)
 			       ((xfs_caddr_t)&(ophead->oh_len) - base_ptr);
-		if (syncing == B_FALSE || (field_offset & 0x1ff)) {
+		if (!syncing || (field_offset & 0x1ff)) {
 			op_len = INT_GET(ophead->oh_len, ARCH_CONVERT);
 		} else {
 			idx = BTOBBT((__psint_t)&ophead->oh_len -
diff -Narup a/fs/xfs/xfs_vfsops.c b/fs/xfs/xfs_vfsops.c
--- a/fs/xfs/xfs_vfsops.c	2006-08-31 22:03:56.000000000 +0200
+++ b/fs/xfs/xfs_vfsops.c	2006-09-01 00:14:36.000000000 +0200
@@ -935,7 +935,7 @@ xfs_sync_inodes(
  * longer be locked.
  */
 #define IPOINTER_INSERT(ip, mp)	{ \
-		ASSERT(ipointer_in == B_FALSE); \
+		ASSERT(!ipointer_in); \
 		ipointer->ip_mnext = ip->i_mnext; \
 		ipointer->ip_mprev = ip; \
 		ip->i_mnext = (xfs_inode_t *)ipointer; \
@@ -952,7 +952,7 @@ xfs_sync_inodes(
  * past us.
  */
 #define IPOINTER_REMOVE(ip, mp)	{ \
-		ASSERT(ipointer_in == B_TRUE); \
+		ASSERT(ipointer_in); \
 		if (ipointer->ip_mnext != (xfs_inode_t *)ipointer) { \
 			ip = ipointer->ip_mnext; \
 			ip->i_mprev = ipointer->ip_mprev; \
@@ -1006,8 +1006,8 @@ xfs_sync_inodes(
 	IPOINTER_CLR;
 
 	do {
-		ASSERT(ipointer_in == B_FALSE);
-		ASSERT(vnode_refed == B_FALSE);
+		ASSERT(!ipointer_in);
+		ASSERT(!vnode_refed);
 
 		lock_flags = base_lock_flags;
 
@@ -1372,7 +1372,7 @@ xfs_sync_inodes(
 				IPOINTER_REMOVE(ip, mp);
 			}
 			XFS_MOUNT_IUNLOCK(mp);
-			ASSERT(ipointer_in == B_FALSE);
+			ASSERT(!ipointer_in);
 			kmem_free(ipointer, sizeof(xfs_iptr_t));
 			return XFS_ERROR(error);
 		}
@@ -1387,21 +1387,21 @@ xfs_sync_inodes(
 			}
 		}
 
-		if (mount_locked == B_FALSE) {
+		if (!mount_locked) {
 			XFS_MOUNT_ILOCK(mp);
 			mount_locked = B_TRUE;
 			IPOINTER_REMOVE(ip, mp);
 			continue;
 		}
 
-		ASSERT(ipointer_in == B_FALSE);
+		ASSERT(!ipointer_in);
 		ip = ip->i_mnext;
 
 	} while (ip != mp->m_inodes);
 
 	XFS_MOUNT_IUNLOCK(mp);
 
-	ASSERT(ipointer_in == B_FALSE);
+	ASSERT(!ipointer_in);
 
 	kmem_free(ipointer, sizeof(xfs_iptr_t));
 	return XFS_ERROR(last_error);


