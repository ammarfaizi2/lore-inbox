Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310835AbSERJca>; Sat, 18 May 2002 05:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311121AbSERJc3>; Sat, 18 May 2002 05:32:29 -0400
Received: from e.kth.se ([130.237.48.5]:12813 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S310835AbSERJc2>;
	Sat, 18 May 2002 05:32:28 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=),
        linux-kernel@vger.kernel.org
Subject: Re: ide cd/dvd with 2.4.19-pre8
In-Reply-To: <E178nCf-00076R-00@the-village.bc.nu>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 18 May 2002 11:32:08 +0200
Message-ID: <yw1xznyx3ip3.fsf@gladiusit.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > I just noticed that reading from both my cdrom and dvd is a lot slower
> > with 2.4.19-pre8 than 2.4.18. Now hdparm reports ~800 kbytes/s compared=
> >  to
> > 1.7 MBytes/s for CD and >2 MBytes/s for DVD with 2.4.18. It is even imp=
> > ossible
> > to play DVDs. Any ideas?
> 
> Did you include support for your controller. Are you in fact now in PIO
> mode because you didnt ?

I included support for PDC202xx and have a PDC20268 (Promise Ultra100
TX2).  Isn't that enough? hdparm claims the cd and dvd are using
dma. The configuration is exactly the same with both kernels.

However, I had to modify pdc202xx.c to make it use udma3 and higher
for the disk. It failed to set hwif->udma_four so other parts of the
ide driver refused to even try the fast modes. I pointed this out a couple
of weeks ago but didn't get any response.

There is also some trouble with udma4&5. Both the disk and the controller
claim they support it and it looks like it is properly detected. However
I get these messages when booting:
PDC20268: IDE controller on PCI bus 00 dev 60
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
PDC20268: ROM enabled at 0x09074000
    ide2: BM-DMA at 0x8090-0x8097, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x8098-0x809f, BIOS settings: hdg:pio, hdh:pio
hde: ST340810A, ATA DISK drive
hdg: SAMSUNG COMBO SM-304B, ATAPI CD/DVD-ROM drive
ide2 at 0x80a0-0x80a7,0x80b2 on irq 32
ide3 at 0x80a8-0x80af,0x80b6 on irq 32
hde: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63, UDMA(100)
Partition check:
 /dev/ide/host2/bus0/target0/lun0:hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
PDC202XX: Primary channel reset.
ide2: reset: success
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
PDC202XX: Primary channel reset.
ide2: reset: success

After this the disk is in udma3 mode and works fine, though it should be able
to go faster. This problem has been present with all kernels from 2.4.10.
I haven't tried earlier ones. I have an Alpha in case it matters.

-- 
Måns Rullgård
mru@users.sf.net
