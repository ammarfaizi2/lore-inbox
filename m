Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbQLFPWD>; Wed, 6 Dec 2000 10:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130200AbQLFPVx>; Wed, 6 Dec 2000 10:21:53 -0500
Received: from zmamail03.zma.compaq.com ([161.114.64.103]:3081 "HELO
	zmamail03.zma.compaq.com") by vger.kernel.org with SMTP
	id <S129408AbQLFPVk>; Wed, 6 Dec 2000 10:21:40 -0500
Date: Wed, 6 Dec 2000 09:51:07 -0500 (EST)
From: Phillip Ezolt <ezolt@perf.zko.dec.com>
To: Jay Estabrook <Jay.Estabrook@compaq.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Andrea Arcangeli <andrea@suse.de>, rth@twiddle.net,
        linux-kernel@vger.kernel.org, wcarr@perf.zko.dec.com
Subject: Re: Alpha SCSI error on 2.4.0-test11
In-Reply-To: <20001205190653.A1031@linux04.mro.cpqcorp.net>
Message-ID: <Pine.OSF.3.96.1001206095025.32027B-100000@perf.zko.dec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay,
	You're a genius.  That works like a charm.  

Thanks so much!

--Phil

Compaq:  High Performance Server Division/Benchmark Performance Engineering 
---------------- Alpha, The Fastest Processor on Earth --------------------
Phillip.Ezolt@compaq.com        |C|O|M|P|A|Q|        ezolt@perf.zko.dec.com
------------------- See the results at www.spec.org -----------------------

On Tue, 5 Dec 2000, Jay Estabrook wrote:

> On Mon, Dec 04, 2000 at 01:53:42PM -0500, Phillip Ezolt wrote:
> >
> > 	I've recompiled as you have suggested.  Any ideas? 
> 
> Compile again with the following patches (these are against 2.4.0-test12,
> but those in arch/alpha/kernel/core_cia.c should work against test10/11
> as well). 
> 
> Something got lost between 2.2 and 2.4, but it's most likely that
> MIATA (because it has 6 DIMM slots) is one of the few CIA and PYXIS
> machines that could actually get over 1GB of memory; that's why we
> haven't seen this before...
> 
> --Jay++
> 
> -----------------------------------------------------------------------------
> Jay A Estabrook                            Alpha Engineering - LINUX Project
> Compaq Computer Corp. - MRO1-2/K20         (508) 467-2080
> 200 Forest Street, Marlboro MA 01752       Jay.Estabrook@compaq.com
> -----------------------------------------------------------------------------
> 
> diff -urN old/arch/alpha/kernel/core_cia.c new/arch/alpha/kernel/core_cia.c
> --- old/arch/alpha/kernel/core_cia.c    Tue Dec  5 10:09:01 2000
> +++ new/arch/alpha/kernel/core_cia.c    Tue Dec  5 18:45:12 2000
> @@ -700,11 +700,11 @@
>  
>         *(vip)CIA_IOC_PCI_W1_BASE = 0x40000000 | 1;
>         *(vip)CIA_IOC_PCI_W1_MASK = (0x40000000 - 1) & 0xfff00000;
> -       *(vip)CIA_IOC_PCI_T1_BASE = 0;
> +       *(vip)CIA_IOC_PCI_T1_BASE = 0 >> 2;
>  
>         *(vip)CIA_IOC_PCI_W2_BASE = 0x80000000 | 1;
>         *(vip)CIA_IOC_PCI_W2_MASK = (0x40000000 - 1) & 0xfff00000;
> -       *(vip)CIA_IOC_PCI_T2_BASE = 0x40000000;
> +       *(vip)CIA_IOC_PCI_T2_BASE = 0x40000000 >> 2;
>  
>         *(vip)CIA_IOC_PCI_W3_BASE = 0;
>  }
> diff -urN old/arch/alpha/kernel/pci.c new/arch/alpha/kernel/pci.c
> --- old/arch/alpha/kernel/pci.c Tue Dec  5 10:09:01 2000
> +++ new/arch/alpha/kernel/pci.c Tue Dec  5 10:20:01 2000
> @@ -91,9 +91,15 @@
>         if (dev->class >> 8 != PCI_CLASS_STORAGE_IDE)
>                 return;
>         dev->resource[1].start |= 2;
> -       dev->resource[1].end = dev->resource[1].start;
> +       dev->resource[1].end = dev->resource[1].start + 1;
> +#ifndef CONFIG_BLK_DEV_IDEPCI
> +       /* already claimed by "standard" (ie junk) resources */
> +       dev->resource[0].flags &= ~IORESOURCE_IO;
> +       dev->resource[1].flags &= ~IORESOURCE_IO;
> +#else
>         pci_claim_resource(dev, 0);
>         pci_claim_resource(dev, 1);
> +#endif
>  }
>  
>  static void __init
> diff -urN old/drivers/pci/pci.c new/drivers/pci/pci.c
> --- old/drivers/pci/pci.c       Tue Dec  5 10:09:02 2000
> +++ new/drivers/pci/pci.c       Tue Dec  5 10:17:32 2000
> @@ -540,7 +540,7 @@
>  static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
>  {
>         unsigned int pos, reg, next;
> -       u32 l, sz;
> +       u32 l, sz, tmp;
>         struct resource *res;
>  
>         for(pos=0; pos<howmany; pos = next) {
> -----------------------------------------------------------------------------
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
