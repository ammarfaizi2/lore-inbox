Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262523AbVA0HU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262523AbVA0HU3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 02:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbVA0HU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 02:20:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:26027 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262526AbVA0HNf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 02:13:35 -0500
Date: Wed, 26 Jan 2005 23:13:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin =?ISO-8859-1?B?S/ZnbGVy?= <e9925248@student.tuwien.ac.at>
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>
Subject: Re: Deadlock in serial driver 2.6.x
Message-Id: <20050126231329.440fbcd8.akpm@osdl.org>
In-Reply-To: <20050126132047.GA2713@stud4.tuwien.ac.at>
References: <20050126132047.GA2713@stud4.tuwien.ac.at>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Kögler <e9925248@student.tuwien.ac.at> wrote:
>
> I noticed with different kernel versions (a 2.6.5 FC2 Kernel, a 2.6.7 Knoppix Kernel
>  and 2.6.10 FC2 and FC3 Kernels (which have no patches for the serial driver)), that it 
>  is possible for a normal user, which has rw access to /dev/ttySx, to hang a computer.
>  To exploit it, there must be a device on the other end on the serial line, which sends 
>  some data.
> 
>  I tested it on a i686 machine.
> 
>  At http://www.auto.tuwien.ac.at/~mkoegler/linux/serial_oops.c , I have an example programm,
>  which exploits the problem (/dev/ttyS0 is hardcoded as serial device).
> 
>  To trigger the problem, connect two computers with a null modem cable and send some
>  characters to the programm (The baud rate at the other computer seems to be not important).
> 
>  With SMP-Kernels, the computer stops responding.
>  Kernels without SMP print a panic message before they stop working, eg:
>  Kernel panic - not syncing: drivers/serial/serial_core.c:103: spin_lock(drivers/serial/serial_core.c:c04055e0) already locked  by drivers/serial/8250.c/1170
> 
>  Photos of a panic messages of a FC3 2.6.10-1.741_FC3 Kernel are available at 
>  http://www.auto.tuwien.ac.at/~mkoegler/linux .
> 
>  What the programm does:
>  It sets the low latency mode, then waiting, until a certain state of the handshake 
>  lines is reached, then it sends a bytes and waits for a byte. Then it changes the 
>  handshake lines again and the process starts again.

Yes, I get a similar deadlock:

 [<c0101327>] show_regs+0x11f/0x12c                    
 [<c0273cc8>] sysrq_handle_showregs+0x10/0x18
 [<c0273e72>] __handle_sysrq+0x76/0x120      
 [<c0273f39>] handle_sysrq+0x1d/0x24   
 [<c026eefd>] kbd_keycode+0x105/0x2c8
 [<c026f144>] kbd_event+0x84/0xbc    
 [<c03038d8>] input_event+0x398/0x3bc
 [<c0305e0a>] atkbd_report_key+0x3e/0x64
 [<c030629b>] atkbd_interrupt+0x46b/0x4e8
 [<c0276059>] serio_interrupt+0x39/0x69  
 [<c0276bff>] i8042_interrupt+0x1f7/0x20c
 [<c013a215>] handle_IRQ_event+0x2d/0x64 
 [<c013a343>] __do_IRQ+0xf7/0x154       
 [<c0104eee>] do_IRQ+0x1e/0x34   
 [<c010376a>] common_interrupt+0x1a/0x20
 [<c0277c35>] uart_start+0x19/0x34      
 [<c0278088>] uart_flush_chars+0xc/0x10
 [<c02670d5>] n_tty_receive_buf+0x104d/0x10f8
 [<c0264bb9>] flush_to_ldisc+0xe1/0xf4       
 [<c0264c75>] tty_flip_buffer_push+0x15/0x34
 [<c027b4d8>] receive_chars+0x1fc/0x210     
 [<c027b703>] serial8250_interrupt+0x63/0xe0
 [<c013a215>] handle_IRQ_event+0x2d/0x64    
 [<c013a343>] __do_IRQ+0xf7/0x154       
 [<c0104eee>] do_IRQ+0x1e/0x34   
 [<c010376a>] common_interrupt+0x1a/0x20

(For some reason the NMI watchdog isn't triggering here, and it's still
taking interrupts).

  serial8250_interrupt() takes uart_8250_port.port.lock
  ->serial8250_handle_port
    ->receive_chars
      ->tty_flip_buffer_push (->low_latency is true)
        ->flush_to_ldisc
          ->n_tty_receive_buf

            (this takes tty->read_lock inside uart_8250_port.port.lock. Is
             this ranking correct?)

            ->uart_flush_chars
              ->uart_start

                Does spin_lock_irqsave(&port->lock, flags);


Looks like low-latency mode is busted.

