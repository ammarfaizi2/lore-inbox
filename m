Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277519AbRJVDgU>; Sun, 21 Oct 2001 23:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277526AbRJVDgO>; Sun, 21 Oct 2001 23:36:14 -0400
Received: from hermes.toad.net ([162.33.130.251]:9871 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S277519AbRJVDf7>;
	Sun, 21 Oct 2001 23:35:59 -0400
Subject: [PATCH] PnP BIOS #5
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 21 Oct 2001 23:35:40 -0400
Message-Id: <1003721745.4322.40.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a new version of the patch in which I have reverted
a number of the function name changes.  If you're building
a new kernel with PnP BIOS support, please test this and
report back.     // Thomas Hood

Summary of changes in this patch:
1) Fix bugs in resource reservation:
       - didn't reserve all io resources
       - end of resource range recorded in devlist off by 1
2) Change code so that set_dev_node updates the devlist, so
   drivers loaded after a setpnp will get up-to-date resource
   information.  Because I haven't protected devlist update
   code with locks, this feature isn't SMP safe yet.  I'd like
   some advice about how to do the locking.  If you're worried,
   don't use setpnp.
3) Miscellaneous code cleanups.   Improve printk output.  Etc.
4) Don't EXPORT_SYMBOL lowlevel PnP BIOS access functions since
   they aren't used by anything except the proc routines which
   don't need them to be EXPORT_SYMBOL to link to them.
5) Declare announce_device in header (since it is EXPORT_SYMBOL
   in pnp_bios.c, presumably for a reason).

The patch:
--- linux-2.4.12-ac4/init/main.c	Sun Oct 14 15:39:55 2001
+++ linux-2.4.12-ac4-fix/init/main.c	Sun Oct 21 22:40:19 2001
@@ -822,7 +822,7 @@
 	isapnp_init();
 #endif
 #ifdef CONFIG_PNPBIOS
-        pnp_bios_init();
+        pnpbios_init();
 #endif
 
 #ifdef CONFIG_TC
--- linux-2.4.12-ac4/include/linux/pnp_bios.h	Sun Oct 21 19:23:43 2001
+++ linux-2.4.12-ac4-fix/include/linux/pnp_bios.h	Sun Oct 21 22:40:57 2001
@@ -132,10 +132,26 @@
 	return (struct pnpbios_driver *)dev->driver;
 }
 
-extern void pnp_bios_init (void);
+#ifdef CONFIG_PNPBIOS
+#define pnpbios_for_each_dev(dev) \
+	for(dev = pnpbios_dev_g(pnpbios_devices.next); dev != pnpbios_dev_g(&pnpbios_devices); dev = pnpbios_dev_g(dev->global_list.next))
+
+/* exported functions */
+extern struct pci_dev *pnpbios_find_device(char *pnpid, struct pci_dev *dev);
+extern int  pnpbios_announce_device(struct pnpbios_driver *drv, struct pci_dev *dev);
+extern int  pnpbios_register_driver(struct pnpbios_driver *drv);
+extern void pnpbios_unregister_driver(struct pnpbios_driver *drv);
+
+/* non-exported functions */
+extern int  pnpbios_dont_use_current_config;
+extern void *pnpbios_kmalloc(size_t size, int f);
+extern void pnpbios_init (void);
+extern void pnpbios_proc_init (void);
+
 extern int pnp_bios_dev_node_info (struct pnp_dev_node_info *data);
 extern int pnp_bios_get_dev_node (u8 *nodenum, char config, struct pnp_bios_node *data);
 extern int pnp_bios_set_dev_node (u8 nodenum, char config, struct pnp_bios_node *data);
+#if needed
 extern int pnp_bios_get_event (u16 *message);
 extern int pnp_bios_send_message (u16 message);
 extern int pnp_bios_set_stat_res (char *info);
@@ -145,16 +161,7 @@
 extern int pnp_bios_escd_info (struct escd_info_struc *data);
 extern int pnp_bios_read_escd (char *data, u32 nvram_base);
 extern int pnp_bios_write_escd (char *data, u32 nvram_base);
-
-extern void pnp_proc_init ( int dont_use_current );
-
-#ifdef CONFIG_PNPBIOS
-#define pnpbios_for_each_dev(dev) \
-	for(dev = pnpbios_dev_g(pnpbios_devices.next); dev != pnpbios_dev_g(&pnpbios_devices); dev = pnpbios_dev_g(dev->global_list.next))
-extern int pnp_bios_present (void);
-extern struct pci_dev *pnpbios_find_device(char *pnpid, struct pci_dev *dev);
-extern int pnpbios_register_driver(struct pnpbios_driver *drv);
-extern void pnpbios_unregister_driver(struct pnpbios_driver *drv);
+#endif
 
 /*
  * a helper function which helps ensure correct pnpbios_driver
@@ -189,22 +196,17 @@
 	return rc;
 }
 
-#else
+#else /* CONFIG_PNPBIOS */
 #define pnpbios_for_each_dev(dev)	for(dev = NULL; 0; )
 
