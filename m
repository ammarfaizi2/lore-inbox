Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422688AbWBBBZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422688AbWBBBZv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 20:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422689AbWBBBZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 20:25:51 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:63728 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1422688AbWBBBZu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 20:25:50 -0500
Date: Wed, 1 Feb 2006 20:25:43 -0500
From: "George G. Davis" <gdavis@mvista.com>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: Add spin_lock_init() in 8250 early_serial_setup() to init port.lock
Message-ID: <20060202012543.GS7405@mvista.com>
References: <20060126032403.GG5133@mvista.com> <20060131.003927.112625901.anemo@mba.ocn.ne.jp> <20060201154549.GE7405@mvista.com> <20060201230013.GL3072@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060201230013.GL3072@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 11:00:13PM +0000, Russell King wrote:
> On Wed, Feb 01, 2006 at 10:45:49AM -0500, George G. Davis wrote:
> > But uart_add_one_port() intentionally does not spin_lock_init() the
> > port.lock of the serial console device under the assumption that
> > it is already done.
> 
> Yes, and there's a bug in there atm...

Which is resolved via:

ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm4/broken-out/serial-initialize-spinlock-for-port-failed-to-setup.patch

Since the above fixes the problem, this patch is withdrawn.

> > 		serial8250_console_init()
> > 			serial8250_isa_init_ports()
> > 				if (first)
> > 					spin_lock_init() /* port.lock init */

> This initialisation is actually pointless here.

Agreed, when serial-initialize-spinlock-for-port-failed-to-setup.patch is
applied, the above spin_lock_init() is no longer required.

> > 			register_console()
> > 				serial8250_console_setup() /* -ENODEV */
> > 	...
> > 	rest_init()
> > 		...
> > 		/* arch_initcalls */
> > 		early_serial_setup()
> 
> This is where it goes wrong.  Don't call early_serial_setup() after
> "early".  Use a platform device instead.

Ok, this was perhaps a bad example, some machines call early_serial_setup()
much earlier via setup_arch() or sooner.  This case used an arch_initcall
which is admittedly rather late to be calling early_* funcs.  My bad...

> I absolutely detest the number of ways to initialise an 8250 port -
> I'd like there to be only one way, but that doesn't satisfy everyone.
> That one way is via platform devices.

FWIW, I agree but had to use early_serial_setup() for other reasons (kgdb8250
vs. standard 8250 serial port fights in an earlier 2.6 kernel release).  Well,
aside from my brain damaged use of early_serial_setup(), there was a real
bug initialising the serial console spinlock.  So it wasn't a total waste
of time.  : )

> Please use that method in
> preference to everything else, _especially_ from architecture code.

FWIW, I also prefer to see early_serial_setup() killed off and force current
users to register 8250 ports via platform devices.  But I'm stuck with
early_serial_setup() in my current case.

Thanks for your comments.

--
Regards,
George
