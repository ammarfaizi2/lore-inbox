Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267637AbUGaOjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267637AbUGaOjb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 10:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267641AbUGaOjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 10:39:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22415 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267591AbUGaOjQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 10:39:16 -0400
Date: Sat, 31 Jul 2004 11:37:00 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jeremy Jackson <jerj@coplanar.net>,
       Torben Mathiasen <torben.mathiasen@hp.com>,
       linux-kernel@vger.kernel.org, linux-ide <linux-ide@vger.kernel.org>
Subject: Re: 2.4.23 IDE hang on boot with two single-channel controllers
Message-ID: <20040731143700.GC6497@logos.cnet>
References: <401538C6.5030609@coplanar.net> <200402180034.44917.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402180034.44917.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Bart,

This triflex fix hasnt been merged in v2.4 mainline, it looks 
pretty straightforward. And it works for Jeremy.

Shall we merge this in 2.4.28-pre?

TIA

On Wed, Feb 18, 2004 at 12:34:44AM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> [ I've just found it in my mail-archive :-). ]
> 
> On Monday 26 of January 2004 16:56, Jeremy Jackson wrote:
> > Hi,
> 
> Hi,
> 
> > (watch crossposting when replying all)
> >
> > I'm hoping to reach the maintainer of the Linux IDE driver for the
> > Compaq TriFlex controller.  I have a problem with this driver when used
> > with a Compaq Armada 7730MT while docked in the base station.
> >
> > The driver appears to only support one triflex controller, due to a
> > missing check (that other chipset drivers have) that should prevent it
> > from registering a /proc interface more than once.  The result is that
> > it hangs on boot in proc_ide_create() in an infinite loop.
> 
> Please send outputs of 'lspci' and 'dmesg' commands.
> 
> > triflex.c:
> >
> > static unsigned int __init init_chipset_triflex(struct pci_dev *dev,
> >                  const char *name)
> > {
> > #ifdef CONFIG_PROC_FS
> >          ide_pci_register_host_proc(&triflex_proc);
> > #endif
> >          return 0;
> > }
> >
> > It also appears that triflex_get_info() doesn't support more that one
> > controller.
> 
> Yep, that's true.
> 
> > I won't go into more detail until I can establish who might care :)
> 
> I might care ;-).
> 
> Does this patch fixes hang?
> Does 'cat /proc/ide/triflex' produce sane output?
> 
> Cheers,
> --bart
> 
>  linux-2.4.23-root/drivers/ide/pci/triflex.c |   41 +++++++++++++++++++---------
>  linux-2.4.23-root/drivers/ide/pci/triflex.h |    5 ++-
>  2 files changed, 32 insertions(+), 14 deletions(-)
> 
> diff -puN drivers/ide/pci/triflex.c~ide_triflex_proc_fix drivers/ide/pci/triflex.c
> --- linux-2.4.23/drivers/ide/pci/triflex.c~ide_triflex_proc_fix	2004-02-17 23:40:34.324345576 +0100
> +++ linux-2.4.23-root/drivers/ide/pci/triflex.c	2004-02-18 00:22:53.578320296 +0100
> @@ -44,15 +44,17 @@
>  #include "ide_modes.h"
>  #include "triflex.h"
>  
> -static struct pci_dev *triflex_dev;
> +#ifdef CONFIG_PROC_FS
> +static u8 triflex_proc;
>  
> -static int triflex_get_info(char *buf, char **addr, off_t offset, int count)
> -{
> -	char *p = buf;
> -	int len;
> +#define TRIFLEX_MAX_DEVS	2
> +static struct pci_dev *triflex_devs[TRIFLEX_MAX_DEVS];
> +static unsigned int n_triflex_devs;
>  
> -	struct pci_dev *dev	= triflex_dev;
> +static int triflex_info(char *buffer, struct pci_dev *dev)
> +{
>  	unsigned long bibma = pci_resource_start(dev, 4);
> +	char *p = buffer;
>  	u8  c0 = 0, c1 = 0;
>  	u32 pri_timing, sec_timing;
>  
> @@ -87,11 +89,23 @@ static int triflex_get_info(char *buf, c
>  	p += sprintf(p, "DMA\n");
>  	p += sprintf(p, "PIO\n");
>  
> +	return p - buffer;
> +}
> +
> +static int triflex_get_info(char *buf, char **addr, off_t offset, int count)
> +{
> +	char *p = buf;
> +	unsigned int i, len;
> +
> +	for (i = 0; i < n_triflex_devs; i++)
> +		buf += triflex_info(buf, triflex_devs[i]);
> +
>  	len = (p - buf) - offset;
>  	*addr = buf + offset;
> -	
> +
>  	return len > count ? count : len;
>  }
> +#endif
>  
>  static int triflex_tune_chipset(ide_drive_t *drive, u8 xferspeed)
>  {
> @@ -211,9 +225,13 @@ static unsigned int __init init_chipset_
>  		const char *name) 
>  {
>  #ifdef CONFIG_PROC_FS
> -	ide_pci_register_host_proc(&triflex_proc);
> +	triflex_devs[n_triflex_devs++] = dev;
> +	if (!triflex_proc) {
> +		triflex_proc = 1;
> +		ide_pci_register_host_proc(&triflex_procs);
> +	}
>  #endif
> -	return 0;	
> +	return 0;
>  }
>  
>  static int __devinit triflex_init_one(struct pci_dev *dev, 
> @@ -222,11 +240,10 @@ static int __devinit triflex_init_one(st
>  	ide_pci_device_t *d = &triflex_devices[id->driver_data];
>  	if (dev->device != d->device)
>  		BUG();
> -	
> +
>  	ide_setup_pci_device(dev, d);
> -	triflex_dev = dev;
>  	MOD_INC_USE_COUNT;
> -	
> +
>  	return 0;
>  }
>  
> diff -puN drivers/ide/pci/triflex.h~ide_triflex_proc_fix drivers/ide/pci/triflex.h
> --- linux-2.4.23/drivers/ide/pci/triflex.h~ide_triflex_proc_fix	2004-02-17 23:58:11.698600256 +0100
> +++ linux-2.4.23-root/drivers/ide/pci/triflex.h	2004-02-18 00:27:28.152578664 +0100
> @@ -14,7 +14,6 @@
>  
>  static unsigned int __devinit init_chipset_triflex(struct pci_dev *, const char *);
>  static void init_hwif_triflex(ide_hwif_t *);
> -static int triflex_get_info(char *, char **, off_t, int);
>  
>  static ide_pci_device_t triflex_devices[] __devinitdata = {
>  	{
> @@ -34,7 +33,9 @@ static ide_pci_device_t triflex_devices[
>  };
>  
>  #ifdef CONFIG_PROC_FS
> -static ide_pci_host_proc_t triflex_proc __initdata = {
> +static int triflex_get_info(char *, char **, off_t, int);
> +
> +static ide_pci_host_proc_t triflex_procs __initdata = {
>  	.name		= "triflex",
>  	.set		= 1,
>  	.get_info 	= triflex_get_info,
> 
> _
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
