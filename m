Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261690AbTCQBLu>; Sun, 16 Mar 2003 20:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261682AbTCQBLu>; Sun, 16 Mar 2003 20:11:50 -0500
Received: from ns.cinet.co.jp ([61.197.228.218]:64782 "EHLO multi.cinet.co.jp")
	by vger.kernel.org with ESMTP id <S261681AbTCQBLq>;
	Sun, 16 Mar 2003 20:11:46 -0500
Message-ID: <E6D19EE98F00AB4DB465A44FCF3FA46903A348@ns.cinet.co.jp>
From: Osamu Tomita <tomita@cinet.co.jp>
To: "'James Bottomley '" <James.Bottomley@steeleye.com>
Cc: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'Linux Kernel Mailing List '" <linux-kernel@vger.kernel.org>,
       "'Alan Cox '" <alan@lxorguk.ukuu.org.uk>,
       "'Christoph Hellwig '" <hch@infradead.org>,
       "'Geert Uytterhoeven '" <geert@linux-m68k.org>
Subject: RE: Complete support PC-9800 for 2.5.64-ac4 (11/11) SCSI
Date: Mon, 17 Mar 2003 10:22:36 +0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comments.

-----Original Message-----
From: James Bottomley
To: Osamu Tomita
Cc: Linux Kernel Mailing List; Alan Cox; Christoph Hellwig; Geert
Uytterhoeven
Sent: 2003/03/17 2:47
Subject: Re: Complete support PC-9800 for 2.5.64-ac4 (11/11) SCSI

> On Sat, 2003-03-15 at 19:15, Osamu Tomita wrote:
> > This is the patch to support NEC PC-9800 subarchitecture
> > against 2.5.64-ac4. (11/11)
> 
> > SCSI host adapter support.
> >  - BIOS parameter change for PC98.
> >  - Add pc980155 driver for old PC98.
> >  - wd33c93.c update error handler for eh_*.
> >  - wd33c93.h register to int for PIO mode.
> 
> I suppose the first thing to point out is that it would be helpful if
> you could send this to linux-scsi@vger.kernel.org.  Although most SCSI
> people also read linux-kernel, it is easy to lose things in the noise.
I see.

> > diff -Nru linux/drivers/scsi/sd.c linux98/drivers/scsi/sd.c
> > --- linux/drivers/scsi/sd.c	2003-03-05 12:29:32.000000000 +0900
> > +++ linux98/drivers/scsi/sd.c	2003-03-08 11:13:28.000000000 +0900
> > @@ -485,6 +485,15 @@
> >  	else
> >  		scsicam_bios_param(bdev, sdkp->capacity, diskinfo);
> >  
> > +#ifdef CONFIG_X86_PC9800
> > +	{
> > +		extern int pc98_bios_param(struct scsi_device *,
> > +					   struct block_device *,
> > +					   sector_t, int *);
> > +		pc98_bios_param(sdp, bdev, sdkp->capacity, diskinfo);
> > +	}
> > +#endif
> > +
> >  	if (put_user(diskinfo[0], &loc->heads))
> >  		return -EFAULT;
> >  	if (put_user(diskinfo[1], &loc->sectors))
> 
> You already have the pc98_bios_param as part of your local driver.  Why
> do you need this in addition?
We need this for other SCSI cards not only wd33c93. For example, we
have cards for PC98 that use aha152x, aic7xxx, advansys and sym53c8xx
drivers. 
PC98 architecture has own boot selector and can boot any of 16 partitions
per 1 drive. The partition table conatins C/H/S geometry. And we can
assign non zero head or sector. Boot selector reads the partition table
and call BIOS by C/H/S parameters on boottime. If geometry is not mach
to BIOS, cannot boot from the partition created on linux. 

> [...]
> >  static inline uchar
> >  read_aux_stat(const wd33c93_regs regs)
> >  {
> > -	return inb(*regs.SASR);
> > +	return inb(regs.SASR);
> >  }
> >  
> >  static inline void
> >  write_wd33c93(const wd33c93_regs regs, uchar reg_num, uchar value)
> >  {
> > -      outb(reg_num, *regs.SASR);
> > -      outb(value, *regs.SCMD);
> > +      outb(reg_num, regs.SASR);
> > +      outb(value, regs.SCMD);
> >  }
> >  
> [...]
> >     /* This is what the 3393 chip looks like to us */
> >  typedef struct {
> > +#ifdef CONFIG_WD33C93_PIO
> > +   unsigned int   SASR;
> > +   unsigned int   SCMD;
> > +#else
> >     volatile unsigned char  *SASR;
> >     volatile unsigned char  *SCMD;
> > +#endif
> >  } wd33c93_regs;
> >  
> 
> This really doesn't look right.  For non PIO (which is all drivers apart
> from yours), they expect to dereference SASR to get the port number (as
> an unsigned char).  If you remove the dereference, don't they all break?
> 
> Perhaps the better thing to do is to make your driver use an unsigned
> int *, so the dereference works in all cases.
> 
> James
I supposed, I use this patch with "#ifdef CONFIG_WD33C93_PIO" in
wd33c98.c. 

Regards,
Osamu Tomita
