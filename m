Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284305AbSA1VKW>; Mon, 28 Jan 2002 16:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285369AbSA1VKN>; Mon, 28 Jan 2002 16:10:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33291 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S284305AbSA1VKC>;
	Mon, 28 Jan 2002 16:10:02 -0500
Message-ID: <3C55BC89.EDE3105C@zip.com.au>
Date: Mon, 28 Jan 2002 13:03:05 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH?] Crash in 2.4.17/ptrace
In-Reply-To: <20020128153210.A3032@nevyn.them.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz wrote:
> 
> I've been debugging frame buffer graphics lately, and encountering a
> very annoying problem.  If the debugee has /dev/fb/0 mapped, and I try
> to print out the contents of a pointer into that buffer, GDB crashes in
> kernel/ptrace.c:access_process_vm.  The problem seems to be that
> get_user_pages returns a NULL page.  Something as simple as this
> prevents the crash:
> 
> --- 2.4.18-pre7/2.4.18-pre7/kernel/ptrace.c     Fri Dec 21 12:42:04 2001
> +++ 2.4.17/kernel-source-2.4.17/kernel/ptrace.c Mon Jan 28 15:30:39 2002
> @@ -160,6 +160,18 @@ int access_process_vm(struct task_struct
> 
>                 flush_cache_page(vma, addr);
> 
> +#if 1
> +               if (!page)
> +               {
> +                       /* FIXME: Writes? */
> +                       if (!write) memset (buf, 0, bytes);
> +                       len -= bytes;
> +                       buf += bytes;
> +                       continue;
> +               }
> +#endif
> +
> +
>                 maddr = kmap(page);
>                 if (write) {
>                         memcpy(maddr + offset, buf, bytes);

Oh nice.  And it seems that, say, an O_DIRECT write of, say,
a mmaped framebuffer will also oops the kernel.

Most callers of get_user_pages() aren't prepared for a
null page* in the returned array.

This patch *may* be sufficient, but perhaps get_user_pages()
should just bale out as soon as it finds an invalid page, rather
than sticking a null page * into the returned array and continuing.

--- linux-2.4.18-pre7/mm/memory.c	Fri Dec 21 11:19:23 2001
+++ linux-akpm/mm/memory.c	Mon Jan 28 12:54:40 2002
@@ -453,6 +453,7 @@ int get_user_pages(struct task_struct *t
 		vma = find_extend_vma(mm, start);
 
 		if ( !vma ||
+		     (vma->vm_flags & VM_IO) ||
 		    (!force &&
 		     	((write && (!(vma->vm_flags & VM_WRITE))) ||
 		    	 (!write && (!(vma->vm_flags & VM_READ))) ) )) {

> Of course, I would much rather be able to see the contents of the
> framebuffer.  Any suggestions?

Not with this patch, I'm afraid.  For your testing purposes you
could just remove the VALID_PAGE() test in mm/memory.c:get_page_map(),
and then gdb should be able to get at the framebuffer.

-
