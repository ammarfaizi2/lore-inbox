Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287748AbSA1Xqr>; Mon, 28 Jan 2002 18:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287764AbSA1Xqi>; Mon, 28 Jan 2002 18:46:38 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:39760 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S287710AbSA1Xq2>; Mon, 28 Jan 2002 18:46:28 -0500
Date: Tue, 29 Jan 2002 00:47:41 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH?] Crash in 2.4.17/ptrace
Message-ID: <20020129004741.G1309@athlon.random>
In-Reply-To: <20020128153210.A3032@nevyn.them.org> <3C55BC89.EDE3105C@zip.com.au> <20020128161900.A9071@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20020128161900.A9071@nevyn.them.org>; from dan@debian.org on Mon, Jan 28, 2002 at 04:19:00PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2002 at 04:19:00PM -0500, Daniel Jacobowitz wrote:
> On Mon, Jan 28, 2002 at 01:03:05PM -0800, Andrew Morton wrote:
> > Oh nice.  And it seems that, say, an O_DIRECT write of, say,
> > a mmaped framebuffer will also oops the kernel.
> > 
> > Most callers of get_user_pages() aren't prepared for a
> > null page* in the returned array.
> > 
> > This patch *may* be sufficient, but perhaps get_user_pages()
> > should just bale out as soon as it finds an invalid page, rather
> > than sticking a null page * into the returned array and continuing.
> > 
> > --- linux-2.4.18-pre7/mm/memory.c	Fri Dec 21 11:19:23 2001
> > +++ linux-akpm/mm/memory.c	Mon Jan 28 12:54:40 2002
> > @@ -453,6 +453,7 @@ int get_user_pages(struct task_struct *t
> >  		vma = find_extend_vma(mm, start);
> >  
> >  		if ( !vma ||
> > +		     (vma->vm_flags & VM_IO) ||
> >  		    (!force &&
> >  		     	((write && (!(vma->vm_flags & VM_WRITE))) ||
> >  		    	 (!write && (!(vma->vm_flags & VM_READ))) ) )) {
> 
> Frame buffers aren't reliable marked VM_IO when mapped, currently.  Ben

For this reason (and also because there aren't only framebuffers mmapped
out there) I guess it's better to just add (yet another) flag to
get_user_pages, so that it fails with an error when it encounters a
page out of the mem_map array.

> H. said he was going to push a fix for this at least to the PPC trees
> today or tomorrow.
> 
> It's cute - fbmem.c goes out of its way to set the flag on some
> architectures and not others.  I can't imagine why.
> 
> But with that, yes, that should fix it.
> 
> > > Of course, I would much rather be able to see the contents of the
> > > framebuffer.  Any suggestions?
> > 
> > Not with this patch, I'm afraid.  For your testing purposes you
> > could just remove the VALID_PAGE() test in mm/memory.c:get_page_map(),
> > and then gdb should be able to get at the framebuffer.
> 
> I'm sure there's a good reason to not do that in general.  Mind
> enlightening me?
> 
> -- 
> Daniel Jacobowitz                           Carnegie Mellon University
> MontaVista Software                         Debian GNU/Linux Developer


Andrea
