Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318254AbSHDWpT>; Sun, 4 Aug 2002 18:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318259AbSHDWpS>; Sun, 4 Aug 2002 18:45:18 -0400
Received: from mail1.qualcomm.com ([129.46.64.223]:36492 "EHLO
	mail1.qualcomm.com") by vger.kernel.org with ESMTP
	id <S318254AbSHDWpP>; Sun, 4 Aug 2002 18:45:15 -0400
Subject: [PATCH] 2.4.19 Bluetooth [1/5] core fixes
From: "Maksim (Max) " Krasnyanskiy <maxk@qualcomm.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, bluez-devel@usw-pr-web.sourceforge.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1028457818.1003.27.camel@champ.qualcomm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.5.99 
Date: 04 Aug 2002 03:47:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, Alan,

Here is another round of Bluetooth updates.

Bluetooth core.

- Device and socket locking fixes

- Fix poll()/select() on connecting socket

- Support for hotplug

- Other minor and trivial fixes

 include/net/bluetooth/hci.h      |   10 +++---
 include/net/bluetooth/hci_core.h |    4 +-
 net/bluetooth/af_bluetooth.c     |   15 ++++++----
 net/bluetooth/hci_conn.c         |    8 ++---
 net/bluetooth/hci_core.c         |   57 ++++++++++++++++++++++++++++-----------
 net/bluetooth/hci_event.c        |   14 +++------
 net/bluetooth/hci_sock.c         |    3 --
 7 files changed, 68 insertions(+), 43 deletions(-)

http://bluez.sourceforge.net/patches/patch-2.4.19-bluetooth-core.gz

Please apply

Max

diff -urN -x 'l2cap*' -x 'sco*' linux.orig/net/bluetooth/af_bluetooth.c linux/net/bluetooth/af_bluetooth.c
--- linux.orig/net/bluetooth/af_bluetooth.c	Sat Aug  3 11:59:47 2002
+++ linux/net/bluetooth/af_bluetooth.c	Sat Aug  3 18:04:31 2002
@@ -25,9 +25,9 @@
 /*
  * BlueZ Bluetooth address family and sockets.
  *
- * $Id: af_bluetooth.c,v 1.6 2002/06/25 22:03:39 maxk Exp $
+ * $Id: af_bluetooth.c,v 1.8 2002/07/22 20:32:54 maxk Exp $
  */
-#define VERSION "2.1"
+#define VERSION "2.2"
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -111,18 +111,18 @@
 
 void bluez_sock_link(struct bluez_sock_list *l, struct sock *sk)
 {
-	write_lock(&l->lock);
+	write_lock_bh(&l->lock);
 	sk->next = l->head;
 	l->head = sk;
 	sock_hold(sk);
-	write_unlock(&l->lock);
+	write_unlock_bh(&l->lock);
 }
 
 void bluez_sock_unlink(struct bluez_sock_list *l, struct sock *sk)
 {
 	struct sock **skp;
 
-	write_lock(&l->lock);
+	write_lock_bh(&l->lock);
 	for (skp = &l->head; *skp; skp = &((*skp)->next)) {
 		if (*skp == sk) {
 			*skp = sk->next;
@@ -130,7 +130,7 @@
 			break;
 		}
 	}
-	write_unlock(&l->lock);
+	write_unlock_bh(&l->lock);
 }
 
 void bluez_accept_enqueue(struct sock *parent, struct sock *sk)
@@ -242,6 +242,9 @@
 	if (sk->state == BT_CLOSED)
 		mask |= POLLHUP;
 
+	if (sk->state == BT_CONNECT || sk->state == BT_CONNECT2)
+		return mask;
+	
 	if (sock_writeable(sk))
 		mask |= POLLOUT | POLLWRNORM | POLLWRBAND;
 	else
diff -urN -x 'l2cap*' -x 'sco*' linux.orig/net/bluetooth/hci_conn.c linux/net/bluetooth/hci_conn.c
--- linux.orig/net/bluetooth/hci_conn.c	Sat Aug  3 11:59:47 2002
+++ linux/net/bluetooth/hci_conn.c	Sat Aug  3 17:22:49 2002
@@ -25,7 +25,7 @@
 /*
  * HCI Connection handling.
  *
- * $Id: hci_conn.c,v 1.3 2002/06/25 22:03:39 maxk Exp $
+ * $Id: hci_conn.c,v 1.5 2002/07/17 18:46:25 maxk Exp $
  */
 
 #include <linux/config.h>
@@ -73,7 +73,7 @@
 	bacpy(&cp.bdaddr, &conn->dst);
 
 	if ((ie = inquiry_cache_lookup(hdev, &conn->dst)) &&
-			inquiry_entry_age(ie) > INQUIRY_ENTRY_AGE_MAX) {
+			inquiry_entry_age(ie) <= INQUIRY_ENTRY_AGE_MAX) {
 		cp.pscan_rep_mode = ie->info.pscan_rep_mode;
 		cp.pscan_mode     = ie->info.pscan_mode;
 		cp.clock_offset   = ie->info.clock_offset | __cpu_to_le16(0x8000);
@@ -217,7 +217,7 @@
 
 	BT_DBG("%s -> %s", batostr(src), batostr(dst));
 
-	spin_lock_bh(&hdev_list_lock);
+	read_lock_bh(&hdev_list_lock);
 
 	list_for_each(p, &hdev_list) {
 		struct hci_dev *d;
@@ -245,7 +245,7 @@
 	if (hdev)
 		hci_dev_hold(hdev);
 
-	spin_unlock_bh(&hdev_list_lock);
+	read_unlock_bh(&hdev_list_lock);
 	return hdev;
 }
 
diff -urN -x 'l2cap*' -x 'sco*' linux.orig/net/bluetooth/hci_core.c linux/net/bluetooth/hci_core.c
--- linux.orig/net/bluetooth/hci_core.c	Sat Aug  3 11:59:47 2002
+++ linux/net/bluetooth/hci_core.c	Sat Aug  3 17:22:50 2002
@@ -25,11 +25,12 @@
 /*
  * BlueZ HCI Core.
  *
- * $Id: hci_core.c,v 1.7 2002/06/25 22:03:39 maxk Exp $
+ * $Id: hci_core.c,v 1.11 2002/07/04 00:25:11 maxk Exp $
  */
 
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/kmod.h>
 
 #include <linux/types.h>
 #include <linux/errno.h>
@@ -66,7 +67,7 @@
 
 /* HCI device list */
 LIST_HEAD(hdev_list);
-spinlock_t hdev_list_lock;
+rwlock_t hdev_list_lock = RW_LOCK_UNLOCKED;
 
 /* HCI protocols */
 #define HCI_MAX_PROTO	2
@@ -93,6 +94,32 @@
 	notifier_call_chain(&hci_notifier, event, hdev);
 }
 
+/* ---- HCI hotplug support ---- */
+
+#ifdef CONFIG_HOTPLUG
+
+static int hci_run_hotplug(char *dev, char *action)
+{
+	char *argv[3], *envp[5], dstr[20], astr[32];
+
+	sprintf(dstr, "DEVICE=%s", dev);
+	sprintf(astr, "ACTION=%s", action);
+
+        argv[0] = hotplug_path;
+        argv[1] = "bluetooth";
+        argv[2] = NULL;
+
+	envp[0] = "HOME=/";
+	envp[1] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
+	envp[2] = dstr;
+	envp[3] = astr;
+	envp[4] = NULL;
+	
+	return call_usermodehelper(argv[0], argv, envp);
+}
+#else
+#define hci_run_hotplug(A...)
+#endif
 
 /* ---- HCI requests ---- */
 
@@ -270,7 +297,7 @@
 	if (index < 0)
 		return NULL;
 
-	spin_lock(&hdev_list_lock);
+	read_lock(&hdev_list_lock);
 	list_for_each(p, &hdev_list) {
 		hdev = list_entry(p, struct hci_dev, list);
 		if (hdev->id == index) {
@@ -280,7 +307,7 @@
 	}
 	hdev = NULL;
 done:
-	spin_unlock(&hdev_list_lock);
+	read_unlock(&hdev_list_lock);
 	return hdev;
 }
 
@@ -699,7 +726,7 @@
 		return -ENOMEM;
 	dr = dl->dev_req;
 
-	spin_lock_bh(&hdev_list_lock);
+	read_lock_bh(&hdev_list_lock);
 	list_for_each(p, &hdev_list) {
 		struct hci_dev *hdev;
 		hdev = list_entry(p, struct hci_dev, list);
@@ -708,7 +735,7 @@
 		if (++n >= dev_num)
 			break;
 	}
-	spin_unlock_bh(&hdev_list_lock);
+	read_unlock_bh(&hdev_list_lock);
 
 	dl->dev_num = n;
 	size = n * sizeof(struct hci_dev_req) + sizeof(__u16);
@@ -768,7 +795,7 @@
 	if (!hdev->open || !hdev->close || !hdev->destruct)
 		return -EINVAL;
 
-	spin_lock_bh(&hdev_list_lock);
+	write_lock_bh(&hdev_list_lock);
 
 	/* Find first available device id */
 	list_for_each(p, &hdev_list) {
@@ -806,12 +833,13 @@
 	memset(&hdev->stat, 0, sizeof(struct hci_dev_stats));
 
 	atomic_set(&hdev->promisc, 0);
-		
-	hci_notify(hdev, HCI_DEV_REG);
 
 	MOD_INC_USE_COUNT;
 
-	spin_unlock_bh(&hdev_list_lock);
+	write_unlock_bh(&hdev_list_lock);
+
+	hci_notify(hdev, HCI_DEV_REG);
+	hci_run_hotplug(hdev->name, "register");
 
 	return id;
 }
@@ -821,13 +849,15 @@
 {
 	BT_DBG("%p name %s type %d", hdev, hdev->name, hdev->type);
 
-	spin_lock_bh(&hdev_list_lock);
+	write_lock_bh(&hdev_list_lock);
 	list_del(&hdev->list);
-	spin_unlock_bh(&hdev_list_lock);
+	write_unlock_bh(&hdev_list_lock);
 
 	hci_dev_do_close(hdev);
 
 	hci_notify(hdev, HCI_DEV_UNREG);
+	hci_run_hotplug(hdev->name, "unregister");
+
 	hci_dev_put(hdev);
 
 	MOD_DEC_USE_COUNT;
@@ -1366,9 +1396,6 @@
 
 int hci_core_init(void)
 {
-	/* Init locks */
-	spin_lock_init(&hdev_list_lock);
-
 	return 0;
 }
 
diff -urN -x 'l2cap*' -x 'sco*' linux.orig/net/bluetooth/hci_event.c linux/net/bluetooth/hci_event.c
--- linux.orig/net/bluetooth/hci_event.c	Sat Aug  3 11:59:47 2002
+++ linux/net/bluetooth/hci_event.c	Sat Aug  3 17:22:50 2002
@@ -25,7 +25,7 @@
 /*
  * HCI Events.
  *
- * $Id: hci_event.c,v 1.3 2002/04/17 17:37:16 maxk Exp $
+ * $Id: hci_event.c,v 1.4 2002/07/27 18:14:38 maxk Exp $
  */
 
 #include <linux/config.h>
@@ -352,16 +352,12 @@
 			hci_dev_lock(hdev);
 	
 			acl = conn_hash_lookup_handle(hdev, handle);
-			if (!acl || !(sco = acl->link)) {
-				hci_dev_unlock(hdev);
-				break;
+			if (acl && (sco = acl->link)) {
+				sco->state = BT_CLOSED;
+				hci_proto_connect_cfm(sco, status);
+				hci_conn_del(sco);
 			}
 
-			sco->state = BT_CLOSED;
-
-			hci_proto_connect_cfm(sco, status);
-			hci_conn_del(sco);
-
 			hci_dev_unlock(hdev);
 		}
 		break;
diff -urN -x 'l2cap*' -x 'sco*' linux.orig/net/bluetooth/hci_sock.c linux/net/bluetooth/hci_sock.c
--- linux.orig/net/bluetooth/hci_sock.c	Sat Aug  3 11:59:47 2002
+++ linux/net/bluetooth/hci_sock.c	Sat Aug  3 17:22:51 2002
@@ -25,7 +25,7 @@
 /*
  * BlueZ HCI socket layer.
  *
- * $Id: hci_sock.c,v 1.4 2002/04/18 22:26:14 maxk Exp $
+ * $Id: hci_sock.c,v 1.5 2002/07/22 20:32:54 maxk Exp $
  */
 
 #include <linux/config.h>
@@ -129,7 +129,6 @@
 
 		if (sock_queue_rcv_skb(sk, nskb))
 			kfree_skb(nskb);
-		
 	}
 	read_unlock(&hci_sk_list.lock);
 }
