Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbTDXXlV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 19:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbTDXXiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:38:06 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:17092 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264499AbTDXXeH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:34:07 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10512280533305@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.68
In-Reply-To: <1051228053892@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 24 Apr 2003 16:47:33 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1165.2.13, 2003/04/23 17:47:05-07:00, greg@kroah.com

[PATCH] USB: keyspan_pda: add support for new tty tiocmget and tiocmset functions.


 drivers/usb/serial/io_edgeport.c |   80 ++++++++++++---------------------
 drivers/usb/serial/io_tables.h   |    8 +++
 drivers/usb/serial/io_ti.c       |   82 ++++++++++++----------------------
 drivers/usb/serial/keyspan.c     |   68 +++++++++++++---------------
 drivers/usb/serial/keyspan.h     |   11 ++++
 drivers/usb/serial/keyspan_pda.c |   94 ++++++++++++++++++---------------------
 6 files changed, 156 insertions(+), 187 deletions(-)


diff -Nru a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
--- a/drivers/usb/serial/io_edgeport.c	Thu Apr 24 16:22:31 2003
+++ b/drivers/usb/serial/io_edgeport.c	Thu Apr 24 16:22:31 2003
@@ -455,6 +455,8 @@
 static void edge_set_termios		(struct usb_serial_port *port, struct termios *old_termios);
 static int  edge_ioctl			(struct usb_serial_port *port, struct file *file, unsigned int cmd, unsigned long arg);
 static void edge_break			(struct usb_serial_port *port, int break_state);
+static int  edge_tiocmget		(struct usb_serial_port *port, struct file *file);
+static int  edge_tiocmset		(struct usb_serial_port *port, struct file *file, unsigned int set, unsigned int clear);
 static int  edge_startup		(struct usb_serial *serial);
 static void edge_shutdown		(struct usb_serial *serial);
 
@@ -1762,42 +1764,27 @@
 	return -ENOIOCTLCMD;
 }
 
-static int set_modem_info(struct edgeport_port *edge_port, unsigned int cmd, unsigned int *value)
+static int edge_tiocmset (struct usb_serial_port *port, struct file *file, unsigned int set, unsigned int clear)
 {
-	unsigned int mcr = edge_port->shadowMCR;
-	unsigned int arg;
-
-	if (copy_from_user(&arg, value, sizeof(int)))
-		return -EFAULT;
-
-	switch (cmd) {
-		case TIOCMBIS:
-			if (arg & TIOCM_RTS)
-				mcr |= MCR_RTS;
-			if (arg & TIOCM_DTR)
-				mcr |= MCR_RTS;
-			if (arg & TIOCM_LOOP)
-				mcr |= MCR_LOOPBACK;
-			break;
+        struct edgeport_port *edge_port = usb_get_serial_port_data(port);
+	unsigned int mcr;
 
-		case TIOCMBIC:
-			if (arg & TIOCM_RTS)
-				mcr &= ~MCR_RTS;
-			if (arg & TIOCM_DTR)
-				mcr &= ~MCR_RTS;
-			if (arg & TIOCM_LOOP)
-				mcr &= ~MCR_LOOPBACK;
-			break;
+	dbg("%s - port %d", __FUNCTION__, port->number);
 
-		case TIOCMSET:
-			/* turn off the RTS and DTR and LOOPBACK 
-			 * and then only turn on what was asked to */
-			mcr &=  ~(MCR_RTS | MCR_DTR | MCR_LOOPBACK);
-			mcr |= ((arg & TIOCM_RTS) ? MCR_RTS : 0);
-			mcr |= ((arg & TIOCM_DTR) ? MCR_DTR : 0);
-			mcr |= ((arg & TIOCM_LOOP) ? MCR_LOOPBACK : 0);
-			break;
-	}
+	mcr = edge_port->shadowMCR;
+	if (set & TIOCM_RTS)
+		mcr |= MCR_RTS;
+	if (set & TIOCM_DTR)
+		mcr |= MCR_DTR;
+	if (set & TIOCM_LOOP)
+		mcr |= MCR_LOOPBACK;
+
+	if (clear & TIOCM_RTS)
+		mcr &= ~MCR_RTS;
+	if (clear & TIOCM_DTR)
+		mcr &= ~MCR_DTR;
+	if (clear & TIOCM_LOOP)
+		mcr &= ~MCR_LOOPBACK;
 
 	edge_port->shadowMCR = mcr;
 
@@ -1806,12 +1793,17 @@
 	return 0;
 }
 
