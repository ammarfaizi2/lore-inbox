Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263087AbTCWR3Y>; Sun, 23 Mar 2003 12:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263129AbTCWR3Y>; Sun, 23 Mar 2003 12:29:24 -0500
Received: from AMarseille-201-1-1-164.abo.wanadoo.fr ([193.252.38.164]:49193
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S263087AbTCWR3X>; Sun, 23 Mar 2003 12:29:23 -0500
Subject: Re: Need help for pci driver on powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Jaeger <christian.jaeger@ethlife.ethz.ch>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030323171955Z263126-25575+35740@vger.kernel.org>
References: <20030323171955Z263126-25575+35740@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048441282.582.5.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 23 Mar 2003 18:41:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-23 at 18:30, Christian Jaeger wrote:
> Hello
> 
> Somehow I can't access a PCI card on a PowerMac.  I once wrote a
> driver for this card on MacOS8, but that does not seem to help me so
> far.
> 
> It's a digital I/O card Computer Boards PCI-DIO96H showing this info
> in lspci -vvn:
> 
> 00:0e.0 Class ffff: 1307:0017 (rev 02) (prog-if ff)
>         Subsystem: 1307:0017
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin A routed to IRQ 24
>         Region 1: I/O ports at 0800 [disabled] [size=128]
>         Region 2: I/O ports at 0880 [disabled] [size=16]
> 
> This is what I am doing (irrelevant parts stripped):
>     error= pci_enable_device(mydevicep);
>     mybase1_phys= pci_resource_start(dev, 2);
>     mybase1length= pci_resource_len(dev,2);
>     // gives: address 0x00000880, len 16
>     error = pci_request_regions (dev, NAME);
>     pci_set_master (dev);
>     mybase1= (unsigned long)ioremap(mybase1_phys,mybase1length);
>     // gives: 0, while the following is printed to the kernel log:
>     // __ioremap(): phys addr 0 is RAM lr c0010c34

According to lspci output, the resources for your card are of type
"IO", not "memory". You use ioremap only for the later.
If you are not sure about the resource type, look at the resource
flags.

So instead of using ioremap along with {read,write}{b,w,l} accessors,
use the output of pci_resource_start() directly with {in,out}{b,w,l}
(and eventually {in,out}s{w,l} for non-byteswapped "stream" access).

Ben.

