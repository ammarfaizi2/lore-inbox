Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316951AbSE3XcK>; Thu, 30 May 2002 19:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316952AbSE3XcK>; Thu, 30 May 2002 19:32:10 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:24281 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S316951AbSE3XcH>; Thu, 30 May 2002 19:32:07 -0400
Message-ID: <3CF6B63C.80508@drugphish.ch>
Date: Fri, 31 May 2002 01:31:08 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brian Davids <dlister@dlister.net>
Cc: linux-kernel@vger.kernel.org, Michail Rusinov <one@da.ru>
Subject: Re: PROBLEM: NVidia drivers with 2.5 kernel
In-Reply-To: <3CF6723E.3020502@dlister.net>
Content-Type: multipart/mixed;
 boundary="------------080807060602060507040900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080807060602060507040900
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

> There was a patch to nVidia's v.2880 drivers tested on kernel 2.5.15
> posted on May 13 which you can find here:
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0205.1/1034.html

Attached is a version forward ported for:

o linux kernel 2.5.19
o NVIDIA_kernel-1.0-2960

I'm running it on a Dell Inspiron 8000. Besides 2.5.19 being sluggish as 
hell and that the HDIO_SET_32BIT ioctl seem not to work, quake2 runs 
like hell ;)

Cheers,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

--------------080807060602060507040900
Content-Type: text/plain;
 name="patch.nvidia-2.5.19.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.nvidia-2.5.19.diff"

diff -ur NVIDIA_kernel-1.0-2960/nv-linux.h NVIDIA_kernel-1.0-2960-2.5.19/nv-linux.h
--- NVIDIA_kernel-1.0-2960/nv-linux.h	Tue May 14 17:26:16 2002
+++ NVIDIA_kernel-1.0-2960-2.5.19/nv-linux.h	Fri May 31 01:03:24 2002
@@ -38,7 +38,7 @@
 #elif LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
 #  define KERNEL_2_4
 #elif LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 0)
-#  error This driver does not support 2.5.x development kernels!
+//#  error This driver does not support 2.5.x development kernels!
 #  define KERNEL_2_5
 #else
 #  error This driver does not support 2.6.x or newer kernels!
diff -ur NVIDIA_kernel-1.0-2960/nv.c NVIDIA_kernel-1.0-2960-2.5.19/nv.c
--- NVIDIA_kernel-1.0-2960/nv.c	Tue May 14 17:26:16 2002
+++ NVIDIA_kernel-1.0-2960-2.5.19/nv.c	Fri May 31 01:15:03 2002
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
diff -ur NVIDIA_kernel-1.0-2960/os-interface.c NVIDIA_kernel-1.0-2960-2.5.19/os-interface.c
--- NVIDIA_kernel-1.0-2960/os-interface.c	Tue May 14 17:26:16 2002
+++ NVIDIA_kernel-1.0-2960-2.5.19/os-interface.c	Fri May 31 01:07:26 2002
@@ -1458,9 +1458,14 @@
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
@@ -1485,10 +1490,14 @@
 
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
@@ -2032,15 +2041,25 @@
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

--------------080807060602060507040900--

