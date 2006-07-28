Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752037AbWG1Q2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbWG1Q2Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 12:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752034AbWG1Q2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 12:28:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:37026 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752037AbWG1Q2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 12:28:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=TDELqtCsIb/fndUZhg9LooNguM/WmqlcVzU9xucNnoTS2xegX8XS1evyd5Gqje1fmERFk+l1GgEPZDPaj3UKqBSOUtsgWF7BeWfuQ0cRs5+sTUfewCNryyfJsfefn+sEGs7TF92VEfU1Gu9+uTOm/HPKUo18aFN058MrgRbjyFM=
Date: Fri, 28 Jul 2006 18:28:15 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, acme@mandriva.com, marcel@holtmann.org, jet@gyve.org
Subject: [03/04 mm-patch, rfc] Add lightweight rwlock to net/dccp/ccid.c (was Re: [mm-patch] bluetooth: use GFP_ATOMIC in *_sock_create's sk_alloc)
Message-ID: <20060728162815.GC1227@slug>
References: <20060728083532.GA311@slug> <20060728.181756.135980869.jet@gyve.org> <20060728123246.GB311@slug> <20060728.221252.265353941.jet@gyve.org> <20060728161515.GA1227@slug> <20060728162320.GB1227@slug>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="at6+YcpfzWZg/htY"
Content-Disposition: inline
In-Reply-To: <20060728162320.GB1227@slug>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch is part of the lw_rwlock patchset, it removes the
ccids_{read,write}_{lock,unlock} functions which have been moved
to linux/lw_rwlock.h and made more generic.
                                          
Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="net_dccp_ccid.c-use-lw_rwlocks.patch"

--- v2.6.18-rc2-mm1~ori/net/dccp/ccid.c	2006-06-18 03:49:35.000000000 +0200
+++ v2.6.18-rc2-mm1/net/dccp/ccid.c	2006-07-28 16:19:32.000000000 +0200
@@ -12,48 +12,11 @@
  */
 
 #include "ccid.h"
+#include <linux/lw_rwlock.h>
 
 static struct ccid_operations *ccids[CCID_MAX];
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
-static atomic_t ccids_lockct = ATOMIC_INIT(0);
-static DEFINE_SPINLOCK(ccids_lock);
-
-/*
- * The strategy is: modifications ccids vector are short, do not sleep and
- * veeery rare, but read access should be free of any exclusive locks.
- */
-static void ccids_write_lock(void)
-{
-	spin_lock(&ccids_lock);
-	while (atomic_read(&ccids_lockct) != 0) {
-		spin_unlock(&ccids_lock);
-		yield();
-		spin_lock(&ccids_lock);
-	}
-}
-
-static inline void ccids_write_unlock(void)
-{
-	spin_unlock(&ccids_lock);
-}
+static DEFINE_LW_RWLOCK(ccids_lock);
 
-static inline void ccids_read_lock(void)
-{
-	atomic_inc(&ccids_lockct);
-	spin_unlock_wait(&ccids_lock);
-}
-
-static inline void ccids_read_unlock(void)
-{
-	atomic_dec(&ccids_lockct);
-}
-
-#else
-#define ccids_write_lock() do { } while(0)
-#define ccids_write_unlock() do { } while(0)
-#define ccids_read_lock() do { } while(0)
-#define ccids_read_unlock() do { } while(0)
-#endif
 
 static kmem_cache_t *ccid_kmem_cache_create(int obj_size, const char *fmt,...)
 {
@@ -103,13 +66,13 @@ int ccid_register(struct ccid_operations
 	if (ccid_ops->ccid_hc_tx_slab == NULL)
 		goto out_free_rx_slab;
 
-	ccids_write_lock();
+	lw_write_lock(&ccids_lock);
 	err = -EEXIST;
 	if (ccids[ccid_ops->ccid_id] == NULL) {
 		ccids[ccid_ops->ccid_id] = ccid_ops;
 		err = 0;
 	}
-	ccids_write_unlock();
+	lw_write_unlock(&ccids_lock);
 	if (err != 0)
 		goto out_free_tx_slab;
 
@@ -131,9 +94,9 @@ EXPORT_SYMBOL_GPL(ccid_register);
 
 int ccid_unregister(struct ccid_operations *ccid_ops)
 {
-	ccids_write_lock();
+	lw_write_lock(&ccids_lock);
 	ccids[ccid_ops->ccid_id] = NULL;
-	ccids_write_unlock();
+	lw_write_unlock(&ccids_lock);
 
 	ccid_kmem_cache_destroy(ccid_ops->ccid_hc_tx_slab);
 	ccid_ops->ccid_hc_tx_slab = NULL;
@@ -152,15 +115,15 @@ struct ccid *ccid_new(unsigned char id, 
 	struct ccid_operations *ccid_ops;
 	struct ccid *ccid = NULL;
 
-	ccids_read_lock();
+	lw_read_lock(&ccids_lock);
 #ifdef CONFIG_KMOD
 	if (ccids[id] == NULL) {
 		/* We only try to load if in process context */
-		ccids_read_unlock();
+		lw_read_unlock(&ccids_lock);
 		if (gfp & GFP_ATOMIC)
 			goto out;
 		request_module("net-dccp-ccid-%d", id);
-		ccids_read_lock();
+		lw_read_lock(&ccids_lock);
 	}
 #endif
 	ccid_ops = ccids[id];
@@ -170,7 +133,7 @@ struct ccid *ccid_new(unsigned char id, 
 	if (!try_module_get(ccid_ops->ccid_owner))
 		goto out_unlock;
 
-	ccids_read_unlock();
+	lw_read_unlock(&ccids_lock);
 
 	ccid = kmem_cache_alloc(rx ? ccid_ops->ccid_hc_rx_slab :
 				     ccid_ops->ccid_hc_tx_slab, gfp);
@@ -191,7 +154,7 @@ struct ccid *ccid_new(unsigned char id, 
 out:
 	return ccid;
 out_unlock:
-	ccids_read_unlock();
+	lw_read_unlock(&ccids_lock);
 	goto out;
 out_free_ccid:
 	kmem_cache_free(rx ? ccid_ops->ccid_hc_rx_slab :
@@ -235,10 +198,10 @@ static void ccid_delete(struct ccid *cci
 			ccid_ops->ccid_hc_tx_exit(sk);
 		kmem_cache_free(ccid_ops->ccid_hc_tx_slab,  ccid);
 	}
-	ccids_read_lock();
+	lw_read_lock(&ccids_lock);
 	if (ccids[ccid_ops->ccid_id] != NULL)
 		module_put(ccid_ops->ccid_owner);
-	ccids_read_unlock();
+	lw_read_unlock(&ccids_lock);
 }
 
 void ccid_hc_rx_delete(struct ccid *ccid, struct sock *sk)

--at6+YcpfzWZg/htY--
