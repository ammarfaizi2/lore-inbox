Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261916AbSJEAjG>; Fri, 4 Oct 2002 20:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261914AbSJEAjG>; Fri, 4 Oct 2002 20:39:06 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:25735 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261916AbSJEAjE>;
	Fri, 4 Oct 2002 20:39:04 -0400
Date: Fri, 4 Oct 2002 20:44:38 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: oops in bk pull (oct 03)
In-Reply-To: <Pine.GSO.4.21.0210042030020.21250-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0210042037450.21250-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Oct 2002, Alexander Viro wrote:

> On Fri, 4 Oct 2002, Linus Torvalds wrote:
> 
> > > [<c01c9e91>] pci_read_bases+0x161/0x340
> > > [<c01ca2a6>] pci_setup_device+0x1b6/0x3d0
> > > [<c0105109>] init+0x79/0x200
> > > [<c0105090>] init+0x0/0x200
> > > [<c01073e5>] kernel_thread_helper+0x5/0x10
> > >Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 48 c3 8d b4
> > 
> > Something has corrupted your kernel image. Those 16 0x00 bytes are
> > definitely not the right code, looks like an errant memset() through a
> > wild pointer cleared it or something.
> > 
> > Is this repeatable? Does it happen with current BK?
> 
> It is repeatable, it does happen with current BK (well, as of couple
> of hours ago) and reverting pci/probe.c change apparently cures it.

PS: on my testbox it happens without apparent corruption of (printed) code.
However, %eip it prints _is_ odd - it's in the middle of pushing arguments
for second pci_read_config_dword() in pci_read_bases().  And AFAICS there's
no way in hell it could be legitimate - what I'm seeing is

(from  pci_write_config_dword(dev, reg, 0); )
        pushl $0
        pushl %edi
        movl 32(%esi),%eax
        pushl %eax
        movl 16(%esi),%eax
        pushl %eax
        call pci_bus_write_config_dword
        addl $16,%esp
(from pci_read_config_dword(dev, reg, &l0); )
        leal 24(%esp),%eax
        pushl %eax
        pushl %edi
        movl 32(%esi),%eax
        pushl %eax
        movl 16(%esi),%eax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        pushl %eax
        call pci_bus_read_config_dword
        addl $16,%esp

and we die on the underlined (%eip points to push %eax).  %esp is reasonable,
so is %esi (and we had just dereferenced both).

I'm at loss on that one - if somebody has bright (heck, any) ideas, you
are welcome.

