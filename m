Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161203AbWHJMNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161203AbWHJMNn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 08:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161204AbWHJMNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 08:13:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:17159 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161203AbWHJMNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 08:13:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=geo0Y1kz+59GxWDwUDbPsSUokfcFKpuNhqSJfqIuXUheCEpMkB5bnC4yMT5t3tG9Sl6FG7dG/q4q9fVLwSBBq0vvuAdTaocD0LFkLZ4KVnhpKkJlemkgjW2okxQAIqo1H888jdCfIjxvktTgUPIZ5FBbyXwQ/qtFfir3pcFl404=
Date: Thu, 10 Aug 2006 14:13:36 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, acme@ghostprotocols.net, davem@davemloft.net,
       jet@gyve.org
Subject: [patch] Use rwsems instead of custom locking scheme in net/socket.c and net/dccp/ccid.c
Message-ID: <20060810121336.GB1462@slug>
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060806030809.2cfb0b1e.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2006 at 03:08:09AM -0700, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/
> 
Hi Andrew,

This patch aims at removing two implementations (spotted by Masatake YAMATO) of
pseudo-rwlocks using a spinlock_t and an atomic_t. One in net/socket.c
and another in net/bluetooth/af_bluetooth.c. I think that both could be
converted to rwsems, saving some lines of code.

Regards,
Frederik


Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

 net/dccp/ccid.c |   63 ++++++++++++------------------------------------------------
 net/socket.c    |   58 +++++++------------------------------------------------
 2 files changed, 21 insertions(+), 100 deletions(-)

diff --git a/net/dccp/ccid.c b/net/dccp/ccid.c
--- a/net/dccp/ccid.c
+++ b/net/dccp/ccid.c
@@ -12,48 +12,11 @@
  */
 
 #include "ccid.h"
+#include <linux/rwsem.h>
 
 static struct ccid_operations *ccids[CCID_MAX];
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
-static atomic_t ccids_lockct = ATOMIC_INIT(0);
-static DEFINE_SPINLOCK(ccids_lock);
+static DECLARE_RWSEM(ccids_sem);
 
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
-
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
+	down_write(&ccids_sem);
 	err = -EEXIST;
 	if (ccids[ccid_ops->ccid_id] == NULL) {
 		ccids[ccid_ops->ccid_id] = ccid_ops;
 		err = 0;
 	}
-	ccids_write_unlock();
+	up_write(&ccids_sem);
 	if (err != 0)
 		goto out_free_tx_slab;
 