-static int get_modem_info(struct edgeport_port *edge_port, unsigned int *value)
+static int edge_tiocmget(struct usb_serial_port *port, struct file *file)
 {
+        struct edgeport_port *edge_port = usb_get_serial_port_data(port);
 	unsigned int result = 0;
-	unsigned int msr = edge_port->shadowMSR;
-	unsigned int mcr = edge_port->shadowMCR;
+	unsigned int msr;
+	unsigned int mcr;
+
+	dbg("%s - port %d", __FUNCTION__, port->number);
 
+	msr = edge_port->shadowMSR;
+	mcr = edge_port->shadowMCR;
 	result = ((mcr & MCR_DTR)	? TIOCM_DTR: 0)	  /* 0x002 */
 		  | ((mcr & MCR_RTS)	? TIOCM_RTS: 0)   /* 0x004 */
 		  | ((msr & MSR_CTS)	? TIOCM_CTS: 0)   /* 0x020 */
@@ -1822,13 +1814,9 @@
 
 	dbg("%s -- %x", __FUNCTION__, result);
 
-	if (copy_to_user(value, &result, sizeof(int)))
-		return -EFAULT;
-	return 0;
+	return result;
 }
 
-
-
 static int get_serial_info(struct edgeport_port *edge_port, struct serial_struct * retinfo)
 {
 	struct serial_struct tmp;
@@ -1884,16 +1872,6 @@
 			dbg("%s (%d) TIOCSERGETLSR", __FUNCTION__,  port->number);
 			return get_lsr_info(edge_port, (unsigned int *) arg);
 			return 0;
-
-		case TIOCMBIS:
-		case TIOCMBIC:
-		case TIOCMSET:
-			dbg("%s (%d) TIOCMSET/TIOCMBIC/TIOCMSET", __FUNCTION__,  port->number);
-			return set_modem_info(edge_port, cmd, (unsigned int *) arg);
-
-		case TIOCMGET:  
-			dbg("%s (%d) TIOCMGET", __FUNCTION__,  port->number);
-			return get_modem_info(edge_port, (unsigned int *) arg);
 
 		case TIOCGSERIAL:
 			dbg("%s (%d) TIOCGSERIAL", __FUNCTION__,  port->number);
diff -Nru a/drivers/usb/serial/io_tables.h b/drivers/usb/serial/io_tables.h
--- a/drivers/usb/serial/io_tables.h	Thu Apr 24 16:22:31 2003
+++ b/drivers/usb/serial/io_tables.h	Thu Apr 24 16:22:31 2003
@@ -114,6 +114,8 @@
 	.shutdown		= edge_shutdown,
 	.ioctl			= edge_ioctl,
 	.set_termios		= edge_set_termios,
+	.tiocmget		= edge_tiocmget,
+	.tiocmset		= edge_tiocmset,
 	.write			= edge_write,
 	.write_room		= edge_write_room,
 	.chars_in_buffer	= edge_chars_in_buffer,
@@ -137,6 +139,8 @@
 	.shutdown		= edge_shutdown,
 	.ioctl			= edge_ioctl,
 	.set_termios		= edge_set_termios,
+	.tiocmget		= edge_tiocmget,
+	.tiocmset		= edge_tiocmset,
 	.write			= edge_write,
 	.write_room		= edge_write_room,
 	.chars_in_buffer	= edge_chars_in_buffer,
@@ -160,6 +164,8 @@
 	.shutdown		= edge_shutdown,
 	.ioctl			= edge_ioctl,
 	.set_termios		= edge_set_termios,
+	.tiocmget		= edge_tiocmget,
+	.tiocmset		= edge_tiocmset,
 	.write			= edge_write,
 	.write_room		= edge_write_room,
 	.chars_in_buffer	= edge_chars_in_buffer,
@@ -183,6 +189,8 @@
 	.shutdown		= edge_shutdown,
 	.ioctl			= edge_ioctl,
 	.set_termios		= edge_set_termios,
+	.tiocmget		= edge_tiocmget,
+	.tiocmset		= edge_tiocmset,
 	.write			= edge_write,
 	.write_room		= edge_write_room,
 	.chars_in_buffer	= edge_chars_in_buffer,
diff -Nru a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
--- a/drivers/usb/serial/io_ti.c	Thu Apr 24 16:22:31 2003
+++ b/drivers/usb/serial/io_ti.c	Thu Apr 24 16:22:31 2003
@@ -2403,42 +2403,27 @@
 	return;
 }
 
