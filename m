Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277222AbRJQVQ3>; Wed, 17 Oct 2001 17:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277219AbRJQVQN>; Wed, 17 Oct 2001 17:16:13 -0400
Received: from sushi.toad.net ([162.33.130.105]:57240 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S277222AbRJQVP6>;
	Wed, 17 Oct 2001 17:15:58 -0400
Subject: PnP BIOS patch #4
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 17 Oct 2001 17:15:41 -0400
Message-Id: <1003353343.743.39.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I guess I'll start numbering these patch versions so we can
tell them apart.)

Here's another version of the PnP BIOS patch with a few
aesthetic improvements, no functional changes.  I'll wait
for some version of this patch to get into an -ac release
before making any more big changes.

The patch:
--- linux-2.4.12-ac2/init/main.c	Sun Oct 14 15:39:55 2001
+++ linux-2.4.12-ac2-fix/init/main.c	Sun Oct 14 15:59:44 2001
@@ -822,7 +822,7 @@
 	isapnp_init();
 #endif
 #ifdef CONFIG_PNPBIOS
-        pnp_bios_init();
+        pnpbios_init();
 #endif
 
 #ifdef CONFIG_TC
--- linux-2.4.12-ac2/include/linux/pnp_bios.h	Wed Oct 10 22:09:57 2001
+++ linux-2.4.12-ac2-fix/include/linux/pnp_bios.h	Mon Oct 15 23:04:21 2001
@@ -132,30 +132,37 @@
 	return (struct pnpbios_driver *)dev->driver;
 }
 
-extern void pnp_bios_init (void);
-extern int pnp_bios_dev_node_info (struct pnp_dev_node_info *data);
-extern int pnp_bios_get_dev_node (u8 *nodenum, char config, struct pnp_bios_node *data);
-extern int pnp_bios_set_dev_node (u8 nodenum, char config, struct pnp_bios_node *data);
-extern int pnp_bios_get_event (u16 *message);
-extern int pnp_bios_send_message (u16 message);
-extern int pnp_bios_set_stat_res (char *info);
-extern int pnp_bios_get_stat_res (char *info);
-extern int pnp_bios_apm_id_table (char *table, u16 *size);
-extern int pnp_bios_isapnp_config (struct pnp_isa_config_struc *data);
-extern int pnp_bios_escd_info (struct escd_info_struc *data);
-extern int pnp_bios_read_escd (char *data, u32 nvram_base);
-extern int pnp_bios_write_escd (char *data, u32 nvram_base);
-
-extern void pnp_proc_init ( int dont_use_current );
-
 #ifdef CONFIG_PNPBIOS
 #define pnpbios_for_each_dev(dev) \
 	for(dev = pnpbios_dev_g(pnpbios_devices.next); dev != pnpbios_dev_g(&pnpbios_devices); dev = pnpbios_dev_g(dev->global_list.next))
-extern int pnp_bios_present (void);
+
+/* exported functions */
 extern struct pci_dev *pnpbios_find_device(char *pnpid, struct pci_dev *dev);
-extern int pnpbios_register_driver(struct pnpbios_driver *drv);
+extern int  pnpbios_announce_device(struct pnpbios_driver *drv, struct pci_dev *dev);
+extern int  pnpbios_register_driver(struct pnpbios_driver *drv);
 extern void pnpbios_unregister_driver(struct pnpbios_driver *drv);
 
