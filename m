Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265607AbUFDFrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265607AbUFDFrU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 01:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265624AbUFDFrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 01:47:20 -0400
Received: from miranda.se.axis.com ([193.13.178.2]:18381 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S265607AbUFDFrQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 01:47:16 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: "'Jeff Garzik'" <jgarzik@pobox.com>, "'Andrew Morton'" <akpm@osdl.org>
Cc: "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: RE: [PATCH] CRIS architecture update
Date: Fri, 4 Jun 2004 07:46:21 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C66818F497@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C668D0BC1E@exmail1.se.axis.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>Who reviewed the ethernet driver?
>Who reviewed the IDE driver?
>Has Bart seen this new driver?
>Why was this committed without first being run by the subsystem
maintainers?

I am very happy if people outside Axis can find time to review patches
that only affects the CRIS architecture (note that all files are under
arch/cris and there is no way you can get these drivers unless you run 
CRIS). I have assumed that people like you and Bart have too much on 
your hands to do this. The few times I have tried to patch CRIS stuff on 
LKML the response is usally none.

>In ethernet, the MII phy probe is wrong (don't need at id 0 first), 

Why is that? Phy address == 0 is the most common value for CRIS based
hardwares.

>it should be using linux/mii.h bits rather than inventing its own, 

Yes.

>del_timer versus del_timer_sync is questionable, 

del_timer_sync is defined to del_timer for !SMP and there is no SMP
support in CRISv10.

>the newly-added full  duplex handling seems to be incorrect
>(ref drivers/net/mii.c and drivers that use mii_if->full_duplex), 

Great! I can definitely use the code in mii.c. Thanks for the pointer.

>and cosmetic issues I won't bother to mention.

Yes, I agree that there are lots of legacy non-Linux formatting. I'll fix
that up.

>In IDE, it uses virt_to_page() when building the scatter/gather list -- 
>something that IMO should not have been allowed in -mm much less 
>mainline -- and other yuckiness.  

This code is copy-pasted from ide-dma.c (ide_raw_build_sglist).
Why is it ok there and not in our driver?

>In the same function, it's questionable whether or not it breaks 
>with lba48.  

Could be. The 2.6 driver is a direct port of the 2.4 driver and
that works with lba48 but the 2.6 driver has not been verified
to work with it.

>etrax_dma_intr doesn't appear to check for some DMA engine 
>conditions that code comments elsewhere in the driver indicate
>_do_ occur.  

etrax_dma_intr checks the result of ide_dma_end but e100_dma_end
always returns 0 and there is a comment there that this could
be improved. I can add some checks of the DMA status there to 
make sure.

>The ATAPI-specific e100_start_dma code doesn't look like it will 
>work with all current ATAPI drivers (ide-{cdrom,floppy,tape,scsi,...}.c).

In e100_start_dma there are a if (!atapi) in a few places to fix 
LBA48 but there is no ATAPI specific code. The driver has only 
been tested with a disk and a CD so I agree that it may fail for 
some devices.

>I'm happy that the CRIS people resurfaced, too, but that's no reason to 
>just shove an unreviewed patch into mainline.

We are continously working on the CRIS port. Recently we have put most
of our work on support for a new CRIS sub-architecture in 2.6. 2.6 is
not really used in any CRIS-based products yet. While 2.5 was moving
fast I was reluctant to submit patches because most people don't care
if CRIS is changing things back and forth to follow the bleeding edge.

Next time I'll send the patches to the subsystem maintainers and LKML. 
I would be very happy if someone could find some time to review our
patches. 

At least the following patches are expected:
Fixes for the things you've pointed out and similar stuff
USB driver
New subarchitechture (later this year)

Thanks!
/Mikael (CRIS Maintainer)

