Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbUBXA1D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 19:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbUBXA1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 19:27:03 -0500
Received: from linux-bt.org ([217.160.111.169]:7823 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S261863AbUBXA0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 19:26:07 -0500
Subject: Re: Please back out the bluetooth sysfs support
From: Marcel Holtmann <marcel@holtmann.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "David S. Miller" <davem@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040223184525.GA12656@lst.de>
References: <20040223103613.GA5865@lst.de>
	 <20040223101231.71be5da2.davem@redhat.com>
	 <1077560544.2791.63.camel@pegasus>  <20040223184525.GA12656@lst.de>
Content-Type: multipart/mixed; boundary="=-dITZ9rAJdbhI4n5j4X9v"
Message-Id: <1077582336.2880.12.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 24 Feb 2004 01:25:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dITZ9rAJdbhI4n5j4X9v
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Christoph,

> You converted bluetooth to the driver model completely ignoring the
> sysfs-imposed lifetime rules.

I converted all Bluetooth drivers to allocate the hci_dev structure and
it will be freed with the release function of the Bluetooth class.

 drivers/bluetooth/bfusb.c        |   52 ++++++++++++++++++++--------------
 drivers/bluetooth/bluecard_cs.c  |   26 +++++++++++------
 drivers/bluetooth/bt3c_cs.c      |   28 +++++++++++-------
 drivers/bluetooth/btuart_cs.c    |   28 +++++++++++-------
 drivers/bluetooth/dtl1_cs.c      |   26 +++++++++++------
 drivers/bluetooth/hci_bcsp.c     |    2 -
 drivers/bluetooth/hci_h4.c       |    4 +-
 drivers/bluetooth/hci_ldisc.c    |   20 +++++++++----
 drivers/bluetooth/hci_uart.h     |    2 -
 drivers/bluetooth/hci_usb.c      |   59 ++++++++++++++++++++++-----------------
 drivers/bluetooth/hci_usb.h      |    2 -
 drivers/bluetooth/hci_vhci.c     |   25 +++++++++++-----
 drivers/bluetooth/hci_vhci.h     |    2 -
 include/net/bluetooth/hci_core.h |    3 +
 net/bluetooth/hci_core.c         |   21 +++++++++++++
 net/bluetooth/hci_sysfs.c        |    3 +
 net/bluetooth/syms.c             |    2 +
 17 files changed, 201 insertions(+), 104 deletions(-)

The patch looks big, but most of them are simple changes. Please review
it before I am submitting it to Dave.

Regards

Marcel


--=-dITZ9rAJdbhI4n5j4X9v
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

===== drivers/bluetooth/bfusb.c 1.2 vs edited =====
--- 1.2/drivers/bluetooth/bfusb.c	Sun Feb 22 17:49:33 2004
+++ edited/drivers/bluetooth/bfusb.c	Tue Feb 24 00:42:42 2004
@@ -70,7 +70,7 @@
 #define BFUSB_MAX_BULK_RX	2
 
 struct bfusb {
-	struct hci_dev		hdev;
+	struct hci_dev		*hdev;
 
 	unsigned long		state;
 
@@ -155,7 +155,7 @@
 	err = usb_submit_urb(urb, GFP_ATOMIC);
 	if (err) {
 		BT_ERR("%s bulk tx submit failed urb %p err %d", 
-					bfusb->hdev.name, urb, err);
+					bfusb->hdev->name, urb, err);
 		skb_unlink(skb);
 		usb_free_urb(urb);
 	} else
@@ -200,13 +200,13 @@
 
 	atomic_dec(&bfusb->pending_tx);
 
-	if (!test_bit(HCI_RUNNING, &bfusb->hdev.flags))
+	if (!test_bit(HCI_RUNNING, &bfusb->hdev->flags))
 		return;
 
 	if (!urb->status)
-		bfusb->hdev.stat.byte_tx += skb->len;
+		bfusb->hdev->stat.byte_tx += skb->len;
 	else
-		bfusb->hdev.stat.err_tx++;
+		bfusb->hdev->stat.err_tx++;
 
 	read_lock(&bfusb->lock);
 
@@ -250,7 +250,7 @@
 	err = usb_submit_urb(urb, GFP_ATOMIC);
 	if (err) {
 		BT_ERR("%s bulk rx submit failed urb %p err %d",
-					bfusb->hdev.name, urb, err);
+					bfusb->hdev->name, urb, err);
 		skb_unlink(skb);
 		kfree_skb(skb);
 		usb_free_urb(urb);
@@ -264,7 +264,7 @@
 	BT_DBG("bfusb %p hdr 0x%02x data %p len %d", bfusb, hdr, data, len);
 
 	if (hdr & 0x10) {
-		BT_ERR("%s error in block", bfusb->hdev.name);
+		BT_ERR("%s error in block", bfusb->hdev->name);
 		if (bfusb->reassembly)
 			kfree_skb(bfusb->reassembly);
 		bfusb->reassembly = NULL;
@@ -277,13 +277,13 @@
 		int pkt_len = 0;
 
 		if (bfusb->reassembly) {
-			BT_ERR("%s unexpected start block", bfusb->hdev.name);
+			BT_ERR("%s unexpected start block", bfusb->hdev->name);
 			kfree_skb(bfusb->reassembly);
 			bfusb->reassembly = NULL;
 		}
 
 		if (len < 1) {
-			BT_ERR("%s no packet type found", bfusb->hdev.name);
+			BT_ERR("%s no packet type found", bfusb->hdev->name);
 			return -EPROTO;
 		}
 
@@ -295,7 +295,7 @@
 				struct hci_event_hdr *hdr = (struct hci_event_hdr *) data;
 				pkt_len = HCI_EVENT_HDR_SIZE + hdr->plen;
 			} else {
-				BT_ERR("%s event block is too short", bfusb->hdev.name);
+				BT_ERR("%s event block is too short", bfusb->hdev->name);
 				return -EILSEQ;
 			}
 			break;
@@ -305,7 +305,7 @@
 				struct hci_acl_hdr *hdr = (struct hci_acl_hdr *) data;
 				pkt_len = HCI_ACL_HDR_SIZE + __le16_to_cpu(hdr->dlen);
 			} else {
-				BT_ERR("%s data block is too short", bfusb->hdev.name);
+				BT_ERR("%s data block is too short", bfusb->hdev->name);
 				return -EILSEQ;
 			}
 			break;
