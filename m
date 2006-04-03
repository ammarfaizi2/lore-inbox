Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751699AbWDCLXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbWDCLXi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 07:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbWDCLXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 07:23:38 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:8667 "EHLO
	mailout3.samsung.com") by vger.kernel.org with ESMTP
	id S1751609AbWDCLXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 07:23:37 -0400
Date: Mon, 03 Apr 2006 20:23:55 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: Re: [PATCH 2.6.16-git] [SERIAL] Adds DCC(JTAG) serial and the console
 emulation support (revised)
In-reply-to: <20060403085058.GA15606@flint.arm.linux.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Message-id: <200604032023.55710.hyok.choi@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.8.3
References: <20060403082001.26644.18948.stgit@localhost.localdomain>
 <20060403085058.GA15606@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 April 2006 05:50 pm, Russell King wrote:
> On Mon, Apr 03, 2006 at 05:20:02PM +0900, Hyok S. Choi wrote:
> 
> Thanks for looking at the previous points, this driver is much better.
> However, there's still some bits which could be even better.
Okay.

> > +/* use ttyJ0(128) */
> > +#define SERIAL_DCC_NAME		"ttyJ"
> > +#define SERIAL_DCC_MINOR	(64 + 64)
> > +#endif
> > +#define SERIAL_DCC_MAJOR	TTY_MAJOR
> 
> Why not just get a proper legal allocation from LANANA ?
I've just requested for an allocation of minor # for major# 204.

> > +static inline u32
> > +__dcc_getstatus(void)
> 
> Column space is not at a premium.
> 
> static inline u32 __dcc_getstatus(void)
> 
> will do just as well.  Does the double underscore here serve any purpose?
 __* naming is used for assembly based primitive functions, that have dependencies
on JTAG1 protocol. Actually, I'd like to extend to support JTAG4 in a mean while.

> > +{
> > +	u32 __ret;
> 
> The double underscore here serves no purpose.
got it.

> > +static inline void
> > +__dcc_putchar(char c)
> > +{
> > +	asm("mcr p14, 0, %0, c1, c0	@ write a char"
> > +		: /* no output register */
> > +		: "r" (c));
> > +}
> > +
> > +static void
> > +dcc_putchar(struct uart_port *port, int ch)
> > +{
> > +	while (__dcc_getstatus() & DCC_STATUS_TX)
> > +		cpu_relax();
> > +	__dcc_putchar((char)(ch & 0xFF));
> 
> Since this is the only place __dcc_putchar is used, might be an idea to
> move it into this function?
You're right.
But, as I mentioned above, I wanted to split JTAG1 dependencies.
If you strongly want to move into there, I will.

> > +}
> > +
> > +static inline void
> > +xmit_string(struct uart_port *port, char *p, int len)
> > +{
> > +	for ( ; len; len--, p++)
> > +		dcc_putchar(port, *p);
> > +}
> > +
> > +static inline void
> > +dcc_transmit_buffer(struct uart_port *port)
> > +{
> > +	struct circ_buf *xmit = &port->info->xmit;
> > +	int pendings = uart_circ_chars_pending(xmit);
> > +
> > +	if(pendings + xmit->tail > UART_XMIT_SIZE)
> > +	{
> 
> Mixture of bracing styles, and there should be a space between if and (.
> 	if (pendings + xmit->tail > UART_XMIT_SIZE) {
> 
Fixed.

> > +		/* for JTAG 1 protocol, incount is always 1. */
> > +		ch = __dcc_getchar();
> > +
> > +		if (tty) {
> > +			tty_insert_flip_char(tty, ch, TTY_NORMAL);
> > +			port->icount.rx++;
> > +			tty_flip_buffer_push(tty);
> > +		}
> > +	}
> > +}
> > +
> > +static inline void
> > +dcc_overrun_chars(struct uart_port *port)
> > +{
> > +	port->icount.overrun++;
> > +}
> 
> This doesn't seem to be used anywhere.
Removed.

> > +static int
> > +dcc_startup(struct uart_port *port)
> > +{
> > +#ifdef DCC_IRQ_USED /* real IRQ used */
> > +	int retval;
> > +
> > +	/* Allocate the IRQ */
> > +	retval = request_irq(port->irq, dcc_int, SA_INTERRUPT,
> > +			     "serial_dcc", port);
> > +	if (retval)
> > +		return retval;
> > +#else /* emulation */
> > +	/* Initialize the work, and shcedule it. */
> > +	INIT_WORK(&dcc_poll_task, dcc_poll, port);
> > +	spin_lock(&port->lock);
> > +	if (dcc_poll_state != DCC_POLL_RUN)
> > +		dcc_poll_state = DCC_POLL_RUN;
> > +	schedule_delayed_work(&dcc_poll_task, 1);
> > +	spin_unlock(&port->lock);
> 
> Hmm, this looks over complex:
> 
> 	if (dcc_poll_state != DCC_POLL_RUN)
> 		dcc_poll_state = DCC_POLL_RUN;
> 
> and unnecessary (see dcc_shutdown comments.)
> 
> Secondly, wouldn't it be better to have INIT_WORK() in the driver
> initialisation?
> 
> > +#endif
> > +
> > +	return 0;
> > +}
> > +
> > +static void
> > +dcc_shutdown(struct uart_port *port)
> > +{
> > +#ifdef DCC_IRQ_USED /* real IRQ used */
> > +	free_irq(port->irq, port);
> > +#else
> > +	spin_lock(&port->lock);
> > +	dcc_poll_state = DCC_POLL_STOP;
> > +	spin_unlock(&port->lock);
> 
> Rather than having this dcc_poll_state, wouldn't the use of:
> 
> 	cancel_rearming_delayed_work(&dcc_poll_task);
> 
> suffice?

  Good. Hmm, the lock protections are still needed.
  Otherwise, it may have some race condition.

-- 
Hyok
ARM Linux 2.6 MPU/noMMU Project http://opensrc.sec.samsung.com/
