Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318262AbSHDXFc>; Sun, 4 Aug 2002 19:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318263AbSHDXFc>; Sun, 4 Aug 2002 19:05:32 -0400
Received: from mail1.qualcomm.com ([129.46.64.223]:16793 "EHLO
	mail1.qualcomm.com") by vger.kernel.org with ESMTP
	id <S318262AbSHDXF1>; Sun, 4 Aug 2002 19:05:27 -0400
Subject: [PATCH] 2.4.19 Bluetooth [4/5] HCI USB driver update
From: "Maksim (Max) " Krasnyanskiy <maxk@qualcomm.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, bluez-devel@usw-pr-web.sourceforge.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1028459281.1003.54.camel@champ.qualcomm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.5.99 
Date: 04 Aug 2002 04:08:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HCI USB driver updates.

- Module refcounting fixes

- Firmware loading is now entirely in hotplug.
  Remove usermod_helper calls.

- Support for device id black list.
  Don't claim devices without firmware. 

 Documentation/Configure.help |   11 ----
 drivers/bluetooth/Config.in  |    1 
 drivers/bluetooth/hci_usb.c  |  109 ++++++++++---------------------------------
 3 files changed, 28 insertions(+), 93 deletions(-)

http://bluez.sourceforge.net/patches/patch-2.4.19-bluetooth-hciusb.gz

Please apply

Max

diff -urN linux.orig/drivers/bluetooth/Config.in linux/drivers/bluetooth/Config.in
--- linux.orig/drivers/bluetooth/Config.in	Sat Aug  3 11:59:42 2002
+++ linux/drivers/bluetooth/Config.in	Sat Aug  3 17:27:56 2002
@@ -3,7 +3,6 @@
 
 dep_tristate 'HCI USB driver' CONFIG_BLUEZ_HCIUSB $CONFIG_BLUEZ $CONFIG_USB
 if [ "$CONFIG_BLUEZ_HCIUSB" != "n" ]; then
-   bool '  Firmware download support'  CONFIG_BLUEZ_USB_FW_LOAD
    bool '  USB zero packet support'  CONFIG_BLUEZ_USB_ZERO_PACKET
 fi
 
diff -urN linux.orig/drivers/bluetooth/hci_usb.c linux/drivers/bluetooth/hci_usb.c
--- linux.orig/drivers/bluetooth/hci_usb.c	Sat Aug  3 11:59:42 2002
+++ linux/drivers/bluetooth/hci_usb.c	Sat Aug  3 18:23:25 2002
@@ -28,9 +28,9 @@
  *    Copyright (c) 2000 Greg Kroah-Hartman        <greg@kroah.com>
  *    Copyright (c) 2000 Mark Douglas Corner       <mcorner@umich.edu>
  *
- * $Id: hci_usb.c,v 1.6 2002/04/17 17:37:20 maxk Exp $    
+ * $Id: hci_usb.c,v 1.8 2002/07/18 17:23:09 maxk Exp $    
  */
-#define VERSION "2.0"
+#define VERSION "2.1"
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -73,7 +73,7 @@
 
 static struct usb_driver hci_usb_driver; 
 
-static struct usb_device_id usb_bluetooth_ids [] = {
+static struct usb_device_id bluetooth_ids[] = {
 	/* Generic Bluetooth USB device */
 	{ USB_DEVICE_INFO(HCI_DEV_CLASS, HCI_DEV_SUBCLASS, HCI_DEV_PROTOCOL) },
 
@@ -83,7 +83,14 @@
 	{ }	/* Terminating entry */
 };
 
-MODULE_DEVICE_TABLE (usb, usb_bluetooth_ids);
+MODULE_DEVICE_TABLE (usb, bluetooth_ids);
+
+static struct usb_device_id ignore_ids[] = {
+	/* Broadcom BCM2033 without firmware */
+	{ USB_DEVICE(0x0a5c, 0x2033) },
+
+	{ }	/* Terminating entry */
+};
 
 static void hci_usb_interrupt(struct urb *urb);
 static void hci_usb_rx_complete(struct urb *urb);
@@ -201,15 +208,19 @@
 	if (test_and_set_bit(HCI_RUNNING, &hdev->flags))
 		return 0;
 
+	MOD_INC_USE_COUNT;
+
 	write_lock_irqsave(&husb->completion_lock, flags);
 
 	err = hci_usb_enable_intr(husb);
 	if (!err) {
 		for (i = 0; i < HCI_MAX_BULK_TX; i++)
 			hci_usb_rx_submit(husb, NULL);
-	} else 
+	} else {
 		clear_bit(HCI_RUNNING, &hdev->flags);
-		
+		MOD_DEC_USE_COUNT;
+	}
+
 	write_unlock_irqrestore(&husb->completion_lock, flags);
 	return err;
 }
@@ -261,6 +272,8 @@
 	hci_usb_flush(hdev);
 
 	write_unlock_irqrestore(&husb->completion_lock, flags);
+
+	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
@@ -588,76 +601,9 @@
 
 	husb = (struct hci_usb *) hdev->driver_data;
 	kfree(husb);
-
-	MOD_DEC_USE_COUNT;
 }
 
