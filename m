Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbULVDtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbULVDtA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 22:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbULVDtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 22:49:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59285 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261952AbULVDsv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 22:48:51 -0500
Message-ID: <41C8EE9A.9080707@pobox.com>
Date: Tue, 21 Dec 2004 22:48:42 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: David Brownell <david-b@pacbell.net>, Greg Kroah-Hartman <greg@kroah.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] USB: fix Scheduling while atomic warning when resuming.
References: <200412220103.iBM13wS0002158@hera.kernel.org>
In-Reply-To: <200412220103.iBM13wS0002158@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.2215, 2004/12/21 16:25:03-08:00, greg@kroah.com
> 
> 	[PATCH] USB: fix Scheduling while atomic warning when resuming.
> 	
> 	This fixes a warning when resuming the USB EHCI host controller driver.

> diff -Nru a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
> --- a/drivers/usb/host/ehci-hub.c	2004-12-21 17:04:09 -08:00
> +++ b/drivers/usb/host/ehci-hub.c	2004-12-21 17:04:09 -08:00
> @@ -122,7 +122,7 @@
>  		writel (temp, &ehci->regs->port_status [i]);
>  	}
>  	i = HCS_N_PORTS (ehci->hcs_params);
> -	msleep (20);
> +	mdelay (20);
>  	while (i--) {
>  		temp = readl (&ehci->regs->port_status [i]);


This is more than a little bit silly.

The entire resume function holds spin_lock_irq() for far longer than a 
timer tick.

If we are going for a minimalist -rc patch, why not drop the lock, 
sleep, then reacquire the lock?

This strikes me as a bad change, make in haste for -rc, that will get 
quickly forgotten (and left as-is) once 2.6.10 is released.

	Jeff


