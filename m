Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316866AbSEVGIo>; Wed, 22 May 2002 02:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316867AbSEVGIn>; Wed, 22 May 2002 02:08:43 -0400
Received: from mail017.syd.optusnet.com.au ([210.49.20.175]:31145 "EHLO
	mail017.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S316866AbSEVGIl>; Wed, 22 May 2002 02:08:41 -0400
Date: Wed, 22 May 2002 16:11:44 +1000
From: Andrew Pam <xanni@glasswings.com.au>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Initialisation bug in IDE patch
Message-ID: <20020522161144.G2437@kira.glasswings.com.au>
In-Reply-To: <20020522155515.F2437@kira.glasswings.com.au> <Pine.LNX.4.10.10205212255170.19403-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2002 at 11:00:45PM -0700, Andre Hedrick wrote:
> 
> Please check the function in the top of ide.c
> 
> linux-2.4.19-p7 ide.c
> 
> static void init_hwif_data (unsigned int index)
> {
>         unsigned int unit;
>         hw_regs_t hw;
>         ide_hwif_t *hwif = &ide_hwifs[index];
> 
>         /* bulk initialize hwif & drive info with zeros */
>         memset(hwif, 0, sizeof(ide_hwif_t));
>         memset(&hw, 0, sizeof(hw_regs_t));
> 
>         /* fill in any non-zero initial values */
>         hwif->index     = index;
>         ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, &hwif->irq);
>         memcpy(&hwif->hw, &hw, sizeof(hw));
>         memcpy(hwif->io_ports, hw.io_ports, sizeof(hw.io_ports));
>         hwif->noprobe   = !hwif->io_ports[IDE_DATA_OFFSET];
> 
> Obviously you are calling things outside of the normal usage of the
> driver.  

No, this is the existing driver as shipped; I have not modified the code.
The init_hwif_data roiutine has not yet been called while the ide_setup()
routine is parsing the kernel parameters, hence the bug.

> 2.2.19 ide.c
> 
> /*
>  * Do not even *think* about calling this!
>  */
> static void init_hwif_data (unsigned int index)
> {
>         unsigned int unit;
>         hw_regs_t hw;
>         ide_hwif_t *hwif = &ide_hwifs[index];
> 
>         /* bulk initialize hwif & drive info with zeros */
>         memset(hwif, 0, sizeof(ide_hwif_t));
>         memset(&hw, 0, sizeof(hw_regs_t));
> 
>         /* fill in any non-zero initial values */
>         hwif->index     = index;
>         ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, &hwif->irq);
>         memcpy(&hwif->hw, &hw, sizeof(hw));
>         memcpy(hwif->io_ports, hw.io_ports, sizeof(hw.io_ports));
>         hwif->noprobe   = !hwif->io_ports[IDE_DATA_OFFSET];
> #ifdef CONFIG_BLK_DEV_HD
>         if (hwif->io_ports[IDE_DATA_OFFSET] == HD_DATA)
> 
> If you are attempting to introduce a hw.chipset which is unknown to the
> driver please submit a patch to register it or the enum index will barf.

No, I have a qd6580 which is already supported.  This bug is in existing
kernel code; I am not adding any new code, but spent some hours debugging
the problem with printk statements.

Regards,
	Andrew Pam
-- 
mailto:xanni@xanadu.net                         Andrew Pam
http://www.xanadu.com.au/                       Chief Scientist, Xanadu
http://www.glasswings.com.au/                   Technology Manager, Glass Wings
http://www.sericyb.com.au/                      Manager, Serious Cybernetics
http://two-cents-worth.com/?105347&EG		Donate two cents to our work!
P.O. Box 477, Blackburn VIC 3130 Australia	Phone +61 401 258 915
