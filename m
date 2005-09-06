Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbVIFWVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbVIFWVF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 18:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbVIFWVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 18:21:05 -0400
Received: from a.mail.sonic.net ([64.142.16.245]:44266 "EHLO a.mail.sonic.net")
	by vger.kernel.org with ESMTP id S1751044AbVIFWVB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 18:21:01 -0400
Date: Tue, 6 Sep 2005 15:20:35 -0700
From: David Hinds <dhinds@sonic.net>
To: "Thomas Kleffel (LKML)" <lkml@maintech.de>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org,
       linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make ide-cs work for hardware with 8-bit CF-Interface
Message-ID: <20050906222035.GA26345@sonic.net>
References: <431DC80C.8030706@maintech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431DC80C.8030706@maintech.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 06:47:08PM +0200, Thomas Kleffel (LKML) wrote:
> 
> The following patch is against vanilla 2.6.13.
> 
> ldiff -uprN a/drivers/ide/legacy/ide-cs.c b/drivers/ide/legacy/ide-cs.c
> --- a/drivers/ide/legacy/ide-cs.c       2005-08-08 15:30:35.000000000 +0200
> +++ b/drivers/ide/legacy/ide-cs.c       2005-09-05 02:09:47.000000000 +0200
> @@ -186,7 +186,8 @@ static int idecs_register(unsigned long
>  {
>      hw_regs_t hw;
>      memset(&hw, 0, sizeof(hw));
> -    ide_init_hwif_ports(&hw, io, ctl, NULL);
> +    ide_std_init_ports(&hw, io, ctl);
> +    hw.io_ports[IDE_DATA_OFFSET] = io + 0x08;
>      hw.irq = irq;
>      hw.chipset = ide_pci;
>      return ide_register_hw_with_fixup(&hw, NULL, ide_undecoded_slave);

You can't do this, at least not exactly this way.  io + 0x08 may not
be a mapped IO address; it is only valid when a card is mapped with
one contiguous 16-bit IO window.  PCMCIA IDE cards are not necessarily
mapped that way: they may be mapped with one 8-port window and one
1-port window, to match standard IBM PC IDE port locations.  In that
case, the registers at 0x08 and 0x09 are not available.  The CF spec
may impose more uniformity here than the PCMCIA spec does.  I do know
that some IDE cards do end up configured with discontiguous register
allocations when used with ide-cs.c.

-- Dave
