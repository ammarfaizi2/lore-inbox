Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161095AbWBAPpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbWBAPpv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 10:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161099AbWBAPpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 10:45:51 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:57850 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1161095AbWBAPpv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 10:45:51 -0500
Date: Wed, 1 Feb 2006 10:45:49 -0500
From: "George G. Davis" <gdavis@mvista.com>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: rmk+serial@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: Add spin_lock_init() in 8250 early_serial_setup() to init port.lock
Message-ID: <20060201154549.GE7405@mvista.com>
References: <20060126032403.GG5133@mvista.com> <20060131.003927.112625901.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060131.003927.112625901.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 12:39:27AM +0900, Atsushi Nemoto wrote:
> >>>>> On Wed, 25 Jan 2006 22:24:03 -0500, "George G. Davis" <gdavis@mvista.com> said:
> 
> gdavis> Need spin_lock_init(&serial8250_ports[port->line].port.lock)
> gdavis> in early_serial_setup() since we're copying struct uart_port
> gdavis> *port into serial8250_ports[port->line].port and *port.lock is
> gdavis> typically unitiliased by the caller.
> 
> Is this really needed?

Yes, IMO, it is required for targets which use early_serial_setup().  If
you have doubts, enable DEBUG_SPINLOCK and you will see the problem but
only if your target uses early_serial_setup().

> The port.lock will be initialized in
> uart_set_options()

uart_set_options() is only called from serial8250_console_setup() when 8250
serial devices have already been registered via serial8250_isa_init_ports()
(for legacy devices only though AFAICT).

> or uart_add_one_port().

But uart_add_one_port() intentionally does not spin_lock_init() the
port.lock of the serial console device under the assumption that
it is already done.


Here's the call sequence:


start_kernel()
	...
	console_init()
		...
		serial8250_console_init()
			serial8250_isa_init_ports()
				if (first)
					spin_lock_init() /* port.lock init */
				...

All 8250 serial port.locks are now initialised but no ports have
been registered (on targets which do not register legacy serial ports
via old_serial_port[]) at this point.


			register_console()
				serial8250_console_setup() /* -ENODEV */
	...
	rest_init()
		...
		/* arch_initcalls */
		early_serial_setup()
			serial8250_isa_init_ports() /* !first, do nothing */
			serial8250_ports[port->line].port = *port;
			...

serial8250_ports[port->line].port.lock is over written above and may
not be properly initialised.


		/* module_inits */
		serial8250_init()
			...
			serial8250_register_ports()
				serial8250_isa_init_ports() /* !first */
				uart_add_one_port()
					if (!uart_console(port))
						spin_lock_init(&port->lock);
					uart_configure_port()


At this point I see the following with DEBUG_SPINLOCK enabled:


Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
BUG: spinlock bad magic on CPU#0, swapper/1
 lock: c02fcffc, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
[<c002bdec>] (dump_stack+0x0/0x14) from [<c0136268>] (spin_bug+0x94/0xac)
[<c01361d4>] (spin_bug+0x0/0xac) from [<c01362a8>] (_raw_spin_lock+0x28/0x160)
 r5 = A0000013  r4 = C02FCFFC 
[<c0136280>] (_raw_spin_lock+0x0/0x160) from [<c024459c>] (_spin_lock_irqsave+0x2c/0x34)
 r8 = 00000000  r7 = C02FCFFC  r6 = C02A4144  r5 = A0000013
 r4 = C02FCFFC 
[<c0244570>] (_spin_lock_irqsave+0x0/0x34) from [<c0168748>] (serial8250_config_port+0x7c/0x988)
 r5 = C02FCFFC  r4 = C02FCFFC 
[<c01686cc>] (serial8250_config_port+0x0/0x988) from [<c01668cc>] (uart_add_one_port+0x110/0x2a0)
[<c01667bc>] (uart_add_one_port+0x0/0x2a0) from [<c001a174>] (serial8250_init+0xec/0x170)
 r8 = C02A40F4  r7 = C1C7B2B0  r6 = C02FD2FC  r5 = 00000000
 r4 = C02FCFFC 
[<c001a088>] (serial8250_init+0x0/0x170) from [<c0026110>] (init+0xa0/0x228)
 r8 = 00000000  r7 = C00205B4  r6 = 00000001  r5 = C0374000
 r4 = C0020504 
[<c0026070>] (init+0x0/0x228) from [<c00446cc>] (do_exit+0x0/0x874)
 r7 = 00000000  r6 = 00000000  r5 = 00000000  r4 = 00000000
BUG: spinlock lockup on CPU#0, swapper/1, c02fcffc
[<c002bdec>] (dump_stack+0x0/0x14) from [<c01363a8>] (_raw_spin_lock+0x128/0x160)
[<c0136280>] (_raw_spin_lock+0x0/0x160) from [<c024459c>] (_spin_lock_irqsave+0x2c/0x34)
 r8 = 00000000  r7 = C02FCFFC  r6 = C02A4144  r5 = A0000013
 r4 = C02FCFFC 
[<c0244570>] (_spin_lock_irqsave+0x0/0x34) from [<c0168748>] (serial8250_config_port+0x7c/0x988)
 r5 = C02FCFFC  r4 = C02FCFFC 
[<c01686cc>] (serial8250_config_port+0x0/0x988) from [<c01668cc>] (uart_add_one_port+0x110/0x2a0)
[<c01667bc>] (uart_add_one_port+0x0/0x2a0) from [<c001a174>] (serial8250_init+0xec/0x170)
 r8 = C02A40F4  r7 = C1C7B2B0  r6 = C02FD2FC  r5 = 00000000
 r4 = C02FCFFC 
[<c001a088>] (serial8250_init+0x0/0x170) from [<c0026110>] (init+0xa0/0x228)
 r8 = 00000000  r7 = C00205B4  r6 = 00000001  r5 = C0374000
 r4 = C0020504 
[<c0026070>] (init+0x0/0x228) from [<c00446cc>] (do_exit+0x0/0x874)
 r7 = 00000000  r6 = 00000000  r5 = 00000000  r4 = 00000000


Adding spin_lock_init() in early_serial_setup() resolves the above.  Perhaps
there is a better way to fix this?

> 
> I think spin_lock_init() in serial8250_isa_init_ports() can be omitted
> also.

AFAICS, there are still a few corner cases where port.lock's are not
initialised on targets which do not define legacy serial ports via
old_serial_port[].


Thanks!

--
Regards,
George
> 
> ---
> Atsushi Nemoto
