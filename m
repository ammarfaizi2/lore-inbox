Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267226AbSLKRoH>; Wed, 11 Dec 2002 12:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267236AbSLKRoH>; Wed, 11 Dec 2002 12:44:07 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:26779 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S267226AbSLKRoG>;
	Wed, 11 Dec 2002 12:44:06 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 11 Dec 2002 18:51:33 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Linux 2.4.21-pre1
Cc: lkml <linux-kernel@vger.kernel.org>, andre@linux-ide.org,
       ralf.hildebrandt@charite.de
X-mailer: Pegasus Mail v3.50
Message-ID: <A09B1892F30@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Dec 02 at 17:29, Alan Cox wrote:
> Ok this seems to be the problem
> 
> 00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02) (prog-if
> 8a [Master SecP PriP])
>         Subsystem: Toshiba America Info Systems: Unknown device 0001
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 11
>         Region 0: I/O ports at cff8 [size=8]
>         Region 1: I/O ports at cff4 [size=4]
>         Region 2: I/O ports at cfe8 [size=8]
>         Region 3: I/O ports at cfe4 [size=4]
> 
> 
> The hardware isnt at the normal ide base addresse, yet the chip is
> reporting that it isnt in native mode. As far as I can see this
> configuration isnt allowed.

An old, pre-BMDMA, "PCI IDE Controller Specification, rev 1.0, 3/4/94" 
I have here says on page 3, in chapter 2.4, second and third paragraphs say:
--
When a channel is in 'compatibility' mode, the controller can either 
disable the first four Base Address registers (i.e.; make them not 
writable and return 0's when read) or leave them fully programmable. In
either case the values in these registers are ignored as long as the 
channel is in 'compatibility' mode.

When a channel is in compatibility mode the IRQ used by the channel 
must be the 'compatibility' IRQ. PCI interrupt lines must not be effected 
by that channel's interrupt. Conversely, when the channel is in native-PCI 
mode the channel's interrupt should be connected to the appropriate INTx#. 
Compatibility IRQs should not be effected (i.e.; they should be tristated).
--

> We see that the chip isnt in native mode so we defer to the legacy
> scanner. Since the ports are not valid the legacy scanner doesn't find
> them.
> 
> Any thoughts on how we should handle this case Andre ?

We should ignore BARs (and reported INT#) when chip is not in native mode, 
but I'm sure that it breaks something else (note that I do not know any
chip which honors BARs when using compatible mode; only problematic piece
of hardware I know is PDC20265, but this one does not report itself
as IDE hardware, so for this chip we have special cases in the code already;
maybe VIA uses IRQ number specified in PCI config space instead of
14/15?).
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