-static int set_modem_info (struct edgeport_port *edge_port, unsigned int cmd, unsigned int *value)
+static int edge_tiocmset (struct usb_serial_port *port, struct file *file, unsigned int set, unsigned int clear)
 {
-	unsigned int mcr = edge_port->shadow_mcr;
-	unsigned int arg;
+        struct edgeport_port *edge_port = usb_get_serial_port_data(port);
+	unsigned int mcr;
 
-	if (copy_from_user(&arg, value, sizeof(int)))
-		return -EFAULT;
-
-	switch (cmd) {
-		case TIOCMBIS:
-			if (arg & TIOCM_RTS)
-				mcr |= MCR_RTS;
-			if (arg & TIOCM_DTR)
-				mcr |= MCR_RTS;
-			if (arg & TIOCM_LOOP)
-				mcr |= MCR_LOOPBACK;
-			break;
+	dbg("%s - port %d", __FUNCTION__, port->number);
 
-		case TIOCMBIC:
-			if (arg & TIOCM_RTS)
-				mcr &= ~MCR_RTS;
-			if (arg & TIOCM_DTR)
-				mcr &= ~MCR_RTS;
-			if (arg & TIOCM_LOOP)
-				mcr &= ~MCR_LOOPBACK;
-			break;
-
-		case TIOCMSET:
-			/* turn off the RTS and DTR and LOOPBACK 
-			 * and then only turn on what was asked to */
-			mcr &=  ~(MCR_RTS | MCR_DTR | MCR_LOOPBACK);
-			mcr |= ((arg & TIOCM_RTS) ? MCR_RTS : 0);
-			mcr |= ((arg & TIOCM_DTR) ? MCR_DTR : 0);
-			mcr |= ((arg & TIOCM_LOOP) ? MCR_LOOPBACK : 0);
-			break;
-	}
+	mcr = edge_port->shadow_mcr;
+	if (set & TIOCM_RTS)
+		mcr |= MCR_RTS;
+	if (set & TIOCM_DTR)
+		mcr |= MCR_DTR;
+	if (set & TIOCM_LOOP)
+		mcr |= MCR_LOOPBACK;
+
+	if (clear & TIOCM_RTS)
+		mcr &= ~MCR_RTS;
+	if (clear & TIOCM_DTR)
+		mcr &= ~MCR_DTR;
+	if (clear & TIOCM_LOOP)
+		mcr &= ~MCR_LOOPBACK;
 
 	edge_port->shadow_mcr = mcr;
 
@@ -2447,12 +2432,17 @@
 	return 0;
 }
 
-static int get_modem_info (struct edgeport_port *edge_port, unsigned int *value)
+static int edge_tiocmget(struct usb_serial_port *port, struct file *file)
 {
+        struct edgeport_port *edge_port = usb_get_serial_port_data(port);
 	unsigned int result = 0;
-	unsigned int msr = edge_port->shadow_msr;
-	unsigned int mcr = edge_port->shadow_mcr;
+	unsigned int msr;
+	unsigned int mcr;
 
+	dbg("%s - port %d", __FUNCTION__, port->number);
+
+	msr = edge_port->shadow_msr;
+	mcr = edge_port->shadow_mcr;
 	result = ((mcr & MCR_DTR)	? TIOCM_DTR: 0)	  /* 0x002 */
 		  | ((mcr & MCR_RTS)	? TIOCM_RTS: 0)   /* 0x004 */
 		  | ((msr & MSR_CTS)	? TIOCM_CTS: 0)   /* 0x020 */
@@ -2463,9 +2453,7 @@
 
 	dbg("%s -- %x", __FUNCTION__, result);
 
-	if (copy_to_user(value, &result, sizeof(int)))
-		return -EFAULT;
-	return 0;
+	return result;
 }
 
 static int get_serial_info (struct edgeport_port *edge_port, struct serial_struct * retinfo)
