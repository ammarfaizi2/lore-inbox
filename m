Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265571AbRF2FjO>; Fri, 29 Jun 2001 01:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265559AbRF2Fiz>; Fri, 29 Jun 2001 01:38:55 -0400
Received: from mail.aslab.com ([205.219.89.194]:17458 "EHLO mail.aslab.com")
	by vger.kernel.org with ESMTP id <S265545AbRF2Fir>;
	Fri, 29 Jun 2001 01:38:47 -0400
Date: Thu, 28 Jun 2001 22:38:50 -0700 (PDT)
From: Andre Hedrick <andre@aslab.com>
To: Gunther Mayer <Gunther.Mayer@t-online.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Patch(2.4.5): Fix PCMCIA ATA/IDE freeze (w/ PCI add-in cards)
 V3
In-Reply-To: <3B3B677C.458188BB@t-online.de>
Message-ID: <Pine.LNX.4.04.10106281317001.30863-100000@mail.aslab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That is a legacy bit from ATA-2 but it is one of those things you can not
get rid of :-( even thou things are obsoleted, they are not retired.
This means that you have to go back into the past to see how it was used,
silly!  I hope you agree to that point.

This is the drive->ctrl register pointer.

outp(drive->ctl|0x02, IDE_CONTROL_REG);

typedef union {
        unsigned all                    : 8;    /* all of the bits together */
        struct {
                unsigned bit0           : 1;
                unsigned nIEN           : 1;    /* device INTRQ to host */
                unsigned SRST           : 1;    /* host soft reset bit */
                unsigned bit3           : 1;    /* ATA-2 thingy */
                unsigned reserved456    : 3;
                unsigned HOB            : 1;    /* 48-bit address ordering */
        } b;
} control_t;

This is a new struct that is to be added for 48-bit addressing and it will
reflect drive->ctl soon.  I have not decided how to use it best or at all,
but it has meaning and once I add-in the real def of bit3 then I will not
need to look it up again.

Cheers,

Andre Hedrick
ASL Kernel Development
Linux ATA Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

On Thu, 28 Jun 2001, Gunther Mayer wrote:

> Andre Hedrick wrote:
> > 
> > It fixes a BUG in CFA, but what will it do to the other stuff?
> > Parse it exclusive to CFA and there is not an issue.
> ...
> > Not all ./arch have a control register doing this randomly without know the
> > rest of the driver will kill more than it fixes.
> > 
> 
> Thanks for pointing out this implementation bug. Although I fixed another problem
> in ide-cs, where ctl_base could eventually be 0.
> 
> I would rather not add a special hwif->is_pcmcia flag, as
> the control register (if it exists) is well defined
> (bit2=softreset bit1=nIEN, others reserved; however there is
>  a hardcoded value of 0x08 somewhere in the ide code?).
> 
> -
> Gunther
> 
> 
> 
> --- linux245.orig/drivers/ide/ide-cs.c  Fri Feb  9 20:40:02 2001
> +++ linux/drivers/ide/ide-cs.c  Thu Jun 28 18:04:27 2001
> @@ -42,6 +42,7 @@
>  #include <linux/ioport.h>
>  #include <linux/hdreg.h>
>  #include <linux/major.h>
> +#include <linux/ide.h>
>  
>  #include <asm/io.h>
>  #include <asm/system.h>
> @@ -223,6 +224,15 @@
>  #define CFG_CHECK(fn, args...) \
>  if (CardServices(fn, args) != 0) goto next_entry
>  
> +int idecs_register (int arg1, int arg2, int irq)
> +{
> +        hw_regs_t hw;
> +        ide_init_hwif_ports(&hw, (ide_ioreg_t) arg1, (ide_ioreg_t) arg2, NULL);
> +        hw.irq = irq;
> +        hw.chipset = ide_pci; // this enables IRQ sharing w/ PCI irqs
> +        return ide_register_hw(&hw, NULL);
> +}
> +
>  void ide_config(dev_link_t *link)
>  {
>      client_handle_t handle = link->handle;
> @@ -326,10 +336,12 @@
>  
>      /* retry registration in case device is still spinning up */
>      for (i = 0; i < 10; i++) {
> -       hd = ide_register(io_base, ctl_base, link->irq.AssignedIRQ);
> +       if(ctl_base) outb(0x02, ctl_base); // Set nIEN = disable device interrupts
> +       hd = idecs_register(io_base, ctl_base, link->irq.AssignedIRQ);
>         if (hd >= 0) break;
>         if (link->io.NumPorts1 == 0x20) {
> -           hd = ide_register(io_base+0x10, ctl_base+0x10,
> +           if(ctl_base) outb(0x02, ctl_base+0x10);
> +           hd = idecs_register(io_base+0x10, ctl_base+0x10,
>                               link->irq.AssignedIRQ);
>             if (hd >= 0) {
>                 io_base += 0x10; ctl_base += 0x10;
> --- linux245.orig/drivers/ide/ide-probe.c       Sun Mar 18 18:25:02 2001
> +++ linux/drivers/ide/ide-probe.c       Thu Jun 28 18:43:43 2001
> @@ -685,6 +685,9 @@
>  #else /* !CONFIG_IDEPCI_SHARE_IRQ */
>                 int sa = (hwif->chipset == ide_pci) ? SA_INTERRUPT|SA_SHIRQ : SA_INTERRUPT;
>  #endif /* CONFIG_IDEPCI_SHARE_IRQ */
> +
> +               if(hwif->io_ports[IDE_CONTROL_OFFSET])
> +                       OUT_BYTE(0x00, hwif->io_ports[IDE_CONTROL_OFFSET]); // clear nIEN == enable irqs
>                 if (ide_request_irq(hwif->irq, &ide_intr, sa, hwif->name, hwgroup)) {
>                         if (!match)
>                                 kfree(hwgroup);
> --- linux245.orig/drivers/ide/ide.c     Wed May  2 01:05:00 2001
> +++ linux/drivers/ide/ide.c     Thu Jun 28 18:04:42 2001
> @@ -2181,6 +2181,7 @@
>         memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->hw.io_ports));
>         hwif->irq = hw->irq;
>         hwif->noprobe = 0;
> +       hwif->chipset = hw->chipset;
>  
>         if (!initializing) {
>                 ide_probe_module();
> --- linux245.orig/include/linux/ide.h   Sat May 26 03:02:42 2001
> +++ linux/include/linux/ide.h   Thu Jun 28 18:18:05 2001
> @@ -226,6 +226,19 @@
>  #endif
>  
>  /*
> + * hwif_chipset_t is used to keep track of the specific hardware
> + * chipset used by each IDE interface, if known.
> + */
> +typedef enum {  ide_unknown,    ide_generic,    ide_pci,
> +                ide_cmd640,     ide_dtc2278,    ide_ali14xx,
> +                ide_qd6580,     ide_umc8672,    ide_ht6560b,
> +                ide_pdc4030,    ide_rz1000,     ide_trm290,
> +                ide_cmd646,     ide_cy82c693,   ide_4drives,
> +                ide_pmac
> +} hwif_chipset_t;
> +
> +
> +/*
>   * Structure to hold all information about the location of this port
>   */
>  typedef struct hw_regs_s {
> @@ -234,6 +247,7 @@
>         int             dma;                    /* our dma entry */
>         ide_ack_intr_t  *ack_intr;              /* acknowledge interrupt */
>         void            *priv;                  /* interface specific data */
> +       hwif_chipset_t  chipset;
>  } hw_regs_t;
>  
>  /*
> @@ -396,17 +410,6 @@
>  typedef void (ide_maskproc_t) (ide_drive_t *, int);
>  typedef void (ide_rw_proc_t) (ide_drive_t *, ide_dma_action_t);
>  
> -/*
> - * hwif_chipset_t is used to keep track of the specific hardware
> - * chipset used by each IDE interface, if known.
> - */
> -typedef enum { ide_unknown,    ide_generic,    ide_pci,
> -               ide_cmd640,     ide_dtc2278,    ide_ali14xx,
> -               ide_qd6580,     ide_umc8672,    ide_ht6560b,
> -               ide_pdc4030,    ide_rz1000,     ide_trm290,
> -               ide_cmd646,     ide_cy82c693,   ide_4drives,
> -               ide_pmac
> -} hwif_chipset_t;
>  
>  #ifdef CONFIG_BLK_DEV_IDEPCI
>  typedef struct ide_pci_devid_s {
> 


