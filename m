Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287359AbRL3Ihx>; Sun, 30 Dec 2001 03:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287360AbRL3Ihn>; Sun, 30 Dec 2001 03:37:43 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:58125 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287359AbRL3Ihi>; Sun, 30 Dec 2001 03:37:38 -0500
Message-ID: <3C2ED18D.FA550F1A@zip.com.au>
Date: Sun, 30 Dec 2001 00:34:21 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [patch] Re: Framebuffer, mmap(), hanging in D state, root FS unmount 
 failure.
In-Reply-To: <20011227195037.GA229@znex> <3C2D0D13.CB1C5683@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> However I don't see why _any_ architecture wants framebuffer contents
> to be included in core files.  It sounds risky.
> 
> So the setting of VM_IO could be simply hoisted outside the forest
> of ifdefs.  Comments, anyone?

Well nobody has objected....

The patch marks fbdev mappings as VM_IO for *all* architectures.

This prevents a kernel deadlock (mmap_sem) which occurs on x86 when a
program which has mmapped an fbdev tries to dump core.


--- linux-2.4.18-pre1/drivers/video/fbmem.c	Fri Dec 21 11:19:14 2001
+++ linux-akpm/drivers/video/fbmem.c	Sun Dec 30 00:23:15 2001
@@ -576,12 +576,13 @@ fb_mmap(struct file *file, struct vm_are
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
@@ -607,8 +608,6 @@ fb_mmap(struct file *file, struct vm_are
 	pgprot_val(vma->vm_page_prot) |= _CACHE_UNCACHED;
 #elif defined(__arm__)
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	/* This is an IO map - tell maydump to skip this VMA */
-	vma->vm_flags |= VM_IO;
 #elif defined(__sh__)
 	pgprot_val(vma->vm_page_prot) &= ~_PAGE_CACHABLE;
 #else


-
