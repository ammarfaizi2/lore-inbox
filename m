Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265300AbSJRUr7>; Fri, 18 Oct 2002 16:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265312AbSJRUr7>; Fri, 18 Oct 2002 16:47:59 -0400
Received: from [195.39.17.254] ([195.39.17.254]:17924 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S265300AbSJRUrz>;
	Fri, 18 Oct 2002 16:47:55 -0400
Date: Fri, 18 Oct 2002 22:50:28 +0200
From: pavel@bug.ucw.cz
Message-Id: <200210182050.WAA21271@bug.ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Zaurus support for usbnet.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- clean/drivers/usb/net/usbnet.c	2002-10-08 21:25:31.000000000 +0200
+++ linux/drivers/usb/net/usbnet.c	2002-10-18 22:44:04.000000000 +0200
@@ -1,6 +1,8 @@
 /*
  * USB Host-to-Host Links
  * Copyright (C) 2000-2002 by David Brownell <dbrownell@users.sourceforge.net>
+ * Copyright (C) 2002 Pavel Machek <pavel@ucw.cz>
+ * Distribute under GPLv2.
  */
 
 /*
@@ -18,7 +20,7 @@
  *	- Belkin, eTEK (interops with Win32 drivers)
  *	- EPSON USB clients
  *	- GeneSys GL620USB-A
- *	- "Linux Devices" (like iPaq and similar SA-1100 based PDAs)
+ *	- "Linux Devices" (like iPaq, Zaurus and similar SA-1100 based PDAs)
  *	- NetChip 1080 (interoperates with NetChip Win32 drivers)
  *	- Prolific PL-2301/2302 (replaces "plusb" driver)
  *
@@ -37,9 +39,7 @@
  *   handshaking; it'd be worth implementing those as "carrier detect".
  *   Prefer generic hooks, not minidriver-specific hacks.
  *
- * - Linux devices ... the www.handhelds.org SA-1100 support works nicely,
- *   but the Sharp Zaurus uses an incompatible protocol (extra checksums).
- *   No reason not to merge the Zaurus protocol here too (got patch? :)
+ * - Linux devices ... the www.handhelds.org SA-1100 support works nicely.
  *
  * - For Netchip, should use keventd to poll via control requests to detect
  *   hardware level "carrier detect". 
@@ -100,6 +100,7 @@
  * 07-may-2002	Generalize/cleanup keventd support, handling rx stalls (mostly
  *		for USB 2.0 TTs) and memory shortages (potential) too. (db)
  *		Use "locally assigned" IEEE802 address space. (Brad Hards)
+ * 18-oct-2002  Support for Zaurus (Pavel Machek)
  *
  *-------------------------------------------------------------------------*/
 
@@ -116,8 +117,8 @@
 #include <asm/uaccess.h>
 #include <asm/unaligned.h>
 
-// #define	DEBUG			// error path messages, extra info
-// #define	VERBOSE			// more; success messages
+#define	DEBUG			// error path messages, extra info
+#define	VERBOSE			// more; success messages
 #define	REALLY_QUEUE
 
 #if !defined (DEBUG) && defined (CONFIG_USB_DEBUG)
@@ -132,6 +133,7 @@
 #define	CONFIG_USB_EPSON2888
 #define	CONFIG_USB_GENESYS
 #define	CONFIG_USB_LINUXDEV
+#define	CONFIG_USB_ZAURUS
 #define	CONFIG_USB_NET1080
 #define	CONFIG_USB_PL2301
 
@@ -216,6 +218,7 @@
 #define FLAG_FRAMING_NC	0x0001		/* guard against device dropouts */ 
 #define FLAG_FRAMING_GL	0x0002		/* genelink batches packets */
 #define FLAG_NO_SETINT	0x0010		/* device can't set_interface() */
+#define FLAG_ZAURUS	0x0020		/* device is sharp zaurus */
 
 	/* reset device ... can sleep */
 	int	(*reset)(struct usbnet *);
@@ -269,6 +272,8 @@
 #define	RUN_CONTEXT (in_irq () ? "in_irq" \
 			: (in_interrupt () ? "in_interrupt" : "can sleep"))
 
