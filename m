Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292035AbSCIAnW>; Fri, 8 Mar 2002 19:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292082AbSCIAnO>; Fri, 8 Mar 2002 19:43:14 -0500
Received: from jhuml3.jhu.edu ([128.220.2.66]:1005 "EHLO jhuml3.jhu.edu")
	by vger.kernel.org with ESMTP id <S292035AbSCIAm4>;
	Fri, 8 Mar 2002 19:42:56 -0500
Date: Fri, 08 Mar 2002 19:43:56 -0500
From: Thomas Hood <jdthood@mail.com>
Subject: Re: PnP BIOS driver status
In-Reply-To: <20020309001454.D15106@suse.de>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <1015634636.24247.74.camel@thanatos>
MIME-version: 1.0
X-Mailer: Evolution/1.0.2
Content-type: text/plain
Content-transfer-encoding: 7bit
In-Reply-To: <1015628440.14518.212.camel@thanatos>
 <20020309001454.D15106@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-03-08 at 18:14, Dave Jones wrote:
>  The bits that handle ESCD ? I merged that.

Here are the additional bits from the -ac tree, diffed
against 2.5.6 + 2.5.5-dj3 patch.  The changes include:

- Improve some comments
- Postpone starting the kernel thread (Alan Cox)
- Call kernel thread 'kpnpbiosd' instead of 'kpnpbios'
- Consolidate printing of error messages to save space
- Add __init and __exit tags and return appropriate error codes
- Print slightly more consistent messages
- Get closer to supporting build-as-module

--
Thomas

--- linux-2.5.6_2.5.5-dj3/include/linux/pnpbios.h_DJ	Fri Mar  8 18:37:58 2002
+++ linux-2.5.6_2.5.5-dj3/include/linux/pnpbios.h	Fri Mar  8 19:12:25 2002
@@ -143,7 +143,8 @@
 extern int  pnpbios_dont_use_current_config;
 extern void *pnpbios_kmalloc(size_t size, int f);
 extern int pnpbios_init (void);
-extern void pnpbios_proc_init (void);
+extern int pnpbios_proc_init (void);
+extern void pnpbios_proc_exit (void);
 
 extern int pnp_bios_dev_node_info (struct pnp_dev_node_info *data);
 extern int pnp_bios_get_dev_node (u8 *nodenum, char config, struct pnp_bios_node *data);
--- linux-2.5.6_2.5.5-dj3/drivers/pnp/pnpbios_core.c_DJ	Fri Mar  8 18:40:02 2002
+++ linux-2.5.6_2.5.5-dj3/drivers/pnp/pnpbios_core.c	Fri Mar  8 19:09:39 2002
@@ -4,7 +4,7 @@
  * Originally (C) 1998 Christian Schmidt <schmidt@digadd.de>
  * Modifications (c) 1998 Tom Lees <tom@lpsg.demon.co.uk>
  * Minor reorganizations by David Hinds <dahinds@users.sourceforge.net>
- * Modifications (c) 2001 by Thomas Hood <jdthood@mail.com>
+ * Modifications (c) 2001,2002 by Thomas Hood <jdthood@mail.com>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -205,6 +205,11 @@
  *
  */
 
