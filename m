Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264701AbUEEPgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264701AbUEEPgm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 11:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264703AbUEEPgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 11:36:42 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:33999 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264701AbUEEPgG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 11:36:06 -0400
Date: Wed, 5 May 2004 17:36:01 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove dead drivers/ide/ppc/swarm.c
In-Reply-To: <Pine.LNX.4.55.0405041621370.32082@jurand.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.55.0405051555170.17257@jurand.ds.pg.gda.pl>
References: <200405040134.22092.bzolnier@elka.pw.edu.pl>
 <200405041428.50592.bzolnier@elka.pw.edu.pl> <20040504124349.GA15664@linux-mips.org>
 <200405041510.41731.bzolnier@elka.pw.edu.pl> <Pine.LNX.4.55.0405041621370.32082@jurand.ds.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 May 2004, Maciej W. Rozycki wrote:

> > The basic question is whether disk used on SiByte can be read i.e. on x86.
> > If not than we may have serious problems with some special commands with
> > current implementation (similar problem as on Atari Q40/Q60).
> 
>  I can check the GPIO attachment with 2.4 (which should behave the same
> way here).  I don't have a PCI IDE board.

 Here is the result:

Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SiByte onboard IDE configured as device 0
hda: ST310211A, ATA DISK drive
ide0 at 0xffffffff340b3e00-0xffffffff340b3e07,0xffffffff340b7ec0 on irq 36
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 19541088 sectors (10005 MB) w/1024KiB Cache, CHS=19386/16/63
Partition check:
 hda:
[...]
# dd if=/dev/hda bs=512 count=1 2>/dev/null | od -Ax -tx1
000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
*
0001f0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 55 aa
000200

so barring the completely bogus addresses reported (the interface is
decoded at 0x100b0000 and that's MMIO, unrelated to the PCI I/O space -- I
guess fixing it would require a significant update to ide-probe.c and
elsewhere), it looks OK.  This is in a little-endian configuration -- I'll
recheck for big endianness once I have appropriate userland installed
(which is likely not very soon).  It shouldn't matter much, though -- I've
checked documentation and I've found out that while the generic bus (the
IDE connector is wired to) is big-endian externally, the internal logic
does swapping if the system is configured for little-endian operation.  

 FYI, the interface is currently fixed at PIO3, but perhaps it could get
improved to handle other speeds.  Bus-master DMA is unsupported, but
perhaps one of the data movers could get engaged for a third-party DMA
support.  The generic bus is clocked at 100MHz, so faster operation is
possible, at least in theory.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