+
+
 /*-------------------------------------------------------------------------*/
 
 #ifdef DEBUG
@@ -700,6 +705,33 @@
 };
 
 #endif	/* CONFIG_USB_LINUXDEV */
+#ifdef CONFIG_USB_ZAURUS
+static struct sk_buff *
+zaurus_tx_fixup (struct usbnet *dev, struct sk_buff *skb, int flags)
+{
+	int			padlen;
+	struct sk_buff		*skb2;
+
+	padlen = 2;
+	if (!skb_cloned (skb)) {
+		int	tailroom = skb_tailroom (skb);
+		if ((padlen + 4) <= tailroom)
+			return skb;
+	}
+	skb2 = skb_copy_expand (skb, 0, 4 + padlen, flags);
+	dev_kfree_skb_any (skb);
+	return skb2;
+}
+
+static const struct driver_info	zaurus_info = {
+	.description =	"Sharp Zaurus",
+	.tx_fixup = 	zaurus_tx_fixup,
+
+	.flags = FLAG_ZAURUS,
+	.in = 2, .out = 1,
+	.epsize = 64,
+};
+#endif
 
 
 #ifdef	CONFIG_USB_NET1080
@@ -1146,7 +1178,7 @@
 	.tx_fixup =	net1080_tx_fixup,
 
 	.in = 1, .out = 1,		// direction distinguishes these
-	.epsize =64,
+	.epsize = 64,
 };
 
 #endif /* CONFIG_USB_NET1080 */
@@ -1213,7 +1245,7 @@
 	.reset =	pl_reset,
 
 	.in = 3, .out = 2,
-	.epsize =64,
+	.epsize = 64,
 };
 
 #endif /* CONFIG_USB_PL2301 */
@@ -1757,6 +1789,55 @@
 
 /*-------------------------------------------------------------------------*/
 
