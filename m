Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbSIWWjL>; Mon, 23 Sep 2002 18:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261428AbSIWWjK>; Mon, 23 Sep 2002 18:39:10 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:34044 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261427AbSIWWjE>;
	Mon, 23 Sep 2002 18:39:04 -0400
Message-ID: <3D8F993E.81D33FE8@mvista.com>
Date: Mon, 23 Sep 2002 18:44:14 -0400
From: "Mark A. Greer" <mgreer@mvista.com>
Organization: MontaVista Software, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.8-26mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: linux-kernel@vger.kernel.org, steiner@sgi.com, davidm@napali.hpl.hp.com
Subject: Re: can we drop early_serial_setup()?
References: <200209200459.g8K4xJcW011057@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

Sorry for the delay, we've had email problems most of last week.

Yes, we can get rid of the early_serial_setup() in ev64260_setup.c, no
problem there.  I'm very busy on some other things right now but I'll try
to get to that soon.  If you can't wait, go ahead and make the change and
I will test it for you.

Mark
--

David Mosberger wrote:

> The early_serial_setup() routine was broken during the big serial
> clean up that happened a while ago.  I fixed this problem for ia64 by
> introducing a new routine called early_register_port() (see below).
> It serves the same purpose as early_serial_setup(), with the only
> difference being that the argument passed to it is now a "uart_port"
> structure (instead of a "serial_struct").  Russell King suggested to
> get rid of early_serial_setup() alltogether, since it is broken anyhow
> and serves no purpose anymore.  However, as far as I can tell, there
> are two places left which use this routine:
>
>         arch/ia64/sn/kernel/setup.c
>         arch/ppc/platforms/ev64260_setup.c
>
> It's should be easy to convert these files to early_register_port(),
> but since I can't test the platform's in question (PPC and SGI SN
> machine), I'd like to know whether it's OK to drop
> early_serial_setup() now.  If someone wants some hints on how to do
> the conversion, let me know (sample code is in 8250_hcdp.c).
>
> Thanks,
>
>         --david
>
> int __init early_register_port (struct uart_port *port)
> {
>         if (port->line >= ARRAY_SIZE(serial8250_ports))
>                 return -ENODEV;
>
>         serial8250_isa_init_ports();    /* force ISA defaults */
>         serial8250_ports[port->line].port = *port;
>         serial8250_ports[port->line].port.ops = &serial8250_pops;
>         return 0;
> }

