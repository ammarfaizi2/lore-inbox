Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275039AbSITEy3>; Fri, 20 Sep 2002 00:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275044AbSITEy3>; Fri, 20 Sep 2002 00:54:29 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:8402 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S275039AbSITEy2>;
	Fri, 20 Sep 2002 00:54:28 -0400
Date: Thu, 19 Sep 2002 21:59:19 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200209200459.g8K4xJcW011057@napali.hpl.hp.com>
To: linux-kernel@vger.kernel.org
cc: mgreer@mvista.com, steiner@sgi.com, davidm@napali.hpl.hp.com
Subject: can we drop early_serial_setup()?
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-to: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The early_serial_setup() routine was broken during the big serial
clean up that happened a while ago.  I fixed this problem for ia64 by
introducing a new routine called early_register_port() (see below).
It serves the same purpose as early_serial_setup(), with the only
difference being that the argument passed to it is now a "uart_port"
structure (instead of a "serial_struct").  Russell King suggested to
get rid of early_serial_setup() alltogether, since it is broken anyhow
and serves no purpose anymore.  However, as far as I can tell, there
are two places left which use this routine:

	arch/ia64/sn/kernel/setup.c
	arch/ppc/platforms/ev64260_setup.c

It's should be easy to convert these files to early_register_port(),
but since I can't test the platform's in question (PPC and SGI SN
machine), I'd like to know whether it's OK to drop
early_serial_setup() now.  If someone wants some hints on how to do
the conversion, let me know (sample code is in 8250_hcdp.c).

Thanks,

	--david

int __init early_register_port (struct uart_port *port)
{
	if (port->line >= ARRAY_SIZE(serial8250_ports))
		return -ENODEV;

	serial8250_isa_init_ports();	/* force ISA defaults */
	serial8250_ports[port->line].port = *port;
	serial8250_ports[port->line].port.ops = &serial8250_pops;
	return 0;
}