@@ -315,7 +315,7 @@
 				struct hci_sco_hdr *hdr = (struct hci_sco_hdr *) data;
 				pkt_len = HCI_SCO_HDR_SIZE + hdr->dlen;
 			} else {
-				BT_ERR("%s audio block is too short", bfusb->hdev.name);
+				BT_ERR("%s audio block is too short", bfusb->hdev->name);
 				return -EILSEQ;
 			}
 			break;
@@ -323,17 +323,17 @@
 
 		skb = bt_skb_alloc(pkt_len, GFP_ATOMIC);
 		if (!skb) {
-			BT_ERR("%s no memory for the packet", bfusb->hdev.name);
+			BT_ERR("%s no memory for the packet", bfusb->hdev->name);
 			return -ENOMEM;
 		}
 
-		skb->dev = (void *) &bfusb->hdev;
+		skb->dev = (void *) bfusb->hdev;
 		skb->pkt_type = pkt_type;
 
 		bfusb->reassembly = skb;
 	} else {
 		if (!bfusb->reassembly) {
-			BT_ERR("%s unexpected continuation block", bfusb->hdev.name);
+			BT_ERR("%s unexpected continuation block", bfusb->hdev->name);
 			return -EIO;
 		}
 	}
@@ -359,7 +359,7 @@
 
 	BT_DBG("bfusb %p urb %p skb %p len %d", bfusb, urb, skb, skb->len);
 
-	if (!test_bit(HCI_RUNNING, &bfusb->hdev.flags))
+	if (!test_bit(HCI_RUNNING, &bfusb->hdev->flags))
 		return;
 
 	read_lock(&bfusb->lock);
@@ -367,7 +367,7 @@
 	if (urb->status || !count)
 		goto resubmit;
 
-	bfusb->hdev.stat.byte_rx += count;
+	bfusb->hdev->stat.byte_rx += count;
 
 	skb_put(skb, count);
 
@@ -386,7 +386,7 @@
 
 		if (count < len) {
 			BT_ERR("%s block extends over URB buffer ranges",
-					bfusb->hdev.name);
+					bfusb->hdev->name);
 		}
 
 		if ((hdr & 0xe1) == 0xc1)
@@ -411,7 +411,7 @@
 	err = usb_submit_urb(urb, GFP_ATOMIC);
 	if (err) {
 		BT_ERR("%s bulk resubmit failed urb %p err %d",
-					bfusb->hdev.name, urb, err);
+					bfusb->hdev->name, urb, err);
 	}
 
 	read_unlock(&bfusb->lock);
@@ -698,7 +698,14 @@
 	release_firmware(firmware);
 
 	/* Initialize and register HCI device */
-	hdev = &bfusb->hdev;
+	hdev = hci_alloc_dev();
+	if (!hdev) {
+		BT_ERR("Can't allocate HCI device");
+		goto error;
+	}
+
+	BT_DBG("bfusb %p hdev %p", bfusb, hdev);
+	bfusb->hdev = hdev;
 
 	hdev->type = HCI_USB;
 	hdev->driver_data = bfusb;
@@ -715,6 +722,7 @@
 
 	if (hci_register_dev(hdev) < 0) {
 		BT_ERR("Can't register HCI device");
+		hci_free_dev(hdev);
 		goto error;
 	}
 
@@ -735,7 +743,7 @@
 static void bfusb_disconnect(struct usb_interface *intf)
 {
 	struct bfusb *bfusb = usb_get_intfdata(intf);
-	struct hci_dev *hdev = &bfusb->hdev;
+	struct hci_dev *hdev = bfusb->hdev;
 
 	BT_DBG("intf %p", intf);
 
@@ -748,6 +756,8 @@
 
 	if (hci_unregister_dev(hdev) < 0)
 		BT_ERR("Can't unregister HCI device %s", hdev->name);
+
+	hci_free_dev(hdev);
 }
 
 static struct usb_driver bfusb_driver = {
===== drivers/bluetooth/bluecard_cs.c 1.14 vs edited =====
--- 1.14/drivers/bluetooth/bluecard_cs.c	Mon Jan 19 07:32:49 2004
+++ edited/drivers/bluetooth/bluecard_cs.c	Tue Feb 24 00:18:30 2004
@@ -72,7 +72,7 @@
 	dev_link_t link;
 	dev_node_t node;
 
-	struct hci_dev hdev;
+	struct hci_dev *hdev;
 
 	spinlock_t lock;		/* For serializing operations */
 	struct timer_list timer;	/* For LED control */
@@ -333,7 +333,7 @@
 			skb_queue_head(&(info->txq), skb);
 		}
 
-		info->hdev.stat.byte_tx += len;
+		info->hdev->stat.byte_tx += len;
 
 		/* Change buffer */
 		change_bit(XMIT_BUFFER_NUMBER, &(info->tx_state));