+/* non-exported functions */
+extern int  pnpbios_dont_use_current_config;
+extern void *pnpbios_kmalloc(size_t size, int f);
+extern void pnpbios_init (void);
+extern void pnpbios_proc_init (void);
+
+extern int pnpbios_dev_node_info (struct pnp_dev_node_info *data);
+extern int pnpbios_get_dev_node (u8 *nodenum, char config, struct pnp_bios_node *data);
+extern int pnpbios_set_dev_node (u8 nodenum, char config, struct pnp_bios_node *data);
+#if needed
+extern int pnpbios_get_event (u16 *message);
+extern int pnpbios_send_message (u16 message);
+extern int pnpbios_set_stat_res (char *info);
+extern int pnpbios_get_stat_res (char *info);
+extern int pnpbios_apm_id_table (char *table, u16 *size);
+extern int pnpbios_isapnp_config (struct pnp_isa_config_struc *data);
+extern int pnpbios_escd_info (struct escd_info_struc *data);
+extern int pnpbios_read_escd (char *data, u32 nvram_base);
+extern int pnpbios_write_escd (char *data, u32 nvram_base);
+#endif
+
 /*
  * a helper function which helps ensure correct pnpbios_driver
  * setup and cleanup for commonly-encountered hotplug/modular cases
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
--- linux-2.4.12-ac2/drivers/pnp/pnp_bios.c	Wed Oct 10 22:09:19 2001
+++ linux-2.4.12-ac2-fix/drivers/pnp/pnp_bios.c	Wed Oct 17 12:35:43 2001
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
@@ -228,18 +238,29 @@
 }
 
 /*
+ * Call this only after init time
+ */
+static int pnp_bios_is_present(void)
+{
+	return (pnp_bios_hdr != NULL);
+}
+
+/*
  *
  * PnP BIOS ACCESS FUNCTIONS
  *
+ * pnp_bios_*  are local functions used to call the BIOS
+ * pnpbios_* are the public interface to these functions
+ *
  */
 
 /*
  * Call PnP BIOS with function 0x00, "get number of system device nodes"
  */
-static int pnp_bios_dev_node_info_silently(struct pnp_dev_node_info *data)
+static int pnp_bios_dev_node_info(struct pnp_dev_node_info *data)
 {
 	u16 status;
-	if (!pnp_bios_present ())
+	if (!pnp_bios_is_present ())
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	Q2_SET_SEL(PNP_TS1, data, sizeof(struct pnp_dev_node_info));
 	status = call_pnp_bios(PNP_GET_NUM_SYS_DEV_NODES, 0, PNP_TS1, 2, PNP_TS1, PNP_DS, 0, 0);
@@ -247,11 +268,11 @@
 	return status;
 }
 
-int pnp_bios_dev_node_info(struct pnp_dev_node_info *data)
+int pnpbios_dev_node_info(struct pnp_dev_node_info *data)
 {
-	u16 status = pnp_bios_dev_node_info_silently( data );
+	int status = pnp_bios_dev_node_info( data );
 	if ( status )
-		printk(KERN_WARNING "PnPBIOS: PnP BIOS dev_node_info function returned error status 0x%x\n", status);
+		printk(KERN_WARNING "PnPBIOS: dev_node_info: Unexpected status 0x%x\n", status);
 	return status;
 }
 
@@ -269,22 +290,25 @@
  *               or volatile current (0) config
  * Output: *nodenum=next node or 0xff if no more nodes
  */
-static int pnp_bios_get_dev_node_silently(u8 *nodenum, char boot, struct pnp_bios_node *data)
+static int pnp_bios_get_dev_node(u8 *nodenum, char boot, struct pnp_bios_node *data)
 {
 	u16 status;
-	if (!pnp_bios_present ())
-		return PNP_FUNCTION_NOT_SUPPORTED;
 	Q2_SET_SEL(PNP_TS1, nodenum, sizeof(char));
 	Q2_SET_SEL(PNP_TS2, data, 64 * 1024);
 	status = call_pnp_bios(PNP_GET_SYS_DEV_NODE, 0, PNP_TS1, 0, PNP_TS2, boot ? 2 : 1, PNP_DS, 0);
 	return status;
 }
 
-int pnp_bios_get_dev_node(u8 *nodenum, char boot, struct pnp_bios_node *data)
+int pnpbios_get_dev_node(u8 *nodenum, char boot, struct pnp_bios_node *data)
 {
-	u16 status =  pnp_bios_get_dev_node_silently( nodenum, boot, data );
+	int status;
+	if (!pnp_bios_is_present ())
+		return PNP_FUNCTION_NOT_SUPPORTED;
+	if ( !boot & pnpbios_dont_use_current_config )
+		return PNP_FUNCTION_NOT_SUPPORTED;
+	status =  pnp_bios_get_dev_node( nodenum, boot, data );
 	if ( status )
-		printk(KERN_WARNING "PnPBIOS: PnP BIOS get_dev_node function returned error status 0x%x\n", status);
+		printk(KERN_WARNING "PnPBIOS: get_dev_node: Unexpected 0x%x\n", status);
 	return status;
 }
 
@@ -294,21 +318,35 @@
  *        boot = whether to set nonvolatile boot (!=0)
  *               or volatile current (0) config
  */
