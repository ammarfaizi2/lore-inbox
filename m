Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316523AbSFUJdA>; Fri, 21 Jun 2002 05:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316530AbSFUJc7>; Fri, 21 Jun 2002 05:32:59 -0400
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([66.185.86.71]:39486
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S316523AbSFUJc4>; Fri, 21 Jun 2002 05:32:56 -0400
Message-ID: <3D1300D1.8020903@bonin.ca>
Date: Fri, 21 Jun 2002 05:32:49 -0500
From: Andre Bonin <kernel@bonin.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
X-Accept-Language: en-us, fr-ca
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Patch] Makes NVidia's driver work with kernel 2.5.24
Content-Type: multipart/mixed;
 boundary="------------050006070205060602050706"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep01-mail.bloor.is.net.cable.rogers.com from [24.112.33.136] using ID <bonin@rogers.com> at Fri, 21 Jun 2002 05:32:53 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050006070205060602050706
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

I found a patch that makes the NVidia's driver (NVIDIA_kernel-1.0-2960) 
work with the 2.5 series kernels.  Unfortunatly it breaks because of the 
deprecation of suser in 2.5.24.  I have created a patch for this (from 
the 'stable' NVIDIA_kernel-1.0-2960 driver).

Most of the patch is not my doing but an unamed person somewhere on the 
net. If you are that person, you can reply to this mail and take your 
valid credit.

This is my first module change and my first patch so if there is 
anything 'wierd' or 'wrong' please tell me, there's only one way to learn.

Thanks!

---
***********************************
Andre Bonin
Computer Engineering Technologist
Student in Software Engineering
Ottawa, Ontario
Canada
***********************************

--------------050006070205060602050706
Content-Type: text/plain;
 name="patch.nvidia-2.5.24.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.nvidia-2.5.24.diff"

diff -ruN stable/NVIDIA_kernel-1.0-2960/Makefile NVIDIA_kernel-1.0-2960/Makefile
--- stable/NVIDIA_kernel-1.0-2960/Makefile	Tue May 14 10:26:15 2002
+++ NVIDIA_kernel-1.0-2960/Makefile	Fri Jun 21 04:16:51 2002
@@ -9,6 +9,7 @@
 HEADERS=os-interface.h nv-linux.h nv.h  nvrm.h nvtypes.h $(VERSION_HDR)
 
 CFLAGS=-Wall -Wimplicit -Wreturn-type -Wswitch -Wformat -Wchar-subscripts -Wparentheses -Wpointer-arith -Wcast-qual -Wno-multichar  -O -MD $(DEFINES) $(INCLUDES) -Wno-cast-qual
+                        
 
 RESMAN_KERNEL_MODULE=Module-nvkernel
 
diff -ruN stable/NVIDIA_kernel-1.0-2960/nv-linux.h NVIDIA_kernel-1.0-2960/nv-linux.h
--- stable/NVIDIA_kernel-1.0-2960/nv-linux.h	Tue May 14 10:26:16 2002
+++ NVIDIA_kernel-1.0-2960/nv-linux.h	Fri May 31 12:35:41 2002
@@ -38,7 +38,7 @@
 #elif LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
 #  define KERNEL_2_4
 #elif LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 0)
-#  error This driver does not support 2.5.x development kernels!
+//#  error This driver does not support 2.5.x development kernels!
 #  define KERNEL_2_5
 #else
 #  error This driver does not support 2.6.x or newer kernels!
diff -ruN stable/NVIDIA_kernel-1.0-2960/nv.c NVIDIA_kernel-1.0-2960/nv.c
--- stable/NVIDIA_kernel-1.0-2960/nv.c	Tue May 14 10:26:16 2002
+++ NVIDIA_kernel-1.0-2960/nv.c	Fri May 31 12:35:41 2002
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
diff -ruN stable/NVIDIA_kernel-1.0-2960/os-interface.c NVIDIA_kernel-1.0-2960/os-interface.c
--- stable/NVIDIA_kernel-1.0-2960/os-interface.c	Tue May 14 10:26:16 2002
+++ NVIDIA_kernel-1.0-2960/os-interface.c	Fri Jun 21 04:54:35 2002
@@ -41,6 +41,7 @@
 #include <linux/stddef.h>
 #include <linux/kernel.h>       // printk()
 #include <linux/errno.h>        // error codes
+#include <linux/sched.h>        // capable(int)
 #include <linux/types.h>        // size_t
 #include <linux/interrupt.h>    // in_interrupt()
 #include <linux/delay.h>        // udelay()
@@ -114,13 +115,13 @@
 #endif // DEBUG
 
 // return TRUE if the caller is the super-user
-BOOL osIsAdministrator(
-    PHWINFO pDev
-)
-{
-    return suser();
+
+BOOL osIsAdministrator( PHWINFO pDev ) {
+    return capable( CAP_SYS_ADMIN );
 }
 
+
+
 //
 // Some quick and dirty library functions.
 // This is an OS function because some operating systems supply their
@@ -1458,9 +1459,14 @@
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
@@ -1485,10 +1491,14 @@
 
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
@@ -2032,15 +2042,25 @@
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

--------------050006070205060602050706--

