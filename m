Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbVLSVmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbVLSVmL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 16:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbVLSVmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 16:42:11 -0500
Received: from panoramix.softnet.tuc.gr ([147.27.14.5]:35291 "HELO
	softnet.tuc.gr") by vger.kernel.org with SMTP id S932296AbVLSVmJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 16:42:09 -0500
Message-ID: <32908.147.27.7.175.1135028524.squirrel@147.27.7.175>
Date: Mon, 19 Dec 2005 23:42:04 +0200 (EET)
Subject: selfmade serial driver problem with chipset other than VIA
From: gxatzipavlis@softnet.tuc.gr
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3-RC1
X-Mailer: SquirrelMail/1.4.3-RC1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

firstly i would like to apologize cause i send this mail to linux-kernel
mailling list and not to linux serial but linux-serial@vger.kernel.org
don't accept the email.

On Mon, 2005-12-19 at 18:12 +0200, giorgos xatzipavlis wrote:
> hello people
>
> this is my first attempt to the linux serial mailling list so i
> apologize for my mistakes...
>
> i am a newbie in kernel development.
>
> i have made a serial driver cause i want to communicate with a serial
device ( a microcontroller ). I have programmed the driver in my
computer and everything is working ok. I have an AMD 1000Hz, MSI
motherboard with VIA chipset and kernel 2.4.31. I have found
> informations from Linux Deveice Drivers book. Everything is working ok
in my computer but  the driver isn't working in computers with INTEL and
NVIDIA chipsets. The fact that makes me suspicious about that
> is that although my driver is registered in /proc/interrupts
> and /proc/ioports (irq 4-ioport 0x03f8) when ever i call outb from my
writer bottomhalf routine the interrupt isn't generated from the
hardware(in machines with inter or nvidia chipset).
>
> the flow chart is somethink like that:
>
> 1)user space write      (getting the data from user)
>
> 2)kernel space write    (generating the package that i want to send)
>
> 3)writer_bottomhalf     (i have the package in writer_buffer indexed by a
> 		         bytes_send variable. Call
"outb(writer_buffer[bytes_send],MY_UART+UART_TX)" )
>
> 4)interrupt handler     (bytes_send++ ,so i can send the next character
variable,
> 		         call "tasklet_schedule(&writer_bottomhalf)" to go to step 3)
>
> in computers with chipsets other than VIA the 4th step (interrupt
handler) is
> never executed.
>
> any ideas?
>
> thank


secondly alan cox respond with:

On Mon, 2005-12-19 at 18:03 +0000, Alan Cox wrote:
> > 2)kernel space write    (generating the package that i want to send)
> >
> > 3)writer_bottomhalf     (i have the package in writer_buffer indexed by a
> > 		         bytes_send variable. Call
"outb(writer_buffer[bytes_send],MY_UART+UART_TX)" )
> >
> > 4)interrupt handler     (bytes_send++ ,so i can send the next
character variable,
> > 		         call "tasklet_schedule(&writer_bottomhalf)" to go to step 3)
> >
> > in computers with chipsets other than VIA the 4th step (interrupt
handler) is
> > never executed.
>
>
> Have you set up the interrupt enables in the 16x50 chip. If you've not
done that step then it may depend on the vendor/BIOS what state the chip
is in when you boot.
>
> You might want to print out the registers at boot on each system and
look at the differences



in the initialization routine i enable the interrupts

"outb( UART_IER_RLSI | UART_IER_RDI | UART_IER_THRI , eib_io+UART_IER);"

where eib_io = 0x03f8.

in the writer_bottomhalf i do:

//bytes_send    :index to writer buffer which holds the package
//writer_length :length of the package i want to send
//foo           :struct timeval for debugging reasons

if(bytes_send==writer_length){   // i have send the whole package

	//starting timer to catch unacknowledged packages

}
else{
	outb(writer[bytes_send],eib_io+UART_TX);
	printk(KERN_ALERT"sending %x %ld %ld\n",
               writer[bytes_send],foo.tv_sec,foo.tv_usec);
}
return;

and in interrupt handler

static void interrupt_handler(int irq, void *dev_id, struct pt_regs *regs){

// code for other interrupts

      if ( inb(  eib_io + UART_LSR ) & ( UART_LSR_THRE) ){

		bytes_send++;
		tasklet_schedule(&writer_tasklet);
		return;

      }

}

so whenever the interrupt handler is calling i increase the bytes_send and
i return to writer_bottomhalf to send the next character of the package.
My question is that if there are differencies in the
implementation of the UARTS between VIA and other manufacturers?
I can't understand why this piece of shit is working only in VIA.
i use 2.4.31 compiled with the same .config  except the processor's type
and chipset support in block devices section(linux serial driver
compiled as a module that i  don't load at all).

i can't understand what registers to print during boot as alan proposed
the registers from 0x03f8 - 0x03ff (aka /dev/ttyS0)?

thanks and sorry for the length of the message...

P.S: do i have to send every email to linux-kernel@vger.kernel.org or to
linux-serial@vger.kernel.org



