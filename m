Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313161AbSEVGB7>; Wed, 22 May 2002 02:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316864AbSEVGB6>; Wed, 22 May 2002 02:01:58 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:15625
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S313161AbSEVGB5>; Wed, 22 May 2002 02:01:57 -0400
Date: Tue, 21 May 2002 23:00:45 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Andrew Pam <xanni@glasswings.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Initialisation bug in IDE patch
In-Reply-To: <20020522155515.F2437@kira.glasswings.com.au>
Message-ID: <Pine.LNX.4.10.10205212255170.19403-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please check the function in the top of ide.c

linux-2.4.19-p7 ide.c

static void init_hwif_data (unsigned int index)
{
        unsigned int unit;
        hw_regs_t hw;
        ide_hwif_t *hwif = &ide_hwifs[index];

        /* bulk initialize hwif & drive info with zeros */
        memset(hwif, 0, sizeof(ide_hwif_t));
        memset(&hw, 0, sizeof(hw_regs_t));

        /* fill in any non-zero initial values */
        hwif->index     = index;
        ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, &hwif->irq);
        memcpy(&hwif->hw, &hw, sizeof(hw));
        memcpy(hwif->io_ports, hw.io_ports, sizeof(hw.io_ports));
        hwif->noprobe   = !hwif->io_ports[IDE_DATA_OFFSET];

Obviously you are calling things outside of the normal usage of the
driver.  

2.2.19 ide.c

/*
 * Do not even *think* about calling this!
 */
static void init_hwif_data (unsigned int index)
{
        unsigned int unit;
        hw_regs_t hw;
        ide_hwif_t *hwif = &ide_hwifs[index];

        /* bulk initialize hwif & drive info with zeros */
        memset(hwif, 0, sizeof(ide_hwif_t));
        memset(&hw, 0, sizeof(hw_regs_t));

        /* fill in any non-zero initial values */
        hwif->index     = index;
        ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, &hwif->irq);
        memcpy(&hwif->hw, &hw, sizeof(hw));
        memcpy(hwif->io_ports, hw.io_ports, sizeof(hw.io_ports));
        hwif->noprobe   = !hwif->io_ports[IDE_DATA_OFFSET];
#ifdef CONFIG_BLK_DEV_HD
        if (hwif->io_ports[IDE_DATA_OFFSET] == HD_DATA)

If you are attempting to introduce a hw.chipset which is unknown to the
driver please submit a patch to register it or the enum index will barf.

Cheers,

On Wed, 22 May 2002, Andrew Pam wrote:

> On Wed, May 22, 2002 at 03:15:10PM +1000, Andrew Pam wrote:
> > In the latest available kernel 2.2 IDE patch "ide-2.2.20.01102002.patch"
> > there is a bug that prevents ide_setup in drivers/block/ide.c
> > from accepting kernel parameters selecting special IDE hardware.
> > 
> > The ide_init_default_hwifs() function in include/asm-*/ide.h fails to
> > initialise the "hw_regs_t hw" variable, thus leaving uninitialised data
> > in some fields.  Specifically, the "chipset" field is uninitialised which
> > causes the "if (hwif->chipset != ide_unknown)" test in drivers/block/ide.c
> > to always fail with the error message " -- BAD OPTION".
> 
> This bug also appears to be present in the mainline 2.4 kernel IDE code.
> I haven't checked the 2.5 code yet.
> 
> Regards,
> 	Andrew Pam
> -- 
> mailto:xanni@xanadu.net                         Andrew Pam
> http://www.xanadu.com.au/                       Chief Scientist, Xanadu
> http://www.glasswings.com.au/                   Technology Manager, Glass Wings
> http://www.sericyb.com.au/                      Manager, Serious Cybernetics
> http://two-cents-worth.com/?105347&EG		Donate two cents to our work!
> P.O. Box 477, Blackburn VIC 3130 Australia	Phone +61 401 258 915
> 

Andre Hedrick
LAD Storage Consulting Group

