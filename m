Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293196AbSB1I4O>; Thu, 28 Feb 2002 03:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293192AbSB1IyC>; Thu, 28 Feb 2002 03:54:02 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:50338 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S293198AbSB1Ivm>; Thu, 28 Feb 2002 03:51:42 -0500
Message-ID: <XFMail.020228094914.pirx@minet.uni-jena.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <XFMail.020220191722.pirx@minet.uni-jena.de>
Date: Thu, 28 Feb 2002 09:49:14 +0100 (CET)
Reply-To: pirx@minet.uni-jena.de
From: 520042182928-0001@t-online.de (Martin Huenniger)
To: <520042182928-0001@t-online.de (Martin Huenniger)>
Subject: RE: patch to NVIDIA_kernel & kernel 2.5.5
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI 

There were obviously some probmlems with the patch I hope I have fixed them now.

Have fun!

----snip----

diff -ur NVIDIA_kernel-1.0-2314.old/nv.c NVIDIA_kernel-1.0-2314/nv.c
--- NVIDIA_kernel-1.0-2314.old/nv.c     Sat Dec  1 05:11:06 2001
+++ NVIDIA_kernel-1.0-2314/nv.c Sun Feb 24 12:37:35 2002
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
 #include <asm/pgtable.h>               // pte bit definitions
 #include <asm/system.h>                 // cli(), *_flags
@@ -1119,7 +1125,6 @@
 #endif
 };
 
-
 /*
 ** nv_kern_open
 **
@@ -1146,11 +1151,22 @@
 
     /* for control device, just jump to its open routine */
     /* after setting up the private data */
+    
+    /* I don't really know the correct kernel version since when it changed */ 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0) 
     if (NV_DEVICE_IS_CONTROL_DEVICE(inode->i_rdev))
+       return nv_kern_ctl_open(inode, file);
+#else    
+    if (NV_DEVICE_IS_CONTROL_DEVICE(kdev_val(inode->i_rdev)))
         return nv_kern_ctl_open(inode, file);
-
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
@@ -1257,8 +1273,14 @@
 
     /* for control device, just jump to its open routine */
     /* after setting up the private data */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)    
     if (NV_DEVICE_IS_CONTROL_DEVICE(inode->i_rdev))
+       return nv_kern_ctl_close(inode, file);
+#else
+    if(NV_DEVICE_IS_CONTROL_DEVICE(kdev_val(inode->i_rdev)))
         return nv_kern_ctl_close(inode, file);
+#endif
 
     NV_DMSG(nv, "close");
 
@@ -1383,11 +1405,21 @@
 #if defined(IA64)
         vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 #endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
         if (remap_page_range(vma->vm_start,
                              (u32) (nv->reg_physical_address) +
LINUX_VMA_OFFS(vma) - NV_MMAP_REG_OFFSET,
                              vma->vm_end - vma->vm_start,
                              vma->vm_page_prot))
             return -EAGAIN;
+#else
+        if (remap_page_range(vma,
+                            vma->vm_start,
+                             (u32) (nv->reg_physical_address) +
LINUX_VMA_OFFS(vma) - NV_MMAP_REG_OFFSET,
+                             vma->vm_end - vma->vm_start,
+                             vma->vm_page_prot))
+            return -EAGAIN;
+#endif
 
         /* mark it as IO so that we don't dump it on core dump */
         vma->vm_flags |= VM_IO;
@@ -1400,12 +1432,21 @@
 #if defined(IA64)
         vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 #endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0) 
         if (remap_page_range(vma->vm_start,
                              (u32) (nv->fb_physical_address) +
LINUX_VMA_OFFS(vma) - NV_MMAP_FB_OFFSET,
                              vma->vm_end - vma->vm_start,
                              vma->vm_page_prot))
             return -EAGAIN;
-
+#else
+        if (remap_page_range(vma,
+                            vma->vm_start,
+                             (u32) (nv->fb_physical_address) +
LINUX_VMA_OFFS(vma) - NV_MMAP_FB_OFFSET,
+                             vma->vm_end - vma->vm_start,
+                             vma->vm_page_prot))
+            return -EAGAIN;
+#endif
         // mark it as IO so that we don't dump it on core dump
         vma->vm_flags |= VM_IO;
     }
@@ -1435,8 +1476,13 @@
         while (pages--)
         {
             page = (unsigned long) at->page_table[i++];
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)           
             if (remap_page_range(start, page, PAGE_SIZE, PAGE_SHARED))
+               return -EAGAIN;
+#else
+           if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
                return -EAGAIN;
+#endif
             start += PAGE_SIZE;
             pos += PAGE_SIZE;
                }
@@ -2298,7 +2344,11 @@
     if (pmd_none(*pg_mid_dir))
         goto failed;
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
     pg_table = pte_offset(pg_mid_dir, address);
+#else
+    pg_table = pte_offset_map(pg_mid_dir, address);
+#endif
     if (!pte_present(*pg_table))
         goto failed;
 
diff -ur NVIDIA_kernel-1.0-2314.old/os-interface.c
NVIDIA_kernel-1.0-2314/os-interface.c
--- NVIDIA_kernel-1.0-2314.old/os-interface.c   Sat Dec  1 05:11:06 2001
+++ NVIDIA_kernel-1.0-2314/os-interface.c       Wed Feb 20 18:19:01 2002
@@ -1445,10 +1445,15 @@
 
     uaddr = *priv;
 
-    /* finally, let's do it! */
-    err = remap_page_range( (size_t) uaddr, (size_t) paddr, size_bytes, 
+    /* finally, let's do it! */ 
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
@@ -1473,10 +1478,14 @@
 
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
@@ -2027,13 +2036,25 @@
 
     agp_addr = agpinfo.aper_base + (agp_data->offset << PAGE_SHIFT);
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
     err = remap_page_range(vma->vm_start, (size_t) agp_addr, 
                            agp_data->num_pages << PAGE_SHIFT,
 #if defined(IA64)
                            vma->vm_page_prot);
 #else
                            PAGE_SHARED);
-#endif
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

----snip----

-----------------------------------------------
E-Mail: Martin Huenniger <pirx@minet.uni-jena.de>
Date: 28-Feb-02
Time: 09:49:14
-----------------------------------------------
