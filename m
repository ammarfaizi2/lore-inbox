Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268032AbTBRVWd>; Tue, 18 Feb 2003 16:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268034AbTBRVWc>; Tue, 18 Feb 2003 16:22:32 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:24455 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S268032AbTBRVWH>; Tue, 18 Feb 2003 16:22:07 -0500
Date: Tue, 18 Feb 2003 16:31:55 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Message-Id: <200302182131.h1ILVteg031707@locutus.cmf.nrl.navy.mil>
To: torvalds@transmeta.com
Subject: [PATCH][2.4] convert atm_dev_lock from spinlock to semaphore
Cc: linux-kernel@vger.kernel.org, mitch@sfgoth.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


same as the 2.5 patch just for 2.4 kernels.

Index: net/atm/addr.c
===================================================================
RCS file: /afs/cmf/project/cvsroot/linux/net/atm/addr.c,v
retrieving revision 1.2
retrieving revision 1.3
diff -u -d -b -w -r1.2 -r1.3
--- net/atm/addr.c	5 Mar 2002 13:41:26 -0000	1.2
+++ net/atm/addr.c	14 Feb 2003 17:02:40 -0000	1.3
@@ -42,7 +42,6 @@
  */
 
 static DECLARE_MUTEX(local_lock);
-extern  spinlock_t atm_dev_lock;
 
 static void notify_sigd(struct atm_dev *dev)
 {
Index: net/atm/common.c
===================================================================
RCS file: /afs/cmf/project/cvsroot/linux/net/atm/common.c,v
retrieving revision 1.5
retrieving revision 1.6
diff -u -d -b -w -r1.5 -r1.6
--- net/atm/common.c	14 Feb 2003 16:59:38 -0000	1.5
+++ net/atm/common.c	14 Feb 2003 17:02:40 -0000	1.6
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
@@ -147,7 +149,7 @@
 				vcc->dev->ops->free_rx_skb(vcc,skb);
 			else kfree_skb(skb);
 		}
-		spin_lock (&atm_dev_lock);	
+		down(&atm_dev_sem);	
 		fops_put (vcc->dev->ops);
 		if (atomic_read(&vcc->rx_inuse))
 			printk(KERN_WARNING "atm_release_vcc: strange ... "
@@ -155,11 +157,11 @@
 			    atomic_read(&vcc->rx_inuse));
 		bind_vcc(vcc,NULL);
 	} else
-		spin_lock (&atm_dev_lock);	
+		down(&atm_dev_sem);	
 
 	if (free_sk) free_atm_vcc_sk(sk);
 
-	spin_unlock (&atm_dev_lock);
+	up(&atm_dev_sem);
 }
 
 
@@ -270,14 +272,14 @@
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
@@ -309,10 +311,10 @@
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
@@ -554,7 +556,7 @@
 	int error,len,size,number, ret_val;
 
 	ret_val = 0;
-	spin_lock (&atm_dev_lock);
+	down(&atm_dev_sem);
 	vcc = ATM_SD(sock);
 	switch (cmd) {
 		case SIOCOUTQ:
@@ -1010,7 +1012,7 @@
 		ret_val = 0;
 
  done:
-	spin_unlock (&atm_dev_lock); 
+	up(&atm_dev_sem); 
 	return ret_val;
 }
 
Index: net/atm/resources.c
===================================================================
RCS file: /afs/cmf/project/cvsroot/linux/net/atm/resources.c,v
retrieving revision 1.2
retrieving revision 1.3
diff -u -d -b -w -r1.2 -r1.3
--- net/atm/resources.c	2 May 2002 16:56:23 -0000	1.2
+++ net/atm/resources.c	14 Feb 2003 17:02:40 -0000	1.3
@@ -25,7 +25,7 @@
 struct atm_dev *atm_devs = NULL;
 static struct atm_dev *last_dev = NULL;
 struct atm_vcc *nodev_vccs = NULL;
-extern spinlock_t atm_dev_lock;
+extern struct semaphore atm_dev_sem;
 
 
 static struct atm_dev *alloc_atm_dev(const char *type)
@@ -40,21 +40,21 @@
 	dev->link_rate = ATM_OC3_PCR;
 	dev->next = NULL;
 
-	spin_lock(&atm_dev_lock);
+	down(&atm_dev_sem);
 
 	dev->prev = last_dev;
 
 	if (atm_devs) last_dev->next = dev;
 	else atm_devs = dev;
 	last_dev = dev;
-	spin_unlock(&atm_dev_lock);
+	up(&atm_dev_sem);
 	return dev;
 }
 
 
 static void free_atm_dev(struct atm_dev *dev)
 {
-	spin_lock (&atm_dev_lock);
+	down(&atm_dev_sem);
 	
 	if (dev->prev) dev->prev->next = dev->next;
 	else atm_devs = dev->next;
@@ -62,7 +62,7 @@
 	else last_dev = dev->prev;
 	kfree(dev);
 	
-	spin_unlock (&atm_dev_lock);
+	up(&atm_dev_sem);
 }
 
 
Index: net/atm/signaling.c
===================================================================
RCS file: /afs/cmf/project/cvsroot/linux/net/atm/signaling.c,v
retrieving revision 1.2
retrieving revision 1.3
diff -u -d -b -w -r1.2 -r1.3
--- net/atm/signaling.c	12 Feb 2003 20:57:47 -0000	1.2
+++ net/atm/signaling.c	14 Feb 2003 17:02:40 -0000	1.3
@@ -33,7 +33,7 @@
 struct atm_vcc *sigd = NULL;
 static DECLARE_WAIT_QUEUE_HEAD(sigd_sleep);
 
-extern spinlock_t atm_dev_lock;
+extern struct semaphore atm_dev_sem;
 
 static void sigd_put_skb(struct sk_buff *skb)
 {
@@ -240,9 +240,9 @@
 	skb_queue_purge(&vcc->recvq);
 	purge_vccs(nodev_vccs);
 
-	spin_lock (&atm_dev_lock);
+	down(&atm_dev_sem);
 	for (dev = atm_devs; dev; dev = dev->next) purge_vccs(dev->vccs);
-	spin_unlock (&atm_dev_lock);
+	up(&atm_dev_sem);
 }
 
 
Index: net/atm/svc.c
===================================================================
RCS file: /afs/cmf/project/cvsroot/linux/net/atm/svc.c,v
retrieving revision 1.3
retrieving revision 1.4
diff -u -d -b -w -r1.3 -r1.4
--- net/atm/svc.c	14 Feb 2003 16:59:38 -0000	1.3
+++ net/atm/svc.c	16 Feb 2003 14:42:22 -0000	1.4
@@ -33,8 +33,6 @@
 #define DPRINTK(format,args...)
 #endif
 
-extern spinlock_t atm_dev_lock;
-
 static int svc_create(struct socket *sock,int protocol);
 
 /*
