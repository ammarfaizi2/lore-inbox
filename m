Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268446AbUH3CpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268446AbUH3CpZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 22:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268447AbUH3CpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 22:45:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61331 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268446AbUH3CpT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 22:45:19 -0400
Date: Sun, 29 Aug 2004 22:07:12 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Neil Horman <nhorman@redhat.com>
Cc: Marc =?iso-8859-1?Q?Str=E4mke?= <marcstraemke.work@gmx.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Problem accessing Sandisk CompactFlash Cards (Connected to the IDE bus)
Message-ID: <20040830010712.GC12313@logos.cnet>
References: <cgs2c1$ccg$1@sea.gmane.org> <4131DC5D.8060408@redhat.com> <cgsuq2$7cb$1@sea.gmane.org> <41326FE1.2050508@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <41326FE1.2050508@redhat.com>
User-Agent: Mutt/1.5.5.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2004 at 08:08:01PM -0400, Neil Horman wrote:
> Marc Strämke wrote:
> 
> >Neil Horman wrote:
> >
> >>Its been awhile, but the last time that I looked at the relevant 
> >>code, there was a table of drive vendor/device strings that were used 
> >>to identify CFA devices and differentiate them from regular ide 
> >>devices.  If this particular device isn't a match in that table, it 
> >>would be mis-identified, and that could be leading to your above 
> >>problem.
> >>Neil
> >>
> >
> >Thx for the suggestion. The only table i could find is in 
> >drive_is_flashcard, which is only checked if drive->removable is set, 
> >which is not the case with the newer card (but is with the old one).
> >Another thing which is weird is that the old card returns an 
> >id->config value of 0x848a which according to manuals from SanDisk is 
> >for a Compactflash card NOT running in True Ide mode, but instead in 
> >memory mapped IO mode (iam no expert for Compactflash, so i dont even 
> >know the exact difference), but as far as i can tell are both cards 
> >wired by the IDE adapter so that they should run in True IDE mode, and 
> >if i understand the Compactflash specification correctly, this is the 
> >only mode of operation which is electrically compatible with the 
> >IDE/ATA bus, isnt it?
> >I tried forcing both the drive->removable and drive->is_flash flags to 
> >the true, my dmesg output then shows me the card as a CFA DISK drive, 
> >but i still get the same errors when reading or writing from/to the 
> >device.
> >
> >TIA for any further hints,
> >Marc
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe 
> >linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> 
> What kernel are you looking at?  I'm looking at 2.4.21, and it seems to 
> get checked more-or-less universally.  Also, I noticed this:
> || !strncmp(id->model, "SunDisk SDCFB", 13)    /* SunDisk */
> I've not heard of SunDisk.  SunDisk->SanDisk == Typo?
> Are you using a SanDisk CFA card?  Could this perhaps be part of your issue?

Indeed this is a typo but has been fixed on 2.4.26:

        if (drive->removable && id != NULL) {
                if (id->config == 0x848a) return 1;     /* CompactFlash */
                if (!strncmp(id->model, "KODAK ATA_FLASH", 15)  /* Kodak */
                 || !strncmp(id->model, "Hitachi CV", 10)       /* Hitachi */
                 || !strncmp(id->model, "SunDisk SDCFB", 13)    /* old SanDisk */
                 || !strncmp(id->model, "SanDisk SDCFB", 13)    /* SanDisk */
                 || !strncmp(id->model, "HAGIWARA HPC", 12)     /* Hagiwara */
                 || !strncmp(id->model, "LEXAR ATA_FLASH", 15)  /* Lexar */
                 || !strncmp(id->model, "ATA_FLASH", 9))        /* Simple Tech */
                {

I haven't got much of a clue about IDE, but I can see the newer card supports
DMA, and the older doesnt, but you are probably not using DMA on that? whats
the output of "hdparm /dev/hda".

Also can you show us dmesg from both old and new cards.

