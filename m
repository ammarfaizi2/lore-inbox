Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVB0Xpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVB0Xpt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 18:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVB0Xpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 18:45:49 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:33171 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261206AbVB0Xip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 18:38:45 -0500
Message-ID: <42225A04.7080505@us.ltcfwd.linux.ibm.com>
Date: Sun, 27 Feb 2005 18:38:44 -0500
From: Wen Xiong <wendyx@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [ patch 2/7] drivers/serial/jsm: new serial device driver
Content-Type: multipart/mixed;
 boundary="------------050507040306080901010107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050507040306080901010107
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This second patch is for jsm_tty.c and included all handling TTY layer 
functions.

Signed-off-by: Wen Xiong <wendyx@us.ltcfwd.linux.ibm.com>

--------------050507040306080901010107
Content-Type: text/plain;
 name="patch2.jasmine"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch2.jasmine"

diff -Nuar linux-2.6.9.orig/drivers/serial/jsm/jsm_tty.c linux-2.6.9.new/drivers/serial/jsm/jsm_tty.c
--- linux-2.6.9.orig/drivers/serial/jsm/jsm_tty.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.9.new/drivers/serial/jsm/jsm_tty.c	2005-02-27 17:09:43.456960832 -0600
@@ -0,0 +1,1273 @@
+/*
+ * Copyright 2003 Digi International (www.digi.com)
+ *	Scott H Kilau <Scott_Kilau at digi dot com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, EXPRESS OR IMPLIED; without even the
+ * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
+ * PURPOSE.  See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ *	NOTE TO LINUX KERNEL HACKERS:  DO NOT REFORMAT THIS CODE! 
+ *
+ *	This is shared code between Digi's CVS archive and the
+ *	Linux Kernel sources.
+ *	Changing the source just for reformatting needlessly breaks
+ *	our CVS diff history.
+ *
+ *	Send any bug fixes/changes to:  Eng.Linux at digi dot com. 
+ *	Thank you. 
+ */
+
+/************************************************************************
+ * 
+ * This file implements the tty driver functionality for the
+ * Neo and ClassicBoard PCI based product lines.
+ * 
+ ************************************************************************
+ *
+ * $Id: jsm_tty.c,v 1.79 2004/09/25 07:01:46 scottk Exp $
+ */
+
+#include <linux/kernel.h>
+#include <linux/version.h>
+#include <linux/sched.h>	/* For jiffies, task states */
+#include <linux/interrupt.h>	/* For tasklet and interrupt structs/defines */
+#include <linux/module.h>
+#include <linux/ctype.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/serial_reg.h>
+#include <linux/slab.h>
+#include <linux/delay.h>	/* For udelay */
+#include <linux/device.h>	/* For udelay */
+#include <asm/uaccess.h>	/* For copy_from_user/copy_to_user */
+
+#include "jsm_driver.h"
+#include "jsm_tty.h"
+#include "jsm_types.h"
+#include "jsm_neo.h"
+#include "dpacompat.h"
+
+/*
+ * internal variables
+ */
+#define JSM_CHANNEL ((struct channel_t *)port)
+
+/*
+ * Define a local default termios struct. All ports will be created
+ * with this termios initially.
+ *
+ * This defines a raw port at 9600 baud, 8 data bits, no parity,
+ * 1 stop bit.
+ */
+
+/*Begin Serial_core API*/
+
+static inline int jsm_get_mstat(struct channel_t *ch)
+{
+	unsigned char mstat;
+	unsigned char result;
+
+	DPR_IOCTL(("jsm_getmstat start\n"));
+
+	mstat = (ch->ch_mostat | ch->ch_mistat);
+
+	result = 0;
+
+	if (mstat & UART_MCR_DTR)
+		result |= TIOCM_DTR;
+	if (mstat & UART_MCR_RTS)
+		result |= TIOCM_RTS;
+	if (mstat & UART_MSR_CTS)
+		result |= TIOCM_CTS;
+	if (mstat & UART_MSR_DSR)
+		result |= TIOCM_DSR;
+	if (mstat & UART_MSR_RI)
+		result |= TIOCM_RI;
+	if (mstat & UART_MSR_DCD)
+		result |= TIOCM_CD;
+
+	DPR_IOCTL(("jsm_getmstat finish\n"));
+	return result;
+}
+
+static unsigned int jsm_tty_tx_empty(struct uart_port *port)
+{
+	return TIOCSER_TEMT;
+}
+
+/*
+ * Return modem signals to ld.
+ */
+static unsigned int jsm_tty_get_mctrl(struct uart_port *port)
+{
+	int result;
+
+	DPR_IOCTL(("jsm_get_modem_info start\n"));
+
+	result = jsm_get_mstat(JSM_CHANNEL);
+
+	if (result < 0)
+		return -ENXIO;
+
+	DPR_IOCTL(("jsm_get_modem_info finish\n"));
+
+	return result;
+}
+
+/*
+ * jsm_set_modem_info()
+ *
+ * Set modem signals, called by ld.
+ */
+static void jsm_tty_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	DPR_IOCTL(("jsm_set_modem_info() start\n"));
+
+	if (mctrl & TIOCM_RTS)
+		JSM_CHANNEL->ch_mostat |= UART_MCR_RTS;
+	else
+		JSM_CHANNEL->ch_mostat &= ~UART_MCR_RTS;

