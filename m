Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267900AbSKEBSB>; Mon, 4 Nov 2002 20:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267915AbSKEBSB>; Mon, 4 Nov 2002 20:18:01 -0500
Received: from dhcp024-209-039-058.neo.rr.com ([24.209.39.58]:47745 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267900AbSKEBRy>;
	Mon, 4 Nov 2002 20:17:54 -0500
Date: Mon, 4 Nov 2002 20:28:00 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: cat@zip.com.au
Cc: greg@kroah.com, linux@brodo.de, Tamagucci@libero.it,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.5.45 / boottime oops (pnp bios I think)
Message-ID: <20021104202800.GD316@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, cat@zip.com.au,
	greg@kroah.com, linux@brodo.de, Tamagucci@libero.it,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
References: <20021104025458.GA3088@zip.com.au> <20021104161504.GA316@neo.rr.com> <20021104235408.GA627@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021104235408.GA627@zip.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 10:54:08AM +1100, CaT wrote:
> On Mon, Nov 04, 2002 at 04:15:04PM +0000, Adam Belay wrote:
> > 1.) apply patch 1 (attached below) to a clean kernel (2.5.45).  Compile the
> > kernel with PnP BIOS support and list the last few messages that start with 
> > "pnp!!!:" before it panics.  You probably will want to have kernel debugging
> > off so it doesn't scroll the messages off the screen.


> PNP!!!: Node number: 0xa EISA ID: PNP0c02
> pnp: 00:0a: iport range 0x4d0-0x4d1 has been reserved
> pnp: 00:0a: iport range 0x8000-0x803f has been reserved
> pnp: 00:0a: iport range 0x2180-0x218f has been reserved
> PNP!!!: Node number: 0xc EISA ID: PNP0c02
> PNP!!!: Node number: 0xd EISA ID: PNP0c02
> PNP!!!: Node number: 0xe EISA ID: PNP0700
> PNP!!!: Node number: 0x10 EISA ID: PNP0400
> general protection fault: 0040
> ...


> > 2.) Apply patch 2 (attached below) to a clean kernel (2.5.45).  Compile the
> > kernel with PnP BIOS support.  It should start up completely without a panic.
> >
> > This is not a complete fix however.  Anyway attach a copy of the output from
> > dmesg.

> PnPBIOS: Found PnP BIOS installation structure at 0xc00f6b40
> PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x843d, dseg 0xf0000
> PNP!!!: Node number: 0x0 EISA ID: PNP0c02
> pnp: pnp: match found with the PnP device '00:00' and the driver 'system'
> PNP!!!: Node number: 0x1 EISA ID: PNP0c01
> pnp: pnp: match found with the PnP device '00:01' and the driver 'system'
> PNP!!!: Node number: 0x2 EISA ID: PNP0200
> PNP!!!: Node number: 0x3 EISA ID: PNP0000
> PNP!!!: Node number: 0x4 EISA ID: PNP0100
> PNP!!!: Node number: 0x5 EISA ID: PNP0b00
> PNP!!!: Node number: 0x6 EISA ID: PNP0303
> PNP!!!: Node number: 0x7 EISA ID: PNP0c04
> PNP!!!: Node number: 0x8 EISA ID: PNP0800
> PNP!!!: Node number: 0x9 EISA ID: PNP0a03
> PNP!!!: Node number: 0xa EISA ID: PNP0c02
> pnp: pnp: match found with the PnP device '00:0a' and the driver 'system'
> pnp: 00:0a: ioport range 0x4d0-0x4d1 has been reserved
> pnp: 00:0a: ioport range 0x8000-0x803f has been reserved
> pnp: 00:0a: ioport range 0x2180-0x218f has been reserved
> PNP!!!: Node number: 0xc EISA ID: PNP0c02
> pnp: pnp: match found with the PnP device '00:0c' and the driver 'system'
> PNP!!!: Node number: 0xd EISA ID: PNP0c02
> pnp: pnp: match found with the PnP device '00:0d' and the driver 'system'
> PNP!!!: Node number: 0xe EISA ID: PNP0700
> PNP!!!: Node number: 0x10 EISA ID: PNP0400
> PNP!!!: Node number: 0x13 EISA ID: PNP0f13
> PNP!!!: Node number: 0x14 EISA ID: PNP0501
> PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver



It can be infered from the two above excerpts that the general protection fault
occured when the pnp bios protocol reached node 0x13.  This node, pnp id
PNP0f13, is of course a standard mouse port.  If you look at the output of 
lspnp for my system, the following can be seen.

12 PNP0f13 input device: mouse
    flags: [no disable] [no config] [static]
    allocated resources:
	irq 12 [high edge]

Notice the flags "No Config" and "Static".  This device can not be configured
by the pnpbios and only contains static resource information.  So the question
is why do some systems handle getting dynamic information from static devices
and others don't.  I believe that some PnP BIOSes are broken and are unable to
handle calls that do not make sense.  In other words, requesting dynamic
information from a static device is pointless becuase it could only contain
static information.  The idea that this is the cause of the general protection
fault is further supported by the fact that not every node had this problem.

It actually makes sense for a bug like this to go unnoticed in other operating
systems.

The following describes the Microsoft Windows PnP boot process:

-During boot real mode calls are made.
-only static configuration requests are made, no dynamics yet
-then the protect mode configuration manager starts
-then dynamic calls can be made

* This would imply that dynamic calls will only be made if neccessary.  Making
a dynamic call on a static device would therefore never happen.

This patch will make the PnP BIOS protocol follow these conventions:

1.) only static information requests are made during the initial device tree
building process.
2.) pnp flags are used to see if a device is static or cannot be configured.
3.) if the device is static the protocol will prevent any dynamic calls
4.) all sony viao and other dmi scan restrictions will be removed.
5.) if the device is indeed dynamic, dynamic calls will be made to update
the status after resources are set or the device is disabled.

More stuff related to this is on the way but this patch should make the pnpbios
driver fully functional.  It is against 2.5.45 but should work with 2.5.46 as
well.  It adds peliminary support for PnP BIOS flags.  Eventually I'll export
these to a user interface.

Please feel free to send any questions or comments.  The patch is below.

Thanks,
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
