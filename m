Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263184AbUFTWtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbUFTWtE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 18:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUFTWtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 18:49:04 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:37316 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S263184AbUFTWsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 18:48:55 -0400
Date: Sun, 20 Jun 2004 18:51:01 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Urban Widmark <urban@teststation.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2.6] Remove smbfs server->rcls/err
Message-ID: <Pine.LNX.4.58.0406201842100.3260@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a small cleanup requested by Urban, use the rcls/err in
smb_request as opposed to smb_sb_info.

 fs/smbfs/proc.c           |   12 ++++++------
 include/linux/smb_fs_sb.h |    3 ---
 2 files changed, 6 insertions(+), 9 deletions(-)

Signed-off-by: Zwane Mwaikambo <zwane@linuxpower.ca>

Index: linux-2.6.7-rc3-mm2/include/linux/smb_fs_sb.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.7-rc3-mm2/include/linux/smb_fs_sb.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smb_fs_sb.h
--- linux-2.6.7-rc3-mm2/include/linux/smb_fs_sb.h	14 Jun 2004 12:48:50 -0000	1.1.1.1
+++ linux-2.6.7-rc3-mm2/include/linux/smb_fs_sb.h	20 Jun 2004 22:47:59 -0000
@@ -60,9 +60,6 @@ struct smb_sb_info {

 	struct semaphore sem;

-        unsigned short     rcls; /* The error codes we received */
-        unsigned short     err;
-
 	unsigned char      header[SMB_HEADER_LEN + 20*2 + 2];
 	u32                header_len;
 	u32                smb_len;
Index: linux-2.6.7-rc3-mm2/fs/smbfs/proc.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.7-rc3-mm2/fs/smbfs/proc.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 proc.c
--- linux-2.6.7-rc3-mm2/fs/smbfs/proc.c	14 Jun 2004 12:49:17 -0000	1.1.1.1
+++ linux-2.6.7-rc3-mm2/fs/smbfs/proc.c	20 Jun 2004 22:47:59 -0000
@@ -2370,7 +2370,7 @@ smb_proc_readdir_long(struct file *filp,
 		if (req->rq_rcls != 0) {
 			result = smb_errno(req);
 			PARANOIA("name=%s, result=%d, rcls=%d, err=%d\n",
-				 mask, result, server->rcls, server->err);
+				 mask, result, req->rq_rcls, req->rq_err);
 			break;
 		}

@@ -2526,7 +2526,7 @@ smb_proc_getattr_ff(struct smb_sb_info *
 	result = smb_add_request(req);
 	if (result < 0)
 		goto out_free;
-	if (server->rcls != 0) {
+	if (req->rq_rcls != 0) {
 		result = smb_errno(req);
 #ifdef SMBFS_PARANOIA
 		if (result != -ENOENT)
@@ -2639,7 +2639,7 @@ smb_proc_getattr_trans2(struct smb_sb_in
 	result = smb_add_request(req);
 	if (result < 0)
 		goto out;
-	if (server->rcls != 0) {
+	if (req->rq_rcls != 0) {
 		VERBOSE("for %s: result=%d, rcls=%d, err=%d\n",
 			&param[6], result, req->rq_rcls, req->rq_err);
 		result = smb_errno(req);
@@ -3218,7 +3218,7 @@ smb_proc_read_link(struct smb_sb_info *s
 	if (result < 0)
 		goto out_free;
 	DEBUG1("for %s: result=%d, rcls=%d, err=%d\n",
-		&param[6], result, server->rcls, server->err);
+		&param[6], result, req->rq_rcls, req->rq_err);

 	/* copy data up to the \0 or buffer length */
 	result = len;
@@ -3268,7 +3268,7 @@ smb_proc_symlink(struct smb_sb_info *ser
 		goto out_free;

 	DEBUG1("for %s: result=%d, rcls=%d, err=%d\n",
-		&param[6], result, server->rcls, server->err);
+		&param[6], result, req->rq_rcls, req->rq_err);
 	result = 0;

 out_free:
@@ -3315,7 +3315,7 @@ smb_proc_link(struct smb_sb_info *server
 		goto out_free;

 	DEBUG1("for %s: result=%d, rcls=%d, err=%d\n",
-	       &param[6], result, server->rcls, server->err);
+	       &param[6], result, req->rq_rcls, req->rq_err);
 	result = 0;

 out_free:
