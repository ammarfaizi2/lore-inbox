Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315784AbSEDHYk>; Sat, 4 May 2002 03:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315785AbSEDHYj>; Sat, 4 May 2002 03:24:39 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:15200 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315784AbSEDHYj>; Sat, 4 May 2002 03:24:39 -0400
Date: Sat, 4 May 2002 09:25:31 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa1 & vm-34: unresolved kmap_pagetable
Message-ID: <20020504092531.L1396@dualathlon.random>
In-Reply-To: <20020503203738.E1396@dualathlon.random> <3CD339B7.5BEB2DB4@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2002 at 11:30:31AM +1000, Eyal Lebedinsky wrote:
> Andrea Arcangeli wrote:
> > 
> > Full patchkit:
> > http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre8aa1.gz
> 
> This is a new symbol introduced in -aa1. It ends up in drivers through
> new header definitions rather than by direct use.
> 
> Should be exported?

You should #include <linux/highmem.h> in those drivers .c files, then it
will compile, but that's not the right fix, you'd need to add the
pte_kunmap too or it would deadlock with highmem. The right fix is to
convert those drivers to vmalloc_to_page, then they will work flawlessy.
Alan actually has a patch in his -ac that converted most usb and other
drivers to vmalloc_to_page, I will merge it plus I will convert those
below drivers if they're not just covered by Alan's patch. Alan could
you push it to Marcelo?

After I finished covering all the compilation failures you reported I
will upload an aa2 with all your patches included. I usually don't
compile every driver out there so I didn't noticed those problems, sorry.

> 
> 
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.19-pre8-aa1/kernel/drivers/ieee1394/dv1394.o
> depmod:         kmap_pagetable
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.19-pre8-aa1/kernel/drivers/net/wan/comx.o
> depmod:         proc_get_inode

actually comx is unrealted to the pte-highmem problem, to fix it we
should EXPORT_SYMBOL(proc_get_inode), but I'm not sure why it wants to
implement the dir lookup by itself instead of relying on the procfs
layer, probably to allow more functionality like mkdir/rmdir.

> depmod: *** Unresolved symbols in
> /lib/modules/2.4.19-pre8-aa1/kernel/drivers/video/NVdriver
> depmod:         kmap_pagetable
> 
> --
> Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>


Andrea
