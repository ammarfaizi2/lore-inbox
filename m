Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262997AbVCQErk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262997AbVCQErk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 23:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVCQErk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 23:47:40 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:48041 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S262997AbVCQErQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 23:47:16 -0500
Date: Wed, 16 Mar 2005 20:47:08 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Subject: [PATCH/RFC] io_remap_pfn_range: convert io_remap_page_range callers
To: linux-mm@kvack.org
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <20050316204708.5adfeebc.randy.dunlap@verizon.net>
Organization: YPO4
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Follow-up to
http://marc.theaimsgroup.com/?l=linux-mm&m=111049473410099&w=2
(which has a minor correction, full patch available at:
http://developer.osdl.org/rddunlap/patches/ioremap_pfn_v6.patch)

Built on 9 arches with OSDL PLM.


io_remap_pfn_range() phase 2:
  convert all callers of io_remap_page_range() to io_remap_pfn_range();
  add io_remap_page_range() to feature-removal-schedule.txt;

 Documentation/feature-removal-schedule.txt |    9 +++++++++
 arch/sh/kernel/cpu/sh4/sq.c                |    2 +-
 drivers/video/acornfb.c                    |    2 +-
 drivers/video/au1100fb.c                   |    2 +-
 drivers/video/controlfb.c                  |    2 +-
 drivers/video/sa1100fb.c                   |    2 +-
 sound/core/pcm_native.c                    |    4 ++--
 7 files changed, 16 insertions(+), 7 deletions(-)

diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk10-remap1/arch/sh/kernel/cpu/sh4/sq.c linux-2611-bk10-remap2/arch/sh/kernel/cpu/sh4/sq.c
--- linux-2611-bk10-remap1/arch/sh/kernel/cpu/sh4/sq.c	2005-03-01 23:38:07.000000000 -0800
+++ linux-2611-bk10-remap2/arch/sh/kernel/cpu/sh4/sq.c	2005-03-16 09:46:10.000000000 -0800
@@ -379,7 +379,7 @@ static int sq_mmap(struct file *file, st
 
 	map = __sq_alloc_mapping(vma->vm_start, offset, size, "Userspace");
 
-	if (io_remap_page_range(vma, map->sq_addr, map->addr,
+	if (io_remap_pfn_range(vma, map->sq_addr, map->addr >> PAGE_SHIFT,
 				size, vma->vm_page_prot))
 		return -EAGAIN;
 
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk10-remap1/Documentation/feature-removal-schedule.txt linux-2611-bk10-remap2/Documentation/feature-removal-schedule.txt
--- linux-2611-bk10-remap1/Documentation/feature-removal-schedule.txt	2005-03-16 09:16:26.000000000 -0800
+++ linux-2611-bk10-remap2/Documentation/feature-removal-schedule.txt	2005-03-16 10:01:18.000000000 -0800
@@ -31,9 +31,18 @@ Why:	/proc/sys/cpu/* has been deprecated
 	Both interfaces are superseded by the cpufreq interface in
 	/sys/devices/system/cpu/cpu%n/cpufreq/.
 Who:	Dominik Brodowski <linux@brodo.de>
+---------------------------
 
 What:	ACPI S4bios support
 When:	May 2005
 Why:	Noone uses it, and it probably does not work, anyway. swsusp is
 	faster, more reliable, and people are actually using it.
 Who:	Pavel Machek <pavel@suse.cz>
+---------------------------
+
+What:	io_remap_page_range() (macro or function)
+When:	September 2005
+Why:	Replaced by io_remap_pfn_range() which allows more memory space
+	addressabilty (by using a pfn) and supports sparc & sparc64
+	iospace as part of the pfn.
+Who:	Randy Dunlap <rddunlap@osdl.org>
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk10-remap1/drivers/video/acornfb.c linux-2611-bk10-remap2/drivers/video/acornfb.c
--- linux-2611-bk10-remap1/drivers/video/acornfb.c	2005-03-01 23:38:26.000000000 -0800
+++ linux-2611-bk10-remap2/drivers/video/acornfb.c	2005-03-16 09:38:24.000000000 -0800
@@ -909,7 +909,7 @@ acornfb_mmap(struct fb_info *info, struc
 	 * some updates to the screen occasionally, but process switches
 	 * should cause the caches and buffers to be flushed often enough.
 	 */
-	if (io_remap_page_range(vma, vma->vm_start, off,
+	if (io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
 				vma->vm_end - vma->vm_start,
 				vma->vm_page_prot))
 		return -EAGAIN;
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk10-remap1/drivers/video/au1100fb.c linux-2611-bk10-remap2/drivers/video/au1100fb.c
--- linux-2611-bk10-remap1/drivers/video/au1100fb.c	2005-03-01 23:37:48.000000000 -0800
+++ linux-2611-bk10-remap2/drivers/video/au1100fb.c	2005-03-16 09:33:56.000000000 -0800
@@ -408,7 +408,7 @@ au1100fb_mmap(struct fb_info *_fb,
 	/* This is an IO map - tell maydump to skip this VMA */
 	vma->vm_flags |= VM_IO;
 
-	if (io_remap_page_range(vma, vma->vm_start, off,
+	if (io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
 				vma->vm_end - vma->vm_start,
 				vma->vm_page_prot)) {
 		return -EAGAIN;
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk10-remap1/drivers/video/controlfb.c linux-2611-bk10-remap2/drivers/video/controlfb.c
--- linux-2611-bk10-remap1/drivers/video/controlfb.c	2005-03-01 23:37:50.000000000 -0800
+++ linux-2611-bk10-remap2/drivers/video/controlfb.c	2005-03-16 09:37:11.000000000 -0800
@@ -315,7 +315,7 @@ static int controlfb_mmap(struct fb_info
        		return -EINVAL;
        off += start;
        vma->vm_pgoff = off >> PAGE_SHIFT;
-       if (io_remap_page_range(vma, vma->vm_start, off,
+       if (io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
            vma->vm_end - vma->vm_start, vma->vm_page_prot))
                return -EAGAIN;
 
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk10-remap1/drivers/video/sa1100fb.c linux-2611-bk10-remap2/drivers/video/sa1100fb.c
--- linux-2611-bk10-remap1/drivers/video/sa1100fb.c	2005-03-01 23:37:50.000000000 -0800
+++ linux-2611-bk10-remap2/drivers/video/sa1100fb.c	2005-03-16 09:37:53.000000000 -0800
@@ -836,7 +836,7 @@ static int sa1100fb_mmap(struct fb_info 
 	vma->vm_pgoff = off >> PAGE_SHIFT;
 	vma->vm_flags |= VM_IO;
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	return io_remap_page_range(vma, vma->vm_start, off,
+	return io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
 				   vma->vm_end - vma->vm_start,
 				   vma->vm_page_prot);
 }
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2611-bk10-remap1/sound/core/pcm_native.c linux-2611-bk10-remap2/sound/core/pcm_native.c
--- linux-2611-bk10-remap1/sound/core/pcm_native.c	2005-03-16 09:17:08.000000000 -0800
+++ linux-2611-bk10-remap2/sound/core/pcm_native.c	2005-03-16 09:39:41.000000000 -0800
@@ -3097,8 +3097,8 @@ int snd_pcm_lib_mmap_iomem(snd_pcm_subst
 	area->vm_flags |= VM_IO;
 	size = area->vm_end - area->vm_start;
 	offset = area->vm_pgoff << PAGE_SHIFT;
-	if (io_remap_page_range(area, area->vm_start,
-				substream->runtime->dma_addr + offset,
+	if (io_remap_pfn_range(area, area->vm_start,
+				(substream->runtime->dma_addr + offset) >> PAGE_SHIFT,
 				size, area->vm_page_prot))
 		return -EAGAIN;
 	atomic_inc(&substream->runtime->mmap_count);


---
