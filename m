Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316456AbSFPRsr>; Sun, 16 Jun 2002 13:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316475AbSFPRsq>; Sun, 16 Jun 2002 13:48:46 -0400
Received: from zwanebloem.xs4all.nl ([213.84.22.107]:35203 "EHLO
	router.zwanebloem.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316456AbSFPRso>; Sun, 16 Jun 2002 13:48:44 -0400
Message-ID: <3D0CCF7B.9040709@thuis.zwanebloem.nl>
Date: Sun, 16 Jun 2002 19:48:43 +0200
From: Tommy Faasen <it0@thuis.zwanebloem.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020614
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.21 nvdia kernel module
Content-Type: multipart/mixed;
 boundary="------------010900050804080805030500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010900050804080805030500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This makes the NVidia kernel module version 2960 work again with kernel 
2.5.21.
Since suser disappeared I replaced it with capable().

I hope I did it correctly anyway Quake3 and glxgears worked for me

Just apply the patch below...



--------------010900050804080805030500
Content-Type: text/plain;
 name="nvidk2960.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nvidk2960.diff"

diff -urN NVIDIA_kernel-1.0-2960/nv-linux.h NVIDIA_kernel-1.0-2960.mod/nv-linux.h
--- NVIDIA_kernel-1.0-2960/nv-linux.h	Tue May 14 17:26:16 2002
+++ NVIDIA_kernel-1.0-2960.mod/nv-linux.h	Fri Jun 14 22:41:49 2002
@@ -38,7 +38,7 @@
 #elif LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
 #  define KERNEL_2_4
 #elif LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 0)
-#  error This driver does not support 2.5.x development kernels!
+//#  error This driver does not support 2.5.x development kernels!
 #  define KERNEL_2_5
 #else
 #  error This driver does not support 2.6.x or newer kernels!
diff -urN NVIDIA_kernel-1.0-2960/nv.c NVIDIA_kernel-1.0-2960.mod/nv.c
--- NVIDIA_kernel-1.0-2960/nv.c	Tue May 14 17:26:16 2002
+++ NVIDIA_kernel-1.0-2960.mod/nv.c	Fri Jun 14 22:41:49 2002
@@ -50,6 +50,12 @@
 #include <linux/devfs_fs_kernel.h>
 #endif
 
+/* Since 2.5.x this is needed for the coorect lookup of the page table entry */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 5, 0)
+#include <asm/kmap_types.h>
+#include <linux/highmem.h>
+#endif
+
 #include <asm/page.h>
 #include <asm/pgtable.h>  		// pte bit definitions
 #include <asm/system.h>                 // cli(), *_flags
@@ -1155,11 +1161,22 @@
 
     /* for control device, just jump to its open routine */
     /* after setting up the private data */
+
+    /* I don't really know the correct kernel version since when it changed */ 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0) 
     if (NV_DEVICE_IS_CONTROL_DEVICE(inode->i_rdev))
         return nv_kern_ctl_open(inode, file);
-
+#else
+    if (NV_DEVICE_IS_CONTROL_DEVICE(kdev_val(inode->i_rdev)))
+        return nv_kern_ctl_open(inode, file);
+#endif
     /* what device are we talking about? */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
     devnum = NV_DEVICE_NUMBER(inode->i_rdev);
