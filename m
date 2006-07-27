Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751906AbWG0SGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbWG0SGV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 14:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbWG0SGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 14:06:21 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:33169 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751906AbWG0SGU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 14:06:20 -0400
Subject: [PATCH v2] nfs: Release dcache_lock in an error path of nfs_path
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
In-Reply-To: <1153848015.5639.17.camel@localhost>
References: <1153848015.5639.17.camel@localhost>
Content-Type: text/plain
Date: Thu, 27 Jul 2006 11:06:14 -0700
Message-Id: <1154023574.12517.106.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In one of the error paths of nfs_path, it may return with dcache_lock still
held; fix this by adding and using a new error path Elong_unlock which unlocks
dcache_lock.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
Fixed commit message typo from previous version: s/dentry_lock/dcache_lock/g.

 fs/nfs/namespace.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 19b98ca..86b3169 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -51,7 +51,7 @@ char *nfs_path(const char *base, const s
 		namelen = dentry->d_name.len;
 		buflen -= namelen + 1;
 		if (buflen < 0)
-			goto Elong;
+			goto Elong_unlock;
 		end -= namelen;
 		memcpy(end, dentry->d_name.name, namelen);
 		*--end = '/';
@@ -68,6 +68,8 @@ char *nfs_path(const char *base, const s
 	end -= namelen;
 	memcpy(end, base, namelen);
 	return end;
+Elong_unlock:
+	spin_unlock(&dcache_lock);
 Elong:
 	return ERR_PTR(-ENAMETOOLONG);
 }


