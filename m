Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268015AbTBRVR0>; Tue, 18 Feb 2003 16:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268017AbTBRVR0>; Tue, 18 Feb 2003 16:17:26 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:22151 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S268015AbTBRVRX>; Tue, 18 Feb 2003 16:17:23 -0500
Date: Tue, 18 Feb 2003 16:26:56 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Message-Id: <200302182126.h1ILQu4s031623@locutus.cmf.nrl.navy.mil>
To: torvalds@transmeta.com
Subject: [PATCH][2.5] convert atm_dev_lock from spinlock to semaphore
Cc: linux-kernel@vger.kernel.org, mitch@sfgoth.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hello,

this patch changes the atm_dev_lock spinlock to a semaphore.  this
solves the sleeping while holding a spinlock problem.  none of the 
code paths doing the original locking are in_interrupt() so this is
fairly straight forward.

diff -u net/atm.000/addr.c net/atm/addr.c
--- net/atm.000/addr.c	Mon Feb 10 13:37:57 2003
+++ net/atm/addr.c	Sun Feb 16 09:54:12 2003
@@ -42,7 +42,6 @@
  */
 
 static DECLARE_MUTEX(local_lock);
-extern  spinlock_t atm_dev_lock;
 
 static void notify_sigd(struct atm_dev *dev)
 {
diff -u net/atm.000/common.c net/atm/common.c
--- net/atm.000/common.c	Mon Feb 10 13:39:18 2003
+++ net/atm/common.c	Sun Feb 16 09:54:12 2003
@@ -18,6 +18,7 @@
 #include <linux/capability.h>
 #include <linux/mm.h>		/* verify_area */
 #include <linux/sched.h>
+#include <linux/sem.h>
 #include <linux/time.h>		/* struct timeval */
 #include <linux/skbuff.h>
 #include <linux/bitops.h>
@@ -27,6 +28,7 @@
 #include <asm/atomic.h>
 #include <asm/poll.h>
 #include <asm/ioctls.h>
+#include <asm/semaphore.h>
 
 #if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
 #include <linux/atmlec.h>
@@ -79,7 +81,7 @@
 #define DPRINTK(format,args...)
 #endif
 
-spinlock_t atm_dev_lock = SPIN_LOCK_UNLOCKED;
+DECLARE_MUTEX(atm_dev_sem);
 
 static struct sk_buff *alloc_tx(struct atm_vcc *vcc,unsigned int size)
 {
@@ -146,7 +148,7 @@
 				vcc->dev->ops->free_rx_skb(vcc,skb);
 			else kfree_skb(skb);
 		}
-		spin_lock (&atm_dev_lock);	
+		down(&atm_dev_sem);	
 		fops_put (vcc->dev->ops);
 		if (atomic_read(&vcc->rx_inuse))
 			printk(KERN_WARNING "atm_release_vcc: strange ... "
@@ -154,11 +156,11 @@
 			    atomic_read(&vcc->rx_inuse));
 		bind_vcc(vcc,NULL);
 	} else
-		spin_lock (&atm_dev_lock);	
+		down(&atm_dev_sem);	
 
 	if (free_sk) free_atm_vcc_sk(sk);
 
-	spin_unlock (&atm_dev_lock);
+	up(&atm_dev_sem);
 }
 
 
@@ -269,14 +271,14 @@
 	struct atm_dev *dev;
 	int return_val;
 
-	spin_lock (&atm_dev_lock);
+	down(&atm_dev_sem);
 	dev = atm_find_dev(itf);
 	if (!dev)
 		return_val =  -ENODEV;
 	else
 		return_val = atm_do_connect_dev(vcc,dev,vpi,vci);
 
-	spin_unlock (&atm_dev_lock);
+	up(&atm_dev_sem);
 
 	return return_val;
 }
@@ -308,10 +310,10 @@
 	else {
 		struct atm_dev *dev;
 
-		spin_lock (&atm_dev_lock);
+		down(&atm_dev_sem);
 		for (dev = atm_devs; dev; dev = dev->next)
 			if (!atm_do_connect_dev(vcc,dev,vpi,vci)) break;
-		spin_unlock (&atm_dev_lock);
+		up(&atm_dev_sem);
 		if (!dev) return -ENODEV;
 	}
 	if (vpi == ATM_VPI_UNSPEC || vci == ATM_VCI_UNSPEC)
