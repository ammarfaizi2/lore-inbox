Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbVC1Rq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbVC1Rq6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 12:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVC1RqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 12:46:08 -0500
Received: from fep19.inet.fi ([194.251.242.244]:15263 "EHLO fep19.inet.fi")
	by vger.kernel.org with ESMTP id S261973AbVC1RmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 12:42:05 -0500
Subject: [PATCH 6/9] isofs: convert macro to function in rock.c
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <ie2p50.yci66q.aqv0asoicoaoehr579419heqb.refire@cs.helsinki.fi>
In-Reply-To: <ie2p4s.1rtfc3.1osta177x31dpyo6jw6k30rf8.refire@cs.helsinki.fi>
Date: Mon, 28 Mar 2005 20:42:04 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts the CHECK_SP macro to a proper function in
fs/isofs/rock.c. 

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 rock.c |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

Index: 2.6/fs/isofs/rock.c
===================================================================
--- 2.6.orig/fs/isofs/rock.c	2005-03-28 16:32:13.000000000 +0300
+++ 2.6/fs/isofs/rock.c	2005-03-28 16:32:16.000000000 +0300
@@ -28,15 +28,13 @@
 
 #define SIG(A,B) ((A) | ((B) << 8))	/* isonum_721() */
 
-/* This is a way of ensuring that we have something in the system
-   use fields that is compatible with Rock Ridge */
-#define CHECK_SP(FAIL)	       			\
-      if(rr->u.SP.magic[0] != 0xbe) FAIL;	\
-      if(rr->u.SP.magic[1] != 0xef) FAIL;       \
-      ISOFS_SB(inode->i_sb)->s_rock_offset=rr->u.SP.skip;
-/* We define a series of macros because each function must do exactly the
-   same thing in certain places.  We use the macros to ensure that everything
-   is done correctly */
+static inline int rock_set_offset(struct inode *inode, struct rock_ridge * rr)
+{
+      if (rr->u.SP.magic[0] != 0xbe || rr->u.SP.magic[1] != 0xef)
+	      return 0;
+      ISOFS_SB(inode->i_sb)->s_rock_offset = rr->u.SP.skip;
+      return 1;
+}
 
 static int setup_rock_ridge(struct iso_directory_record *de, struct inode *inode, unsigned char ** chr)
 {
@@ -92,7 +90,8 @@
 					goto out;
 				break;
 			case SIG('S', 'P'):
-				CHECK_SP(goto out);
+				if (!rock_set_offset(inode, rr))
+					goto out;
 				break;
 			case SIG('C', 'E'):
 				{
@@ -225,7 +224,8 @@
 				break;
 #endif
 			case SIG('S', 'P'):
-				CHECK_SP(goto out);
+				if (!rock_set_offset(inode, rr))
+					goto out;
 				break;
 			case SIG('C', 'E'):
 				{
@@ -612,7 +612,8 @@
 				goto out;
 			break;
 		case SIG('S', 'P'):
-			CHECK_SP(goto out);
+			if (!rock_set_offset(inode, rr))
+				goto out;
 			break;
 		case SIG('S', 'L'):
 			rpnt = get_symlink_chunk(rpnt, rr,
