Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313687AbSEMOEN>; Mon, 13 May 2002 10:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313661AbSEMOEM>; Mon, 13 May 2002 10:04:12 -0400
Received: from yuha.menta.net ([212.78.128.42]:11770 "EHLO yuha.menta.net")
	by vger.kernel.org with ESMTP id <S313687AbSEMOEB>;
	Mon, 13 May 2002 10:04:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ivanovich <ivanovich@menta.net>
To: Jasper van Veghel <vanveghel@home.nl>
Subject: Re: [PATCH] NVIDIA_kernel_2802 & kernel 2.5.5 --> updated to 2880
Date: Mon, 13 May 2002 16:03:04 +0200
X-Mailer: KMail [version 1.4]
In-Reply-To: <41B61F96.9060203@home.nl>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200205131603.04790.ivanovich@menta.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dimarts 07 Desembre 2004 22:24, Jasper van Veghel wrote:
> Heya
>
> A while ago I caught a patch for the NVIDIA 2314 kernel driver which
> made the driver work in 2.5.X (I'm using 2.5.6-pre1 and it worked for
> me) but now that NVIDIA have released their 2802 drivers, a new patch is
> needed, I adapted the old one, credit for that one goes to Martin
> Huenniger, to work with the latest version, didn't require much work so
> thank Martin, not me :)
>
> Have fun with it ^^
>
> Jasper van Veghel

Hi

Your patch caused a reject with nvidia kernel driver 2880 (which i think is 
the latest version)

I just updated it (tested in 2.5.15):




diff -urN NVIDIA_kernel-1.0-2880/nv-linux.h nker/nv-linux.h
--- NVIDIA_kernel-1.0-2880/nv-linux.h	Tue Mar 26 17:52:43 2002
+++ nker/nv-linux.h	Mon May 13 15:33:30 2002
@@ -38,7 +38,6 @@
 #elif LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
 #  define KERNEL_2_4
 #elif LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 0)
-#  error This driver does not support 2.5.x development kernels!
 #  define KERNEL_2_5
 #else
 #  error This driver does not support 2.6.x or newer kernels!
diff -urN NVIDIA_kernel-1.0-2880/nv.c nker/nv.c
--- NVIDIA_kernel-1.0-2880/nv.c	Tue Mar 26 17:52:43 2002
+++ nker/nv.c	Mon May 13 15:44:39 2002
@@ -50,6 +50,12 @@
 #include <linux/devfs_fs_kernel.h>
 #endif
 
+/* Since 2.5.x this is needed for the coorect lookup of the page table entry 
*/
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 5, 0)
+#include <asm/kmap_types.h>
+#include <linux/highmem.h>
+#endif
+
 #include <asm/page.h>
 #include <asm/pgtable.h>  		// pte bit definitions
 #include <asm/system.h>                 // cli(), *_flags
@@ -1153,11 +1159,22 @@
 
     /* for control device, just jump to its open routine */
     /* after setting up the private data */
+
+    /* I don't really know the correct kernel version since when it changed 
*/ 
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
@@ -1263,9 +1280,14 @@
 
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
@@ -1384,11 +1406,21 @@
 #if defined(IA64)
         vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 #endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
         if (remap_page_range(vma->vm_start,
                              (u32)(nv->regs.address) + LINUX_VMA_OFFS(vma) - 
NV_MMAP_REG_OFFSET,
                              vma->vm_end - vma->vm_start,
                              vma->vm_page_prot))
             return -EAGAIN;
+#else
+        if (remap_page_range(vma,
+                            vma->vm_start,
+                             (u32) (nv->regs.address) + LINUX_VMA_OFFS(vma) - 
NV_MMAP_REG_OFFSET,
+                             vma->vm_end - vma->vm_start,
+                             vma->vm_page_prot))
+            return -EAGAIN;
+#endif
 
         /* mark it as IO so that we don't dump it on core dump */
         vma->vm_flags |= VM_IO;
@@ -1401,11 +1433,20 @@
 #if defined(IA64)
         vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 #endif
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
         if (remap_page_range(vma->vm_start,
                              (u32)(nv->fb.address) + LINUX_VMA_OFFS(vma) - 
NV_MMAP_FB_OFFSET,
                              vma->vm_end - vma->vm_start,
                              vma->vm_page_prot))
             return -EAGAIN;
+#else
+        if (remap_page_range(vma,
+                            vma->vm_start,
+                             (u32) (nv->fb.address) + LINUX_VMA_OFFS(vma) - 
NV_MMAP_FB_OFFSET,
+                             vma->vm_end - vma->vm_start,
+                             vma->vm_page_prot))
+            return -EAGAIN;
+#endif
 
         // mark it as IO so that we don't dump it on core dump
         vma->vm_flags |= VM_IO;
@@ -1434,10 +1475,15 @@
         start = vma->vm_start;
         while (pages--)
         {
-            page = (unsigned long) at->page_table[i++];
-            if (remap_page_range(start, page, PAGE_SIZE, PAGE_SHARED))
+	    page = (unsigned long) at->page_table[i++];
+ #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
+	    if (remap_page_range(start, page, PAGE_SIZE, PAGE_SHARED))
               	return -EAGAIN;
-            start += PAGE_SIZE;
+ #else
+	            if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
+	                 return -EAGAIN;
+ #endif
+	    start += PAGE_SIZE;
             pos += PAGE_SIZE;
        	}
         nv_unlock_at(nv);
@@ -2262,7 +2308,11 @@
     if (pmd_none(*pg_mid_dir))
         goto failed;
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
     pg_table = pte_offset(pg_mid_dir, address);
+#else
+    pg_table = pte_offset_map(pg_mid_dir, address);
+#endif
     if (!pte_present(*pg_table))
         goto failed;
 
diff -urN NVIDIA_kernel-1.0-2880/os-interface.c nker/os-interface.c
--- NVIDIA_kernel-1.0-2880/os-interface.c	Tue Mar 26 17:52:43 2002
+++ nker/os-interface.c	Mon May 13 15:33:30 2002
@@ -1463,9 +1463,14 @@
     uaddr = *priv;
 
     /* finally, let's do it! */
-    err = remap_page_range( (size_t) uaddr, (size_t) paddr, size_bytes, 
+    
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
+    err = remap_page_range( (size_t) uaddr, (size_t) paddr, size_bytes,
+                           PAGE_SHARED);
+#else
+    err = remap_page_range( kaddr, (size_t) uaddr, (size_t) paddr, 
size_bytes,
                             PAGE_SHARED);
-
+#endif
     if (err != 0)
     {
         return (void *) NULL;
@@ -1490,10 +1495,14 @@
 
     uaddr = *priv;
 
-    /* finally, let's do it! */
-    err = remap_page_range( (size_t) uaddr, (size_t) start, size_bytes, 
+    /* finally, let's do it! */ 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
+    err = remap_page_rage( (size_t) uaddr, (size_t) start, size_bytes,
+                          PAGE_SHARED);    
+#else
+    err = remap_page_range( *priv, (size_t) uaddr, (size_t) start, 
size_bytes, 
                             PAGE_SHARED);
-
+#endif
     if (err != 0)
     {
         return (void *) NULL;
@@ -2037,15 +2046,25 @@
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

