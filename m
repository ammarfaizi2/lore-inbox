Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317439AbSGUVHg>; Sun, 21 Jul 2002 17:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317450AbSGUVHg>; Sun, 21 Jul 2002 17:07:36 -0400
Received: from mx1.elte.hu ([157.181.1.137]:33469 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317439AbSGUVHc>;
	Sun, 21 Jul 2002 17:07:32 -0400
Date: Sun, 21 Jul 2002 23:09:34 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] "big IRQ lock" removal, 2.5.27-A1
In-Reply-To: <20020721214239.C26376@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207212307570.28392-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


using serial-2.5.26-3.diff, i get an oops here:

(gdb) list *0xc01b1f03
0xc01b1f03 is in serial_in (serial_8250.c:189).
184                     return readb(up->port.membase + offset);
185
186             default:
187                     return inb(up->port.iobase + offset);
188             }
189     }
190
191     static _INLINE_ void
192     serial_out(struct uart_8250_port *up, int offset, int value)
193     {
(gdb)

called from:

(gdb) list *0xc01b3450
0xc01b3450 is in serial8250_interrupt (serial_8250.c:946).
941                     struct uart_8250_port *up;
942                     unsigned int iir;
943
944                     up = list_entry(l, struct uart_8250_port, list);
945
946                     iir = serial_in(up, UART_IIR);
947                     if (!(iir & UART_IIR_NO_INT)) {
948                             spin_lock(&up->port.lock);
949                             serial8250_handle_port(up, regs);
950                             spin_unlock(&up->port.lock);
(gdb)

when echo-ing into a serial port, which is also set up for kernel serial
console. (the kernel serial console produces no output.)

	Ingo

