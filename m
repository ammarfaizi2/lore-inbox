Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287769AbSA1Xx5>; Mon, 28 Jan 2002 18:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287710AbSA1Xxs>; Mon, 28 Jan 2002 18:53:48 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:5714 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S287769AbSA1Xxj>; Mon, 28 Jan 2002 18:53:39 -0500
Date: Tue, 29 Jan 2002 00:54:51 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Daniel Jacobowitz <dan@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH?] Crash in 2.4.17/ptrace
Message-ID: <20020129005451.H1309@athlon.random>
In-Reply-To: <20020128153210.A3032@nevyn.them.org> <3C55BC89.EDE3105C@zip.com.au>, <3C55BC89.EDE3105C@zip.com.au> <20020128161900.A9071@nevyn.them.org> <3C55C2AB.AE73A75D@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C55C2AB.AE73A75D@zip.com.au>; from akpm@zip.com.au on Mon, Jan 28, 2002 at 01:29:15PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2002 at 01:29:15PM -0800, Andrew Morton wrote:
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
> 
> > It's cute - fbmem.c goes out of its way to set the flag on some
> > architectures and not others.  I can't imagine why.
> > 
> > But with that, yes, that should fix it.
> > 
> > > > Of course, I would much rather be able to see the contents of the
> > > > framebuffer.  Any suggestions?
> > >
> > > Not with this patch, I'm afraid.  For your testing purposes you
> > > could just remove the VALID_PAGE() test in mm/memory.c:get_page_map(),
> > > and then gdb should be able to get at the framebuffer.
> > 
> > I'm sure there's a good reason to not do that in general.  Mind
> > enlightening me?
> 
> Well, get_user_pages is used by several parts of the kernel.
> In the O_DIRECT/map_user_kiobuf case, we could end up asking
> the disk controller to perform busmastering against the video
> PCI device, which will probably explode somewhere down the chain.
> 
> Also, just because the hardware is mapped into the process
> virtual address space, it's not necessarily all accessible.
> It is possible to get a bus fault against part of the mapping.
> And the kernel doesn't expect to get bus faults on the source
> of copy_to_user, I think.

another basic problem about allowing map_user_kiobuf to succeed on
invalid pages, is that calling PageReserved/SetPageDirty on a null
pointer will crash, etc...

> 
> I'm sure Andrea will have a better notion than I.  Sometimes I
> just fling out random patches to get people thinking about
> things ;)

Well, I think your earlier suggestion to bale out with an error if an
invalid page is found sounds like the cleaner fix (possibly in function
of yet another bitflag, so if somebody wants to get the nearby pages
regardless of an invalid pages somewhere, it can).

Andrea
