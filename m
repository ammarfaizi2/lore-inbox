Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283012AbSAEUou>; Sat, 5 Jan 2002 15:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283259AbSAEUol>; Sat, 5 Jan 2002 15:44:41 -0500
Received: from doninha.ip.pt ([195.23.132.12]:42758 "HELO doninha.ip.pt")
	by vger.kernel.org with SMTP id <S283012AbSAEUob>;
	Sat, 5 Jan 2002 15:44:31 -0500
Date: Sat, 5 Jan 2002 20:44:27 +0000 (WET)
From: Rui Sousa <rui.p.m.sousa@clix.pt>
X-X-Sender: <rsousa@localhost.localdomain>
To: Vladimir Dergachev <volodya@mindspring.com>
cc: <linux-kernel@vger.kernel.org>, <emu10k1-devel@opensource.creative.com>
Subject: Re: HIGHMEM and DMA (emu10k1 related)
In-Reply-To: <Pine.LNX.4.20.0201050730180.17212-100000@node2.localnet.net>
Message-ID: <Pine.LNX.4.33.0201052030080.1985-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jan 2002, Vladimir Dergachev wrote:

> 
> This might not be immediately relevant but I saw a similar issue with
> Radeon DMA engine. What was happenning is that the card has an internal
> memory controller which was misconfigured. So it was not "seeing" certain
> physical pages. The problem manifested in pages of data filled with 0's.
> Also it was often that it worked fine right after boot but became slowly
> screwed up as memory was getting more fragmented.
> 
> So I think what happens is that your cards idea of pci addressable memory
> goes awry with the pages you get from kernel.

As I mentioned before the bus addresses for the pages I allocate are (as
expected) always in the same memory range. The only difference is that 
if the kernel was compiled with HIGHMEM support the sound card sometimes
doesn't read the correct values.

> Try printing out the
> addresses and checking whether there is any pattern.

No pattern. In fact if I start/stop the sound application (with a mainly idle machine)
I usually end up allocating the same memory pages. The first couple of 
times it works as expected and then the card starts reading some bogus values.

> Also (probably you
> did that already) check linux/Documentation/  for new PCI functions..

I'm already using pci_set_dma_mask and pci_alloc/free_consistent.

>                              Vladimir Dergachev


Rui Sousa

> On Sat, 5 Jan 2002, Rui Sousa wrote:
> 
> > 
> > Hi,
> > 
> > Lately, there have been reports of problems when using
> > the emu10k1 driver and a kernel compiled with HIGHMEM support.
> > I finally managed to observe the problem myself and basically this 
> > e-mail is a request for help to try and solve this.
> > 
> > 1. The problem is only observed when using a kernel compiled with 
> > HIGHMEM support, even if actual RAM available is less than 1GiB 
> > (192MiB in my case).
> > 
> > 2. The emu10k1 uses DMA to get sound data from host memory.
> > 
> > 3. DMA memory is allocated with pci_alloc_consistent (in 
> > PAGE_SIZE blocks).
> > 
> > 4. The emu10k1 reads some bytes from host memory and caches them 
> > locally (up to 128 bytes). These can then be read back through PCI IO 
> > registers (using inl()).
> > 
> > 5. When I compare the values in host memory to the ones read by the card
> > _some times_ they are different (all of the 128 bytes read). The values
> > read by the card are usually zero when this happens.
> > 
> > 6. Once the problem starts if I start/stop the same sound application
> > (freeing and then allocating the same DMA memory pages) the problem
> > persists. If I stop the application, start another one (with a 
> > different buffer usually allocating more memory), stop it, go
> > back to the initial one, the problem is gone.
> > 
> > 
> > At the hardware level what is the difference between a kernel with 
> > HIGHMEM support and one without? I see that the physical/virtual 
> > addresses of the pages obtained with pci_alloc_consistent are within
> > the same range... 
> > 
> > If it's a bug in the driver why would it only show up some times and
> > only if HIGHMEM support is enabled?
> > 
> > Thanks for any help,
> > Rui Sousa
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> 