+#else
+    devnum = NV_DEVICE_NUMBER(kdev_val(inode->i_rdev));
+#endif
     if (devnum >= NV_MAX_DEVICES)
     {
         rc = -ENODEV;
@@ -1265,9 +1282,14 @@
 
     /* for control device, just jump to its open routine */
     /* after setting up the private data */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
     if (NV_DEVICE_IS_CONTROL_DEVICE(inode->i_rdev))
+       return nv_kern_ctl_close(inode, file);
+#else
+    if(NV_DEVICE_IS_CONTROL_DEVICE(kdev_val(inode->i_rdev)))
         return nv_kern_ctl_close(inode, file);
-
+#endif
     NV_DMSG(nv, "close");
 
     nv_unix_free_all_unused_clients(nv, current->pid, (void *) file);
@@ -1386,11 +1408,21 @@
 #if defined(IA64)
         vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 #endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
         if (remap_page_range(vma->vm_start,
                              (u32)(nv->regs.address) + LINUX_VMA_OFFS(vma) - NV_MMAP_REG_OFFSET,
                              vma->vm_end - vma->vm_start,
                              vma->vm_page_prot))
             return -EAGAIN;
+#else
+        if (remap_page_range(vma,
+                            vma->vm_start,
+                             (u32) (nv->regs.address) + LINUX_VMA_OFFS(vma) - NV_MMAP_REG_OFFSET,
+                             vma->vm_end - vma->vm_start,
+                             vma->vm_page_prot))
+            return -EAGAIN;
+#endif
 
         /* mark it as IO so that we don't dump it on core dump */
         vma->vm_flags |= VM_IO;
@@ -1403,11 +1435,20 @@
 #if defined(IA64)
         vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 #endif
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
         if (remap_page_range(vma->vm_start,
                              (u32)(nv->fb.address) + LINUX_VMA_OFFS(vma) - NV_MMAP_FB_OFFSET,
                              vma->vm_end - vma->vm_start,
                              vma->vm_page_prot))
             return -EAGAIN;
+#else
+        if (remap_page_range(vma,
+                            vma->vm_start,
+                             (u32) (nv->fb.address) + LINUX_VMA_OFFS(vma) - NV_MMAP_FB_OFFSET,
+                             vma->vm_end - vma->vm_start,
+                             vma->vm_page_prot))
+            return -EAGAIN;
+#endif
 
         // mark it as IO so that we don't dump it on core dump
         vma->vm_flags |= VM_IO;
@@ -1437,8 +1478,13 @@
         while (pages--)
         {
             page = (unsigned long) at->page_table[i++];
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
             if (remap_page_range(start, page, PAGE_SIZE, PAGE_SHARED))
               	return -EAGAIN;
+#else
+            if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
+                 return -EAGAIN;
+#endif
             start += PAGE_SIZE;
             pos += PAGE_SIZE;
        	}
@@ -2273,7 +2319,11 @@
     pte_kunmap(pte__);
 #else
     pte__ = NULL;
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
     pte = *pte_offset(pg_mid_dir, address);
+#else
+    pte = *pte_offset_map(pg_mid_dir, address);
+#endif
 #endif
 
     if (!pte_present(pte)) 
diff -urN NVIDIA_kernel-1.0-2960/os-interface.c NVIDIA_kernel-1.0-2960.mod/os-interface.c
--- NVIDIA_kernel-1.0-2960/os-interface.c	Tue May 14 17:26:16 2002
+++ NVIDIA_kernel-1.0-2960.mod/os-interface.c	Sun Jun 16 19:33:46 2002
@@ -46,6 +46,7 @@
 #include <linux/delay.h>        // udelay()
 #include <linux/pci.h>          // pci_*() functions
 #include <linux/kmod.h>         // request_module
+#include <linux/sched.h>	// replacement for suser() is capable();
 #include <asm/io.h>             // ioremap() and iounmap()
 #ifdef CONFIG_MTRR
 #include <asm/mtrr.h>           // mtrr_add()
@@ -118,7 +119,8 @@
     PHWINFO pDev
 )
 {
-    return suser();
+    return capable(CAP_SYS_ADMIN);
+    //return suser();
 }
 
 //
@@ -1458,9 +1460,14 @@
     uaddr = *priv;
 
     /* finally, let's do it! */
-    err = remap_page_range( (size_t) uaddr, (size_t) paddr, size_bytes, 
+    
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
+    err = remap_page_range( (size_t) uaddr, (size_t) paddr, size_bytes,
+                           PAGE_SHARED);
+#else
+    err = remap_page_range( kaddr, (size_t) uaddr, (size_t) paddr, size_bytes,
                             PAGE_SHARED);
-
+#endif
     if (err != 0)
     {
         return (void *) NULL;
@@ -1485,10 +1492,14 @@
 
     uaddr = *priv;
 
-    /* finally, let's do it! */
-    err = remap_page_range( (size_t) uaddr, (size_t) start, size_bytes, 
+    /* finally, let's do it! */ 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
+    err = remap_page_rage( (size_t) uaddr, (size_t) start, size_bytes,
+                          PAGE_SHARED);    
+#else
+    err = remap_page_range( *priv, (size_t) uaddr, (size_t) start, size_bytes, 
                             PAGE_SHARED);
-
+#endif
     if (err != 0)
     {
         return (void *) NULL;
@@ -2032,15 +2043,25 @@
         return RM_ERROR;
 
     agp_addr = agpinfo.aper_base + (agp_data->offset << PAGE_SHIFT);
-
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
     err = remap_page_range(vma->vm_start, (size_t) agp_addr, 
                            agp_data->num_pages << PAGE_SHIFT,
 #if defined(IA64)
                            vma->vm_page_prot);
 #else
                            PAGE_SHARED);
-#endif
-        
+#endif /* IA64 */
+
+#else
+    err = remap_page_range(vma,
+                          vma->vm_start, (size_t) agp_addr, 
+                           agp_data->num_pages << PAGE_SHIFT,
+#if defined(IA64)
+                           vma->vm_page_prot);
+#else
+                           PAGE_SHARED);
+#endif /* IA64 */
+#endif /* LINUX_VERSION_CODE */
     if (err) {
         printk(KERN_ERR "NVRM: AGPGART: unable to remap %lu pages\n",
                (unsigned long)agp_data->num_pages);

--------------010900050804080805030500--

