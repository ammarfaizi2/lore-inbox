Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWDTOF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWDTOF0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 10:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWDTOF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 10:05:26 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:31251 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1750757AbWDTOFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 10:05:25 -0400
Date: Thu, 20 Apr 2006 16:05:17 +0200
From: Olivier Galibert <galibert@pobox.com>
To: "Hack inc." <linux-kernel@vger.kernel.org>, marcel@holtmann.org,
       maxk@qualcomm.com, bluez-devel@lists.sourceforge.net
Subject: [PATCH] Fix SCO on some bluetooth adapters
Message-ID: <20060420140517.GA72089@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	"Hack inc." <linux-kernel@vger.kernel.org>, marcel@holtmann.org,
	maxk@qualcomm.com, bluez-devel@lists.sf.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some bluetooth adapters return an incorrect number of sco packets in
READ_BUFFER_SIZE.  Add a quirk hook to fix it from the driver side,
and use the hook for a first adapter.

Signed-off-by: Olivier Galibert <galibert@pobox.com>

---

I tried to take Marcel Holtmann's remarks into account, but he seems
unavailable to tell me whether he likes that version, so I'll send it
to the whole shebang instead of just him this time.

The main point was "only the driver knows how to fix the problem",
hence a function pointer quirk hook.  This is definitively not limited
to broadcom USB devices, googling for "SCO MTU 64:0" has interesting
results.

Pavel, '4' doesn't seem to be a value that happens in any correctly
answering adapter, while 8 happens often.  Try "SCO MTU 64:4" and "SCO
MTU 64:8" for comparison.


 drivers/bluetooth/hci_usb.c      |   12 ++++++++++++
 drivers/bluetooth/hci_usb.h      |    1 +
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_event.c        |   16 ++++++++++++++--
 4 files changed, 28 insertions(+), 2 deletions(-)

841d7690e75189803907fbc4616b984087e7f89c
diff --git a/drivers/bluetooth/hci_usb.c b/drivers/bluetooth/hci_usb.c
index 92382e8..0cea36b 100644
--- a/drivers/bluetooth/hci_usb.c
+++ b/drivers/bluetooth/hci_usb.c
@@ -130,6 +130,9 @@ static struct usb_device_id blacklist_id
 	/* CSR BlueCore Bluetooth Sniffer */
 	{ USB_DEVICE(0x0a12, 0x0002), .driver_info = HCI_SNIFFER },
 
+	/* Belkin F8T012 */
+	{ USB_DEVICE(0x050d, 0x0012), .driver_info = HCI_READ_BUFFER_SIZE },
+
 	{ }	/* Terminating entry */
 };
 
@@ -817,6 +820,12 @@ static void hci_usb_notify(struct hci_de
 	BT_DBG("%s evt %d", hdev->name, evt);
 }
 
+static void hci_usb_quirk_read_buffer_size(struct hci_dev *hdev)
+{
+	if (!hdev->sco_pkts)
+		hdev->sco_pkts = 8;
+}
+
 static int hci_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct usb_device *udev = interface_to_usbdev(intf);
@@ -984,6 +993,9 @@ #endif
 
 	if (reset || id->driver_info & HCI_RESET)
 		set_bit(HCI_QUIRK_RESET_ON_INIT, &hdev->quirks);
+
+	if (id->driver_info & HCI_READ_BUFFER_SIZE)
+		hdev->quirk_read_buffer_size = hci_usb_quirk_read_buffer_size;
 
 	if (id->driver_info & HCI_SNIFFER) {
 		if (le16_to_cpu(udev->descriptor.bcdDevice) > 0x997)
diff --git a/drivers/bluetooth/hci_usb.h b/drivers/bluetooth/hci_usb.h
index 37100a6..ea11df7 100644
--- a/drivers/bluetooth/hci_usb.h
+++ b/drivers/bluetooth/hci_usb.h
@@ -35,6 +35,7 @@ #define HCI_CSR			0x08
 #define HCI_SNIFFER		0x10
 #define HCI_BCM92035		0x20
 #define HCI_BROKEN_ISOC		0x40
+#define HCI_READ_BUFFER_SIZE    0x80
 
 #define HCI_MAX_IFACE_NUM	3
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index bb9f81d..045b61f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -134,6 +134,7 @@ struct hci_dev {
 	void (*destruct)(struct hci_dev *hdev);
 	void (*notify)(struct hci_dev *hdev, unsigned int evt);
 	int (*ioctl)(struct hci_dev *hdev, unsigned int cmd, unsigned long arg);
+	void (*quirk_read_buffer_size)(struct hci_dev *hdev);
 };
 
 struct hci_conn {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index eb64555..87358b8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -321,8 +321,20 @@ static void hci_cc_info_param(struct hci
 
 		hdev->acl_mtu  = __le16_to_cpu(bs->acl_mtu);
 		hdev->sco_mtu  = bs->sco_mtu ? bs->sco_mtu : 64;
-		hdev->acl_pkts = hdev->acl_cnt = __le16_to_cpu(bs->acl_max_pkt);
-		hdev->sco_pkts = hdev->sco_cnt = __le16_to_cpu(bs->sco_max_pkt);
+		hdev->acl_pkts = __le16_to_cpu(bs->acl_max_pkt);
+		hdev->sco_pkts = __le16_to_cpu(bs->sco_max_pkt);
+
+		if (hdev->quirk_read_buffer_size)
+			hdev->quirk_read_buffer_size(hdev);
+
+		if (!hdev->acl_mtu || !hdev->sco_mtu || !hdev->acl_pkts || !hdev->sco_pkts) {
+			printk (KERN_WARNING "Your Bluetooth adapter has an incorrect OCF_READ_BUFFER_SIZE reply (%d:%d, %d:%d)\n",
+				hdev->acl_mtu, hdev->acl_pkts, hdev->sco_mtu, hdev->sco_pkts);
+			printk (KERN_WARNING "It won't work correctly.  Please contact Marcel Holtmann <marcel@holtmann.org> with information about your device to try workarounds.\n");
+		}
+				
+		hdev->acl_cnt = hdev->acl_pkts;
+		hdev->sco_cnt = hdev->sco_pkts;
 
 		BT_DBG("%s mtu: acl %d, sco %d max_pkt: acl %d, sco %d", hdev->name,
 			hdev->acl_mtu, hdev->sco_mtu, hdev->acl_pkts, hdev->sco_pkts);
-- 
1.3.0.rc1.g40e9