-#ifdef CONFIG_BLUEZ_USB_FW_LOAD
-
-/* Support for user mode Bluetooth USB firmware loader */
-
-#define FW_LOADER "/sbin/bluefw"
-static int errno;
-
-static int hci_usb_fw_exec(void *dev)
-{
-	char *envp[] = { "HOME=/", "TERM=linux", 
-			 "PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL };
-	char *argv[] = { FW_LOADER, dev, NULL };
-	int err;
-
-	err = exec_usermodehelper(FW_LOADER, argv, envp);
-	if (err)
-		BT_ERR("failed to exec %s %s", FW_LOADER, (char *)dev);
-	return err;
-}
-
-static int hci_usb_fw_load(struct usb_device *udev)
-{
-	sigset_t tmpsig;
-	char dev[16];
-	pid_t pid;
-	int result;
-
-	/* Check if root fs is mounted */
-	if (!current->fs->root) {
-		BT_ERR("root fs not mounted");
-		return -EPERM;
-	}
-
-	sprintf(dev, "%3.3d/%3.3d", udev->bus->busnum, udev->devnum);
-
-	pid = kernel_thread(hci_usb_fw_exec, (void *)dev, 0);
-	if (pid < 0) {
-		BT_ERR("fork failed, errno %d\n", -pid);
-		return pid;
-	}
-
-	/* Block signals, everything but SIGKILL/SIGSTOP */
-	spin_lock_irq(&current->sigmask_lock);
-	tmpsig = current->blocked;
-	siginitsetinv(&current->blocked, sigmask(SIGKILL) | sigmask(SIGSTOP));
-	recalc_sigpending(current);
-	spin_unlock_irq(&current->sigmask_lock);
-
-	result = waitpid(pid, NULL, __WCLONE);
-
-	/* Allow signals again */
-	spin_lock_irq(&current->sigmask_lock);
-	current->blocked = tmpsig;
-	recalc_sigpending(current);
-	spin_unlock_irq(&current->sigmask_lock);
-
-	if (result != pid) {
-		BT_ERR("waitpid failed pid %d errno %d\n", pid, -result);
-		return -result;
-	}
-	return 0;
-}
-
-#endif /* CONFIG_BLUEZ_USB_FW_LOAD */
-
-static void * hci_usb_probe(struct usb_device *udev, unsigned int ifnum, const struct usb_device_id *id)
+static void *hci_usb_probe(struct usb_device *udev, unsigned int ifnum, const struct usb_device_id *id)
 {
 	struct usb_endpoint_descriptor *bulk_out_ep[HCI_MAX_IFACE_NUM];
 	struct usb_endpoint_descriptor *isoc_out_ep[HCI_MAX_IFACE_NUM];
@@ -673,16 +619,16 @@
 
 	BT_DBG("udev %p ifnum %d", udev, ifnum);
 
+	iface = &udev->actconfig->interface[0];
+
+	/* Check our black list */
+	if (usb_match_id(udev, iface, ignore_ids))
+		return NULL;
+
 	/* Check number of endpoints */
 	if (udev->actconfig->interface[ifnum].altsetting[0].bNumEndpoints < 3)
 		return NULL;
 
-	MOD_INC_USE_COUNT;
-
-#ifdef CONFIG_BLUEZ_USB_FW_LOAD
-	hci_usb_fw_load(udev);
-#endif
-
 	memset(bulk_out_ep, 0, sizeof(bulk_out_ep));
 	memset(isoc_out_ep, 0, sizeof(isoc_out_ep));
 	memset(bulk_in_ep,  0, sizeof(bulk_in_ep));
@@ -801,7 +747,6 @@
 	kfree(husb);
 
 done:
-	MOD_DEC_USE_COUNT;
 	return NULL;
 }
 
@@ -828,7 +773,7 @@
 	name:           "hci_usb",
 	probe:          hci_usb_probe,
 	disconnect:     hci_usb_disconnect,
-	id_table:       usb_bluetooth_ids,
+	id_table:       bluetooth_ids,
 };
 
 int hci_usb_init(void)
diff -urN linux.orig/Documentation/Configure.help linux/Documentation/Configure.help
--- linux.orig/Documentation/Configure.help	Sat Aug  3 11:59:38 2002
+++ linux/Documentation/Configure.help	Sat Aug  3 17:29:04 2002
@@ -20464,18 +20464,9 @@
   Say Y here to compile support for Bluetooth USB devices into the
   kernel or say M to compile it as module (hci_usb.o).
 
-HCI USB firmware download support
-CONFIG_BLUEZ_USB_FW_LOAD
-  Firmware download support for Bluetooth USB devices.
-  This support is required for devices like Broadcom BCM2033.
-
-  HCI USB driver uses external firmware downloader program provided 
-  in BlueFW package.
-  For more information, see <http://bluez.sf.net/>.
-
 HCI USB zero packet support
 CONFIG_BLUEZ_USB_ZERO_PACKET
-  Support for USB zero packets. 
+  Support for USB zero packets.
   This option is provided only as a work around for buggy Bluetooth USB 
   devices. Do _not_ enable it unless you know for sure that your device 
   requires zero packets.


