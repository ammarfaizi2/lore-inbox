Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423005AbWBAXAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423005AbWBAXAW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 18:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423006AbWBAXAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 18:00:22 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21522 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1423005AbWBAXAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 18:00:22 -0500
Date: Wed, 1 Feb 2006 23:00:13 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "George G. Davis" <gdavis@mvista.com>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: Add spin_lock_init() in 8250 early_serial_setup() to init port.lock
Message-ID: <20060201230013.GL3072@flint.arm.linux.org.uk>
Mail-Followup-To: "George G. Davis" <gdavis@mvista.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-kernel@vger.kernel.org
References: <20060126032403.GG5133@mvista.com> <20060131.003927.112625901.anemo@mba.ocn.ne.jp> <20060201154549.GE7405@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060201154549.GE7405@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 10:45:49AM -0500, George G. Davis wrote:
> But uart_add_one_port() intentionally does not spin_lock_init() the
> port.lock of the serial console device under the assumption that
> it is already done.

Yes, and there's a bug in there atm...

> Here's the call sequence:
> 
> start_kernel()
> 	...
> 	console_init()
> 		...
> 		serial8250_console_init()
> 			serial8250_isa_init_ports()
> 				if (first)
> 					spin_lock_init() /* port.lock init */
> 				...
> 
> All 8250 serial port.locks are now initialised but no ports have
> been registered (on targets which do not register legacy serial ports
> via old_serial_port[]) at this point.

This initialisation is actually pointless here.

> 
> 			register_console()
> 				serial8250_console_setup() /* -ENODEV */
> 	...
> 	rest_init()
> 		...
> 		/* arch_initcalls */
> 		early_serial_setup()

This is where it goes wrong.  Don't call early_serial_setup() after
"early".  Use a platform device instead.

I absolutely detest the number of ways to initialise an 8250 port -
I'd like there to be only one way, but that doesn't satisfy everyone.
That one way is via platform devices.  Please use that method in
preference to everything else, _especially_ from architecture code.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