@@ -2515,18 +2503,6 @@
 //			return get_lsr_info(edge_port, (unsigned int *) arg);
 			break;
 
-		case TIOCMBIS:
-		case TIOCMBIC:
-		case TIOCMSET:
-			dbg("%s - (%d) TIOCMSET/TIOCMBIC/TIOCMSET", __FUNCTION__, port->number);
-			return set_modem_info(edge_port, cmd, (unsigned int *) arg);
-			break;
-
-		case TIOCMGET:  
-			dbg("%s - (%d) TIOCMGET", __FUNCTION__, port->number);
-			return get_modem_info(edge_port, (unsigned int *) arg);
-			break;
-
 		case TIOCGSERIAL:
 			dbg("%s - (%d) TIOCGSERIAL", __FUNCTION__, port->number);
 			return get_serial_info(edge_port, (struct serial_struct *) arg);
@@ -2665,6 +2641,8 @@
 	.shutdown		= edge_shutdown,
 	.ioctl			= edge_ioctl,
 	.set_termios		= edge_set_termios,
+	.tiocmget		= edge_tiocmget,
+	.tiocmset		= edge_tiocmset,
 	.write			= edge_write,
 	.write_room		= edge_write_room,
 	.chars_in_buffer	= edge_chars_in_buffer,
@@ -2688,6 +2666,8 @@
 	.shutdown		= edge_shutdown,
 	.ioctl			= edge_ioctl,
 	.set_termios		= edge_set_termios,
+	.tiocmget		= edge_tiocmget,
+	.tiocmset		= edge_tiocmset,
 	.write			= edge_write,
 	.write_room		= edge_write_room,
 	.chars_in_buffer	= edge_chars_in_buffer,
diff -Nru a/drivers/usb/serial/keyspan.c b/drivers/usb/serial/keyspan.c
--- a/drivers/usb/serial/keyspan.c	Thu Apr 24 16:22:31 2003
+++ b/drivers/usb/serial/keyspan.c	Thu Apr 24 16:22:31 2003
@@ -282,48 +282,46 @@
 	keyspan_send_setup(port, 0);
 }
 
-static int keyspan_ioctl(struct usb_serial_port *port, struct file *file,
-			     unsigned int cmd, unsigned long arg)
+static int keyspan_tiocmget(struct usb_serial_port *port, struct file *file)
 {
-	unsigned int			value, set;
+	unsigned int			value;
 	struct keyspan_port_private 	*p_priv;
 
 	p_priv = usb_get_serial_port_data(port);
 	
-	switch (cmd) {
-	case TIOCMGET:
-		value = ((p_priv->rts_state) ? TIOCM_RTS : 0) |
-			((p_priv->dtr_state) ? TIOCM_DTR : 0) |
-			((p_priv->cts_state) ? TIOCM_CTS : 0) |
-			((p_priv->dsr_state) ? TIOCM_DSR : 0) |
-			((p_priv->dcd_state) ? TIOCM_CAR : 0) |
-			((p_priv->ri_state) ? TIOCM_RNG : 0); 
-
-		if (put_user(value, (unsigned int *) arg))
-			return -EFAULT;
-		return 0;
+	value = ((p_priv->rts_state) ? TIOCM_RTS : 0) |
+		((p_priv->dtr_state) ? TIOCM_DTR : 0) |
+		((p_priv->cts_state) ? TIOCM_CTS : 0) |
+		((p_priv->dsr_state) ? TIOCM_DSR : 0) |
+		((p_priv->dcd_state) ? TIOCM_CAR : 0) |
+		((p_priv->ri_state) ? TIOCM_RNG : 0); 
+
+	return value;
+}
+
+static int keyspan_tiocmset(struct usb_serial_port *port, struct file *file,
+			    unsigned int set, unsigned int clear)
+{
+	struct keyspan_port_private 	*p_priv;
+
+	p_priv = usb_get_serial_port_data(port);
 	
-	case TIOCMSET:
-		if (get_user(value, (unsigned int *) arg))
-			return -EFAULT;
-		p_priv->rts_state = ((value & TIOCM_RTS) ? 1 : 0);
-		p_priv->dtr_state = ((value & TIOCM_DTR) ? 1 : 0);
-		keyspan_send_setup(port, 0);
-		return 0;
-
-	case TIOCMBIS:
-	case TIOCMBIC:
-		if (get_user(value, (unsigned int *) arg))
-			return -EFAULT;
-		set = (cmd == TIOCMBIS);
-		if (value & TIOCM_RTS)
-			p_priv->rts_state = set;
-		if (value & TIOCM_DTR)
-			p_priv->dtr_state = set;
-		keyspan_send_setup(port, 0);
-		return 0;
-	}
+	if (set & TIOCM_RTS)
+		p_priv->rts_state = 1;
+	if (set & TIOCM_DTR)
+		p_priv->dtr_state = 1;
+
+	if (clear & TIOCM_RTS)
+		p_priv->rts_state = 0;
+	if (clear & TIOCM_DTR)
+		p_priv->dtr_state = 0;
+	keyspan_send_setup(port, 0);
+	return 0;
+}
 
