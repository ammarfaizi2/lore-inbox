Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286750AbSA2XMq>; Tue, 29 Jan 2002 18:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286207AbSA2XLC>; Tue, 29 Jan 2002 18:11:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17414 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S285692AbSA2XKD>;
	Tue, 29 Jan 2002 18:10:03 -0500
Message-ID: <3C572A20.F55DED87@zip.com.au>
Date: Tue, 29 Jan 2002 15:02:56 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: James Simmons <jsimmons@transvirtual.com>
CC: Daniel Jacobowitz <dan@debian.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <andrea@suse.de>,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH?] Crash in 2.4.17/ptrace
In-Reply-To: <3C55CCE0.30189523@zip.com.au> <Pine.LNX.4.10.10201291453250.29648-100000@www.transvirtual.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
> 
> > It marks all framebuffer mappings as VM_IO.  This prevents
> > kernel deadlocks which can occur when a program which
> > has a framebuffer mapping attempts to dump core.
> 
> Good this is needed.
> 
> > I've Cc'ed linux-fbdev-devel.  Could someone please
> > review?
> 
> > --- linux-2.4.18-pre7/drivers/video/acornfb.c Thu Nov 22 23:02:58 2001
> 
> You missed the atyfb driver. Other then that it looks fine. Geert what do
> you think?

Ah, thanks.  Also I missed sbusfb.c (not that it was fatal - the driver
got it right anyway).

Here's the current patch.  After some discussion with Ben
Herrenschmidt, it now sets VM_IO against the vma *before*
calling the subdriver's mmap method, just in case the
driver really does want to clear that flag (presumably, a shadow
buffer in main memory).



--- linux-2.4.18-pre7/drivers/video/acornfb.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/drivers/video/acornfb.c	Tue Jan 29 14:57:00 2002
@@ -1139,9 +1139,6 @@ acornfb_mmap(struct fb_info *info, struc
 	off += start;
 	vma->vm_pgoff = off >> PAGE_SHIFT;
 
-	/* This is an IO map - tell maydump to skip this VMA */
-	vma->vm_flags |= VM_IO;
-
 #ifdef CONFIG_CPU_32
 	pgprot_val(vma->vm_page_prot) &= ~L_PTE_CACHEABLE;
 #endif
--- linux-2.4.18-pre7/drivers/video/igafb.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/drivers/video/igafb.c	Tue Jan 29 14:57:00 2002
@@ -293,8 +293,6 @@ static int igafb_mmap(struct fb_info *in
 	if (!map_size)
 		return -EINVAL;
 
-	vma->vm_flags |= VM_IO;
-
 	if (!fb->mmaped) {
 		int lastconsole = 0;
 
--- linux-2.4.18-pre7/drivers/video/sgivwfb.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/drivers/video/sgivwfb.c	Tue Jan 29 14:57:00 2002
@@ -846,7 +846,6 @@ static int sgivwfb_mmap(struct fb_info *
     return -EINVAL;
   offset += sgivwfb_mem_phys;
   pgprot_val(vma->vm_page_prot) = pgprot_val(vma->vm_page_prot) | _PAGE_PCD;
-  vma->vm_flags |= VM_IO;
   if (remap_page_range(vma->vm_start, offset, size, vma->vm_page_prot))
     return -EAGAIN;
   vma->vm_file = file;
--- linux-2.4.18-pre7/drivers/video/fbmem.c	Fri Dec 21 11:19:14 2001
+++ linux-akpm/drivers/video/fbmem.c	Tue Jan 29 14:57:00 2002
@@ -541,6 +541,16 @@ fb_mmap(struct file *file, struct vm_are
 	if (fb->fb_mmap) {
 		int res;
 		lock_kernel();
+		/*
+		 * This is an IO map - tell maydump to skip this VMA.
+		 * If, for some reason, the sub-driver wishes to allow the
+		 * mapping to be dumpable and accessible via ptrace then
+		 * it may clear VM_IO later.
+		 * (This only makes sense if the buffer is actually
+		 * in main memory, and is described by a page struct in
+		 * mem_map[])
+		 */
+		vma->vm_flags |= VM_IO;
 		res = fb->fb_mmap(info, file, vma);
 		unlock_kernel();
 		return res;
@@ -576,12 +586,13 @@ fb_mmap(struct file *file, struct vm_are
 		return -EINVAL;
 	off += start;
 	vma->vm_pgoff = off >> PAGE_SHIFT;
+	/* This is an IO map - tell maydump to skip this VMA */
+	vma->vm_flags |= VM_IO;
 #if defined(__sparc_v9__)
 	vma->vm_flags |= (VM_SHM | VM_LOCKED);
 	if (io_remap_page_range(vma->vm_start, off,
 				vma->vm_end - vma->vm_start, vma->vm_page_prot, 0))
 		return -EAGAIN;
-	vma->vm_flags |= VM_IO;
 #else
 #if defined(__mc68000__)
 #if defined(CONFIG_SUN3)
@@ -607,8 +618,6 @@ fb_mmap(struct file *file, struct vm_are
 	pgprot_val(vma->vm_page_prot) |= _CACHE_UNCACHED;
 #elif defined(__arm__)
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	/* This is an IO map - tell maydump to skip this VMA */
-	vma->vm_flags |= VM_IO;
 #elif defined(__sh__)
 	pgprot_val(vma->vm_page_prot) &= ~_PAGE_CACHABLE;
 #else
--- linux-2.4.18-pre7/drivers/video/sbusfb.c	Thu Sep 13 16:04:43 2001
+++ linux-akpm/drivers/video/sbusfb.c	Tue Jan 29 14:58:59 2002
@@ -220,7 +220,6 @@ static int sbusfb_mmap(struct fb_info *i
 		page += map_size;
 	}
 	
-	vma->vm_flags |= VM_IO;
 	if (!fb->mmaped) {
 		int lastconsole = 0;
 		
--- linux-2.4.18-pre7/drivers/video/aty/atyfb_base.c	Wed Jan 23 15:11:34 2002
+++ linux-akpm/drivers/video/aty/atyfb_base.c	Tue Jan 29 14:56:46 2002
@@ -1426,8 +1426,6 @@ static int atyfb_mmap(struct fb_info *in
 	if (!map_size)
 		return -EINVAL;
 
-	vma->vm_flags |= VM_IO;
-
 	if (!fb->mmaped) {
 		int lastconsole = 0;
