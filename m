Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318026AbSHCX2y>; Sat, 3 Aug 2002 19:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318027AbSHCX2x>; Sat, 3 Aug 2002 19:28:53 -0400
Received: from p032.as-l031.contactel.cz ([212.65.234.224]:38016 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S318026AbSHCX2w>;
	Sat, 3 Aug 2002 19:28:52 -0400
Date: Sun, 4 Aug 2002 01:27:05 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Pawel Kot <pkot@linuxnews.pl>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: No Subject
Message-ID: <20020803232705.GB30729@ppc.vc.cvut.cz>
References: <Pine.SOL.4.30.0208040010520.696-100000@mion.elka.pw.edu.pl> <1028417880.1760.52.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1028417880.1760.52.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2002 at 12:38:00AM +0100, Alan Cox wrote:
> On Sat, 2002-08-03 at 23:16, Bartlomiej Zolnierkiewicz wrote:
> > Just rethough it. What if chipset is in compatibility mode?
> > Like VIA with base addresses set to 0?
> 
> If we found a register that was marked as unassigned with a size then we
> would map it to a PCI address. That would go for BAR0-3 on any PCI IDE
> device attached to the south bridge.
> 
> What problems does that cause for the VIA stuff ?

We must read PCI config register 9 (programming interface), and check its value.

If r9 & 0x05 == 0x05, we can program BARs. 

Otherwise if r9 & 0x0A != 0x0A, we must not touch hardware: it supports 
only legacy 0x1F0/0x170 assignment (PCI-IDE spec says that BAR0-BAR3
can be either hardwired to zero, or it can be writeable, but written
value must be ignored).

If r9 & 0x0A == 0x0A, we must write r9 | 0x05 to PCI config register 9,
and then (after verifying that write suceeded... it does not suceed
in VMware, for example...) we must (re)program BARs.

Worst problem is that (some) VIA chips have BAR0-BAR3 writeable,
but are programmed to ignore them by BIOS (as IRQ14/IRQ15 routing is
not available when in native mode). Current kernel code will believe
that device was relocated, but reality will be different, because of device
ignores BAR0-BAR3 value until programming interface is modified.
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz

