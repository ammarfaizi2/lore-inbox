Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286339AbSA1Vge>; Mon, 28 Jan 2002 16:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286336AbSA1VgY>; Mon, 28 Jan 2002 16:36:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46347 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S286188AbSA1VgM>;
	Mon, 28 Jan 2002 16:36:12 -0500
Message-ID: <3C55C2AB.AE73A75D@zip.com.au>
Date: Mon, 28 Jan 2002 13:29:15 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH?] Crash in 2.4.17/ptrace
In-Reply-To: <20020128153210.A3032@nevyn.them.org> <3C55BC89.EDE3105C@zip.com.au>,
		<3C55BC89.EDE3105C@zip.com.au> <20020128161900.A9071@nevyn.them.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz wrote:
> 
> Frame buffers aren't reliable marked VM_IO when mapped, currently.  Ben
> H. said he was going to push a fix for this at least to the PPC trees
> today or tomorrow.

They are now, I hope.  I fixed that in 2.4.18-pre2.
 drivers/video/fbmem.c:fb_mmap() marks the vma as
VM_IO for all architectures.  But perhaps I missed some;
an audit is needed in there, which I'll do.

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

Well, get_user_pages is used by several parts of the kernel.
In the O_DIRECT/map_user_kiobuf case, we could end up asking
the disk controller to perform busmastering against the video
PCI device, which will probably explode somewhere down the chain.

Also, just because the hardware is mapped into the process
virtual address space, it's not necessarily all accessible.
It is possible to get a bus fault against part of the mapping.
And the kernel doesn't expect to get bus faults on the source
of copy_to_user, I think.

I'm sure Andrea will have a better notion than I.  Sometimes I
just fling out random patches to get people thinking about
things ;)

-
