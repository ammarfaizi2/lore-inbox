Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269313AbUI3QOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269313AbUI3QOS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 12:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269319AbUI3QOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 12:14:18 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:48550 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S269313AbUI3QOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 12:14:09 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][PATCH] Way for platforms to alter built-in serial ports
Date: Thu, 30 Sep 2004 10:14:00 -0600
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200409301014.00725.bjorn.helgaas@hp.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What I propose is a way for the arch to provide it's own table along
> with the size of it via a function call. It's optional, based on a
> #ifdef defined by the arch in it's asm/serial.h. The only remaining
> tricky point is the fact that you used to size your static array of
> UART's based on the size of the table. So with my path, an arch
> that defines ARCH_HAS_GET_LEGACY_SERIAL_PORTS is supposed to provide
> both the new get_legacy_serial_ports() function, but also to define
> UART_NR to something sensible. I hope one day, we'll be able to
> convert 8250 to more dynamic allocation though.

This looks like a reasonable short-term fix, but I think the whole
serial8250_isa_init_ports() should go away.  I like dwmw2's suggestion
of an 8250_platform.c that could use register_serial() for each port
in some platform-supplied old_serial_port[] table, which is probably
what you mean by moving to a more dynamic allocation.

AFAICS, the only reason for doing serial8250_isa_init_ports() early
is for early serial consoles, and I think those should be done along
the lines of this:
 http://www.ussg.iu.edu/hypermail/linux/kernel/0409.1/1034.html
where the platform can specify a device by its MMIO or IO port address,
and we automatically switch to the corresponding ttyS device later.
