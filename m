Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272533AbTHEQYE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 12:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272536AbTHEQYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 12:24:03 -0400
Received: from 224.Red-217-125-129.pooles.rima-tde.net ([217.125.129.224]:43249
	"HELO cocodriloo.com") by vger.kernel.org with SMTP id S272533AbTHEQX7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 12:23:59 -0400
Date: Tue, 5 Aug 2003 18:23:31 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: [Q] Question about memory access
Message-ID: <20030805162331.GC814@wind.cocodriloo.com>
References: <00a001c35a58$02c20f00$a5a5f88f@core8fyzomwjks> <1059989725.392.2.camel@sherbert> <20030804161846.GA814@wind.cocodriloo.com> <20030805001303.GB27191@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805001303.GB27191@pegasys.ws>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 05:13:04PM -0700, jw schultz wrote:
> On Mon, Aug 04, 2003 at 06:18:46PM +0200, Antonio Vargas wrote:
> > On Mon, Aug 04, 2003 at 10:35:25AM +0100, Gianni Tedesco wrote:
> > > On Mon, 2003-08-04 at 08:14, Cho, joon-woo wrote:
> > > > If someone want to transfer large data from some device to memory, he may
> > > > use DMA method.
> > > > 
> > > > At this point, i am confused.
> > > > 
> > > > I think that only one process can access physical memory(RAM) at a time.
> > > 
> > > The DMA controller is a dedicated piece of hardware that copies the data
> > > from devices to RAM. This means that other processes can use the CPU
> > > while the DMA is in progress. That is the whole point of DMA.
> > 
> > Yes, this is called having 2 bus masters, which are the chips that
> > can use the bus to read and write to memory. What can be done is to
> > timeshare the bus, for example the cpu accesses memory on odd cycles
> > and the dma chip does on even cycles.
> > 
> > A more complex design would allow the cpu to access memory on all
> > cycles, but give the dma chip more priority. This would mean that
> > a dma transfer would take priority over the cpu. Think about
> > a sound card reading the sound data to pump it to the speakers,
> > you would prefer not to have it skip.
> 
> A few of things to ponder:
> 
> 	Multiple CPUs may share the same memory.
> 
> 	CPUs mostly access memory in burst mode to fill
> 	cache lines (usually 32 bytes) so once the
> 	memory begins transfer it can pump at buss speed.
> 
> 	CPU-to-memory buss is clocked at speeds of
> 	100MHz and above.  Most newer Intel boxes have the
> 	memory bus clocked at 133MHz and may use DDR which
> 	allows transfers at double the clock rate.  That is
> 	~1064BG/s (less access initialisation time)
> 
> 	Devices on the PCI buss are limited to the PCI bus
> 	speed which is typically 33 or 66 MHz.  This limits
> 	DMA transfers to about 120 or 240 MB/s.  So Even if
> 	you saturate the PCI buss there are still a lot of
> 	memory buss cycles left.
> 
> 	Few devices are capable of saturating the PCI buss.
> 	In theory a medium to large RAID array could do it.
> 	Combining multiple Gbit NICs and RAID arrays would
> 	do it in practice under the right kind of loads.
> 
> 	Access to the memory buss is arbitrated by a bridge
> 	chipset (sometimes called "North Bridge") between
> 	CPU, memory, AGP and other bridges.  The PCI buss
> 	bridge may packetise (for lack of a better word) a
> 	DMA transfer into multiple short bursts which
> 	will be fed to the North Bridge at memory buss
> 	speeds.
> 
> The days of interleaving DMA with CPU at the cycle level or
> stalling the CPU or other device are long gone.  It is
> pretty much all done in bursts mediated by a bridge
> functioning as a memory controller.

Now I understand the fuss about northbridge speeds
on motherboard reviews :)

Anyways, if the memory is not connected directly to the cpu but
to an intermediate controller, this controller is in fact stalling
the cpu memory access when he prefers to give this memory cycle
to the pci devices. The fact that the communication between, say,
cpu and memory controller can ask for burst read/write doesn't
mean that in a heavy loaded system such as an SMP, some accesses
will be stalled because another device needs it earlier.

My background on DMA programming come from Amiga and Gameboy systems,
this may explain this "long gone"-style example.

Greets, Antonio.

-- 

1. Dado un programa, siempre tiene al menos un fallo.
2. Dadas varias lineas de codigo, siempre se pueden acortar a menos lineas.
3. Por induccion, todos los programas se pueden
   reducir a una linea que no funciona.
