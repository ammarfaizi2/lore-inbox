Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbTDDE66 (for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 23:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbTDDE66 (for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 23:58:58 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:18053 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S261489AbTDDExA (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 23:53:00 -0500
Date: Fri, 4 Apr 2003 00:08:14 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.66
Message-ID: <20030404000814.GC11574@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030404000731.GB11574@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404000731.GB11574@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Nru a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
--- a/drivers/pnp/pnpbios/core.c	Thu Apr  3 23:41:16 2003
+++ b/drivers/pnp/pnpbios/core.c	Thu Apr  3 23:41:16 2003
@@ -32,6 +32,18 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+ 
+/* Change Log
+ *
+ * Adam Belay - <ambx1@neo.rr.com> - March 16, 2003
+ * rev 1.01	Only call pnp_bios_dev_node_info once
+ *		Added pnpbios_print_status
+ *		Added several new error messages and info messages
+ *		Added pnpbios_interface_attach_device
+ *		integrated core and proc init system
+ *		Introduced PNPMODE flags
+ *		Removed some useless includes
+ */
 
 #include <linux/types.h>
 #include <linux/module.h>
@@ -46,9 +58,7 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <asm/desc.h>
-#include <linux/ioport.h>
 #include <linux/slab.h>
-#include <linux/pci.h>
 #include <linux/kmod.h>
 #include <linux/completion.h>
 #include <linux/spinlock.h>
@@ -93,6 +103,7 @@
 } pnp_bios_callpoint;
 
 static union pnp_bios_expansion_header * pnp_bios_hdr = NULL;
+struct pnp_dev_node_info node_info;
 
 /* The PnP BIOS entries in the GDT */
 #define PNP_GDT    (GDT_ENTRY_PNPBIOS_BASE * 8)
@@ -237,9 +248,46 @@
  *
  */
 
-static void pnpbios_warn_unexpected_status(const char * module, u16 status)
+static void pnpbios_print_status(const char * module, u16 status)
 {
-	printk(KERN_ERR "PnPBIOS: %s: Unexpected status 0x%x\n", module, status);
+	switch(status) {
+	case PNP_SUCCESS:
+	printk(KERN_ERR "PnPBIOS: %s: function successful\n", module);
+	case PNP_NOT_SET_STATICALLY:
+	printk(KERN_ERR "PnPBIOS: %s: unable to set static resources\n", module);
+	case PNP_UNKNOWN_FUNCTION:
+	printk(KERN_ERR "PnPBIOS: %s: invalid function number passed\n", module);
+	case PNP_FUNCTION_NOT_SUPPORTED:
+	printk(KERN_ERR "PnPBIOS: %s: function not supported on this system\n", module);
+	case PNP_INVALID_HANDLE:
+	printk(KERN_ERR "PnPBIOS: %s: invalid handle\n", module);
+	case PNP_BAD_PARAMETER:
+	printk(KERN_ERR "PnPBIOS: %s: invalid parameters were passed\n", module);
+	case PNP_SET_FAILED:
+	printk(KERN_ERR "PnPBIOS: %s: unable to set resources\n", module);
+	case PNP_EVENTS_NOT_PENDING:
+	printk(KERN_ERR "PnPBIOS: %s: no events are pending\n", module);
+	case PNP_SYSTEM_NOT_DOCKED:
+	printk(KERN_ERR "PnPBIOS: %s: the system is not docked\n", module);
+	case PNP_NO_ISA_PNP_CARDS:
+	printk(KERN_ERR "PnPBIOS: %s: no isapnp cards are installed on this system\n", module);
+	case PNP_UNABLE_TO_DETERMINE_DOCK_CAPABILITIES:
+	printk(KERN_ERR "PnPBIOS: %s: cannot determine the capabilities of the docking station\n", module);
+	case PNP_CONFIG_CHANGE_FAILED_NO_BATTERY:
+	printk(KERN_ERR "PnPBIOS: %s: unable to undock, the system does not have a battery\n", module);
+	case PNP_CONFIG_CHANGE_FAILED_RESOURCE_CONFLICT:
+	printk(KERN_ERR "PnPBIOS: %s: could not dock due to resource conflicts\n", module);
+	case PNP_BUFFER_TOO_SMALL:
+	printk(KERN_ERR "PnPBIOS: %s: the buffer passed is too small\n", module);
+	case PNP_USE_ESCD_SUPPORT:
+	printk(KERN_ERR "PnPBIOS: %s: use ESCD instead\n", module);
+	case PNP_MESSAGE_NOT_SUPPORTED:
+	printk(KERN_ERR "PnPBIOS: %s: the message is unsupported\n", module);
+	case PNP_HARDWARE_ERROR:
+	printk(KERN_ERR "PnPBIOS: %s: a hardware failure has occured\n", module);
+	default:
+	printk(KERN_ERR "PnPBIOS: %s: unexpected status 0x%x\n", module, status);
+	}
 }
 
 void *pnpbios_kmalloc(size_t size, int f)
@@ -299,7 +347,7 @@
 {
 	int status = __pnp_bios_dev_node_info( data );
 	if ( status )
-		pnpbios_warn_unexpected_status( "dev_node_info", status );
+		pnpbios_print_status( "dev_node_info", status );
 	return status;
 }
 
@@ -334,7 +382,7 @@
 	int status;
 	status =  __pnp_bios_get_dev_node( nodenum, boot, data );
 	if ( status )
-		pnpbios_warn_unexpected_status( "get_dev_node", status );
+		pnpbios_print_status( "get_dev_node", status );
 	return status;
 }
 
@@ -362,7 +410,7 @@
 	int status;
 	status =  __pnp_bios_set_dev_node( nodenum, boot, data );
 	if ( status ) {
-		pnpbios_warn_unexpected_status( "set_dev_node", status );
+		pnpbios_print_status( "set_dev_node", status );
 		return status;
 	}
 	if ( !boot ) { /* Update devlist */
@@ -452,7 +500,7 @@
 	int status;
 	status = __pnp_bios_get_stat_res( info );
 	if ( status )
-		pnpbios_warn_unexpected_status( "get_stat_res", status );
+		pnpbios_print_status( "get_stat_res", status );
 	return status;
 }
 
@@ -489,7 +537,7 @@
 	int status;
 	status = __pnp_bios_isapnp_config( data );
 	if ( status )
-		pnpbios_warn_unexpected_status( "isapnp_config", status );
+		pnpbios_print_status( "isapnp_config", status );
 	return status;
 }
 