@@ -131,9 +94,9 @@ EXPORT_SYMBOL_GPL(ccid_register);
 
 int ccid_unregister(struct ccid_operations *ccid_ops)
 {
-	ccids_write_lock();
+	down_write(&ccids_sem);
 	ccids[ccid_ops->ccid_id] = NULL;
-	ccids_write_unlock();
+	up_write(&ccids_sem);
 
 	ccid_kmem_cache_destroy(ccid_ops->ccid_hc_tx_slab);
 	ccid_ops->ccid_hc_tx_slab = NULL;
@@ -152,15 +115,15 @@ struct ccid *ccid_new(unsigned char id, 
 	struct ccid_operations *ccid_ops;
 	struct ccid *ccid = NULL;
 
-	ccids_read_lock();
+	down_read(&ccids_sem);
 #ifdef CONFIG_KMOD
 	if (ccids[id] == NULL) {
 		/* We only try to load if in process context */
-		ccids_read_unlock();
+		up_read(&ccids_sem);
 		if (gfp & GFP_ATOMIC)
 			goto out;
 		request_module("net-dccp-ccid-%d", id);
-		ccids_read_lock();
+		down_read(&ccids_sem);
 	}
 #endif
 	ccid_ops = ccids[id];
@@ -170,7 +133,7 @@ #endif
 	if (!try_module_get(ccid_ops->ccid_owner))
 		goto out_unlock;
 
-	ccids_read_unlock();
+	up_read(&ccids_sem);
 
 	ccid = kmem_cache_alloc(rx ? ccid_ops->ccid_hc_rx_slab :
 				     ccid_ops->ccid_hc_tx_slab, gfp);
@@ -191,7 +154,7 @@ #endif
 out:
 	return ccid;
 out_unlock:
-	ccids_read_unlock();
+	up_read(&ccids_sem);
 	goto out;
 out_free_ccid:
 	kmem_cache_free(rx ? ccid_ops->ccid_hc_rx_slab :
@@ -235,10 +198,10 @@ static void ccid_delete(struct ccid *cci
 			ccid_ops->ccid_hc_tx_exit(sk);
 		kmem_cache_free(ccid_ops->ccid_hc_tx_slab,  ccid);
 	}
-	ccids_read_lock();
+	down_read(&ccids_sem);
 	if (ccids[ccid_ops->ccid_id] != NULL)
 		module_put(ccid_ops->ccid_owner);
-	ccids_read_unlock();
+	up_read(&ccids_sem);
 }
 
 void ccid_hc_rx_delete(struct ccid *ccid, struct sock *sk)
diff --git a/net/socket.c b/net/socket.c
index 53cb85b..bc52aeb 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -85,6 +85,7 @@ #include <linux/compat.h>
 #include <linux/kmod.h>
 #include <linux/audit.h>
 #include <linux/wireless.h>
+#include <linux/rwsem.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -143,50 +144,7 @@ #endif
 
 static struct net_proto_family *net_families[NPROTO];
 
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
-static atomic_t net_family_lockct = ATOMIC_INIT(0);
-static DEFINE_SPINLOCK(net_family_lock);
-
-/* The strategy is: modifications net_family vector are short, do not
-   sleep and veeery rare, but read access should be free of any exclusive
-   locks.
- */
-
-static void net_family_write_lock(void)
-{
-	spin_lock(&net_family_lock);
-	while (atomic_read(&net_family_lockct) != 0) {
-		spin_unlock(&net_family_lock);
-
-		yield();
-
-		spin_lock(&net_family_lock);
-	}
-}
-
-static __inline__ void net_family_write_unlock(void)
-{
-	spin_unlock(&net_family_lock);
-}
-
-static __inline__ void net_family_read_lock(void)
-{
-	atomic_inc(&net_family_lockct);
-	spin_unlock_wait(&net_family_lock);
-}
-
-static __inline__ void net_family_read_unlock(void)
-{
-	atomic_dec(&net_family_lockct);
-}
-
-#else
-#define net_family_write_lock() do { } while(0)
-#define net_family_write_unlock() do { } while(0)
-#define net_family_read_lock() do { } while(0)
-#define net_family_read_unlock() do { } while(0)
-#endif
-
+static DECLARE_RWSEM(net_family_sem);
 
 /*
  *	Statistics counters of the socket lists
@@ -1132,7 +1090,7 @@ #if defined(CONFIG_KMOD)
 	}
 #endif
 
-	net_family_read_lock();
+	down_read(&net_family_sem);
 	if (net_families[family] == NULL) {
 		err = -EAFNOSUPPORT;
 		goto out;
@@ -1185,7 +1143,7 @@ #endif
 		goto out_release;
 
 out:
-	net_family_read_unlock();
+	up_read(&net_family_sem);
 	return err;
 out_module_put:
 	module_put(net_families[family]->owner);
@@ -2034,13 +1992,13 @@ int sock_register(struct net_proto_famil
 		printk(KERN_CRIT "protocol %d >= NPROTO(%d)\n", ops->family, NPROTO);
 		return -ENOBUFS;
 	}
-	net_family_write_lock();
+	down_write(&net_family_sem);
 	err = -EEXIST;
 	if (net_families[ops->family] == NULL) {
 		net_families[ops->family]=ops;
 		err = 0;
 	}
-	net_family_write_unlock();
+	up_write(&net_family_sem);
 	printk(KERN_INFO "NET: Registered protocol family %d\n",
 	       ops->family);
 	return err;
@@ -2057,9 +2015,9 @@ int sock_unregister(int family)
 	if (family < 0 || family >= NPROTO)
 		return -1;
 
-	net_family_write_lock();
+	down_write(&net_family_sem);
 	net_families[family]=NULL;
-	net_family_write_unlock();
+	up_write(&net_family_sem);
 	printk(KERN_INFO "NET: Unregistered protocol family %d\n",
 	       family);
 	return 0;
