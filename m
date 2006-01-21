Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbWAUBZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWAUBZK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 20:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbWAUBZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 20:25:10 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:16781 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932377AbWAUBZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 20:25:09 -0500
Date: Fri, 20 Jan 2006 20:26:40 -0500
From: Latchesar Ionkov <lucho@ionkov.net>
To: Andrew Morton <akpm@osdl.org>
Cc: v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] v9fs: symlink support fixes
Message-ID: <20060121012640.GA2084@ionkov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

two symlink fixes, v9fs_readlink didn't copy the last character of the
symlink name, v9fs_vfs_follow_link incorrectly called strlen of newly
allocated buffer instead of PATH_MAX.

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>

---
commit 80543589e5ab35e0fda3e97f93108f136eb4e623
tree 78150d708f7d815a3aa64967741f1aa9df60be9f
parent 3ee68c4af3fd7228c1be63254b9f884614f9ebb2
author Latchesar Ionkov <lucho@ionkov.net> Fri, 20 Jan 2006 20:20:38 -0500
committer Latchesar Ionkov <lucho@ionkov.net> Fri, 20 Jan 2006 20:20:38 -0500

 fs/9p/vfs_inode.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 91f5524..63e5b03 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -886,8 +886,8 @@ static int v9fs_readlink(struct dentry *
 	}
 
 	/* copy extension buffer into buffer */
-	if (fcall->params.rstat.stat.extension.len < buflen)
-		buflen = fcall->params.rstat.stat.extension.len;
+	if (fcall->params.rstat.stat.extension.len+1 < buflen)
+		buflen = fcall->params.rstat.stat.extension.len + 1;
 
 	memcpy(buffer, fcall->params.rstat.stat.extension.str, buflen - 1);
 	buffer[buflen-1] = 0;
@@ -951,7 +951,7 @@ static void *v9fs_vfs_follow_link(struct
 	if (!link)
 		link = ERR_PTR(-ENOMEM);
 	else {
-		len = v9fs_readlink(dentry, link, strlen(link));
+		len = v9fs_readlink(dentry, link, PATH_MAX);
 
 		if (len < 0) {
 			__putname(link);
