Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276384AbRI2AaH>; Fri, 28 Sep 2001 20:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276385AbRI2A37>; Fri, 28 Sep 2001 20:29:59 -0400
Received: from sushi.toad.net ([162.33.130.105]:3290 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S276382AbRI2A3v>;
	Fri, 28 Sep 2001 20:29:51 -0400
Message-ID: <3BB515FB.3D327FA7@mail.com>
Date: Fri, 28 Sep 2001 20:29:48 -0400
From: Thomas Hood <jdthood@mail.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Stelian Pop <stelian.pop@fr.alcove.com>
Subject: [PATCH] PnPBIOS 2.4.9-ac1[56] Vaio fix
Content-Type: multipart/mixed;
 boundary="------------AB76F8DA8A48762EFB8F6E78"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------AB76F8DA8A48762EFB8F6E78
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

_Here_ is a new patch against stock 2.4.9-ac16.
It is about the minimum change that is required to get
-ac16 working on Sony Vaio laptops.  I omit the
other changes to the PnP BIOS driver that I submitted
earlier ... we should get this straightened out first.
Once Alan releases a kernel with this or a similar
patch, I'll submit a new patch that fixes the 
disabled-device problems I was grappling with before.
(Did you know that 'Bios' is a Hindi word for 'quicksand'?
I'll bet you didn't.  That's because I just made it up.) 

The fix is required because Sony Vaio laptops' PnP BIOS
won't handle requests to get the "current" resource
configuration.

The fix:
In many cases it doesn't matter whether we get the
"current" or "boot" configuration of a device (e.g.,
when we are just looking for the PnP I.D.s), so for
the most part the fix consists of asking for the 
"boot" rather than the "current" config.

One thing that had to be done, however, was to eliminate
the /proc/bus/pnp interface to "current" config values
for those laptops that can't supply them.  Accordingly, now,
the PnP BIOS proc module is initialized with a flag that can
tell it to omit the "current" files.  The PnP BIOS driver
calls with this flag set when the is_sony_vaio_laptop global
variable is nonzero.  The DMI scan routine will set
is_sony_vaio_laptop to 1, but at present it runs
too late for this to be of use to the PnP BIOS driver.
With the patch the variable can also be set using the
"nobioscurrpnp" boot option; users of Sony Vaio laptops
will have to use this option until the DMI scan is put
earlier in the boot sequence.

--
Thomas
--------------AB76F8DA8A48762EFB8F6E78
Content-Type: text/plain; charset=us-ascii;
 name="thood-pnpbiosvaiofix-patch-20010928-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="thood-pnpbiosvaiofix-patch-20010928-1"

diff -Naur linux-2.4.9-ac16/drivers/pnp/pnp_bios.c linux-2.4.9-ac16-pnpbiosfix/drivers/pnp/pnp_bios.c
--- linux-2.4.9-ac16/drivers/pnp/pnp_bios.c	Fri Sep 28 15:35:07 2001
+++ linux-2.4.9-ac16-pnpbiosfix/drivers/pnp/pnp_bios.c	Fri Sep 28 17:32:24 2001
@@ -48,7 +48,8 @@
 /* PnP bios signature: "$PnP" */
 #define PNP_SIGNATURE   (('$' << 0) + ('P' << 8) + ('n' << 16) + ('P' << 24))
 
-void pnp_proc_init(void);
+extern int is_sony_vaio_laptop;
+
 static void pnpbios_build_devlist(void);
 
 /*
@@ -560,6 +561,7 @@
  */
 
 static int pnp_bios_disabled;
+static int pnp_bios_dont_use_current_config;
 
 static int disable_pnp_bios(char *str)
 {
@@ -567,7 +569,14 @@
 	return 0;
 }
 
+static int disable_use_of_current_config(char *str)
+{
+	pnp_bios_dont_use_current_config=1;
+	return 0;
+}
+
 __setup("nobiospnp", disable_pnp_bios);
+__setup("nobioscurrpnp", disable_use_of_current_config);
 
 void pnp_bios_init(void)
 {
@@ -582,6 +591,10 @@
 		printk(KERN_INFO "PNP BIOS services disabled.\n");
 		return;
 	}
+
+	if ( is_sony_vaio_laptop )
+		pnp_bios_dont_use_current_config = 1;
+
 	for (check = (union pnpbios *) __va(0xf0000);
 	     check < (union pnpbios *) __va(0xffff0);
 	     ((void *) (check)) += 16) {
@@ -616,7 +629,7 @@
 	}
 	pnpbios_build_devlist();
 #ifdef CONFIG_PROC_FS
-	pnp_proc_init();
+	pnp_proc_init( pnp_bios_dont_use_current_config );
 #endif
 #ifdef CONFIG_HOTPLUG	
 	init_completion(&unload_sem);
@@ -846,8 +859,10 @@
 		dev =  kmalloc(sizeof (struct pci_dev), GFP_KERNEL);
 		if (!dev)
 			break;
-			
-                if (pnp_bios_get_dev_node((u8 *)&num, (char )0 , node))
+
+		// For now we scan the "boot" config because some BIOSes
+		// oops when their "current" configs are accessed
+                if (pnp_bios_get_dev_node((u8 *)&num, (char )1 , node))
 			continue;
 
 		devs++;
diff -Naur linux-2.4.9-ac16/drivers/pnp/pnp_proc.c linux-2.4.9-ac16-pnpbiosfix/drivers/pnp/pnp_proc.c
--- linux-2.4.9-ac16/drivers/pnp/pnp_proc.c	Fri Sep 28 15:35:07 2001
+++ linux-2.4.9-ac16-pnpbiosfix/drivers/pnp/pnp_proc.c	Fri Sep 28 16:53:47 2001
@@ -33,7 +33,7 @@
 	node = kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node) return -ENOMEM;
 	for (num = 0; num != 0xff; ) {
-		pnp_bios_get_dev_node(&num, 0, node);
+		pnp_bios_get_dev_node(&num, 1, node);
 		p += sprintf(p, "%02x\t%08x\t%02x:%02x:%02x\t%04x\n",
 			     node->handle, node->eisa_id,
 			     node->type_code[0], node->type_code[1],
@@ -83,13 +83,17 @@
 	return count;
 }
 
-void pnp_proc_init(void)
+static int pnp_proc_dont_use_current_config;
+
+void pnp_proc_init( int dont_use_current )
 {
 	struct pnp_bios_node *node;
 	struct proc_dir_entry *ent;
 	char name[3];
 	u8 num;
 
+	pnp_proc_dont_use_current_config = dont_use_current;
+
 	if (!pnp_bios_present()) return;
 	if (pnp_bios_dev_node_info(&node_info) != 0)
 		return;
@@ -105,14 +109,16 @@
 	if (!node) return;
 	for (num = 0; num != 0xff; ) {
 		//sprintf(name, "%02x", num);
-		if (pnp_bios_get_dev_node(&num, 0, node) != 0)
+		if (pnp_bios_get_dev_node(&num, 1, node) != 0)
 			break;
 		sprintf(name, "%02x", node->handle);
-		ent = create_proc_entry(name, 0, proc_pnp);
-		if (ent) {
-			ent->read_proc = proc_read_node;
-			ent->write_proc = proc_write_node;
-			ent->data = (void *)(long)(node->handle);
+		if ( !dont_use_current ) {
+			ent = create_proc_entry(name, 0, proc_pnp);
+			if (ent) {
+				ent->read_proc = proc_read_node;
+				ent->write_proc = proc_write_node;
+				ent->data = (void *)(long)(node->handle);
+			}
 		}
 		ent = create_proc_entry(name, 0, proc_pnp_boot);
 		if (ent) {
@@ -132,7 +138,8 @@
 	if (!proc_pnp) return;
 	for (num = 0; num != 0xff; num++) {
 		sprintf(name, "%02x", num);
-		remove_proc_entry(name, proc_pnp);
+		if ( !pnp_proc_dont_use_current_config )
+			remove_proc_entry(name, proc_pnp);
 		remove_proc_entry(name, proc_pnp_boot);
 	}
 	remove_proc_entry("boot", proc_pnp);
diff -Naur linux-2.4.9-ac16/include/linux/pnp_bios.h linux-2.4.9-ac16-pnpbiosfix/include/linux/pnp_bios.h
--- linux-2.4.9-ac16/include/linux/pnp_bios.h	Fri Sep 28 15:35:42 2001
+++ linux-2.4.9-ac16-pnpbiosfix/include/linux/pnp_bios.h	Fri Sep 28 16:55:47 2001
@@ -146,6 +146,8 @@
 extern int pnp_bios_read_escd (char *data, u32 nvram_base);
 extern int pnp_bios_write_escd (char *data, u32 nvram_base);
 
+extern void pnp_proc_init ( int dont_use_current );
+
 #ifdef CONFIG_PNPBIOS
 #define pnpbios_for_each_dev(dev) \
 	for(dev = pnpbios_dev_g(pnpbios_devices.next); dev != pnpbios_dev_g(&pnpbios_devices); dev = pnpbios_dev_g(dev->global_list.next))
diff -Naur linux-2.4.9-ac16/arch/i386/kernel/dmi_scan.c linux-2.4.9-ac16-pnpbiosfix/arch/i386/kernel/dmi_scan.c
--- linux-2.4.9-ac16/arch/i386/kernel/dmi_scan.c	Fri Sep 28 15:34:12 2001
+++ linux-2.4.9-ac16-pnpbiosfix/arch/i386/kernel/dmi_scan.c	Fri Sep 28 17:04:17 2001
@@ -313,14 +313,12 @@
 	return 0;
 }		
 
-#if defined(CONFIG_SONYPI) || defined(CONFIG_SONYPI_MODULE)
 /*
- * Check for a Sony Vaio system in order to enable the use of
- * the sonypi driver (we don't want this driver to be used on
- * other systems, even if they have the good PCI IDs).
+ * Check for a Sony Vaio system
  *
- * This one isn't a bug detect for those who asked, we simply want to
- * activate Sony specific goodies like the camera and jogdial..
+ * On a Sony system we want to enable the use of the sonypi
+ * driver for Sony-specific goodies like the camera and jogdial.
+ * We also want to avoid using certain functions of the PnP BIOS.
  */
 int is_sony_vaio_laptop;
 
@@ -333,7 +331,6 @@
 	}
 	return 0;
 }
-#endif
 
 /*
  * This bios swaps the APM minute reporting bytes over (Many sony laptops
@@ -459,13 +456,11 @@
 			MATCH(DMI_BIOS_VENDOR,"SystemSoft"),
 			MATCH(DMI_BIOS_VERSION,"Version R2.08")
 			} },
-#if defined(CONFIG_SONYPI) || defined(CONFIG_SONYPI_MODULE)
 	{ sony_vaio_laptop, "Sony Vaio", { /* This is a Sony Vaio laptop */
 			MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
 			MATCH(DMI_PRODUCT_NAME, "PCG-"),
 			NO_MATCH, NO_MATCH,
 			} },
-#endif
 	{ swab_apm_power_in_minutes, "Sony VAIO", { /* Handle problems with APM on Sony Vaio PCG-N505X(DE) */
 			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
 			MATCH(DMI_BIOS_VERSION, "R0206H"),
diff -Naur linux-2.4.9-ac16/arch/i386/kernel/i386_ksyms.c linux-2.4.9-ac16-pnpbiosfix/arch/i386/kernel/i386_ksyms.c
--- linux-2.4.9-ac16/arch/i386/kernel/i386_ksyms.c	Fri Sep 28 15:34:12 2001
+++ linux-2.4.9-ac16-pnpbiosfix/arch/i386/kernel/i386_ksyms.c	Fri Sep 28 17:41:12 2001
@@ -171,8 +171,6 @@
 EXPORT_SYMBOL(do_BUG);
 #endif
 
-#if defined(CONFIG_SONYPI) || defined(CONFIG_SONYPI_MODULE)
 extern int is_sony_vaio_laptop;
 EXPORT_SYMBOL(is_sony_vaio_laptop);
-#endif
 

--------------AB76F8DA8A48762EFB8F6E78--

