Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262433AbSI2JnK>; Sun, 29 Sep 2002 05:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262434AbSI2JnK>; Sun, 29 Sep 2002 05:43:10 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:4337 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S262433AbSI2JnE>; Sun, 29 Sep 2002 05:43:04 -0400
Message-ID: <3D96CC7B.7060801@drugphish.ch>
Date: Sun, 29 Sep 2002 11:48:43 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sipos Ferenc <sferi@mail.tvnet.hu>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: offtopic: patch for nvidia drivers
References: <1033291640.1535.3.camel@zeus.city.tvnet.hu>
Content-Type: multipart/mixed;
 boundary="------------010802030008010403060309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010802030008010403060309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

> Could anybody send me a nvidia 3123 driver patch for 2.5.39? I would
> like to test the kernel. Thx.

IMHO this is a bad idea. Testing a kernel with a broken module. You 
won't get any support if it breaks so you might get the wrong impression 
from the 2.5.x kernel. If you want to test the newest kernels with a 
NVidia card, use the nv driver provided by the XFree86 tree.

But attached is, upon your request a patch that should work. I do not 
take any responsability for it. It was the last 2.5.x kernel I could 
boot because after that it seriously destroyed my partition scheme and 
part of my data by either an off-by-one error or some piix.c changes 
that were not optimal.

Regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

--------------010802030008010403060309
Content-Type: text/plain;
 name="patch.nvidia_3123-2.5.35-bk3-ratz-1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.nvidia_3123-2.5.35-bk3-ratz-1.diff"

diff -ur NVIDIA_kernel-1.0-3123/nv-linux.h NVIDIA_kernel-1.0-3123-2.5.35/nv-linux.h
--- NVIDIA_kernel-1.0-3123/nv-linux.h	Wed Aug 28 01:36:53 2002
+++ NVIDIA_kernel-1.0-3123-2.5.35/nv-linux.h	Tue Sep 17 23:26:14 2002
@@ -36,11 +36,6 @@
 #  error This driver does not support 2.3.x development kernels!
 #elif LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
 #  define KERNEL_2_4
-#elif LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 0)
-#  error This driver does not support 2.5.x development kernels!
-#  define KERNEL_2_5
-#else
-#  error This driver does not support 2.6.x or newer kernels!
 #endif
 
 #if defined (CONFIG_SMP) && !defined (__SMP__)
diff -ur NVIDIA_kernel-1.0-3123/nv.c NVIDIA_kernel-1.0-3123-2.5.35/nv.c
--- NVIDIA_kernel-1.0-3123/nv.c	Wed Aug 28 01:36:52 2002
+++ NVIDIA_kernel-1.0-3123-2.5.35/nv.c	Tue Sep 17 23:26:14 2002
@@ -1068,11 +1068,22 @@
 
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
@@ -1178,9 +1189,14 @@
 
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
 
     rm_free_unused_clients(nv, current->pid, (void *) file);
@@ -1299,11 +1315,21 @@
 #if defined(NVCPU_IA64)
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
@@ -1316,11 +1342,20 @@
 #if defined(NVCPU_IA64)
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
@@ -1350,8 +1385,13 @@
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
@@ -2179,7 +2219,11 @@
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
diff -ur NVIDIA_kernel-1.0-3123/os-interface.c NVIDIA_kernel-1.0-3123-2.5.35/os-interface.c
--- NVIDIA_kernel-1.0-3123/os-interface.c	Wed Aug 28 01:36:52 2002
+++ NVIDIA_kernel-1.0-3123-2.5.35/os-interface.c	Tue Sep 17 23:29:31 2002
@@ -27,7 +27,10 @@
 
 BOOL os_is_administrator(PHWINFO pDev)
 {
-    return suser();
+    /* Actually suser() wasn't really a bool, but since the
+       nvidia guys want it as a bool, let's give them a bool.
+    */
+    return (!capable(CAP_SYS_ADMIN)?1:0);
 }
 
 U032 os_get_page_size(VOID)
@@ -1141,9 +1144,14 @@
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
@@ -1176,10 +1184,14 @@
 
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
@@ -1593,7 +1605,8 @@
 
     agp_addr = agpinfo.aper_base + (agp_data->offset << PAGE_SHIFT);
 
-    err = remap_page_range(vma->vm_start, (size_t) agp_addr, 
+    err = remap_page_range(vma,
+			   vma->vm_start, (size_t) agp_addr, 
                            agp_data->num_pages << PAGE_SHIFT,
 #if defined(NVCPU_IA64)
                            vma->vm_page_prot);

--------------010802030008010403060309--