+#ifdef CONFIG_USB_ZAURUS
+__u32 crc32_table[256] = {
+    0x00000000, 0x77073096, 0xee0e612c, 0x990951ba, 0x076dc419, 0x706af48f, 0xe963a535, 0x9e6495a3,
+    0x0edb8832, 0x79dcb8a4, 0xe0d5e91e, 0x97d2d988, 0x09b64c2b, 0x7eb17cbd, 0xe7b82d07, 0x90bf1d91,
+    0x1db71064, 0x6ab020f2, 0xf3b97148, 0x84be41de, 0x1adad47d, 0x6ddde4eb, 0xf4d4b551, 0x83d385c7,
+    0x136c9856, 0x646ba8c0, 0xfd62f97a, 0x8a65c9ec, 0x14015c4f, 0x63066cd9, 0xfa0f3d63, 0x8d080df5,
+    0x3b6e20c8, 0x4c69105e, 0xd56041e4, 0xa2677172, 0x3c03e4d1, 0x4b04d447, 0xd20d85fd, 0xa50ab56b,
+    0x35b5a8fa, 0x42b2986c, 0xdbbbc9d6, 0xacbcf940, 0x32d86ce3, 0x45df5c75, 0xdcd60dcf, 0xabd13d59,
+    0x26d930ac, 0x51de003a, 0xc8d75180, 0xbfd06116, 0x21b4f4b5, 0x56b3c423, 0xcfba9599, 0xb8bda50f,
+    0x2802b89e, 0x5f058808, 0xc60cd9b2, 0xb10be924, 0x2f6f7c87, 0x58684c11, 0xc1611dab, 0xb6662d3d,
+    0x76dc4190, 0x01db7106, 0x98d220bc, 0xefd5102a, 0x71b18589, 0x06b6b51f, 0x9fbfe4a5, 0xe8b8d433,
+    0x7807c9a2, 0x0f00f934, 0x9609a88e, 0xe10e9818, 0x7f6a0dbb, 0x086d3d2d, 0x91646c97, 0xe6635c01,
+    0x6b6b51f4, 0x1c6c6162, 0x856530d8, 0xf262004e, 0x6c0695ed, 0x1b01a57b, 0x8208f4c1, 0xf50fc457,
+    0x65b0d9c6, 0x12b7e950, 0x8bbeb8ea, 0xfcb9887c, 0x62dd1ddf, 0x15da2d49, 0x8cd37cf3, 0xfbd44c65,
+    0x4db26158, 0x3ab551ce, 0xa3bc0074, 0xd4bb30e2, 0x4adfa541, 0x3dd895d7, 0xa4d1c46d, 0xd3d6f4fb,
+    0x4369e96a, 0x346ed9fc, 0xad678846, 0xda60b8d0, 0x44042d73, 0x33031de5, 0xaa0a4c5f, 0xdd0d7cc9,
+    0x5005713c, 0x270241aa, 0xbe0b1010, 0xc90c2086, 0x5768b525, 0x206f85b3, 0xb966d409, 0xce61e49f,
+    0x5edef90e, 0x29d9c998, 0xb0d09822, 0xc7d7a8b4, 0x59b33d17, 0x2eb40d81, 0xb7bd5c3b, 0xc0ba6cad,
+    0xedb88320, 0x9abfb3b6, 0x03b6e20c, 0x74b1d29a, 0xead54739, 0x9dd277af, 0x04db2615, 0x73dc1683,
+    0xe3630b12, 0x94643b84, 0x0d6d6a3e, 0x7a6a5aa8, 0xe40ecf0b, 0x9309ff9d, 0x0a00ae27, 0x7d079eb1,
+    0xf00f9344, 0x8708a3d2, 0x1e01f268, 0x6906c2fe, 0xf762575d, 0x806567cb, 0x196c3671, 0x6e6b06e7,
+    0xfed41b76, 0x89d32be0, 0x10da7a5a, 0x67dd4acc, 0xf9b9df6f, 0x8ebeeff9, 0x17b7be43, 0x60b08ed5,
+    0xd6d6a3e8, 0xa1d1937e, 0x38d8c2c4, 0x4fdff252, 0xd1bb67f1, 0xa6bc5767, 0x3fb506dd, 0x48b2364b,
+    0xd80d2bda, 0xaf0a1b4c, 0x36034af6, 0x41047a60, 0xdf60efc3, 0xa867df55, 0x316e8eef, 0x4669be79,
+    0xcb61b38c, 0xbc66831a, 0x256fd2a0, 0x5268e236, 0xcc0c7795, 0xbb0b4703, 0x220216b9, 0x5505262f,
+    0xc5ba3bbe, 0xb2bd0b28, 0x2bb45a92, 0x5cb36a04, 0xc2d7ffa7, 0xb5d0cf31, 0x2cd99e8b, 0x5bdeae1d,
+    0x9b64c2b0, 0xec63f226, 0x756aa39c, 0x026d930a, 0x9c0906a9, 0xeb0e363f, 0x72076785, 0x05005713,
+    0x95bf4a82, 0xe2b87a14, 0x7bb12bae, 0x0cb61b38, 0x92d28e9b, 0xe5d5be0d, 0x7cdcefb7, 0x0bdbdf21,
+    0x86d3d2d4, 0xf1d4e242, 0x68ddb3f8, 0x1fda836e, 0x81be16cd, 0xf6b9265b, 0x6fb077e1, 0x18b74777,
+    0x88085ae6, 0xff0f6a70, 0x66063bca, 0x11010b5c, 0x8f659eff, 0xf862ae69, 0x616bffd3, 0x166ccf45,
+    0xa00ae278, 0xd70dd2ee, 0x4e048354, 0x3903b3c2, 0xa7672661, 0xd06016f7, 0x4969474d, 0x3e6e77db,
+    0xaed16a4a, 0xd9d65adc, 0x40df0b66, 0x37d83bf0, 0xa9bcae53, 0xdebb9ec5, 0x47b2cf7f, 0x30b5ffe9,
+    0xbdbdf21c, 0xcabac28a, 0x53b39330, 0x24b4a3a6, 0xbad03605, 0xcdd70693, 0x54de5729, 0x23d967bf,
+    0xb3667a2e, 0xc4614ab8, 0x5d681b02, 0x2a6f2b94, 0xb40bbe37, 0xc30c8ea1, 0x5a05df1b, 0x2d02ef8d
+};
+
+#define CRC32_INITFCS     0xffffffff  // Initial FCS value 
+#define CRC32_FCS(fcs, c) (((fcs) >> 8) ^ crc32_table[((fcs) ^ (c)) & 0xff])
+
+/* fcs_compute32 - memcpy and calculate fcs
+ * Perform a memcpy and calculate fcs using ppp 32bit CRC algorithm.
+ */
+static u32 fcs_compute32(unsigned char *sp, int len, __u32 fcs)
+{
+    for (;len-- > 0; fcs = CRC32_FCS(fcs, *sp++));
+    return fcs;
+}
+#endif
+
 static int usbnet_start_xmit (struct sk_buff *skb, struct net_device *net)
 {
 	struct usbnet		*dev = (struct usbnet *) net->priv;
@@ -1795,6 +1876,16 @@
 	// FIXME: reorganize a bit, so that fixup() fills out NetChip
 	// framing too. (Packet ID update needs the spinlock...)
 
+#ifdef	CONFIG_USB_ZAURUS
+	if (info->flags & FLAG_ZAURUS) {
+		u32 fcs = fcs_compute32(skb->data, skb->len, CRC32_INITFCS);
+		fcs = ~fcs;
+		*skb_put(skb, 1) = fcs&0xff;
+		*skb_put(skb, 1) = (fcs>>8)&0xff;
+		*skb_put(skb, 1) = (fcs>>16)&0xff;
+		*skb_put(skb, 1) = (fcs>>24)&0xff;
+	}
+#endif
 #ifdef	CONFIG_USB_NET1080
 	if (info->flags & FLAG_FRAMING_NC) {
 		header = (struct nc_header *) skb_push (skb, sizeof *header);
@@ -2043,6 +2134,11 @@
 		xdev->bus->bus_name, xdev->devpath,
 		dev->driver_info->description);
 
+	if (dev->flags & FLAG_ZAURUS) {
+		printk("usbnet: Setting config: %d\n", usb_set_configuration(xdev, 1));
+		printk("usbnet: Setting alternate: %d\n", usb_set_interface(xdev, 1, 1));
+	}
+
 	// ok, it's ready to go.
 	dev_set_drvdata (&udev->dev, net);
 	mutex_lock (&usbnet_mutex);
@@ -2118,9 +2214,14 @@
 }, {
 	USB_DEVICE (0x0E7E, 0x1001),	// G.Mate "Yopy"
 	.driver_info =	(unsigned long) &linuxdev_info,
+}, 
+#endif
+#ifdef	CONFIG_USB_ZAURUS
+{
+	match_flags: USB_DEVICE_ID_MATCH_INT_INFO | USB_DEVICE_ID_MATCH_DEVICE, 
+        idVendor: 0x04DD, idProduct: 0x8004, bInterfaceClass: 0x0a, bInterfaceSubClass: 0x00, bInterfaceProtocol: 0x00,
+	.driver_info =  (unsigned long) &zaurus_info, 	// Sharp Zaurus, "collie"
 },
-	// NOTE:  the Sharp Zaurus uses a modified version of
-	// this driver, which is not interoperable with this.
 #endif
 
 #ifdef	CONFIG_USB_NET1080
@@ -2161,8 +2262,7 @@
 static int __init usbnet_init (void)
 {
 	// compiler should optimize this out
-	if (sizeof (((struct sk_buff *)0)->cb) < sizeof (struct skb_data))
-		BUG ();
+	BUG_ON(sizeof (((struct sk_buff *)0)->cb) < sizeof (struct skb_data));
 
 	get_random_bytes (node_id, sizeof node_id);
 	node_id [0] &= 0xfe;	// clear multicast bit
@@ -2170,7 +2270,6 @@
 
  	if (usb_register (&usbnet_driver) < 0)
  		return -1;
-
 	return 0;
 }
 module_init (usbnet_init);