@@ -404,7 +404,7 @@
 
 		if (info->rx_state == RECV_WAIT_PACKET_TYPE) {
 
-			info->rx_skb->dev = (void *)&(info->hdev);
+			info->rx_skb->dev = (void *) info->hdev;
 			info->rx_skb->pkt_type = buf[i];
 
 			switch (info->rx_skb->pkt_type) {
@@ -440,7 +440,7 @@
 			default:
 				/* unknown packet */
 				printk(KERN_WARNING "bluecard_cs: Unknown HCI packet with type 0x%02x received.\n", info->rx_skb->pkt_type);
-				info->hdev.stat.err_rx++;
+				info->hdev->stat.err_rx++;
 
 				kfree_skb(info->rx_skb);
 				info->rx_skb = NULL;
@@ -495,7 +495,7 @@
 
 	}
 
-	info->hdev.stat.byte_rx += len;
+	info->hdev->stat.byte_rx += len;
 }
 
 
@@ -778,8 +778,13 @@
 
 
 	/* Initialize and register HCI device */
+	hdev = hci_alloc_dev();
+	if (!hdev) {
+		printk(KERN_WARNING "bluecard_cs: Can't allocate HCI device.\n");
+		return -ENOMEM;
+	}
 
-	hdev = &(info->hdev);
+	info->hdev = hdev;
 
 	hdev->type = HCI_PCCARD;
 	hdev->driver_data = info;
@@ -794,7 +799,8 @@
 	hdev->owner = THIS_MODULE;
 	
 	if (hci_register_dev(hdev) < 0) {
-		printk(KERN_WARNING "bluecard_cs: Can't register HCI device %s.\n", hdev->name);
+		printk(KERN_WARNING "bluecard_cs: Can't register HCI device.\n");
+		hci_free_dev(hdev);
 		return -ENODEV;
 	}
 
@@ -805,7 +811,7 @@
 int bluecard_close(bluecard_info_t *info)
 {
 	unsigned int iobase = info->link.io.BasePort1;
-	struct hci_dev *hdev = &(info->hdev);
+	struct hci_dev *hdev = info->hdev;
 
 	bluecard_hci_close(hdev);
 
@@ -821,6 +827,8 @@
 	if (hci_unregister_dev(hdev) < 0)
 		printk(KERN_WARNING "bluecard_cs: Can't unregister HCI device %s.\n", hdev->name);
 
+	hci_free_dev(hdev);
+
 	return 0;
 }
 
@@ -988,7 +996,7 @@
 	if (bluecard_open(info) != 0)
 		goto failed;
 
-	strcpy(info->node.dev_name, info->hdev.name);
+	strcpy(info->node.dev_name, info->hdev->name);
 	link->dev = &info->node;
 	link->state &= ~DEV_CONFIG_PENDING;
 
===== drivers/bluetooth/bt3c_cs.c 1.15 vs edited =====
--- 1.15/drivers/bluetooth/bt3c_cs.c	Mon Jan 19 07:32:49 2004
+++ edited/drivers/bluetooth/bt3c_cs.c	Tue Feb 24 00:19:04 2004
@@ -79,7 +79,7 @@
 	dev_link_t link;
 	dev_node_t node;
 
-	struct hci_dev hdev;
+	struct hci_dev *hdev;
 
 	spinlock_t lock;		/* For serializing operations */
 
@@ -227,7 +227,7 @@
 
 		kfree_skb(skb);
 
-		info->hdev.stat.byte_tx += len;
+		info->hdev->stat.byte_tx += len;
 
 	} while (0);
 
