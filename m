Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946250AbWJSRNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946250AbWJSRNS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946253AbWJSRNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:13:18 -0400
Received: from mx2.netapp.com ([216.240.18.37]:17669 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1946250AbWJSRNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:13:16 -0400
X-IronPort-AV: i="4.09,330,1157353200"; 
   d="scan'208"; a="419609113:sNHT17543652"
From: Trond Myklebust <Trond.Myklebust@netapp.com>
Date: Thu, 19 Oct 2006 13:11:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Message-Id: <20061019171113.8593.90932.stgit@lade.trondhjem.org>
In-Reply-To: <20061019171113.8593.8585.stgit@lade.trondhjem.org>
References: <20061019171113.8593.8585.stgit@lade.trondhjem.org>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Subject: [PATCH 2/2] NFS: Cache invalidation fixup
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 19 Oct 2006 17:13:27.0319 (UTC) FILETIME=[E45C8270:01C6F3A1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <Trond.Myklebust@netapp.com>

If someone has renamed a directory on the server, triggering the d_move
code in d_materialise_unique(), then we need to invalidate the
cached directory information in the source parent directory.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/dir.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 2cfa414..fa71936 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -936,8 +936,14 @@ static struct dentry *nfs_lookup(struct 
 no_entry:
 	res = d_materialise_unique(dentry, inode);
 	if (res != NULL) {
+		struct dentry *parent;
 		if (IS_ERR(res))
 			goto out_unlock;
+		/* Was a directory renamed! */
+		parent = dget_parent(res);
+		if (!IS_ROOT(parent))
+			nfs_mark_for_revalidate(parent->d_inode);
+		dput(parent);
 		dentry = res;
 	}
 	nfs_renew_times(dentry);
