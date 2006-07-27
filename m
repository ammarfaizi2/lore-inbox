Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWG0U7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWG0U7b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWG0Uxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:53:46 -0400
Received: from mx2.redhat.com ([66.187.237.31]:51169 "EHLO mx2.redhat.com")
	by vger.kernel.org with ESMTP id S1750955AbWG0UxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:53:20 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 21/30] NFS: Secure the roots of the NFS subtrees in a shared superblock [try #11]
Date: Thu, 27 Jul 2006 21:53:14 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060727205314.8443.77944.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
References: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Invoke security_d_instantiate() on root dentries after allocating them with
dentry_alloc_anon().  Normally dentry_alloc_root() would do that, but we don't
call that as we don't want to assign a name to the root dentry at this point
(we may discover the real name later).

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/nfs/getroot.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
index 977e590..76b08ae 100644
--- a/fs/nfs/getroot.c
+++ b/fs/nfs/getroot.c
@@ -33,6 +33,7 @@ #include <linux/nfs_idmap.h>
 #include <linux/vfs.h>
 #include <linux/namei.h>
 #include <linux/namespace.h>
+#include <linux/security.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -109,6 +110,8 @@ struct dentry *nfs_get_root(struct super
 		return ERR_PTR(-ENOMEM);
 	}
 
+	security_d_instantiate(mntroot, inode);
+
 	if (!mntroot->d_op)
 		mntroot->d_op = server->nfs_client->rpc_ops->dentry_ops;
 
@@ -296,6 +299,8 @@ struct dentry *nfs4_get_root(struct supe
 		return ERR_PTR(-ENOMEM);
 	}
 
+	security_d_instantiate(mntroot, inode);
+
 	if (!mntroot->d_op)
 		mntroot->d_op = server->nfs_client->rpc_ops->dentry_ops;
 