+static void pnpbios_warn_unexpected_status(const char * module, u16 status)
+{
+	printk(KERN_ERR "PnPBIOS: %s: Unexpected status 0x%x\n", module, status);
+}
+
 void *pnpbios_kmalloc(size_t size, int f)
 {
 	void *p = kmalloc( size, f );
@@ -251,7 +256,7 @@
 static int __pnp_bios_dev_node_info(struct pnp_dev_node_info *data)
 {
 	u16 status;
-	if (!pnp_bios_present ())
+	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	Q2_SET_SEL(PNP_TS1, data, sizeof(struct pnp_dev_node_info));
 	status = call_pnp_bios(PNP_GET_NUM_SYS_DEV_NODES, 0, PNP_TS1, 2, PNP_TS1, PNP_DS, 0, 0);
@@ -263,7 +268,7 @@
 {
 	int status = __pnp_bios_dev_node_info( data );
 	if ( status )
-		printk(KERN_WARNING "PnPBIOS: dev_node_info: Unexpected status 0x%x\n", status);
+		pnpbios_warn_unexpected_status( "dev_node_info", status );
 	return status;
 }
 
@@ -284,7 +289,7 @@
 static int __pnp_bios_get_dev_node(u8 *nodenum, char boot, struct pnp_bios_node *data)
 {
 	u16 status;
-	if (!pnp_bios_present ())
+	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	if ( !boot & pnpbios_dont_use_current_config )
 		return PNP_FUNCTION_NOT_SUPPORTED;
@@ -299,7 +304,7 @@
 	int status;
 	status =  __pnp_bios_get_dev_node( nodenum, boot, data );
 	if ( status )
-		printk(KERN_WARNING "PnPBIOS: get_dev_node: Unexpected status 0x%x\n", status);
+		pnpbios_warn_unexpected_status( "get_dev_node", status );
 	return status;
 }
 
@@ -313,7 +318,7 @@
 static int __pnp_bios_set_dev_node(u8 nodenum, char boot, struct pnp_bios_node *data)
 {
 	u16 status;
-	if (!pnp_bios_present ())
+	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	if ( !boot & pnpbios_dont_use_current_config )
 		return PNP_FUNCTION_NOT_SUPPORTED;
@@ -327,7 +332,7 @@
 	int status;
 	status =  __pnp_bios_set_dev_node( nodenum, boot, data );
 	if ( status ) {
-		printk(KERN_WARNING "PnPBIOS: set_dev_node: Unexpected status 0x%x\n", status);
+		pnpbios_warn_unexpected_status( "set_dev_node", status );
 		return status;
 	}
 	if ( !boot ) { /* Update devlist */
@@ -347,7 +352,7 @@
 static int pnp_bios_get_event(u16 *event)
 {
 	u16 status;
-	if (!pnp_bios_present ())
+	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	Q2_SET_SEL(PNP_TS1, event, sizeof(u16));
 	status = call_pnp_bios(PNP_GET_EVENT, 0, PNP_TS1, PNP_DS, 0, 0 ,0 ,0);
@@ -362,7 +367,7 @@
 static int pnp_bios_send_message(u16 message)
 {
 	u16 status;
-	if (!pnp_bios_present ())
+	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	status = call_pnp_bios(PNP_SEND_MESSAGE, message, PNP_DS, 0, 0, 0, 0, 0);
 	return status;
@@ -376,7 +381,7 @@
 static int pnp_bios_dock_station_info(struct pnp_docking_station_info *data)
 {
 	u16 status;
-	if (!pnp_bios_present ())
+	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	Q2_SET_SEL(PNP_TS1, data, sizeof(struct pnp_docking_station_info));
 	status = call_pnp_bios(PNP_GET_DOCKING_STATION_INFORMATION, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0);
@@ -392,7 +397,7 @@
 static int pnp_bios_set_stat_res(char *info)
 {
 	u16 status;
-	if (!pnp_bios_present ())
+	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	Q2_SET_SEL(PNP_TS1, info, *((u16 *) info));
 	status = call_pnp_bios(PNP_SET_STATIC_ALLOCED_RES_INFO, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0);
@@ -407,7 +412,7 @@
 static int __pnp_bios_get_stat_res(char *info)
 {
 	u16 status;
-	if (!pnp_bios_present ())
+	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	Q2_SET_SEL(PNP_TS1, info, 64 * 1024);
 	status = call_pnp_bios(PNP_GET_STATIC_ALLOCED_RES_INFO, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0);
@@ -419,7 +424,7 @@
 	int status;
 	status = __pnp_bios_get_stat_res( info );
 	if ( status )
-		printk(KERN_WARNING "PnPBIOS: get_stat_res: Unexpected status 0x%x\n", status);
+		pnpbios_warn_unexpected_status( "get_stat_res", status );
 	return status;
 }
 
@@ -430,7 +435,7 @@
 static int pnp_bios_apm_id_table(char *table, u16 *size)
 {
 	u16 status;
-	if (!pnp_bios_present ())
+	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	Q2_SET_SEL(PNP_TS1, table, *size);
 	Q2_SET_SEL(PNP_TS2, size, sizeof(u16));
@@ -445,7 +450,7 @@
 static int __pnp_bios_isapnp_config(struct pnp_isa_config_struc *data)
 {
 	u16 status;
-	if (!pnp_bios_present ())
+	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	Q2_SET_SEL(PNP_TS1, data, sizeof(struct pnp_isa_config_struc));
 	status = call_pnp_bios(PNP_GET_PNP_ISA_CONFIG_STRUC, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0);
@@ -457,7 +462,7 @@
 	int status;
 	status = __pnp_bios_isapnp_config( data );
 	if ( status )
-		printk(KERN_WARNING "PnPBIOS: isapnp_config: Unexpected status 0x%x\n", status);
+		pnpbios_warn_unexpected_status( "isapnp_config", status );
 	return status;
 }
 
@@ -467,7 +472,7 @@
 static int __pnp_bios_escd_info(struct escd_info_struc *data)
 {
 	u16 status;
-	if (!pnp_bios_present ())
+	if (!pnp_bios_present())
 		return ESCD_FUNCTION_NOT_SUPPORTED;
 	Q2_SET_SEL(PNP_TS1, data, sizeof(struct escd_info_struc));
 	status = call_pnp_bios(PNP_GET_ESCD_INFO, 0, PNP_TS1, 2, PNP_TS1, 4, PNP_TS1, PNP_DS);
@@ -479,7 +484,7 @@
 	int status;
 	status = __pnp_bios_escd_info( data );
 	if ( status )
-		printk(KERN_WARNING "PnPBIOS: escd_info: Unexpected status 0x%x\n", status);
+		pnpbios_warn_unexpected_status( "escd_info", status );
 	return status;
 }
 
@@ -490,7 +495,7 @@
 static int __pnp_bios_read_escd(char *data, u32 nvram_base)
 {
 	u16 status;
-	if (!pnp_bios_present ())
+	if (!pnp_bios_present())
 		return ESCD_FUNCTION_NOT_SUPPORTED;
 	Q2_SET_SEL(PNP_TS1, data, 64 * 1024);
 	set_base(gdt[PNP_TS2 >> 3], nvram_base);
@@ -504,7 +509,7 @@
 	int status;
 	status = __pnp_bios_read_escd( data, nvram_base );
 	if ( status )
-		printk(KERN_ERR "PnPBIOS: read_escd: Unexpected status 0x%x\n", status);
+		pnpbios_warn_unexpected_status( "read_escd", status );
 	return status;
 }
 
@@ -515,7 +520,7 @@
 static int pnp_bios_write_escd(char *data, u32 nvram_base)
 {
 	u16 status;
-	if (!pnp_bios_present ())
+	if (!pnp_bios_present())
 		return ESCD_FUNCTION_NOT_SUPPORTED;
 	Q2_SET_SEL(PNP_TS1, data, 64 * 1024);
 	set_base(gdt[PNP_TS2 >> 3], nvram_base);
@@ -602,10 +607,10 @@
 	int docked = -1, d = 0;
 	daemonize();
 	reparent_to_init();
-	strcpy(current->comm, "kpnpbios");
+	strcpy(current->comm, "kpnpbiosd");
 	while(!unloading && !signal_pending(current))
 	{
-		int err;
+		int status;
 		
 		/*
 		 * Poll every 2 seconds
@@ -615,9 +620,9 @@
 		if(signal_pending(current))
 			break;
 
-		err = pnp_bios_dock_station_info(&now);
+		status = pnp_bios_dock_station_info(&now);
 
-		switch(err)
+		switch(status)
 		{
 			/*
 			 * No dock to manage
@@ -631,7 +636,7 @@
 				d = 1;
 				break;
 			default:
-				printk(KERN_WARNING "PnPBIOS: pnp_dock_thread: Unexpected status 0x%x\n", err);
+				pnpbios_warn_unexpected_status( "pnp_dock_thread", status );
 				continue;
 		}
 		if(d != docked)
@@ -874,13 +879,13 @@
 static void __init build_devlist(void)
 {
 	u8 nodenum;
-	int nodes_got = 0;
-	int devs = 0;
+	unsigned int nodes_got = 0;
+	unsigned int devs = 0;
 	struct pnp_bios_node *node;
 	struct pnp_dev_node_info node_info;
 	struct pci_dev *dev;
 	
-	if (!pnp_bios_present ())
+	if (!pnp_bios_present())
 		return;
 
 	if (pnp_bios_dev_node_info(&node_info) != 0)
@@ -912,7 +917,7 @@
 		else
 			devs++;
 		if (nodenum <= thisnodenum) {
-			printk(KERN_ERR "PnPBIOS: build_devlist(): Node number 0x%x is out of sequence following node 0x%x. Aborting.\n", (int)nodenum, (int)thisnodenum);
+			printk(KERN_ERR "PnPBIOS: build_devlist: Node number 0x%x is out of sequence following node 0x%x. Aborting.\n", (unsigned int)nodenum, (unsigned int)thisnodenum);
 			break;
 		}
 	}
@@ -1215,14 +1220,14 @@
 {
 	union pnp_bios_expansion_header *check;
 	u8 sum;
-	int i, length;
+	int i, length, r;
 
 	spin_lock_init(&pnp_bios_lock);
 	spin_lock_init(&pnpbios_devices_lock);
 
 	if(pnpbios_disabled) {
 		printk(KERN_INFO "PnPBIOS: Disabled\n");
-		return 0;
+		return -ENODEV;
 	}
 
 	if ( is_sony_vaio_laptop )
@@ -1264,12 +1269,21 @@
 		pnp_bios_hdr = check;
 		break;
 	}
+	if (!pnp_bios_present())
+		return -ENODEV;
 	build_devlist();
 	if ( ! dont_reserve_resources )
 		reserve_resources();
 #ifdef CONFIG_PROC_FS
-	pnpbios_proc_init();
+	r = pnpbios_proc_init();
+	if (r)
+		return r;
 #endif
+	return 0;
+}
+
+static int __init pnpbios_thread_init(void)
+{
 #ifdef CONFIG_HOTPLUG	
 	init_completion(&unload_sem);
 	if(kernel_thread(pnp_dock_thread, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGNAL)>0)
@@ -1278,23 +1292,46 @@
 	return 0;
 }
 
-#ifdef MODULE
+#ifndef MODULE
+
+/* init/main.c calls pnpbios_init early */
+
+/* Start the kernel thread later: */
+module_init(pnpbios_thread_init);
+
+#else
+
+/*
+ * N.B.: Building pnpbios as a module hasn't been fully implemented
+ */
 
 MODULE_LICENSE("GPL");
 
-/* We have to run it early and not as a module. */
-module_init(pnpbios_init);
+static int __init pnpbios_init_all(void)
+{
+	int r;
 
-#ifdef CONFIG_HOTPLUG
-static void pnpbios_exit(void)
+	r = pnpbios_init();
+	if (r)
+		return r;
+	r = pnpbios_thread_init();
+	if (r)
+		return r;
+	return 0;
+}
+
+static void __exit pnpbios_exit(void)
 {
-	/* free_resources() ought to go here */
-	/* pnpbios_proc_done() */
+#ifdef CONFIG_HOTPLUG
 	unloading = 1;
 	wait_for_completion(&unload_sem);
+#endif
+	pnpbios_proc_exit();
+	/* We ought to free resources here */
+	return;
 }
 
+module_init(pnpbios_init_all);
 module_exit(pnpbios_exit);
 
-#endif
 #endif
--- linux-2.5.6_2.5.5-dj3/drivers/pnp/pnpbios_proc.c_DJ	Fri Mar  8 18:37:58 2002
+++ linux-2.5.6_2.5.5-dj3/drivers/pnp/pnpbios_proc.c	Fri Mar  8 19:10:32 2002
@@ -2,7 +2,20 @@
  * /proc/bus/pnp interface for Plug and Play devices
  *
  * Written by David Hinds, dahinds@users.sourceforge.net
- * Modified by Thomas Hood, jdthood_AT_mail.com
+ * Modified by Thomas Hood, jdthood@mail.com
+ *
+ * The .../devices and .../<node> and .../boot/<node> files are
+ * utilized by the lspnp and setpnp utilities, supplied with the
+ * pcmcia-cs package.
+ *     http://pcmcia-cs.sourceforge.net
+ *
+ * The .../escd file is utilized by the lsescd utility written by
+ * Gunther Mayer.
+ *     http://home.t-online.de/home/gunther.mayer/lsescd
+ *
+ * The .../legacy_device_resources file is not used yet.
+ *
+ * The other files are human-readable.
  */
 
 //#include <pcmcia/config.h>
@@ -66,7 +79,7 @@
 
 	/* sanity check */
 	if (escd.escd_size > (32*1024)) {
-		printk(KERN_ERR "PnPBIOS: Error: ESCD size is too great\n");
+		printk(KERN_ERR "PnPBIOS: proc_read_escd: ESCD size is too great\n");
 		return -EFBIG;
 	}
 
@@ -122,7 +135,7 @@
 			     node->type_code[0], node->type_code[1],
 			     node->type_code[2], node->flags);
 		if (nodenum <= thisnodenum) {
-			printk(KERN_ERR "PnPBIOS: proc_read_devices(): Node number 0x%x is out of sequence following node 0x%x. Aborting.\n", (int)nodenum, (int)thisnodenum);
+			printk(KERN_ERR "%s Node number 0x%x is out of sequence following node 0x%x. Aborting.\n", "PnPBIOS: proc_read_devices:", (unsigned int)nodenum, (unsigned int)thisnodenum);
 			*eof = 1;
 			break;
 		}
@@ -177,20 +190,22 @@
  * work and the pnpbios_dont_use_current_config flag
  * should already have been set to the appropriate value
  */
-void pnpbios_proc_init( void )
+int __init pnpbios_proc_init( void )
 {
 	struct pnp_bios_node *node;
 	struct proc_dir_entry *ent;
 	char name[3];
-	int i;
 	u8 nodenum;
 
-	if (pnp_bios_dev_node_info(&node_info) != 0) return;
+	if (pnp_bios_dev_node_info(&node_info))
+		return -EIO;
 	
 	proc_pnp = proc_mkdir("pnp", proc_bus);
-	if (!proc_pnp) return;
+	if (!proc_pnp)
+		return -EIO;
 	proc_pnp_boot = proc_mkdir("boot", proc_pnp);
-	if (!proc_pnp_boot) return;
+	if (!proc_pnp_boot)
+		return -EIO;
 	create_proc_read_entry("devices", 0, proc_pnp, proc_read_devices, NULL);
 	create_proc_read_entry("configuration_info", 0, proc_pnp, proc_read_pnpconfig, NULL);
 	create_proc_read_entry("escd_info", 0, proc_pnp, proc_read_escdinfo, NULL);
@@ -198,8 +213,11 @@
 	create_proc_read_entry("legacy_device_resources", 0, proc_pnp, proc_read_legacyres, NULL);
 	
 	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
-	if (!node) return;
-	for (i=0,nodenum = 0; i<0xff && nodenum != 0xff; i++) {
+	if (!node)
+		return -ENOMEM;
+
+	for (nodenum=0; nodenum<0xff; ) {
+		u8 thisnodenum = nodenum;
 		if (pnp_bios_get_dev_node(&nodenum, 1, node) != 0)
 			break;
 		sprintf(name, "%02x", node->handle);
@@ -217,11 +235,17 @@
 			ent->write_proc = proc_write_node;
 			ent->data = (void *)(long)(node->handle+0x100);
 		}
+		if (nodenum <= thisnodenum) {
+			printk(KERN_ERR "%s Node number 0x%x is out of sequence following node 0x%x. Aborting.\n", "PnPBIOS: proc_init:", (unsigned int)nodenum, (unsigned int)thisnodenum);
+			break;
+		}
 	}
 	kfree(node);
+
+	return 0;
 }
 
-void pnpbios_proc_done(void)
+void __exit pnpbios_proc_exit(void)
 {
 	int i;
 	char name[3];
@@ -241,4 +265,6 @@
 	remove_proc_entry("devices", proc_pnp);
 	remove_proc_entry("boot", proc_pnp);
 	remove_proc_entry("pnp", proc_bus);
+
+	return;
 }

