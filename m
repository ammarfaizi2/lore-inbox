Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272628AbRHaIAB>; Fri, 31 Aug 2001 04:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272630AbRHaH7w>; Fri, 31 Aug 2001 03:59:52 -0400
Received: from gnu.in-berlin.de ([192.109.42.4]:42764 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S272628AbRHaH7p>;
	Fri, 31 Aug 2001 03:59:45 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: kraxel
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: [UPDATE] 2.4.10-pre2 PCI64, API changes README
Date: 31 Aug 2001 07:22:11 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrn9ouep3.4d6.kraxel@bytesex.org>
In-Reply-To: <20010830.161453.130817352.davem@redhat.com> from "David S. Miller" at Aug 30, 2001 04:14:53 PM <E15cbGc-00027M-00@the-village.bc.nu>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 999242531 4602 127.0.0.1 (31 Aug 2001 07:22:11 GMT)
User-Agent: slrn/0.9.7.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > If mmap()'ing the frame buffer and passing this into read() is how
> > this will be done, it simply won't work.  That's the point I'm trying
> > to make.
>  
>  That isnt done anyway - the card executes a risc instruction set for the
>  DMA engine specifying which to skip and draw. So you feed it a base
>  physical address for the fb via ioctl (yes this needs to be a pci device
>  bar and offset I suspect) and then tell it about the fb layout and the like

current bttv tries to find a PCI device for the given physical address by
walking all PCI devices, then check whenever the address falls into one of the
dev->resource memory ranges.  Works fine on i386, but I'm not sure whenever
this works on other platforms, where phys == bus isn't true.

Right now it only sanity-checks the given physical address this way (see
below), but of course I could also pass the found pci_dev to some pci->pci
API.

What addresses are in dev->resource?  Physical?  Bus address?  Are they
unique?

  Gerd

---------------------------- cut here -------------------------
static int
find_videomem(unsigned long from, unsigned long to)
{
        struct pci_dev *dev = NULL;
        int i,match,found;

        found = 0;
        dprintk(KERN_DEBUG "bttv: checking video framebuffer address"
                " (%lx-%lx)\n",from,to);
        pci_for_each_dev(dev) {
                if (dev->class != PCI_CLASS_NOT_DEFINED_VGA &&
                    dev->class >> 16 != PCI_BASE_CLASS_DISPLAY)
                        continue;
                dprintk(KERN_DEBUG
                        "  pci display adapter %04x:%04x at %02x:%02x.%x\n",
                        dev->vendor,dev->device,dev->bus->number,
                        PCI_SLOT(dev->devfn),PCI_FUNC(dev->devfn));
                for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
                        if (!(dev->resource[i].flags & IORESOURCE_MEM))
                                continue;
                        if (dev->resource[i].flags & IORESOURCE_READONLY)
                                continue;
                        match = (from >= dev->resource[i].start) &&
                                (to-1 <= dev->resource[i].end);
                        if (match)
                                found = 1;
                        dprintk(KERN_DEBUG "    memory at %08lx-%08lx%s\n",
                                dev->resource[i].start,
                                dev->resource[i].end,
                                match ? "  (check passed)" : "");
                }
        }
        return found;
}
