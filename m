Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271530AbRHPIt4>; Thu, 16 Aug 2001 04:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271529AbRHPItr>; Thu, 16 Aug 2001 04:49:47 -0400
Received: from topic-gw2.topic.com.au ([203.37.31.2]:20472 "HELO
	mailhost.topic.com.au") by vger.kernel.org with SMTP
	id <S271527AbRHPIte>; Thu, 16 Aug 2001 04:49:34 -0400
Date: Thu, 16 Aug 2001 18:49:38 +1000
From: Jason Thomas <jason@topic.com.au>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] patch's for vmware 2.0.4 for use with linux-2.4.8 kernel
Message-ID: <20010816184937.E742@topic.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="udcq9yAoWb9A4FsZ"
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--udcq9yAoWb9A4FsZ
Content-Type: multipart/mixed; boundary="KlAEzMkarCnErv5Q"
Content-Disposition: inline


--KlAEzMkarCnErv5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

attached are two very small patches for those that want them. they make
vmware's kernel modules compile with 2.4.8.  Its not all my work, its a
combination of what was posted a while back and my work.

--=20
Jason Thomas                           Phone:  +61 2 6257 7111
System Administrator  -  UID 0         Fax:    +61 2 6257 7311
tSA Consulting Group Pty. Ltd.         Mobile: 0418 29 66 81
1 Hall Street Lyneham ACT 2602         http://www.topic.com.au/

--KlAEzMkarCnErv5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="vmnet-only-2.4.8.patch"
Content-Transfer-Encoding: quoted-printable

diff -ru vmnet-only.orig/bridge.c vmnet-only/bridge.c
--- vmnet-only.orig/bridge.c	Thu May 10 11:33:58 2001
+++ vmnet-only/bridge.c	Thu Aug 16 17:33:07 2001
@@ -19,7 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/version.h>
 #include <linux/sched.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #ifdef KERNEL_2_1
 #include <linux/poll.h>
 #include <asm/uaccess.h>
@@ -44,7 +44,7 @@
 #include "vnetInt.h"
=20
=20
-#define VNET_BRIDGE_HISTORY    8
+#define VNET_BRIDGE_HISTORY    48
=20
 typedef struct VNetBridge VNetBridge;
=20
@@ -58,6 +58,7 @@
    Bool                     savedPromisc;
    struct sk_buff          *history[VNET_BRIDGE_HISTORY];
    VNetPort                 port;
+   spinlock_t		    historyLock;
 };
=20
=20
@@ -130,6 +131,7 @@
       goto out;
    }
    memset(bridge, 0, sizeof *bridge);
+   spin_lock_init(&bridge->historyLock);
    memcpy(bridge->name, devName, sizeof bridge->name);