diff -urN linux.orig/include/net/bluetooth/hci.h linux/include/net/bluetooth/hci.h
--- linux.orig/include/net/bluetooth/hci.h	Sat Aug  3 11:59:47 2002
+++ linux/include/net/bluetooth/hci.h	Sat Aug  3 17:23:14 2002
@@ -23,7 +23,7 @@
 */
 
 /*
- *  $Id: hci.h,v 1.4 2002/04/18 22:26:15 maxk Exp $
+ *  $Id: hci.h,v 1.5 2002/06/27 17:29:30 maxk Exp $
  */
 
 #ifndef __HCI_H
@@ -113,10 +113,10 @@
 #define ACL_PTYPE_MASK	(~SCO_PTYPE_MASK)
 
 /* ACL flags */
-#define ACL_CONT		0x0001
-#define ACL_START		0x0002
-#define ACL_ACTIVE_BCAST	0x0010
-#define ACL_PICO_BCAST		0x0020
+#define ACL_CONT		0x01
+#define ACL_START		0x02
+#define ACL_ACTIVE_BCAST	0x04
+#define ACL_PICO_BCAST		0x08
 
 /* Baseband links */
 #define SCO_LINK	0x00
diff -urN linux.orig/include/net/bluetooth/hci_core.h linux/include/net/bluetooth/hci_core.h
--- linux.orig/include/net/bluetooth/hci_core.h	Sat Aug  3 11:59:47 2002
+++ linux/include/net/bluetooth/hci_core.h	Sat Aug  3 17:23:15 2002
@@ -23,7 +23,7 @@
 */
 
 /* 
- * $Id: hci_core.h,v 1.4 2002/06/25 22:04:43 maxk Exp $ 
+ * $Id: hci_core.h,v 1.5 2002/06/27 04:56:30 maxk Exp $ 
  */
 
 #ifndef __HCI_CORE_H
@@ -149,7 +149,7 @@
 
 extern struct hci_proto *hci_proto[];
 extern struct list_head hdev_list;
-extern spinlock_t hdev_list_lock;
+extern rwlock_t hdev_list_lock;
 
 /* ----- Inquiry cache ----- */
 #define INQUIRY_CACHE_AGE_MAX   (HZ*30)   // 30 seconds

