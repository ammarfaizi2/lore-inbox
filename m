Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315929AbSGGOMg>; Sun, 7 Jul 2002 10:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315941AbSGGOMf>; Sun, 7 Jul 2002 10:12:35 -0400
Received: from mail2.luukku.com ([193.209.83.38]:64139 "EHLO mail2.luukku.com")
	by vger.kernel.org with ESMTP id <S315929AbSGGOMf> convert rfc822-to-8bit;
	Sun, 7 Jul 2002 10:12:35 -0400
Message-ID: <4357948.1026051312492.JavaMail.nws@imapg-000.luukku.com>
Date: Sun, 7 Jul 2002 17:15:12 +0300 (EEST)
From: Marko Kohtala <marko.kohtala@luukku.com>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Serial: updated serial drivers
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> Linus has expressed an interest in merging this work; hence this
> message.  Before I do send it to Linus, I would like to get some
> feedback on the code.  So, here is the latest patch against 2.5.24:
> 
>  http://www.home.arm.linux.org.uk/cvs/serial-2.5.24.diff.bz2
...
> I'm sure there's other stuff people want. 8)

It looks good.

I have one additional request that might best be done while doing this kind of rewrite.

I came across an IndustryPack (IP) carrier card. Each IP sits on a 16 bit bus. The carrier is a PCI device and has slots for four IP, each IP module I had carried eight 16550 serial ports.

With this I came up with two problems:

1) The PCI<->IP bridge had a bug with byte accesses. The iotype SERIAL_IO_MEM and iomem_reg_shift 1 addressed right addresses, but with byte access, so it did not work.

2) All the 32 serial ports were on same IRQ. You could find out which ports need service on an interrupt with one or two register reads, but the serial driver wanted to get and handle the IRQ on its own. The multiport support did not quite work for this.

One solution to allow the carrier driver address these would be to replace the struct uart_port iotype with a pointer to

struct serial_hw_ops {
  unsigned int (*serial_in)(struct uart_port *, int offset);
  void (*serial_out)(struct uart_port *, int offset, int value);
  int (*enable_irq)(struct uart_port *, void (*irq_func)(struct uart_port *));
  void (*disable_irq)(struct uart_port *);
};

Then implement new register_serial functions for the carrier card driver to use that take this as argument (serial8250_register?). The irq_func would be the function carrier driver calls to get the IRQ serviced (close to serial8250_handle_port).

The struct uart_port would need to also carry a pointer to carrier specific data. Only the enable_irq and disable_irq will need carrier data.

I think the current iobase and other members are good enough such that the serial_in and serial_out can be implemented rather efficiently without the extra indirection through the carrier data pointer.

I'm not sure if it would still incur a small overhead to I/O access. Perhaps not, as it would seem to me the serial_in does not get inlined and there would be one switch statement we could avoid by this. You are more competent to judge this.

This would also nicely clean up the SERIAL_IO_HUB6 case in serial_in/out. And it would help other multiport serial cards to utilize the registers they have to isolate the ports that interrupt.

The enable_irq in the carrier driver would see if the port is the first on the carrier, and request the IRQ to its own interrupt function. On the same interrupt there can be other things besides the serial ports.

struct serial_hw_ops instances and the functions for the standard single port or standard multiport cases should be exported. The carrier card has it's own module that needs access to these things for the serial8250_register call.

There are IP with other UART than 16550, so this should be used for all UART drivers.

Since this seems to affect the interface to port registration functions, it might be better to have it done now rather than later.


............................................................
Maksuton sähköposti aina käytössä http://luukku.com                            
Kuukausimaksuton MTV3 Internet-liittymä www.mtv3.fi/liittyma