@@ -511,7 +559,7 @@
 	int status;
 	status = __pnp_bios_escd_info( data );
 	if ( status )
-		pnpbios_warn_unexpected_status( "escd_info", status );
+		pnpbios_print_status( "escd_info", status );
 	return status;
 }
 
@@ -534,7 +582,7 @@
 	int status;
 	status = __pnp_bios_read_escd( data, nvram_base );
 	if ( status )
-		pnpbios_warn_unexpected_status( "read_escd", status );
+		pnpbios_print_status( "read_escd", status );
 	return status;
 }
 
@@ -658,7 +706,7 @@
 				d = 1;
 				break;
 			default:
-				pnpbios_warn_unexpected_status( "pnp_dock_thread", status );
+				pnpbios_print_status( "pnp_dock_thread", status );
 				continue;
 		}
 		if(d != docked)
@@ -753,19 +801,17 @@
 
 static int pnpbios_get_resources(struct pnp_dev * dev, struct pnp_resource_table * res)
 {
-	struct pnp_dev_node_info node_info;
 	u8 nodenum = dev->number;
 	struct pnp_bios_node * node;
 
 	/* just in case */
 	if(!pnpbios_is_dynamic(dev))
 		return -EPERM;
-	if (pnp_bios_dev_node_info(&node_info) != 0)
-		return -ENODEV;
+
 	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return -1;
-	if (pnp_bios_get_dev_node(&nodenum, (char )0, node)) {
+	if (pnp_bios_get_dev_node(&nodenum, (char )PNPMODE_DYNAMIC, node)) {
 		kfree(node);
 		return -ENODEV;
 	}
@@ -777,7 +823,6 @@
 
 static int pnpbios_set_resources(struct pnp_dev * dev, struct pnp_resource_table * res)
 {
-	struct pnp_dev_node_info node_info;
 	u8 nodenum = dev->number;
 	struct pnp_bios_node * node;
 	int ret;
@@ -785,18 +830,17 @@
 	/* just in case */
 	if (!pnpbios_is_dynamic(dev))
 		return -EPERM;
-	if (pnp_bios_dev_node_info(&node_info) != 0)
-		return -ENODEV;
+
 	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return -1;
-	if (pnp_bios_get_dev_node(&nodenum, (char )1, node))
+	if (pnp_bios_get_dev_node(&nodenum, (char )PNPMODE_STATIC, node))
 		return -ENODEV;
 	if(!pnp_write_resources((char *)node->data,(char *)node->data + node->size,res)){
 		kfree(node);
 		return -1;
 	}
-	ret = pnp_bios_set_dev_node(node->handle, (char)0, node);
+	ret = pnp_bios_set_dev_node(node->handle, (char)PNPMODE_DYNAMIC, node);
 	kfree(node);
 	if (ret > 0)
 		ret = -1;
@@ -805,23 +849,18 @@
 
 static int pnpbios_disable_resources(struct pnp_dev *dev)
 {
-	struct pnp_dev_node_info node_info;
 	struct pnp_bios_node * node;
 	int ret;
 	
 	/* just in case */
 	if(dev->flags & PNPBIOS_NO_DISABLE || !pnpbios_is_dynamic(dev))
 		return -EPERM;
-	if (!dev || !dev->active)
-		return -EINVAL;
-	if (pnp_bios_dev_node_info(&node_info) != 0)
-		return -ENODEV;
+
 	/* the value of this will be zero */
 	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return -ENOMEM;
-	ret = pnp_bios_set_dev_node(dev->number, (char)0, node);
-	dev->active = 0;
+	ret = pnp_bios_set_dev_node(dev->number, (char)PNPMODE_DYNAMIC, node);
 	kfree(node);
 	if (ret > 0)
 		ret = -1;
@@ -879,6 +918,8 @@
 	dev->protocol = &pnpbios_protocol;
 
 	pnp_add_device(dev);
+	pnpbios_interface_attach_device(node);
+
 	return 0;
 }
 
@@ -903,8 +944,16 @@
 
 	for(nodenum=0; nodenum<0xff; ) {
 		u8 thisnodenum = nodenum;
-		if (pnp_bios_get_dev_node(&nodenum, (char )0, node))
-			break;
+		/* eventually we will want to use PNPMODE_STATIC here but for now
+		 * dynamic will help us catch buggy bioses to add to the blacklist.
+		 */
+		if (!pnpbios_dont_use_current_config) {
+			if (pnp_bios_get_dev_node(&nodenum, (char )PNPMODE_DYNAMIC, node))
+				break;
+		} else {
+			if (pnp_bios_get_dev_node(&nodenum, (char )PNPMODE_STATIC, node))
+				break;
+		}
 		nodes_got++;
 		dev =  pnpbios_kmalloc(sizeof (struct pnp_dev), GFP_KERNEL);
 		if (!dev)
@@ -972,7 +1021,8 @@
 	if(pnpbios_disabled || (dmi_broken & BROKEN_PNP_BIOS)) {
 		printk(KERN_INFO "PnPBIOS: Disabled\n");
 		return -ENODEV;
-	}
+	} else
+		printk(KERN_INFO "PnPBIOS: Scanning system for PnP BIOS support...\n");
 
 	/*
  	 * Search the defined area (0xf0000-0xffff0) for a valid PnP BIOS
@@ -1016,17 +1066,34 @@
 		}
 		break;
 	}
-	if (!pnp_bios_present())
+	if (!pnp_bios_present()) {
+		printk(KERN_INFO "PnPBIOS: A PnP BIOS was not detected.\n");
 		return -ENODEV;
+	}
+
+	/*
+	 * we found a pnpbios, now let's load the rest of the driver
+	 */
+
+	/* read the node info */
+	if (pnp_bios_dev_node_info(&node_info)) {
+		printk(KERN_ERR "PnPBIOS: Unable to get node info.  Aborting.\n");
+		return -EIO;
+	}
+
+	/* register with the pnp layer */
 	pnp_register_protocol(&pnpbios_protocol);
-	build_devlist();
-	/*if ( ! dont_reserve_resources )*/
-		/*reserve_resources();*/
+
 #ifdef CONFIG_PROC_FS
+	/* start the proc interface */
 	r = pnpbios_proc_init();
 	if (r)
 		return r;
 #endif
+
+	/* scan for pnpbios devices */
+	build_devlist();
+
 	return 0;
 }
 
diff -Nru a/drivers/pnp/pnpbios/proc.c b/drivers/pnp/pnpbios/proc.c
--- a/drivers/pnp/pnpbios/proc.c	Thu Apr  3 23:41:16 2003
+++ b/drivers/pnp/pnpbios/proc.c	Thu Apr  3 23:41:16 2003
@@ -31,7 +31,6 @@
 
 static struct proc_dir_entry *proc_pnp = NULL;
 static struct proc_dir_entry *proc_pnp_boot = NULL;
-static struct pnp_dev_node_info node_info;
 
 static int proc_read_pnpconfig(char *buf, char **start, off_t pos,
                                int count, int *eof, void *data)
@@ -136,7 +135,7 @@
 		/* 26 = the number of characters per line sprintf'ed */
 		if ((p - buf + 26) > count)
 			break;
-		if (pnp_bios_get_dev_node(&nodenum, 1, node))
+		if (pnp_bios_get_dev_node(&nodenum, PNPMODE_STATIC, node))
 			break;
 		p += sprintf(p, "%02x\t%08x\t%02x:%02x:%02x\t%04x\n",
 			     node->handle, node->eisa_id,
@@ -193,6 +192,30 @@
 	return count;
 }
 
+int pnpbios_interface_attach_device(struct pnp_bios_node * node)
+{
+	char name[3];
+	struct proc_dir_entry *ent;
+
+	sprintf(name, "%02x", node->handle);
+	if ( !pnpbios_dont_use_current_config ) {
+		ent = create_proc_entry(name, 0, proc_pnp);
+		if (ent) {
+			ent->read_proc = proc_read_node;
+			ent->write_proc = proc_write_node;
+			ent->data = (void *)(long)(node->handle);
+		}
+	}
+	ent = create_proc_entry(name, 0, proc_pnp_boot);
+	if (ent) {
+		ent->read_proc = proc_read_node;
+		ent->write_proc = proc_write_node;
+		ent->data = (void *)(long)(node->handle+0x100);
+		return 0;
+	}
+	return -EIO;
+}
+
 /*
  * When this is called, pnpbios functions are assumed to
  * work and the pnpbios_dont_use_current_config flag
@@ -200,14 +223,6 @@
  */
 int __init pnpbios_proc_init( void )
 {
-	struct pnp_bios_node *node;
-	struct proc_dir_entry *ent;
-	char name[3];
-	u8 nodenum;
-
-	if (pnp_bios_dev_node_info(&node_info))
-		return -EIO;
-	
 	proc_pnp = proc_mkdir("pnp", proc_bus);
 	if (!proc_pnp)
 		return -EIO;
@@ -219,36 +234,6 @@
 	create_proc_read_entry("escd_info", 0, proc_pnp, proc_read_escdinfo, NULL);
 	create_proc_read_entry("escd", S_IRUSR, proc_pnp, proc_read_escd, NULL);
 	create_proc_read_entry("legacy_device_resources", 0, proc_pnp, proc_read_legacyres, NULL);
-	
-	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
-	if (!node)
-		return -ENOMEM;
-
-	for (nodenum=0; nodenum<0xff; ) {
-		u8 thisnodenum = nodenum;
-		if (pnp_bios_get_dev_node(&nodenum, 1, node) != 0)
-			break;
-		sprintf(name, "%02x", node->handle);
-		if ( !pnpbios_dont_use_current_config ) {
-			ent = create_proc_entry(name, 0, proc_pnp);
-			if (ent) {
-				ent->read_proc = proc_read_node;
-				ent->write_proc = proc_write_node;
-				ent->data = (void *)(long)(node->handle);
-			}
-		}
-		ent = create_proc_entry(name, 0, proc_pnp_boot);
-		if (ent) {
-			ent->read_proc = proc_read_node;
-			ent->write_proc = proc_write_node;
-			ent->data = (void *)(long)(node->handle+0x100);
-		}
-		if (nodenum <= thisnodenum) {
-			printk(KERN_ERR "%s Node number 0x%x is out of sequence following node 0x%x. Aborting.\n", "PnPBIOS: proc_init:", (unsigned int)nodenum, (unsigned int)thisnodenum);
-			break;
-		}
-	}
-	kfree(node);
 
 	return 0;
 }
diff -Nru a/include/linux/pnpbios.h b/include/linux/pnpbios.h
--- a/include/linux/pnpbios.h	Thu Apr  3 23:41:16 2003
+++ b/include/linux/pnpbios.h	Thu Apr  3 23:41:16 2003
@@ -29,7 +29,7 @@
 #include <linux/pci.h>
 
 /*
- * Status codes (warnings and errors)
+ * Return codes
  */
 #define PNP_SUCCESS                     0x00
 #define PNP_NOT_SET_STATICALLY          0x7f
@@ -75,6 +75,7 @@
 #define PNPMSG_POWER_OFF		0x41
 #define PNPMSG_PNP_OS_ACTIVE		0x42
 #define PNPMSG_PNP_OS_INACTIVE		0x43
+
 /*
  * Plug and Play BIOS flags
  */
@@ -88,6 +89,12 @@
 #define pnpbios_is_static(x) (((x)->flags & 0x0100) == 0x0000)
 #define pnpbios_is_dynamic(x) ((x)->flags & 0x0080)
 
+/*
+ * Function Parameters
+ */
+#define PNPMODE_STATIC 1
+#define PNPMODE_DYNAMIC 0
+
 /* 0x8000 through 0xffff are OEM defined */
 
 #pragma pack(1)
@@ -125,8 +132,10 @@
 
 /* non-exported */
 extern int  pnpbios_dont_use_current_config;
+extern struct pnp_dev_node_info node_info;
 extern void *pnpbios_kmalloc(size_t size, int f);
 extern int pnpbios_init (void);
+extern int pnpbios_interface_attach_device(struct pnp_bios_node * node);
 extern int pnpbios_proc_init (void);
 extern void pnpbios_proc_exit (void);
 
