Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262319AbVDLR6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbVDLR6H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 13:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVDLKfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:35:43 -0400
Received: from fire.osdl.org ([65.172.181.4]:3528 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262116AbVDLKbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:08 -0400
Message-Id: <200504121030.j3CAUw0e005195@shell0.pdx.osdl.net>
Subject: [patch 021/198] net: don't call kmem_cache_create with a spinlock held
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, acme@conectiva.com.br,
       davem@davemloft.net
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:30:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>

This fixes the warning reported by Marcel Holtmann (Thanks!).
  
Signed-off-by: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/net/core/sock.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff -puN net/core/sock.c~dont-call-kmem_cache_create-with-a-spinlock-held net/core/sock.c
--- 25/net/core/sock.c~dont-call-kmem_cache_create-with-a-spinlock-held	2005-04-12 03:21:08.325871176 -0700
+++ 25-akpm/net/core/sock.c	2005-04-12 03:21:08.329870568 -0700
@@ -1359,8 +1359,6 @@ int proto_register(struct proto *prot, i
 {
 	int rc = -ENOBUFS;
 
-	write_lock(&proto_list_lock);
-
 	if (alloc_slab) {
 		prot->slab = kmem_cache_create(prot->name, prot->obj_size, 0,
 					       SLAB_HWCACHE_ALIGN, NULL, NULL);
@@ -1368,14 +1366,15 @@ int proto_register(struct proto *prot, i
 		if (prot->slab == NULL) {
 			printk(KERN_CRIT "%s: Can't create sock SLAB cache!\n",
 			       prot->name);
-			goto out_unlock;
+			goto out;
 		}
 	}
 
+	write_lock(&proto_list_lock);
 	list_add(&prot->node, &proto_list);
-	rc = 0;
-out_unlock:
 	write_unlock(&proto_list_lock);
+	rc = 0;
+out:
 	return rc;
 }
 
_