-static __inline__ int pnp_bios_present (void)
-{
-	return 0;
-}
-
 static __inline__ struct pci_dev *pnpbios_find_device(char *pnpid, struct pci_dev *dev)
 {
 	return NULL;
 }
 
-static __inline__ int pnpbios_module_init(struct pnpbios_driver *drv) 
+static __inline__ int pnpbios_announce_device(struct pnpbios_driver *drv, struct pci_dev *dev)
 {
-	return -ENODEV; 
+	return 0;
 }
 
 static __inline__ int pnpbios_register_driver(struct pnpbios_driver *drv)
@@ -217,7 +219,12 @@
 	return;
 }
 
-#endif
+static __inline__ int pnpbios_module_init(struct pnpbios_driver *drv) 
+{
+	return -ENODEV; 
+}
+
+#endif /* CONFIG_PNPBIOS */
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_PNP_BIOS_H */
--- linux-2.4.12-ac4/drivers/pnp/pnp_bios.c	Wed Oct 10 22:09:19 2001
+++ linux-2.4.12-ac4-fix/drivers/pnp/pnp_bios.c	Sun Oct 21 23:27:13 2001
@@ -50,11 +50,17 @@
 #define PNP_SIGNATURE   (('$' << 0) + ('P' << 8) + ('n' << 16) + ('P' << 24))
 
 /*
+ * Forward declarations
+ */
+
+static void pnpbios_update_devlist( u8 nodenum, struct pnp_bios_node *data );
+
+/*
  * This is the standard structure used to identify the entry point
  * to the Plug and Play bios
  */
 #pragma pack(1)
-union pnpbios {
+union pnp_bios_expansion_header {
 	struct {
 		u32 signature;    /* "$PnP" */
 		u8 version;	  /* in BCD */
@@ -83,7 +89,7 @@
 	u16	segment;
 } pnp_bios_callpoint;
 
-static union pnpbios * pnp_bios_inst_struc = NULL;
+static union pnp_bios_expansion_header * pnp_bios_hdr = NULL;
 
 /* The PnP entries in the GDT */
 #define PNP_GDT		0x0060
@@ -214,12 +220,16 @@
 		printk(KERN_ERR "PnPBIOS: Check with your vendor for an updated BIOS\n");
 	}
 
-//	if ( status ) printk(KERN_WARNING "PnPBIOS: BIOS returned error 0x%x from function 0x%x.\n", status, func);
-		
 	return status;
 }
 
-static void *pnp_bios_kmalloc(size_t size, int f)
+/*
+ *
+ * UTILITY FUNCTIONS
+ *
+ */
+
+void *pnpbios_kmalloc(size_t size, int f)
 {
 	void *p = kmalloc( size, f );
 	if ( p == NULL )
@@ -228,6 +238,14 @@
 }
 
 /*
+ * Call this only after init time
+ */
+static int pnp_bios_present(void)
+{
+	return (pnp_bios_hdr != NULL);
+}
+
+/*
  *
  * PnP BIOS ACCESS FUNCTIONS
  *
@@ -236,7 +254,7 @@
 /*
  * Call PnP BIOS with function 0x00, "get number of system device nodes"
  */
