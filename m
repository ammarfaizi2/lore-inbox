Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVGQO5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVGQO5Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 10:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVGQO5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 10:57:16 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18188 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261294AbVGQO5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 10:57:15 -0400
Date: Sun, 17 Jul 2005 16:57:09 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-devel@lists.sf.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/bluetooth/: cleanups
Message-ID: <20050717145709.GI3613@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- remove BT_DMP/bt_dump
- remove the following unneeded EXPORT_SYMBOL's:
  - hci_core.c: hci_dev_get
  - hci_core.c: hci_send_cmd
  - hci_event.c: hci_si_event

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 5 May 2005

 drivers/bluetooth/hci_bcsp.c      |    2 --
 drivers/bluetooth/hci_h4.c        |    5 -----
 drivers/bluetooth/hci_ldisc.c     |    2 --
 drivers/bluetooth/hci_usb.c       |    2 --
 include/net/bluetooth/bluetooth.h |    8 --------
 net/bluetooth/hci_core.c          |    2 --
 net/bluetooth/hci_event.c         |    1 -
 net/bluetooth/lib.c               |   25 -------------------------
 8 files changed, 47 deletions(-)

--- linux-2.6.12-rc3-mm2-full/net/bluetooth/hci_core.c.old	2005-05-03 10:38:58.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/net/bluetooth/hci_core.c	2005-05-03 10:47:49.000000000 +0200
@@ -299,7 +299,6 @@
 	read_unlock(&hci_dev_list_lock);
 	return hdev;
 }
-EXPORT_SYMBOL(hci_dev_get);
 
 /* ---- Inquiry support ---- */
 static void inquiry_cache_flush(struct hci_dev *hdev)
@@ -1042,7 +1045,6 @@
 
 	return 0;
 }
-EXPORT_SYMBOL(hci_send_cmd);
 
 /* Get data from the previously sent command */
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 ogf, __u16 ocf)
--- linux-2.6.12-rc3-mm2-full/net/bluetooth/hci_event.c.old	2005-05-03 10:48:13.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/net/bluetooth/hci_event.c	2005-05-03 10:48:21.000000000 +0200
@@ -1040,4 +1040,3 @@
 	hci_send_to_sock(hdev, skb);
 	kfree_skb(skb);
 }
-EXPORT_SYMBOL(hci_si_event);

--- linux-2.6.12-rc3-mm3-full/include/net/bluetooth/bluetooth.h.old	2005-05-05 17:36:52.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/include/net/bluetooth/bluetooth.h	2005-05-05 17:40:41.000000000 +0200
@@ -57,12 +57,6 @@
 #define BT_DBG(fmt, arg...)  printk(KERN_INFO "%s: " fmt "\n" , __FUNCTION__ , ## arg)
 #define BT_ERR(fmt, arg...)  printk(KERN_ERR  "%s: " fmt "\n" , __FUNCTION__ , ## arg)
 
-#ifdef HCI_DATA_DUMP
-#define BT_DMP(buf, len) bt_dump(__FUNCTION__, buf, len)
-#else
-#define BT_DMP(D...)
-#endif
-
 extern struct proc_dir_entry *proc_bt;
 
 /* Connection and socket states */
@@ -174,8 +168,6 @@
 	return n;
 }
 
-void bt_dump(char *pref, __u8 *buf, int count);
-
 int bt_err(__u16 code);
 
 #endif /* __BLUETOOTH_H */
--- linux-2.6.12-rc3-mm3-full/net/bluetooth/lib.c.old	2005-05-05 17:37:20.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/net/bluetooth/lib.c	2005-05-05 17:37:30.000000000 +0200
@@ -34,31 +34,6 @@
 
 #include <net/bluetooth/bluetooth.h>
 
-void bt_dump(char *pref, __u8 *buf, int count)
-{
-	char *ptr;
-	char line[100];
-	unsigned int i;
-
-	printk(KERN_INFO "%s: dump, len %d\n", pref, count);
-
-	ptr = line;
-	*ptr = 0;
-	for (i = 0; i < count; i++) {
-		ptr += sprintf(ptr, " %2.2X", buf[i]);
-
-		if (i && !((i + 1) % 20)) {
-			printk(KERN_INFO "%s:%s\n", pref, line);
-			ptr = line;
-			*ptr = 0;
-		}
-	}
-
-	if (line[0])
-		printk(KERN_INFO "%s:%s\n", pref, line);
-}
-EXPORT_SYMBOL(bt_dump);
-
 void baswap(bdaddr_t *dst, bdaddr_t *src)
 {
 	unsigned char *d = (unsigned char *) dst;
--- linux-2.6.12-rc3-mm3-full/drivers/bluetooth/hci_h4.c.old	2005-05-05 17:38:19.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/drivers/bluetooth/hci_h4.c	2005-05-05 17:39:42.000000000 +0200
@@ -57,8 +57,6 @@
 #ifndef CONFIG_BT_HCIUART_DEBUG
 #undef  BT_DBG
 #define BT_DBG( A... )
-#undef  BT_DMP
-#define BT_DMP( A... )
 #endif
 
 /* Initialize protocol */
@@ -125,7 +123,6 @@
 
 	BT_DBG("len %d room %d", len, room);
 	if (!len) {
-		BT_DMP(h4->rx_skb->data, h4->rx_skb->len);
 		hci_recv_frame(h4->rx_skb);
 	} else if (len > room) {
 		BT_ERR("Data length is too large");
@@ -169,8 +166,6 @@
 			case H4_W4_DATA:
 				BT_DBG("Complete data");
 
-				BT_DMP(h4->rx_skb->data, h4->rx_skb->len);
-
 				hci_recv_frame(h4->rx_skb);
 
 				h4->rx_state = H4_W4_PACKET_TYPE;
--- linux-2.6.12-rc3-mm3-full/drivers/bluetooth/hci_ldisc.c.old	2005-05-05 17:38:51.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/drivers/bluetooth/hci_ldisc.c	2005-05-05 17:39:54.000000000 +0200
@@ -57,8 +57,6 @@
 #ifndef CONFIG_BT_HCIUART_DEBUG
 #undef  BT_DBG
 #define BT_DBG( A... )
-#undef  BT_DMP
-#define BT_DMP( A... )
 #endif
 
 static int reset = 0;
--- linux-2.6.12-rc3-mm3-full/drivers/bluetooth/hci_bcsp.c.old	2005-05-05 17:40:04.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/drivers/bluetooth/hci_bcsp.c	2005-05-05 17:40:08.000000000 +0200
@@ -58,8 +58,6 @@
 #ifndef CONFIG_BT_HCIUART_DEBUG
 #undef  BT_DBG
 #define BT_DBG( A... )
-#undef  BT_DMP
-#define BT_DMP( A... )
 #endif
 
 static int hciextn = 1;
--- linux-2.6.12-rc3-mm3-full/drivers/bluetooth/hci_usb.c.old	2005-05-05 17:40:18.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/drivers/bluetooth/hci_usb.c	2005-05-05 17:40:22.000000000 +0200
@@ -57,8 +57,6 @@
 #ifndef CONFIG_BT_HCIUSB_DEBUG
 #undef  BT_DBG
 #define BT_DBG(D...)
-#undef  BT_DMP
-#define BT_DMP(D...)
 #endif
 
 #ifndef CONFIG_BT_HCIUSB_ZERO_PACKET