-static int pnp_bios_set_dev_node_silently(u8 nodenum, char boot, struct pnp_bios_node *data)
+static int pnp_bios_set_dev_node(u8 nodenum, char boot, struct pnp_bios_node *data)
 {
 	u16 status;
-	if (!pnp_bios_present ())
-		return PNP_FUNCTION_NOT_SUPPORTED;
 	Q2_SET_SEL(PNP_TS1, data, /* *((u16 *) data)*/ 65536);
 	status = call_pnp_bios(PNP_SET_SYS_DEV_NODE, nodenum, 0, PNP_TS1, boot ? 2 : 1, PNP_DS, 0, 0);
 	return status;
 }
 
-int pnp_bios_set_dev_node(u8 nodenum, char boot, struct pnp_bios_node *data)
+int pnpbios_set_dev_node(u8 nodenum, char boot, struct pnp_bios_node *data)
 {
-	u16 status =  pnp_bios_set_dev_node_silently( nodenum, boot, data );
-	if ( status )
-		printk(KERN_WARNING "PnPBIOS: PnP BIOS set_dev_node function returned error status 0x%x\n", status);
+	int status;
+	if (!pnp_bios_is_present ())
+		return PNP_FUNCTION_NOT_SUPPORTED;
+	if ( !boot & pnpbios_dont_use_current_config )
+		return PNP_FUNCTION_NOT_SUPPORTED;
+	status =  pnp_bios_set_dev_node( nodenum, boot, data );
+	if ( status ) {
+		printk(KERN_WARNING "PnPBIOS: set_dev_node: Unexpected set_dev_node status 0x%x\n", status);
+		return status;
+	}
+	if ( !boot ) { /* Update devlist */
+		u8 thisnodenum = nodenum;
+		status =  pnp_bios_get_dev_node( &nodenum, boot, data );
+		if ( status ) {
+			printk(KERN_WARNING "PnPBIOS: set_dev_node: Unexpected get_dev_node status 0x%x\n", status);
+			return status;
+		}
+		pnpbios_update_devlist( thisnodenum, data );
+	}
 	return status;
 }
 
