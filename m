Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268589AbTGIVxw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 17:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268597AbTGIVxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 17:53:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2948 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268589AbTGIVxu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 17:53:50 -0400
Message-ID: <3F0C9251.2010107@pobox.com>
Date: Wed, 09 Jul 2003 18:08:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: torvalds@osdl.org
Subject: Re: Fix IDE initialization when we don't probe for interrupts.
References: <200307092110.h69LAlgG027527@hera.kernel.org>
In-Reply-To: <200307092110.h69LAlgG027527@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.1374, 2003/07/09 13:40:53-07:00, torvalds@home.osdl.org
> 
> 	Fix IDE initialization when we don't probe for interrupts.
> 	
> 	The driver obviously cannot rely on the interrupt handler
> 	when it is probing for interrupts, so the identify code is
> 	written to not use interrupts and the probing code will
> 	disable the interrupt after having figured out which one it
> 	is.
> 	
> 	The non-probe code should do the same, otherwise confusion
> 	happens. 

> diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
> --- a/drivers/ide/ide-probe.c	Wed Jul  9 14:10:54 2003
> +++ b/drivers/ide/ide-probe.c	Wed Jul  9 14:10:54 2003
> @@ -390,6 +390,14 @@
>  		cookie = probe_irq_on();
>  		/* enable device irq */
>  		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
> +	} else {
> +		/*
> +		 * Disable device irq if we don't need to
> +		 * probe for it. Otherwise we'll get spurious
> +		 * interrupts during the identify-phase that
> +		 * the irq handler isn't expecting.
> +		 */
> +		hwif->OUTB(drive->ctl|2, IDE_CONTROL_REG);


Yeah, my driver does probing with interrupts disabled, too.

I'm curious where interrupts are re-enabled, though?

	Jeff