+	if (mctrl & TIOCM_DTR)
+		JSM_CHANNEL->ch_mostat |= UART_MCR_DTR;
+	else
+		JSM_CHANNEL->ch_mostat &= ~UART_MCR_DTR;
+
+	JSM_CHANNEL->ch_bd->bd_ops->assert_modem_signals(JSM_CHANNEL);
+
+	DPR_IOCTL(("jsm_set_modem_info finish\n"));
+
+	udelay(10);
+
+}
+
+static void jsm_tty_start_tx(struct uart_port *port, unsigned int tty_start)
+{
+	DPR_IOCTL(("dgcn_tty_start start\n"));
+
+	JSM_CHANNEL->ch_flags &= ~(CH_STOP);
+
+	jsm_tty_write(port);
+
+	DPR_IOCTL(("jsm_tty_start finish\n"));
+
+}
+
+static void jsm_tty_stop_tx(struct uart_port *port, unsigned int tty_stop)
+{
+	DPR_IOCTL(("jsm_tty_stop start\n"));
+
+	JSM_CHANNEL->ch_flags |= (CH_STOP);
+
+	DPR_IOCTL(("jsm_tty_stop finish\n"));
+}
+
+static void jsm_tty_send_xchar(struct uart_port *port, char ch)
+{
+	unsigned long lock_flags;
+
+	spin_lock_irqsave(&port->lock, lock_flags);
+	if (ch == port->info->tty->termios->c_cc[VSTART])
+		JSM_CHANNEL->ch_bd->bd_ops->send_start_character(JSM_CHANNEL);
+
+	if (ch == port->info->tty->termios->c_cc[VSTOP])
+		JSM_CHANNEL->ch_bd->bd_ops->send_stop_character(JSM_CHANNEL);
+	spin_unlock_irqrestore(&port->lock, lock_flags);
+}
+
+static void jsm_tty_stop_rx(struct uart_port *port)
+{
+
+	JSM_CHANNEL->ch_bd->bd_ops->disable_receiver(JSM_CHANNEL);
+
+}
+
+static void jsm_tty_break(struct uart_port *port, int break_state)
+{
+	unsigned long lock_flags;
+	spin_lock_irqsave(&port->lock, lock_flags);
+	if (break_state == -1)
+		JSM_CHANNEL->ch_bd->bd_ops->send_break(JSM_CHANNEL);
+	else
+		neo_clear_break(JSM_CHANNEL,0);
+
+	spin_unlock_irqrestore(&port->lock, lock_flags);
+}
+
+static int jsm_tty_open(struct uart_port *port)
+{
+	struct board_t	*brd;
+	struct un_t	*un;
+	int		rc = 0;
+
+	/* Get board pointer from our array of majors we have allocated */
+	brd = JSM_CHANNEL->ch_bd;
+
+	un = &JSM_CHANNEL->ch_tun;
+	un->un_type = JSM_SERIAL;
+
+	/*
+	 * Initialize tty's
+	 */
+	if (!(un->un_flags & UN_ISOPEN)) {
+		/* Store important variables. */
+		un->un_ch = JSM_CHANNEL;
+		un->un_dev = JSM_CHANNEL->ch_portnum;
+
+		/* Maybe do something here to the TTY struct as well? */
+	}
+
+	/*
+	 * Allocate channel buffers for read/write/error.
+	 * Set flag, so we don't get trounced on.
+	 */
+	JSM_CHANNEL->ch_flags |= (CH_OPENING);
+
+	/* Drop locks, as malloc with GFP_KERNEL can sleep */
+
+	if (!JSM_CHANNEL->ch_rqueue) {
+		JSM_CHANNEL->ch_rqueue = (uchar *) kmalloc(RQUEUESIZE, GFP_KERNEL);
+		if (!JSM_CHANNEL->ch_rqueue) {
+			DPR_INIT(("unable to allocate read queue buf"));
+			return -ENOMEM;
+		}
+		memset(JSM_CHANNEL->ch_rqueue, 0, RQUEUESIZE);
+	}
+	if (!JSM_CHANNEL->ch_equeue) {
+		JSM_CHANNEL->ch_equeue = (uchar *) kmalloc(EQUEUESIZE, GFP_KERNEL);
+		if (!JSM_CHANNEL->ch_equeue) {
+			DPR_INIT(("unable to allocate error queue buf"));
+			return -ENOMEM;
+		}
+		memset(JSM_CHANNEL->ch_equeue, 0, EQUEUESIZE);
+	}
+	if (!JSM_CHANNEL->ch_wqueue) {
+		JSM_CHANNEL->ch_wqueue = (uchar *) kmalloc(WQUEUESIZE, GFP_KERNEL);
+		if (!JSM_CHANNEL->ch_wqueue) {
+			DPR_INIT(("unable to allocate write queue buf"));
+			return -ENOMEM;
+		}
+		memset(JSM_CHANNEL->ch_wqueue, 0, WQUEUESIZE);
+	}
+
+	JSM_CHANNEL->ch_flags &= ~(CH_OPENING);
+	/*
+	 * Initialize if neither terminal is open.
+	 */
+	if (!(un->un_flags & UN_ISOPEN)) {
+		DPR_OPEN(("jsm_open: initializing channel in open...\n"));
+
+		/*
+		 * Flush input queues.
+		 */
+		JSM_CHANNEL->ch_r_head = JSM_CHANNEL->ch_r_tail = 0;
+		JSM_CHANNEL->ch_e_head = JSM_CHANNEL->ch_e_tail = 0;
+		JSM_CHANNEL->ch_w_head = JSM_CHANNEL->ch_w_tail = 0;
+
+		brd->bd_ops->flush_uart_write(JSM_CHANNEL);
+		brd->bd_ops->flush_uart_read(JSM_CHANNEL);
+
+		JSM_CHANNEL->ch_flags = 0;
+		JSM_CHANNEL->ch_cached_lsr = 0;
+		JSM_CHANNEL->ch_stops_sent = 0;
+
+		JSM_CHANNEL->ch_c_cflag   = port->info->tty->termios->c_cflag;
+		JSM_CHANNEL->ch_c_iflag   = port->info->tty->termios->c_iflag;
+		JSM_CHANNEL->ch_c_oflag   = port->info->tty->termios->c_oflag;
+		JSM_CHANNEL->ch_c_lflag   = port->info->tty->termios->c_lflag;
+		JSM_CHANNEL->ch_startc = port->info->tty->termios->c_cc[VSTART];
+		JSM_CHANNEL->ch_stopc  = port->info->tty->termios->c_cc[VSTOP];
+
+		/* Tell UART to init itself */
+		brd->bd_ops->uart_init(JSM_CHANNEL);
+	}
+	/*
+	 * Run param in case we changed anything
+	 */
+	brd->bd_ops->param(JSM_CHANNEL);
+
+	jsm_carrier(JSM_CHANNEL);
+	un->un_open_count++;
+	un->un_flags |= (UN_ISOPEN);
+
+	DPR_OPEN(("jsm_tty_open finished\n"));
+	return rc;
+}
+
+static void jsm_tty_close(struct uart_port *port)
+{
+	struct board_t *bd;
+	struct un_t *un;
+	struct termios *ts;
+	int rc = 0;
+
+	un = &JSM_CHANNEL->ch_tun;
+	
+	bd = JSM_CHANNEL->ch_bd;
+
+	ts = JSM_CHANNEL->uart_port.info->tty->termios;
+
+	DPR_CLOSE(("Close called\n"));
+
+	un->un_flags |= UN_CLOSING;
+
+	if ((JSM_CHANNEL->ch_open_count == 0)) {
+
+		JSM_CHANNEL->ch_flags &= ~(CH_STOPI);
+
+		/* wait for output to drain */
+		/* This will also return if we take an interrupt */
+
+		DPR_CLOSE(("Calling wait_for_drain\n"));
+		rc = bd->bd_ops->drain(port->info->tty, 0);
+
+		DPR_CLOSE(("After calling wait_for_drain\n"));
+
+		if (rc)
+			DPR_BASIC(("jsm_tty_close - bad return: %d ", rc));
+
+		/*
+		 * If we have HUPCL set, lower DTR and RTS
+		 */
+		if (JSM_CHANNEL->ch_c_cflag & HUPCL) {
+			DPR_CLOSE(("Close. HUPCL set, dropping DTR/RTS\n"));
+
+			/* Drop RTS/DTR */
+			JSM_CHANNEL->ch_mostat &= ~(UART_MCR_DTR | UART_MCR_RTS);
+			bd->bd_ops->assert_modem_signals(JSM_CHANNEL);
+
+			/*
+			 * Go to sleep to ensure RTS/DTR 
+			 * have been dropped for modems to see it.
+			 */
+		}
+
+		JSM_CHANNEL->ch_old_baud = 0;
+
+		/* Turn off UART interrupts for this port */
+		JSM_CHANNEL->ch_bd->bd_ops->uart_off(JSM_CHANNEL);
+	}
+
+	un->un_tty = NULL;
+	un->un_flags &= ~(UN_ISOPEN | UN_CLOSING);
+
+	DPR_CLOSE(("Close. Doing wakeups\n"));
+
+	DPR_BASIC(("jsm_tty_close - complete\n"));
+}
+
+static void jsm_tty_set_termios(struct uart_port *port,
+				 struct termios *termios,
+				 struct termios *old_termios)
+{
+	unsigned long lock_flags;
+
+	spin_lock_irqsave(&port->lock, lock_flags);
+	JSM_CHANNEL->ch_c_cflag   = termios->c_cflag;
+	JSM_CHANNEL->ch_c_iflag   = termios->c_iflag;
+	JSM_CHANNEL->ch_c_oflag   = termios->c_oflag;
+	JSM_CHANNEL->ch_c_lflag   = termios->c_lflag;
+	JSM_CHANNEL->ch_startc	= termios->c_cc[VSTART];
+	JSM_CHANNEL->ch_stopc	= termios->c_cc[VSTOP];
+
+	JSM_CHANNEL->ch_bd->bd_ops->param(JSM_CHANNEL);
+	jsm_carrier(JSM_CHANNEL);
+	spin_unlock_irqrestore(&port->lock, lock_flags);
+}
+
+static const char *jsm_tty_type(struct uart_port *port)
+{
+	return "jsm";
+}
+
+static void jsm_tty_release_port(struct uart_port *port)
+{
+}
+
+static int jsm_tty_request_port(struct uart_port *port)
+{
+	return 0;
+}
+
+static void jsm_config_port(struct uart_port *port, int flags)
+{
+	port->type = PORT_JSM;
+}
+
+static struct uart_ops jsm_ops = {
+	.tx_empty	= jsm_tty_tx_empty,
+	.set_mctrl	= jsm_tty_set_mctrl,
+	.get_mctrl	= jsm_tty_get_mctrl,
+	.stop_tx	= jsm_tty_stop_tx,
+	.start_tx	= jsm_tty_start_tx,
+	.send_xchar	= jsm_tty_send_xchar,
+	.stop_rx	= jsm_tty_stop_rx,
+	.break_ctl	= jsm_tty_break,
+	.startup	= jsm_tty_open,
+	.shutdown	= jsm_tty_close,
+	.set_termios	= jsm_tty_set_termios,
+	.type		= jsm_tty_type,
+	.release_port	= jsm_tty_release_port,
+	.request_port	= jsm_tty_request_port,
+	.config_port	= jsm_config_port,
+};
+
+/*
+ * jsm_tty_register()
+ *
+ * Init the tty subsystem for this board.
+ */
+int jsm_tty_register(struct board_t *brd)
+{
+	int rc = 0;
+
+	DPR_INIT(("tty_register start\n"));
+
+	if (!brd->jsm_Major_Serial_Registered) {
+		if (rc < 0) {
+			APR(("Can't register tty device (%d)\n", rc));
+			return rc;
+		}
+		brd->jsm_Major_Serial_Registered = TRUE;
+		brd->jsm_Serial_Major = jsm_uart_driver.major;
+	}
+
+	DPR_INIT(("JSM REGISTER TTY: MAJOR: %d\n", jsm_uart_driver.major));
+
+	return rc;
+}
+
+/*
+ * jsm_tty_init()
+ *
+ * Init the tty subsystem.  Called once per board after board has been
+ * downloaded and init'ed.
+ */
+int jsm_tty_init(struct board_t *brd)
+{
+	int i;
+	uchar *vaddr;
+	struct channel_t *ch;
+
+	if (!brd)
+		return -ENXIO;
+
+	DPR_INIT(("jsm_tty_init start\n"));
+
+	/*
+	 * Initialize board structure elements.
+	 */
+
+	vaddr = brd->re_map_membase;
+
+	brd->nasync = brd->maxports;
+
+	/*
+	 * Allocate channel memory that might not have been allocated
+	 * when the driver was first loaded.
+	 */
+	for (i = 0; i < brd->nasync; i++) {
+		if (!brd->channels[i]) {
+
+			/*
+			 * Okay to malloc with GFP_KERNEL, we are not at
+			 * interrupt context, and there are no locks held.
+			 */
+			brd->channels[i] = kmalloc(sizeof(struct channel_t), GFP_KERNEL);
+			if (!brd->channels[i]) {
+				DPR_CORE(("%s:%d Unable to allocate memory for channel struct\n",
+				__FILE__, __LINE__));
+			}
+			memset(brd->channels[i], 0, sizeof(struct channel_t));
+		}
+	}
+
+	ch = brd->channels[0];
+	vaddr = brd->re_map_membase;
+
+	/* Set up channel variables */
+	for (i = 0; i < brd->nasync; i++, ch = brd->channels[i]) {
+
+		if (!brd->channels[i])
+			continue;
+
+		spin_lock_init(&ch->ch_lock);
+
+		/* Store all our magic numbers */
+		ch->magic = JSM_CHANNEL_MAGIC;
+		ch->ch_tun.magic = JSM_UNIT_MAGIC;
+		ch->ch_pun.magic = JSM_UNIT_MAGIC;
+
+		if (brd->bd_uart_offset == 0x200)
+			ch->ch_neo_uart = (struct neo_uart_struct *) ((ulong) vaddr + (brd->bd_uart_offset * i));
+
+		ch->ch_bd = brd;
+		ch->ch_portnum = i;
+
+		/* .25 second delay */
+		ch->ch_close_delay = 250;
+
+		init_waitqueue_head(&ch->ch_flags_wait);
+		init_waitqueue_head(&ch->ch_tun.un_flags_wait);
+		init_waitqueue_head(&ch->ch_pun.un_flags_wait);
+		init_waitqueue_head(&ch->ch_sniff_wait);
+	}
+
+	DPR_INIT(("jsm_tty_init finish\n"));
+
+	return 0;
+}
+
+int jsm_uart_port_init(struct board_t *brd)
+{
+	int i;
+	uchar *vaddr;
+	struct channel_t *ch;
+
+	if (!brd)
+		return -ENXIO;
+
+	DPR_INIT(("jsm_uart_port_init start\n"));
+
+	/*
+	 * Initialize board structure elements.
+	 */
+
+	vaddr = brd->re_map_membase;
+
+	brd->nasync = brd->maxports;
+
+	/* Set up channel variables */
+	for (i = 0; i < brd->nasync; i++, ch = brd->channels[i]) {
+
+		if (!brd->channels[i])
+			continue;
+
+		brd->channels[i]->uart_port.irq = brd->irq;
+		brd->channels[i]->uart_port.type = PORT_JSM;
+		brd->channels[i]->uart_port.iotype = UPIO_MEM;
+		brd->channels[i]->uart_port.membase = brd->re_map_membase;
+		brd->channels[i]->uart_port.fifosize = 16;
+		brd->channels[i]->uart_port.ops = &jsm_ops;
+		brd->channels[i]->uart_port.line = brd->channels[i]->ch_portnum + brd->boardnum * 2;
+		if (uart_add_one_port (&jsm_uart_driver, &brd->channels[i]->uart_port)) 
+			printk(KERN_INFO "Added device failed\n");
+		else
+			printk(KERN_INFO "Added device \n");
+	}
+
+	DPR_INIT(("jsm_uart_port_init finish\n"));
+
+	return 0;
+}
+
+int jsm_remove_uart_port(struct board_t *brd)
+{
+	int i;
+	struct channel_t *ch;
+
+	if (!brd)
+		return -ENXIO;
+
+	DPR_INIT(("jsm_uart_port_init start\n"));
+
+	/*
+	 * Initialize board structure elements.
+	 */
+
+	brd->nasync = brd->maxports;
+
+	/* Set up channel variables */
+	for (i = 0; i < brd->nasync; i++) {
+
+		if (!brd->channels[i])
+			continue;
+
+		ch = brd->channels[i];
+
+		uart_remove_one_port(&jsm_uart_driver, &brd->channels[i]->uart_port);  
+	}
+
+	DPR_INIT(("jsm_uart_port_init finish\n"));
+
+	return 0;
+}
+
+/*
+ * jsm_tty_uninit()
+ *
+ * Uninitialize the TTY portion of this driver.  Free all memory and
+ * resources. 
+ */
+
+void jsm_tty_uninit(struct board_t *brd)
+{
+
+	if (brd->jsm_Major_Serial_Registered)
+		brd->jsm_Major_Serial_Registered = FALSE;
+}
+
+#define TMPBUFLEN (1024)
+
+/*
+ * jsm_sniff - Dump data out to the "sniff" buffer if the
+ * proc sniff file is opened...
+ */
+
+void jsm_sniff_nowait_nolock(struct channel_t *ch, uchar *text, uchar *buf, int len)
+{
+	struct timeval tv;
+	int n;
+	int r;
+	int nbuf;
+	int i;
+	int tmpbuflen;
+	char tmpbuf[TMPBUFLEN];
+	char *p = tmpbuf;
+	int too_much_data;
+
+	/* Leave if sniff not open */
+	if (!(ch->ch_sniff_flags & SNIFF_OPEN))
+		return;
+
+	do_gettimeofday(&tv);
+
+	/* Create our header for data dump */
+	p += sprintf(p, "<%ld %ld><%s><", tv.tv_sec, tv.tv_usec, text);
+	tmpbuflen = p - tmpbuf;
+
+	do {
+		too_much_data = 0;
+
+		for (i = 0; i < len && tmpbuflen < (TMPBUFLEN - 4); i++) {
+			p += sprintf(p, "%02x ", *buf);
+			buf++;
+			tmpbuflen = p - tmpbuf;
+		}
+
+		if (tmpbuflen < (TMPBUFLEN - 4)) {
+			if (i > 0)
+				p += sprintf(p - 1, "%s\n", ">");
+			else
+				p += sprintf(p, "%s\n", ">");
+		} else {
+			too_much_data = 1;
+			len -= i;
+		}
+
+		nbuf = strlen(tmpbuf);
+		p = tmpbuf;
+
+		/*
+		 *  Loop while data remains.
+		 */
+		while (nbuf > 0 && ch->ch_sniff_buf != 0) {
+			/*
+			 *  Determine the amount of available space left in the
+			 *  buffer.  If there's none, wait until some appears.
+			 */
+			n = (ch->ch_sniff_out - ch->ch_sniff_in - 1) & SNIFF_MASK;
+
+			/*
+			 * If there is no space left to write to in our sniff buffer,
+			 * we have no choice but to drop the data.
+			 * We *cannot* sleep here waiting for space, because this
+			 * function was probably called by the interrupt/timer routines!
+			 */
+			if (n == 0)
+				return;
+	
+			/*
+			 * Copy as much data as will fit.
+			 */
+
+			if (n > nbuf)
+				n = nbuf;
+
+			r = SNIFF_MAX - ch->ch_sniff_in;
+
+			if (r <= n) {
+				memcpy(ch->ch_sniff_buf + ch->ch_sniff_in, p, r);
+
+				n -= r;
+				ch->ch_sniff_in = 0;
+				p += r;
+				nbuf -= r;
+			}
+
+			memcpy(ch->ch_sniff_buf + ch->ch_sniff_in, p, n);
+
+			ch->ch_sniff_in += n;
+			p += n;
+			nbuf -= n;
+
+			/*
+			 *  Wakeup any thread waiting for data
+			 */
+			if (ch->ch_sniff_flags & SNIFF_WAIT_DATA) {
+				ch->ch_sniff_flags &= ~SNIFF_WAIT_DATA;
+				wake_up_interruptible(&ch->ch_sniff_wait);
+			}
+		}
+
+		/*
+		 * If the user sent us too much data to push into our tmpbuf,
+		 * we need to keep looping around on all the data.
+		 */
+		if (too_much_data) {
+			p = tmpbuf;
+			tmpbuflen = 0;
+		}
+
+	} while (too_much_data);
+}
+
+/*
+ *
+ *jsm_input - Process received data.
+ * 
+ *ch - Pointer to channel structure.
+ * 
+ */
+
+void jsm_input(struct channel_t *ch)
+{
+	struct board_t *bd;
+	struct tty_struct *tp;
+	uint	rmask;
+	ushort	head;
+	ushort	tail;
+	int	data_len;
+	ulong	lock_flags;
+	int flip_len;
+	int len = 0;
+	int n = 0;
+	char *buf = NULL;
+	char *buf2 = NULL;
+	int s = 0;
+	int i = 0;
+
+	if (!ch || ch->magic != JSM_CHANNEL_MAGIC)
+		return;
+
+	tp = ch->uart_port.info->tty;
+
+	bd = ch->ch_bd;
+	if(!bd || bd->magic != JSM_BOARD_MAGIC)
+		return;
+
+	spin_lock_irqsave(&ch->ch_lock, lock_flags);
+
+	/* 
+	 *Figure the number of characters in the buffer.   
+	 *Exit immediately if none.
+	 */
+
+	rmask = RQUEUEMASK;
+
+	head = ch->ch_r_head & rmask;
+	tail = ch->ch_r_tail & rmask;
+
+	data_len = (head - tail) & rmask;
+	if (data_len == 0) {
+		spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
+		return;
+	}
+
+	DPR_READ(("jsm_input start\n"));
+
+	/*
+	 *If the device is not open, or CREAD is off, flush
+	 *input data and return immediately.
+	 */
+	if (!tp || !(ch->ch_tun.un_flags & UN_ISOPEN) || 
+		!(tp->termios->c_cflag & CREAD) || (ch->ch_tun.un_flags & UN_CLOSING)) {
+
+		DPR_READ(("input. dropping %d bytes on port %d...\n", data_len, ch->ch_portnum));
+		DPR_READ(("input. tp: %p tp->magic: %x MAGIC:%x ch flags: %x\n",
+			tp, tp ? tp->magic : 0, TTY_MAGIC, ch->ch_tun.un_flags));
+
+		ch->ch_r_head = tail;
+
+		/* Force queue flow control to be released, if needed */
+		jsm_check_queue_flow_control(ch);
+
+		spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
+		return;
+	}
+
+	/*
+	 * If we are throttled, simply don't read any data.
+	 */
+	if (ch->ch_flags &  CH_STOPI) {
+		spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
+		DPR_READ(("Port %d throttled, not reading any data. head: %x tail: %x\n",
+			ch->ch_portnum, head, tail));
+		return;
+	}
+
+	DPR_READ(("jsm_input start 2\n"));
+
+	/*
+	 * If the rxbuf is empty and we are not throttled, put as much
+	 * as we can directly into the linux TTY flip buffer.  
+	 * The jsm_rawreadok case takes advantage of carnal knowledge that
+	 * the char_buf and the flag_buf are next to each other and
+	 * are each of (2 * TTY_FLIPBUF_SIZE) size.
+	 *
+	 * NOTE: if(!tty->real_raw), the call to ldisc.receive_buf
+	 *actually still uses the flag buffer, so you can't
+	 *use it for input data
+	 */
+	if (jsm_rawreadok) {
+		if (tp->real_raw)
+			flip_len = MYFLIPLEN;
+		else
+			flip_len = 2 * TTY_FLIPBUF_SIZE;
+	} else
+		flip_len = TTY_FLIPBUF_SIZE - tp->flip.count;
+
+	len = min(data_len, flip_len);
+	len = min(len, (N_TTY_BUF_SIZE - 1) - tp->read_cnt);
+
+	if (len <= 0) {
+		spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
+		DPR_READ(("jsm_input 1 - finish\n"));
+		return;
+	}
+
+	/*
+	 * If we're bypassing flip buffers on rx, we can blast it
+	 * right into the beginning of the buffer.
+	 */ 
+	if (jsm_rawreadok) {
+		if (tp->real_raw) {
+			if (ch->ch_flags & CH_FLIPBUF_IN_USE) {
+				DPR_READ(("JSM - FLIPBUF in use. delaying input\n"));
+				spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
+				return;
+			}
+			ch->ch_flags |= CH_FLIPBUF_IN_USE;
+			buf = ch->ch_bd->flipbuf;
+			buf2 = NULL;
+		} else {
+			buf  = tp->flip.char_buf;
+			buf2 = tp->flip.flag_buf;
+		}
+	} else {
+		buf  = tp->flip.char_buf_ptr;
+		buf2 = tp->flip.flag_buf_ptr;
+	}
+
+	n = len;
+
+	/*
+	 * n now contains the most amount of data we can copy,
+	 * bounded either by the flip buffer size or the amount
+	 * of data the card actually has pending...
+	 */
+	while (n) {
+		s = ((head >= tail) ? head : RQUEUESIZE) - tail;
+		s = min(s, n);
+
+		if (s <= 0)
+			break;
+
+		memcpy(buf, ch->ch_rqueue + tail, s);
+		jsm_sniff_nowait_nolock(ch, "USER READ", ch->ch_rqueue + tail, s);
+
+		/* buf2 is only set when port isn't raw */
+		if (buf2)
+			memcpy(buf2, ch->ch_equeue + tail, s);
+
+
+
+		tail += s;
+		buf += s;
+		if (buf2)
+			buf2 += s;
+		n -= s;
+		/* Flip queue if needed */
+		tail &= rmask;
+	}
+
+	/*  
+	 * In high performance mode, we don't have to update
+	 * flag_buf or any of the counts or pointers into flip buf.
+	 */
+	if (!jsm_rawreadok) {
+		if (I_PARMRK(tp) || I_BRKINT(tp) || I_INPCK(tp)) {
+			for (i = 0; i < len; i++) {
+				/*
+				 * Give the Linux ld the flags in the
+				 * format it likes.
+				 */
+				if (tp->flip.flag_buf_ptr[i] & UART_LSR_BI)
+					tp->flip.flag_buf_ptr[i] = TTY_BREAK;
+				else if (tp->flip.flag_buf_ptr[i] & UART_LSR_PE)
+					tp->flip.flag_buf_ptr[i] = TTY_PARITY;
+				else if (tp->flip.flag_buf_ptr[i] & UART_LSR_FE)
+					tp->flip.flag_buf_ptr[i] = TTY_FRAME;
+				else 
+					tp->flip.flag_buf_ptr[i] = TTY_NORMAL;
+			}
+		} else  {
+			memset(tp->flip.flag_buf_ptr, 0, len);
+		}
+
+		tp->flip.char_buf_ptr += len;
+		tp->flip.flag_buf_ptr += len;
+		tp->flip.count += len;
+	}
+	else if (!tp->real_raw) {
+		if (I_PARMRK(tp) || I_BRKINT(tp) || I_INPCK(tp)) {
+			for (i = 0; i < len; i++) {
+				/*
+				 * Give the Linux ld the flags in the
+				 * format it likes.
+				 */
+				if (tp->flip.flag_buf_ptr[i] & UART_LSR_BI)
+					tp->flip.flag_buf_ptr[i] = TTY_BREAK;
+				else if (tp->flip.flag_buf_ptr[i] & UART_LSR_PE)
+					tp->flip.flag_buf_ptr[i] = TTY_PARITY;
+				else if (tp->flip.flag_buf_ptr[i] & UART_LSR_FE)
+					tp->flip.flag_buf_ptr[i] = TTY_FRAME;
+				else 
+					tp->flip.flag_buf_ptr[i] = TTY_NORMAL;
+			}
+		} else
+			memset(tp->flip.flag_buf, 0, len);
+	}
+
+	/*
+	 * If we're doing raw reads, jam it right into the
+	 * line disc bypassing the flip buffers.
+	 */
+	if (jsm_rawreadok) {
+		if (tp->real_raw) {
+			ch->ch_r_tail = tail & rmask;
+			ch->ch_e_tail = tail & rmask;
+
+			jsm_check_queue_flow_control(ch);
+
+			/* !!! WE *MUST* LET GO OF ALL LOCKS BEFORE CALLING RECEIVE BUF !!! */
+
+			spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
+
+			DPR_READ(("jsm_input. %d real_raw len:%d calling receive_buf for buffer for board %d\n", 
+				 __LINE__, len, ch->ch_bd->boardnum));
+			tp->ldisc.receive_buf(tp, ch->ch_bd->flipbuf, NULL, len);
+
+			/* Allow use of channel flip buffer again */
+			spin_lock_irqsave(&ch->ch_lock, lock_flags);
+			ch->ch_flags &= ~CH_FLIPBUF_IN_USE;
+			spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
+
+		} else {
+			ch->ch_r_tail = tail & rmask;
+			ch->ch_e_tail = tail & rmask;
+
+			jsm_check_queue_flow_control(ch);
+
+			/* !!! WE *MUST* LET GO OF ALL LOCKS BEFORE CALLING RECEIVE BUF !!! */
+			spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
+
+			DPR_READ(("jsm_input. %d not real_raw len:%d calling receive_buf for buffer for board %d\n", 
+				 __LINE__, len, ch->ch_bd->boardnum));
+
+			tp->ldisc.receive_buf(tp, tp->flip.char_buf, tp->flip.flag_buf, len);
+		}
+	} else  {
+		ch->ch_r_tail = tail & rmask;
+		ch->ch_e_tail = tail & rmask;
+
+		jsm_check_queue_flow_control(ch);
+
+		spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
+
+		DPR_READ(("jsm_input. %d not jsm_read raw okay scheduling flip\n", __LINE__)); 
+		tty_schedule_flip(tp);
+	}
+
+	DPR_READ(("jsm_input - finish\n"));
+}
+
+void jsm_carrier(struct channel_t *ch)
+{
+	struct board_t *bd;
+
+	int virt_carrier = 0;
+	int phys_carrier = 0;
+ 
+	DPR_CARR(("jsm_carrier called...\n"));
+
+	if (!ch || ch->magic != JSM_CHANNEL_MAGIC)
+		return;
+
+	bd = ch->ch_bd;
+
+	if (!bd || bd->magic != JSM_BOARD_MAGIC)
+		return;
+
+	if (ch->ch_mistat & UART_MSR_DCD) {
+		DPR_CARR(("mistat: %x  D_CD: %x\n", ch->ch_mistat, ch->ch_mistat & UART_MSR_DCD));
+		phys_carrier = 1;
+	}
+
+	if (ch->ch_c_cflag & CLOCAL)
+		virt_carrier = 1;
+
+	DPR_CARR(("DCD: physical: %d virt: %d\n", phys_carrier, virt_carrier));
+
+	/*
+	 * Test for a VIRTUAL carrier transition to HIGH.
+	 */
+	if (((ch->ch_flags & CH_FCAR) == 0) && (virt_carrier == 1)) {
+
+		/*
+		 * When carrier rises, wake any threads waiting
+		 * for carrier in the open routine.
+		 */
+
+		DPR_CARR(("carrier: virt DCD rose\n"));
+
+		if (waitqueue_active(&(ch->ch_flags_wait)))
+			wake_up_interruptible(&ch->ch_flags_wait);
+	}
+
+	/*
+	 * Test for a PHYSICAL carrier transition to HIGH.
+	 */
+	if (((ch->ch_flags & CH_CD) == 0) && (phys_carrier == 1)) {
+
+		/*
+		 * When carrier rises, wake any threads waiting
+		 * for carrier in the open routine.
+		 */
+
+		DPR_CARR(("carrier: physical DCD rose\n"));
+
+		if (waitqueue_active(&(ch->ch_flags_wait)))
+			wake_up_interruptible(&ch->ch_flags_wait);
+	}
+
+	/*
+	 *  Test for a PHYSICAL transition to low, so long as we aren't
+	 *  currently ignoring physical transitions (which is what "virtual
+	 *  carrier" indicates).
+	 *
+	 *  The transition of the virtual carrier to low really doesn't
+	 *  matter... it really only means "ignore carrier state", not
+	 *  "make pretend that carrier is there".
+	 */
+	if ((virt_carrier == 0) && ((ch->ch_flags & CH_CD) != 0) 
+			&& (phys_carrier == 0)) {
+		/*
+		 *   When carrier drops:
+		 *
+		 *   Drop carrier on all open units.
+		 *
+		 *   Flush queues, waking up any task waiting in the
+		 *   line discipline.
+		 *
+		 *   Send a hangup to the control terminal.
+		 *
+		 *   Enable all select calls.
+		 */
+		if (waitqueue_active(&(ch->ch_flags_wait)))
+			wake_up_interruptible(&ch->ch_flags_wait);
+
+		if (ch->ch_tun.un_open_count > 0) {
+			DPR_CARR(("Sending tty hangup\n"));
+			tty_hangup(ch->ch_tun.un_tty);
+		}
+
+		if (ch->ch_pun.un_open_count > 0) { 
+			DPR_CARR(("Sending pr hangup\n"));
+			tty_hangup(ch->ch_pun.un_tty);
+		}
+	}
+
+	/*
+	 *  Make sure that our cached values reflect the current reality.
+	 */
+	if (virt_carrier == 1)
+		ch->ch_flags |= CH_FCAR;
+	else
+		ch->ch_flags &= ~CH_FCAR;
+
+	if (phys_carrier == 1)
+		ch->ch_flags |= CH_CD;
+	else
+		ch->ch_flags &= ~CH_CD;
+}
+
+
+void jsm_check_queue_flow_control(struct channel_t *ch)
+{
+	int qleft = 0;
+
+	/* Store how much space we have left in the queue */
+	if ((qleft = ch->ch_r_tail - ch->ch_r_head - 1) < 0)
+		qleft += RQUEUEMASK + 1;
+
+	/*
+	 * Check to see if we should enforce flow control on our queue because
+	 * the ld (or user) isn't reading data out of our queue fast enuf.
+	 *
+	 * NOTE: This is done based on what the current flow control of the
+	 * port is set for.
+	 *
+	 * 1) HWFLOW (RTS) - Turn off the UART's Receive interrupt.
+	 *	This will cause the UART's FIFO to back up, and force
+	 *	the RTS signal to be dropped.
+	 * 2) SWFLOW (IXOFF) - Keep trying to send a stop character to
+	 *	the other side, in hopes it will stop sending data to us.
+	 * 3) NONE - Nothing we can do.  We will simply drop any extra data
+	 *	that gets sent into us when the queue fills up.
+	 */
+	if (qleft < 256) {
+		/* HWFLOW */
+		if (ch->ch_c_cflag & CRTSCTS) {
+			if(!(ch->ch_flags & CH_RECEIVER_OFF)) {
+				ch->ch_bd->bd_ops->disable_receiver(ch);
+				ch->ch_flags |= (CH_RECEIVER_OFF);
+				DPR_READ(("Internal queue hit hilevel mark (%d)! Turning off interrupts.\n",
+					qleft));
+			}
+		}
+		/* SWFLOW */
+		else if (ch->ch_c_iflag & IXOFF) {
+			if (ch->ch_stops_sent <= MAX_STOPS_SENT) {
+				ch->ch_bd->bd_ops->send_stop_character(ch);
+				ch->ch_stops_sent++;
+				DPR_READ(("Sending stop char!  Times sent: %x\n", ch->ch_stops_sent));
+			}
+		}
+	}
+
+	/*
+	 * Check to see if we should unenforce flow control because
+	 * ld (or user) finally read enuf data out of our queue.
+	 *
+	 * NOTE: This is done based on what the current flow control of the
+	 * port is set for.
+	 *
+	 * 1) HWFLOW (RTS) - Turn back on the UART's Receive interrupt.
+	 *	This will cause the UART's FIFO to raise RTS back up,
+	 *	which will allow the other side to start sending data again.
+	 * 2) SWFLOW (IXOFF) - Send a start character to
+	 *	the other side, so it will start sending data to us again.
+	 * 3) NONE - Do nothing. Since we didn't do anything to turn off the
+	 *	other side, we don't need to do anything now.
+	 */
+	if (qleft > (RQUEUESIZE / 2)) {
+		/* HWFLOW */
+		if (ch->ch_c_cflag & CRTSCTS) {
+			if (ch->ch_flags & CH_RECEIVER_OFF) {
+				ch->ch_bd->bd_ops->enable_receiver(ch);
+				ch->ch_flags &= ~(CH_RECEIVER_OFF);
+				DPR_READ(("Internal queue hit lowlevel mark (%d)! Turning on interrupts.\n",
+					qleft));
+			}
+		}
+		/* SWFLOW */
+		else if (ch->ch_c_iflag & IXOFF && ch->ch_stops_sent) {
+			ch->ch_stops_sent = 0;
+			ch->ch_bd->bd_ops->send_start_character(ch);
+			DPR_READ(("Sending start char!\n"));
+		}
+	}
+}
+
+/*
+ * jsm_tty_write()
+ *
+ * Take data from the user or kernel and send it out to the FEP.
+ * In here exists all the Transparent Print magic as well.
+ */
+int jsm_tty_write(struct uart_port *port)
+{
+	struct un_t *un = NULL;
+	int bufcount = 0, n = 0;
+	int data_count = 0,data_count1 =0;
+	ushort head;
+	ushort tail;
+	ushort tmask;
+	uint remain;
+	int temp_tail = port->info->xmit.tail;
+
+	un = &JSM_CHANNEL->ch_tun;
+
+	tmask = WQUEUEMASK;
+	head = (JSM_CHANNEL->ch_w_head) & tmask;
+	tail = (JSM_CHANNEL->ch_w_tail) & tmask;
+
+	if ((bufcount = tail - head - 1) < 0)
+		bufcount += WQUEUESIZE;
+
+	n = bufcount;
+
+	n = min(n, 56);
+	remain = WQUEUESIZE - head;
+
+	data_count = 0;
+	if (n >= remain) {
+		n -= remain;
+		while ((port->info->xmit.head != temp_tail) &&
+		(data_count < remain)) {
+			JSM_CHANNEL->ch_wqueue[head++] =
+			port->info->xmit.buf[temp_tail];
+
+			temp_tail++;
+			temp_tail &= (UART_XMIT_SIZE - 1);
+			data_count++;
+		}
+		if (data_count == remain) head = 0;
+	}
+
+	data_count1 = 0;
+	if (n > 0) {
+		remain = n;
+		while ((port->info->xmit.head != temp_tail) &&
+			(data_count1 < remain)) {
+			JSM_CHANNEL->ch_wqueue[head++] =
+				port->info->xmit.buf[temp_tail];
+
+			temp_tail++;
+			temp_tail &= (UART_XMIT_SIZE - 1);
+			data_count1++;
+
+		}
+	}
+
+	port->info->xmit.tail = temp_tail;
+
+	data_count += data_count1;
+	if (data_count) {
+		head &= tmask;
+		JSM_CHANNEL->ch_w_head = head;
+	}
+
+	if (data_count) {
+		JSM_CHANNEL->ch_bd->bd_ops->copy_data_from_queue_to_uart(JSM_CHANNEL);
+	}
+
+	return data_count;
+}

--------------050507040306080901010107--

