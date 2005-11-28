Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbVK1La3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbVK1La3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 06:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVK1La2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 06:30:28 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5898 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751117AbVK1La2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 06:30:28 -0500
Date: Mon, 28 Nov 2005 11:30:20 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: uart_match_port() question
Message-ID: <20051128113020.GA30298@flint.arm.linux.org.uk>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1133050906.7768.66.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133050906.7768.66.camel@gaston>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2005 at 11:21:46AM +1100, Benjamin Herrenschmidt wrote:
> Hi Russel, would you accept a patch like that:

s/l,/l&/

> Index: linux-work/drivers/serial/serial_core.c
> ===================================================================
> --- linux-work.orig/drivers/serial/serial_core.c	2005-11-14 20:32:16.000000000 +1100
> +++ linux-work/drivers/serial/serial_core.c	2005-11-27 11:13:54.000000000 +1100
> @@ -2307,7 +2307,8 @@
>  		return (port1->iobase == port2->iobase) &&
>  		       (port1->hub6   == port2->hub6);
>  	case UPIO_MEM:
> -		return (port1->membase == port2->membase);
> +		return (port1->membase == port2->membase) ||
> +			(port1->mapbase && port1->mapbase == port2->mapbase);
>  	}
>  	return 0;
>  }

I don't think so.  (see below)

> The reason is a bit complicated, but basically, we have some arch code
> that builds a list of available serial ports very early and registers that
> as a platform device. It also detects which one is the default firmware port
> and what speed it's been configured for and builds a proper config line to
> pass to add_preferred_console() so we get the default serial console setup
> properly automatically.
> 
> This list includes however ports that are on PCI devices on some recent
> machines. Thus, we need to make sure that, when 8250_pci.c kicks in, it
> property detects that those platform ports are the same it's discovered
> and thus properly re-uses the same port & minor. However, while that works
> for PIO ports, it doesn't for MMIO since membase is obtained from ioremap,
> and thus will be different between the port registered at boot and the
> value passed by the PCI code. Only mapbase will be the same.
> 
> If we just skipped PCI devices in our early discovery code (thus letting
> 8250_pci.c alone discover them), we would be unable to use them for very
> early console output, and we would be unable to "know" what their minor number
> will be, and thus build an appropriate argument string for add_preferred_console(),
> which means we would be unable to have the console automatically pick the port
> that we set by the firmware and at the right speed, which basically means
> console not working for users. 

Looking at this deeper, I think we should _only_ use mapbase in this
case.  membase is really a indeterminant cookie which bears no real
relationship to whether two ports are identical - in fact, if we are
going to compare two of these cookies, I think arch code should be
involved.

So how about:

-             return (port1->membase == port2->membase);
+             return (port1->mapbase == port2->mapbase);

?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
