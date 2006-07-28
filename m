Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751985AbWG1QX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbWG1QX3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 12:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751989AbWG1QX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 12:23:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:22422 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751985AbWG1QX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 12:23:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=bbbQngjAX4IGbXXVdVq9oTpWgYw3xzIaI+HGXaqjAmHDwqoPhsKgOwre/CZlrWu6xEhsezJT1DGIWfa5LjEJ/N/xljeBx8FopvCFBav/OcGRlNRl0uBOBNKzofGAvMGHXLpGwHf5DVLLWHDs+HQB0LOh4jiuTHaRqHaoMu2NXvY=
Date: Fri, 28 Jul 2006 18:23:20 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, acme@mandriva.com, marcel@holtmann.org, jet@gyve.org
Subject: [02/04 mm-patch, rfc] Add lightweight rwlock (was Re: [mm-patch] bluetooth: use GFP_ATOMIC in *_sock_create's sk_alloc)
Message-ID: <20060728162320.GB1227@slug>
References: <20060728083532.GA311@slug> <20060728.181756.135980869.jet@gyve.org> <20060728123246.GB311@slug> <20060728.221252.265353941.jet@gyve.org> <20060728161515.GA1227@slug>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
In-Reply-To: <20060728161515.GA1227@slug>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch is part of the lw_rwlock patchset, it removes the
net_family_{read,write}_{lock,unlock} functions which have been moved
to linux/lw_rwlock.h and made more generic.

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="net_socket.c-use-lw_rwlocks.patch"

--- v2.6.18-rc2-mm1~ori/net/socket.c	2006-07-27 11:46:12.000000000 +0200
+++ v2.6.18-rc2-mm1/net/socket.c	2006-07-28 15:50:06.000000000 +0200
@@ -85,6 +85,7 @@
 #include <linux/kmod.h>
 #include <linux/audit.h>
 #include <linux/wireless.h>
+#include <linux/lw_rwlock.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -143,50 +144,7 @@ static struct file_operations socket_fil
 
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
+static DEFINE_LW_RWLOCK(net_family_lock);
 
 /*
  *	Statistics counters of the socket lists
@@ -1125,7 +1083,7 @@ static int __sock_create(int family, int
 	}
 #endif
 
-	net_family_read_lock();
+	lw_read_lock(&net_family_lock);
 	if (net_families[family] == NULL) {
 		err = -EAFNOSUPPORT;
 		goto out;
@@ -1176,7 +1134,7 @@ static int __sock_create(int family, int
 	security_socket_post_create(sock, family, type, protocol, kern);
 
 out:
-	net_family_read_unlock();
+	lw_read_unlock(&net_family_lock);
 	return err;
 out_module_put:
 	module_put(net_families[family]->owner);
@@ -2025,13 +1983,13 @@ int sock_register(struct net_proto_famil
 		printk(KERN_CRIT "protocol %d >= NPROTO(%d)\n", ops->family, NPROTO);
 		return -ENOBUFS;
 	}
-	net_family_write_lock();
+	lw_write_lock(&net_family_lock);
 	err = -EEXIST;
 	if (net_families[ops->family] == NULL) {
 		net_families[ops->family]=ops;
 		err = 0;
 	}
-	net_family_write_unlock();
+	lw_write_unlock(&net_family_lock);
 	printk(KERN_INFO "NET: Registered protocol family %d\n",
 	       ops->family);
 	return err;
@@ -2048,9 +2006,9 @@ int sock_unregister(int family)
 	if (family < 0 || family >= NPROTO)
 		return -1;
 
-	net_family_write_lock();
+	lw_write_lock(&net_family_lock);
 	net_families[family]=NULL;
-	net_family_write_unlock();
+	lw_write_unlock(&net_family_lock);
 	printk(KERN_INFO "NET: Unregistered protocol family %d\n",
 	       family);
 	return 0;

--bKyqfOwhbdpXa4YI--
