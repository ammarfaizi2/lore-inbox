Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131232AbRCUHVB>; Wed, 21 Mar 2001 02:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131233AbRCUHUv>; Wed, 21 Mar 2001 02:20:51 -0500
Received: from aeon.tvd.be ([195.162.196.20]:1194 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S131232AbRCUHUd>;
	Wed, 21 Mar 2001 02:20:33 -0500
Date: Wed, 21 Mar 2001 08:19:29 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Gérard Roudier <groudier@club-internet.fr>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: st corruption with 2.4.3-pre4
In-Reply-To: <Pine.LNX.4.10.10103202029370.1698-100000@linux.local>
Message-ID: <Pine.LNX.4.05.10103210815560.577-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2001, Gérard Roudier wrote:
> On Tue, 20 Mar 2001, Geert Uytterhoeven wrote:
> > On Tue, 20 Mar 2001, Geert Uytterhoeven wrote:
> > > On Mon, 19 Mar 2001, Jeff Garzik wrote:
> > > > Is the corruption reproducible?  If so, does the corruption go away if
> > > 
> > > Yes, it is reproducible. In all my tests, I tarred 16 files of 16 MB each to
> > > tape (I used a new one).
> > >   - test 1: 4 files with failed md5sum (no further investigation on type of
> > > 	    corruption)
> > >   - test 2: 7 files with failed md5sum, 7 blocks of 32 consecutive bytes were
> > > 	    corrupted, all starting at an offset of the form 32*x+1.
> > >   - test 3: 7 files with failed md5sum, 7 blocks of 32 consecutive bytes were
> > > 	    corrupted, all starting at an offset of the form 32*x+1.
> > > 
> > > The files seem to be corrupted during writing only, as reading always gives the
> > > exact same (corrupted) data back.
> > > 
> > > Copying files from the disk on the MESH to a disk on the Sym53c875 (which also
> > > has the tape drive) shows no corruption.
> > 
> > I did some more tests:
> >   - The problem also occurs when tarring up files from a disk on the Sym53c875.
> >   - The corrupted data always occurs at offset 32*x (the `+1' above was caused
> >     by hexdump, starting counting at 1).
> >   - The 32 bytes of corrupted data at offset 32*x are always a copy of the data
> >     at offset 32*x-10240.
> >   - Since 10240 is the default blocksize of tar (bug in tar?), I made a tarball
> >     on disk instead of on tape, but no corruption.
> >   - 32 is the size of a cacheline on PPC. Is there a missing cacheflush
> >     somewhere in the Sym53c875 driver? But then it should happen on disk as
> >     well?
> 
> The only PCI transaction that requires the cache line size to be correctly
> configured is PCI WRITE and INVALIDATE. This transaction may be used by
> the 875 only for data read from a SCSI device and DMAed to memory.

So if this would be the problem, I should see the corruption when reading files
from disks too? But my tests indicate it happens when writing to tape only, not
when reading from tape, nor when copying between disks.

> Note that the controller may use optimized PCI transactions only if the 
> cache line size is configured in its PCI device configuration space.
> Otherwise only normal PCI memory read and PCI memory write transactions 
> will be used.
> 
> Could you check if the cache line size is configured for your 875?
> 
> Let me imagine it is so. Btw, I may be wasting my time if it is not ...
> Then the 875 may also use PCI read multiple transactions and/or PCI read
> line transactions when reading data from memory. If the corruption is due
> to the use of these transactions, the the PCI-HOST bridges may well be the
> culprit, in my opinion.
> 
> Anyway, since the sym53c8xx driver does not try to change the configured
> cache line size on PPC, I would suggest to try again the same tests with
> the cache line size set to zero for the 875. You may hack the driver code
> or the PPC pci code if needed, for example, for value zero to be written
> in the proper place in the PCI configuration space of the 875.

I'll try that.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