=20
    /*
@@ -391,6 +393,8 @@
 	 unsigned long flags;
 	 int i;
 	 SKB_INCREF(clone);
+	=20
+	 spin_lock_irqsave(&bridge->historyLock, flags);
 	 // XXX need to lock history
 	 for (i =3D 0; i < VNET_BRIDGE_HISTORY; i++) {
 	    if (bridge->history[i] =3D=3D NULL) {
@@ -417,11 +421,15 @@
 	    for (i =3D 0; i < VNET_BRIDGE_HISTORY; i++) {
 	       struct sk_buff *s =3D bridge->history[i];
 	       bridge->history[i] =3D NULL;
-	       KFREE_SKB(s, FREE_WRITE);
+	       if (s) {
+	       	  spin_unlock_irqrestore(&bridge->historyLock, flags);
+		  KFREE_SKB(s, FREE_WRITE);
+		  spin_lock_irqsave(&bridge->historyLock, flags);
+	       }
 	    }
 	    bridge->history[0] =3D clone;
 	 }
-        =20
+         spin_unlock_irqrestore(&bridge->historyLock, flags);
 	 clone->dev =3D dev;
 	 clone->protocol =3D eth_type_trans(clone, dev);
 	 save_flags(flags);
@@ -773,6 +781,7 @@
 {
    VNetBridge *bridge =3D *(VNetBridge**)&((struct sock *)pt->data)->proti=
nfo;
    int i;
+   unsigned long flags;
=20
    if (bridge->dev =3D=3D NULL) {
       LOG(3, (KERN_DEBUG "bridge-%s: received %d closed\n",
@@ -782,11 +791,13 @@
    }
=20
    // XXX need to lock history
+   spin_lock_irqsave(&bridge->historyLock, flags);
    for (i =3D 0; i < VNET_BRIDGE_HISTORY; i++) {
       struct sk_buff *s =3D bridge->history[i];
       if (s !=3D NULL &&
 	  (s =3D=3D skb || SKB_IS_CLONE_OF(skb, s))) {
 	 bridge->history[i] =3D NULL;
+	 spin_unlock_irqrestore(&bridge->historyLock, flags);
 	 KFREE_SKB(s, FREE_WRITE);
 	 LOG(3, (KERN_DEBUG "bridge-%s: receive %d self %d\n",
 		 bridge->name, (int) skb->len, i));
@@ -795,6 +806,7 @@
 	 return 0;
       }
    }
+   spin_unlock_irqrestore(&bridge->historyLock, flags);
=20
 #  if LOGLEVEL >=3D 4
    {
diff -ru vmnet-only.orig/driver.c vmnet-only/driver.c
--- vmnet-only.orig/driver.c	Thu May 10 11:33:58 2001
+++ vmnet-only/driver.c	Thu Aug 16 17:33:13 2001
@@ -20,7 +20,7 @@
 #include <linux/module.h>
 #include <linux/version.h>
 #include <linux/sched.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #ifdef KERNEL_2_1
 #include <linux/poll.h>
 #include <asm/uaccess.h>
diff -ru vmnet-only.orig/hub.c vmnet-only/hub.c
--- vmnet-only.orig/hub.c	Thu May 10 11:33:58 2001
+++ vmnet-only/hub.c	Thu Aug 16 17:33:57 2001
@@ -19,7 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/version.h>
 #include <linux/sched.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #ifdef KERNEL_2_1
 #include <linux/poll.h>
 #include <asm/uaccess.h>
diff -ru vmnet-only.orig/netif.c vmnet-only/netif.c
--- vmnet-only.orig/netif.c	Thu May 10 11:33:58 2001
+++ vmnet-only/netif.c	Thu Aug 16 17:33:21 2001
@@ -19,7 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/version.h>
 #include <linux/sched.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #ifdef KERNEL_2_1
 #include <linux/poll.h>
 #include <asm/uaccess.h>
diff -ru vmnet-only.orig/procfs.c vmnet-only/procfs.c
--- vmnet-only.orig/procfs.c	Thu May 10 11:33:58 2001
+++ vmnet-only/procfs.c	Thu Aug 16 17:33:27 2001
@@ -19,7 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/version.h>
 #include <linux/sched.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #ifdef KERNEL_2_1
 #include <linux/poll.h>
 #include <asm/uaccess.h>
diff -ru vmnet-only.orig/userif.c vmnet-only/userif.c
--- vmnet-only.orig/userif.c	Thu May 10 11:33:58 2001
+++ vmnet-only/userif.c	Thu Aug 16 17:33:33 2001
@@ -19,7 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/version.h>
 #include <linux/sched.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #ifdef KERNEL_2_1
 #include <linux/poll.h>
 #include <asm/uaccess.h>

--KlAEzMkarCnErv5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="vmmon-only-2.4.8.patch"
Content-Transfer-Encoding: quoted-printable

diff -ru vmmon-only.orig/linux/driver.c vmmon-only/linux/driver.c
--- vmmon-only.orig/linux/driver.c	Thu May 10 11:33:58 2001
+++ vmmon-only/linux/driver.c	Thu Aug 16 17:55:29 2001
@@ -9,6 +9,7 @@
 #endif=20
=20
 #include "driver-config.h"
+#include "hostif.h"
=20
 #ifdef KERNEL_2_1
 #define EXPORT_SYMTAB
@@ -19,7 +20,7 @@
 #include <linux/module.h>
 #include <linux/version.h>
 #include <linux/sched.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
=20
 #ifdef __SMP__
 #include <linux/smp.h>
@@ -925,7 +926,7 @@
 	  current->fsuid =3D=3D current->uid &&
           current->egid =3D=3D current->gid &&
 	  current->fsgid =3D=3D current->gid) {
-	 current->dumpable =3D 1;
+	 current->mm->dumpable =3D 1;
       }
       break;
=20
diff -ru vmmon-only.orig/linux/hostif.c vmmon-only/linux/hostif.c
--- vmmon-only.orig/linux/hostif.c	Thu May 10 11:33:58 2001
+++ vmmon-only/linux/hostif.c	Thu Aug 16 17:35:37 2001
@@ -22,7 +22,7 @@
 #include <linux/binfmts.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
=20
 #ifdef KERNEL_2_1
 #  ifdef KERNEL_2_3_25

--KlAEzMkarCnErv5Q--

--udcq9yAoWb9A4FsZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7e4kh7cYwRJJSiL4RAnTdAJ9nHGTLvKz/UKsGQWrkqpjz86jvFACdHfX6
j8HdofYRgV8q6sf/2cDZiHo=
=knia
-----END PGP SIGNATURE-----

--udcq9yAoWb9A4FsZ--
