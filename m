Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756120AbWKVRxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756120AbWKVRxL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 12:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756125AbWKVRxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 12:53:10 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:14290 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1756120AbWKVRxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 12:53:09 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] [DCACHE] : avoid RCU for never hashed dentries
Date: Wed, 22 Nov 2006 18:53:26 +0100
User-Agent: KMail/1.9.5
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org,
       David Miller <davem@davemloft.net>
References: <20061024141739.GB18364@nuim.ie> <20061025.230615.92585270.davem@davemloft.net> <200610311948.48970.dada1@cosmosbay.com>
In-Reply-To: <200610311948.48970.dada1@cosmosbay.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_X6IZFtdQLo6gxD9"
Message-Id: <200611221853.27037.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_X6IZFtdQLo6gxD9
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Some dentries dont need to be globally visible in dentry hashtable. (pipes & 
sockets)

Such dentries dont need to wait for a RCU grace period at delete time. Being 
able to free them permits a better CPU cache use (hot cache)

This patch combined with (dont insert pipe dentries into dentry_hashtable)
reduced time of { pipe(p); close(p[0]); close(p[1]);} on my UP machine (1.6 
GHz Pentium-M) from 3.23 us to 2.86 us
(But this patch does not depend on other patches, only bench results)

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--Boundary-00=_X6IZFtdQLo6gxD9
Content-Type: text/plain;
  charset="utf-8";
  name="avoid_rcu_dcache.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="avoid_rcu_dcache.patch"

--- linux-2.6.19-rc6/fs/dcache.c	2006-11-22 17:33:33.000000000 +0100
+++ linux-2.6.19-rc6-ed/fs/dcache.c	2006-11-22 17:33:58.000000000 +0100
@@ -68,15 +68,19 @@ struct dentry_stat_t dentry_stat = {
 	.age_limit = 45,
 };
 
-static void d_callback(struct rcu_head *head)
+static void __d_free(struct dentry *dentry)
 {
-	struct dentry * dentry = container_of(head, struct dentry, d_u.d_rcu);
-
 	if (dname_external(dentry))
 		kfree(dentry->d_name.name);
 	kmem_cache_free(dentry_cache, dentry); 
 }
 
+static void d_callback(struct rcu_head *head)
+{
+	struct dentry * dentry = container_of(head, struct dentry, d_u.d_rcu);
+	__d_free(dentry);
+}
+
 /*
  * no dcache_lock, please.  The caller must decrement dentry_stat.nr_dentry
  * inside dcache_lock.
@@ -85,7 +89,11 @@ static void d_free(struct dentry *dentry
 {
 	if (dentry->d_op && dentry->d_op->d_release)
 		dentry->d_op->d_release(dentry);
- 	call_rcu(&dentry->d_u.d_rcu, d_callback);
+	/* if dentry was never inserted into hash, immediate free is OK */
+	if (dentry->d_hash.pprev == NULL)
+		__d_free(dentry);
+	else
+		call_rcu(&dentry->d_u.d_rcu, d_callback);
 }
 
 /*

--Boundary-00=_X6IZFtdQLo6gxD9--
