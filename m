Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbUBRFES (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 00:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbUBRFES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 00:04:18 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:50309 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261965AbUBRFCe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 00:02:34 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: kgdb-lite for 2.6.2
Date: Wed, 18 Feb 2004 10:31:38 +0530
User-Agent: KMail/1.5
Cc: Tom Rini <trini@kernel.crashing.org>, George Anzinger <george@mvista.com>,
       Luben Tuikov <ltuikov@panasas.com>
References: <20040217113627.GA503@elf.ucw.cz> <200402171807.21894.amitkale@emsyssoft.com>
In-Reply-To: <200402171807.21894.amitkale@emsyssoft.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402181031.38629.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is one bug report of a kernel segfault for this kgdb core. It occurs 
when same breakpoint is hit on two processors. I am waiting on feedback for a 
fix for this problem from Luben. Luben, Any progress?

If someone else volunteers to test the fix on an SMP machine, I'll send a kgdb 
with this fix.

Thanks.
-Amit

On Tuesday 17 Feb 2004 6:07 pm, Amit S. Kale wrote:
> On Tuesday 17 Feb 2004 5:06 pm, Pavel Machek wrote:
> > Hi!
> >
> > kgdb-lite is version of kgdb with thread support and console-over-kgdb
> > support removed, to reduce impact on generic code.
>
> console-over-kgdb code is present, though the kernel configuration option
> for the same is removed. We can add that later.
>
> module.c changes are absent. Without them module unloading in gdb will not
> work correctly. Automatic module loading stuff is anyway broken on 2.6
> kgdbs. That's because module information structures have changed. I'll be
> fixing that soon.
>
> -Amit
>
> > This is only arch-independend part. Does it look like it could be
> > included in the -mm?
> > 								Pavel
> >
> >
> > --- clean.2.5/Makefile	2004-02-05 01:53:53.000000000 +0100
> > +++ linux-mm/Makefile	2004-02-16 23:09:06.000000000 +0100
> > @@ -440,6 +440,8 @@
> >
> >  ifndef CONFIG_FRAME_POINTER
> >  CFLAGS		+= -fomit-frame-pointer
> > +else
> > +CFLAGS		+= -fno-omit-frame-pointer
> >  endif
> >
> >  ifdef CONFIG_DEBUG_INFO
> > --- clean.2.5/drivers/serial/8250.c	2004-01-09 20:24:22.000000000 +0100
> > +++ linux-mm/drivers/serial/8250.c	2004-02-16 23:09:06.000000000 +0100
> > @@ -1198,12 +1198,17 @@
> >  	spin_unlock_irqrestore(&up->port.lock, flags);
> >  }
> >
> > +static int released_irq = -1;
> > +
> >  static int serial8250_startup(struct uart_port *port)
> >  {
> >  	struct uart_8250_port *up = (struct uart_8250_port *)port;
> >  	unsigned long flags;
> >  	int retval;
> >
> > +	if (up->port.irq == released_irq)
> > +		return -EBUSY;
> > +
> >  	up->capabilities = uart_config[up->port.type].flags;
> >
> >  	if (up->port.type == PORT_16C950) {
> > @@ -1869,6 +1874,10 @@
> >  	for (i = 0; i < UART_NR; i++) {
> >  		struct uart_8250_port *up = &serial8250_ports[i];
> >
> > +		if (up->port.irq == released_irq) {
> > +			continue;
> > +		}
> > +
> >  		up->port.line = i;
> >  		up->port.ops = &serial8250_pops;
> >  		init_timer(&up->timer);
> > @@ -2138,6 +2147,36 @@
> >  	uart_resume_port(&serial8250_reg, &serial8250_ports[line].port);
> >  }
> >
> > +/*
> > + * Find all the ports using the given irq and shut them down.
> > + * Result should be that the irq will be released.
> > + * At most one irq can be released this way.
> > + * Once an irq is released, any attempts to initialize a port with that
> > irq + * will fail with EBUSY.
> > + */
> > +
> > +int serial8250_release_irq(int irq)
> > +{
> > +        struct uart_8250_port *up;
> > +	int ttyS;
> > +
> > +	if (released_irq != -1) {
> > +		return -EBUSY;
> > +	}
> > +	released_irq = irq;
> > +	for (ttyS = 0; ttyS < UART_NR; ttyS++){
> > +		up =  &serial8250_ports[ttyS];
> > +		if (up->port.irq == irq && (irq_lists + irq)->head) {
> > +#ifdef CONFIG_DEBUG_SPINLOCK   /* ugly business... */
> > +			if(up->port.lock.magic != SPINLOCK_MAGIC)
> > +				spin_lock_init(&up->port.lock);
> > +#endif
> > +			serial8250_shutdown(&up->port);
> > +		}
> > +        }
> > +	return 0;
> > +}
> > +
> >  static int __init serial8250_init(void)
> >  {
> >  	int ret, i;
> > --- clean.2.5/drivers/serial/Kconfig	2004-02-05 01:54:11.000000000 +0100
> > +++ linux-mm/drivers/serial/Kconfig	2004-02-16 23:09:06.000000000 +0100
> > @@ -6,6 +6,13 @@
> >
> >  menu "Serial drivers"
> >
> > +config KGDB_8250
> > +	bool "KGDB: On generic serial port (8250)"
> > +	depends on KGDB
> > +	help
> > +	  Uses generic serial port (8250) for kgdb. This is independent of the
> > +	  option 9250/16550 and compatible serial port.
> > +
> >  #
> >  # The new 8250/16550 serial drivers
> >  config SERIAL_8250
> > --- clean.2.5/drivers/serial/Makefile	2003-09-28 22:06:15.000000000 +0200
> > +++ linux-mm/drivers/serial/Makefile	2004-02-16 23:09:06.000000000 +0100
> > @@ -32,3 +32,5 @@
> >  obj-$(CONFIG_V850E_UART) += v850e_uart.o
> >  obj-$(CONFIG_SERIAL98) += serial98.o
> >  obj-$(CONFIG_SERIAL_PMACZILOG) += pmac_zilog.o
> > +
> > +obj-$(CONFIG_KGDB_8250) += kgdb_8250.o
> > --- clean.2.5/drivers/serial/kgdb_8250.c	2004-02-17 11:37:58.000000000
> > +0100 +++ linux-mm/drivers/serial/kgdb_8250.c	2004-02-16
> > 23:32:39.000000000 +0100 @@ -0,0 +1,396 @@
> > +/*
> > + * 8250 interface for kgdb.
> > + *
> > + * Restructured for making kgdb capable of handling different types of
> > serial + * interfaces, by Amit Kale (amitkale@emsyssoft.com)
> > + *
> > + * Written (hacked together) by David Grothe (dave@gcom.com)
> > + *
> > + * Modified by Scott Foehner (sfoehner@engr.sgi.com) to allow connect
> > + * on boot-up
> > + *
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/errno.h>
> > +#include <linux/signal.h>
> > +#include <linux/sched.h>
> > +#include <linux/timer.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/tty.h>
> > +#include <linux/tty_flip.h>
> > +#include <linux/serial.h>
> > +#include <linux/serial_core.h>
> > +#include <linux/serial_reg.h>
> > +#include <linux/serialP.h>
> > +#include <linux/config.h>
> > +#include <linux/major.h>
> > +#include <linux/string.h>
> > +#include <linux/fcntl.h>
> > +#include <linux/termios.h>
> > +#include <linux/kgdb.h>
> > +
> > +#include <asm/system.h>
> > +#include <asm/io.h>
> > +#include <asm/segment.h>
> > +#include <asm/bitops.h>
> > +#include <asm/system.h>
> > +#include <asm/irq.h>
> > +#include <asm/atomic.h>
> > +
> > +#define	GDB_BUF_SIZE	512		/* power of 2, please */
> > +
> > +static char	kgdb8250_buf[GDB_BUF_SIZE];
> > +static int	kgdb8250_buf_in_inx;
> > +static atomic_t	kgdb8250_buf_in_cnt;
> > +static int	kgdb8250_buf_out_inx;
> > +
> > +
> > +static int kgdb8250_got_dollar = -3, kgdb8250_got_H = -3,
> > +	kgdb8250_interrupt_iteration = 0;
> > +
> > +/* We only allow for 4 ports to be registered.  We default to standard
> > + * PC values. */
> > +static struct uart_port rs_table[4] = {
> > +	{ .line = 0x3f8, .irq = 4 },
> > +	{ .line = 0x2f8, .irq = 3 },
> > +	{ .line = 0x3e8, .irq = 4 },
> > +	{ .line = 0x2e8, .irq = 3 },
> > +};
> > +static void (*serial_outb)(unsigned char, unsigned long);
> > +static unsigned long (*serial_inb)(unsigned long);
> > +
> > +int serial8250_release_irq(int irq);
> > +
> > +int kgdb8250_irq;
> > +unsigned long kgdb8250_port;
> > +
> > +int kgdb8250_baud = 115200;
> > +int kgdb8250_ttyS;
> > +
> > +static unsigned long direct_inb(unsigned long addr)
> > +{
> > +	return readb(addr);
> > +}
> > +
> > +static void direct_outb(unsigned char val, unsigned long addr)
> > +{
> > +	writeb(val, addr);
> > +}
> > +
> > +static unsigned long io_inb(unsigned long port)
> > +{
> > +	return inb(port);
> > +}
> > +
> > +static void io_outb(unsigned char val, unsigned long port)
> > +{
> > +	outb(val, port);
> > +}
> > +
> > +/*
> > + * Get a byte from the hardware data buffer and return it
> > + * Get a char if available, return -EAGAIN if nothing available.
> > + */
> > +static int read_data_bfr(void)
> > +{
> > +	if (serial_inb(kgdb8250_port + UART_LSR) & UART_LSR_DR)
> > +		return(serial_inb(kgdb8250_port + UART_RX));
> > +
> > +	return -EAGAIN;
> > +}
> > +
> > +/*
> > + * Empty the receive buffer first, then look at the interface hardware.
> > + * It waits for a character from the serial interface and then returns
> > it. + */
> > +static int kgdb8250_read_char(void)
> > +{
> > +	int retchar;
> > +	if (atomic_read(&kgdb8250_buf_in_cnt) != 0)
> > +	{
> > +		/* intr routine has q'd chars read them from buffer */
> > +		int		chr;
> > +
> > +		chr = kgdb8250_buf[kgdb8250_buf_out_inx++];
> > +		kgdb8250_buf_out_inx &= (GDB_BUF_SIZE - 1);
> > +		atomic_dec(&kgdb8250_buf_in_cnt);
> > +		return chr;
> > +	}
> > +	do {
> > +		/* read from hardware */
> > +		retchar = read_data_bfr();
> > +	} while (retchar < 0);
> > +	return retchar;
> > +}
> > +
> > +/*
> > + * Wait until the interface can accept a char, then write it.
> > + */
> > +static void kgdb8250_write_char(int chr)
> > +{
> > +    while (!(serial_inb(kgdb8250_port + UART_LSR) & UART_LSR_THRE))
> > +	    /* Do nothing */;
> > +
> > +    serial_outb(chr, kgdb8250_port+UART_TX);
> > +
> > +}
> > +
> > +/*
> > + * This is the receiver interrupt routine for the GDB stub.
> > + * It will receive a limited number of characters of input
> > + * from the gdb  host machine and save them up in a buffer.
> > + *
> > + * When kgdb8250_read_char() is called it
> > + * draws characters out of the buffer until it is empty and
> > + * then reads directly from the serial port.
> > + *
> > + * We do not attempt to write chars from the interrupt routine
> > + * since the stubs do all of that via kgdb8250_write_char() which
> > + * writes one byte after waiting for the interface to become
> > + * ready.
> > + *
> > + * The debug stubs like to run with interrupts disabled since,
> > + * after all, they run as a consequence of a breakpoint in
> > + * the kernel.
> > + *
> > + * Perhaps someone who knows more about the tty driver than I
> > + * care to learn can make this work for any low level serial
> > + * driver.
> > + */
> > +static irqreturn_t kgdb8250_interrupt(int irq, void *dev_id,
> > +		struct pt_regs * regs)
> > +{
> > +	int	chr;
> > +	int	iir;
> > +
> > +	do
> > +	{
> > +		chr = read_data_bfr();
> > +		iir = serial_inb(kgdb8250_port + UART_IIR);
> > +		if (chr < 0) continue ;
> > +
> > +		/* Check whether gdb sent interrupt */
> > +		if (chr == 3)
> > +		{
> > +			breakpoint();
> > +			continue ;
> > +		}
> > +
> > +		if(atomic_read(&kgdb_killed_or_detached)) {
> > +			if (chr == '$')
> > +				kgdb8250_got_dollar = kgdb8250_interrupt_iteration;
> > +			if (kgdb8250_interrupt_iteration == kgdb8250_got_dollar + 1 &&
> > +			    chr == 'H')
> > +				kgdb8250_got_H  = kgdb8250_interrupt_iteration;
> > +			else if (kgdb8250_interrupt_iteration == kgdb8250_got_H + 1 &&
> > +				chr == 'c') {
> > +				kgdb8250_buf[kgdb8250_buf_in_inx++] = chr;
> > +				atomic_inc(&kgdb8250_buf_in_cnt);
> > +				atomic_set(&kgdb_might_be_resumed, 1);
> > +				wmb();
> > +				breakpoint();
> > +				atomic_set(&kgdb_might_be_resumed, 0);
> > +				kgdb8250_interrupt_iteration = 0;
> > +				kgdb8250_got_dollar = -3;
> > +				kgdb8250_got_H = -3;
> > +				continue;
> > +			}
> > +		}
> > +
> > +		if (atomic_read(&kgdb8250_buf_in_cnt) >= GDB_BUF_SIZE)
> > +		{
> > +			/* buffer overflow, clear it */
> > +			kgdb8250_buf_in_inx = 0 ;
> > +			atomic_set(&kgdb8250_buf_in_cnt, 0) ;
> > +			kgdb8250_buf_out_inx = 0 ;
> > +			break ;
> > +		}
> > +
> > +		kgdb8250_buf[kgdb8250_buf_in_inx++] = chr ;
> > +		kgdb8250_buf_in_inx &= (GDB_BUF_SIZE - 1) ;
> > +		atomic_inc(&kgdb8250_buf_in_cnt) ;
> > +	}
> > +	while (iir & UART_IIR_RDI);
> > +
> > +	if (atomic_read(&kgdb_killed_or_detached))
> > +		kgdb8250_interrupt_iteration ++;
> > +
> > +	return IRQ_HANDLED;
> > +
> > +}
> > +
> > +/*
> > + * Initializes serial port.
> > + *	ttyS - integer specifying which serial port to use for debugging
> > + *	baud - baud rate of specified serial port
> > + */
> > +static int kgdb8250_init(int ttyS, int baud)
> > +{
> > +        unsigned cval;
> > +        int     bits = 8;
> > +        int     parity = 'n';
> > +        int     cflag = CREAD | HUPCL | CLOCAL;
> > +        int     quot = 0;
> > +
> > +        /*
> > +         *      Now construct a cflag setting.
> > +         */
> > +        switch(baud) {
> > +                case 1200:
> > +                        cflag |= B1200;
> > +                        break;
> > +                case 2400:
> > +                        cflag |= B2400;
> > +                        break;
> > +                case 4800:
> > +                        cflag |= B4800;
> > +                        break;
> > +                case 19200:
> > +                        cflag |= B19200;
> > +                        break;
> > +                case 38400:
> > +                        cflag |= B38400;
> > +                        break;
> > +                case 57600:
> > +                        cflag |= B57600;
> > +                        break;
> > +                case 115200:
> > +                        cflag |= B115200;
> > +                        break;
> > +                default:
> > +			baud = 9600;
> > +			/* Fall through */
> > +                case 9600:
> > +                        cflag |= B9600;
> > +                        break;
> > +        }
> > +        switch(bits) {
> > +                case 7:
> > +                        cflag |= CS7;
> > +                        break;
> > +                default:
> > +                case 8:
> > +                        cflag |= CS8;
> > +                        break;
> > +        }
> > +        switch(parity) {
> > +                case 'o': case 'O':
> > +                        cflag |= PARODD;
> > +                        break;
> > +                case 'e': case 'E':
> > +                        cflag |= PARENB;
> > +                        break;
> > +        }
> > +
> > +        /*
> > +         *      Divisor, bytesize and parity
> > +	 *
> > +         */
> > +
> > +        quot = (1843200/16) / baud;
> > +        cval = cflag & (CSIZE | CSTOPB);
> > +        cval >>= 4;
> > +        if (cflag & PARENB)
> > +                cval |= UART_LCR_PARITY;
> > +        if (!(cflag & PARODD))
> > +                cval |= UART_LCR_EPAR;
> > +
> > +
> > +        /*
> > +         *      Disable UART interrupts, set DTR and RTS high
> > +         *      and set speed.
> > +         */
> > +	cval = 0x3;
> > +        serial_outb(cval | UART_LCR_DLAB, kgdb8250_port + UART_LCR);
> > /* set DLAB */ +        serial_outb(quot & 0xff, kgdb8250_port +
> > UART_DLL); /* LS of divisor */ +        serial_outb(quot >> 8,
> > kgdb8250_port + UART_DLM);           /* MS of divisor */ +       
> > serial_outb(cval, kgdb8250_port + UART_LCR);                /* reset DLAB
> > */ +
> > serial_outb(UART_IER_RDI, kgdb8250_port + UART_IER);        /* turn on
> > interrupts*/ +        serial_outb(UART_MCR_OUT2 | UART_MCR_DTR |
> > UART_MCR_RTS, kgdb8250_port + UART_MCR); +
> > +        /*
> > +         *      If we read 0xff from the LSR, there is no UART here.
> > +         */
> > +        if (serial_inb(kgdb8250_port + UART_LSR) == 0xff)
> > +                return -ENODEV;
> > +        return 0;
> > +}
> > +
> > +int kgdb8250_hook(void)
> > +{
> > +	int retval;
> > +
> > +	/*
> > +	 * Set port and irq number.
> > +	 */
> > +	kgdb8250_irq = rs_table[kgdb8250_ttyS].irq;
> > +	switch(rs_table[kgdb8250_ttyS].iotype)
> > +	{
> > +	case SERIAL_IO_MEM:
> > +		kgdb8250_port = (unsigned long)rs_table[kgdb8250_ttyS].membase;
> > +		serial_inb = direct_inb;
> > +		serial_outb = direct_outb;
> > +		break;
> > +	default:
> > +		kgdb8250_port = rs_table[kgdb8250_ttyS].line;
> > +		serial_inb = io_inb;
> > +		serial_outb = io_outb;
> > +	}
> > +
> > +#ifdef CONFIG_SERIAL_8250
> > +	if ((retval = serial8250_release_irq(kgdb8250_irq)) < 0)
> > +		return retval;
> > +#endif
> > +
> > +	if ((retval = kgdb8250_init(kgdb8250_ttyS, kgdb8250_baud)) < 0)
> > +		return retval;
> > +
> > +	retval = request_irq(kgdb8250_irq, kgdb8250_interrupt, SA_INTERRUPT,
> > +                         "GDB-stub", NULL);
> > +	return retval;
> > +}
> > +
> > +void
> > +kgdb8250_add_port(int i, struct uart_port *serial_req)
> > +{
> > +	rs_table[i].iotype = serial_req->iotype;
> > +	rs_table[i].line = serial_req->line;
> > +	rs_table[i].membase = serial_req->membase;
> > +	rs_table[i].regshift = serial_req->regshift;
> > +}
> > +
> > +struct kgdb_serial kgdb8250_serial_driver = {
> > +	.read_char = kgdb8250_read_char,
> > +	.write_char = kgdb8250_write_char,
> > +	.hook = kgdb8250_hook
> > +};
> > +
> > +/*
> > + * Syntax for this cmdline option is
> > + * kgdb8250=ttyno,baudrate
> > + */
> > +
> > +static int __init kgdb8250_opt(char *str)
> > +{
> > +	if (*str < '0' || *str > '3')
> > +		goto errout;
> > +	kgdb8250_ttyS = *str - '0';
> > +	str++;
> > +	if (*str != ',')
> > +		goto errout;
> > +	str++;
> > +	kgdb8250_baud = simple_strtoul(str, NULL, 10);
> > +	if (kgdb8250_baud != 9600 && kgdb8250_baud != 19200 &&
> > +	    kgdb8250_baud != 38400 && kgdb8250_baud != 57600 &&
> > +	    kgdb8250_baud != 115200)
> > +		goto errout;
> > +	kgdb_serial = &kgdb8250_serial_driver;
> > +	return 1;
> > +
> > +errout:
> > +	printk("Invalid syntax for option kgdb8250=\n");
> > +	return 0;
> > +}
> > +
> > +__setup("kgdb8250=", kgdb8250_opt);
> > --- clean.2.5/drivers/serial/serial_core.c	2004-02-05 01:54:11.000000000
> > +0100 +++ linux-mm/drivers/serial/serial_core.c	2004-02-16
> > 23:09:06.000000000 +0100 @@ -917,7 +917,11 @@
> >  static void uart_break_ctl(struct tty_struct *tty, int break_state)
> >  {
> >  	struct uart_state *state = tty->driver_data;
> > -	struct uart_port *port = state->port;
> > +	struct uart_port *port;
> > +
> > +	if (!state)
> > +		return;
> > +	port = state->port;
> >
> >  	BUG_ON(!kernel_locked());
> >
> > --- clean.2.5/include/linux/debugger.h	2004-02-17 11:38:14.000000000
> > +0100 +++ linux-mm/include/linux/debugger.h	2004-02-16 23:09:06.000000000
> > +0100 @@ -0,0 +1,66 @@
> > +#ifndef _DEBUGGER_H_
> > +#define _DEBUGGER_H_
> > +
> > +/*
> > + * Copyright (C) 2003-2004 Amit S. Kale
> > + *
> > + * Definition switchout for debuggers
> > + */
> > +
> > +/*
> > + * KGDB
> > + */
> > +#ifdef CONFIG_KGDB
> > +
> > +typedef int gdb_debug_hook(int exVector, int signo, int err_code,
> > +                            struct pt_regs *regs);
> > +extern gdb_debug_hook  *linux_debug_hook;
> > +#define	CHK_DEBUGGER(trapnr,signr,error_code,regs,after)			\
> > +    {									\
> > +	if (linux_debug_hook != (gdb_debug_hook *) NULL && !user_mode(regs)) \
> > +	{								\
> > +		(*linux_debug_hook)(trapnr, signr, error_code, regs) ;	\
> > +		after;							\
> > +	}								\
> > +    }
> > +
> > +void kgdb_nmihook(int cpu, void *regs);
> > +static inline void debugger_nmihook(int cpu, void *regs)
> > +{
> > +	kgdb_nmihook(cpu, regs);
> > +}
> > +
> > +void kgdb_entry(void);
> > +static inline void debugger_entry(void)
> > +{
> > +	kgdb_entry();
> > +}
> > +
> > +extern int debugger_step;
> > +extern atomic_t debugger_active;
> > +
> > +/*
> > + * No debugger in the kernel
> > + */
> > +#else
> > +
> > +#define	CHK_DEBUGGER(trapnr,signr,error_code,regs,after)
> > +
> > +static inline void debugger_nmihook(int cpu, void *regs)
> > +{
> > +	/* Do nothing */
> > +}
> > +
> > +static inline void debugger_entry(void)
> > +{
> > +	/* Do nothing */
> > +}
> > +
> > +#define debugger_step 0
> > +static const atomic_t debugger_active = { 0 };
> > +#define debugger_memerr_expected 0
> > +
> > +#endif
> > +
> > +
> > +#endif /* _DEBUGGER_H_ */
> > --- clean.2.5/include/linux/kgdb.h	2004-02-17 11:38:23.000000000 +0100
> > +++ linux-mm/include/linux/kgdb.h	2004-02-16 23:09:06.000000000 +0100
> > @@ -0,0 +1,112 @@
> > +#ifndef _KGDB_H_
> > +#define _KGDB_H_
> > +
> > +/*
> > + * Copyright (C) 2001-2004 Amit S. Kale
> > + */
> > +
> > +#include <linux/ptrace.h>
> > +#include <asm/kgdb.h>
> > +#include <linux/spinlock.h>
> > +#include <asm/atomic.h>
> > +#include <linux/debugger.h>
> > +
> > +/* To enter the debugger explicitly. */
> > +void breakpoint(void);
> > +
> > +#ifndef KGDB_MAX_NO_CPUS
> > +#if CONFIG_NR_CPUS > 8
> > +#error KGDB can handle max 8 CPUs
> > +#endif
> > +#define KGDB_MAX_NO_CPUS 8
> > +#endif
> > +
> > +extern atomic_t kgdb_setting_breakpoint;
> > +extern atomic_t kgdb_killed_or_detached;
> > +extern atomic_t kgdb_might_be_resumed;
> > +
> > +extern struct task_struct *kgdb_usethread, *kgdb_contthread;
> > +
> > +enum kgdb_bptype
> > +{
> > +	bp_breakpoint = '0',
> > +	bp_hardware_breakpoint,
> > +	bp_write_watchpoint,
> > +	bp_read_watchpoint,
> > +	bp_access_watchpoint
> > +};
> > +
> > +enum kgdb_bpstate
> > +{
> > +       bp_disabled,
> > +       bp_enabled
> > +};
> > +
> > +struct kgdb_bkpt
> > +{
> > +       unsigned long		bpt_addr;
> > +       unsigned char		saved_instr[BREAK_INSTR_SIZE];
> > +       enum kgdb_bptype		type;
> > +       enum kgdb_bpstate	state;
> > +};
> > +
> > +#ifndef BREAK_INSTR_SIZE
> > +#error BREAK_INSTR_SIZE  needed by kgdb
> > +#endif
> > +
> > +#ifndef MAX_BREAKPOINTS
> > +#define MAX_BREAKPOINTS        16
> > +#endif
> > +
> > +#define KGDB_HW_BREAKPOINT          1
> > +
> > +/* These are functions that the arch specific code can, and in some
> > cases + * must, provide. */
> > +extern int kgdb_arch_init(void);
> > +extern void regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs
> > *regs); +extern void sleeping_thread_to_gdb_regs(unsigned long
> > *gdb_regs,struct task_struct *p); +extern void gdb_regs_to_regs(unsigned
> > long *gdb_regs, struct pt_regs *regs); +extern void
> > kgdb_printexceptioninfo(int exceptionNo, int errorcode, +		char *buffer);
> > +extern void kgdb_disable_hw_debug(struct pt_regs *regs);
> > +extern void kgdb_post_master_code(struct pt_regs *regs, int eVector,
> > +		int err_code);
> > +extern int kgdb_arch_handle_exception(int vector, int signo, int
> > err_code, +		char *InBuffer, char *outBuffer, struct pt_regs *regs);
> > +extern int kgdb_arch_set_break(unsigned long addr, int type);
> > +extern int kgdb_arch_remove_break(unsigned long addr, int type);
> > +extern void kgdb_correct_hw_break(void);
> > +extern void kgdb_shadowinfo(struct pt_regs *regs, char *buffer, unsigned
> > threadid); +extern struct task_struct *kgdb_get_shadow_thread(struct
> > pt_regs *regs, +		int threadid);
> > +extern struct pt_regs *kgdb_shadow_regs(struct pt_regs *regs, int
> > threadid); +
> > +struct kgdb_arch {
> > +	unsigned char gdb_bpt_instr[BREAK_INSTR_SIZE];
> > +	unsigned long flags;
> > +	unsigned shadowth;
> > +};
> > +
> > +/* Thread reference */
> > +typedef unsigned char threadref[8];
> > +
> > +struct kgdb_serial {
> > +	int (*read_char)(void);
> > +	void (*write_char)(int);
> > +	void (*flush)(void);
> > +	int (*hook)(void);
> > +};
> > +
> > +extern struct kgdb_serial *kgdb_serial;
> > +extern struct kgdb_arch arch_kgdb_ops;
> > +extern int kgdb_initialized;
> > +
> > +struct uart_port;
> > +
> > +extern void kgdb8250_add_port(int i, struct uart_port *serial_req);
> > +
> > +int kgdb_hex2long(char **ptr, long *longValue);
> > +char *kgdb_mem2hex(char *mem, char *buf, int count);
> > +char *kgdb_hex2mem(char *buf, char *mem, int count);
> > +
> > +#endif /* _KGDB_H_ */
> > --- clean.2.5/init/main.c	2004-02-05 01:54:30.000000000 +0100
> > +++ linux-mm/init/main.c	2004-02-16 23:09:06.000000000 +0100
> > @@ -39,6 +39,7 @@
> >  #include <linux/writeback.h>
> >  #include <linux/cpu.h>
> >  #include <linux/efi.h>
> > +#include <linux/debugger.h>
> >
> >  #include <asm/io.h>
> >  #include <asm/bugs.h>
> > @@ -580,6 +581,7 @@
> >  	do_pre_smp_initcalls();
> >
> >  	smp_init();
> > +	debugger_entry();
> >  	do_basic_setup();
> >
> >  	prepare_namespace();
> > --- clean.2.5/kernel/Makefile	2003-10-09 00:14:41.000000000 +0200
> > +++ linux-mm/kernel/Makefile	2004-02-16 23:09:06.000000000 +0100
> > @@ -19,6 +19,7 @@
> >  obj-$(CONFIG_COMPAT) += compat.o
> >  obj-$(CONFIG_IKCONFIG) += configs.o
> >  obj-$(CONFIG_IKCONFIG_PROC) += configs.o
> > +obj-$(CONFIG_KGDB) += kgdbstub.o
> >
> >  ifneq ($(CONFIG_IA64),y)
> >  # According to Alan Modra <alan@linuxcare.com.au>, the
> > -fno-omit-frame-pointer is --- clean.2.5/kernel/kgdbstub.c	2004-02-17
> > 11:38:39.000000000 +0100 +++ linux-mm/kernel/kgdbstub.c	2004-02-16
> > 23:09:06.000000000 +0100 @@ -0,0 +1,1271 @@
> > +/*
> > + * This program is free software; you can redistribute it and/or modify
> > it + * under the terms of the GNU General Public License as published by
> > the + * Free Software Foundation; either version 2, or (at your option)
> > any + * later version.
> > + *
> > + * This program is distributed in the hope that it will be useful, but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * General Public License for more details.
> > + */
> > +
> > +/*
> > + * Copyright (C) 2000-2001 VERITAS Software Corporation.
> > + * Copyright (C) 2002-2004 Timesys Corporation
> > + * Copyright (C) 2003-2004 Amit S. Kale
> > + * Copyright (C) 2004 Pavel Machek <pavel@suse.cz>
> > + *
> > + * Restructured KGDB for 2.6 kernels.
> > + * thread support, support for multiple processors,support for
> > ia-32(x86) + * hardware debugging, Console support, handling nmi watchdog
> > + * - Amit S. Kale ( amitkale@emsyssoft.com )
> > + *
> > + * Several enhancements by George Anzinger <george@mvista.com>
> > + * Generic KGDB Support
> > + * Implemented by Anurekh Saxena (anurekh.saxena@timesys.com)
> > + *
> > + * Contributor:     Lake Stevens Instrument Division
> > + * Written by:      Glenn Engel
> > + *
> > + * Modified for 386 by Jim Kingdon, Cygnus Support.
> > + * Origianl kgdb, compatibility with 2.1.xx kernel by David Grothe
> > <dave@gcom.com> + * Integrated into 2.2.5 kernel by Tigran Aivazian
> > <tigran@sco.com> + */
> > +
> > +#include <linux/string.h>
> > +#include <linux/kernel.h>
> > +#include <linux/sched.h>
> > +#include <linux/smp.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/delay.h>
> > +#include <linux/mm.h>
> > +#include <asm/system.h>
> > +#include <asm/ptrace.h>
> > +#include <asm/uaccess.h>
> > +#include <linux/kgdb.h>
> > +#include <asm/atomic.h>
> > +#include <linux/notifier.h>
> > +#include <linux/module.h>
> > +#include <asm/cacheflush.h>
> > +#ifdef CONFIG_KGDB_CONSOLE
> > +#include <linux/console.h>
> > +#endif
> > +#include <linux/init.h>
> > +
> > +extern int pid_max;
> > +
> > +#define BUF_THREAD_ID_SIZE 16
> > +
> > +/*
> > + * kgdb_initialized indicates that kgdb is setup and is all ready to
> > serve + * breakpoints and other kernel exceptions. kgdb_connected
> > indicates that kgdb + * has connected to kgdb.
> > + */
> > +int kgdb_initialized = 0;
> > +static volatile int kgdb_connected;
> > +
> > +/* If non-zero, wait for a gdb connection when kgdb_entry is called */
> > +int kgdb_enter = 0;
> > +
> > +/* Set to 1 to make kgdb allow access to user addresses. Can be set from
> > gdb + * also at runtime. */
> > +int kgdb_useraccess = 0;
> > +
> > +struct kgdb_serial *kgdb_serial;
> > +
> > +/*
> > + * Holds information about breakpoints in a kernel. These breakpoints
> > are + * added and removed by gdb.
> > + */
> > +struct kgdb_bkpt kgdb_break[MAX_BREAKPOINTS];
> > +
> > +struct kgdb_arch *kgdb_ops = &arch_kgdb_ops;
> > +
> > +static const char hexchars[] = "0123456789abcdef";
> > +
> > +static spinlock_t slavecpulocks[KGDB_MAX_NO_CPUS];
> > +static volatile int procindebug[KGDB_MAX_NO_CPUS];
> > +atomic_t kgdb_setting_breakpoint;
> > +atomic_t kgdb_killed_or_detached;
> > +atomic_t kgdb_might_be_resumed;
> > +struct task_struct *kgdb_usethread, *kgdb_contthread;
> > +
> > +int debugger_step;
> > +atomic_t debugger_active;
> > +
> > +/* This will point to kgdb_handle_exception by default.
> > + * The architecture code can override this in its init function
> > + */
> > +gdb_debug_hook *linux_debug_hook;
> > +
> > +static char remcomInBuffer[BUFMAX];
> > +static char remcomOutBuffer[BUFMAX];
> > +
> > +/*
> > + * The following are the stub functions for code which is arch specific
> > + * and can be omitted on some arches
> > + * This function will handle the initalization of any architecture
> > specific + * hooks.  If there is a suitable early output driver,
> > kgdb_serial + * can be pointed at it now.
> > + */
> > +int __attribute__ ((weak))
> > +kgdb_arch_init(void)
> > +{
> > +	return 0;
> > +}
> > +
> > +void __attribute__ ((weak))
> > +regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
> > +{
> > +}
> > +
> > +void __attribute__ ((weak))
> > +sleeping_thread_to_gdb_regs(unsigned long *gdb_regs,struct task_struct
> > *p) +{
> > +}
> > +
> > +void __attribute__ ((weak))
> > +gdb_regs_to_regs(unsigned long *gdb_regs, struct pt_regs *regs)
> > +{
> > +}
> > +
> > +void __attribute__ ((weak))
> > +kgdb_printexceptioninfo(int exceptionNo, int errorcode, char *buffer)
> > +{
> > +}
> > +
> > +void __attribute__ ((weak))
> > +kgdb_disable_hw_debug(struct pt_regs *regs)
> > +{
> > +}
> > +
> > +void __attribute__ ((weak))
> > +kgdb_post_master_code(struct pt_regs *regs, int eVector, int err_code)
> > +{
> > +}
> > +
> > +/*
> > + * Handle any additional commands.  This must handle the 'c' and 's'
> > + * command packets.
> > + * Return -1 to loop over other commands, and 0 to exit from KGDB
> > + */
> > +int __attribute__ ((weak))
> > +kgdb_arch_handle_exception(int vector, int signo, int err_code, char
> > *InBuffer, +		char *outBuffer, struct pt_regs *regs)
> > +{
> > +	return 0;
> > +}
> > +
> > +int __attribute__ ((weak))
> > +kgdb_arch_set_break(unsigned long addr, int type)
> > +{
> > +	return 0;
> > +}
> > +
> > +int __attribute__ ((weak))
> > +kgdb_arch_remove_break(unsigned long addr, int type)
> > +{
> > +	return 0;
> > +}
> > +
> > +void __attribute__ ((weak))
> > +kgdb_correct_hw_break(void)
> > +{
> > +}
> > +
> > +void __attribute__ ((weak))
> > +kgdb_shadowinfo(struct pt_regs *regs, char *buffer, unsigned threadid)
> > +{
> > +}
> > +
> > +struct task_struct __attribute__ ((weak))
> > +*kgdb_get_shadow_thread(struct pt_regs *regs, int threadid)
> > +{
> > +	return NULL;
> > +}
> > +
> > +struct pt_regs __attribute__ ((weak))
> > +*kgdb_shadow_regs(struct pt_regs *regs, int threadid)
> > +{
> > +	return NULL;
> > +}
> > +
> > +static int hex(char ch)
> > +{
> > +	if ((ch >= 'a') && (ch <= 'f'))
> > +		return (ch - 'a' + 10);
> > +	if ((ch >= '0') && (ch <= '9'))
> > +		return (ch - '0');
> > +	if ((ch >= 'A') && (ch <= 'F'))
> > +		return (ch - 'A' + 10);
> > +	return (-1);
> > +}
> > +
> > +/* scan for the sequence $<data>#<checksum>	*/
> > +static void getpacket(char *buffer)
> > +{
> > +	unsigned char checksum;
> > +	unsigned char xmitcsum;
> > +	int i;
> > +	int count;
> > +	char ch;
> > +
> > +	do {
> > +	/* wait around for the start character, ignore all other characters */
> > +		while ((ch = (kgdb_serial->read_char() & 0x7f)) != '$');
> > +		checksum = 0;
> > +		xmitcsum = -1;
> > +
> > +		count = 0;
> > +
> > +		/* now, read until a # or end of buffer is found */
> > +		while (count < (BUFMAX - 1)) {
> > +			ch = kgdb_serial->read_char() & 0x7f;
> > +			if (ch == '#')
> > +				break;
> > +			checksum = checksum + ch;
> > +			buffer[count] = ch;
> > +			count = count + 1;
> > +		}
> > +		buffer[count] = 0;
> > +
> > +		if (ch == '#') {
> > +			xmitcsum = hex(kgdb_serial->read_char() & 0x7f) << 4;
> > +			xmitcsum += hex(kgdb_serial->read_char() & 0x7f);
> > +
> > +			if (checksum != xmitcsum)
> > +				kgdb_serial->write_char('-');	/* failed checksum */
> > +			else {
> > +				kgdb_serial->write_char('+');	/* successful transfer */
> > +				/* if a sequence char is present, reply the sequence ID */
> > +				if (buffer[2] == ':') {
> > +					kgdb_serial->write_char(buffer[0]);
> > +					kgdb_serial->write_char(buffer[1]);
> > +					/* remove sequence chars from buffer */
> > +					count = strlen(buffer);
> > +					for (i = 3; i <= count; i++)
> > +						buffer[i - 3] = buffer[i];
> > +				}
> > +			}
> > +			if (kgdb_serial->flush)
> > +				kgdb_serial->flush();
> > +		}
> > +	} while (checksum != xmitcsum);
> > +}
> > +
> > +/*
> > + * Send the packet in buffer.
> > + * Check for gdb connection if asked for.
> > + */
> > +static void putpacket(char *buffer, int checkconnect)
> > +{
> > +	unsigned char checksum;
> > +	int count;
> > +	char ch;
> > +	static char gdbseq[] = "$Hc-1#09";
> > +	int i;
> > +	int send_count;
> > +
> > +	/*  $<packet info>#<checksum>. */
> > +	do {
> > +		kgdb_serial->write_char('$');
> > +		checksum = 0;
> > +		count = 0;
> > +		send_count = 0;
> > +
> > +		while ((ch = buffer[count])) {
> > +			kgdb_serial->write_char(ch);
> > +			checksum += ch;
> > +			count ++;
> > +			send_count ++;
> > +		}
> > +
> > +		kgdb_serial->write_char('#');
> > +		kgdb_serial->write_char(hexchars[checksum >> 4]);
> > +		kgdb_serial->write_char(hexchars[checksum % 16]);
> > +		if (kgdb_serial->flush)
> > +			kgdb_serial->flush();
> > +
> > +		i = 0;
> > +		while ((ch = kgdb_serial->read_char()) == gdbseq[i++] &&
> > +		       checkconnect) {
> > +			if (!gdbseq[i]) {
> > +				kgdb_serial->write_char('+');
> > +				if (kgdb_serial->flush)
> > +					kgdb_serial->flush();
> > +				breakpoint();
> > +
> > +				/*
> > +				 * GDB is available now.
> > +				 * Retransmit this packet.
> > +				 */
> > +				break;
> > +			}
> > +		}
> > +		if (checkconnect && ch == 3) {
> > +			kgdb_serial->write_char('+');
> > +			if (kgdb_serial->flush)
> > +				kgdb_serial->flush();
> > +			breakpoint();
> > +		}
> > +	} while (( ch & 0x7f) != '+');
> > +
> > +}
> > +
> > +static int get_char(char *addr, unsigned char *data)
> > +{
> > +	mm_segment_t fs;
> > +	int ret = 0;
> > +
> > +	if (!kgdb_useraccess && (unsigned long)addr < TASK_SIZE) {
> > +		return -EINVAL;
> > +	}
> > +	wmb();
> > +	fs = get_fs();
> > +	set_fs(KERNEL_DS);
> > +
> > +	if (get_user(*data, addr) != 0) {
> > +		ret = -EFAULT;
> > +	}
> > +
> > +	set_fs(fs);
> > +	return ret;
> > +}
> > +
> > +static int set_char(char *addr, int data)
> > +{
> > +	mm_segment_t fs;
> > +	int ret = 0;
> > +
> > +	if (!kgdb_useraccess && (unsigned long)addr < TASK_SIZE) {
> > +		return -EINVAL;
> > +	}
> > +	wmb();
> > +	fs = get_fs();
> > +	set_fs(KERNEL_DS);
> > +
> > +	if (put_user(data, addr) != 0) {
> > +		ret = -EFAULT;
> > +	}
> > +
> > +	set_fs(fs);
> > +	return ret;
> > +}
> > +
> > +/*
> > + * convert the memory pointed to by mem into hex, placing result in buf
> > + * return a pointer to the last char put in buf (null). May return an
> > error. + */
> > +char *kgdb_mem2hex(char *mem, char *buf, int count)
> > +{
> > +	int i;
> > +	unsigned char ch;
> > +	int error;
> > +
> > +	for (i = 0; i < count; i++) {
> > +
> > +		if ((error = get_char(mem++, &ch)) < 0)
> > +			return ERR_PTR(error);
> > +
> > +		*buf++ = hexchars[ch >> 4];
> > +		*buf++ = hexchars[ch % 16];
> > +	}
> > +	*buf = 0;
> > +	return (buf);
> > +}
> > +
> > +/*
> > + * convert the hex array pointed to by buf into binary to be placed in
> > mem + * return a pointer to the character AFTER the last byte written + *
> > May return an error.
> > + */
> > +char *kgdb_hex2mem(char *buf, char *mem, int count)
> > +{
> > +	int i;
> > +	unsigned char ch;
> > +	int error;
> > +
> > +	for (i = 0; i < count; i++) {
> > +		ch = hex(*buf++) << 4;
> > +		ch = ch + hex(*buf++);
> > +		if ((error = set_char(mem++, ch)) < 0)
> > +			return ERR_PTR(error);
> > +	}
> > +	return (mem);
> > +}
> > +
> > +/*
> > + * While we find nice hex chars, build a longValue.
> > + * Return number of chars processed.
> > + */
> > +int kgdb_hex2long(char **ptr, long *longValue)
> > +{
> > +	int numChars = 0;
> > +	int hexValue;
> > +
> > +	*longValue = 0;
> > +
> > +	while (**ptr) {
> > +		hexValue = hex(**ptr);
> > +		if (hexValue >= 0) {
> > +			*longValue = (*longValue << 4) | hexValue;
> > +			numChars++;
> > +		} else
> > +			break;
> > +
> > +		(*ptr)++;
> > +	}
> > +
> > +	return (numChars);
> > +}
> > +
> > +static inline char *pack_hex_byte(char *pkt, int byte)
> > +{
> > +	*pkt++ = hexchars[(byte >> 4) & 0xf];
> > +	*pkt++ = hexchars[(byte & 0xf)];
> > +	return pkt;
> > +}
> > +
> > +static inline void error_packet(char *pkt, int error)
> > +{
> > +	error = -error;
> > +	pkt[0] = 'E';
> > +	pkt[1] = hexchars[(error / 10)];
> > +	pkt[2] = hexchars[(error % 10)];
> > +	pkt[3] = '\0';
> > +}
> > +
> > +static void ok_packet(char *pkt)
> > +{
> > +	strcpy(pkt, "OK");
> > +}
> > +
> > +static char *pack_threadid(char *pkt, threadref *id)
> > +{
> > +	char *limit;
> > +	unsigned char *altid;
> > +
> > +	altid = (unsigned char *) id;
> > +	limit = pkt + BUF_THREAD_ID_SIZE;
> > +	while (pkt < limit)
> > +		pkt = pack_hex_byte(pkt, *altid++);
> > +
> > +	return pkt;
> > +}
> > +
> > +void int_to_threadref(threadref *id, int value)
> > +{
> > +	unsigned char *scan;
> > +
> > +	scan = (unsigned char *) id;
> > +	{
> > +		int i = 4;
> > +		while (i--)
> > +			*scan++ = 0;
> > +	}
> > +	*scan++ = (value >> 24) & 0xff;
> > +	*scan++ = (value >> 16) & 0xff;
> > +	*scan++ = (value >> 8) & 0xff;
> > +	*scan++ = (value & 0xff);
> > +}
> > +
> > +static struct task_struct *getthread(struct pt_regs *regs,int tid)
> > +{
> > +	int i;
> > +	struct list_head *l;
> > +	struct task_struct *p;
> > +	struct pid *pid;
> > +
> > +	if (tid >= pid_max + num_online_cpus() + kgdb_ops->shadowth) {
> > +		return NULL;
> > +	}
> > +	if (tid >= pid_max + num_online_cpus()) {
> > +		return kgdb_get_shadow_thread(regs, tid - pid_max -
> > +				num_online_cpus());
> > +	}
> > +	if (tid >= pid_max) {
> > +		i = 0;
> > +		for_each_task_pid(0, PIDTYPE_PID, p, l, pid) {
> > +			if (tid == pid_max + i) {
> > +				return p;
> > +			}
> > +			i++;
> > +		}
> > +		return NULL;
> > +	}
> > +	if (!tid) {
> > +		return NULL;
> > +	}
> > +	return find_task_by_pid(tid);
> > +}
> > +
> > +#ifdef CONFIG_SMP
> > +void kgdb_wait(struct pt_regs *regs)
> > +{
> > +	unsigned long flags;
> > +	int processor;
> > +
> > +	local_irq_save(flags);
> > +	processor = smp_processor_id();
> > +	procindebug[processor] = 1;
> > +	current->thread.debuggerinfo = regs;
> > +
> > +	/* Wait till master processor goes completely into the debugger. FIXME:
> > this looks racy */ +	while (!procindebug[atomic_read(&debugger_active) -
> > 1]) {
> > +		int i = 10;	/* an arbitrary number */
> > +
> > +		while (--i)
> > +			asm volatile ("nop": : : "memory");
> > +		barrier();
> > +	}
> > +
> > +	/* Wait till master processor is done with debugging */
> > +	spin_lock(slavecpulocks + processor);
> > +
> > +	/* This has been taken from x86 kgdb implementation and
> > +	 * will be needed by architectures that have SMP support
> > +	 */
> > +	kgdb_correct_hw_break();
> > +
> > +	/* Signal the master processor that we are done */
> > +	procindebug[processor] = 0;
> > +	spin_unlock(slavecpulocks + processor);
> > +	local_irq_restore(flags);
> > +}
> > +#endif
> > +
> > +static int get_mem (char *addr, unsigned char *buf, int count)
> > +{
> > +	int error;
> > +	while (count) {
> > +		if((error = get_char(addr++, buf)) <  0)
> > +			return error;
> > +		buf++;
> > +		count--;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int set_mem (char *addr,unsigned char *buf, int count)
> > +{
> > +	int error;
> > +	while (count) {
> > +		if ((error = set_char(addr++,*buf++)) < 0)
> > +			return error;
> > +		count--;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int set_break (unsigned long addr)
> > +{
> > +	int i, breakno = -1;
> > +	int error;
> > +
> > +	for (i = 0; i < MAX_BREAKPOINTS; i++) {
> > +		if ((kgdb_break[i].state == bp_enabled) &&
> > +		    (kgdb_break[i].bpt_addr == addr)) {
> > +			return -EEXIST;
> > +		}
> > +
> > +		if (kgdb_break[i].state == bp_disabled) {
> > +			if ((breakno == -1) || (kgdb_break[i].bpt_addr == addr))
> > +				breakno = i;
> > +		}
> > +	}
> > +	if (breakno == -1)
> > +		return -E2BIG;
> > +
> > +	if ((error = get_mem((char *)addr, kgdb_break[breakno].saved_instr,
> > +				BREAK_INSTR_SIZE)) < 0)
> > +		return error;
> > +
> > +	if ((error = set_mem((char *)addr, kgdb_ops->gdb_bpt_instr,
> > +					BREAK_INSTR_SIZE)) < 0)
> > +		return error;
> > +	flush_cache_range (current->mm, addr, addr + BREAK_INSTR_SIZE);
> > +	flush_icache_range (addr, addr + BREAK_INSTR_SIZE);
> > +
> > +	kgdb_break[breakno].state = bp_enabled;
> > +	kgdb_break[breakno].type = bp_breakpoint;
> > +	kgdb_break[breakno].bpt_addr = addr;
> > +
> > +	return 0;
> > +}
> > +
> > +static int remove_break (unsigned long addr)
> > +{
> > +	int i;
> > +	int error;
> > +
> > +	for (i=0; i < MAX_BREAKPOINTS; i++) {
> > +		if ((kgdb_break[i].state == bp_enabled) &&
> > +		   (kgdb_break[i].bpt_addr == addr)) {
> > +			if ((error =set_mem((char *)addr, kgdb_break[i].saved_instr,
> > +			        BREAK_INSTR_SIZE)) < 0)
> > +				return error;
> > +			flush_cache_range (current->mm, addr, addr + BREAK_INSTR_SIZE);
> > +			flush_icache_range (addr, addr + BREAK_INSTR_SIZE);
> > +			kgdb_break[i].state = bp_disabled;
> > +			return 0;
> > +		}
> > +	}
> > +	return -ENOENT;
> > +}
> > +
> > +int remove_all_break(void)
> > +{
> > +	int i;
> > +	int error;
> > +	for (i=0; i < MAX_BREAKPOINTS; i++) {
> > +		if(kgdb_break[i].state == bp_enabled) {
> > +			unsigned long addr = kgdb_break[i].bpt_addr;
> > +			if ((error = set_mem((char *)addr, kgdb_break[i].saved_instr,
> > +			       BREAK_INSTR_SIZE)) < 0)
> > +				return error;
> > +			flush_cache_range (current->mm, addr, addr + BREAK_INSTR_SIZE);
> > +			flush_icache_range (addr, addr + BREAK_INSTR_SIZE);
> > +		}
> > +		kgdb_break[i].state = bp_disabled;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static inline int shadow_pid(int realpid)
> > +{
> > +	if (realpid) {
> > +		return realpid;
> > +	}
> > +	return pid_max + smp_processor_id();
> > +}
> > +
> > +/*
> > + * This function does all command procesing for interfacing to gdb.
> > + *
> > + * Locking hierarchy:
> > + *	interface locks, if any (begin_session)
> > + *	kgdb lock (debugger_active)
> > + *
> > + */
> > +int kgdb_handle_exception(int exVector, int signo, int err_code,
> > +                     struct pt_regs *linux_regs)
> > +{
> > +	unsigned long length, addr;
> > +	char *ptr;
> > +	unsigned long flags;
> > +	unsigned long gdb_regs[NUMREGBYTES / sizeof (unsigned long)];
> > +	int i;
> > +	long threadid;
> > +	threadref thref;
> > +	struct task_struct *thread = NULL;
> > +	unsigned procid;
> > +	static char tmpstr[256];
> > +	int numshadowth = num_online_cpus() + kgdb_ops->shadowth;
> > +	long kgdb_usethreadid = 0;
> > +	int error = 0;
> > +
> > +	/* Panic on recursive debugger calls. */
> > +	if (atomic_read(&debugger_active) == smp_processor_id() + 1) {
> > +		return 0;
> > +	}
> > +
> > +	/*
> > +	 * Interrupts will be restored by the 'trap return' code, except when
> > +	 * single stepping.
> > +	 */
> > +	local_irq_save(flags);
> > +
> > +	/* Hold debugger_active */
> > +	procid = smp_processor_id();
> > +	while (cmpxchg(&atomic_read(&debugger_active), 0, (procid + 1)) != 0) {
> > +		int i = 25;	/* an arbitrary number */
> > +
> > +		while (--i)
> > +			asm volatile ("nop": : : "memory");
> > +	}
> > +
> > +	debugger_step = 0;
> > +
> > +	current->thread.debuggerinfo = linux_regs;
> > +
> > +	kgdb_disable_hw_debug(linux_regs);
> > +
> > +	for (i = 0; i < num_online_cpus(); i++) {
> > +		spin_lock(&slavecpulocks[i]);
> > +	}
> > +
> > +	/* spin_lock code is good enough as a barrier so we don't
> > +	 * need one here */
> > +	procindebug[smp_processor_id()] = 1;
> > +
> > +	/* Clear the out buffer. */
> > +	memset(remcomOutBuffer, 0, sizeof(remcomOutBuffer));
> > +
> > +	/* Master processor is completely in the debugger */
> > +	kgdb_post_master_code(linux_regs, exVector, err_code);
> > +
> > +	if (atomic_read(&kgdb_killed_or_detached) &&
> > +	    atomic_read(&kgdb_might_be_resumed)) {
> > +		getpacket(remcomInBuffer);
> > +		if(remcomInBuffer[0] == 'H' && remcomInBuffer[1] =='c') {
> > +			remove_all_break();
> > +			atomic_set(&kgdb_killed_or_detached, 0);
> > +			ok_packet(remcomOutBuffer);
> > +		}
> > +		else
> > +			return 1;
> > +	} else {
> > +
> > +		/* reply to host that an exception has occurred */
> > +		ptr = remcomOutBuffer;
> > +		*ptr++ = 'T';
> > +		*ptr++ = hexchars[(signo >> 4) % 16];
> > +		*ptr++ = hexchars[signo % 16];
> > +		ptr += strlen(strcpy(ptr, "thread:"));
> > +		int_to_threadref(&thref, shadow_pid(current->pid));
> > +		ptr = pack_threadid(ptr, &thref);
> > +		*ptr++ = ';';
> > +		*ptr = '\0';
> > +	}
> > +
> > +	putpacket(remcomOutBuffer, 0);
> > +	kgdb_connected = 1;
> > +
> > +	kgdb_usethread = current;
> > +	kgdb_usethreadid = shadow_pid(current->pid);
> > +
> > +	while (1) {
> > +		int bpt_type = 0;
> > +		error = 0;
> > +
> > +		/* Clear the out buffer. */
> > +		memset(remcomOutBuffer, 0, sizeof(remcomOutBuffer));
> > +
> > +		getpacket(remcomInBuffer);
> > +
> > +		switch (remcomInBuffer[0]) {
> > +		case '?':
> > +			remcomOutBuffer[0] = 'S';
> > +			remcomOutBuffer[1] = hexchars[signo >> 4];
> > +			remcomOutBuffer[2] = hexchars[signo % 16];
> > +			break;
> > +
> > +		case 'g':	/* return the value of the CPU registers */
> > +			thread = kgdb_usethread;
> > +
> > +			if (!thread)
> > +				thread = current;
> > +
> > +			/* All threads that don't have debuggerinfo should be
> > +			   in __schedule() sleeping, since all other CPUs
> > +			   are in kgdb_wait, and thus have debuggerinfo. */
> > +
> > +			if (kgdb_usethreadid >= pid_max + num_online_cpus()) {
> > +				regs_to_gdb_regs(gdb_regs,
> > +					kgdb_shadow_regs(linux_regs,
> > +						kgdb_usethreadid - pid_max -
> > +						num_online_cpus()));
> > +			} else if (thread->thread.debuggerinfo) {
> > +				if ((error = get_char(thread->thread.debuggerinfo,
> > +					(unsigned char *)gdb_regs)) < 0) {
> > +					error_packet(remcomOutBuffer, error);
> > +					break;
> > +				}
> > +				regs_to_gdb_regs(gdb_regs,
> > +					(struct pt_regs *)
> > +					thread->thread.debuggerinfo);
> > +			} else {
> > +				/* Pull stuff saved during
> > +				 * switch_to; nothing else is
> > +				 * accessible (or even particularly relevant).
> > +				 * This should be enough for a stack trace. */
> > +				sleeping_thread_to_gdb_regs(gdb_regs, thread);
> > +			}
> > +
> > +			kgdb_mem2hex((char *) gdb_regs, remcomOutBuffer, NUMREGBYTES);
> > +			break;
> > +
> > +		case 'G':	/* set the value of the CPU registers - return OK */
> > +			kgdb_hex2mem(&remcomInBuffer[1], (char *) gdb_regs,
> > +				NUMREGBYTES);
> > +
> > +			if (kgdb_usethread && kgdb_usethread != current)
> > +				error_packet(remcomOutBuffer, -EINVAL);
> > +			else {
> > +				gdb_regs_to_regs(gdb_regs,
> > +					(struct pt_regs *)
> > +					current->thread.debuggerinfo);
> > +				ok_packet(remcomOutBuffer);
> > +			}
> > +
> > +			break;
> > +
> > +			/* mAA..AA,LLLL  Read LLLL bytes at address AA..AA */
> > +		case 'm':
> > +			ptr = &remcomInBuffer[1];
> > +			if (kgdb_hex2long(&ptr, &addr) > 0 && *ptr++ == ',' &&
> > +			    kgdb_hex2long(&ptr, &length) > 0) {
> > +				if (IS_ERR(ptr = kgdb_mem2hex((char *) addr,
> > +							remcomOutBuffer,
> > +							length)))
> > +					error_packet(remcomOutBuffer,
> > +							PTR_ERR(ptr));
> > +			} else
> > +				error_packet(remcomOutBuffer, -EINVAL);
> > +			break;
> > +
> > +		/* MAA..AA,LLLL: Write LLLL bytes at address AA.AA return OK */
> > +		case 'M':
> > +			ptr = &remcomInBuffer[1];
> > +			if (kgdb_hex2long(&ptr, &addr) > 0 && *(ptr++) == ','
> > +				&& kgdb_hex2long(&ptr, &length) > 0 &&
> > +				*(ptr++) == ':') {
> > +				if (IS_ERR(ptr = kgdb_hex2mem(ptr, (char *)addr,
> > +							length)))
> > +					error_packet(remcomOutBuffer,
> > +							PTR_ERR(ptr));
> > +			} else
> > +				error_packet(remcomOutBuffer, -EINVAL);
> > +			break;
> > +
> > +			/* kill or detach. KGDB should treat this like a
> > +			 * continue.
> > +			 */
> > +		case 'D':
> > +			if ((error = remove_all_break()) < 0) {
> > +				error_packet(remcomOutBuffer, error);
> > +			} else {
> > +				ok_packet(remcomOutBuffer);
> > +				kgdb_connected = 0;
> > +			}
> > +			putpacket(remcomOutBuffer, 0);
> > +			goto default_handle;
> > +
> > +		case 'k':
> > +			/* Don't care about error from remove_all_break */
> > +			remove_all_break();
> > +			kgdb_connected = 0;
> > +			goto default_handle;
> > +
> > +			/* query */
> > +		case 'q':
> > +			switch (remcomInBuffer[1]) {
> > +			case 's':
> > +			case 'f':
> > +				if (memcmp(remcomInBuffer+2, "ThreadInfo",10))
> > +				{
> > +					error_packet(remcomOutBuffer,
> > +							-EINVAL);
> > +					break;
> > +				}
> > +				if (remcomInBuffer[1] == 'f') {
> > +					threadid = 1;
> > +				}
> > +				remcomOutBuffer[0] = 'm';
> > +				ptr = remcomOutBuffer + 1;
> > +				for (i = 0; i < 32 && threadid < pid_max +
> > +						numshadowth; threadid++) {
> > +					thread = getthread(linux_regs,
> > +							threadid);
> > +					if (thread) {
> > +						int_to_threadref(&thref,
> > +								threadid);
> > +						pack_threadid(ptr, &thref);
> > +						ptr += 16;
> > +						*(ptr++) = ',';
> > +						i++;
> > +					}
> > +				}
> > +				break;
> > +
> > +			case 'C':
> > +				/* Current thread id */
> > +				strcpy(remcomOutBuffer, "QC");
> > +
> > +				threadid = shadow_pid(current->pid);
> > +
> > +				int_to_threadref(&thref, threadid);
> > +				pack_threadid(remcomOutBuffer + 2, &thref);
> > +				break;
> > +
> > +			case 'E':
> > +				/* Print exception info */
> > +				kgdb_printexceptioninfo(exVector, err_code,
> > +						remcomOutBuffer);
> > +				break;
> > +			case 'T':
> > +				if (memcmp(remcomInBuffer+1,
> > +					"ThreadExtraInfo,",16))
> > +				{
> > +					error_packet(remcomOutBuffer, -EINVAL);
> > +					break;
> > +				}
> > +				threadid = 0;
> > +				ptr = remcomInBuffer+17;
> > +				kgdb_hex2long(&ptr, &threadid);
> > +				if (!getthread(linux_regs, threadid)) {
> > +					error_packet(remcomOutBuffer, -EINVAL);
> > +					break;
> > +				}
> > +				if (threadid < pid_max) {
> > +					kgdb_mem2hex(getthread(linux_regs,
> > +						threadid)->comm,
> > +						remcomOutBuffer, 16);
> > +				} else if (threadid >= pid_max +
> > +						num_online_cpus()) {
> > +					kgdb_shadowinfo(linux_regs,
> > +						remcomOutBuffer,
> > +						threadid - pid_max -
> > +						num_online_cpus());
> > +				} else {
> > +					sprintf(tmpstr, "Shadow task %d"
> > +						" for pid 0",
> > +						(int)(threadid - pid_max));
> > +					kgdb_mem2hex(tmpstr, remcomOutBuffer,
> > +							strlen(tmpstr));
> > +				}
> > +				break;
> > +			}
> > +			break;
> > +
> > +			/* task related */
> > +		case 'H':
> > +			switch (remcomInBuffer[1]) {
> > +			case 'g':
> > +				ptr = &remcomInBuffer[2];
> > +				kgdb_hex2long(&ptr, &threadid);
> > +				thread = getthread(linux_regs, threadid);
> > +				if (!thread && threadid > 0) {
> > +					error_packet(remcomOutBuffer, -EINVAL);
> > +					break;
> > +				}
> > +				kgdb_usethread = thread;
> > +				kgdb_usethreadid = threadid;
> > +				ok_packet(remcomOutBuffer);
> > +				break;
> > +
> > +			case 'c':
> > +				atomic_set(&kgdb_killed_or_detached, 0);
> > +				ptr = &remcomInBuffer[2];
> > +				kgdb_hex2long(&ptr, &threadid);
> > +				if (!threadid) {
> > +					kgdb_contthread = 0;
> > +				} else {
> > +					thread = getthread(linux_regs, threadid);
> > +					if (!thread && threadid > 0) {
> > +						error_packet(remcomOutBuffer,
> > +								-EINVAL);
> > +						break;
> > +					}
> > +					kgdb_contthread = thread;
> > +				}
> > +				ok_packet(remcomOutBuffer);
> > +				break;
> > +			}
> > +			break;
> > +
> > +			/* Query thread status */
> > +		case 'T':
> > +			ptr = &remcomInBuffer[1];
> > +			kgdb_hex2long(&ptr, &threadid);
> > +			thread = getthread(linux_regs, threadid);
> > +			if (thread)
> > +				ok_packet(remcomOutBuffer);
> > +			else
> > +				error_packet(remcomOutBuffer, -EINVAL);
> > +			break;
> > +		case 'z':
> > +		case 'Z':
> > +			ptr = &remcomInBuffer[2];
> > +			if (*(ptr++) != ',') {
> > +				error_packet(remcomOutBuffer, -EINVAL);
> > +				break;
> > +			}
> > +			kgdb_hex2long(&ptr, &addr);
> > +
> > +			bpt_type = remcomInBuffer[1];
> > +			if (bpt_type != bp_breakpoint) {
> > +				if (bpt_type == bp_hardware_breakpoint &&
> > +				    !(kgdb_ops->flags & KGDB_HW_BREAKPOINT))
> > +					break;
> > +
> > +				/* if set_break is not defined, then
> > +				 * remove_break does not matter
> > +				 */
> > +				if(!(kgdb_ops->flags & KGDB_HW_BREAKPOINT))
> > +					break;
> > +			}
> > +
> > +			if (remcomInBuffer[0] == 'Z') {
> > +				if (bpt_type == bp_breakpoint)
> > +					error = set_break(addr);
> > +				else
> > +					error = kgdb_arch_set_break(addr,
> > +							bpt_type);
> > +			}
> > +			else {
> > +				if (bpt_type == bp_breakpoint)
> > +					error = remove_break(addr);
> > +				else
> > +					error = kgdb_arch_remove_break(addr,
> > +							bpt_type);
> > +			}
> > +
> > +			if (error == 0)
> > +				ok_packet(remcomOutBuffer);
> > +			else
> > +				error_packet(remcomOutBuffer, error);
> > +
> > +			break;
> > +
> > +		default:
> > +		default_handle:
> > +			error = kgdb_arch_handle_exception(exVector, signo,
> > +					err_code, remcomInBuffer,
> > +					remcomOutBuffer, linux_regs);
> > +
> > +			if(error >= 0 || remcomInBuffer[0] == 'D' ||
> > +			    remcomInBuffer[0] == 'k')
> > +				goto kgdb_exit;
> > +
> > +
> > +		} /* switch */
> > +
> > +		/* reply to the request */
> > +		putpacket(remcomOutBuffer, 0);
> > +	}
> > +
> > +kgdb_exit:
> > +	procindebug[smp_processor_id()] = 0;
> > +
> > +	for (i = 0; i < num_online_cpus(); i++) {
> > +		spin_unlock(&slavecpulocks[i]);
> > +	}
> > +	/* Wait till all the processors have quit
> > +	 * from the debugger
> > +	 */
> > +	for (i = 0; i < num_online_cpus(); i++) {
> > +		while (procindebug[i]) {
> > +			int j = 10; /* an arbitrary number */
> > +
> > +			while (--j) {
> > +				asm volatile ("nop" : : : "memory");
> > +			}
> > +			barrier();
> > +		}
> > +	}
> > +
> > +	/* Free debugger_active */
> > +	atomic_set(&kgdb_killed_or_detached, 1);
> > +	atomic_set(&debugger_active, 0);
> > +	local_irq_restore(flags);
> > +
> > +	return error;
> > +}
> > +
> > +/*
> > + * GDB places a breakpoint at this function to know dynamically
> > + * loaded objects. It's not defined static so that only one instance
> > with this + * name exists in the kernel.
> > + */
> > +
> > +int module_event(struct notifier_block * self, unsigned long val, void *
> > data) +{
> > +	return 0;
> > +}
> > +
> > +static struct notifier_block kgdb_module_load_nb = {
> > +	.notifier_call = module_event,
> > +};
> > +
> > +/* This function will generate a breakpoint exception.  It is used at
> > the +   beginning of a program to sync up with a debugger and can be used
> > +   otherwise as a quick means to stop program execution and "break" into
> > +   the debugger. */
> > +
> > +void breakpoint(void)
> > +{
> > +	if (!kgdb_initialized) {
> > +		kgdb_enter = 1;
> > +		kgdb_entry();
> > +		if (!kgdb_initialized) {
> > +			printk("kgdb not enabled. Cannot do breakpoint\n");
> > +			return;
> > +		}
> > +	}
> > +
> > +	atomic_set(&kgdb_setting_breakpoint, 1);
> > +	wmb();
> > +	BREAKPOINT();
> > +	wmb();
> > +	atomic_set(&kgdb_setting_breakpoint, 0);
> > +}
> > +
> > +void kgdb_nmihook(int cpu, void *regs)
> > +{
> > +#ifdef CONFIG_SMP
> > +	if (!procindebug[cpu] && atomic_read(&debugger_active) != (cpu + 1)) {
> > +		kgdb_wait((struct pt_regs *)regs);
> > +	}
> > +#endif
> > +}
> > +
> > +void kgdb_entry(void)
> > +{
> > +	int i;
> > +
> > +	if (kgdb_initialized) {
> > +		/* KGDB was initialized */
> > +		return;
> > +	}
> > +
> > +	for (i = 0; i < KGDB_MAX_NO_CPUS; i++)
> > +		spin_lock_init(&slavecpulocks[i]);
> > +
> > +	/* Free debugger_active */
> > +	atomic_set(&debugger_active, 0);
> > +
> > +	/* This flag is used, if gdb has detached and wants to start
> > +	 * another session
> > +	 */
> > +	atomic_set(&kgdb_killed_or_detached, 1);
> > +	atomic_set(&kgdb_might_be_resumed, 0);
> > +
> > +	for (i = 0; i < MAX_BREAKPOINTS; i++)
> > +		kgdb_break[i].state = bp_disabled;
> > +
> > +	linux_debug_hook = kgdb_handle_exception;
> > +
> > +	/* Let the arch do any initalization it needs to, including
> > +	 * pointing to a suitable early output device. */
> > +	kgdb_arch_init();
> > +
> > +	/* We can't do much if this fails */
> > +	register_module_notifier(&kgdb_module_load_nb);
> > +
> > +	atomic_set(&kgdb_setting_breakpoint, 0);
> > +
> > +	if (!kgdb_serial || kgdb_serial->hook() < 0) {
> > +		/* KGDB interface isn't ready yet */
> > +		return;
> > +	}
> > +	kgdb_initialized = 1;
> > +	if (!kgdb_enter) {
> > +		return;
> > +	}
> > +	/*
> > +	 * Call the breakpoint() routine in GDB to start the debugging
> > +	 * session
> > +	 */
> > +	printk(KERN_CRIT "Waiting for connection from remote gdb... ");
> > +	breakpoint() ;
> > +	printk("Connected.\n");
> > +}
> > +
> > +#ifdef CONFIG_KGDB_CONSOLE
> > +char kgdbconbuf[BUFMAX];
> > +
> > +void kgdb_console_write(struct console *co, const char *s, unsigned
> > count) +{
> > +	int i;
> > +	int wcount;
> > +	char *bufptr;
> > +	unsigned long flags;
> > +
> > +	if (!kgdb_connected) {
> > +		return;
> > +	}
> > +	local_irq_save(flags);
> > +
> > +	kgdbconbuf[0] = 'O';
> > +	bufptr = kgdbconbuf + 1;
> > +	while (count > 0) {
> > +		if ((count << 1) > (BUFMAX - 2)) {
> > +			wcount = (BUFMAX - 2) >> 1;
> > +		} else {
> > +			wcount = count;
> > +		}
> > +		count -= wcount;
> > +		for (i = 0; i < wcount; i++) {
> > +			bufptr = pack_hex_byte(bufptr, s[i]);
> > +		}
> > +		*bufptr = '\0';
> > +		s += wcount;
> > +
> > +		putpacket(kgdbconbuf, 1);
> > +
> > +	}
> > +	local_irq_restore(flags);
> > +}
> > +
> > +/* Always fail so that kgdb console doesn't become the default console
> > */ +static int __init kgdb_console_setup(struct console *co, char
> > *options) +{
> > +	return -1;
> > +}
> > +
> > +static struct console kgdbcons = {
> > +	.name = "kgdb",
> > +	.write = kgdb_console_write,
> > +	.setup = kgdb_console_setup,
> > +	.flags = CON_PRINTBUFFER | CON_ENABLED,
> > +	.index = -1,
> > +};
> > +
> > +static int __init kgdb_console_init(void)
> > +{
> > +	register_console(&kgdbcons);
> > +	return 0;
> > +}
> > +console_initcall(kgdb_console_init);
> > +#endif
> > +
> > +EXPORT_SYMBOL(breakpoint);
> > +#ifdef CONFIG_KGDB_THREAD
> > +EXPORT_SYMBOL(kern_schedule);
> > +#endif
> > +
> > +static int __init opt_kgdb_enter(char *str)
> > +{
> > +	kgdb_enter = 1;
> > +	return 1;
> > +}
> > +
> > +static int __init opt_gdb(char *str)
> > +{
> > +	kgdb_enter = 1;
> > +	return 1;
> > +}
> > +
> > +/*
> > + * These options have been deprecated and are present only to maintain
> > + * compatibility with kgdb for 2.4 and earlier kernels.
> > + */
> > +#ifdef CONFIG_KGDB_8250
> > +extern int kgdb8250_baud;
> > +extern int kgdb8250_ttyS;
> > +static int __init opt_gdbttyS(char *str)
> > +{
> > +	kgdb8250_ttyS = simple_strtoul(str, NULL, 10);
> > +	return 1;
> > +}
> > +static int __init opt_gdbbaud(char *str)
> > +{
> > +	kgdb8250_baud = simple_strtoul(str, NULL, 10);
> > +	return 1;
> > +}
> > +#endif
> > +
> > +/*
> > + *
> > + * Sequence of following lines has to be maintained because gdb option
> > is a + * prefix of the other two options
> > + */
> > +
> > +#ifdef CONFIG_KGDB_8250
> > +__setup("gdbttyS=", opt_gdbttyS);
> > +__setup("gdbbaud=", opt_gdbbaud);
> > +#endif
> > +__setup("gdb", opt_gdb);
> > +__setup("kgdbwait", opt_kgdb_enter);
> > --- clean.2.5/kernel/sched.c	2004-02-05 01:54:30.000000000 +0100
> > +++ linux-mm/kernel/sched.c	2004-02-16 23:09:06.000000000 +0100
> > @@ -37,6 +37,7 @@
> >  #include <linux/rcupdate.h>
> >  #include <linux/cpu.h>
> >  #include <linux/percpu.h>
> > +#include <linux/debugger.h>
> >
> >  #ifdef CONFIG_NUMA
> >  #define cpu_to_node_mask(cpu) node_to_cpumask(cpu_to_node(cpu))
> > @@ -2958,6 +2959,8 @@
> >  #if defined(in_atomic)
> >  	static unsigned long prev_jiffy;	/* ratelimiting */
> >
> > +	if (atomic_read(&debugger_active))
> > +		return;
> >  	if ((in_atomic() || irqs_disabled()) && system_running) {
> >  		if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
> >  			return;

