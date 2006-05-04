Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWEDHuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWEDHuL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 03:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWEDHuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 03:50:10 -0400
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154]:25780 "EHLO
	pne-smtpout4-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751433AbWEDHuJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 03:50:09 -0400
From: Jani-Matti =?iso-8859-1?q?H=E4tinen?= <jani-matti.hatinen@iki.fi>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: Lock-up with modprobe sdhci after suspending to ram
Date: Thu, 4 May 2006 09:57:30 +0300
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <515ed10f0604240033i71781bfdp421ed244477fd200@mail.gmail.com> <200604251645.58421.jani-matti.hatinen@iki.fi> <44538581.50608@drzeus.cx>
In-Reply-To: <44538581.50608@drzeus.cx>
X-Face: #cyYMAd}qudd3k4*S6mac8z1vRgtwXAC'7r{jv<~p5y80oOWqj0)0~/;,QeB(P>fhDJ"=?iso-8859-1?q?lF=0A=09=7D-ls=26?="0:\(7!/S)a_ew$J?hey[-+u`<VOlVBz48@)SW{u#N=v1P~`\Cd9^zw[>=?iso-8859-1?q?Z=607l=26XK=24=0A=09Deyz7Uf=5Dx?=@r"kOgh|l?F~QrgBEd<$x`a)[]1C"NqvG<T3Gk"@_,cH7Q;HTlZgb*F>VR(=?iso-8859-1?q?3j=0A=09=5ByC?=>>hR;jXQ!K/Q]*HjPibvm_33AQC_N2Z$VnZ<=?iso-8859-1?q?gy*4-QB2q=3A=5BoZ=2E-8YNsF+WK=27ya6u/!J=0A=09-4g=3B?=
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200605040957.30758.jani-matti.hatinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman kirjoitti viestissään (lähetysaika lauantai, 29. huhtikuuta 2006 
18:25):
> Jani-Matti Hätinen wrote:
> > Ok, this is what I get on Loglevel 9.
> > And if I modprobe sdhci after suspend&resume I get the following:
> >   First from the modprobe (not all of it is visible):
> > sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
> > sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
> > sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
> > sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
> > sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
> > sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
> > sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
> > sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
> > sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
> > sdhci: Caps:     0xffffffff | Max curr: 0xffffffff
> > sdhci: ===========================================
>
> Now this is horribly broken and would explain why things go south. I
> guess the chip needs a reset early in the detection sequence to function
> properly. Try putting:
>
>     sdhci_reset(host, SDHCI_RESET_ALL);
>
> just before the driver does a readl() on the capabilities register (in
> sdhci_probe_slot()).

Sorry for the delay.
  I tried that with 2.6.17-rc3, but it doesn't seem to have any effect. The 
register values stay the same.

> >   Also I just noticed that if the machine has been through at least one
> > suspend&resume cycle, rebooting no longer works. All processes exit
> > cleanly, but the system just hangs when it should shut down.
>
> That's just probably a broken ACPI. Laptops tend to be buggy as hell.
> File a report with the ACPI guys.

I'm not sure if this has any effect on the sdhci issue, but during a normal 
suspend&resume (i.e. when sdhci has been rmmoded earlier) I get the following 
error about the PCMCIA CardBus slot, which is on the same PCI channel as the 
card reader (01:03.0 and 01:03.2 respectively):

May  4 09:37:38 leevi PCMCIA: socket c14d8828: *** DANGER *** unable to remove 
socket power

And the PCMCIA slot doesn't work either after a suspend&resume. I haven't 
tested FireWire yet (which is also on the same PCI channel 01:03.1), but I 
will shortly.

-- 
Jani-Matti Hätinen
