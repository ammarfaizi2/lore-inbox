Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286968AbRL1SOB>; Fri, 28 Dec 2001 13:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286961AbRL1SNw>; Fri, 28 Dec 2001 13:13:52 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:30983
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S286963AbRL1SNl>; Fri, 28 Dec 2001 13:13:41 -0500
Date: Fri, 28 Dec 2001 10:11:52 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: 2.5.1-p1 (Re: patch-2.4.15: Fix CompactFlash+PCMCIA+PCI system freeze
 (Resend)) (fwd)
Message-ID: <Pine.LNX.4.10.10112281002240.24491-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Funny but I find it strange this did not end up on LKML, and I did
submit a patch prior to BIO release but you never got it.

To bad you never saw it and I know for a fact that I discussed all of
these issue w/ out before BIO and even asked you to explain all the BIO
stuff ahead of time for the off chance that BIO entered first.

Feel free to call BS on this but you and I know it is true as do a much if
people IRC'ng.

I removed the patches because VGER may have eaten the message because of
them.

Regards,

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project

---------- Forwarded message ----------
Date: Sun, 25 Nov 2001 13:27:32 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Gunther Mayer <Gunther.Mayer@t-online.de>
Cc: linux-kernel@vger.kernel.org, dhinds@zen.stanford.edu,
     marcelo@conectiva.com.br, torvalds@transmeta.com, fred@pont.net
Subject: 2.5.1-p1 (Re: patch-2.4.15: Fix CompactFlash+PCMCIA+PCI system freeze
    (Resend))


I have it prepped to submit for 2.5.1-p1, additionally it is adopted in
the 

This is a "safety patch" similar to the contents in the 2.4.13-ac6 patch.
It uses the legacy data path for now.  It is in a form that is accpetable
to be used in 2.4.X.  Upon a few more tests the legacy data patch will be
toggled out and the later removed.

The classic CDB model adopted in the SCSI SCB is now translated into the
ACB (ATA Command Block).  This is completely based on the updated state
diagrams in the soon to be adopted ATA/ATAPI-6 document, which is
currently under review and held in a letter ballot vote.  Once approved it
shall be submitted to NCITS/ANSI for radification and the new standard for
the industry.

The significance to this model change is to create the core library for
the evolving personalities drivers.  Since there a movement to separate
the physical layer from the transport layer, which will effect all legacy
host-os-drivers, the adoption if the memory struct model is essentail.

Future HOST-Controllers will no longer support IO mapped IO in the lower
BAR registers, specifically BAR 0,1,2,3.  BAR 4 will evolve to a complete
MMIO and may be extended to mask BAR 5.  The rational for this transition
is to support local and remote memory access across the now ATA-Bridge.
The means that all transfers will be of PCI-DMA regards of data-phase
operations on the HOST-Device side of the Bridge.  Translation of of the
goop above -- all transfers are DMA (across the PCI BUS), but on the
other side they are parsed by the hardware and handled completely on their
own.

In conclusion to the file called "ide-taskfile.c", it will be the bases
for keeping support for the legacy IOMIO hardware of today in complete
support and absolutely correct to the transport layer ruleset.  The new
IOCTL that must be complied in at this time to use, shall provide the
means to isolate potential problems in the top-layer of the driver
re-write.  It is absolutely essentail to have a means to test the data on
the platters w/o the need of a filesystem; otherwise, the chasing down of
micro races could be extremely difficult.

One of the final issues address in the enclosed patch is the
infrastructure for inclusion of SerialATA's "First Party DMA" transport
layer.  This method is similar in the USB 2.X CDB, but more flexable.

Request for adoption in the release of 2.5.1-pre2 is formally submitted.

Respectfully,

Andre Hedrick
Linux ATA Development


On Sun, 25 Nov 2001, Gunther Mayer wrote:

> Hi,
> 
> this patch is nedded to prevent system freeze on
> inserting a CompactFlash (or any other ATA) card
> into a PCMCIA-PCI adapter card !
> 
> The IDE maintainer (Andre) agreed with the patch but didn't submit
> since the August thread .
> 
> So he must be bypassed !!!
> 
> Thanks David for integrating the minimal one-liner patch (i.e. non-freeze)
> to pcmcia-cs-3.1.30. For proper working we must tell the ide subsystem
> it is OK to share IRQ (which is mandatory for PCI), this takes some
> trivial lines to fix the API in the ide subsystem (about "chipset"s).
> 
> Regards, Gunther
> 
> 
> 
> diff -ur linux-2.4.15.orig/drivers/ide/ide-cs.c linux/drivers/ide/ide-cs.c
> --- linux-2.4.15.orig/drivers/ide/ide-cs.c      Sun Sep 30 21:26:05 2001
> +++ linux/drivers/ide/ide-cs.c  Sun Nov 25 13:11:36 2001
> @@ -42,6 +42,7 @@
>  #include <linux/ioport.h>
>  #include <linux/hdreg.h>
>  #include <linux/major.h>
> +#include <linux/ide.h>
>  
>  #include <asm/io.h>
>  #include <asm/system.h>
> @@ -226,6 +227,16 @@
>  #define CFG_CHECK(fn, args...) \
>  if (CardServices(fn, args) != 0) goto next_entry
>  
> +int idecs_register (int io_base, int ctl_base, int irq)
> +{
> +        hw_regs_t hw;
> +        ide_init_hwif_ports(&hw, (ide_ioreg_t) io_base, (ide_ioreg_t) ctl_base, NULL);
> +        hw.irq = irq;
> +        hw.chipset = ide_pci; // this enables IRQ sharing w/ PCI irqs
> +        return ide_register_hw(&hw, NULL);
> +}
> +
> +
>  void ide_config(dev_link_t *link)
>  {
>      client_handle_t handle = link->handle;
> @@ -327,12 +338,16 @@
>      if (link->io.NumPorts2)
>         release_region(link->io.BasePort2, link->io.NumPorts2);
>  
> +    /* disable drive interrupts during IDE probe */
> +    if(ctl_base)
> +       outb(0x02, ctl_base);
> +
>      /* retry registration in case device is still spinning up */
>      for (i = 0; i < 10; i++) {
> -       hd = ide_register(io_base, ctl_base, link->irq.AssignedIRQ);
> +       hd = idecs_register(io_base, ctl_base, link->irq.AssignedIRQ);
>         if (hd >= 0) break;
>         if (link->io.NumPorts1 == 0x20) {
> -           hd = ide_register(io_base+0x10, ctl_base+0x10,
> +           hd = idecs_register(io_base+0x10, ctl_base+0x10,
>                               link->irq.AssignedIRQ);
>             if (hd >= 0) {
>                 io_base += 0x10; ctl_base += 0x10;
> Only in linux/drivers/ide: ide-cs.c-2415
> diff -ur linux-2.4.15.orig/drivers/ide/ide.c linux/drivers/ide/ide.c
> --- linux-2.4.15.orig/drivers/ide/ide.c Thu Oct 25 22:58:35 2001
> +++ linux/drivers/ide/ide.c     Sun Nov 25 13:02:34 2001
> @@ -2293,6 +2293,7 @@
>         memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->hw.io_ports));
>         hwif->irq = hw->irq;
>         hwif->noprobe = 0;
> +       hwif->chipset = hw->chipset;
>  
>         if (!initializing) {
>                 ide_probe_module();
> diff -ur linux-2.4.15.orig/include/linux/ide.h linux/include/linux/ide.h
> --- linux-2.4.15.orig/include/linux/ide.h       Thu Nov 22 20:48:07 2001
> +++ linux/include/linux/ide.h   Sun Nov 25 13:05:57 2001
> @@ -223,6 +223,23 @@
>  #endif
>  
>  /*
> + * hwif_chipset_t is used to keep track of the specific hardware
> + * chipset used by each IDE interface, if known.
> + */
> +typedef enum {  ide_unknown,    ide_generic,    ide_pci,
> +                ide_cmd640,     ide_dtc2278,    ide_ali14xx,
> +                ide_qd65xx,     ide_umc8672,    ide_ht6560b,
> +                ide_pdc4030,    ide_rz1000,     ide_trm290,
> +                ide_cmd646,     ide_cy82c693,   ide_4drives,
> +                ide_pmac,       ide_etrax100
> +} hwif_chipset_t;
> +
> +#define IDE_CHIPSET_PCI_MASK    \
> +    ((1<<ide_pci)|(1<<ide_cmd646)|(1<<ide_ali14xx))
> +#define IDE_CHIPSET_IS_PCI(c)   ((IDE_CHIPSET_PCI_MASK >> (c)) & 1)
> +
> +
> +/*
>   * Structure to hold all information about the location of this port
>   */
>  typedef struct hw_regs_s {
> @@ -231,6 +248,7 @@
>         int             dma;                    /* our dma entry */
>         ide_ack_intr_t  *ack_intr;              /* acknowledge interrupt */
>         void            *priv;                  /* interface specific data */
> +       hwif_chipset_t  chipset;
>  } hw_regs_t;
>  
>  /*
> @@ -439,22 +457,6 @@
>   * ide soft-power support
>   */
>  typedef int (ide_busproc_t) (struct hwif_s *, int);
> -
> -/*
> - * hwif_chipset_t is used to keep track of the specific hardware
> - * chipset used by each IDE interface, if known.
> - */
> -typedef enum { ide_unknown,    ide_generic,    ide_pci,
> -               ide_cmd640,     ide_dtc2278,    ide_ali14xx,
> -               ide_qd65xx,     ide_umc8672,    ide_ht6560b,
> -               ide_pdc4030,    ide_rz1000,     ide_trm290,
> -               ide_cmd646,     ide_cy82c693,   ide_4drives,
> -               ide_pmac,       ide_etrax100
> -} hwif_chipset_t;
> -
> -#define IDE_CHIPSET_PCI_MASK   \
> -    ((1<<ide_pci)|(1<<ide_cmd646)|(1<<ide_ali14xx))
> -#define IDE_CHIPSET_IS_PCI(c)  ((IDE_CHIPSET_PCI_MASK >> (c)) & 1)
>  
>  #ifdef CONFIG_BLK_DEV_IDEPCI
>  typedef struct ide_pci_devid_s {



