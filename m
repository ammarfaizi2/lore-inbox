Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285482AbSA1VTc>; Mon, 28 Jan 2002 16:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285828AbSA1VTX>; Mon, 28 Jan 2002 16:19:23 -0500
Received: from NEVYN.RES.CMU.EDU ([128.2.145.6]:11650 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id <S285482AbSA1VTM>;
	Mon, 28 Jan 2002 16:19:12 -0500
Date: Mon, 28 Jan 2002 16:19:00 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH?] Crash in 2.4.17/ptrace
Message-ID: <20020128161900.A9071@nevyn.them.org>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <20020128153210.A3032@nevyn.them.org> <3C55BC89.EDE3105C@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C55BC89.EDE3105C@zip.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2002 at 01:03:05PM -0800, Andrew Morton wrote:
> Oh nice.  And it seems that, say, an O_DIRECT write of, say,
> a mmaped framebuffer will also oops the kernel.
> 
> Most callers of get_user_pages() aren't prepared for a
> null page* in the returned array.
> 
> This patch *may* be sufficient, but perhaps get_user_pages()
> should just bale out as soon as it finds an invalid page, rather
> than sticking a null page * into the returned array and continuing.
> 
> --- linux-2.4.18-pre7/mm/memory.c	Fri Dec 21 11:19:23 2001
> +++ linux-akpm/mm/memory.c	Mon Jan 28 12:54:40 2002
> @@ -453,6 +453,7 @@ int get_user_pages(struct task_struct *t
>  		vma = find_extend_vma(mm, start);
>  
>  		if ( !vma ||
> +		     (vma->vm_flags & VM_IO) ||
>  		    (!force &&
>  		     	((write && (!(vma->vm_flags & VM_WRITE))) ||
>  		    	 (!write && (!(vma->vm_flags & VM_READ))) ) )) {

Frame buffers aren't reliable marked VM_IO when mapped, currently.  Ben
H. said he was going to push a fix for this at least to the PPC trees
today or tomorrow.

It's cute - fbmem.c goes out of its way to set the flag on some
architectures and not others.  I can't imagine why.

But with that, yes, that should fix it.

> > Of course, I would much rather be able to see the contents of the
> > framebuffer.  Any suggestions?
> 
> Not with this patch, I'm afraid.  For your testing purposes you
> could just remove the VALID_PAGE() test in mm/memory.c:get_page_map(),
> and then gdb should be able to get at the framebuffer.

I'm sure there's a good reason to not do that in general.  Mind
enlightening me?

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