@@ -253,7 +253,7 @@
 	bt3c_address(iobase, 0x7480);
 	while (size < avail) {
 		size++;
-		info->hdev.stat.byte_rx++;
+		info->hdev->stat.byte_rx++;
 
 		/* Allocate packet */
 		if (info->rx_skb == NULL) {
@@ -268,7 +268,7 @@
 
 		if (info->rx_state == RECV_WAIT_PACKET_TYPE) {
 
-			info->rx_skb->dev = (void *)&(info->hdev);
+			info->rx_skb->dev = (void *) info->hdev;
 			info->rx_skb->pkt_type = inb(iobase + DATA_L);
 			inb(iobase + DATA_H);
 			//printk("bt3c: PACKET_TYPE=%02x\n", info->rx_skb->pkt_type);
@@ -293,8 +293,8 @@
 			default:
 				/* Unknown packet */
 				printk(KERN_WARNING "bt3c_cs: Unknown HCI packet with type 0x%02x received.\n", info->rx_skb->pkt_type);
-				info->hdev.stat.err_rx++;
-				clear_bit(HCI_RUNNING, &(info->hdev.flags));
+				info->hdev->stat.err_rx++;
+				clear_bit(HCI_RUNNING, &(info->hdev->flags));
 
 				kfree_skb(info->rx_skb);
 				info->rx_skb = NULL;
@@ -534,8 +534,13 @@
 
 
 	/* Initialize and register HCI device */
+	hdev = hci_alloc_dev();
+	if (!hdev) {
+		printk(KERN_WARNING "bt3c_cs: Can't allocate HCI device.\n");
+		return -ENOMEM;
+	}
 
-	hdev = &(info->hdev);
+	info->hdev = hdev;
 
 	hdev->type = HCI_PCCARD;
 	hdev->driver_data = info;
@@ -550,7 +555,8 @@
 	hdev->owner = THIS_MODULE;
 	
 	if (hci_register_dev(hdev) < 0) {
-		printk(KERN_WARNING "bt3c_cs: Can't register HCI device %s.\n", hdev->name);
+		printk(KERN_WARNING "bt3c_cs: Can't register HCI device.\n");
+		hci_free_dev(hdev);
 		return -ENODEV;
 	}
 
@@ -560,13 +566,15 @@
 
 int bt3c_close(bt3c_info_t *info)
 {
-	struct hci_dev *hdev = &(info->hdev);
+	struct hci_dev *hdev = info->hdev;
 
 	bt3c_hci_close(hdev);
 
 	if (hci_unregister_dev(hdev) < 0)
 		printk(KERN_WARNING "bt3c_cs: Can't unregister HCI device %s.\n", hdev->name);
 
+	hci_free_dev(hdev);
+
 	return 0;
 }
 
@@ -781,7 +789,7 @@
 	if (bt3c_open(info) != 0)
 		goto failed;
 
-	strcpy(info->node.dev_name, info->hdev.name);
+	strcpy(info->node.dev_name, info->hdev->name);
 	link->dev = &info->node;
 	link->state &= ~DEV_CONFIG_PENDING;
 
===== drivers/bluetooth/btuart_cs.c 1.10 vs edited =====
--- 1.10/drivers/bluetooth/btuart_cs.c	Mon Jan 19 07:32:49 2004
+++ edited/drivers/bluetooth/btuart_cs.c	Tue Feb 24 00:19:15 2004
@@ -77,7 +77,7 @@
 	dev_link_t link;
 	dev_node_t node;
 
-	struct hci_dev hdev;
+	struct hci_dev *hdev;
 
 	spinlock_t lock;	/* For serializing operations */
 
@@ -181,7 +181,7 @@
 			skb_queue_head(&(info->txq), skb);
 		}
 
-		info->hdev.stat.byte_tx += len;
+		info->hdev->stat.byte_tx += len;
 
 	} while (test_bit(XMIT_WAKEUP, &(info->tx_state)));
 
@@ -202,7 +202,7 @@
 	iobase = info->link.io.BasePort1;
 
 	do {
-		info->hdev.stat.byte_rx++;
+		info->hdev->stat.byte_rx++;
 
 		/* Allocate packet */
 		if (info->rx_skb == NULL) {
@@ -216,7 +216,7 @@
 
 		if (info->rx_state == RECV_WAIT_PACKET_TYPE) {
 
-			info->rx_skb->dev = (void *)&(info->hdev);
+			info->rx_skb->dev = (void *) info->hdev;
 			info->rx_skb->pkt_type = inb(iobase + UART_RX);
 
 			switch (info->rx_skb->pkt_type) {
@@ -239,8 +239,8 @@
 			default:
 				/* Unknown packet */
 				printk(KERN_WARNING "btuart_cs: Unknown HCI packet with type 0x%02x received.\n", info->rx_skb->pkt_type);
-				info->hdev.stat.err_rx++;
-				clear_bit(HCI_RUNNING, &(info->hdev.flags));
+				info->hdev->stat.err_rx++;
+				clear_bit(HCI_RUNNING, &(info->hdev->flags));
 
 				kfree_skb(info->rx_skb);
 				info->rx_skb = NULL;
@@ -529,8 +529,13 @@
 
 
 	/* Initialize and register HCI device */
+	hdev = hci_alloc_dev();
+	if (!hdev) {
+		printk(KERN_WARNING "btuart_cs: Can't allocate HCI device.\n");
+		return -ENOMEM;
+	}
 
-	hdev = &(info->hdev);
+	info->hdev = hdev;
 
 	hdev->type = HCI_PCCARD;
 	hdev->driver_data = info;
@@ -545,7 +550,8 @@
 	hdev->owner = THIS_MODULE;
 	
 	if (hci_register_dev(hdev) < 0) {
-		printk(KERN_WARNING "btuart_cs: Can't register HCI device %s.\n", hdev->name);
+		printk(KERN_WARNING "btuart_cs: Can't register HCI device.\n");
+		hci_free_dev(hdev);
 		return -ENODEV;
 	}
 
@@ -557,7 +563,7 @@
 {
 	unsigned long flags;
 	unsigned int iobase = info->link.io.BasePort1;
-	struct hci_dev *hdev = &(info->hdev);
+	struct hci_dev *hdev = info->hdev;
 
 	btuart_hci_close(hdev);
 
@@ -574,6 +580,8 @@
 	if (hci_unregister_dev(hdev) < 0)
 		printk(KERN_WARNING "btuart_cs: Can't unregister HCI device %s.\n", hdev->name);
 
+	hci_free_dev(hdev);
+
 	return 0;
 }
 
@@ -789,7 +797,7 @@
 	if (btuart_open(info) != 0)
 		goto failed;
 
-	strcpy(info->node.dev_name, info->hdev.name);
+	strcpy(info->node.dev_name, info->hdev->name);
 	link->dev = &info->node;
 	link->state &= ~DEV_CONFIG_PENDING;
 
===== drivers/bluetooth/dtl1_cs.c 1.13 vs edited =====
--- 1.13/drivers/bluetooth/dtl1_cs.c	Mon Jan 19 07:32:49 2004
+++ edited/drivers/bluetooth/dtl1_cs.c	Tue Feb 24 00:18:45 2004
@@ -77,7 +77,7 @@
 	dev_link_t link;
 	dev_node_t node;
 
-	struct hci_dev hdev;
+	struct hci_dev *hdev;
 
 	spinlock_t lock;		/* For serializing operations */
 
@@ -188,7 +188,7 @@
 			skb_queue_head(&(info->txq), skb);
 		}
 
-		info->hdev.stat.byte_tx += len;
+		info->hdev->stat.byte_tx += len;
 
 	} while (test_bit(XMIT_WAKEUP, &(info->tx_state)));
 
@@ -233,7 +233,7 @@
 	iobase = info->link.io.BasePort1;
 
 	do {
-		info->hdev.stat.byte_rx++;
+		info->hdev->stat.byte_rx++;
 
 		/* Allocate packet */
 		if (info->rx_skb == NULL)
@@ -277,7 +277,7 @@
 				case 0x83:
 				case 0x84:
 					/* send frame to the HCI layer */
-					info->rx_skb->dev = (void *)&(info->hdev);
+					info->rx_skb->dev = (void *) info->hdev;
 					info->rx_skb->pkt_type &= 0x0f;
 					hci_recv_frame(info->rx_skb);
 					break;
@@ -508,8 +508,13 @@
 
 
 	/* Initialize and register HCI device */
+	hdev = hci_alloc_dev();
+	if (!hdev) {
+		printk(KERN_WARNING "dtl1_cs: Can't allocate HCI device.\n");
+		return -ENOMEM;
+	}
 
-	hdev = &(info->hdev);
+	info->hdev = hdev;
 
 	hdev->type = HCI_PCCARD;
 	hdev->driver_data = info;
@@ -522,9 +527,10 @@
 	hdev->ioctl = dtl1_hci_ioctl;
 
 	hdev->owner = THIS_MODULE;
-	
+
 	if (hci_register_dev(hdev) < 0) {
-		printk(KERN_WARNING "dtl1_cs: Can't register HCI device %s.\n", hdev->name);
+		printk(KERN_WARNING "dtl1_cs: Can't register HCI device.\n");
+		hci_free_dev(hdev);
 		return -ENODEV;
 	}
 
@@ -536,7 +542,7 @@
 {
 	unsigned long flags;
 	unsigned int iobase = info->link.io.BasePort1;
-	struct hci_dev *hdev = &(info->hdev);
+	struct hci_dev *hdev = info->hdev;
 
 	dtl1_hci_close(hdev);
 
@@ -553,6 +559,8 @@
 	if (hci_unregister_dev(hdev) < 0)
 		printk(KERN_WARNING "dtl1_cs: Can't unregister HCI device %s.\n", hdev->name);
 
+	hci_free_dev(hdev);
+
 	return 0;
 }
 
@@ -741,7 +749,7 @@
 	if (dtl1_open(info) != 0)
 		goto failed;
 
-	strcpy(info->node.dev_name, info->hdev.name);
+	strcpy(info->node.dev_name, info->hdev->name);
 	link->dev = &info->node;
 	link->state &= ~DEV_CONFIG_PENDING;
 
===== drivers/bluetooth/hci_bcsp.c 1.5 vs edited =====
--- 1.5/drivers/bluetooth/hci_bcsp.c	Tue Sep  2 20:08:00 2003
+++ edited/drivers/bluetooth/hci_bcsp.c	Tue Feb 24 00:18:02 2004
@@ -617,7 +617,7 @@
 					bcsp->rx_count = 0;
 					return 0;
 				}
-				bcsp->rx_skb->dev = (void *) &hu->hdev;
+				bcsp->rx_skb->dev = (void *) hu->hdev;
 				break;
 			}
 			break;
===== drivers/bluetooth/hci_h4.c 1.13 vs edited =====
--- 1.13/drivers/bluetooth/hci_h4.c	Tue Sep  2 20:08:00 2003
+++ edited/drivers/bluetooth/hci_h4.c	Tue Feb 24 00:17:34 2004
@@ -229,7 +229,7 @@
 
 		default:
 			BT_ERR("Unknown HCI packet type %2.2x", (__u8)*ptr);
-			hu->hdev.stat.err_rx++;
+			hu->hdev->stat.err_rx++;
 			ptr++; count--;
 			continue;
 		};
@@ -243,7 +243,7 @@
 			h4->rx_count = 0;
 			return 0;
 		}
