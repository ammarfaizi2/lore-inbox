Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWD2PZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWD2PZf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 11:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWD2PZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 11:25:35 -0400
Received: from hermes.drzeus.cx ([193.12.253.7]:32667 "EHLO mail.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750739AbWD2PZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 11:25:35 -0400
Message-ID: <44538581.50608@drzeus.cx>
Date: Sat, 29 Apr 2006 17:25:53 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: "=?ISO-8859-1?Q?Jani-Matti_H=E4tinen?=" <jani-matti.hatinen@iki.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: Lock-up with modprobe sdhci after suspending to ram
References: <515ed10f0604240033i71781bfdp421ed244477fd200@mail.gmail.com> <200604251108.52515.jani-matti.hatinen@iki.fi> <444DE0E6.8090801@drzeus.cx> <200604251645.58421.jani-matti.hatinen@iki.fi>
In-Reply-To: <200604251645.58421.jani-matti.hatinen@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jani-Matti Hätinen wrote:
>
> Ok, this is what I get on Loglevel 9.
>   If I try to suspend with the module loaded and with a card in the reader I 
> get:
> Stopping tasks: ================================|
> ipw2200: Failed to send CARD_DISABLE: Command timed out
> ACPI: PCI interrupt for device 0000:01:05.0 disabled
> sdhci [sdhci_suspend()]: Suspending...
> MMC: starting cmd 07 arg 00000000 flags 00000000
> sdhci [sdhci_send_command()]: Sending cmd (7)
>
> And if I modprobe sdhci after suspend&resume I get the following:
>   First from the modprobe (not all of it is visible):
> sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
> sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
> sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
> sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
> sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
> sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
> sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
> sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
> sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
> sdhci: Caps:     0xffffffff | Max curr: 0xffffffff
> sdhci: ===========================================
>   

Now this is horribly broken and would explain why things go south. I
guess the chip needs a reset early in the detection sequence to function
properly. Try putting:

    sdhci_reset(host, SDHCI_RESET_ALL);

just before the driver does a readl() on the capabilities register (in
sdhci_probe_slot()).

>   Also I just noticed that if the machine has been through at least one 
> suspend&resume cycle, rebooting no longer works. All processes exit cleanly, 
> but the system just hangs when it should shut down.
>   

That's just probably a broken ACPI. Laptops tend to be buggy as hell.
File a report with the ACPI guys.

Rgds
Pierre

