Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267014AbSL3RdO>; Mon, 30 Dec 2002 12:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267015AbSL3RdO>; Mon, 30 Dec 2002 12:33:14 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:45697
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267014AbSL3RdN>; Mon, 30 Dec 2002 12:33:13 -0500
Subject: Re: Micron Samurai chipset in 2.4.x (ide-pci.c)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephen Brown <sbrown7@umbc.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L.01.0212301138290.2383-100000@linux3.gl.umbc.edu>
References: <Pine.LNX.4.44L.01.0212301138290.2383-100000@linux3.gl.umbc.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Dec 2002 18:22:59 +0000
Message-Id: <1041272579.13684.35.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-30 at 16:51, Stephen Brown wrote:
> 
> 00:19.1 IDE interface: Micron Samurai_IDE (prog-if 8f [Master SecP SecO PriP PriO])
> 	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 	Interrupt: pin A routed to IRQ 0
> 	Region 0: I/O ports at fca0 [disabled] [size=8]
> 	Region 1: I/O ports at fca8 [disabled] [size=8]
> 	Region 2: I/O ports at fcb0 [disabled] [size=8]
> 	Region 3: I/O ports at fcb8 [disabled] [size=8]
> 	Region 4: I/O ports at fcc0 [disabled] [size=16]

We found the device and being overly smart tried to enable it. Trouble
is on IBM thinkpad docking stations this is the right thing to do with
the on board controllers 8(, in the case of the generic dma it may well
not be.

Ok can you try the following checks to decide when to skip. In
generic_init_one add some code to do:

	u16 cmd;

	pci_read_config_word(dev, PCI_COMMAND, &cmd);

	if(!(cmd & PCI_COMMAND_IO))
	{
		printk(KERN_INFO "Skipping disabled %s controller.\n",
			d->name);
		return 1;
	}

That will mean we enable PCI controllers we know about specifically but
not generic PCI bus masters. If that turns out to be too conservative
then adding a flag per controller can always be done.

Alan
	