-		h4->rx_skb->dev = (void *) &hu->hdev;
+		h4->rx_skb->dev = (void *) hu->hdev;
 		h4->rx_skb->pkt_type = type;
 	}
 	return count;
===== drivers/bluetooth/hci_ldisc.c 1.12 vs edited =====
--- 1.12/drivers/bluetooth/hci_ldisc.c	Tue Sep  2 20:08:00 2003
+++ edited/drivers/bluetooth/hci_ldisc.c	Mon Feb 23 23:46:31 2004
@@ -96,7 +96,7 @@
 
 static inline void hci_uart_tx_complete(struct hci_uart *hu, int pkt_type)
 {
-	struct hci_dev *hdev = &hu->hdev;
+	struct hci_dev *hdev = hu->hdev;
 	
 	/* Update HCI stat counters */
 	switch (pkt_type) {
@@ -127,7 +127,7 @@
 int hci_uart_tx_wakeup(struct hci_uart *hu)
 {
 	struct tty_struct *tty = hu->tty;
-	struct hci_dev *hdev = &hu->hdev;
+	struct hci_dev *hdev = hu->hdev;
 	struct sk_buff *skb;
 	
 	if (test_and_set_bit(HCI_UART_SENDING, &hu->tx_state)) {
@@ -306,12 +306,13 @@
 	tty->disc_data = NULL;
 
 	if (hu) {
-		struct hci_dev *hdev = &hu->hdev;
+		struct hci_dev *hdev = hu->hdev;
 		hci_uart_close(hdev);
 
 		if (test_and_clear_bit(HCI_UART_PROTO_SET, &hu->flags)) {
 			hu->proto->close(hu);
 			hci_unregister_dev(hdev);
+			hci_free_dev(hdev);
 		}
 	}
 }
@@ -380,7 +381,7 @@
 	
 	spin_lock(&hu->rx_lock);
 	hu->proto->recv(hu, (void *) data, count);
-	hu->hdev.stat.byte_rx += count;
+	hu->hdev->stat.byte_rx += count;
 	spin_unlock(&hu->rx_lock);
 
 	if (test_and_clear_bit(TTY_THROTTLED,&tty->flags) && tty->driver->unthrottle)
@@ -394,7 +395,13 @@
 	BT_DBG("");
 
 	/* Initialize and register HCI device */
-	hdev = &hu->hdev;
+	hdev = hci_alloc_dev();
+	if (!hdev) {
+		BT_ERR("Can't allocate HCI device");
+		return -ENOMEM;
+	}
+
+	hu->hdev = hdev;
 
 	hdev->type = HCI_UART;
 	hdev->driver_data = hu;
@@ -408,7 +415,8 @@
 	hdev->owner = THIS_MODULE;
 	
 	if (hci_register_dev(hdev) < 0) {
-		BT_ERR("Can't register HCI device %s", hdev->name);
+		BT_ERR("Can't register HCI device");
+		hci_free_dev(hdev);
 		return -ENODEV;
 	}
 
===== drivers/bluetooth/hci_uart.h 1.6 vs edited =====
--- 1.6/drivers/bluetooth/hci_uart.h	Wed Oct 30 06:22:38 2002
+++ edited/drivers/bluetooth/hci_uart.h	Mon Feb 23 22:15:39 2004
@@ -56,7 +56,7 @@
 
 struct hci_uart {
 	struct tty_struct  *tty;
-	struct hci_dev     hdev;
+	struct hci_dev     *hdev;
 	unsigned long      flags;
 
 	struct hci_uart_proto *proto;
===== drivers/bluetooth/hci_usb.c 1.38 vs edited =====
--- 1.38/drivers/bluetooth/hci_usb.c	Sun Feb 22 17:49:34 2004
+++ edited/drivers/bluetooth/hci_usb.c	Tue Feb 24 00:43:05 2004
@@ -165,7 +165,7 @@
 	int err, pipe, interval, size;
 	void *buf;
 
-	BT_DBG("%s", husb->hdev.name);
+	BT_DBG("%s", husb->hdev->name);
 
         size = husb->intr_in_ep->desc.wMaxPacketSize;
 
@@ -189,7 +189,7 @@
 	err = usb_submit_urb(urb, GFP_ATOMIC);
 	if (err) {
 		BT_ERR("%s intr rx submit failed urb %p err %d",
-				husb->hdev.name, urb, err);
+				husb->hdev->name, urb, err);
 		_urb_unlink(_urb);
 		_urb_free(_urb);
 		kfree(buf);
@@ -221,12 +221,12 @@
         usb_fill_bulk_urb(urb, husb->udev, pipe, buf, size, hci_usb_rx_complete, husb);
         urb->transfer_flags = 0;
 
-	BT_DBG("%s urb %p", husb->hdev.name, urb);
+	BT_DBG("%s urb %p", husb->hdev->name, urb);
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
 	if (err) {
 		BT_ERR("%s bulk rx submit failed urb %p err %d",
-				husb->hdev.name, urb, err);
+				husb->hdev->name, urb, err);
 		_urb_unlink(_urb);
 		_urb_free(_urb);
 		kfree(buf);
@@ -270,12 +270,12 @@
 
 	__fill_isoc_desc(urb, size, mtu);
 
-	BT_DBG("%s urb %p", husb->hdev.name, urb);
+	BT_DBG("%s urb %p", husb->hdev->name, urb);
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
 	if (err) {
 		BT_ERR("%s isoc rx submit failed urb %p err %d",
-				husb->hdev.name, urb, err);
+				husb->hdev->name, urb, err);
 		_urb_unlink(_urb);
 		_urb_free(_urb);
 		kfree(buf);
@@ -333,7 +333,7 @@
 {
 	int i;
 
-	BT_DBG("%s", husb->hdev.name);
+	BT_DBG("%s", husb->hdev->name);
 
 	for (i=0; i < 4; i++) {
 		struct _urb *_urb;
@@ -343,7 +343,7 @@
 		while ((_urb = _urb_dequeue(&husb->pending_q[i]))) {
 			urb = &_urb->urb;
 			BT_DBG("%s unlinking _urb %p type %d urb %p", 
-					husb->hdev.name, _urb, _urb->type, urb);
+					husb->hdev->name, _urb, _urb->type, urb);
 			usb_unlink_urb(urb);
 			_urb_queue_tail(__completed_q(husb, _urb->type), _urb);
 		}
@@ -352,7 +352,7 @@
 		while ((_urb = _urb_dequeue(&husb->completed_q[i]))) {
 			urb = &_urb->urb;
 			BT_DBG("%s freeing _urb %p type %d urb %p",
-					husb->hdev.name, _urb, _urb->type, urb);
+					husb->hdev->name, _urb, _urb->type, urb);
 			if (urb->setup_packet)
 				kfree(urb->setup_packet);
 			if (urb->transfer_buffer)
@@ -393,13 +393,13 @@
 	struct urb *urb = &_urb->urb;
 	int err;
 
-	BT_DBG("%s urb %p type %d", husb->hdev.name, urb, _urb->type);
+	BT_DBG("%s urb %p type %d", husb->hdev->name, urb, _urb->type);
 	
 	_urb_queue_tail(__pending_q(husb, _urb->type), _urb);
 	err = usb_submit_urb(urb, GFP_ATOMIC);
 	if (err) {
 		BT_ERR("%s tx submit failed urb %p type %d err %d",
-				husb->hdev.name, urb, _urb->type, err);
+				husb->hdev->name, urb, _urb->type, err);
 		_urb_unlink(_urb);
 		_urb_queue_tail(__completed_q(husb, _urb->type), _urb);
 	} else
@@ -438,7 +438,7 @@
 	usb_fill_control_urb(urb, husb->udev, usb_sndctrlpipe(husb->udev, 0),
 		(void *) dr, skb->data, skb->len, hci_usb_tx_complete, husb);
 
-	BT_DBG("%s skb %p len %d", husb->hdev.name, skb, skb->len);
+	BT_DBG("%s skb %p len %d", husb->hdev->name, skb, skb->len);
 	
 	_urb->priv = skb;
 	return __tx_submit(husb, _urb);
@@ -463,7 +463,7 @@
 			hci_usb_tx_complete, husb);
 	urb->transfer_flags = URB_ZERO_PACKET;
 
-	BT_DBG("%s skb %p len %d", husb->hdev.name, skb, skb->len);
+	BT_DBG("%s skb %p len %d", husb->hdev->name, skb, skb->len);
 
 	_urb->priv = skb;
 	return __tx_submit(husb, _urb);
@@ -482,7 +482,7 @@
 		_urb->type = skb->pkt_type;
 	}
 
-	BT_DBG("%s skb %p len %d", husb->hdev.name, skb, skb->len);
+	BT_DBG("%s skb %p len %d", husb->hdev->name, skb, skb->len);
 
 	urb = &_urb->urb;
 	
@@ -507,7 +507,7 @@
 	struct sk_buff_head *q;
 	struct sk_buff *skb;
 
-	BT_DBG("%s", husb->hdev.name);
+	BT_DBG("%s", husb->hdev->name);
 
 	do {
 		clear_bit(HCI_USB_TX_WAKEUP, &husb->state);
@@ -601,9 +601,9 @@
 
 static inline int __recv_frame(struct hci_usb *husb, int type, void *data, int count)
 {
-	BT_DBG("%s type %d data %p count %d", husb->hdev.name, type, data, count);
+	BT_DBG("%s type %d data %p count %d", husb->hdev->name, type, data, count);
 
-	husb->hdev.stat.byte_rx += count;
+	husb->hdev->stat.byte_rx += count;
 
 	while (count) {
 		struct sk_buff *skb = __reassembly(husb, type);
@@ -643,10 +643,10 @@
 				
 			skb = bt_skb_alloc(len, GFP_ATOMIC);
 			if (!skb) {
-				BT_ERR("%s no memory for the packet", husb->hdev.name);
+				BT_ERR("%s no memory for the packet", husb->hdev->name);
 				return -ENOMEM;
 			}
-			skb->dev = (void *) &husb->hdev;
+			skb->dev = (void *) husb->hdev;
 			skb->pkt_type = type;
 	
 			__reassembly(husb, type) = skb;
@@ -679,7 +679,7 @@
 {
 	struct _urb *_urb = container_of(urb, struct _urb, urb);
 	struct hci_usb *husb = (void *) urb->context;
-	struct hci_dev *hdev = &husb->hdev;
+	struct hci_dev *hdev = husb->hdev;
 	int    err, count = urb->actual_length;
 
 	BT_DBG("%s urb %p type %d status %d count %d flags %x", hdev->name, urb,
@@ -714,7 +714,7 @@
 		err = __recv_frame(husb, _urb->type, urb->transfer_buffer, count);
 		if (err < 0) { 
 			BT_ERR("%s corrupted packet: type %d count %d",
-					husb->hdev.name, _urb->type, count);
+					husb->hdev->name, _urb->type, count);
 			hdev->stat.err_rx++;
 		}
 	}
@@ -732,7 +732,7 @@
 {
 	struct _urb *_urb = container_of(urb, struct _urb, urb);
 	struct hci_usb *husb = (void *) urb->context;
-	struct hci_dev *hdev = &husb->hdev;
+	struct hci_dev *hdev = husb->hdev;
 
 	BT_DBG("%s urb %p status %d flags %x", hdev->name, urb,
 			urb->status, urb->transfer_flags);
@@ -904,9 +904,15 @@
 	}
 
 	/* Initialize and register HCI device */
-	hdev = &husb->hdev;
+	hdev = hci_alloc_dev();
+	if (!hdev) {
+		BT_ERR("Can't allocate HCI device");
+		goto probe_error;
+	}
 
-	hdev->type  = HCI_USB;
+	husb->hdev = hdev;
+
+	hdev->type = HCI_USB;
 	hdev->driver_data = husb;
 	SET_HCIDEV_DEV(hdev, &intf->dev);
 
@@ -920,6 +926,7 @@
 
 	if (hci_register_dev(hdev) < 0) {
 		BT_ERR("Can't register HCI device");
+		hci_free_dev(hdev);
 		goto probe_error;
 	}
 
@@ -936,7 +943,7 @@
 static void hci_usb_disconnect(struct usb_interface *intf)
 {
 	struct hci_usb *husb = usb_get_intfdata(intf);
-	struct hci_dev *hdev = &husb->hdev;
+	struct hci_dev *hdev = husb->hdev;
 
 	if (!husb)
 		return;
@@ -951,6 +958,8 @@
 
 	if (hci_unregister_dev(hdev) < 0)
 		BT_ERR("Can't unregister HCI device %s", hdev->name);
+
+	hci_free_dev(hdev);
 }
 
 static struct usb_driver hci_usb_driver = {
===== drivers/bluetooth/hci_usb.h 1.9 vs edited =====
--- 1.9/drivers/bluetooth/hci_usb.h	Sat Dec 27 19:46:21 2003
+++ edited/drivers/bluetooth/hci_usb.h	Mon Feb 23 22:08:30 2004
@@ -112,7 +112,7 @@
 #endif
 
 struct hci_usb {
-	struct hci_dev		hdev;
+	struct hci_dev		*hdev;
 
 	unsigned long		state;
 	
===== drivers/bluetooth/hci_vhci.c 1.12 vs edited =====
--- 1.12/drivers/bluetooth/hci_vhci.c	Wed Dec 18 03:19:21 2002
+++ edited/drivers/bluetooth/hci_vhci.c	Tue Feb 24 00:16:53 2004
@@ -142,7 +142,7 @@
 		return -EFAULT;
 	}
 
-	skb->dev = (void *) &hci_vhci->hdev;
+	skb->dev = (void *) hci_vhci->hdev;
 	skb->pkt_type = *((__u8 *) skb->data);
 	skb_pull(skb, 1);
 
@@ -175,18 +175,18 @@
 		return -EFAULT;
 	total += len;
 
-	hci_vhci->hdev.stat.byte_tx += len;
+	hci_vhci->hdev->stat.byte_tx += len;
 	switch (skb->pkt_type) {
 		case HCI_COMMAND_PKT:
-			hci_vhci->hdev.stat.cmd_tx++;
+			hci_vhci->hdev->stat.cmd_tx++;
 			break;
 
 		case HCI_ACLDATA_PKT:
-			hci_vhci->hdev.stat.acl_tx++;
+			hci_vhci->hdev->stat.acl_tx++;
 			break;
 
 		case HCI_SCODATA_PKT:
-			hci_vhci->hdev.stat.cmd_tx++;
+			hci_vhci->hdev->stat.cmd_tx++;
 			break;
 	};
 
@@ -275,7 +275,13 @@
 	init_waitqueue_head(&hci_vhci->read_wait);
 
 	/* Initialize and register HCI device */
-	hdev = &hci_vhci->hdev;
+	hdev = hci_alloc_dev();
+	if (!hdev) {
+		kfree(hci_vhci);
+		return -ENOMEM;
+	}
+
+	hci_vhci->hdev = hdev;
 
 	hdev->type = HCI_VHCI;
 	hdev->driver_data = hci_vhci;
@@ -290,6 +296,7 @@
 	
 	if (hci_register_dev(hdev) < 0) {
 		kfree(hci_vhci);
+		hci_free_dev(hdev);
 		return -EBUSY;
 	}
 
@@ -301,9 +308,11 @@
 {
 	struct hci_vhci_struct *hci_vhci = (struct hci_vhci_struct *) file->private_data;
 
-	if (hci_unregister_dev(&hci_vhci->hdev) < 0) {
-		BT_ERR("Can't unregister HCI device %s", hci_vhci->hdev.name);
+	if (hci_unregister_dev(hci_vhci->hdev) < 0) {
+		BT_ERR("Can't unregister HCI device %s", hci_vhci->hdev->name);
 	}
+
+	hci_free_dev(hci_vhci->hdev);
 
 	file->private_data = NULL;
 	return 0;
===== drivers/bluetooth/hci_vhci.h 1.3 vs edited =====
--- 1.3/drivers/bluetooth/hci_vhci.h	Tue Apr 30 16:17:22 2002
+++ edited/drivers/bluetooth/hci_vhci.h	Mon Feb 23 23:09:57 2004
@@ -32,7 +32,7 @@
 #ifdef __KERNEL__
 
 struct hci_vhci_struct {
-	struct hci_dev       hdev;
+	struct hci_dev       *hdev;
 	__u32                flags;
 	wait_queue_head_t    read_wait;
 	struct sk_buff_head  readq;
===== include/net/bluetooth/hci_core.h 1.17 vs edited =====
--- 1.17/include/net/bluetooth/hci_core.h	Sun Feb 22 17:48:16 2004
+++ edited/include/net/bluetooth/hci_core.h	Mon Feb 23 21:49:25 2004
@@ -348,6 +348,9 @@
 
 struct hci_dev *hci_dev_get(int index);
 struct hci_dev *hci_get_route(bdaddr_t *src, bdaddr_t *dst);
+
+struct hci_dev *hci_alloc_dev(void);
+void hci_free_dev(struct hci_dev *hdev);
 int hci_register_dev(struct hci_dev *hdev);
 int hci_unregister_dev(struct hci_dev *hdev);
 int hci_suspend_dev(struct hci_dev *hdev);
===== net/bluetooth/hci_core.c 1.24 vs edited =====
--- 1.24/net/bluetooth/hci_core.c	Sun Feb 22 17:49:30 2004
+++ edited/net/bluetooth/hci_core.c	Mon Feb 23 23:55:17 2004
@@ -762,6 +762,27 @@
 
 /* ---- Interface to HCI drivers ---- */
 
+/* Alloc HCI device */
+struct hci_dev *hci_alloc_dev(void)
+{
+	struct hci_dev *hdev;
+
+	hdev = kmalloc(sizeof(struct hci_dev), GFP_KERNEL);
+	if (!hdev)
+		return NULL;
+
+	memset(hdev, 0, sizeof(struct hci_dev));
+
+	return hdev;
+}
+
+/* Free HCI device */
+void hci_free_dev(struct hci_dev *hdev)
+{
+	/* will free via class release */
+	class_device_put(&hdev->class_dev);
+}
+
 /* Register HCI device */
 int hci_register_dev(struct hci_dev *hdev)
 {
===== net/bluetooth/hci_sysfs.c 1.2 vs edited =====
--- 1.2/net/bluetooth/hci_sysfs.c	Sun Feb 22 17:49:32 2004
+++ edited/net/bluetooth/hci_sysfs.c	Mon Feb 23 22:20:09 2004
@@ -96,6 +96,9 @@
 
 static void bt_release(struct class_device *cdev)
 {
+	struct hci_dev *hdev = class_get_devdata(cdev);
+
+	kfree(hdev);
 }
 
 static struct class bt_class = {
===== net/bluetooth/syms.c 1.9 vs edited =====
--- 1.9/net/bluetooth/syms.c	Tue Jun 17 07:14:45 2003
+++ edited/net/bluetooth/syms.c	Mon Feb 23 21:48:55 2004
@@ -42,6 +42,8 @@
 #include <net/bluetooth/hci_core.h>
 
 /* HCI Core */
+EXPORT_SYMBOL(hci_alloc_dev);
+EXPORT_SYMBOL(hci_free_dev);
 EXPORT_SYMBOL(hci_register_dev);
 EXPORT_SYMBOL(hci_unregister_dev);
 EXPORT_SYMBOL(hci_suspend_dev);

--=-dITZ9rAJdbhI4n5j4X9v--

