Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266267AbSKGBkV>; Wed, 6 Nov 2002 20:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266268AbSKGBkV>; Wed, 6 Nov 2002 20:40:21 -0500
Received: from dhcp024-209-039-058.neo.rr.com ([24.209.39.58]:33412 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S266267AbSKGBkS>;
	Wed, 6 Nov 2002 20:40:18 -0500
Date: Wed, 6 Nov 2002 20:50:16 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: [PATCH] PnP BIOS fixes - 2.5.46 (1/6)
Message-ID: <20021106205016.GL316@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, greg@kroah.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch should at least partially fix the problems caused by broken PnP
BIOSes.  More fixes will come later but this should boot.  Please report general
protection faults.  The PnP BIOS proc interface may still not work if you have a
broken PnP BIOS.  Also adds basic support for PnP BIOS flags and removes some
currently unused stuff.

Please apply,
Adam



diff -ur --new-file a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
--- a/drivers/pnp/pnpbios/core.c	Wed Oct 30 17:16:54 2002
+++ b/drivers/pnp/pnpbios/core.c	Tue Oct 29 23:41:21 2002
@@ -1256,6 +1256,12 @@
 	struct pnp_dev_node_info node_info;
 	u8 nodenum = dev->number;
 	struct pnp_bios_node * node;
+
+	/* just in case */
+	if(dev->driver)
+		return -EBUSY;
+	if(!pnp_is_dynamic(dev))
+		return -EPERM;
 	if (pnp_bios_dev_node_info(&node_info) != 0)
 		return -ENODEV;
 	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
@@ -1273,8 +1279,13 @@
 	struct pnp_dev_node_info node_info;
 	u8 nodenum = dev->number;
 	struct pnp_bios_node * node;
-	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
 
+	/* just in case */
+	if(dev->driver)
+		return -EBUSY;
+	if (flags == PNP_DYNAMIC && !pnp_is_dynamic(dev))
+		return -EPERM;
+	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (pnp_bios_dev_node_info(&node_info) != 0)
 		return -ENODEV;
 	if (!node)
@@ -1323,6 +1334,11 @@
 	struct pnp_bios_node * node;
 	if (!config)
 		return -1;
+	/* just in case */
+	if(dev->driver)
+		return -EBUSY;
+	if(dev->flags & PNP_NO_DISABLE || !pnp_is_dynamic(dev))
+		return -EPERM;
 	memset(config, 0, sizeof(struct pnp_cfg));
 	if (!dev || !dev->active)
 		return -EINVAL;
@@ -1402,10 +1418,13 @@
 	for(nodenum=0; nodenum<0xff; ) {
 		u8 thisnodenum = nodenum;
 		/* We build the list from the "boot" config because
-		 * asking for the "current" config causes some
-		 * BIOSes to crash.
+		 * we know that the resources couldn't have changed
+		 * at this stage.  Furthermore some buggy PnP BIOSes
+		 * will crash if we request the "current" config
+		 * from devices that are can only be static such as
+		 * those controlled by the "system" driver.
 		 */
-		if (pnp_bios_get_dev_node(&nodenum, (char )0 , node))
+		if (pnp_bios_get_dev_node(&nodenum, (char )1, node))
 			break;
 		nodes_got++;
 		dev =  pnpbios_kmalloc(sizeof (struct pnp_dev), GFP_KERNEL);
@@ -1426,6 +1445,7 @@
 		pos = node_current_resource_data_to_dev(node,dev);
 		pos = node_possible_resource_data_to_dev(pos,node,dev);
 		node_id_data_to_dev(pos,node,dev);
+		dev->flags = node->flags;
 
 		dev->protocol = &pnpbios_protocol;
 
@@ -1450,10 +1470,7 @@
  *
  */
 
-extern int is_sony_vaio_laptop;
-
 static int pnpbios_disabled; /* = 0 */
-static int dont_reserve_resources; /* = 0 */
 int pnpbios_dont_use_current_config; /* = 0 */
 
 #ifndef MODULE
@@ -1471,8 +1488,6 @@
 			str += 3;
 		if (strncmp(str, "curr", 4) == 0)
 			pnpbios_dont_use_current_config = invert;
-		if (strncmp(str, "res", 3) == 0)
-			dont_reserve_resources = invert;
 		str = strchr(str, ',');
 		if (str != NULL)
 			str += strspn(str, ", \t");
@@ -1498,9 +1513,6 @@
 		printk(KERN_INFO "PnPBIOS: Disabled\n");
 		return -ENODEV;
 	}
-
-	if ( is_sony_vaio_laptop )
-		pnpbios_dont_use_current_config = 1;
 
 	/*
  	 * Search the defined area (0xf0000-0xffff0) for a valid PnP BIOS
diff -ur --new-file a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h	Wed Oct 30 17:16:54 2002
+++ b/include/linux/pnp.h	Mon Oct 28 20:28:35 2002
@@ -53,6 +53,7 @@
 	struct	device	    dev;	/* Driver Model device interface */
 	void  		  * driver_data;/* data private to the driver */
 	void		  * protocol_data;
+	int		    flags;	/* used by protocols */
 	struct proc_dir_entry *procent;	/* device entry in /proc/bus/isapnp */
 };
 
@@ -108,7 +109,7 @@
 #define DEV_DMA(dev, index) (dev->dma_resource[index].start)
 
 #define PNP_PORT_FLAG_16BITADDR	(1<<0)
-#define PNP_PORT_FLAG_FIXED		(1<<1)
+#define PNP_PORT_FLAG_FIXED	(1<<1)
 
 struct pnp_port {
 	unsigned short min;		/* min base number */
diff -ur --new-file a/include/linux/pnpbios.h b/include/linux/pnpbios.h
--- a/include/linux/pnpbios.h	Sat Oct 19 04:01:48 2002
+++ b/include/linux/pnpbios.h	Mon Oct 28 20:27:16 2002
@@ -75,6 +75,19 @@
 #define PNPMSG_POWER_OFF		0x41
 #define PNPMSG_PNP_OS_ACTIVE		0x42
 #define PNPMSG_PNP_OS_INACTIVE		0x43
+/*
+ * Plug and Play BIOS flags
+ */
+#define PNP_NO_DISABLE		0x0001
+#define PNP_NO_CONFIG		0x0002
+#define PNP_OUTPUT		0x0004
+#define PNP_INPUT		0x0008
+#define PNP_BOOTABLE		0x0010
+#define PNP_DOCK		0x0020
+#define PNP_REMOVABLE		0x0040
+#define pnp_is_static(x) (x->flags & 0x0100) == 0x0000
+#define pnp_is_dynamic(x) x->flags & 0x0080
+
 /* 0x8000 through 0xffff are OEM defined */
 
 #pragma pack(1)