+static int keyspan_ioctl(struct usb_serial_port *port, struct file *file,
+			     unsigned int cmd, unsigned long arg)
+{
 	return -ENOIOCTLCMD;
 }
 
diff -Nru a/drivers/usb/serial/keyspan.h b/drivers/usb/serial/keyspan.h
--- a/drivers/usb/serial/keyspan.h	Thu Apr 24 16:22:31 2003
+++ b/drivers/usb/serial/keyspan.h	Thu Apr 24 16:22:31 2003
@@ -63,6 +63,11 @@
 					 struct termios *old);
 static void keyspan_break_ctl		(struct usb_serial_port *port,
 					 int break_state);
+static int  keyspan_tiocmget		(struct usb_serial_port *port,
+					 struct file *file);
+static int  keyspan_tiocmset		(struct usb_serial_port *port,
+					 struct file *file, unsigned int set,
+					 unsigned int clear);
 static int  keyspan_fake_startup	(struct usb_serial *serial);
 
 static int  keyspan_usa19_calc_baud	(u32 baud_rate, u32 baudclk, 
@@ -551,6 +556,8 @@
 	.ioctl			= keyspan_ioctl,
 	.set_termios		= keyspan_set_termios,
 	.break_ctl		= keyspan_break_ctl,
+	.tiocmget		= keyspan_tiocmget,
+	.tiocmset		= keyspan_tiocmset,
 	.attach			= keyspan_startup,
 	.shutdown		= keyspan_shutdown,
 };
@@ -574,6 +581,8 @@
 	.ioctl			= keyspan_ioctl,
 	.set_termios		= keyspan_set_termios,
 	.break_ctl		= keyspan_break_ctl,
+	.tiocmget		= keyspan_tiocmget,
+	.tiocmset		= keyspan_tiocmset,
 	.attach			= keyspan_startup,
 	.shutdown		= keyspan_shutdown,
 };
@@ -597,6 +606,8 @@
 	.ioctl			= keyspan_ioctl,
 	.set_termios		= keyspan_set_termios,
 	.break_ctl		= keyspan_break_ctl,
+	.tiocmget		= keyspan_tiocmget,
+	.tiocmset		= keyspan_tiocmset,
 	.attach			= keyspan_startup,
 	.shutdown		= keyspan_shutdown,
 };
diff -Nru a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
--- a/drivers/usb/serial/keyspan_pda.c	Thu Apr 24 16:22:31 2003
+++ b/drivers/usb/serial/keyspan_pda.c	Thu Apr 24 16:22:31 2003
@@ -457,62 +457,54 @@
 	return rc;
 }
 
