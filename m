Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVA3Fqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVA3Fqn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 00:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVA3Fqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 00:46:43 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:15354 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261648AbVA3Fqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 00:46:34 -0500
Message-ID: <41FC74A1.2060500@biomail.ucsd.edu>
Date: Sat, 29 Jan 2005 21:46:09 -0800
From: John Gilbert <jgilbert@biomail.ucsd.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH, 2.6.11-rc2-RT] Proprietary ATI Radeon Drivers
Content-Type: multipart/mixed;
 boundary="------------050904050408030508000900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050904050408030508000900
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,

These patches allow ATI's Radeon drivers (8.8.25) to work under the 
realtime-preempt 2.6.11-rc2-v0.7.37-01 Linux kernels.

Be sure to configure tmpfs before using (see 
http://www.ati.com/support/infobase/4687.html).

OpenGL works very well. Quake 3, bzflag, gltron all run solidly and 
smoothly!
Exiting X Windows blanks screen until next reboot.
There are still some compile time warnings that should be fixed.
An OpenGL latency footprint / histogram and performance test suite 
should be developed.
The open code parts of ATI's drivers need to be picked through for 
spinlocks, and cleaned up if possible.
Lots of other work left to do, like a frame scheduler locked to page 
redraw interrupts, Xv support, a triple buffering API (next version of SDL?)

Please send me any improvements. Thanks.
John Gilbert
jgilbert@biomail.ucsd.edu

--------------050904050408030508000900
Content-Type: text/plain;
 name="patch.agpgart_be.c-04"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.agpgart_be.c-04"

--- agpgart_be.c.orig	2004-12-14 09:55:47.000000000 -0800
+++ agpgart_be.c	2005-01-24 17:09:15.000000000 -0800
@@ -117,6 +117,10 @@
 #include <linux/miscdevice.h>
 #include <linux/pm.h>
 
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,9)
+#define pci_find_class pci_get_class
+#endif
+
 #if (LINUX_VERSION_CODE >= 0x020400)
 #define FGL_PM_PRESENT
 #else
@@ -6469,6 +6473,7 @@
 
 // FGL - end
 
+#ifdef __x86_64__
 static int agp_check_supported_device(struct pci_dev *dev) 
 {
 
@@ -6483,13 +6488,16 @@
 
   return 0;
 }
+#endif
 
 /* Supported Device Scanning routine */
 
 static int __init agp_find_supported_device(void)
 {
 	struct pci_dev *dev = NULL;
+#ifdef __x86_64__
     u8 cap_ptr = 0x00;
+#endif
 
     // locate host bridge device
 #ifdef __x86_64__

--------------050904050408030508000900
Content-Type: text/plain;
 name="patch.firegl_public.c-04"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.firegl_public.c-04"

--- firegl_public.c.orig	2005-01-04 17:05:05.000000000 -0800
+++ firegl_public.c	2005-01-24 16:50:28.000000000 -0800
@@ -2590,13 +2590,13 @@
 #endif /* __ia64__ */
                 vma->vm_flags |= VM_IO; /* not in core dump */
             }
-            if (remap_page_range(FGL_VMA_API_PASS
+            if (remap_pfn_range(FGL_VMA_API_PASS
                                  vma->vm_start,
-                                 __ke_vm_offset(vma),
+                                 vma->vm_pgoff,
                                  vma->vm_end - vma->vm_start,
                                  vma->vm_page_prot))
             {
-                __KE_DEBUG("remap_page_range failed\n");
+                __KE_DEBUG("remap_pfn_range failed\n");
                 return -EAGAIN;
             }
             vma->vm_flags |= VM_SHM | VM_RESERVED; /* Don't swap */
@@ -2655,15 +2655,15 @@
 #else
 			//			else
 			{
-				if (__ke_vm_offset(vma) >= __pa(high_memory))
+				if (vma->vm_pgoff >= __pa(high_memory))
 					vma->vm_flags |= VM_IO; /* not in core dump */
-				if (remap_page_range(FGL_VMA_API_PASS
+				if (remap_pfn_range(FGL_VMA_API_PASS
 									 vma->vm_start,
-									 __ke_vm_offset(vma),
+									 vma->vm_pgoff,
 									 vma->vm_end - vma->vm_start,
 									 vma->vm_page_prot))
 				{
-					__KE_DEBUG("remap_page_range failed\n");
+					__KE_DEBUG("remap_pfn_range failed\n");
 					return -EAGAIN;
 				}
 #ifdef __x86_64__
@@ -2692,15 +2692,15 @@
 //			else
 #else
 			{
-				if (__ke_vm_offset(vma) >= __pa(high_memory))
+				if (vma->vm_pgoff >= __pa(high_memory))
 					vma->vm_flags |= VM_IO; /* not in core dump */
-				if (remap_page_range(FGL_VMA_API_PASS
+				if (remap_pfn_range(FGL_VMA_API_PASS
 									 vma->vm_start,
-									 __ke_vm_offset(vma),
+									 vma->vm_pgoff,
 									 vma->vm_end - vma->vm_start,
 									 vma->vm_page_prot))
 				{
-					__KE_DEBUG("remap_page_range failed\n");
+					__KE_DEBUG("remap_pfn_range failed\n");
 					return -EAGAIN;
 				}
 #ifdef __x86_64__
@@ -2744,6 +2744,20 @@
 
 #if LINUX_VERSION_CODE >= 0x020400
 
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,9)
+/* This is no longer used inside kernel, so declare it here. JGG */
+typedef struct {
+	void                    (*free_memory)(struct agp_memory *);
+	struct agp_memory *     (*allocate_memory)(size_t, u32);
+	int                     (*bind_memory)(struct agp_memory *, off_t);
+	int                     (*unbind_memory)(struct agp_memory *);
+	void                    (*enable)(u32);
+	int                     (*acquire)(void);
+	void                    (*release)(void);
+	int                     (*copy_info)(struct agp_kern_info *);
+} drm_agp_t;
+#endif
+
 static const drm_agp_t  *drm_agp_module_stub = NULL;
 
 #define AGP_FUNCTIONS		8

--------------050904050408030508000900--
