Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316868AbSEVGUH>; Wed, 22 May 2002 02:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316869AbSEVGUG>; Wed, 22 May 2002 02:20:06 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:17161
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S316868AbSEVGUF>; Wed, 22 May 2002 02:20:05 -0400
Date: Tue, 21 May 2002 23:18:56 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Andrew Pam <xanni@glasswings.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Initialisation bug in IDE patch
In-Reply-To: <20020522161144.G2437@kira.glasswings.com.au>
Message-ID: <Pine.LNX.4.10.10205212313160.19403-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



from ide.c

 */
int __init ide_setup (char *s)
{
        int i, vals[3];
<snip>
        printk("ide_setup: %s", s);
        init_ide_data ();


#define MAGIC_COOKIE 0x12345678
static void __init init_ide_data (void)
{
        unsigned int index;
        static unsigned long magic_cookie = MAGIC_COOKIE;

        if (magic_cookie != MAGIC_COOKIE)
                return;         /* already initialized */
        magic_cookie = 0;

        /* Initialise all interface structures */
        for (index = 0; index < MAX_HWIFS; ++index)
                init_hwif_data(index);

        /* Add default hw interfaces */
        ide_init_default_hwifs();

        idebus_parameter = 0;
        system_bus_speed = 0;
}


Now you have me puzzled........
If "ide_setup" which parses the passed settings calls "init_ide_data"
which initalizes all "hwif" groups and sets a cookie to prevent "ide_init"
from re-initalizing thus purging the contents place in by "ide_setup", how
are you getting a "BAD -- OPTION"?

Would please post what you are attempting to pass ?

On Wed, 22 May 2002, Andrew Pam wrote:

> On Tue, May 21, 2002 at 11:00:45PM -0700, Andre Hedrick wrote:
> > 
> > Please check the function in the top of ide.c
> > 
> > linux-2.4.19-p7 ide.c
> > 
> > static void init_hwif_data (unsigned int index)
> > {
> >         unsigned int unit;
> >         hw_regs_t hw;
> >         ide_hwif_t *hwif = &ide_hwifs[index];
> > 
> >         /* bulk initialize hwif & drive info with zeros */
> >         memset(hwif, 0, sizeof(ide_hwif_t));
> >         memset(&hw, 0, sizeof(hw_regs_t));
> > 
> >         /* fill in any non-zero initial values */
> >         hwif->index     = index;
> >         ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, &hwif->irq);
> >         memcpy(&hwif->hw, &hw, sizeof(hw));
> >         memcpy(hwif->io_ports, hw.io_ports, sizeof(hw.io_ports));
> >         hwif->noprobe   = !hwif->io_ports[IDE_DATA_OFFSET];
> > 
> > Obviously you are calling things outside of the normal usage of the
> > driver.  
> 
> No, this is the existing driver as shipped; I have not modified the code.
> The init_hwif_data roiutine has not yet been called while the ide_setup()
> routine is parsing the kernel parameters, hence the bug.
> 
> > 2.2.19 ide.c
> > 
> > /*
> >  * Do not even *think* about calling this!
> >  */
> > static void init_hwif_data (unsigned int index)
> > {
> >         unsigned int unit;
> >         hw_regs_t hw;
> >         ide_hwif_t *hwif = &ide_hwifs[index];
> > 
> >         /* bulk initialize hwif & drive info with zeros */
> >         memset(hwif, 0, sizeof(ide_hwif_t));
> >         memset(&hw, 0, sizeof(hw_regs_t));
> > 
> >         /* fill in any non-zero initial values */
> >         hwif->index     = index;
> >         ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, &hwif->irq);
> >         memcpy(&hwif->hw, &hw, sizeof(hw));
> >         memcpy(hwif->io_ports, hw.io_ports, sizeof(hw.io_ports));
> >         hwif->noprobe   = !hwif->io_ports[IDE_DATA_OFFSET];
> > #ifdef CONFIG_BLK_DEV_HD
> >         if (hwif->io_ports[IDE_DATA_OFFSET] == HD_DATA)
> > 
> > If you are attempting to introduce a hw.chipset which is unknown to the
> > driver please submit a patch to register it or the enum index will barf.
> 
> No, I have a qd6580 which is already supported.  This bug is in existing
> kernel code; I am not adding any new code, but spent some hours debugging
> the problem with printk statements.
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