-static int pnp_bios_dev_node_info_silently(struct pnp_dev_node_info *data)
+static int __pnp_bios_dev_node_info(struct pnp_dev_node_info *data)
 {
 	u16 status;
 	if (!pnp_bios_present ())
@@ -249,9 +267,9 @@
 
 int pnp_bios_dev_node_info(struct pnp_dev_node_info *data)
 {
-	u16 status = pnp_bios_dev_node_info_silently( data );
+	int status = __pnp_bios_dev_node_info( data );
 	if ( status )
-		printk(KERN_WARNING "PnPBIOS: PnP BIOS dev_node_info function returned error status 0x%x\n", status);
+		printk(KERN_WARNING "PnPBIOS: dev_node_info: Unexpected status 0x%x\n", status);
 	return status;
 }
 
@@ -269,11 +287,13 @@
  *               or volatile current (0) config
  * Output: *nodenum=next node or 0xff if no more nodes
  */
-static int pnp_bios_get_dev_node_silently(u8 *nodenum, char boot, struct pnp_bios_node *data)
+static int __pnp_bios_get_dev_node(u8 *nodenum, char boot, struct pnp_bios_node *data)
 {
 	u16 status;
 	if (!pnp_bios_present ())
 		return PNP_FUNCTION_NOT_SUPPORTED;
+	if ( !boot & pnpbios_dont_use_current_config )
+		return PNP_FUNCTION_NOT_SUPPORTED;
 	Q2_SET_SEL(PNP_TS1, nodenum, sizeof(char));
 	Q2_SET_SEL(PNP_TS2, data, 64 * 1024);
 	status = call_pnp_bios(PNP_GET_SYS_DEV_NODE, 0, PNP_TS1, 0, PNP_TS2, boot ? 2 : 1, PNP_DS, 0);
@@ -282,9 +302,10 @@
 
 int pnp_bios_get_dev_node(u8 *nodenum, char boot, struct pnp_bios_node *data)
 {
-	u16 status =  pnp_bios_get_dev_node_silently( nodenum, boot, data );
+	int status;
+	status =  __pnp_bios_get_dev_node( nodenum, boot, data );
 	if ( status )
-		printk(KERN_WARNING "PnPBIOS: PnP BIOS get_dev_node function returned error status 0x%x\n", status);
+		printk(KERN_WARNING "PnPBIOS: get_dev_node: Unexpected 0x%x\n", status);
 	return status;
 }
 
@@ -294,11 +315,13 @@
  *        boot = whether to set nonvolatile boot (!=0)
  *               or volatile current (0) config
  */
-static int pnp_bios_set_dev_node_silently(u8 nodenum, char boot, struct pnp_bios_node *data)
+static int __pnp_bios_set_dev_node(u8 nodenum, char boot, struct pnp_bios_node *data)
 {
 	u16 status;
 	if (!pnp_bios_present ())
 		return PNP_FUNCTION_NOT_SUPPORTED;
+	if ( !boot & pnpbios_dont_use_current_config )
+		return PNP_FUNCTION_NOT_SUPPORTED;
 	Q2_SET_SEL(PNP_TS1, data, /* *((u16 *) data)*/ 65536);
 	status = call_pnp_bios(PNP_SET_SYS_DEV_NODE, nodenum, 0, PNP_TS1, boot ? 2 : 1, PNP_DS, 0, 0);
 	return status;
@@ -306,9 +329,21 @@
 
 int pnp_bios_set_dev_node(u8 nodenum, char boot, struct pnp_bios_node *data)
 {
-	u16 status =  pnp_bios_set_dev_node_silently( nodenum, boot, data );
-	if ( status )
-		printk(KERN_WARNING "PnPBIOS: PnP BIOS set_dev_node function returned error status 0x%x\n", status);
+	int status;
+	status =  __pnp_bios_set_dev_node( nodenum, boot, data );
+	if ( status ) {
+		printk(KERN_WARNING "PnPBIOS: set_dev_node: Unexpected set_dev_node status 0x%x\n", status);
+		return status;
+	}
+	if ( !boot ) { /* Update devlist */
+		u8 thisnodenum = nodenum;
+		status =  __pnp_bios_get_dev_node( &nodenum, boot, data );
+		if ( status ) {
+			printk(KERN_WARNING "PnPBIOS: set_dev_node: Unexpected get_dev_node status 0x%x\n", status);
+			return status;
+		}
+		pnpbios_update_devlist( thisnodenum, data );
+	}
 	return status;
 }
 
@@ -469,10 +504,6 @@
 }
 #endif
 
-EXPORT_SYMBOL(pnp_bios_dev_node_info);
-EXPORT_SYMBOL(pnp_bios_get_dev_node);
-EXPORT_SYMBOL(pnp_bios_set_dev_node);
-
 /*
  *
  * PnP DOCKING FUNCTIONS
@@ -482,7 +513,6 @@
 #ifdef CONFIG_HOTPLUG
 
 static int unloading = 0;
-
 static struct completion unload_sem;
 
 /*
@@ -499,10 +529,10 @@
 	if (!current->fs->root) {
 		return -EAGAIN;
 	}
-	if (!(envp = (char **) pnp_bios_kmalloc (20 * sizeof (char *), GFP_KERNEL))) {
+	if (!(envp = (char **) pnpbios_kmalloc (20 * sizeof (char *), GFP_KERNEL))) {
 		return -ENOMEM;
 	}
-	if (!(buf = pnp_bios_kmalloc (256, GFP_KERNEL))) {
+	if (!(buf = pnpbios_kmalloc (256, GFP_KERNEL))) {
 		kfree (envp);
 		return -ENOMEM;
 	}
@@ -579,7 +609,7 @@
 				d = 1;
 				break;
 			default:
-				printk(KERN_WARNING "PnPBIOS: Unexpected error 0x%x returned by BIOS.\n", err);
+				printk(KERN_WARNING "PnPBIOS: pnp_dock_thread: Unexpected status 0x%x returned by BIOS.\n", err);
 				continue;
 		}
 		if(d != docked)
@@ -587,7 +617,9 @@
 			if(pnp_dock_event(d, &now)==0)
 			{
 				docked = d;
-//				printk(KERN_INFO "PnPBIOS: Docking station %stached.\n", docked?"at":"de");
+#if 0
+				printk(KERN_INFO "PnPBIOS: Docking station %stached.\n", docked?"at":"de");
+#endif
 			}
 		}
 	}	
@@ -598,147 +630,62 @@
 
 /*
  *
- * NODE DATA HANDLING FUNCTIONS
+ * NODE DATA PARSING FUNCTIONS
  *
  */
 
-static void inline pnpbios_add_irqresource(struct pci_dev *dev, int irq)
+static void pnpbios_add_irqresource(struct pci_dev *dev, int irq)
 {
-	// Permit irq==-1 which signifies "disabled"
 	int i = 0;
 	while (!(dev->irq_resource[i].flags & IORESOURCE_UNSET) && i < DEVICE_COUNT_IRQ) i++;
 	if (i < DEVICE_COUNT_IRQ) {
-		dev->irq_resource[i].start = irq;
+		dev->irq_resource[i].start = (unsigned long) irq;
 		dev->irq_resource[i].flags = IORESOURCE_IRQ;  // Also clears _UNSET flag
 	}
 }
 
-static void inline pnpbios_add_dmaresource(struct pci_dev *dev, int dma)
+static void pnpbios_add_dmaresource(struct pci_dev *dev, int dma)
 {
-	// Permit dma==-1 which signifies "disabled"
 	int i = 0;
 	while (!(dev->dma_resource[i].flags & IORESOURCE_UNSET) && i < DEVICE_COUNT_DMA) i++;
 	if (i < DEVICE_COUNT_DMA) {
-		dev->dma_resource[i].start = dma;
+		dev->dma_resource[i].start = (unsigned long) dma;
 		dev->dma_resource[i].flags = IORESOURCE_DMA;  // Also clears _UNSET flag
 	}
 }
 
-static void inline pnpbios_add_ioresource(struct pci_dev *dev, int io, int len)
+static void pnpbios_add_ioresource(struct pci_dev *dev, int io, int len)
 {
 	int i = 0;
 	while (!(dev->resource[i].flags & IORESOURCE_UNSET) && i < DEVICE_COUNT_RESOURCE) i++;
 	if (i < DEVICE_COUNT_RESOURCE) {
-		dev->resource[i].start = io;
-		dev->resource[i].end = io + len;
+		dev->resource[i].start = (unsigned long) io;
+		dev->resource[i].end = (unsigned long)(io + len - 1);
 		dev->resource[i].flags = IORESOURCE_IO;  // Also clears _UNSET flag
 	}
 }
 
-static void inline pnpbios_add_memresource(struct pci_dev *dev, int mem, int len)
+static void pnpbios_add_memresource(struct pci_dev *dev, int mem, int len)
 {
 	int i = 0;
 	while (!(dev->resource[i].flags & IORESOURCE_UNSET) && i < DEVICE_COUNT_RESOURCE) i++;
 	if (i < DEVICE_COUNT_RESOURCE) {
-		dev->resource[i].start = mem;
-		dev->resource[i].end = mem + len;
+		dev->resource[i].start = (unsigned long) mem;
+		dev->resource[i].end = (unsigned long)(mem + len - 1);
 		dev->resource[i].flags = IORESOURCE_MEM;  // Also clears _UNSET flag
 	}
 }
 
-/*
- * request I/O ports which are used according to the PnP BIOS
- * to avoid I/O conflicts.
- */
-static void mboard_request(char *pnpid, int io, int len)
-{
-	struct resource *res;
-	char *regionid;
-    
-	if (
-		0 != strcmp(pnpid,"PNP0c01") &&  /* memory controller */
-		0 != strcmp(pnpid,"PNP0c02")     /* system peripheral: other */
-	) {
-		return;
-	}
-
-	if (io < 0x100) {
-		/*
-		 * Below 0x100 is only standard PC hardware
-		 * (pics, kbd, timer, dma, ...)
-		 *
-		 * We should not get resource conflicts there,
-		 * and the kernel reserves these anyway
-		 * (see arch/i386/kernel/setup.c).
-		 */
-		return;
-	}
-
-	/*
-	 * Anything else we'll try reserve to avoid these ranges are
-	 * assigned to someone (CardBus bridges for example) and thus are
-	 * triggering resource conflicts.
-	 *
-	 * Failures at this point are usually harmless. pci quirks for
-	 * example do reserve stuff they know about too, so we might have
-	 * double reservations here.
-	 *
-	 * We really shouldn't just reserve these regions, though, since
-	 * that prevents the device drivers from claiming them.
-	 */
-	regionid = pnp_bios_kmalloc(16, GFP_KERNEL);
-	if ( regionid == NULL )
-		return;
-	sprintf(regionid, "PnPBIOS %s", pnpid);
-	res = request_region(io,len,regionid);
-	if ( res == NULL )
-		kfree( regionid );
-	printk(
-		"PnPBIOS: %s: 0x%x-0x%x %s reserved\n",
-		pnpid, io, io+len-1,
-		NULL != res ? "has been" : "was already"
-	);
-
-	return;
-}
-
-
-#define HEX(id,a) hex[((id)>>a) & 15]
-#define CHAR(id,a) (0x40 + (((id)>>a) & 31))
-
-static char * __init pnpid32_to_pnpid(u32 id)
-{
-	const char *hex = "0123456789abcdef";
-	static char str[8];
-	id = be32_to_cpu(id);
-	str[0] = CHAR(id, 26);
-	str[1] = CHAR(id, 21);
-	str[2] = CHAR(id,16);
-	str[3] = HEX(id, 12);
-	str[4] = HEX(id, 8);
-	str[5] = HEX(id, 4);
-	str[6] = HEX(id, 0);
-	str[7] = '\0';
-	return str;
-}                                              
-
-#undef CHAR
-#undef HEX  
-
-/*
- * parse PNPBIOS "Allocated Resources Block" and fill IO,IRQ,DMA into pci_dev
- */
-static void __init pnpbios_rawdata_2_pci_dev(struct pnp_bios_node *node, struct pci_dev *dev)
+static void pnpbios_node_resource_data_to_dev(struct pnp_bios_node *node, struct pci_dev *dev)
 {
 	unsigned char *p = node->data, *lastp=NULL;
 	int i;
 
 	/*
-	 * First, set dev contents to default values
+	 * First, set resource info to default values
 	 */
-	memset(dev,0,sizeof(struct pci_dev));
 	for (i=0;i<DEVICE_COUNT_RESOURCE;i++) {
-	/*	dev->resource[i].start = 0; */
+		dev->resource[i].start = 0;  // "disabled"
 		dev->resource[i].flags = IORESOURCE_UNSET;
 	}
 	for (i=0;i<DEVICE_COUNT_IRQ;i++) {
@@ -751,7 +698,7 @@
 	}
 
 	/*
-	 * Fill in dev info
+	 * Fill in dev resource info
 	 */
         while ( (char *)p < ((char *)node->data + node->size )) {
         	if(p==lastp) break;
@@ -795,7 +742,7 @@
                 switch (p[0]>>3) {
                 case 0x04: // irq
                 {
-                        int i, mask, irq = -1; // "disabled"
+                        int i, mask, irq = -1;
                         mask= p[1] + p[2]*256;
                         for (i=0;i<16;i++, mask=mask>>1)
                                 if(mask & 0x01) irq=i;
@@ -804,7 +751,7 @@
                 }
                 case 0x05: // dma
                 {
-                        int i, mask, dma = -1; // "disabled"
+                        int i, mask, dma = -1;
                         mask = p[1];
                         for (i=0;i<8;i++, mask = mask>>1)
                                 if(mask & 0x01) dma=i;
@@ -816,7 +763,6 @@
 			int io= p[2] + p[3] *256;
 			int len = p[7];
 			pnpbios_add_ioresource(dev, io, len);
-			mboard_request(pnpid32_to_pnpid(node->eisa_id),io,len);
                         break;
                 }
 		case 0x09: // fixed location io
@@ -843,34 +789,45 @@
 
 static LIST_HEAD(pnpbios_devices);
 
-int pnp_bios_present(void)
-{
-	return (pnp_bios_inst_struc != NULL);
-}
-
-EXPORT_SYMBOL(pnp_bios_present);
-
-static int __init pnpbios_insert_device(struct pci_dev *dev)
+static int inline pnpbios_insert_device(struct pci_dev *dev)
 {
 	/* FIXME: Need to check for re-add of existing node */
 	list_add_tail(&dev->global_list, &pnpbios_devices);
 	return 0;
 }
 
-/*
- *	Build the list of pci_dev objects from the PnP table
- */
- 
+#define HEX(id,a) hex[((id)>>a) & 15]
+#define CHAR(id,a) (0x40 + (((id)>>a) & 31))
+//
+static void inline pnpid32_to_pnpid(u32 id, char *str)
+{
+	const char *hex = "0123456789abcdef";
+
+	id = be32_to_cpu(id);
+	str[0] = CHAR(id, 26);
+	str[1] = CHAR(id, 21);
+	str[2] = CHAR(id,16);
+	str[3] = HEX(id, 12);
+	str[4] = HEX(id, 8);
+	str[5] = HEX(id, 4);
+	str[6] = HEX(id, 0);
+	str[7] = '\0';
+
+	return;
+}                                              
+//
+#undef CHAR
+#undef HEX 
+
 static void __init pnpbios_build_devlist(void)
 {
 	int i;
 	int nodenum;
 	int nodes_got = 0;
+	int devs = 0;
 	struct pnp_bios_node *node;
 	struct pnp_dev_node_info node_info;
 	struct pci_dev *dev;
-	char *pnpid;
-
 	
 	if (!pnp_bios_present ())
 		return;
@@ -878,7 +835,7 @@
 	if (pnp_bios_dev_node_info(&node_info) != 0)
 		return;
 
-	node = pnp_bios_kmalloc(node_info.max_node_size, GFP_KERNEL);
+	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return;
 
@@ -891,22 +848,45 @@
 		if (pnp_bios_get_dev_node((u8 *)&nodenum, (char )1 , node))
 			break;
 		nodes_got++;
-		dev =  pnp_bios_kmalloc(sizeof (struct pci_dev), GFP_KERNEL);
+		dev =  pnpbios_kmalloc(sizeof (struct pci_dev), GFP_KERNEL);
 		if (!dev)
 			break;
-		pnpbios_rawdata_2_pci_dev(node,dev);
+		memset(dev,0,sizeof(struct pci_dev));
 		dev->devfn=thisnodenum;
-		pnpid = pnpid32_to_pnpid(node->eisa_id);
 		memcpy(dev->name,"PNPBIOS",8);
-		memcpy(dev->slot_name,pnpid,8);
+		pnpid32_to_pnpid(node->eisa_id,dev->slot_name);
+		pnpbios_node_resource_data_to_dev(node,dev);
 		if(pnpbios_insert_device(dev)<0)
 			kfree(dev);
+		devs++;
 	}
 	kfree(node);
 
-	printk(KERN_INFO "PnPBIOS: %i node%s reported by PnP BIOS\n", nodes_got, nodes_got != 1 ? "s" : "");
+	printk(KERN_INFO "PnPBIOS: %i node%s reported by PnP BIOS; %i recorded by driver.\n",
+		nodes_got, nodes_got != 1 ? "s" : "", devs);
 }
 
+static struct pci_dev *pnpbios_find_device_by_nodenum( u8 nodenum )
+{
+	struct pci_dev *dev;
+
+	pnpbios_for_each_dev(dev) {
+		if(dev->devfn == nodenum)
+			return dev;
+	}
+
+	return NULL;
+}
+
+static void pnpbios_update_devlist( u8 nodenum, struct pnp_bios_node *data )
+{
+	struct pci_dev *dev = pnpbios_find_device_by_nodenum( nodenum );
+	if ( dev ) {
+		pnpbios_node_resource_data_to_dev(data,dev);
+	}
+
+	return;
+}
 
 /*
  *
@@ -920,22 +900,19 @@
 struct pci_dev *pnpbios_find_device(char *pnpid, struct pci_dev *prev)
 {
 	struct pci_dev *dev;
-	int num;
-
-	if(prev==NULL)
-		num=0; /* Start from beginning */
-	else
-		num=prev->devfn + 1; /* Encode node number here */
+	int nodenum;
 
+	nodenum = 0;
+	if(prev)
+		nodenum=prev->devfn + 1; /* Encode node number here */
 
-	pnpbios_for_each_dev(dev)
-	{
-		if(dev->devfn >= num)
-		{
+	pnpbios_for_each_dev(dev) {
+		if(dev->devfn >= nodenum) {
 			if(memcmp(dev->slot_name, pnpid, 7)==0)
 				return dev;
 		}
 	}
+
 	return NULL;
 }
 
@@ -969,8 +946,7 @@
 	return NULL;
 }
 
-static int
-pnpbios_announce_device(struct pnpbios_driver *drv, struct pci_dev *dev)
+int pnpbios_announce_device(struct pnpbios_driver *drv, struct pci_dev *dev)
 {
 	const struct pnpbios_device_id *id;
 	int ret = 0;
@@ -1049,54 +1025,158 @@
 
 EXPORT_SYMBOL(pnpbios_unregister_driver);
 
+/*
+ *
+ * RESOURCE RESERVATION FUNCTIONS
+ *
+ */
+
+static void __init pnpbios_reserve_ioport_range(char *pnpid, int start, int end)
+{
+	struct resource *res;
+	char *regionid;
+
+	regionid = pnpbios_kmalloc(16, GFP_KERNEL);
+	if ( regionid == NULL )
+		return;
+	sprintf(regionid, "PnPBIOS %s", pnpid);
+	res = request_region(start,end-start+1,regionid);
+	if ( res == NULL )
+		kfree( regionid );
+	/*
+	 * Failures at this point are usually harmless. pci quirks for
+	 * example do reserve stuff they know about too, so we may well
+	 * have double reservations.
+	 */
+	printk(KERN_INFO
+		"PnPBIOS: %s: ioport range 0x%x-0x%x %s reserved\n",
+		pnpid, start, end,
+		NULL != res ? "has been" : "could not be"
+	);
+
+	return;
+}
+
+static void __init pnpbios_reserve_resources_of_dev( struct pci_dev *dev )
+{
+	int i;
+
+	for (i=0;i<DEVICE_COUNT_RESOURCE;i++) {
+		if ( dev->resource[i].flags & IORESOURCE_UNSET )
+			/* end of resources */
+			break;
+		if (dev->resource[i].flags & IORESOURCE_IO) {
+			/* ioport */
+			if ( dev->resource[i].start == 0 )
+				/* disabled */
+				/* Do nothing */
+				continue;
+			if ( dev->resource[i].start < 0x100 )
+				/*
+				 * Below 0x100 is only standard PC hardware
+				 * (pics, kbd, timer, dma, ...)
+				 * We should not get resource conflicts there,
+				 * and the kernel reserves these anyway
+				 * (see arch/i386/kernel/setup.c).
+				 * So, do nothing
+				 */
+				continue;
+			if ( dev->resource[i].end < dev->resource[i].start )
+				/* invalid endpoint */
+				/* Do nothing */
+				continue;
+			pnpbios_reserve_ioport_range(
+				dev->slot_name,
+				dev->resource[i].start,
+				dev->resource[i].end
+			);
+		} else if (dev->resource[i].flags & IORESOURCE_MEM) {
+			/* memory */
+			/* For now do nothing */
+			continue;
+		} else {
+			/* Neither ioport nor memory */
+			/* Do nothing */
+			continue;
+		}
+	}
+
+	return;
+}
+
+/*
+ * Reserve resources used by system board devices
+ *
+ * We really shouldn't just _reserve_ these regions since
+ * that prevents the device drivers from claiming them.
+ */
+static void __init pnpbios_reserve_resources( void )
+{
+	struct pci_dev *dev;
+
+	pnpbios_for_each_dev(dev) {
+		if (
+			0 != strcmp(dev->slot_name,"PNP0c01") &&  /* memory controller */
+			0 != strcmp(dev->slot_name,"PNP0c02")     /* system peripheral: other */
+		) {
+			continue;
+		}  
+		pnpbios_reserve_resources_of_dev(dev);
+	}
+
+	return;
+}
+
 /* 
  *
  * INIT AND EXIT
  *
  *
- * Search the defined area (0xf0000-0xffff0) for a valid PnP BIOS
- * structure and, if one is found, sets up the selectors and
- * entry points
  */
 
 extern int is_sony_vaio_laptop;
 
-static int pnp_bios_disabled;
-static int pnp_bios_dont_use_current_config;
+static int pnpbios_disabled;
+int pnpbios_dont_use_current_config;
 
-static int disable_pnp_bios(char *str)
+static int __init pnpbios_disable_pnp_bios(char *str)
 {
-	pnp_bios_disabled=1;
+	pnpbios_disabled=1;
 	return 0;
 }
 
-static int disable_use_of_current_config(char *str)
+static int __init pnpbios_disable_use_of_current_config(char *str)
 {
-	pnp_bios_dont_use_current_config=1;
+	pnpbios_dont_use_current_config=1;
 	return 0;
 }
 
-__setup("nobiospnp", disable_pnp_bios);
-__setup("nobioscurrpnp", disable_use_of_current_config);
+__setup("nobiospnp", pnpbios_disable_pnp_bios);
+__setup("nobioscurrpnp", pnpbios_disable_use_of_current_config);
 
-void pnp_bios_init(void)
+void __init pnpbios_init(void)
 {
-	union pnpbios *check;
+	union pnp_bios_expansion_header *check;
 	u8 sum;
 	int i, length;
 
 	spin_lock_init(&pnp_bios_lock);
 
-	if(pnp_bios_disabled) {
+	if(pnpbios_disabled) {
 		printk(KERN_INFO "PnPBIOS: Disabled.\n");
 		return;
 	}
 
 	if ( is_sony_vaio_laptop )
-		pnp_bios_dont_use_current_config = 1;
+		pnpbios_dont_use_current_config = 1;
 
-	for (check = (union pnpbios *) __va(0xf0000);
-	     check < (union pnpbios *) __va(0xffff0);
+	/*
+ 	 * Search the defined area (0xf0000-0xffff0) for a valid PnP BIOS
+	 * structure and, if one is found, sets up the selectors and
+	 * entry points
+	 */
+	for (check = (union pnp_bios_expansion_header *) __va(0xf0000);
+	     check < (union pnp_bios_expansion_header *) __va(0xffff0);
 	     ((void *) (check)) += 16) {
 		if (check->fields.signature != PNP_SIGNATURE)
 			continue;
@@ -1123,12 +1203,14 @@
 		Q_SET_SEL(PNP_DS, check->fields.pm16dseg, 64 * 1024);
 		pnp_bios_callpoint.offset = check->fields.pm16offset;
 		pnp_bios_callpoint.segment = PNP_CS16;
-		pnp_bios_inst_struc = check;
+		pnp_bios_hdr = check;
 		break;
 	}
+
 	pnpbios_build_devlist();
+	pnpbios_reserve_resources();
 #ifdef CONFIG_PROC_FS
-	pnp_proc_init( pnp_bios_dont_use_current_config );
+	pnpbios_proc_init();
 #endif
 #ifdef CONFIG_HOTPLUG	
 	init_completion(&unload_sem);
@@ -1142,16 +1224,18 @@
 MODULE_LICENSE("GPL");
 
 /* We have to run it early and specifically in non modular.. */
-module_init(pnp_bios_init);
+module_init(pnpbios_init);
 
 #ifdef CONFIG_HOTPLUG
-static void pnp_bios_exit(void)
+static void pnpbios_exit(void)
 {
+	/* free_resources() ought to go here */
+	/* pnpbios_proc_done() */
 	unloading = 1;
 	wait_for_completion(&unload_sem);
 }
 
-module_exit(pnp_bios_exit);
+module_exit(pnpbios_exit);
 
 #endif
 #endif
--- linux-2.4.12-ac4/drivers/pnp/pnp_proc.c	Wed Oct 10 22:09:19 2001
+++ linux-2.4.12-ac4-fix/drivers/pnp/pnp_proc.c	Sun Oct 21 22:48:59 2001
@@ -31,7 +31,7 @@
 	    *eof = 1;
 	    return 0;
 	}
-	node = kmalloc(node_info.max_node_size, GFP_KERNEL);
+	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node) return -ENOMEM;
 	for (i=0,nodenum=0;i<0xff && nodenum!=0xff; i++) {
 		if ( pnp_bios_get_dev_node(&nodenum, 1, node) )
@@ -57,7 +57,7 @@
 	    *eof = 1;
 	    return 0;
 	}
-	node = kmalloc(node_info.max_node_size, GFP_KERNEL);
+	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node) return -ENOMEM;
 	if ( pnp_bios_get_dev_node(&nodenum, boot, node) )
 		return -EIO;
@@ -74,7 +74,7 @@
 	int boot = (long)data >> 8;
 	u8 nodenum = (long)data;
 
-	node = kmalloc(node_info.max_node_size, GFP_KERNEL);
+	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node) return -ENOMEM;
 	if ( pnp_bios_get_dev_node(&nodenum, boot, node) )
 		return -EIO;
@@ -87,9 +87,12 @@
 	return count;
 }
 
-static int pnp_proc_dont_use_current_config;
-
-void pnp_proc_init( int dont_use_current )
+/*
+ * When this is called, pnpbios functions are assumed to
+ * work and the pnpbios_dont_use_current_config flag
+ * should already have been set to the appropriate value
+ */
+void pnpbios_proc_init( void )
 {
 	struct pnp_bios_node *node;
 	struct proc_dir_entry *ent;
@@ -97,9 +100,6 @@
 	int i;
 	u8 nodenum;
 
-	pnp_proc_dont_use_current_config = dont_use_current;
-
-	if (!pnp_bios_present()) return;
 	if (pnp_bios_dev_node_info(&node_info) != 0) return;
 	
 	proc_pnp = proc_mkdir("pnp", proc_bus);
@@ -108,13 +108,13 @@
 	if (!proc_pnp_boot) return;
 	create_proc_read_entry("devices", 0, proc_pnp, proc_read_devices, NULL);
 	
-	node = kmalloc(node_info.max_node_size, GFP_KERNEL);
+	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node) return;
 	for (i=0,nodenum = 0; i<0xff && nodenum != 0xff; i++) {
 		if (pnp_bios_get_dev_node(&nodenum, 1, node) != 0)
 			break;
 		sprintf(name, "%02x", node->handle);
-		if ( !pnp_proc_dont_use_current_config ) {
+		if ( !pnpbios_dont_use_current_config ) {
 			ent = create_proc_entry(name, 0, proc_pnp);
 			if (ent) {
 				ent->read_proc = proc_read_node;
@@ -132,7 +132,7 @@
 	kfree(node);
 }
 
-void pnp_proc_done(void)
+void pnpbios_proc_done(void)
 {
 	int i;
 	char name[3];
@@ -141,7 +141,7 @@
 
 	for (i=0; i<0xff; i++) {
 		sprintf(name, "%02x", i);
-		if ( !pnp_proc_dont_use_current_config )
+		if ( !pnpbios_dont_use_current_config )
 			remove_proc_entry(name, proc_pnp);
 		remove_proc_entry(name, proc_pnp_boot);
 	}

