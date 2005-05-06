Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVEJFZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVEJFZh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 01:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVEJFZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 01:25:35 -0400
Received: from alcazaba.unex.es ([158.49.151.6]:52198 "EHLO www.fcdyc.unex.es")
	by vger.kernel.org with ESMTP id S261560AbVEJFY2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 01:24:28 -0400
Message-ID: <20050506134121.onrx8ckym8wkg80w@158.49.151.11>
X-Priority: 3 (Normal)
Date: Fri, 06 May 2005 13:41:21 +0200
From: Manuel Perez Ayala <mperaya@alcazaba.unex.es>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: TG3 support broken on PPC (PowerMac G4)
References: <1104217668.41d10644a57f7@alcazaba.unex.es>
	<20041228102026.0ec40a5a.davem@davemloft.net>
In-Reply-To: <20041228102026.0ec40a5a.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Internet Messaging Program (IMP) H3 (4.0.3)
X-FCDyC-UEx-MailScanner: Found to be clean
X-FCDyC-UEx-MailScanner-From: mperaya@alcazaba.unex.es
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the kernel log from my machines:

tg3.c:v3.10 (September 14, 2004)
PCI: Enabling device 0001:10:13.0 (0014 -> 0016)
eth1: Tigon3 [partno(BCM95700A6) rev 7102 PHY(5401)] (PCI:33MHz:64-bit)
10/100/1000BaseT Ethernet 00:04:76:3b:51:ae
eth1: RXcsums[1] LinkChgREG[1] MIirq[1] ASF[0] Split[0] WireSpeed[0] TSOcap[0]


After a while finally I've found the code responsible of my problems:

On debian kernel 2.6.8 in the tg3.c file, at line 7356 (inside the 
tg3_test_dma
function) there are a conditional piece of code that compiles only if the
platform is NOT 386:

#ifndef CONFIG_X86
	{
		u8 byte;
		int cacheline_size;
		pci_read_config_byte(tp->pdev, PCI_CACHE_LINE_SIZE, &byte);

		if (byte == 0)
			cacheline_size = 1024;
		else
			cacheline_size = (int) byte * 4;

		switch (cacheline_size) {
		case 16:
		case 32:
		case 64:
		case 128:
			if ((tp->tg3_flags & TG3_FLAG_PCIX_MODE) &&
			    !(tp->tg3_flags2 & TG3_FLG2_PCI_EXPRESS)) {
				tp->dma_rwctrl |=
					DMA_RWCTRL_WRITE_BNDRY_384_PCIX;
				break;
			} else if (tp->tg3_flags2 & TG3_FLG2_PCI_EXPRESS) {
				tp->dma_rwctrl &=
					~(DMA_RWCTRL_PCI_WRITE_CMD);
				tp->dma_rwctrl |=
					DMA_RWCTRL_WRITE_BNDRY_128_PCIE;
				break;
			}
			/* fallthrough */
		case 256:
			if (!(tp->tg3_flags & TG3_FLAG_PCIX_MODE) &&
			    !(tp->tg3_flags2 & TG3_FLG2_PCI_EXPRESS))
				tp->dma_rwctrl |=
					DMA_RWCTRL_WRITE_BNDRY_256;
			else if (!(tp->tg3_flags2 & TG3_FLG2_PCI_EXPRESS))
				tp->dma_rwctrl |=
					DMA_RWCTRL_WRITE_BNDRY_256_PCIX;
		};
	}
#endif


This has changed from version 2.6.7 (also Debian dist). At line 6964 
(inside the
same function) was:

#ifndef CONFIG_X86
	{
		u8 byte;
		int cacheline_size;
		pci_read_config_byte(tp->pdev, PCI_CACHE_LINE_SIZE, &byte);

		if (byte == 0)
			cacheline_size = 1024;
		else
			cacheline_size = (int) byte * 4;

		tp->dma_rwctrl &= ~(DMA_RWCTRL_READ_BNDRY_MASK |
				    DMA_RWCTRL_WRITE_BNDRY_MASK);

		switch (cacheline_size) {
		case 16:
			tp->dma_rwctrl |=
				(DMA_RWCTRL_READ_BNDRY_16 |
				 DMA_RWCTRL_WRITE_BNDRY_16);
			break;

		case 32:
			tp->dma_rwctrl |=
				(DMA_RWCTRL_READ_BNDRY_32 |
				 DMA_RWCTRL_WRITE_BNDRY_32);
			break;

		case 64:
			tp->dma_rwctrl |=
				(DMA_RWCTRL_READ_BNDRY_64 |
				 DMA_RWCTRL_WRITE_BNDRY_64);
			break;

		case 128:
			tp->dma_rwctrl |=
				(DMA_RWCTRL_READ_BNDRY_128 |
				 DMA_RWCTRL_WRITE_BNDRY_128);
			break;

		case 256:
			tp->dma_rwctrl |=
				(DMA_RWCTRL_READ_BNDRY_256 |
				 DMA_RWCTRL_WRITE_BNDRY_256);
			break;

		case 512:
			tp->dma_rwctrl |=
				(DMA_RWCTRL_READ_BNDRY_512 |
				 DMA_RWCTRL_WRITE_BNDRY_512);
			break;

		case 1024:
			tp->dma_rwctrl |=
				(DMA_RWCTRL_READ_BNDRY_1024 |
				 DMA_RWCTRL_WRITE_BNDRY_1024);
			break;
		};
	}
#endif


If I replace the 2.6.8 piece of code with the 2.6.7 one and compile the 
code, it
seems to work without problems of data corruption.

Perhaps is there a better solution adding or modifiyng only certain 2.6.8 code
to make the thinks works, but this works for me.

Feel free to sugest anything about I could try and I will send you any report
about it.


----------
Manuel Perez Ayala
mperaya@alcazaba.unex.es
Facultad de Biblioteconomía y Documentación
Universidad de Extremadura


"David S. Miller" <davem@davemloft.net> ha escrito:

> On Tue, 28 Dec 2004 08:07:48 +0100
> Manuel Perez Ayala <mperaya@alcazaba.unex.es> wrote:
>
>> Disconnecting: Corrupted MAC on input.
>> lost connection
>
> That message is from ssh, and it indicates data corruption
> on the TCP connection.
>
> I have a similar report on x86_64 from Alan Cox.  What does
> the kernel say when the module is loaded?  In particular
> the lines from the kernel logs which describe the exact tg3
> chip revision.
>


