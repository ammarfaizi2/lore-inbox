Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285006AbRL2A1N>; Fri, 28 Dec 2001 19:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284931AbRL2A1D>; Fri, 28 Dec 2001 19:27:03 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:54795 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S285006AbRL2A0r>; Fri, 28 Dec 2001 19:26:47 -0500
Message-ID: <3C2D0D13.CB1C5683@zip.com.au>
Date: Fri, 28 Dec 2001 16:23:47 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark J Roberts <mjr@znex.org>
CC: linux-kernel@vger.kernel.org,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Framebuffer, mmap(), hanging in D state, root FS unmount failure.
In-Reply-To: <20011227195037.GA229@znex>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark J Roberts wrote:
> 
> #include <assert.h>
> #include <sys/mman.h>
> #include <fcntl.h>
> int main(void)
> {
>         char *p;
>         assert((p = mmap(0, 1, PROT_READ|PROT_WRITE, MAP_SHARED, open("/dev/fb/0", O_RDWR), 0)) != MAP_FAILED);
>         p[4096] = 0; /* this hangs */
>         return 0;
> }
> 
> When I run this on my 2.4.17rc2aa2 kernel with a Voodoo3000
> framebuffer, the process hangs forever in D state. ps and top will
> then hang the same way when they read the /proc/pid files for the
> hung process. And my root filesystem won't unmount.
> 

OK, the framebuffer driver is failing to mark the mmapped vma as
VM_IO, so the kernel is trying to dump the framebuffer device
to the core file, takes a recursive fault and deadlocks.

Simplest possible fix is to mark the framebuffer as not dumpable
for x86.

--- linux-2.4.18-pre1/drivers/video/fbmem.c	Fri Dec 21 11:19:14 2001
+++ linux-akpm/drivers/video/fbmem.c	Fri Dec 28 16:18:05 2001
@@ -600,6 +600,7 @@ fb_mmap(struct file *file, struct vm_are
 #elif defined(__alpha__)
 	/* Caching is off in the I/O space quadrant by design.  */
 #elif defined(__i386__) || defined(__x86_64__)
+	vma->vm_flags |= VM_IO;
 	if (boot_cpu_data.x86 > 3)
 		pgprot_val(vma->vm_page_prot) |= _PAGE_PCD;
 #elif defined(__mips__)


However I don't see why _any_ architecture wants framebuffer contents
to be included in core files.  It sounds risky.

So the setting of VM_IO could be simply hoisted outside the forest
of ifdefs.  Comments, anyone?

-