@@ -319,7 +357,7 @@
 static int pnp_bios_get_event(u16 *event)
 {
 	u16 status;
-	if (!pnp_bios_present ())
+	if (!pnp_bios_is_present ())
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	Q2_SET_SEL(PNP_TS1, event, sizeof(u16));
 	status = call_pnp_bios(PNP_GET_EVENT, 0, PNP_TS1, PNP_DS, 0, 0 ,0 ,0);
@@ -334,7 +372,7 @@
 static int pnp_bios_send_message(u16 message)
 {
 	u16 status;
-	if (!pnp_bios_present ())
+	if (!pnp_bios_is_present ())
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	status = call_pnp_bios(PNP_SEND_MESSAGE, message, PNP_DS, 0, 0, 0, 0, 0);
 	return status;
@@ -348,7 +386,7 @@
 static int pnp_bios_dock_station_info(struct pnp_docking_station_info *data)
 {
 	u16 status;
-	if (!pnp_bios_present ())
+	if (!pnp_bios_is_present ())
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	Q2_SET_SEL(PNP_TS1, data, sizeof(struct pnp_docking_station_info));
 	status = call_pnp_bios(PNP_GET_DOCKING_STATION_INFORMATION, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0);
@@ -364,7 +402,7 @@
 static int pnp_bios_set_stat_res(char *info)
 {
 	u16 status;
-	if (!pnp_bios_present ())
+	if (!pnp_bios_is_present ())
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	Q2_SET_SEL(PNP_TS1, info, *((u16 *) info));
 	status = call_pnp_bios(PNP_SET_STATIC_ALLOCED_RES_INFO, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0);
@@ -380,7 +418,7 @@
 static int pnp_bios_get_stat_res(char *info)
 {
 	u16 status;
-	if (!pnp_bios_present ())
+	if (!pnp_bios_is_present ())
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	Q2_SET_SEL(PNP_TS1, info, 64 * 1024);
 	status = call_pnp_bios(PNP_GET_STATIC_ALLOCED_RES_INFO, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0);
@@ -395,7 +433,7 @@
 static int pnp_bios_apm_id_table(char *table, u16 *size)
 {
 	u16 status;
-	if (!pnp_bios_present ())
+	if (!pnp_bios_is_present ())
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	Q2_SET_SEL(PNP_TS1, table, *size);
 	Q2_SET_SEL(PNP_TS2, size, sizeof(u16));
@@ -411,7 +449,7 @@
 static int pnp_bios_isapnp_config(struct pnp_isa_config_struc *data)
 {
 	u16 status;
-	if (!pnp_bios_present ())
+	if (!pnp_bios_is_present ())
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	Q2_SET_SEL(PNP_TS1, data, sizeof(struct pnp_isa_config_struc));
 	status = call_pnp_bios(PNP_GET_PNP_ISA_CONFIG_STRUC, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0);
@@ -426,7 +464,7 @@
 static int pnp_bios_escd_info(struct escd_info_struc *data)
 {
 	u16 status;
-	if (!pnp_bios_present ())
+	if (!pnp_bios_is_present ())
 		return ESCD_FUNCTION_NOT_SUPPORTED;
 	Q2_SET_SEL(PNP_TS1, data, sizeof(struct escd_info_struc));
 	status = call_pnp_bios(PNP_GET_ESCD_INFO, 0, PNP_TS1, 2, PNP_TS1, 4, PNP_TS1, PNP_DS);
@@ -442,7 +480,7 @@
 static int pnp_bios_read_escd(char *data, u32 nvram_base)
 {
 	u16 status;
-	if (!pnp_bios_present ())
+	if (!pnp_bios_is_present ())
 		return ESCD_FUNCTION_NOT_SUPPORTED;
 	Q2_SET_SEL(PNP_TS1, data, 64 * 1024);
 	set_base(gdt[PNP_TS2 >> 3], nvram_base);
@@ -459,7 +497,7 @@
 static int pnp_bios_write_escd(char *data, u32 nvram_base)
 {
 	u16 status;
-	if (!pnp_bios_present ())
+	if (!pnp_bios_is_present ())
 		return ESCD_FUNCTION_NOT_SUPPORTED;
 	Q2_SET_SEL(PNP_TS1, data, 64 * 1024);
 	set_base(gdt[PNP_TS2 >> 3], nvram_base);
@@ -469,10 +507,6 @@
 }
 #endif
 
-EXPORT_SYMBOL(pnp_bios_dev_node_info);
-EXPORT_SYMBOL(pnp_bios_get_dev_node);
-EXPORT_SYMBOL(pnp_bios_set_dev_node);
-
 /*
  *
  * PnP DOCKING FUNCTIONS
@@ -482,7 +516,6 @@
 #ifdef CONFIG_HOTPLUG
 
 static int unloading = 0;
-
 static struct completion unload_sem;
 
 /*
@@ -499,10 +532,10 @@
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
@@ -579,7 +612,7 @@
 				d = 1;
 				break;
 			default:
-				printk(KERN_WARNING "PnPBIOS: Unexpected error 0x%x returned by BIOS.\n", err);
+				printk(KERN_WARNING "PnPBIOS: pnp_dock_thread: Unexpected status 0x%x returned by BIOS.\n", err);
 				continue;
 		}
 		if(d != docked)
@@ -587,7 +620,9 @@
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
@@ -598,147 +633,62 @@
 
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
@@ -751,7 +701,7 @@
 	}
 
 	/*
-	 * Fill in dev info
+	 * Fill in dev resource info
 	 */
         while ( (char *)p < ((char *)node->data + node->size )) {
         	if(p==lastp) break;
@@ -795,7 +745,7 @@
                 switch (p[0]>>3) {
                 case 0x04: // irq
                 {
-                        int i, mask, irq = -1; // "disabled"
+                        int i, mask, irq = -1;
                         mask= p[1] + p[2]*256;
                         for (i=0;i<16;i++, mask=mask>>1)
                                 if(mask & 0x01) irq=i;
@@ -804,7 +754,7 @@
                 }
                 case 0x05: // dma
                 {
-                        int i, mask, dma = -1; // "disabled"
+                        int i, mask, dma = -1;
                         mask = p[1];
                         for (i=0;i<8;i++, mask = mask>>1)
                                 if(mask & 0x01) dma=i;
@@ -816,7 +766,6 @@
 			int io= p[2] + p[3] *256;
 			int len = p[7];
 			pnpbios_add_ioresource(dev, io, len);
-			mboard_request(pnpid32_to_pnpid(node->eisa_id),io,len);
                         break;
                 }
 		case 0x09: // fixed location io
@@ -843,42 +792,53 @@
 
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
 	
-	if (!pnp_bios_present ())
+	if (!pnp_bios_is_present ())
 		return;
 
 	if (pnp_bios_dev_node_info(&node_info) != 0)
 		return;
 
-	node = pnp_bios_kmalloc(node_info.max_node_size, GFP_KERNEL);
+	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return;
 
@@ -891,22 +851,45 @@
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
+}
+
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
 }
 
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
@@ -920,22 +903,19 @@
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
 
@@ -969,8 +949,7 @@
 	return NULL;
 }
 
-static int
-pnpbios_announce_device(struct pnpbios_driver *drv, struct pci_dev *dev)
+int pnpbios_announce_device(struct pnpbios_driver *drv, struct pci_dev *dev)
 {
 	const struct pnpbios_device_id *id;
 	int ret = 0;
@@ -1049,54 +1028,158 @@
 
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
@@ -1123,12 +1206,14 @@
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
@@ -1142,16 +1227,18 @@
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
--- linux-2.4.12-ac2/drivers/pnp/pnp_proc.c	Wed Oct 10 22:09:19 2001
+++ linux-2.4.12-ac2-fix/drivers/pnp/pnp_proc.c	Sun Oct 14 15:59:44 2001
@@ -31,10 +31,10 @@
 	    *eof = 1;
 	    return 0;
 	}
-	node = kmalloc(node_info.max_node_size, GFP_KERNEL);
+	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node) return -ENOMEM;
 	for (i=0,nodenum=0;i<0xff && nodenum!=0xff; i++) {
-		if ( pnp_bios_get_dev_node(&nodenum, 1, node) )
+		if ( pnpbios_get_dev_node(&nodenum, 1, node) )
 			break;
 		p += sprintf(p, "%02x\t%08x\t%02x:%02x:%02x\t%04x\n",
 			     node->handle, node->eisa_id,
@@ -57,9 +57,9 @@
 	    *eof = 1;
 	    return 0;
 	}
-	node = kmalloc(node_info.max_node_size, GFP_KERNEL);
+	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node) return -ENOMEM;
-	if ( pnp_bios_get_dev_node(&nodenum, boot, node) )
+	if ( pnpbios_get_dev_node(&nodenum, boot, node) )
 		return -EIO;
 	len = node->size - sizeof(struct pnp_bios_node);
 	memcpy(buf, node->data, len);
@@ -74,22 +74,25 @@
 	int boot = (long)data >> 8;
 	u8 nodenum = (long)data;
 
-	node = kmalloc(node_info.max_node_size, GFP_KERNEL);
+	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node) return -ENOMEM;
-	if ( pnp_bios_get_dev_node(&nodenum, boot, node) )
+	if ( pnpbios_get_dev_node(&nodenum, boot, node) )
 		return -EIO;
 	if (count != node->size - sizeof(struct pnp_bios_node))
 		return -EINVAL;
 	memcpy(node->data, buf, count);
-	if (pnp_bios_set_dev_node(node->handle, boot, node) != 0)
+	if (pnpbios_set_dev_node(node->handle, boot, node) != 0)
 	    return -EINVAL;
 	kfree(node);
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
@@ -97,10 +100,7 @@
 	int i;
 	u8 nodenum;
 
-	pnp_proc_dont_use_current_config = dont_use_current;
-
-	if (!pnp_bios_present()) return;
-	if (pnp_bios_dev_node_info(&node_info) != 0) return;
+	if (pnpbios_dev_node_info(&node_info) != 0) return;
 	
 	proc_pnp = proc_mkdir("pnp", proc_bus);
 	if (!proc_pnp) return;
@@ -108,13 +108,13 @@
 	if (!proc_pnp_boot) return;
 	create_proc_read_entry("devices", 0, proc_pnp, proc_read_devices, NULL);
 	
-	node = kmalloc(node_info.max_node_size, GFP_KERNEL);
+	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node) return;
 	for (i=0,nodenum = 0; i<0xff && nodenum != 0xff; i++) {
-		if (pnp_bios_get_dev_node(&nodenum, 1, node) != 0)
+		if (pnpbios_get_dev_node(&nodenum, 1, node) != 0)
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



