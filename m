Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUFNDc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUFNDc3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 23:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbUFNDc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 23:32:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6315 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261724AbUFNDcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 23:32:11 -0400
Date: Sun, 13 Jun 2004 20:32:03 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: <marcelo.tosatti@cyclades.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Patch for USB in 2.4 to update mct_u232
Message-Id: <20040613203203.0a5ca0cd@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a fairly straightforward backport from 2.6.6.
My MCT U9 is hardly useable without it, because the 2.4 driver
keeps forgetting to set the baud rate. Only applications which
pre-set baud rate work (to anything other than 9600, too).
And god forbid you run getty with this thing.

This is independent from the write-from-interrupt part I posted
before, but both are needed for getty to work.

-- Pete

diff -urp -X dontdiff linux-2.4.27-pre5/drivers/usb/serial/mct_u232.c linux-2.4.27-pre5-usb/drivers/usb/serial/mct_u232.c
--- linux-2.4.27-pre5/drivers/usb/serial/mct_u232.c	2004-02-26 14:09:59.000000000 -0800
+++ linux-2.4.27-pre5-usb/drivers/usb/serial/mct_u232.c	2004-06-12 14:24:26.000000000 -0700
@@ -169,7 +169,8 @@ static struct usb_serial_device_type mct
 
 
 struct mct_u232_private {
-	unsigned long	     control_state; /* Modem Line Setting (TIOCM) */
+	spinlock_t lock;
+	unsigned int	     control_state; /* Modem Line Setting (TIOCM) */
 	unsigned char        last_lcr;      /* Line Control Register */
 	unsigned char	     last_lsr;      /* Line Status Register */
 	unsigned char	     last_msr;      /* Modem Status Register */
@@ -181,25 +182,49 @@ struct mct_u232_private {
 
 #define WDR_TIMEOUT (HZ * 5 ) /* default urb timeout */
 
+/*
+ * Later day 2.6.0-test kernels have new baud rates like B230400 which
+ * we do not know how to support. We ignore them for the moment.
+ * XXX Rate-limit the error message, it's user triggerable.
+ */
 static int mct_u232_calculate_baud_rate(struct usb_serial *serial, int value) {
 	if (serial->dev->descriptor.idProduct == MCT_U232_SITECOM_PID
 	  || serial->dev->descriptor.idProduct == MCT_U232_BELKIN_F5U109_PID) {
 		switch (value) {
-			case    300: return 0x01;
-			case    600: return 0x02; /* this one not tested */
-			case   1200: return 0x03;
-			case   2400: return 0x04;
-			case   4800: return 0x06;
-			case   9600: return 0x08;
-			case  19200: return 0x09;
-			case  38400: return 0x0a;
-			case  57600: return 0x0b;
-			case 115200: return 0x0c;
-			default:     return -1; /* normally not reached */
+		case    B300: return 0x01;
+		case    B600: return 0x02; /* this one not tested */
+		case   B1200: return 0x03;
+		case   B2400: return 0x04;
+		case   B4800: return 0x06;
+		case   B9600: return 0x08;
+		case  B19200: return 0x09;
+		case  B38400: return 0x0a;
+		case  B57600: return 0x0b;
+		case B115200: return 0x0c;
+		default:
+			err("MCT USB-RS232: unsupported baudrate request 0x%x,"
+			    " using default of B9600", value);
+			return 0x08;
+		}
+	} else {
+		switch (value) {
+		case    B300: value =     300;
+		case    B600: value =     600;
+		case   B1200: value =    1200;
+		case   B2400: value =    2400;
+		case   B4800: value =    4800;
+		case   B9600: value =    9600;
+		case  B19200: value =   19200;
+		case  B38400: value =   38400;
+		case  B57600: value =   57600;
+		case B115200: value =  115200;
+		default:
+			err("MCT USB-RS232: unsupported baudrate request 0x%x,"
+			    " using default of B9600", value);
+			value = 9600;
 		}
+		return 115200/value;
 	}
-	else
-		return MCT_U232_BAUD_RATE(value);
 }
 
 static int mct_u232_set_baud_rate(struct usb_serial *serial, int value)
@@ -207,7 +232,9 @@ static int mct_u232_set_baud_rate(struct
 	unsigned int divisor;
         int rc;
         unsigned char zero_byte = 0;
+
 	divisor = cpu_to_le32(mct_u232_calculate_baud_rate(serial, value));
+
         rc = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
                              MCT_U232_SET_BAUD_RATE_REQUEST,
 			     MCT_U232_SET_REQUEST_TYPE,
@@ -215,7 +242,7 @@ static int mct_u232_set_baud_rate(struct
 			     WDR_TIMEOUT);
 	if (rc < 0)
 		err("Set BAUD RATE %d failed (error = %d)", value, rc);
-	dbg("set_baud_rate: value: %d, divisor: 0x%x", value, divisor);
+	dbg("set_baud_rate: value: 0x%x, divisor: 0x%x", value, divisor);
 
 	/* Mimic the MCT-supplied Windows driver (version 1.21P.0104), which
 	   always sends two extra USB 'device request' messages after the
@@ -263,7 +290,7 @@ static int mct_u232_set_line_ctrl(struct
 } /* mct_u232_set_line_ctrl */
 
 static int mct_u232_set_modem_ctrl(struct usb_serial *serial,
-				   unsigned long control_state)
+				   unsigned int control_state)
 {
         int rc;
 	unsigned char mcr = MCT_U232_MCR_NONE;
@@ -280,7 +307,7 @@ static int mct_u232_set_modem_ctrl(struc
 			     WDR_TIMEOUT);
 	if (rc < 0)
 		err("Set MODEM CTRL 0x%x failed (error = %d)", mcr, rc);
-	dbg("set_modem_ctrl: state=0x%lx ==> mcr=0x%x", control_state, mcr);
+	dbg("set_modem_ctrl: state=0x%x ==> mcr=0x%x", control_state, mcr);
 
         return rc;
 } /* mct_u232_set_modem_ctrl */
@@ -301,7 +328,7 @@ static int mct_u232_get_modem_stat(struc
         return rc;
 } /* mct_u232_get_modem_stat */
 
-static void mct_u232_msr_to_state(unsigned long *control_state, unsigned char msr)
+static void mct_u232_msr_to_state(unsigned int *control_state, unsigned char msr)
 {
  	/* Translate Control Line states */
 	if (msr & MCT_U232_MSR_DSR)
@@ -320,7 +347,7 @@ static void mct_u232_msr_to_state(unsign
 		*control_state |=  TIOCM_CD;
 	else
 		*control_state &= ~TIOCM_CD;
- 	dbg("msr_to_state: msr=0x%x ==> state=0x%lx", msr, *control_state);
+ 	dbg("msr_to_state: msr=0x%x ==> state=0x%x", msr, *control_state);
 } /* mct_u232_msr_to_state */
 
 /*
@@ -330,20 +357,32 @@ static void mct_u232_msr_to_state(unsign
 static int mct_u232_startup (struct usb_serial *serial)
 {
 	struct mct_u232_private *priv;
+	struct usb_serial_port *port, *rport;
 
 	/* allocate the private data structure */
-	serial->port->private = kmalloc(sizeof(struct mct_u232_private),
-					GFP_KERNEL);
-	if (!serial->port->private)
-		return (-1); /* error */
-	priv = (struct mct_u232_private *)serial->port->private;
+	priv = kmalloc(sizeof(struct mct_u232_private), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
 	/* set initial values for control structures */
+	spin_lock_init(&priv->lock);
 	priv->control_state = 0;
 	priv->last_lsr = 0;
 	priv->last_msr = 0;
-
+	serial->port->private = priv;
+ 
 	init_waitqueue_head(&serial->port->write_wait);
-	
+
+	/* Puh, that's dirty */
+	port = &serial->port[0];
+	rport = &serial->port[1];
+	if (port->read_urb) {
+		/* No unlinking, it wasn't submitted yet. */
+		usb_free_urb(port->read_urb);
+	}
+	port->read_urb = rport->interrupt_in_urb;
+	rport->interrupt_in_urb = NULL;
+	port->read_urb->context = port;
+
 	return (0);
 } /* mct_u232_startup */
 
@@ -354,7 +393,6 @@ static void mct_u232_shutdown (struct us
 	
 	dbg("%s", __FUNCTION__);
 
-	/* stop reads and writes on all ports */
 	for (i=0; i < serial->num_ports; ++i) {
 		/* My special items, the standard routines free my urbs */
 		if (serial->port[i].private)
@@ -367,6 +405,10 @@ static int  mct_u232_open (struct usb_se
 	struct usb_serial *serial = port->serial;
 	struct mct_u232_private *priv = (struct mct_u232_private *)port->private;
 	int retval = 0;
+	unsigned int control_state;
+	unsigned long flags;
+	unsigned char last_lcr;
+	unsigned char last_msr;
 
 	dbg("%s port %d", __FUNCTION__, port->number);
 
@@ -383,29 +425,27 @@ static int  mct_u232_open (struct usb_se
 	 * sure if this is really necessary. But it should not harm
 	 * either.
 	 */
+	spin_lock_irqsave(&priv->lock, flags);
 	if (port->tty->termios->c_cflag & CBAUD)
 		priv->control_state = TIOCM_DTR | TIOCM_RTS;
 	else
 		priv->control_state = 0;
-	mct_u232_set_modem_ctrl(serial, priv->control_state);
 	
 	priv->last_lcr = (MCT_U232_DATA_BITS_8 | 
 			  MCT_U232_PARITY_NONE |
 			  MCT_U232_STOP_BITS_1);
-	mct_u232_set_line_ctrl(serial, priv->last_lcr);
+	control_state = priv->control_state;
+	last_lcr = priv->last_lcr;
+	spin_unlock_irqrestore(&priv->lock, flags);
+	mct_u232_set_modem_ctrl(serial, control_state);
+	mct_u232_set_line_ctrl(serial, last_lcr);
 
 	/* Read modem status and update control state */
-	mct_u232_get_modem_stat(serial, &priv->last_msr);
+	mct_u232_get_modem_stat(serial, &last_msr);
+	spin_lock_irqsave(&priv->lock, flags);
+	priv->last_msr = last_msr;
 	mct_u232_msr_to_state(&priv->control_state, priv->last_msr);
-
-	{
-		/* Puh, that's dirty */
-		struct usb_serial_port *rport;	
-		rport = &serial->port[1];
-		rport->tty = port->tty;
-		rport->private = port->private;
-		port->read_urb = rport->interrupt_in_urb;
-	}
+	spin_unlock_irqrestore(&priv->lock, flags);
 
 	port->read_urb->dev = port->serial->dev;
 	retval = usb_submit_urb(port->read_urb);
@@ -551,6 +591,7 @@ static void mct_u232_read_int_callback (
 	struct usb_serial *serial = port->serial;
 	struct tty_struct *tty;
 	unsigned char *data = urb->transfer_buffer;
+	unsigned long flags;
 
         dbg("%s - port %d", __FUNCTION__, port->number);
 
@@ -587,6 +628,7 @@ static void mct_u232_read_int_callback (
 	 * The interrupt-in pipe signals exceptional conditions (modem line
 	 * signal changes and errors). data[0] holds MSR, data[1] holds LSR.
 	 */
+	spin_lock_irqsave(&priv->lock, flags);
 	priv->last_msr = data[MCT_U232_MSR_INDEX];
 	
 	/* Record Control Line states */
@@ -617,6 +659,7 @@ static void mct_u232_read_int_callback (
 		}
 	}
 #endif
+	spin_unlock_irqrestore(&priv->lock, flags);
 
 	/* INT urbs are automatically re-submitted */
 } /* mct_u232_read_int_callback */
@@ -628,125 +671,113 @@ static void mct_u232_set_termios (struct
 	struct usb_serial *serial = port->serial;
 	struct mct_u232_private *priv = (struct mct_u232_private *)port->private;
 	unsigned int iflag = port->tty->termios->c_iflag;
-	unsigned int old_iflag = old_termios->c_iflag;
 	unsigned int cflag = port->tty->termios->c_cflag;
 	unsigned int old_cflag = old_termios->c_cflag;
-	
+	unsigned long flags;
+	unsigned int control_state, new_state;
+	unsigned char last_lcr;
+
+	/* get a local copy of the current port settings */
+	spin_lock_irqsave(&priv->lock, flags);
+	control_state = priv->control_state;
+	spin_unlock_irqrestore(&priv->lock, flags);
+	last_lcr = 0;
+
 	/*
-	 * Update baud rate
+	 * Update baud rate.
+	 * Do not attempt to cache old rates and skip settings,
+	 * disconnects screw such tricks up completely.
+	 * Premature optimization is the root of all evil.
 	 */
-	if( (cflag & CBAUD) != (old_cflag & CBAUD) ) {
-	        /* reassert DTR and (maybe) RTS on transition from B0 */
-		if( (old_cflag & CBAUD) == B0 ) {
-			dbg("%s: baud was B0", __FUNCTION__);
-			priv->control_state |= TIOCM_DTR;
-			/* don't set RTS if using hardware flow control */
-			if (!(old_cflag & CRTSCTS)) {
-				priv->control_state |= TIOCM_RTS;
-			}
-			mct_u232_set_modem_ctrl(serial, priv->control_state);
-		}
-		
-		switch(cflag & CBAUD) {
-		case B0: /* handled below */
-			break;
-		case B300: mct_u232_set_baud_rate(serial, 300);
-			break;
-		case B600: mct_u232_set_baud_rate(serial, 600);
-			break;
-		case B1200: mct_u232_set_baud_rate(serial, 1200);
-			break;
-		case B2400: mct_u232_set_baud_rate(serial, 2400);
-			break;
-		case B4800: mct_u232_set_baud_rate(serial, 4800);
-			break;
-		case B9600: mct_u232_set_baud_rate(serial, 9600);
-			break;
-		case B19200: mct_u232_set_baud_rate(serial, 19200);
-			break;
-		case B38400: mct_u232_set_baud_rate(serial, 38400);
-			break;
-		case B57600: mct_u232_set_baud_rate(serial, 57600);
-			break;
-		case B115200: mct_u232_set_baud_rate(serial, 115200);
-			break;
-		default: err("MCT USB-RS232 converter: unsupported baudrate request, using default of 9600");
-			mct_u232_set_baud_rate(serial, 9600); break;
-		}
-		if ((cflag & CBAUD) == B0 ) {
-			dbg("%s: baud is B0", __FUNCTION__);
-			/* Drop RTS and DTR */
-			priv->control_state &= ~(TIOCM_DTR | TIOCM_RTS);
-        		mct_u232_set_modem_ctrl(serial, priv->control_state);
-		}
+
+        /* reassert DTR and (maybe) RTS on transition from B0 */
+	if ((old_cflag & CBAUD) == B0) {
+		dbg("%s: baud was B0", __FUNCTION__);
+		control_state |= TIOCM_DTR;
+		/* don't set RTS if using hardware flow control */
+		if (!(old_cflag & CRTSCTS)) {
+			control_state |= TIOCM_RTS;
+		}
+		mct_u232_set_modem_ctrl(serial, control_state);
+	}
+
+	mct_u232_set_baud_rate(serial, cflag & CBAUD);
+
+	if ((cflag & CBAUD) == B0 ) {
+		dbg("%s: baud is B0", __FUNCTION__);
+		/* Drop RTS and DTR */
+		control_state &= ~(TIOCM_DTR | TIOCM_RTS);
+       		mct_u232_set_modem_ctrl(serial, control_state);
 	}
 
 	/*
 	 * Update line control register (LCR)
 	 */
-	if ((cflag & (PARENB|PARODD)) != (old_cflag & (PARENB|PARODD))
-	    || (cflag & CSIZE) != (old_cflag & CSIZE)
-	    || (cflag & CSTOPB) != (old_cflag & CSTOPB) ) {
-		
 
-		priv->last_lcr = 0;
+	/* set the parity */
+	if (cflag & PARENB)
+		last_lcr |= (cflag & PARODD) ?
+			MCT_U232_PARITY_ODD : MCT_U232_PARITY_EVEN;
+	else
+		last_lcr |= MCT_U232_PARITY_NONE;
 
-		/* set the parity */
-		if (cflag & PARENB)
-			priv->last_lcr |= (cflag & PARODD) ?
-				MCT_U232_PARITY_ODD : MCT_U232_PARITY_EVEN;
-		else
-			priv->last_lcr |= MCT_U232_PARITY_NONE;
+	/* set the number of data bits */
+	switch (cflag & CSIZE) {
+	case CS5:
+		last_lcr |= MCT_U232_DATA_BITS_5; break;
+	case CS6:
+		last_lcr |= MCT_U232_DATA_BITS_6; break;
+	case CS7:
+		last_lcr |= MCT_U232_DATA_BITS_7; break;
+	case CS8:
+		last_lcr |= MCT_U232_DATA_BITS_8; break;
+	default:
+		err("CSIZE was not CS5-CS8, using default of 8");
+		last_lcr |= MCT_U232_DATA_BITS_8;
+		break;
+	}
 
-		/* set the number of data bits */
-		switch (cflag & CSIZE) {
-		case CS5:
-			priv->last_lcr |= MCT_U232_DATA_BITS_5; break;
-		case CS6:
-			priv->last_lcr |= MCT_U232_DATA_BITS_6; break;
-		case CS7:
-			priv->last_lcr |= MCT_U232_DATA_BITS_7; break;
-		case CS8:
-			priv->last_lcr |= MCT_U232_DATA_BITS_8; break;
-		default:
-			err("CSIZE was not CS5-CS8, using default of 8");
-			priv->last_lcr |= MCT_U232_DATA_BITS_8;
-			break;
-		}
+	/* set the number of stop bits */
+	last_lcr |= (cflag & CSTOPB) ?
+		MCT_U232_STOP_BITS_2 : MCT_U232_STOP_BITS_1;
 
-		/* set the number of stop bits */
-		priv->last_lcr |= (cflag & CSTOPB) ?
-			MCT_U232_STOP_BITS_2 : MCT_U232_STOP_BITS_1;
+	mct_u232_set_line_ctrl(serial, last_lcr);
 
-		mct_u232_set_line_ctrl(serial, priv->last_lcr);
-	}
-	
 	/*
 	 * Set flow control: well, I do not really now how to handle DTR/RTS.
 	 * Just do what we have seen with SniffUSB on Win98.
 	 */
-	if( (iflag & IXOFF) != (old_iflag & IXOFF)
-	    || (iflag & IXON) != (old_iflag & IXON)
-	    ||  (cflag & CRTSCTS) != (old_cflag & CRTSCTS) ) {
-		
-		/* Drop DTR/RTS if no flow control otherwise assert */
-		if ((iflag & IXOFF) || (iflag & IXON) || (cflag & CRTSCTS) )
-			priv->control_state |= TIOCM_DTR | TIOCM_RTS;
-		else
-			priv->control_state &= ~(TIOCM_DTR | TIOCM_RTS);
-		mct_u232_set_modem_ctrl(serial, priv->control_state);
+	/* Drop DTR/RTS if no flow control otherwise assert */
+	new_state = control_state;
+	if ((iflag & IXOFF) || (iflag & IXON) || (cflag & CRTSCTS))
+		new_state |= TIOCM_DTR | TIOCM_RTS;
+	else
+		new_state &= ~(TIOCM_DTR | TIOCM_RTS);
+	if (new_state != control_state) {
+		mct_u232_set_modem_ctrl(serial, control_state);
+		control_state = new_state;
 	}
-} /* mct_u232_set_termios */
 
+	/* save off the modified port settings */
+	spin_lock_irqsave(&priv->lock, flags);
+	priv->control_state = control_state;
+	priv->last_lcr = last_lcr;
+	spin_unlock_irqrestore(&priv->lock, flags);
+} /* mct_u232_set_termios */
 
 static void mct_u232_break_ctl( struct usb_serial_port *port, int break_state )
 {
 	struct usb_serial *serial = port->serial;
 	struct mct_u232_private *priv = (struct mct_u232_private *)port->private;
-	unsigned char lcr = priv->last_lcr;
+	unsigned char lcr;
+	unsigned long flags;
 
 	dbg("%sstate=%d", __FUNCTION__, break_state);
 
+	spin_lock_irqsave(&priv->lock, flags);
+	lcr = priv->last_lcr;
+	spin_unlock_irqrestore(&priv->lock, flags);
+
 	if (break_state)
 		lcr |= MCT_U232_SET_BREAK;
 
@@ -760,7 +791,8 @@ static int mct_u232_ioctl (struct usb_se
 	struct usb_serial *serial = port->serial;
 	struct mct_u232_private *priv = (struct mct_u232_private *)port->private;
 	int mask;
-	
+	unsigned long flags;
+
 	dbg("%scmd=0x%x", __FUNCTION__, cmd);
 
 	/* Based on code from acm.c and others */
@@ -775,6 +807,7 @@ static int mct_u232_ioctl (struct usb_se
 		if (get_user(mask, (unsigned long *) arg))
 			return -EFAULT;
 
+		spin_lock_irqsave(&priv->lock, flags);
 		if ((cmd == TIOCMSET) || (mask & TIOCM_RTS)) {
 			/* RTS needs set */
 			if( ((cmd == TIOCMSET) && (mask & TIOCM_RTS)) ||
@@ -792,6 +825,7 @@ static int mct_u232_ioctl (struct usb_se
 			else
 				priv->control_state &= ~TIOCM_DTR;
 		}
+		spin_unlock_irqrestore(&priv->lock, flags);
 		mct_u232_set_modem_ctrl(serial, priv->control_state);
 		break;
 					
