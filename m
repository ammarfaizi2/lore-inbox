Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132240AbQLVWIc>; Fri, 22 Dec 2000 17:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132290AbQLVWIW>; Fri, 22 Dec 2000 17:08:22 -0500
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:49910 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S132240AbQLVWIG>; Fri, 22 Dec 2000 17:08:06 -0500
From: ianh@iahastie.clara.net (Ian Hastie)
To: linux-kernel@vger.kernel.org
Date: Fri, 22 Dec 2000 21:09:49 +0000 (UTC)
Subject: [PATCH] ALi agpgart patch for 2.4.0-test12
Organization: home using Linux
Message-ID: <slrn947got.h6n.ianh@iahastie.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is against 2.4.0-test12.  It is based on the patch available
from ALi with an improvement suggested by Jeff Hartmann.  The ALi M1541
uses an external memory cache.  The driver needs to flush the memory
pages when they are allocated for AGP.  This is what the patch does.
Olivier Cahagne and myself have both tested this patch and found it to
greatly improve stability for 3D.  However to help it's acceptance it
would be worth testing it with a wider range of systems and graphics
hardware.

-- 
Ian.

--- linux-2.4.0-test12/drivers/char/agp/agpgart_be.c.ali	Thu Nov 16 21:59:53 2000
+++ linux-2.4.0-test12/drivers/char/agp/agpgart_be.c	Sun Dec 17 16:42:52 2000
@@ -245,7 +245,7 @@
 	if (curr->page_count != 0) {
 		for (i = 0; i < curr->page_count; i++) {
 			curr->memory[i] &= ~(0x00000fff);
-			agp_destroy_page((unsigned long)
+			agp_bridge.agp_destroy_page((unsigned long)
 					 phys_to_virt(curr->memory[i]));
 		}
 	}
@@ -290,7 +290,7 @@
 		return NULL;
 	}
 	for (i = 0; i < page_count; i++) {
-		new->memory[i] = agp_alloc_page();
+		new->memory[i] = agp_bridge.agp_alloc_page();
 
 		if (new->memory[i] == 0) {
 			/* Free this structure */
@@ -1017,7 +1017,7 @@
 			return NULL;
 		}
 	   	MOD_INC_USE_COUNT;
-		new->memory[0] = agp_alloc_page();
+		new->memory[0] = agp_bridge.agp_alloc_page();
 
 		if (new->memory[0] == 0) {
 			/* Free this structure */
@@ -1042,7 +1042,7 @@
 {
 	agp_free_key(curr->key);
    	if(curr->type == AGP_PHYS_MEMORY) {
-	   	agp_destroy_page((unsigned long)
+	   	agp_bridge.agp_destroy_page((unsigned long)
 				 phys_to_virt(curr->memory[0]));
 		vfree(curr->memory);
 	}
@@ -1238,6 +1238,8 @@
 	agp_bridge.remove_memory = agp_generic_remove_memory;
 	agp_bridge.alloc_by_type = agp_generic_alloc_by_type;
 	agp_bridge.free_by_type = agp_generic_free_by_type;
+	agp_bridge.agp_alloc_page = agp_alloc_page;
+	agp_bridge.agp_destroy_page = agp_destroy_page;
 
 	return 0;
 	
@@ -1379,6 +1381,8 @@
 	agp_bridge.remove_memory = agp_generic_remove_memory;
 	agp_bridge.alloc_by_type = agp_generic_alloc_by_type;
 	agp_bridge.free_by_type = agp_generic_free_by_type;
+	agp_bridge.agp_alloc_page = agp_alloc_page;
+	agp_bridge.agp_destroy_page = agp_destroy_page;
 
 	return 0;
 	
@@ -1488,6 +1492,8 @@
 	agp_bridge.remove_memory = agp_generic_remove_memory;
 	agp_bridge.alloc_by_type = agp_generic_alloc_by_type;
 	agp_bridge.free_by_type = agp_generic_free_by_type;
+	agp_bridge.agp_alloc_page = agp_alloc_page;
+	agp_bridge.agp_destroy_page = agp_destroy_page;
 
 	return 0;
 }
@@ -1870,6 +1876,21 @@
 #endif /* CONFIG_AGP_AMD */
 
 #ifdef CONFIG_AGP_ALI
+static void ali_generic_cache_flush(void)
+  {     int i;
+        u32 temp;
+    //Clear Tag =0xc4
+  global_cache_flush();
+  if (agp_bridge.type==ALI_M1541){
+           for (i = 0; i< PAGE_SIZE * (1 <<  A_SIZE_32(agp_bridge.current_size)->page_order); i+=PAGE_SIZE) {
+              pci_read_config_dword(agp_bridge.dev, L1_2_CACHE_FLUSH_CTRL , &temp);
+              pci_write_config_dword(agp_bridge.dev, L1_2_CACHE_FLUSH_CTRL ,
+         (((temp & CACHE_FLUSH_ADDR_MASK) | (agp_bridge.gatt_bus_addr+i)) |CACHE_FLUSH_EN ));
+        }
+
+   }
+
+}
 
 static int ali_fetch_size(void)
 {
@@ -1898,10 +1919,11 @@
 	u32 temp;
 
 	pci_read_config_dword(agp_bridge.dev, ALI_TLBCTRL, &temp);
-	pci_write_config_dword(agp_bridge.dev, ALI_TLBCTRL,
-			       ((temp & 0xffffff00) | 0x00000090));
-	pci_write_config_dword(agp_bridge.dev, ALI_TLBCTRL,
-			       ((temp & 0xffffff00) | 0x00000010));
+
+/***clear TAG*/
+pci_write_config_dword(agp_bridge.dev, ALI_TAGCTRL,
+                               ((temp & 0xfffffff0) | 0x00000001|0x00000002));
+
 }
 
 static void ali_cleanup(void)
@@ -1912,31 +1934,122 @@
 	previous_size = A_SIZE_32(agp_bridge.previous_size);
 
 	pci_read_config_dword(agp_bridge.dev, ALI_TLBCTRL, &temp);
-	pci_write_config_dword(agp_bridge.dev, ALI_TLBCTRL,
-			       ((temp & 0xffffff00) | 0x00000090));
-	pci_write_config_dword(agp_bridge.dev, ALI_ATTBASE,
-			       previous_size->size_value);
+//clear TAG
+   pci_write_config_dword(agp_bridge.dev, ALI_TAGCTRL,
+                               ((temp & 0xffffff00) | 0x00000001|0x00000002));
+
+        pci_read_config_dword(agp_bridge.dev,  ALI_ATTBASE, &temp);
+        pci_write_config_dword(agp_bridge.dev, ALI_ATTBASE,
+                              ((temp & 0x00000ff0)|previous_size->size_value));
+}
+
+static unsigned long ali_alloc_page(void)
+{
+	void *pt;
+	u32 temp;
+
+	pt = (void *) __get_free_page(GFP_KERNEL);
+	if (pt == NULL) {
+		return 0;
+	}
+	atomic_inc(&virt_to_page(pt)->count);
+	set_bit(PG_locked, &virt_to_page(pt)->flags);
+	atomic_inc(&agp_bridge.current_memory_agp);
+	global_cache_flush();
+	if (agp_bridge.type == ALI_M1541) {
+		pci_read_config_dword(agp_bridge.dev, L1_2_CACHE_FLUSH_CTRL ,
+					&temp);
+		pci_write_config_dword(agp_bridge.dev, L1_2_CACHE_FLUSH_CTRL ,
+					(((temp & CACHE_FLUSH_ADDR_MASK) |
+					virt_to_phys((void *)pt)) |
+					CACHE_FLUSH_EN ));
+	}
+	return (unsigned long) pt;
+}
+
+static void ali_destroy_page(unsigned long page)
+{
+	u32 temp;
+
+	void *pt = (void *) page;
+
+	if (pt == NULL) {
+		return;
+	}
+	global_cache_flush();
+	if (agp_bridge.type == ALI_M1541) {
+		pci_read_config_dword(agp_bridge.dev, L1_2_CACHE_FLUSH_CTRL ,
+					&temp);
+		pci_write_config_dword(agp_bridge.dev, L1_2_CACHE_FLUSH_CTRL ,
+					(((temp & CACHE_FLUSH_ADDR_MASK) |
+					virt_to_phys((void *)pt)) |
+					CACHE_FLUSH_EN ));
+	}
+	atomic_dec(&virt_to_page(pt)->count);
+	clear_bit(PG_locked, &virt_to_page(pt)->flags);
+	wake_up(&virt_to_page(pt)->wait);
+	free_page((unsigned long) pt);
+	atomic_dec(&agp_bridge.current_memory_agp);
 }
 
 static int ali_configure(void)
 {
 	u32 temp;
 	aper_size_info_32 *current_size;
+	u32 nlvm_addr=0;
 
 	current_size = A_SIZE_32(agp_bridge.current_size);
+ printk(KERN_INFO PFX "a= %0lx, s=%1u \n",agp_bridge.gatt_bus_addr,current_size->size_value);
+
+       /* aperture size and gatt addr */
+        pci_read_config_dword(agp_bridge.dev,  ALI_ATTBASE, &temp);
+
+        temp=(((temp & 0x00000ff0) | (agp_bridge.gatt_bus_addr&0xfffff000))
+        | (current_size->size_value&0xf));
+        pci_write_config_dword(agp_bridge.dev, ALI_ATTBASE,temp);
 
-	/* aperture size and gatt addr */
-	pci_write_config_dword(agp_bridge.dev, ALI_ATTBASE,
-		    agp_bridge.gatt_bus_addr | current_size->size_value);
+      printk(KERN_INFO PFX "temp= %0x, s=%1u \n",temp,current_size->size_value);
 
 	/* tlb control */
-	pci_read_config_dword(agp_bridge.dev, ALI_TLBCTRL, &temp);
-	pci_write_config_dword(agp_bridge.dev, ALI_TLBCTRL,
-			       ((temp & 0xffffff00) | 0x00000010));
 
-	/* address to map to */
+        pci_read_config_dword(agp_bridge.dev, ALI_APBASE, &temp);
+        agp_bridge.gart_bus_addr = (temp & PCI_BASE_ADDRESS_MEM_MASK);
+
+        /* address to map to */
+
 	pci_read_config_dword(agp_bridge.dev, ALI_APBASE, &temp);
 	agp_bridge.gart_bus_addr = (temp & PCI_BASE_ADDRESS_MEM_MASK);
+       printk(KERN_INFO PFX "gat bus addr = %8lx\n",agp_bridge.gart_bus_addr);
+
+        if (agp_bridge.type == ALI_M1541)
+          {
+          switch (current_size->size_value)  {
+                        case 0:  break;
+                        case 1:  nlvm_addr = 0x100000;break;
+                        case 2:  nlvm_addr = 0x200000;break;
+                        case 3:  nlvm_addr = 0x400000;break;
+                        case 4:  nlvm_addr = 0x800000;break;
+                        case 6:  nlvm_addr = 0x1000000;break;
+                        case 7:  nlvm_addr = 0x2000000;break;
+                        case 8:  nlvm_addr = 0x4000000;break;
+                        case 9:  nlvm_addr = 0x8000000;break;
+                        case 10: nlvm_addr = 0x10000000;break;
+                        default: break;
+                }
+                        nlvm_addr--;
+                        nlvm_addr&=0xfff00000;
+
+                        nlvm_addr+= agp_bridge.gart_bus_addr;
+                        nlvm_addr|=(agp_bridge.gart_bus_addr>>12);
+//printk(KERN_INFO PFX "nlvm top &base = %8x\n",nlvm_addr);
+
+           }
+             pci_read_config_dword(agp_bridge.dev, ALI_TLBCTRL, &temp);
+             temp&=0xffffff7f;//enable TLB
+             pci_write_config_dword(agp_bridge.dev, ALI_TLBCTRL,temp);
+
+
+
 	return 0;
 }
 
@@ -1980,13 +2093,15 @@
 	agp_bridge.tlb_flush = ali_tlbflush;
 	agp_bridge.mask_memory = ali_mask_memory;
 	agp_bridge.agp_enable = agp_generic_agp_enable;
-	agp_bridge.cache_flush = global_cache_flush;
+	agp_bridge.cache_flush = ali_generic_cache_flush;
 	agp_bridge.create_gatt_table = agp_generic_create_gatt_table;
 	agp_bridge.free_gatt_table = agp_generic_free_gatt_table;
 	agp_bridge.insert_memory = agp_generic_insert_memory;
 	agp_bridge.remove_memory = agp_generic_remove_memory;
 	agp_bridge.alloc_by_type = agp_generic_alloc_by_type;
 	agp_bridge.free_by_type = agp_generic_free_by_type;
+	agp_bridge.agp_alloc_page = ali_alloc_page;
+	agp_bridge.agp_destroy_page = ali_destroy_page;
 
 	return 0;
 	
@@ -2015,6 +2130,42 @@
 		"Ali",
 		"M1541",
 		ali_generic_setup },
+        { PCI_DEVICE_ID_AL_M1621_0,  
+                PCI_VENDOR_ID_AL,
+                ALI_M1621,
+                "Ali",
+                "M1621",
+                ali_generic_setup },
+        { PCI_DEVICE_ID_AL_M1631_0,
+                PCI_VENDOR_ID_AL,
+                ALI_M1631,
+                "Ali",
+                "M1631",
+                ali_generic_setup },
+        { PCI_DEVICE_ID_AL_M1641_0,
+                PCI_VENDOR_ID_AL,
+                ALI_M1641,
+                "Ali",
+                "M1641",
+                ali_generic_setup },
+        { PCI_DEVICE_ID_AL_M1632_0,
+                PCI_VENDOR_ID_AL,
+                ALI_M1632,
+                "Ali",
+                "M1632",
+                ali_generic_setup },
+        { PCI_DEVICE_ID_AL_M1647_0,
+                PCI_VENDOR_ID_AL,
+                ALI_M1647,
+                "Ali",
+                "M1647",
+                ali_generic_setup },
+        { PCI_DEVICE_ID_AL_M1651_0,
+                PCI_VENDOR_ID_AL,
+                ALI_M1651,
+                "Ali",
+                "M1651",
+                ali_generic_setup },
 	{ 0,
 		PCI_VENDOR_ID_AL,
 		ALI_GENERIC,
@@ -2201,6 +2352,36 @@
 	while ((i < ARRAY_SIZE (agp_bridge_info)) &&
 	       (agp_bridge_info[i].vendor_id == pdev->vendor)) {
 		if (pdev->device == agp_bridge_info[i].device_id) {
+#ifdef CONFIG_AGP_ALI
+                        u8 hidden_1621_id;
+                        if (pdev->device == PCI_DEVICE_ID_AL_M1621_0){
+                                pci_read_config_byte(pdev, 0xFB, &hidden_1621_id);
+                                switch(hidden_1621_id){
+                                        case 0x31:
+                                                  agp_bridge_info[i].chipset_name="M1631";
+                                                  break;
+                                        case 0x32:
+                                                  agp_bridge_info[i].chipset_name="M1632";
+                                                  break;
+                                        case 0x41:
+                                                  agp_bridge_info[i].chipset_name="M1641";
+                                                  break;
+                                        case 0x43:
+                                                  break;
+                                        case 0x47:
+                                                  agp_bridge_info[i].chipset_name="M1647";
+                                                  break;
+                                        case 0x51:
+                                                  agp_bridge_info[i].chipset_name="M1651";
+                                                  break;
+
+                                        default:
+                                                  break;
+
+                                        }
+                        }
+#endif /* CONFIG_AGP_ALI */
+
 			printk (KERN_INFO PFX "Detected %s %s chipset\n",
 				agp_bridge_info[i].vendor_name,
 				agp_bridge_info[i].chipset_name);
@@ -2416,7 +2597,7 @@
 	}
 
 	if (agp_bridge.needs_scratch_page == TRUE) {
-		agp_bridge.scratch_page = agp_alloc_page();
+		agp_bridge.scratch_page = agp_bridge.agp_alloc_page();
 
 		if (agp_bridge.scratch_page == 0) {
 			printk(KERN_ERR PFX "unable to get memory for "
@@ -2469,7 +2650,7 @@
 err_out:
 	if (agp_bridge.needs_scratch_page == TRUE) {
 		agp_bridge.scratch_page &= ~(0x00000fff);
-		agp_destroy_page((unsigned long)
+		agp_bridge.agp_destroy_page((unsigned long)
 				 phys_to_virt(agp_bridge.scratch_page));
 	}
 	if (got_gatt)
@@ -2489,7 +2670,7 @@
 
 	if (agp_bridge.needs_scratch_page == TRUE) {
 		agp_bridge.scratch_page &= ~(0x00000fff);
-		agp_destroy_page((unsigned long)
+		agp_bridge.agp_destroy_page((unsigned long)
 				 phys_to_virt(agp_bridge.scratch_page));
 	}
 }
--- linux-2.4.0-test12/drivers/char/agp/agp.h.ali	Tue Nov  7 18:59:43 2000
+++ linux-2.4.0-test12/drivers/char/agp/agp.h	Sun Dec 17 16:42:52 2000
@@ -117,6 +117,8 @@
 	int (*remove_memory) (agp_memory *, off_t, int);
 	agp_memory *(*alloc_by_type) (size_t, int);
 	void (*free_by_type) (agp_memory *);
+	unsigned long (*agp_alloc_page) (void);
+	void (*agp_destroy_page) (unsigned long);
 };
 
 #define OUTREG32(mmap, addr, val)   __raw_writel((val), (mmap)+(addr))
@@ -200,6 +202,24 @@
 #ifndef PCI_DEVICE_ID_AL_M1541_0
 #define PCI_DEVICE_ID_AL_M1541_0	0x1541
 #endif
+#ifndef PCI_DEVICE_ID_AL_M1621_0
+#define PCI_DEVICE_ID_AL_M1621_0        0x1621
+#endif
+#ifndef PCI_DEVICE_ID_AL_M1631_0
+#define PCI_DEVICE_ID_AL_M1631_0        0x1631
+#endif
+#ifndef PCI_DEVICE_ID_AL_M1641_0
+#define PCI_DEVICE_ID_AL_M1641_0        0x1641
+#endif
+#ifndef PCI_DEVICE_ID_AL_M1632_0
+#define PCI_DEVICE_ID_AL_M1632_0        0x1632
+#endif
+#ifndef PCI_DEVICE_ID_AL_M1647_0
+#define PCI_DEVICE_ID_AL_M1647_0        0x1647
+#endif
+#ifndef PCI_DEVICE_ID_AL_M1651_0
+#define PCI_DEVICE_ID_AL_M1651_0        0x1651
+#endif
 
 /* intel register */
 #define INTEL_APBASE    0x10
@@ -260,5 +280,9 @@
 #define ALI_AGPCTRL	0xb8
 #define ALI_ATTBASE	0xbc
 #define ALI_TLBCTRL	0xc0
+#define ALI_TAGCTRL     0xc4
+#define L1_2_CACHE_FLUSH_CTRL 0xD0
+#define CACHE_FLUSH_ADDR_MASK 0xFFFFF000
+#define CACHE_FLUSH_EN  0x100
 
 #endif				/* _AGP_BACKEND_PRIV_H */
--- linux-2.4.0-test12/drivers/char/Config.in.ali	Thu Nov 16 21:59:53 2000
+++ linux-2.4.0-test12/drivers/char/Config.in	Sun Dec 17 16:42:52 2000
@@ -183,7 +183,7 @@
    bool '  VIA chipset support' CONFIG_AGP_VIA
    bool '  AMD Irongate support' CONFIG_AGP_AMD
    bool '  Generic SiS support' CONFIG_AGP_SIS
-   bool '  ALI M1541 support' CONFIG_AGP_ALI
+   bool '  ALI chipset support' CONFIG_AGP_ALI
 fi
 
 source drivers/char/drm/Config.in
--- linux-2.4.0-test12/Documentation/Configure.help.ali	Mon Dec 11 21:42:08 2000
+++ linux-2.4.0-test12/Documentation/Configure.help	Sun Dec 17 16:42:52 2000
@@ -2397,12 +2397,15 @@
   the GLX component for XFree86 3.3.6, which can be downloaded from
   http://utah-glx.sourceforge.net/ .
 
-ALI M1541 support
+ALI chipset support
 CONFIG_AGP_ALI
   This option gives you AGP support for the GLX component of the
-  XFree86 4.x on the ALi M1541 chipset.
+  XFree86 4.x on the following ALi chipsets.  The supported chipsets
+  include M1541, M1621, M1631, M1632, M1641,M1647,and M1651.
+  For ALI-chipset question, welcome you refer to
+  http://www.ali.com.tw/eng/support/index.shtml
 
-  This chipset can do AGP 1x and 2x, but note that there is an
+  M1541 chipset can do AGP 1x and 2x, but note that there is an
   acknowledged incompatibility with Matrox G200 cards. Due to
   timing issues, this chipset cannot do AGP 2x with the G200.
   This is a hardware limitation. AGP 1x seems to be fine, though.
--- linux-2.4.0-test12/include/linux/agp_backend.h.ali	Thu Nov 16 21:59:53 2000
+++ linux-2.4.0-test12/include/linux/agp_backend.h	Sun Dec 17 16:42:52 2000
@@ -58,6 +58,12 @@
 	AMD_GENERIC,
 	AMD_IRONGATE,
 	ALI_M1541,
+	ALI_M1621,
+	ALI_M1631,
+	ALI_M1641,
+	ALI_M1632,
+	ALI_M1647,
+	ALI_M1651,
 	ALI_GENERIC
 };
 
--- linux-2.4.0-test12/include/linux/pci_ids.h.ali	Mon Dec  4 01:45:23 2000
+++ linux-2.4.0-test12/include/linux/pci_ids.h	Sun Dec 17 16:42:52 2000
@@ -646,6 +646,11 @@
 #define PCI_DEVICE_ID_AL_M1531		0x1531
 #define PCI_DEVICE_ID_AL_M1533		0x1533
 #define PCI_DEVICE_ID_AL_M1541		0x1541
+#define PCI_DEVICE_ID_AL_M1621          0x1621
+#define PCI_DEVICE_ID_AL_M1631          0x1631
+#define PCI_DEVICE_ID_AL_M1641          0x1641
+#define PCI_DEVICE_ID_AL_M1647          0x1647
+#define PCI_DEVICE_ID_AL_M1651          0x1651
 #define PCI_DEVICE_ID_AL_M1543		0x1543
 #define PCI_DEVICE_ID_AL_M3307		0x3307
 #define PCI_DEVICE_ID_AL_M4803		0x5215
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
