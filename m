Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286959AbSA1WUQ>; Mon, 28 Jan 2002 17:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287189AbSA1WUH>; Mon, 28 Jan 2002 17:20:07 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15377 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287177AbSA1WTr>;
	Mon, 28 Jan 2002 17:19:47 -0500
Message-ID: <3C55CCE0.30189523@zip.com.au>
Date: Mon, 28 Jan 2002 14:12:48 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <andrea@suse.de>,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH?] Crash in 2.4.17/ptrace
In-Reply-To: <20020128153210.A3032@nevyn.them.org> <3C55BC89.EDE3105C@zip.com.au>,
			<3C55BC89.EDE3105C@zip.com.au> <20020128161900.A9071@nevyn.them.org> <3C55C2AB.AE73A75D@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Daniel Jacobowitz wrote:
> >
> > Frame buffers aren't reliable marked VM_IO when mapped, currently.  Ben
> > H. said he was going to push a fix for this at least to the PPC trees
> > today or tomorrow.
> 
> They are now, I hope.  I fixed that in 2.4.18-pre2.
>  drivers/video/fbmem.c:fb_mmap() marks the vma as
> VM_IO for all architectures.  But perhaps I missed some;
> an audit is needed in there, which I'll do.

I lied.  Linus applied it, but not, it seems, Marcelo.

So.  Here's a patch.

It marks all framebuffer mappings as VM_IO.  This prevents
kernel deadlocks which can occur when a program which
has a framebuffer mapping attempts to dump core.

It also allows get_user_pages() to detect and skip these
IO mappings, so ptrace, O_DIRECT, etc will not permit
I/O against these mappings.

I've Cc'ed linux-fbdev-devel.  Could someone please
review?



--- linux-2.4.18-pre7/drivers/video/acornfb.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/drivers/video/acornfb.c	Mon Jan 28 14:00:21 2002
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
+++ linux-akpm/drivers/video/igafb.c	Mon Jan 28 14:02:10 2002
@@ -293,8 +293,6 @@ static int igafb_mmap(struct fb_info *in
 	if (!map_size)
 		return -EINVAL;
 
-	vma->vm_flags |= VM_IO;
-
 	if (!fb->mmaped) {
 		int lastconsole = 0;
 
--- linux-2.4.18-pre7/drivers/video/sgivwfb.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/drivers/video/sgivwfb.c	Mon Jan 28 14:02:49 2002
@@ -846,7 +846,6 @@ static int sgivwfb_mmap(struct fb_info *
     return -EINVAL;
   offset += sgivwfb_mem_phys;
   pgprot_val(vma->vm_page_prot) = pgprot_val(vma->vm_page_prot) | _PAGE_PCD;
-  vma->vm_flags |= VM_IO;
   if (remap_page_range(vma->vm_start, offset, size, vma->vm_page_prot))
     return -EAGAIN;
   vma->vm_file = file;
--- linux-2.4.18-pre7/drivers/video/fbmem.c	Fri Dec 21 11:19:14 2001
+++ linux-akpm/drivers/video/fbmem.c	Mon Jan 28 14:07:08 2002
@@ -543,6 +543,8 @@ fb_mmap(struct file *file, struct vm_are
 		lock_kernel();
 		res = fb->fb_mmap(info, file, vma);
 		unlock_kernel();
+		/* This is an IO map - tell maydump to skip this VMA */
+		vma->vm_flags |= VM_IO;
 		return res;
 	}
 
@@ -576,12 +578,13 @@ fb_mmap(struct file *file, struct vm_are
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
@@ -607,8 +610,6 @@ fb_mmap(struct file *file, struct vm_are
 	pgprot_val(vma->vm_page_prot) |= _CACHE_UNCACHED;
 #elif defined(__arm__)
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	/* This is an IO map - tell maydump to skip this VMA */
-	vma->vm_flags |= VM_IO;
 #elif defined(__sh__)
 	pgprot_val(vma->vm_page_prot) &= ~_PAGE_CACHABLE;
 #else
