Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbVAYEuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVAYEuA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 23:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbVAYEt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 23:49:59 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:46520 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261816AbVAYErj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 23:47:39 -0500
Message-ID: <41F5CF5D.4060807@biomail.ucsd.edu>
Date: Mon, 24 Jan 2005 20:47:25 -0800
From: John Gilbert <jgilbert@biomail.ucsd.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ATI drivers working under realtime-preempt linux
Content-Type: multipart/mixed;
 boundary="------------090909040104040406000609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090909040104040406000609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,
Here are two patches that are needed to get this working. It's not 
perfect, but quake3 runs, bzflag runs, noof runs, and that's a start.
So here's the recipe...

Linux-2.6.10 source
the linux-2.6.11-rc2 patch
the realtime-preempt-2.6.11-rc2-V0.7.36-03 patch
the fglrx_6_8_0-8.8.25-1.i386.rpm proprietary drivers
the two included patches.
xorg 6.8.x and some hardware (Radeon 8500+)

install the kernel source with the rc2 and realtime-preempt patches. Mix 
in some configuration options CONFIG_MODULES=y, CONFIG_MODULE_UNLOAD=y,  
CONFIG_KMOD=y, CONFIG_MTRR=y, #CONFIG_FB= is not set, CONFIG_DRM=y, 
CONFIG_TMPFS=y, plus whatever else runs your system.
Build kernel, fix lilo/grub,  add the line "tmpfs /dev/shm tmpfs 
defaults 0 0" to the fstab
and reboot.

If you have an older ATI rpm installed, remove it.
Install the new ATI drivers. I used "rpm -i --nodeps fglrx...". 
Slackware doesn't use RPMs so dependency tables are useless.
It will install all the files, but will fail.
cd to  /lib/modules/fglrx/build_mod and patch the two files. "sh 
make.sh", "cd .."
"sh make_install.sh", "depmod -e", "modprobe fglrx"
if this works, the kernel module is done.

Run fglrxconfig, answer the questions, and it will create a broken 
XF86Config-4 file for you (if you are running 6.8.1). in /etc/X11 create 
a symbolic link to XF86Config-4 called xorg.conf, and change the line ' 
Driver "Keyboard" ' , to 'Driver "kbd" '.
Keep fingers crossed, run startx.

#### Bugs and Rants Follow ####
Seems to have a problem exiting, leaves video blank.
There's still some compile time warnings.
I suspect that if you ran a 32 bit kernel with AMD-8150 hardware, you 
would see some things blow up (see line 3788 of agpgart_be.c).

Xv isn't supported. DRI isn't supported.
ATI (and NVIDIA) should be all over the hard-realtime kernel, as this 
has the potential of making video and games frame accurate (never 
missing frames, no page tears).
The documentation from Linux user's web pages are better than ATI's.

Making this work should have been someone at ATI's job, not mine. I'm 
working blind here.

To anyone playing with this, good luck. It would be good to have real 
kernel developers look at what I've probably messed up trying to get 
this working. If you can fix some more warnings or some bugs, please let 
me know ;^)

ATI: please work with and support the realtime-preempt developers, 
there's lots of things Linux will be able to do shortly that only 
expensive Silicon Graphics systems could do before (and not open source).
Be a help, not a hindrance. Open up more code. Help make Linux the 
uber-media/games OS.

Thanks, Hope this helps.

John Gilbert
jgilbert@biomail.ucsd.edu

--------------090909040104040406000609
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

--------------090909040104040406000609
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

--------------090909040104040406000609--