+static int keyspan_pda_tiocmget(struct usb_serial_port *port, struct file *file)
+{
+	struct usb_serial *serial = port->serial;
+	int rc;
+	unsigned char status;
+	int value;
 
-static int keyspan_pda_ioctl(struct usb_serial_port *port, struct file *file,
-			     unsigned int cmd, unsigned long arg)
+	rc = keyspan_pda_get_modem_info(serial, &status);
+	if (rc < 0)
+		return rc;
+	value =
+		((status & (1<<7)) ? TIOCM_DTR : 0) |
+		((status & (1<<6)) ? TIOCM_CAR : 0) |
+		((status & (1<<5)) ? TIOCM_RNG : 0) |
+		((status & (1<<4)) ? TIOCM_DSR : 0) |
+		((status & (1<<3)) ? TIOCM_CTS : 0) |
+		((status & (1<<2)) ? TIOCM_RTS : 0);
+	return value;
+}
+
+static int keyspan_pda_tiocmset(struct usb_serial_port *port, struct file *file,
+				unsigned int set, unsigned int clear)
 {
 	struct usb_serial *serial = port->serial;
 	int rc;
-	unsigned int value;
-	unsigned char status, mask;
+	unsigned char status;
 
+	rc = keyspan_pda_get_modem_info(serial, &status);
+	if (rc < 0)
+		return rc;
+
+	if (set & TIOCM_RTS)
+		status |= (1<<2);
+	if (set & TIOCM_DTR)
+		status |= (1<<7);
+
+	if (clear & TIOCM_RTS)
+		status &= ~(1<<2);
+	if (clear & TIOCM_DTR)
+		status &= ~(1<<7);
+	rc = keyspan_pda_set_modem_info(serial, status);
+	return rc;
+}
+
+static int keyspan_pda_ioctl(struct usb_serial_port *port, struct file *file,
+			     unsigned int cmd, unsigned long arg)
+{
 	switch (cmd) {
-	case TIOCMGET: /* get modem pins state */
-		rc = keyspan_pda_get_modem_info(serial, &status);
-		if (rc < 0)
-			return rc;
-		value =
-			((status & (1<<7)) ? TIOCM_DTR : 0) |
-			((status & (1<<6)) ? TIOCM_CAR : 0) |
-			((status & (1<<5)) ? TIOCM_RNG : 0) |
-			((status & (1<<4)) ? TIOCM_DSR : 0) |
-			((status & (1<<3)) ? TIOCM_CTS : 0) |
-			((status & (1<<2)) ? TIOCM_RTS : 0);
-		if (copy_to_user((unsigned int *)arg, &value, sizeof(int)))
-			return -EFAULT;
-		return 0;
-	case TIOCMSET: /* set a state as returned by MGET */
-		if (copy_from_user(&value, (unsigned int *)arg, sizeof(int)))
-			return -EFAULT;
-		status =
-			((value & TIOCM_DTR) ? (1<<7) : 0) |
-			((value & TIOCM_CAR) ? (1<<6) : 0) |
-			((value & TIOCM_RNG) ? (1<<5) : 0) |
-			((value & TIOCM_DSR) ? (1<<4) : 0) |
-			((value & TIOCM_CTS) ? (1<<3) : 0) |
-			((value & TIOCM_RTS) ? (1<<2) : 0);
-		rc = keyspan_pda_set_modem_info(serial, status);
-		if (rc < 0)
-			return rc;
-		return 0;
-	case TIOCMBIS: /* set bits in bitmask <arg> */
-	case TIOCMBIC: /* clear bits from bitmask <arg> */
-		if (copy_from_user(&value, (unsigned int *)arg, sizeof(int)))
-			return -EFAULT;
-		rc = keyspan_pda_get_modem_info(serial, &status);
-		if (rc < 0)
-			return rc;
-		mask =
-			((value & TIOCM_RTS) ? (1<<2) : 0) |
-			((value & TIOCM_DTR) ? (1<<7) : 0);
-		if (cmd == TIOCMBIS)
-			status |= mask;
-		else
-			status &= ~mask;
-		rc = keyspan_pda_set_modem_info(serial, status);
-		if (rc < 0)
-			return rc;
-		return 0;
 	case TIOCMIWAIT:
 		/* wait for any of the 4 modem inputs (DCD,RI,DSR,CTS)*/
 		/* TODO */
@@ -874,6 +866,8 @@
 	.ioctl =		keyspan_pda_ioctl,
 	.set_termios =		keyspan_pda_set_termios,
 	.break_ctl =		keyspan_pda_break_ctl,
+	.tiocmget =		keyspan_pda_tiocmget,
+	.tiocmset =		keyspan_pda_tiocmset,
 	.attach =		keyspan_pda_startup,
 	.shutdown =		keyspan_pda_shutdown,
 };

