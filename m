Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162264AbWKPCur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162264AbWKPCur (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162271AbWKPCup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:50:45 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:33160 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162266AbWKPCuX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:50:23 -0500
Message-Id: <20061116024916.390806000@sous-sol.org>
References: <20061116024332.124753000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 15 Nov 2006 18:44:01 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, maks@sternwelten.at,
       Steve French <sfrench@us.ibm.com>
Subject: [patch 29/30] CIFS: report rename failure when target file is locked by Windows
Content-Disposition: inline; filename=cifs-report-rename-failure-when-target-file-is-locked-by-windows.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Steve French <sfrench@us.ibm.com>

Fixes Samba bugzilla bug # 4182

Rename by handle failures (retry after rename by path) were not
being returned back.

Signed-off-by: Steve French <sfrench@us.ibm.com>
[chrisw: trivial backport in CHANGES]
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 fs/cifs/CHANGES |    6 +++++-
 fs/cifs/inode.c |   14 +++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

--- linux-2.6.18.2.orig/fs/cifs/CHANGES
+++ linux-2.6.18.2/fs/cifs/CHANGES
@@ -6,7 +6,11 @@ on requests on other threads.  Improve P
 (lock cancel now works, and unlock of merged range works even
 to Windows servers now).  Fix oops on mount to lanman servers
 (win9x, os/2 etc.) when null password.  Do not send listxattr
-(SMB to query all EAs) if nouser_xattr specified.
+(SMB to query all EAs) if nouser_xattr specified.  Return error
+in rename 2nd attempt retry (ie report if rename by handle also
+fails, after rename by path fails, we were not reporting whether
+the retry worked or not).
+
 
 Version 1.44
 ------------
--- linux-2.6.18.2.orig/fs/cifs/inode.c
+++ linux-2.6.18.2/fs/cifs/inode.c
@@ -880,10 +880,14 @@ int cifs_rename(struct inode *source_ino
 			kmalloc(2 * sizeof(FILE_UNIX_BASIC_INFO), GFP_KERNEL);
 		if (info_buf_source != NULL) {
 			info_buf_target = info_buf_source + 1;
-			rc = CIFSSMBUnixQPathInfo(xid, pTcon, fromName,
-				info_buf_source, cifs_sb_source->local_nls, 
-				cifs_sb_source->mnt_cifs_flags &
-					CIFS_MOUNT_MAP_SPECIAL_CHR);
+			if (pTcon->ses->capabilities & CAP_UNIX)
+				rc = CIFSSMBUnixQPathInfo(xid, pTcon, fromName,
+					info_buf_source, 
+					cifs_sb_source->local_nls,
+					cifs_sb_source->mnt_cifs_flags &
+						CIFS_MOUNT_MAP_SPECIAL_CHR);
+			/* else rc is still EEXIST so will fall through to
+			   unlink the target and retry rename */
 			if (rc == 0) {
 				rc = CIFSSMBUnixQPathInfo(xid, pTcon, toName,
 						info_buf_target,
@@ -932,7 +936,7 @@ int cifs_rename(struct inode *source_ino
 				 cifs_sb_source->mnt_cifs_flags & 
 					CIFS_MOUNT_MAP_SPECIAL_CHR);
 		if (rc==0) {
-			CIFSSMBRenameOpenFile(xid, pTcon, netfid, toName,
+			rc = CIFSSMBRenameOpenFile(xid, pTcon, netfid, toName,
 					      cifs_sb_source->local_nls, 
 					      cifs_sb_source->mnt_cifs_flags &
 						CIFS_MOUNT_MAP_SPECIAL_CHR);

--
