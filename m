Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266118AbSKFVZb>; Wed, 6 Nov 2002 16:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266128AbSKFVZb>; Wed, 6 Nov 2002 16:25:31 -0500
Received: from gaea.projecticarus.com ([195.10.228.71]:63369 "EHLO
	gaea.projecticarus.com") by vger.kernel.org with ESMTP
	id <S266118AbSKFVZB>; Wed, 6 Nov 2002 16:25:01 -0500
Message-ID: <3DC98A01.4030809@walrond.org>
Date: Wed, 06 Nov 2002 21:30:41 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.44 serial driver bug with asus pr-dls m/b
References: <3DB84EAB.5020608@walrond.org> <20021103135813.B5589@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for delay; been offline moving office. Will try this tomorrow am 
and let you know what transpires.

Andrew

Russell King wrote:

>On Thu, Oct 24, 2002 at 08:48:59PM +0100, Andrew Walrond wrote:
>  
>
>>It doesn't seem to detect the uart of tts/0 at all, although it finds 
>>tts/1 if I enable it in the bios (there isn't a DB9 for tts/1 on the 
>>rear plate so I can't actually try it)
>>    
>>
>
>Ok, I've recently brought 2.5.45-bk up to date wrt the stuff I've got
>here, which includes better debugging for these types of problems.
>Can you retry with vanilla 2.5.45 plus the attached patch please?
>
>Also, please make sure you enable DEBUG_AUTOCONF debugging in
>drivers/serial/8250.c - the output from the autoconfig should allow
>me to track down why tts/0 is failing to be detected.
>
>Thanks.
>
>diff -Nru a/drivers/serial/8250.c b/drivers/serial/8250.c
>--- a/drivers/serial/8250.c	Sat Nov  2 21:02:11 2002
>+++ b/drivers/serial/8250.c	Sat Nov  2 21:02:11 2002
>@@ -124,6 +124,8 @@
> 	unsigned char		ier;
> 	unsigned char		rev;
> 	unsigned char		lcr;
>+	unsigned char		mcr_mask;	/* mask of user bits */
>+	unsigned char		mcr_force;	/* mask of forced bits */
> 	unsigned int		lsr_break_flag;
> 
> 	/*
>@@ -342,10 +344,9 @@
>  * 
>  * What evil have men's minds wrought...
>  */
>-static void
>-autoconfig_startech_uarts(struct uart_8250_port *up)
>+static void autoconfig_has_efr(struct uart_8250_port *up)
> {
>-	unsigned char scratch, scratch2, scratch3, scratch4;
>+	unsigned char id1, id2, id3, rev, saved_dll, saved_dlm;
> 
> 	/*
> 	 * First we check to see if it's an Oxford Semiconductor UART.
>@@ -354,31 +355,32 @@
> 	 * Semiconductor clone chips lock up if you try writing to the
> 	 * LSR register (which serial_icr_read does)
> 	 */
>-	if (up->port.type == PORT_16550A) {
>-		/*
>-		 * EFR [4] must be set else this test fails
>-		 *
>-		 * This shouldn't be necessary, but Mike Hudson
>-		 * (Exoray@isys.ca) claims that it's needed for 952
>-		 * dual UART's (which are not recommended for new designs).
>-		 */
>-		up->acr = 0;
>-		serial_out(up, UART_LCR, 0xBF);
>-		serial_out(up, UART_EFR, 0x10);
>-		serial_out(up, UART_LCR, 0x00);
>-		/* Check for Oxford Semiconductor 16C950 */
>-		scratch = serial_icr_read(up, UART_ID1);
>-		scratch2 = serial_icr_read(up, UART_ID2);
>-		scratch3 = serial_icr_read(up, UART_ID3);
>-		
>-		if (scratch == 0x16 && scratch2 == 0xC9 &&
>-		    (scratch3 == 0x50 || scratch3 == 0x52 ||
>-		     scratch3 == 0x54)) {
>-			up->port.type = PORT_16C950;
>-			up->rev = serial_icr_read(up, UART_REV) |
>-						  (scratch3 << 8);
>-			return;
>-		}
>+
>+	/*
>+	 * Check for Oxford Semiconductor 16C950.
>+	 *
>+	 * EFR [4] must be set else this test fails.
>+	 *
>+	 * This shouldn't be necessary, but Mike Hudson (Exoray@isys.ca)
>+	 * claims that it's needed for 952 dual UART's (which are not
>+	 * recommended for new designs).
>+	 */
>+	up->acr = 0;
>+	serial_out(up, UART_LCR, 0xBF);
>+	serial_out(up, UART_EFR, UART_EFR_ECB);
>+	serial_out(up, UART_LCR, 0x00);
>+	id1 = serial_icr_read(up, UART_ID1);
>+	id2 = serial_icr_read(up, UART_ID2);
>+	id3 = serial_icr_read(up, UART_ID3);
>+	rev = serial_icr_read(up, UART_REV);
>+
>+	DEBUG_AUTOCONF("950id=%02x:%02x:%02x:%02x ", id1, id2, id3, rev);
>+
>+	if (id1 == 0x16 && id2 == 0xC9 &&
>+	    (id3 == 0x50 || id3 == 0x52 || id3 == 0x54)) {
>+		up->port.type = PORT_16C950;
>+		up->rev = rev | (id3 << 8);
>+		return;
> 	}
> 	
> 	/*
>@@ -389,34 +391,28 @@
> 	 *  0x12 - XR16C2850.
> 	 *  0x14 - XR16C854.
> 	 */
>-
>-	/* Save the DLL and DLM */
>-
> 	serial_outp(up, UART_LCR, UART_LCR_DLAB);
>-	scratch3 = serial_inp(up, UART_DLL);
>-	scratch4 = serial_inp(up, UART_DLM);
>-
>+	saved_dll = serial_inp(up, UART_DLL);
>+	saved_dlm = serial_inp(up, UART_DLM);
> 	serial_outp(up, UART_DLL, 0);
> 	serial_outp(up, UART_DLM, 0);
>-	scratch2 = serial_inp(up, UART_DLL);
>-	scratch = serial_inp(up, UART_DLM);
>-	serial_outp(up, UART_LCR, 0);
>-
>-	if (scratch == 0x10 || scratch == 0x12 || scratch == 0x14) {
>-		if (scratch == 0x10)
>-			up->rev = scratch2;
>+	id2 = serial_inp(up, UART_DLL);
>+	id1 = serial_inp(up, UART_DLM);
>+	serial_outp(up, UART_DLL, saved_dll);
>+	serial_outp(up, UART_DLM, saved_dlm);
>+
>+	DEBUG_AUTOCONF("850id=%02x:%02x ", id1, id2);
>+
>+	if (id1 == 0x10 || id1 == 0x12 || id1 == 0x14) {
>+		if (id1 == 0x10)
>+			up->rev = id2;
> 		up->port.type = PORT_16850;
> 		return;
> 	}
> 
>-	/* Restore the DLL and DLM */
>-
>-	serial_outp(up, UART_LCR, UART_LCR_DLAB);
>-	serial_outp(up, UART_DLL, scratch3);
>-	serial_outp(up, UART_DLM, scratch4);
>-	serial_outp(up, UART_LCR, 0);
>-
> 	/*
>+	 * It wasn't an XR16C850.
>+	 *
> 	 * We distinguish between the '654 and the '650 by counting
> 	 * how many bytes are in the FIFO.  I'm using this for now,
> 	 * since that's the technique that was sent to me in the
>@@ -430,6 +426,85 @@
> }
> 
> /*
>+ * We detected a chip without a FIFO.  Only two fall into
>+ * this category - the original 8250 and the 16450.  The
>+ * 16450 has a scratch register (accessible with LCR=0)
>+ */
>+static void autoconfig_8250(struct uart_8250_port *up)
>+{
>+	unsigned char scratch, status1, status2;
>+
>+	up->port.type = PORT_8250;
>+
>+	scratch = serial_in(up, UART_SCR);
>+	serial_outp(up, UART_SCR, 0xa5);
>+	status1 = serial_in(up, UART_SCR);
>+	serial_outp(up, UART_SCR, 0x5a);
>+	status2 = serial_in(up, UART_SCR);
>+	serial_outp(up, UART_SCR, scratch);
>+
>+	if (status1 == 0xa5 && status2 == 0x5a)
>+		up->port.type = PORT_16450;
>+}
>+
>+/*
>+ * We know that the chip has FIFOs.  Does it have an EFR?  The
>+ * EFR is located in the same register position as the IIR and
>+ * we know the top two bits of the IIR are currently set.  The
>+ * EFR should contain zero.  Try to read the EFR.
>+ */
>+static void autoconfig_16550a(struct uart_8250_port *up)
>+{
>+	unsigned char status1, status2;
>+
>+	up->port.type = PORT_16550A;
>+
>+	/*
>+	 * Check for presence of the EFR when DLAB is set.
>+	 * Only ST16C650V1 UARTs pass this test.
>+	 */
>+	serial_outp(up, UART_LCR, UART_LCR_DLAB);
>+	if (serial_in(up, UART_EFR) == 0) {
>+		DEBUG_AUTOCONF("EFRv1 ");
>+		up->port.type = PORT_16650;
>+		return;
>+	}
>+
>+	/*
>+	 * Maybe it requires 0xbf to be written to the LCR.
>+	 * (other ST16C650V2 UARTs, TI16C752A, etc)
>+	 */
>+	serial_outp(up, UART_LCR, 0xBF);
>+	if (serial_in(up, UART_EFR) == 0) {
>+		DEBUG_AUTOCONF("EFRv2 ");
>+		autoconfig_has_efr(up);
>+		return;
>+	}
>+
>+	/*
>+	 * No EFR.  Try to detect a TI16750, which only sets bit 5 of
>+	 * the IIR when 64 byte FIFO mode is enabled when DLAB is set.
>+	 * Try setting it with and without DLAB set.  Cheap clones
>+	 * set bit 5 without DLAB set.
>+	 */
>+	serial_outp(up, UART_LCR, 0);
>+	serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO | UART_FCR7_64BYTE);
>+	status1 = serial_in(up, UART_IIR) >> 5;
>+	serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
>+	serial_outp(up, UART_LCR, UART_LCR_DLAB);
>+	serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO | UART_FCR7_64BYTE);
>+	status2 = serial_in(up, UART_IIR) >> 5;
>+	serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
>+
>+	DEBUG_AUTOCONF("iir1=%d iir2=%d ", status1, status2);
>+
>+	if (status1 == 6 && status2 == 7) {
>+		up->port.type = PORT_16750;
>+		return;
>+	}
>+}
>+
>+/*
>  * This routine is called by rs_init() to initialize a specific serial
>  * port.  It determines what type of UART chip this serial port is
>  * using: 8250, 16450, 16550, 16550A.  The important question is
>@@ -438,16 +513,16 @@
>  */
> static void autoconfig(struct uart_8250_port *up, unsigned int probeflags)
> {
>-	unsigned char status1, status2, scratch, scratch2, scratch3;
>+	unsigned char status1, scratch, scratch2, scratch3;
> 	unsigned char save_lcr, save_mcr;
> 	unsigned long flags;
> 
>-	DEBUG_AUTOCONF("Testing ttyS%d (0x%04x, 0x%08lx)...\n",
>-			up->port.line, up->port.iobase, up->port.membase);
>-
> 	if (!up->port.iobase && !up->port.membase)
> 		return;
> 
>+	DEBUG_AUTOCONF("ttyS%d: autoconf (0x%04x, 0x%08lx): ",
>+			up->port.line, up->port.iobase, up->port.membase);
>+
> 	/*
> 	 * We really do need global IRQs disabled here - we're going to
> 	 * be frobbing the chips IRQ enable register to see if it exists.
>@@ -455,7 +530,7 @@
> 	spin_lock_irqsave(&up->port.lock, flags);
> //	save_flags(flags); cli();
> 
>-	if (!(up->port.flags & ASYNC_BUGGY_UART)) {
>+	if (!(up->port.flags & UPF_BUGGY_UART)) {
> 		/*
> 		 * Do a simple existence test first; if we fail this,
> 		 * there's no point trying anything else.
>@@ -465,6 +540,9 @@
> 		 * assumption is that 0x80 is a non-existent port;
> 		 * which should be safe since include/asm/io.h also
> 		 * makes this assumption.
>+		 *
>+		 * Note: this is safe as long as MCR bit 4 is clear
>+		 * and the device is in "PC" mode.
> 		 */
> 		scratch = serial_inp(up, UART_IER);
> 		serial_outp(up, UART_IER, 0);
>@@ -482,9 +560,8 @@
> 			/*
> 			 * We failed; there's nothing here
> 			 */
>-			DEBUG_AUTOCONF("serial: ttyS%d: simple autoconfig "
>-				       "failed (%02x, %02x)\n",
>-				       up->port.line, scratch2, scratch3);
>+			DEBUG_AUTOCONF("IER test failed (%02x, %02x) ",
>+				       scratch2, scratch3);
> 			goto out;
> 		}
> 	}
>@@ -501,69 +578,50 @@
> 	 * manufacturer would be stupid enough to design a board
> 	 * that conflicts with COM 1-4 --- we hope!
> 	 */
>-	if (!(up->port.flags & ASYNC_SKIP_TEST)) {
>+	if (!(up->port.flags & UPF_SKIP_TEST)) {
> 		serial_outp(up, UART_MCR, UART_MCR_LOOP | 0x0A);
> 		status1 = serial_inp(up, UART_MSR) & 0xF0;
> 		serial_outp(up, UART_MCR, save_mcr);
> 		if (status1 != 0x90) {
>-			DEBUG_AUTOCONF("serial: ttyS%d: no UART loopback "
>-				       "failed\n", up->port.line);
>+			DEBUG_AUTOCONF("LOOP test failed (%02x) ",
>+				       status1);
> 			goto out;
> 		}
> 	}
>-	serial_outp(up, UART_LCR, 0xBF); /* set up for StarTech test */
>-	serial_outp(up, UART_EFR, 0);	/* EFR is the same as FCR */
>+
>+	/*
>+	 * We're pretty sure there's a port here.  Lets find out what
>+	 * type of port it is.  The IIR top two bits allows us to find
>+	 * out if its 8250 or 16450, 16550, 16550A or later.  This
>+	 * determines what we test for next.
>+	 *
>+	 * We also initialise the EFR (if any) to zero for later.  The
>+	 * EFR occupies the same register location as the FCR and IIR.
>+	 */
>+	serial_outp(up, UART_LCR, 0xBF);
>+	serial_outp(up, UART_EFR, 0);
> 	serial_outp(up, UART_LCR, 0);
>+
> 	serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
> 	scratch = serial_in(up, UART_IIR) >> 6;
>+
>+	DEBUG_AUTOCONF("iir=%d ", scratch);
>+
> 	switch (scratch) {
>-		case 0:
>-			up->port.type = PORT_16450;
>-			break;
>-		case 1:
>-			up->port.type = PORT_UNKNOWN;
>-			break;
>-		case 2:
>-			up->port.type = PORT_16550;
>-			break;
>-		case 3:
>-			up->port.type = PORT_16550A;
>-			break;
>-	}
>-	if (up->port.type == PORT_16550A) {
>-		/* Check for Startech UART's */
>-		serial_outp(up, UART_LCR, UART_LCR_DLAB);
>-		if (serial_in(up, UART_EFR) == 0) {
>-			up->port.type = PORT_16650;
>-		} else {
>-			serial_outp(up, UART_LCR, 0xBF);
>-			if (serial_in(up, UART_EFR) == 0)
>-				autoconfig_startech_uarts(up);
>-		}
>-	}
>-	if (up->port.type == PORT_16550A) {
>-		/* Check for TI 16750 */
>-		serial_outp(up, UART_LCR, save_lcr | UART_LCR_DLAB);
>-		serial_outp(up, UART_FCR,
>-			    UART_FCR_ENABLE_FIFO | UART_FCR7_64BYTE);
>-		scratch = serial_in(up, UART_IIR) >> 5;
>-		if (scratch == 7) {
>-			/*
>-			 * If this is a 16750, and not a cheap UART
>-			 * clone, then it should only go into 64 byte
>-			 * mode if the UART_FCR7_64BYTE bit was set
>-			 * while UART_LCR_DLAB was latched.
>-			 */
>- 			serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
>-			serial_outp(up, UART_LCR, 0);
>-			serial_outp(up, UART_FCR,
>-				    UART_FCR_ENABLE_FIFO | UART_FCR7_64BYTE);
>-			scratch = serial_in(up, UART_IIR) >> 5;
>-			if (scratch == 6)
>-				up->port.type = PORT_16750;
>-		}
>-		serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
>+	case 0:
>+		autoconfig_8250(up);
>+		break;
>+	case 1:
>+		up->port.type = PORT_UNKNOWN;
>+		break;
>+	case 2:
>+		up->port.type = PORT_16550;
>+		break;
>+	case 3:
>+		autoconfig_16550a(up);
>+		break;
> 	}
>+
> #if defined(CONFIG_SERIAL_8250_RSA) && defined(MODULE)
> 	/*
> 	 * Only probe for RSA ports if we got the region.
>@@ -586,17 +644,6 @@
> 	}
> #endif
> 	serial_outp(up, UART_LCR, save_lcr);
>-	if (up->port.type == PORT_16450) {
>-		scratch = serial_in(up, UART_SCR);
>-		serial_outp(up, UART_SCR, 0xa5);
>-		status1 = serial_in(up, UART_SCR);
>-		serial_outp(up, UART_SCR, 0x5a);
>-		status2 = serial_in(up, UART_SCR);
>-		serial_outp(up, UART_SCR, scratch);
>-
>-		if ((status1 != 0xa5) || (status2 != 0x5a))
>-			up->port.type = PORT_8250;
>-	}
> 
> 	up->port.fifosize = uart_config[up->port.type].dfl_xmit_fifo_size;
> 
>@@ -628,6 +675,7 @@
> 			       "serial_rsa");
> 	}
> #endif
>+	DEBUG_AUTOCONF("type=%s\n", uart_config[up->port.type].name);
> }
> 
> static void autoconfig_irq(struct uart_8250_port *up)
>@@ -638,7 +686,7 @@
> 	unsigned long irqs;
> 	int irq;
> 
>-	if (up->port.flags & ASYNC_FOURPORT) {
>+	if (up->port.flags & UPF_FOURPORT) {
> 		ICP = (up->port.iobase & 0xfe0) | 0x1f;
> 		save_ICP = inb_p(ICP);
> 		outb_p(0x80, ICP);
>@@ -654,7 +702,7 @@
> 	irqs = probe_irq_on();
> 	serial_outp(up, UART_MCR, 0);
> 	udelay (10);
>-	if (up->port.flags & ASYNC_FOURPORT)  {
>+	if (up->port.flags & UPF_FOURPORT)  {
> 		serial_outp(up, UART_MCR,
> 			    UART_MCR_DTR | UART_MCR_RTS);
> 	} else {
>@@ -673,7 +721,7 @@
> 	serial_outp(up, UART_MCR, save_mcr);
> 	serial_outp(up, UART_IER, save_ier);
> 
>-	if (up->port.flags & ASYNC_FOURPORT)
>+	if (up->port.flags & UPF_FOURPORT)
> 		outb_p(save_ICP, ICP);
> 
> 	up->port.irq = (irq > 0) ? irq : 0;
>@@ -839,7 +887,7 @@
> 	} while (--count > 0);
> 
> 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
>-		uart_event(&up->port, EVT_WRITE_WAKEUP);
>+		uart_write_wakeup(&up->port);
> 
> 	DEBUG_INTR("THRE...");
> 
>@@ -948,10 +996,26 @@
>  * line being stuck active, and, since ISA irqs are edge triggered,
>  * no more IRQs will be seen.
>  */
>+static void serial_do_unlink(struct irq_info *i, struct uart_8250_port *up)
>+{
>+	spin_lock_irq(&i->lock);
>+
>+	if (!list_empty(i->head)) {
>+		if (i->head == &up->list)
>+			i->head = i->head->next;
>+		list_del(&up->list);
>+	} else {
>+		BUG_ON(i->head != &up->list);
>+		i->head = NULL;
>+	}
>+
>+	spin_unlock_irq(&i->lock);
>+}
>+
> static int serial_link_irq_chain(struct uart_8250_port *up)
> {
> 	struct irq_info *i = irq_lists + up->port.irq;
>-	int ret, irq_flags = share_irqs ? SA_SHIRQ : 0;
>+	int ret, irq_flags = up->port.flags & UPF_SHARE_IRQ ? SA_SHIRQ : 0;
> 
> 	spin_lock_irq(&i->lock);
> 
>@@ -967,6 +1031,8 @@
> 
> 		ret = request_irq(up->port.irq, serial8250_interrupt,
> 				  irq_flags, "serial", i);
>+		if (ret)
>+			serial_do_unlink(i, up);
> 	}
> 
> 	return ret;
>@@ -981,18 +1047,7 @@
> 	if (list_empty(i->head))
> 		free_irq(up->port.irq, i);
> 
>-	spin_lock_irq(&i->lock);
>-
>-	if (!list_empty(i->head)) {
>-		if (i->head == &up->list)
>-			i->head = i->head->next;
>-		list_del(&up->list);
>-	} else {
>-		BUG_ON(i->head != &up->list);
>-		i->head = NULL;
>-	}
>-
>-	spin_unlock_irq(&i->lock);
>+	serial_do_unlink(i, up);
> }
> 
> /*
>@@ -1058,7 +1113,7 @@
> static void serial8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
> {
> 	struct uart_8250_port *up = (struct uart_8250_port *)port;
>-	unsigned char mcr = ALPHA_KLUDGE_MCR;
>+	unsigned char mcr = 0;
> 
> 	if (mctrl & TIOCM_RTS)
> 		mcr |= UART_MCR_RTS;
>@@ -1071,6 +1126,8 @@
> 	if (mctrl & TIOCM_LOOP)
> 		mcr |= UART_MCR_LOOP;
> 
>+	mcr = (mcr & up->mcr_mask) | up->mcr_force;
>+
> 	serial_out(up, UART_MCR, mcr);
> }
> 
>@@ -1139,7 +1196,7 @@
> 	 * if it is, then bail out, because there's likely no UART
> 	 * here.
> 	 */
>-	if (!(up->port.flags & ASYNC_BUGGY_UART) &&
>+	if (!(up->port.flags & UPF_BUGGY_UART) &&
> 	    (serial_inp(up, UART_LSR) == 0xff)) {
> 		printk("ttyS%d: LSR safety check engaged!\n", up->port.line);
> 		return -ENODEV;
>@@ -1169,7 +1226,7 @@
> 	serial_outp(up, UART_LCR, UART_LCR_WLEN8);
> 
> 	spin_lock_irqsave(&up->port.lock, flags);
>-	if (up->port.flags & ASYNC_FOURPORT) {
>+	if (up->port.flags & UPF_FOURPORT) {
> 		if (!is_real_interrupt(up->port.irq))
> 			up->port.mctrl |= TIOCM_OUT1;
> 	} else
>@@ -1190,7 +1247,7 @@
> 	up->ier = UART_IER_RLSI | UART_IER_RDI;
> 	serial_outp(up, UART_IER, up->ier);
> 
>-	if (up->port.flags & ASYNC_FOURPORT) {
>+	if (up->port.flags & UPF_FOURPORT) {
> 		unsigned int icp;
> 		/*
> 		 * Enable interrupts on the AST Fourport board
>@@ -1223,7 +1280,7 @@
> 	serial_outp(up, UART_IER, 0);
> 
> 	spin_lock_irqsave(&up->port.lock, flags);
>-	if (up->port.flags & ASYNC_FOURPORT) {
>+	if (up->port.flags & UPF_FOURPORT) {
> 		/* reset interrupts on the AST Fourport board */
> 		inb((up->port.iobase & 0xfe0) | 0x1f);
> 		up->port.mctrl |= TIOCM_OUT1;
>@@ -1604,7 +1661,7 @@
> 	/*
> 	 * Don't probe for MCA ports on non-MCA machines.
> 	 */
>-	if (up->port.flags & ASYNC_BOOT_ONLYMCA && !MCA_bus)
>+	if (up->port.flags & UPF_BOOT_ONLYMCA && !MCA_bus)
> 		return;
> #endif
> 
>@@ -1704,6 +1761,8 @@
> 		up->port.iotype   = old_serial_port[i].io_type;
> 		up->port.regshift = old_serial_port[i].iomem_reg_shift;
> 		up->port.ops      = &serial8250_pops;
>+		if (share_irqs)
>+			up->port.flags |= UPF_SHARE_IRQ;
> 	}
> }
> 
>@@ -1714,11 +1773,20 @@
> 	serial8250_isa_init_ports();
> 
> 	for (i = 0; i < UART_NR; i++) {
>-		serial8250_ports[i].port.line = i;
>-		serial8250_ports[i].port.ops = &serial8250_pops;
>-		init_timer(&serial8250_ports[i].timer);
>-		serial8250_ports[i].timer.function = serial8250_timeout;
>-		uart_add_one_port(drv, &serial8250_ports[i].port);
>+		struct uart_8250_port *up = &serial8250_ports[i];
>+
>+		up->port.line = i;
>+		up->port.ops = &serial8250_pops;
>+		init_timer(&up->timer);
>+		up->timer.function = serial8250_timeout;
>+
>+		/*
>+		 * ALPHA_KLUDGE_MCR needs to be killed.
>+		 */
>+		up->mcr_mask = ~ALPHA_KLUDGE_MCR;
>+		up->mcr_force = ALPHA_KLUDGE_MCR;
>+
>+		uart_add_one_port(drv, &up->port);
> 	}
> }
> 
>@@ -1746,7 +1814,7 @@
> 	} while ((status & BOTH_EMPTY) != BOTH_EMPTY);
> 
> 	/* Wait up to 1s for flow control if necessary */
>-	if (up->port.flags & ASYNC_CONS_FLOW) {
>+	if (up->port.flags & UPF_CONS_FLOW) {
> 		tmout = 1000000;
> 		while (--tmout &&
> 		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0))
>@@ -1857,7 +1925,7 @@
> #ifdef CONFIG_DEVFS_FS
> 	.dev_name		= "tts/%d",
> #else
>-	.dev_name		= "ttyS",
>+	.dev_name		= "ttyS%d",
> #endif
> 	.major			= TTY_MAJOR,
> 	.minor			= 64,
>@@ -1881,8 +1949,11 @@
> 	port.fifosize = req->xmit_fifo_size;
> 	port.regshift = req->iomem_reg_shift;
> 	port.iotype   = req->io_type;
>-	port.flags    = req->flags | ASYNC_BOOT_AUTOCONF;
>+	port.flags    = req->flags | UPF_BOOT_AUTOCONF;
> 	port.line     = line;
>+
>+	if (share_irqs)
>+		port.flags |= UPF_SHARE_IRQ;
> 
> 	if (HIGH_BITS_OFFSET)
> 		port.iobase |= (long) req->port_high << HIGH_BITS_OFFSET;
>diff -Nru a/drivers/serial/8250_cs.c b/drivers/serial/8250_cs.c
>--- a/drivers/serial/8250_cs.c	Sat Nov  2 21:02:12 2002
>+++ b/drivers/serial/8250_cs.c	Sat Nov  2 21:02:12 2002
>@@ -41,6 +41,7 @@
> #include <linux/timer.h>
> #include <linux/tty.h>
> #include <linux/serial.h>
>+#include <linux/serial_core.h>
> #include <linux/major.h>
> #include <linux/workqueue.h>
> #include <asm/io.h>
>@@ -306,7 +307,7 @@
> 	memset(&serial, 0, sizeof (serial));
> 	serial.port = port;
> 	serial.irq = irq;
>-	serial.flags = ASYNC_SKIP_TEST | ASYNC_SHARE_IRQ;
>+	serial.flags = UPF_SKIP_TEST | UPF_SHARE_IRQ;
> 	line = register_serial(&serial);
> 	if (line < 0) {
> 		printk(KERN_NOTICE "serial_cs: register_serial() at 0x%04lx,"
>diff -Nru a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
>--- a/drivers/serial/8250_pci.c	Sat Nov  2 21:02:12 2002
>+++ b/drivers/serial/8250_pci.c	Sat Nov  2 21:02:12 2002
>@@ -11,7 +11,7 @@
>  * it under the terms of the GNU General Public License as published by
>  * the Free Software Foundation; either version 2 of the License.
>  *
>- *  $Id: 8250_pci.c,v 1.24 2002/07/29 14:39:56 rmk Exp $
>+ *  $Id: 8250_pci.c,v 1.28 2002/11/02 11:14:18 rmk Exp $
>  */
> #include <linux/module.h>
> #include <linux/init.h>
>@@ -21,7 +21,6 @@
> #include <linux/kernel.h>
> #include <linux/slab.h>
> #include <linux/serial.h>
>-
> #include <linux/serialP.h>
> 
> #include <asm/bitops.h>
>@@ -55,14 +54,19 @@
> 	int line[0];
> };
> 
>+/*
>+ * init_fn returns:
>+ *  > 0 - number of ports
>+ *  = 0 - use board->num_ports
>+ *  < 0 - error
>+ */
> struct pci_board {
> 	int flags;
> 	int num_ports;
> 	int base_baud;
> 	int uart_offset;
> 	int reg_shift;
>-	int (*init_fn)(struct pci_dev *dev, struct pci_board *board,
>-			int enable);
>+	int (*init_fn)(struct pci_dev *dev, int enable);
> 	int first_uart_offset;
> };
> 
>@@ -201,8 +205,7 @@
>  * seems to be mainly needed on card using the PLX which also use I/O
>  * mapped memory.
>  */
>-static int __devinit
>-pci_plx9050_fn(struct pci_dev *dev, struct pci_board *board, int enable)
>+static int __devinit pci_plx9050_fn(struct pci_dev *dev, int enable)
> {
> 	u8 *p, irq_config = 0;
> 
>@@ -264,8 +267,7 @@
> #define PCI_DEVICE_ID_SIIG_1S_10x (PCI_DEVICE_ID_SIIG_1S_10x_550 & 0xfffc)
> #define PCI_DEVICE_ID_SIIG_2S_10x (PCI_DEVICE_ID_SIIG_2S_10x_550 & 0xfff8)
> 
>-static int __devinit
>-pci_siig10x_fn(struct pci_dev *dev, struct pci_board *board, int enable)
>+static int __devinit pci_siig10x_fn(struct pci_dev *dev, int enable)
> {
> 	u16 data, *p;
> 
>@@ -296,8 +298,7 @@
> #define PCI_DEVICE_ID_SIIG_2S_20x (PCI_DEVICE_ID_SIIG_2S_20x_550 & 0xfffc)
> #define PCI_DEVICE_ID_SIIG_2S1P_20x (PCI_DEVICE_ID_SIIG_2S1P_20x_550 & 0xfffc)
> 
>-static int __devinit
>-pci_siig20x_fn(struct pci_dev *dev, struct pci_board *board, int enable)
>+static int __devinit pci_siig20x_fn(struct pci_dev *dev, int enable)
> {
> 	u8 data;
> 
>@@ -318,8 +319,7 @@
> }
> 
> /* Added for EKF Intel i960 serial boards */
>-static int __devinit
>-pci_inteli960ni_fn(struct pci_dev *dev, struct pci_board *board, int enable)
>+static int __devinit pci_inteli960ni_fn(struct pci_dev *dev, int enable)
> {
> 	unsigned long oldval;
> 
>@@ -378,8 +378,7 @@
> 	{ 0, 0 }
> };
> 
>-static int __devinit
>-pci_timedia_fn(struct pci_dev *dev, struct pci_board *board, int enable)
>+static int __devinit pci_timedia_fn(struct pci_dev *dev, int enable)
> {
> 	int	i, j;
> 	unsigned short *ids;
>@@ -389,12 +388,9 @@
> 
> 	for (i = 0; timedia_data[i].num; i++) {
> 		ids = timedia_data[i].ids;
>-		for (j = 0; ids[j]; j++) {
>-			if (pci_get_subdevice(dev) == ids[j]) {
>-				board->num_ports = timedia_data[i].num;
>-				return 0;
>-			}
>-		}
>+		for (j = 0; ids[j]; j++)
>+			if (pci_get_subdevice(dev) == ids[j])
>+				return timedia_data[i].num;
> 	}
> 	return 0;
> }
>@@ -406,9 +402,10 @@
>  * and Keystone have one Diva chip with 3 UARTs.  Some later machines have
>  * one Diva chip, but it has been expanded to 5 UARTs.
>  */
>-static int __devinit
>-pci_hp_diva(struct pci_dev *dev, struct pci_board *board, int enable)
>+static int __devinit pci_hp_diva(struct pci_dev *dev, int enable)
> {
>+	int rc = 0;
>+
> 	if (!enable)
> 		return 0;
> 
>@@ -417,25 +414,24 @@
> 	case PCI_DEVICE_ID_HP_DIVA_HALFDOME:
> 	case PCI_DEVICE_ID_HP_DIVA_KEYSTONE:
> 	case PCI_DEVICE_ID_HP_DIVA_EVEREST:
>-		board->num_ports = 3;
>+		rc = 3;
> 		break;
> 	case PCI_DEVICE_ID_HP_DIVA_TOSCA2:
>-		board->num_ports = 2;
>+		rc = 2;
> 		break;
> 	case PCI_DEVICE_ID_HP_DIVA_MAESTRO:
>-		board->num_ports = 4;
>+		rc = 4;
> 		break;
> 	case PCI_DEVICE_ID_HP_DIVA_POWERBAR:
>-		board->num_ports = 1;
>+		rc = 1;
> 		break;
> 	}
> 
>-	return 0;
>+	return rc;
> }
> 
> 
>-static int __devinit
>-pci_xircom_fn(struct pci_dev *dev, struct pci_board *board, int enable)
>+static int __devinit pci_xircom_fn(struct pci_dev *dev, int enable)
> {
> 	__set_current_state(TASK_UNINTERRUPTIBLE);
> 	schedule_timeout(HZ/10);
>@@ -579,8 +575,11 @@
> 		0x400, 7, pci_plx9050_fn },
> 	{ SPCI_FL_BASE2, 4, 921600,			   /* pbn_plx_romulus */
> 		0x20, 2, pci_plx9050_fn, 0x03 },
>-		/* This board uses the size of PCI Base region 0 to
>-		 * signal now many ports are available */
>+
>+	/*
>+	 * This board uses the size of PCI Base region 0 to
>+	 * signal now many ports are available
>+	 */
> 	{ SPCI_FL_BASE0 | SPCI_FL_REGION_SZ_CAP, 32, 115200 }, /* pbn_oxsemi */
> 	{ SPCI_FL_BASE_TABLE, 1, 921600,		   /* pbn_timedia */
> 		0, 0, pci_timedia_fn },
>@@ -645,9 +644,9 @@
> 	 * later?) 
> 	 */
> 	if ((((dev->class >> 8) != PCI_CLASS_COMMUNICATION_SERIAL) &&
>-	    ((dev->class >> 8) != PCI_CLASS_COMMUNICATION_MODEM)) ||
>+	     ((dev->class >> 8) != PCI_CLASS_COMMUNICATION_MODEM)) ||
> 	    (dev->class & 0xff) > 6)
>-		return 1;
>+		return -ENODEV;
> 
> 	for (i = 0; i < 6; i++) {
> 		if (IS_PCI_REGION_IOPORT(dev, i)) {
>@@ -667,20 +666,31 @@
> 		board->flags = first_port;
> 		return 0;
> 	}
>-	return 1;
>+	return -ENODEV;
>+}
>+
>+static inline int
>+serial_pci_matches(struct pci_board *board, int index)
>+{
>+	return
>+	    board->base_baud == pci_boards[index].base_baud &&
>+	    board->num_ports == pci_boards[index].num_ports &&
>+	    board->uart_offset == pci_boards[index].uart_offset &&
>+	    board->reg_shift == pci_boards[index].reg_shift &&
>+	    board->first_uart_offset == pci_boards[index].first_uart_offset;
> }
> 
> /*
>- * return an error code to refuse.
>- *
>- * serial_struct is 60 bytes.
>+ * Probe one serial board.  Unfortunately, there is no rhyme nor reason
>+ * to the arrangement of serial ports on a PCI card.
>  */
>-static int __devinit pci_init_one(struct pci_dev *dev, const struct pci_device_id *ent)
>+static int __devinit
>+pci_init_one(struct pci_dev *dev, const struct pci_device_id *ent)
> {
> 	struct serial_private *priv;
> 	struct pci_board *board, tmp;
> 	struct serial_struct serial_req;
>-	int base_baud, rc, k;
>+	int base_baud, rc, nr_ports, i;
> 
> 	if (ent->driver_data >= ARRAY_SIZE(pci_boards)) {
> 		printk(KERN_ERR "pci_init_one: invalid driver_data: %ld\n",
>@@ -694,67 +704,98 @@
> 	if (rc)
> 		return rc;
> 
>-	if (ent->driver_data == pbn_default &&
>-	    serial_pci_guess_board(dev, board)) {
>-		pci_disable_device(dev);
>-		return -ENODEV;
>-	} else if (serial_pci_guess_board(dev, &tmp) == 0) {
>-		printk(KERN_INFO "Redundant entry in serial pci_table.  "
>-		       "Please send the output of\n"
>-		       "lspci -vv, this message (%d,%d,%d,%d)\n"
>-		       "and the manufacturer and name of "
>-		       "serial board or modem board\n"
>-		       "to serial-pci-info@lists.sourceforge.net.\n",
>-		       dev->vendor, dev->device,
>-		       pci_get_subvendor(dev), pci_get_subdevice(dev));
>+	if (ent->driver_data == pbn_default) {
>+		/*
>+		 * Use a copy of the pci_board entry for this;
>+		 * avoid changing entries in the table.
>+		 */
>+		memcpy(&tmp, board, sizeof(struct pci_board));
>+		board = &tmp;
>+
>+		/*
>+		 * We matched one of our class entries.  Try to
>+		 * determine the parameters of this board.
>+		 */
>+		rc = serial_pci_guess_board(dev, board);
>+		if (rc)
>+			goto disable;
>+	} else {
>+		/*
>+		 * We matched an explicit entry.  If we are able to
>+		 * detect this boards settings with our heuristic,
>+		 * then we no longer need this entry.
>+		 */
>+		rc = serial_pci_guess_board(dev, &tmp);
>+		if (rc == 0 && serial_pci_matches(board, pbn_default)) {
>+			printk(KERN_INFO
>+		"Redundant entry in serial pci_table.  Please send the output\n"
>+		"of lspci -vv, this message (0x%04x,0x%04x,0x%04x,0x%04x),\n"
>+		"the manufacturer and name of serial board or modem board to\n"
>+		"rmk@arm.linux.org.uk.\n",
>+			       dev->vendor, dev->device,
>+			       pci_get_subvendor(dev), pci_get_subdevice(dev));
>+		}
> 	}
> 
>-	priv = kmalloc(sizeof(struct serial_private) +
>-			      sizeof(unsigned int) * board->num_ports,
>-			      GFP_KERNEL);
>-	if (!priv) {
>-		pci_disable_device(dev);
>-		return -ENOMEM;
>-	}
>+	nr_ports = board->num_ports;
> 
> 	/*
>-	 * Run the initialization function, if any
>+	 * Run the initialization function, if any.  The initialization
>+	 * function returns:
>+	 *  <0  - error
>+	 *   0  - use board->num_ports
>+	 *  >0  - number of ports
> 	 */
> 	if (board->init_fn) {
>-		rc = board->init_fn(dev, board, 1);
>-		if (rc != 0) {
>-			pci_disable_device(dev);
>-			kfree(priv);
>-			return rc;
>-		}
>+		rc = board->init_fn(dev, 1);
>+		if (rc < 0)
>+			goto disable;
>+
>+		if (rc)
>+			nr_ports = rc;
>+	}
>+
>+	priv = kmalloc(sizeof(struct serial_private) +
>+			      sizeof(unsigned int) * nr_ports,
>+			      GFP_KERNEL);
>+	if (!priv) {
>+		rc = -ENOMEM;
>+		goto deinit;
> 	}
> 
> 	base_baud = board->base_baud;
> 	if (!base_baud)
> 		base_baud = BASE_BAUD;
> 	memset(&serial_req, 0, sizeof(serial_req));
>-	for (k = 0; k < board->num_ports; k++) {
>-		serial_req.irq = get_pci_irq(dev, board, k);
>-		if (get_pci_port(dev, board, &serial_req, k))
>+	for (i = 0; i < nr_ports; i++) {
>+		serial_req.irq = get_pci_irq(dev, board, i);
>+		if (get_pci_port(dev, board, &serial_req, i))
> 			break;
> #ifdef SERIAL_DEBUG_PCI
>-		printk("Setup PCI/PNP port: port %x, irq %d, type %d\n",
>+		printk("Setup PCI port: port %x, irq %d, type %d\n",
> 		       serial_req.port, serial_req.irq, serial_req.io_type);
> #endif
> 		serial_req.flags = ASYNC_SKIP_TEST | ASYNC_AUTOPROBE;
> 		serial_req.baud_base = base_baud;
> 		
>-		priv->line[k] = register_serial(&serial_req);
>-		if (priv->line[k] < 0)
>+		priv->line[i] = register_serial(&serial_req);
>+		if (priv->line[i] < 0)
> 			break;
> 	}
> 
> 	priv->board = board;
>-	priv->nr = k;
>+	priv->nr = i;
> 
> 	pci_set_drvdata(dev, priv);
> 
> 	return 0;
>+
>+ deinit:
>+	if (board->init_fn)
>+		board->init_fn(dev, 0);
>+ disable:
>+	pci_disable_device(dev);
>+	return rc;
> }
> 
> static void __devexit pci_remove_one(struct pci_dev *dev)
>@@ -769,7 +810,7 @@
> 			unregister_serial(priv->line[i]);
> 
> 		if (priv->board->init_fn)
>-			priv->board->init_fn(dev, priv->board, 0);
>+			priv->board->init_fn(dev, 0);
> 
> 		pci_disable_device(dev);
> 
>@@ -1160,18 +1201,23 @@
> 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> 		pbn_dci_pccom8 },
> 
>+	/*
>+	 * These entries match devices with class
>+	 * COMMUNICATION_SERIAL, COMMUNICATION_MODEM
>+	 * or COMMUNICATION_MULTISERIAL
>+	 */
> 	{	PCI_ANY_ID, PCI_ANY_ID,
> 		PCI_ANY_ID, PCI_ANY_ID,
> 		PCI_CLASS_COMMUNICATION_SERIAL << 8,
>-		0xffff00, },
>+		0xffff00, pbn_default },
> 	{	PCI_ANY_ID, PCI_ANY_ID,
> 		PCI_ANY_ID, PCI_ANY_ID,
> 		PCI_CLASS_COMMUNICATION_MODEM << 8,
>-		0xffff00, },
>+		0xffff00, pbn_default },
> 	{	PCI_ANY_ID, PCI_ANY_ID,
> 		PCI_ANY_ID, PCI_ANY_ID,
> 		PCI_CLASS_COMMUNICATION_MULTISERIAL << 8,
>-		0xffff00, },
>+		0xffff00, pbn_default },
> 	{ 0, }
> };
> 
>diff -Nru a/drivers/serial/core.c b/drivers/serial/core.c
>--- a/drivers/serial/core.c	Sat Nov  2 21:02:11 2002
>+++ b/drivers/serial/core.c	Sat Nov  2 21:02:11 2002
>@@ -65,11 +65,9 @@
>  * This routine is used by the interrupt handler to schedule processing in
>  * the software interrupt portion of the driver.
>  */
>-void uart_event(struct uart_port *port, int event)
>+void uart_write_wakeup(struct uart_port *port)
> {
> 	struct uart_info *info = port->info;
>-
>-	set_bit(0, &info->event);
> 	tasklet_schedule(&info->tlet);
> }
> 
>@@ -112,13 +110,12 @@
> 	struct tty_struct *tty;
> 
> 	tty = info->tty;
>-	if (!tty || !test_and_clear_bit(EVT_WRITE_WAKEUP, &info->event))
>-		return;
>-
>-	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
>-	    tty->ldisc.write_wakeup)
>-		(tty->ldisc.write_wakeup)(tty);
>-	wake_up_interruptible(&tty->write_wait);
>+	if (tty) {
>+		if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
>+		    tty->ldisc.write_wakeup)
>+			tty->ldisc.write_wakeup(tty);
>+		wake_up_interruptible(&tty->write_wait);
>+	}
> }
> 
> static inline void
>@@ -1981,7 +1978,8 @@
> static inline void
> uart_report_port(struct uart_driver *drv, struct uart_port *port)
> {
>-	printk("%s%d at ", drv->dev_name, port->line);
>+	printk(drv->dev_name, port->line);
>+	printk(" at ");
> 	switch (port->iotype) {
> 	case UPIO_PORT:
> 		printk("I/O 0x%x", port->iobase);
>@@ -2005,7 +2003,6 @@
> 	state->port = port;
> 
> 	spin_lock_init(&port->lock);
>-	port->type = PORT_UNKNOWN;
> 	port->cons = drv->cons;
> 	port->info = state->info;
> 
>@@ -2022,8 +2019,10 @@
> 	flags = UART_CONFIG_TYPE;
> 	if (port->flags & UPF_AUTO_IRQ)
> 		flags |= UART_CONFIG_IRQ;
>-	if (port->flags & UPF_BOOT_AUTOCONF)
>+	if (port->flags & UPF_BOOT_AUTOCONF) {
>+		port->type = PORT_UNKNOWN;
> 		port->ops->config_port(port, flags);
>+	}
> 
> 	/*
> 	 * Register the port whether it's detected or not.  This allows
>@@ -2439,8 +2438,9 @@
> 	struct uart_state *state;
> 
> 	if (line < 0 || line >= drv->nr) {
>-		printk(KERN_ERR "Attempt to unregister %s%d\n",
>-			drv->dev_name, line);
>+		printk(KERN_ERR "Attempt to unregister ");
>+		printk(drv->dev_name, line);
>+		printk("\n");
> 		return;
> 	}
> 
>@@ -2453,7 +2453,7 @@
> 	up(&port_sem);
> }
> 
>-EXPORT_SYMBOL(uart_event);
>+EXPORT_SYMBOL(uart_write_wakeup);
> EXPORT_SYMBOL(uart_register_driver);
> EXPORT_SYMBOL(uart_unregister_driver);
> EXPORT_SYMBOL(uart_register_port);
>diff -Nru a/include/linux/serial_core.h b/include/linux/serial_core.h
>--- a/include/linux/serial_core.h	Sat Nov  2 21:02:11 2002
>+++ b/include/linux/serial_core.h	Sat Nov  2 21:02:11 2002
>@@ -154,6 +154,7 @@
> 	unsigned int		flags;
> 
> #define UPF_HUP_NOTIFY		(1 << 0)
>+#define UPF_FOURPORT		(1 << 1)
> #define UPF_SAK			(1 << 2)
> #define UPF_SPD_MASK		(0x1030)
> #define UPF_SPD_HI		(0x0010)
>@@ -167,6 +168,9 @@
> #define UPF_LOW_LATENCY		(1 << 13)
> #define UPF_BUGGY_UART		(1 << 14)
> #define UPF_AUTOPROBE		(1 << 15)
>+#define UPF_BOOT_ONLYMCA	(1 << 22)
>+#define UPF_CONS_FLOW		(1 << 23)
>+#define UPF_SHARE_IRQ		(1 << 24)
> #define UPF_BOOT_AUTOCONF	(1 << 28)
> #define UPF_RESOURCES		(1 << 30)
> #define UPF_IOREMAP		(1 << 31)
>@@ -247,8 +251,6 @@
> /* number of characters left in xmit buffer before we ask for more */
> #define WAKEUP_CHARS		256
> 
>-#define EVT_WRITE_WAKEUP	0
>-
> struct module;
> struct tty_driver;
> 
>@@ -269,7 +271,7 @@
> 	struct tty_driver	*tty_driver;
> };
> 
>-void uart_event(struct uart_port *port, int event);
>+void uart_write_wakeup(struct uart_port *port);
> struct uart_port *uart_get_console(struct uart_port *ports, int nr,
> 				   struct console *c);
> void uart_parse_options(char *options, int *baud, int *parity, int *bits,
>@@ -380,7 +382,7 @@
> 			if (status) {
> 				tty->hw_stopped = 0;
> 				port->ops->start_tx(port, 0);
>-				uart_event(port, EVT_WRITE_WAKEUP);
>+				uart_write_wakeup(port);
> 			}
> 		} else {
> 			if (!status) {
>
>
>  
>


