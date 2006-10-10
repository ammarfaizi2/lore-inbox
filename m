Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWJJRQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWJJRQg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 13:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWJJRQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 13:16:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:52617 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964796AbWJJRPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 13:15:36 -0400
Date: Tue, 10 Oct 2006 10:14:43 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Trond Myklebust <Trond.Myklebust@netapp.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 05/19] NFS: More page cache revalidation fixups
Message-ID: <20061010171443.GF6339@kroah.com>
References: <20061010165621.394703368@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="nfs-more-page-cache-revalidation-fixups.patch"
In-Reply-To: <20061010171350.GA6339@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Trond Myklebust <Trond.Myklebust@netapp.com>

Whenever the directory changes, we want to make sure that we always
invalidate its page cache. Fix up update_changeattr() and
nfs_mark_for_revalidate() so that they do so.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/nfs/nfs4proc.c      |   10 +++++-----
 include/linux/nfs_fs.h |    6 +++++-
 2 files changed, 10 insertions(+), 6 deletions(-)

--- linux-2.6.17.13.orig/fs/nfs/nfs4proc.c
+++ linux-2.6.17.13/fs/nfs/nfs4proc.c
@@ -185,15 +185,15 @@ static void renew_lease(const struct nfs
 	spin_unlock(&clp->cl_lock);
 }
 
-static void update_changeattr(struct inode *inode, struct nfs4_change_info *cinfo)
+static void update_changeattr(struct inode *dir, struct nfs4_change_info *cinfo)
 {
-	struct nfs_inode *nfsi = NFS_I(inode);
+	struct nfs_inode *nfsi = NFS_I(dir);
 
-	spin_lock(&inode->i_lock);
-	nfsi->cache_validity |= NFS_INO_INVALID_ATTR;
+	spin_lock(&dir->i_lock);
+	nfsi->cache_validity |= NFS_INO_INVALID_ATTR|NFS_INO_REVAL_PAGECACHE|NFS_INO_INVALID_DATA;
 	if (cinfo->before == nfsi->change_attr && cinfo->atomic)
 		nfsi->change_attr = cinfo->after;
-	spin_unlock(&inode->i_lock);
+	spin_unlock(&dir->i_lock);
 }
 
 struct nfs4_opendata {
--- linux-2.6.17.13.orig/include/linux/nfs_fs.h
+++ linux-2.6.17.13/include/linux/nfs_fs.h
@@ -234,8 +234,12 @@ static inline int nfs_caches_unstable(st
 
 static inline void nfs_mark_for_revalidate(struct inode *inode)
 {
+	struct nfs_inode *nfsi = NFS_I(inode);
+
 	spin_lock(&inode->i_lock);
-	NFS_I(inode)->cache_validity |= NFS_INO_INVALID_ATTR | NFS_INO_INVALID_ACCESS;
+	nfsi->cache_validity |= NFS_INO_INVALID_ATTR|NFS_INO_INVALID_ACCESS;
+	if (S_ISDIR(inode->i_mode))
+		nfsi->cache_validity |= NFS_INO_REVAL_PAGECACHE|NFS_INO_INVALID_DATA;
 	spin_unlock(&inode->i_lock);
 }
 

--