@@ -553,7 +555,7 @@
 	int error,len,size,number, ret_val;
 
 	ret_val = 0;
-	spin_lock (&atm_dev_lock);
+	down(&atm_dev_sem);
 	vcc = ATM_SD(sock);
 	switch (cmd) {
 		case SIOCOUTQ:
@@ -945,7 +947,7 @@
 		ret_val = 0;
 
  done:
-	spin_unlock (&atm_dev_lock); 
+	up(&atm_dev_sem); 
 	return ret_val;
 }
 
diff -u net/atm.000/resources.c net/atm/resources.c
--- net/atm.000/resources.c	Mon Feb 10 13:38:54 2003
+++ net/atm/resources.c	Sun Feb 16 09:58:11 2003
@@ -16,6 +16,8 @@
 #include <linux/module.h>
 #include <linux/bitops.h>
 #include <net/sock.h>	 /* for struct sock */
+#include <linux/sem.h>
+#include <asm/semaphore.h>
 
 #include "common.h"
 #include "resources.h"
@@ -29,9 +31,9 @@
 struct atm_dev *atm_devs = NULL;
 static struct atm_dev *last_dev = NULL;
 struct atm_vcc *nodev_vccs = NULL;
-extern spinlock_t atm_dev_lock;
+extern struct semaphore atm_dev_sem;
 
-/* Caller must hold atm_dev_lock. */
+/* Caller must hold atm_dev_sem. */
 static struct atm_dev *__alloc_atm_dev(const char *type)
 {
 	struct atm_dev *dev;
@@ -56,7 +58,7 @@
 	return dev;
 }
 
-/* Caller must hold atm_dev_lock. */
+/* Caller must hold atm_dev_sem. */
 static void __free_atm_dev(struct atm_dev *dev)
 {
 	if (dev->prev)
@@ -70,7 +72,7 @@
 	kfree(dev);
 }
 
-/* Caller must hold atm_dev_lock. */
+/* Caller must hold atm_dev_sem. */
 struct atm_dev *atm_find_dev(int number)
 {
 	struct atm_dev *dev;
@@ -87,7 +89,7 @@
 {
 	struct atm_dev *dev;
 
-	spin_lock(&atm_dev_lock);
+	down(&atm_dev_sem);
 
 	dev = __alloc_atm_dev(type);
 	if (!dev) {
@@ -131,7 +133,7 @@
 #endif
 
 done:
-	spin_unlock(&atm_dev_lock);
+	up(&atm_dev_sem);
 	return dev;
 }
 
@@ -142,9 +144,9 @@
 	if (dev->ops->proc_read)
 		atm_proc_dev_deregister(dev);
 #endif
-	spin_lock(&atm_dev_lock);
+	down(&atm_dev_sem);
 	__free_atm_dev(dev);
-	spin_unlock(&atm_dev_lock);
+	up(&atm_dev_sem);
 }
 
 void shutdown_atm_dev(struct atm_dev *dev)
diff -u net/atm.000/signaling.c net/atm/signaling.c
--- net/atm.000/signaling.c	Mon Feb 10 13:38:49 2003
+++ net/atm/signaling.c	Sun Feb 16 09:59:12 2003
@@ -13,6 +13,8 @@
 #include <linux/atmsvc.h>
 #include <linux/atmdev.h>
 #include <linux/bitops.h>
+#include <linux/sem.h>
+#include <asm/semaphore.h>
 
 #include "resources.h"
 #include "signaling.h"
@@ -33,7 +35,7 @@
 struct atm_vcc *sigd = NULL;
 static DECLARE_WAIT_QUEUE_HEAD(sigd_sleep);
 
-extern spinlock_t atm_dev_lock;
+extern struct semaphore atm_dev_sem;
 
 static void sigd_put_skb(struct sk_buff *skb)
 {
@@ -220,9 +222,9 @@
 	skb_queue_purge(&vcc->recvq);
 	purge_vccs(nodev_vccs);
 
-	spin_lock (&atm_dev_lock);
+	down(&atm_dev_sem);
 	for (dev = atm_devs; dev; dev = dev->next) purge_vccs(dev->vccs);
-	spin_unlock (&atm_dev_lock);
+	up(&atm_dev_sem);
 }
 
 
