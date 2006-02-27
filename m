Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751549AbWB0GYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbWB0GYy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 01:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbWB0GYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 01:24:54 -0500
Received: from wp060.webpack.hosteurope.de ([80.237.132.67]:57311 "EHLO
	wp060.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S1751472AbWB0GYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 01:24:51 -0500
Date: Mon, 27 Feb 2006 07:23:11 +0100
From: Hansjoerg Lipp <hjlipp@web.de>
To: Karsten Keil <kkeil@suse.de>
Cc: i4ldeveloper@listserv.isdn4linux.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       Tilman Schmidt <tilman@imap.cc>
Subject: [PATCH 6/7] isdn4linux: Siemens Gigaset drivers - M105 USB DECT adapter
Message-ID: <gigaset307x.2006.02.27.001.6@hjlipp.my-fqdn.de>
References: <gigaset307x.2006.02.27.001.0@hjlipp.my-fqdn.de> <gigaset307x.2006.02.27.001.1@hjlipp.my-fqdn.de> <gigaset307x.2006.02.27.001.2@hjlipp.my-fqdn.de> <gigaset307x.2006.02.27.001.3@hjlipp.my-fqdn.de> <gigaset307x.2006.02.27.001.4@hjlipp.my-fqdn.de> <gigaset307x.2006.02.27.001.5@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gigaset307x.2006.02.27.001.5@hjlipp.my-fqdn.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tilman Schmidt <tilman@imap.cc>, Hansjoerg Lipp <hjlipp@web.de>

This patch adds the connection-specific module "usb_gigaset", the
hardware driver for Gigaset base stations connected via the M105 USB
DECT adapter. It contains the code for handling probe/disconnect, AT
command/response transmission, and call setup and termination, as well
as handling asynchronous data transfers, PPP framing, byte stuffing,
and flow control.

Signed-off-by: Hansjoerg Lipp <hjlipp@web.de>
Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---

 drivers/isdn/gigaset/asyncdata.c   |  600 +++++++++++++++++++++++
 drivers/isdn/gigaset/usb-gigaset.c |  964 +++++++++++++++++++++++++++++++++++++
 2 files changed, 1564 insertions(+)

--- linux-2.6.16-rc4.orig/drivers/isdn/gigaset/usb-gigaset.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.16-rc4-mm2/drivers/isdn/gigaset/usb-gigaset.c	2006-02-24 00:19:28.000000000 +0100
@@ -0,0 +1,964 @@
+/*
+ * USB driver for Gigaset 307x directly or using M105 Data.
+ *
+ * Copyright (c) 2001 by Stefan Eilers <Eilers.Stefan@epost.de>
+ *                   and Hansjoerg Lipp <hjlipp@web.de>.
+ *
+ * This driver was derived from the USB skeleton driver by
+ * Greg Kroah-Hartman <greg@kroah.com>
+ *
+ * =====================================================================
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation; either version 2 of
+ *	the License, or (at your option) any later version.
+ * =====================================================================
+ */
+
+#include "gigaset.h"
+
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/usb.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+
+/* Version Information */
+#define DRIVER_AUTHOR "Hansjoerg Lipp <hjlipp@web.de>, Stefan Eilers <Eilers.Stefan@epost.de>"
+#define DRIVER_DESC "USB Driver for Gigaset 307x using M105"
+
+/* Module parameters */
+
+static int startmode = SM_ISDN;
+static int cidmode = 1;
+
+module_param(startmode, int, S_IRUGO);
+module_param(cidmode, int, S_IRUGO);
+MODULE_PARM_DESC(startmode, "start in isdn4linux mode");
+MODULE_PARM_DESC(cidmode, "Call-ID mode");
+
+#define GIGASET_MINORS     1
+#define GIGASET_MINOR      8
+#define GIGASET_MODULENAME "usb_gigaset"
+#define GIGASET_DEVFSNAME  "gig/usb/"
+#define GIGASET_DEVNAME    "ttyGU"
+
+#define IF_WRITEBUF 2000 //FIXME  // WAKEUP_CHARS: 256
+
+/* Values for the Gigaset M105 Data */
+#define USB_M105_VENDOR_ID	0x0681
+#define USB_M105_PRODUCT_ID	0x0009
+
+/* table of devices that work with this driver */
+static struct usb_device_id gigaset_table [] = {
+	{ USB_DEVICE(USB_M105_VENDOR_ID, USB_M105_PRODUCT_ID) },
+	{ }					/* Terminating entry */
+};
+
+MODULE_DEVICE_TABLE(usb, gigaset_table);
+
+/*
+ * Control requests (empty fields: 00)
+ *
+ *       RT|RQ|VALUE|INDEX|LEN  |DATA
+ * In:
+ *       C1 08             01
+ *            Get flags (1 byte). Bits: 0=dtr,1=rts,3-7:?
+ *       C1 0F             ll ll
+ *            Get device information/status (llll: 0x200 and 0x40 seen).
+ *            Real size: I only saw MIN(llll,0x64).
+ *            Contents: seems to be always the same...
+ *              offset 0x00: Length of this structure (0x64) (len: 1,2,3 bytes)
+ *              offset 0x3c: String (16 bit chars): "MCCI USB Serial V2.0"
+ *              rest:        ?
+ * Out:
+ *       41 11
+ *            Initialize/reset device ?
+ *       41 00 xx 00
+ *            ? (xx=00 or 01; 01 on start, 00 on close)
+ *       41 07 vv mm
+ *            Set/clear flags vv=value, mm=mask (see RQ 08)
+ *       41 12 xx
+ *            Used before the following configuration requests are issued
+ *            (with xx=0x0f). I've seen other values<0xf, though.
+ *       41 01 xx xx
+ *            Set baud rate. xxxx=ceil(0x384000/rate)=trunc(0x383fff/rate)+1.
+ *       41 03 ps bb
+ *            Set byte size and parity. p:  0x20=even,0x10=odd,0x00=no parity
+ *                                     [    0x30: m, 0x40: s           ]
+ *                                     [s:  0: 1 stop bit; 1: 1.5; 2: 2]
+ *                                      bb: bits/byte (seen 7 and 8)
+ *       41 13 -- -- -- -- 10 00 ww 00 00 00 xx 00 00 00 yy 00 00 00 zz 00 00 00
+ *            ??
+ *            Initialization: 01, 40, 00, 00
+ *            Open device:    00  40, 00, 00
+ *            yy and zz seem to be equal, either 0x00 or 0x0a
+ *            (ww,xx) pairs seen: (00,00), (00,40), (01,40), (09,80), (19,80)
+ *       41 19 -- -- -- -- 06 00 00 00 00 xx 11 13
+ *            Used after every "configuration sequence" (RQ 12, RQs 01/03/13).
+ *            xx is usually 0x00 but was 0x7e before starting data transfer
+ *            in unimodem mode. So, this might be an array of characters that need
+ *            special treatment ("commit all bufferd data"?), 11=^Q, 13=^S.
+ *
+ * Unimodem mode: use "modprobe ppp_async flag_time=0" as the device _needs_ two
+ * flags per packet.
+ */
+
+static int gigaset_probe(struct usb_interface *interface,
+			 const struct usb_device_id *id);
+static void gigaset_disconnect(struct usb_interface *interface);
+
+static struct gigaset_driver *driver = NULL;
+static struct cardstate *cardstate = NULL;
+
+/* usb specific object needed to register this driver with the usb subsystem */
+static struct usb_driver gigaset_usb_driver = {
+	.name =		GIGASET_MODULENAME,
+	.probe =	gigaset_probe,
+	.disconnect =	gigaset_disconnect,
+	.id_table =	gigaset_table,
+};
+
+struct usb_cardstate {
+	struct usb_device	*udev;		/* usb device pointer */
+	struct usb_interface	*interface;	/* interface for this device */
+	atomic_t		busy;		/* bulk output in progress */
+
+	/* Output buffer */
+	unsigned char		*bulk_out_buffer;
+	int			bulk_out_size;
+	__u8			bulk_out_endpointAddr;
+	struct urb		*bulk_out_urb;
+
+	/* Input buffer */
+	int			rcvbuf_size;
+	struct urb		*read_urb;
+	__u8			int_in_endpointAddr;
+
+	char			bchars[6];		/* for request 0x19 */
+};
+
+struct usb_bc_state {};
+
+static inline unsigned tiocm_to_gigaset(unsigned state)
+{
+	return ((state & TIOCM_DTR) ? 1 : 0) | ((state & TIOCM_RTS) ? 2 : 0);
+}
+
+#ifdef CONFIG_GIGASET_UNDOCREQ
+/* WARNING: EXPERIMENTAL! */
+static int gigaset_set_modem_ctrl(struct cardstate *cs, unsigned old_state,
+				  unsigned new_state)
+{
+	struct usb_device *udev = cs->hw.usb->udev;
+	unsigned mask, val;
+	int r;
+
+	mask = tiocm_to_gigaset(old_state ^ new_state);
+	val = tiocm_to_gigaset(new_state);
+
+	gig_dbg(DEBUG_USBREQ, "set flags 0x%02x with mask 0x%02x", val, mask);
+	// don't use this in an interrupt/BH
+	r = usb_control_msg(udev, usb_sndctrlpipe(udev, 0), 7, 0x41,
+			    (val & 0xff) | ((mask & 0xff) << 8), 0,
+			    NULL, 0, 2000 /* timeout? */);
+	if (r < 0)
+		return r;
+	//..
+	return 0;
+}
+
+static int set_value(struct cardstate *cs, u8 req, u16 val)
+{
+	struct usb_device *udev = cs->hw.usb->udev;
+	int r, r2;
+
+	gig_dbg(DEBUG_USBREQ, "request %02x (%04x)",
+		(unsigned)req, (unsigned)val);
+	r = usb_control_msg(udev, usb_sndctrlpipe(udev, 0), 0x12, 0x41,
+			    0xf /*?*/, 0, NULL, 0, 2000 /*?*/);
+			    /* no idea what this does */
+	if (r < 0) {
+		dev_err(&udev->dev, "error %d on request 0x12\n", -r);
+		return r;
+	}
+
+	r = usb_control_msg(udev, usb_sndctrlpipe(udev, 0), req, 0x41,
+			    val, 0, NULL, 0, 2000 /*?*/);
+	if (r < 0)
+		dev_err(&udev->dev, "error %d on request 0x%02x\n",
+			-r, (unsigned)req);
+
+	r2 = usb_control_msg(udev, usb_sndctrlpipe(udev, 0), 0x19, 0x41,
+			     0, 0, cs->hw.usb->bchars, 6, 2000 /*?*/);
+	if (r2 < 0)
+		dev_err(&udev->dev, "error %d on request 0x19\n", -r2);
+
+	return r < 0 ? r : (r2 < 0 ? r2 : 0);
+}
+
+/* WARNING: HIGHLY EXPERIMENTAL! */
+// don't use this in an interrupt/BH
+static int gigaset_baud_rate(struct cardstate *cs, unsigned cflag)
+{
+	u16 val;
+	u32 rate;
+
+	cflag &= CBAUD;
+
+	switch (cflag) {
+	//FIXME more values?
+	case    B300: rate =     300; break;
+	case    B600: rate =     600; break;
+	case   B1200: rate =    1200; break;
+	case   B2400: rate =    2400; break;
+	case   B4800: rate =    4800; break;
+	case   B9600: rate =    9600; break;
+	case  B19200: rate =   19200; break;
+	case  B38400: rate =   38400; break;
+	case  B57600: rate =   57600; break;
+	case B115200: rate =  115200; break;
+	default:
+		rate =  9600;
+		dev_err(cs->dev, "unsupported baudrate request 0x%x,"
+			" using default of B9600\n", cflag);
+	}
+
+	val = 0x383fff / rate + 1;
+
+	return set_value(cs, 1, val);
+}
+
+/* WARNING: HIGHLY EXPERIMENTAL! */
+// don't use this in an interrupt/BH
+static int gigaset_set_line_ctrl(struct cardstate *cs, unsigned cflag)
+{
+	u16 val = 0;
+
+	/* set the parity */
+	if (cflag & PARENB)
+		val |= (cflag & PARODD) ? 0x10 : 0x20;
+
+	/* set the number of data bits */
+	switch (cflag & CSIZE) {
+	case CS5:
+		val |= 5 << 8; break;
+	case CS6:
+		val |= 6 << 8; break;
+	case CS7:
+		val |= 7 << 8; break;
+	case CS8:
+		val |= 8 << 8; break;
+	default:
+		dev_err(cs->dev, "CSIZE was not CS5-CS8, using default of 8\n");
+		val |= 8 << 8;
+		break;
+	}
+
+	/* set the number of stop bits */
+	if (cflag & CSTOPB) {
+		if ((cflag & CSIZE) == CS5)
+			val |= 1; /* 1.5 stop bits */ //FIXME is this okay?
+		else
+			val |= 2; /* 2 stop bits */
+	}
+
+	return set_value(cs, 3, val);
+}
+
+#else
+static int gigaset_set_modem_ctrl(struct cardstate *cs, unsigned old_state,
+				  unsigned new_state)
+{
+	return -EINVAL;
+}
+
+static int gigaset_set_line_ctrl(struct cardstate *cs, unsigned cflag)
+{
+	return -EINVAL;
+}
+
+static int gigaset_baud_rate(struct cardstate *cs, unsigned cflag)
+{
+	return -EINVAL;
+}
+#endif
+
+
+ /*================================================================================================================*/
+static int gigaset_init_bchannel(struct bc_state *bcs)
+{
+	/* nothing to do for M10x */
+	gigaset_bchannel_up(bcs);
+	return 0;
+}
+
+static int gigaset_close_bchannel(struct bc_state *bcs)
+{
+	/* nothing to do for M10x */
+	gigaset_bchannel_down(bcs);
+	return 0;
+}
+
+static int write_modem(struct cardstate *cs);
+static int send_cb(struct cardstate *cs, struct cmdbuf_t *cb);
+
+
+/* Write tasklet handler: Continue sending current skb, or send command, or
+ * start sending an skb from the send queue.
+ */
+static void gigaset_modem_fill(unsigned long data)
+{
+	struct cardstate *cs = (struct cardstate *) data;
+	struct bc_state *bcs = &cs->bcs[0]; /* only one channel */
+	struct cmdbuf_t *cb;
+	unsigned long flags;
+	int again;
+
+	gig_dbg(DEBUG_OUTPUT, "modem_fill");
+
+	if (atomic_read(&cs->hw.usb->busy)) {
+		gig_dbg(DEBUG_OUTPUT, "modem_fill: busy");
+		return;
+	}
+
+	do {
+		again = 0;
+		if (!bcs->tx_skb) { /* no skb is being sent */
+			spin_lock_irqsave(&cs->cmdlock, flags);
+			cb = cs->cmdbuf;
+			spin_unlock_irqrestore(&cs->cmdlock, flags);
+			if (cb) { /* commands to send? */
+				gig_dbg(DEBUG_OUTPUT, "modem_fill: cb");
+				if (send_cb(cs, cb) < 0) {
+					gig_dbg(DEBUG_OUTPUT,
+						"modem_fill: send_cb failed");
+					again = 1; /* no callback will be
+						      called! */
+				}
+			} else { /* skbs to send? */
+				bcs->tx_skb = skb_dequeue(&bcs->squeue);
+				if (bcs->tx_skb)
+					gig_dbg(DEBUG_INTR,
+						"Dequeued skb (Adr: %lx)!",
+						(unsigned long) bcs->tx_skb);
+			}
+		}
+
+		if (bcs->tx_skb) {
+			gig_dbg(DEBUG_OUTPUT, "modem_fill: tx_skb");
+			if (write_modem(cs) < 0) {
+				gig_dbg(DEBUG_OUTPUT,
+					"modem_fill: write_modem failed");
+				// FIXME should we tell the LL?
+				again = 1; /* no callback will be called! */
+			}
+		}
+	} while (again);
+}
+
+/**
+ *	gigaset_read_int_callback
+ *
+ *	It is called if the data was received from the device.
+ */
+static void gigaset_read_int_callback(struct urb *urb, struct pt_regs *regs)
+{
+	int resubmit = 0;
+	int r;
+	struct cardstate *cs;
+	unsigned numbytes;
+	unsigned char *src;
+	struct inbuf_t *inbuf;
+
+	IFNULLRET(urb);
+	inbuf = (struct inbuf_t *) urb->context;
+	IFNULLRET(inbuf);
+	cs = inbuf->cs;
+	IFNULLRET(cs);
+
+	if (!atomic_read(&cs->connected)) {
+		err("%s: disconnected", __func__);
+		return;
+	}
+
+	if (!urb->status) {
+		numbytes = urb->actual_length;
+
+		if (numbytes) {
+			src = inbuf->rcvbuf;
+			if (unlikely(*src))
+				dev_warn(cs->dev,
+				    "%s: There was no leading 0, but 0x%02x!\n",
+					 __func__, (unsigned) *src);
+			++src; /* skip leading 0x00 */
+			--numbytes;
+			if (gigaset_fill_inbuf(inbuf, src, numbytes)) {
+				gig_dbg(DEBUG_INTR, "%s-->BH", __func__);
+				gigaset_schedule_event(inbuf->cs);
+			}
+		} else
+			gig_dbg(DEBUG_INTR, "Received zero block length");
+		resubmit = 1;
+	} else {
+		/* The urb might have been killed. */
+		gig_dbg(DEBUG_ANY, "%s - nonzero read bulk status received: %d",
+			__func__, urb->status);
+		if (urb->status != -ENOENT) /* not killed */
+			resubmit = 1;
+	}
+
+	if (resubmit) {
+		r = usb_submit_urb(urb, SLAB_ATOMIC);
+		if (r)
+			dev_err(cs->dev, "error %d when resubmitting urb.\n",
+				-r);
+	}
+}
+
+
+/* This callback routine is called when data was transmitted to the device. */
+static void gigaset_write_bulk_callback(struct urb *urb, struct pt_regs *regs)
+{
+	struct cardstate *cs = (struct cardstate *) urb->context;
+
+	IFNULLRET(cs);
+#ifdef CONFIG_GIGASET_DEBUG
+	if (!atomic_read(&cs->connected)) {
+		err("%s: not connected", __func__);
+		return;
+	}
+#endif
+	if (urb->status)
+		dev_err(cs->dev, "bulk transfer failed (status %d)\n",
+			-urb->status);
+		/* That's all we can do. Communication problems
+		   are handled by timeouts or network protocols. */
+
+	atomic_set(&cs->hw.usb->busy, 0);
+	tasklet_schedule(&cs->write_tasklet);
+}
+
+static int send_cb(struct cardstate *cs, struct cmdbuf_t *cb)
+{
+	struct cmdbuf_t *tcb;
+	unsigned long flags;
+	int count;
+	int status = -ENOENT; // FIXME
+	struct usb_cardstate *ucs = cs->hw.usb;
+
+	do {
+		if (!cb->len) {
+			tcb = cb;
+
+			spin_lock_irqsave(&cs->cmdlock, flags);
+			cs->cmdbytes -= cs->curlen;
+			gig_dbg(DEBUG_OUTPUT, "send_cb: sent %u bytes, %u left",
+				cs->curlen, cs->cmdbytes);
+			cs->cmdbuf = cb = cb->next;
+			if (cb) {
+				cb->prev = NULL;
+				cs->curlen = cb->len;
+			} else {
+				cs->lastcmdbuf = NULL;
+				cs->curlen = 0;
+			}
+			spin_unlock_irqrestore(&cs->cmdlock, flags);
+
+			if (tcb->wake_tasklet)
+				tasklet_schedule(tcb->wake_tasklet);
+			kfree(tcb);
+		}
+		if (cb) {
+			count = min(cb->len, ucs->bulk_out_size);
+			usb_fill_bulk_urb(ucs->bulk_out_urb, ucs->udev,
+					  usb_sndbulkpipe(ucs->udev,
+					     ucs->bulk_out_endpointAddr & 0x0f),
+					  cb->buf + cb->offset, count,
+					  gigaset_write_bulk_callback, cs);
+
+			cb->offset += count;
+			cb->len -= count;
+			atomic_set(&ucs->busy, 1);
+			gig_dbg(DEBUG_OUTPUT, "send_cb: send %d bytes", count);
+
+			status = usb_submit_urb(ucs->bulk_out_urb, SLAB_ATOMIC);
+			if (status) {
+				atomic_set(&ucs->busy, 0);
+				dev_err(cs->dev,
+					"could not submit urb (error %d)\n",
+					-status);
+				cb->len = 0; /* skip urb => remove cb+wakeup
+						in next loop cycle */
+			}
+		}
+	} while (cb && status); /* next command on error */
+
+	return status;
+}
+
+/* Send command to device. */
+static int gigaset_write_cmd(struct cardstate *cs, const unsigned char *buf,
+			     int len, struct tasklet_struct *wake_tasklet)
+{
+	struct cmdbuf_t *cb;
+	unsigned long flags;
+
+	gigaset_dbg_buffer(atomic_read(&cs->mstate) != MS_LOCKED ?
+			     DEBUG_TRANSCMD : DEBUG_LOCKCMD,
+			   "CMD Transmit", len, buf, 0);
+
+	if (!atomic_read(&cs->connected)) {
+		err("%s: not connected", __func__);
+		return -ENODEV;
+	}
+
+	if (len <= 0)
+		return 0;
+
+	if (!(cb = kmalloc(sizeof(struct cmdbuf_t) + len, GFP_ATOMIC))) {
+		dev_err(cs->dev, "%s: out of memory\n", __func__);
+		return -ENOMEM;
+	}
+
+	memcpy(cb->buf, buf, len);
+	cb->len = len;
+	cb->offset = 0;
+	cb->next = NULL;
+	cb->wake_tasklet = wake_tasklet;
+
+	spin_lock_irqsave(&cs->cmdlock, flags);
+	cb->prev = cs->lastcmdbuf;
+	if (cs->lastcmdbuf)
+		cs->lastcmdbuf->next = cb;
+	else {
+		cs->cmdbuf = cb;
+		cs->curlen = len;
+	}
+	cs->cmdbytes += len;
+	cs->lastcmdbuf = cb;
+	spin_unlock_irqrestore(&cs->cmdlock, flags);
+
+	tasklet_schedule(&cs->write_tasklet);
+	return len;
+}
+
+static int gigaset_write_room(struct cardstate *cs)
+{
+	unsigned long flags;
+	unsigned bytes;
+
+	spin_lock_irqsave(&cs->cmdlock, flags);
+	bytes = cs->cmdbytes;
+	spin_unlock_irqrestore(&cs->cmdlock, flags);
+
+	return bytes < IF_WRITEBUF ? IF_WRITEBUF - bytes : 0;
+}
+
+static int gigaset_chars_in_buffer(struct cardstate *cs)
+{
+	return cs->cmdbytes;
+}
+
+static int gigaset_brkchars(struct cardstate *cs, const unsigned char buf[6])
+{
+#ifdef CONFIG_GIGASET_UNDOCREQ
+	struct usb_device *udev = cs->hw.usb->udev;
+
+	gigaset_dbg_buffer(DEBUG_USBREQ, "brkchars", 6, buf, 0);
+	memcpy(cs->hw.usb->bchars, buf, 6);
+	return usb_control_msg(udev, usb_sndctrlpipe(udev, 0), 0x19, 0x41,
+			       0, 0, &buf, 6, 2000);
+#else
+	return -EINVAL;
+#endif
+}
+
+static int gigaset_freebcshw(struct bc_state *bcs)
+{
+	if (!bcs->hw.usb)
+		return 0;
+	//FIXME
+	kfree(bcs->hw.usb);
+	return 1;
+}
+
+/* Initialize the b-channel structure */
+static int gigaset_initbcshw(struct bc_state *bcs)
+{
+	bcs->hw.usb = kmalloc(sizeof(struct usb_bc_state), GFP_KERNEL);
+	if (!bcs->hw.usb)
+		return 0;
+
+	return 1;
+}
+
+static void gigaset_reinitbcshw(struct bc_state *bcs)
+{
+}
+
+static void gigaset_freecshw(struct cardstate *cs)
+{
+	tasklet_kill(&cs->write_tasklet);
+	kfree(cs->hw.usb);
+}
+
+static int gigaset_initcshw(struct cardstate *cs)
+{
+	struct usb_cardstate *ucs;
+
+	cs->hw.usb = ucs =
+		kmalloc(sizeof(struct usb_cardstate), GFP_KERNEL);
+	if (!ucs)
+		return 0;
+
+	ucs->bchars[0] = 0;
+	ucs->bchars[1] = 0;
+	ucs->bchars[2] = 0;
+	ucs->bchars[3] = 0;
+	ucs->bchars[4] = 0x11;
+	ucs->bchars[5] = 0x13;
+	ucs->bulk_out_buffer = NULL;
+	ucs->bulk_out_urb = NULL;
+	//ucs->urb_cmd_out = NULL;
+	ucs->read_urb = NULL;
+	tasklet_init(&cs->write_tasklet,
+		     &gigaset_modem_fill, (unsigned long) cs);
+
+	return 1;
+}
+
+/* Send data from current skb to the device. */
+static int write_modem(struct cardstate *cs)
+{
+	int ret;
+	int count;
+	struct bc_state *bcs = &cs->bcs[0]; /* only one channel */
+	struct usb_cardstate *ucs = cs->hw.usb;
+
+	IFNULLRETVAL(bcs->tx_skb, -EINVAL);
+
+	gig_dbg(DEBUG_WRITE, "len: %d...", bcs->tx_skb->len);
+
+	ret = -ENODEV;
+	IFNULLGOTO(ucs->bulk_out_buffer, error);
+	IFNULLGOTO(ucs->bulk_out_urb, error);
+	ret = 0;
+
+	if (!bcs->tx_skb->len) {
+		dev_kfree_skb_any(bcs->tx_skb);
+		bcs->tx_skb = NULL;
+		return -EINVAL;
+	}
+
+	/* Copy data to bulk out buffer and  // FIXME copying not necessary
+	 * transmit data
+	 */
+	count = min(bcs->tx_skb->len, (unsigned) ucs->bulk_out_size);
+	memcpy(ucs->bulk_out_buffer, bcs->tx_skb->data, count);
+	skb_pull(bcs->tx_skb, count);
+
+	usb_fill_bulk_urb(ucs->bulk_out_urb, ucs->udev,
+			  usb_sndbulkpipe(ucs->udev,
+					  ucs->bulk_out_endpointAddr & 0x0f),
+			  ucs->bulk_out_buffer, count,
+			  gigaset_write_bulk_callback, cs);
+	atomic_set(&ucs->busy, 1);
+	gig_dbg(DEBUG_OUTPUT, "write_modem: send %d bytes", count);
+
+	ret = usb_submit_urb(ucs->bulk_out_urb, SLAB_ATOMIC);
+	if (ret) {
+		dev_err(cs->dev, "could not submit urb (error %d)\n", -ret);
+		atomic_set(&ucs->busy, 0);
+	}
+	if (!bcs->tx_skb->len) {
+		/* skb sent completely */
+		gigaset_skb_sent(bcs, bcs->tx_skb); //FIXME also, when ret<0?
+
+		gig_dbg(DEBUG_INTR, "kfree skb (Adr: %lx)!",
+			(unsigned long) bcs->tx_skb);
+		dev_kfree_skb_any(bcs->tx_skb);
+		bcs->tx_skb = NULL;
+	}
+
+	return ret;
+error:
+	dev_kfree_skb_any(bcs->tx_skb);
+	bcs->tx_skb = NULL;
+	return ret;
+
+}
+
+static int gigaset_probe(struct usb_interface *interface,
+			 const struct usb_device_id *id)
+{
+	int retval;
+	struct usb_device *udev = interface_to_usbdev(interface);
+	unsigned int ifnum;
+	struct usb_host_interface *hostif;
+	struct cardstate *cs = NULL;
+	struct usb_cardstate *ucs = NULL;
+	struct usb_endpoint_descriptor *endpoint;
+	int buffer_size;
+	int alt;
+
+	gig_dbg(DEBUG_ANY,
+		"%s: Check if device matches .. (Vendor: 0x%x, Product: 0x%x)",
+		__func__, le16_to_cpu(udev->descriptor.idVendor),
+		le16_to_cpu(udev->descriptor.idProduct));
+
+	retval = -ENODEV; //FIXME
+
+	/* See if the device offered us matches what we can accept */
+	if ((le16_to_cpu(udev->descriptor.idVendor  != USB_M105_VENDOR_ID)) ||
+	    (le16_to_cpu(udev->descriptor.idProduct != USB_M105_PRODUCT_ID)))
+		return -ENODEV;
+
+	/* this starts to become ascii art... */
+	hostif = interface->cur_altsetting;
+	alt = hostif->desc.bAlternateSetting;
+	ifnum = hostif->desc.bInterfaceNumber; // FIXME ?
+
+	if (alt != 0 || ifnum != 0) {
+		dev_warn(&udev->dev, "ifnum %d, alt %d\n", ifnum, alt);
+		return -ENODEV;
+	}
+
+	/* Reject application specific intefaces
+	 *
+	 */
+	if (hostif->desc.bInterfaceClass != 255) {
+		dev_info(&udev->dev,
+		"%s: Device matched but iface_desc[%d]->bInterfaceClass==%d!\n",
+			 __func__, ifnum, hostif->desc.bInterfaceClass);
+		return -ENODEV;
+	}
+
+	dev_info(&udev->dev, "%s: Device matched ... !\n", __func__);
+
+	cs = gigaset_getunassignedcs(driver);
+	if (!cs) {
+		dev_warn(&udev->dev, "no free cardstate\n");
+		return -ENODEV;
+	}
+	ucs = cs->hw.usb;
+
+	/* save off device structure ptrs for later use */
+	usb_get_dev(udev);
+	ucs->udev = udev;
+	ucs->interface = interface;
+	cs->dev = &udev->dev;
+
+	endpoint = &hostif->endpoint[0].desc;
+
+	buffer_size = le16_to_cpu(endpoint->wMaxPacketSize);
+	ucs->bulk_out_size = buffer_size;
+	ucs->bulk_out_endpointAddr = endpoint->bEndpointAddress;
+	ucs->bulk_out_buffer = kmalloc(buffer_size, GFP_KERNEL);
+	if (!ucs->bulk_out_buffer) {
+		dev_err(cs->dev, "Couldn't allocate bulk_out_buffer\n");
+		retval = -ENOMEM;
+		goto error;
+	}
+
+	ucs->bulk_out_urb = usb_alloc_urb(0, SLAB_KERNEL);
+	if (!ucs->bulk_out_urb) {
+		dev_err(cs->dev, "Couldn't allocate bulk_out_urb\n");
+		retval = -ENOMEM;
+		goto error;
+	}
+
+	endpoint = &hostif->endpoint[1].desc;
+
+	atomic_set(&ucs->busy, 0);
+
+	ucs->read_urb = usb_alloc_urb(0, SLAB_KERNEL);
+	if (!ucs->read_urb) {
+		dev_err(cs->dev, "No free urbs available\n");
+		retval = -ENOMEM;
+		goto error;
+	}
+	buffer_size = le16_to_cpu(endpoint->wMaxPacketSize);
+	ucs->rcvbuf_size = buffer_size;
+	ucs->int_in_endpointAddr = endpoint->bEndpointAddress;
+	cs->inbuf[0].rcvbuf = kmalloc(buffer_size, GFP_KERNEL);
+	if (!cs->inbuf[0].rcvbuf) {
+		dev_err(cs->dev, "Couldn't allocate rcvbuf\n");
+		retval = -ENOMEM;
+		goto error;
+	}
+	/* Fill the interrupt urb and send it to the core */
+	usb_fill_int_urb(ucs->read_urb, udev,
+			 usb_rcvintpipe(udev,
+					endpoint->bEndpointAddress & 0x0f),
+			 cs->inbuf[0].rcvbuf, buffer_size,
+			 gigaset_read_int_callback,
+			 cs->inbuf + 0, endpoint->bInterval);
+
+	retval = usb_submit_urb(ucs->read_urb, SLAB_KERNEL);
+	if (retval) {
+		dev_err(cs->dev, "Could not submit URB (error %d)\n", -retval);
+		goto error;
+	}
+
+	/* tell common part that the device is ready */
+	if (startmode == SM_LOCKED)
+		atomic_set(&cs->mstate, MS_LOCKED);
+	if (!gigaset_start(cs)) {
+		tasklet_kill(&cs->write_tasklet);
+		retval = -ENODEV; //FIXME
+		goto error;
+	}
+
+	/* save address of controller structure */
+	usb_set_intfdata(interface, cs);
+	return 0;
+
+error:
+	if (ucs->read_urb)
+		usb_kill_urb(ucs->read_urb);
+	kfree(ucs->bulk_out_buffer);
+	if (ucs->bulk_out_urb != NULL)
+		usb_free_urb(ucs->bulk_out_urb);
+	kfree(cs->inbuf[0].rcvbuf);
+	if (ucs->read_urb != NULL)
+		usb_free_urb(ucs->read_urb);
+	ucs->read_urb = ucs->bulk_out_urb = NULL;
+	cs->inbuf[0].rcvbuf = ucs->bulk_out_buffer = NULL;
+	usb_put_dev(ucs->udev);
+	ucs->udev = NULL;
+	ucs->interface = NULL;
+	gigaset_unassign(cs);
+	return retval;
+}
+
+/**
+ *	skel_disconnect
+ */
+static void gigaset_disconnect(struct usb_interface *interface)
+{
+	struct cardstate *cs;
+	struct usb_cardstate *ucs;
+
+	cs = usb_get_intfdata(interface);
+	usb_set_intfdata(interface, NULL);
+
+	ucs = cs->hw.usb;
+	usb_kill_urb(ucs->read_urb);
+
+	gigaset_stop(cs);
+
+	tasklet_kill(&cs->write_tasklet);
+
+	usb_kill_urb(ucs->bulk_out_urb);	/* FIXME: only if active? */
+
+	kfree(ucs->bulk_out_buffer);
+	if (ucs->bulk_out_urb != NULL)
+		usb_free_urb(ucs->bulk_out_urb);
+	kfree(cs->inbuf[0].rcvbuf);
+	if (ucs->read_urb != NULL)
+		usb_free_urb(ucs->read_urb);
+	ucs->read_urb = ucs->bulk_out_urb = NULL;
+	cs->inbuf[0].rcvbuf = ucs->bulk_out_buffer = NULL;
+
+	usb_put_dev(ucs->udev);
+	ucs->interface = NULL;
+	ucs->udev = NULL;
+	cs->dev = NULL;
+	gigaset_unassign(cs);
+}
+
+static struct gigaset_ops ops = {
+	gigaset_write_cmd,
+	gigaset_write_room,
+	gigaset_chars_in_buffer,
+	gigaset_brkchars,
+	gigaset_init_bchannel,
+	gigaset_close_bchannel,
+	gigaset_initbcshw,
+	gigaset_freebcshw,
+	gigaset_reinitbcshw,
+	gigaset_initcshw,
+	gigaset_freecshw,
+	gigaset_set_modem_ctrl,
+	gigaset_baud_rate,
+	gigaset_set_line_ctrl,
+	gigaset_m10x_send_skb,
+	gigaset_m10x_input,
+};
+
+/**
+ *	usb_gigaset_init
+ * This function is called while kernel-module is loaded
+ */
+static int __init usb_gigaset_init(void)
+{
+	int result;
+
+	/* allocate memory for our driver state and intialize it */
+	if ((driver = gigaset_initdriver(GIGASET_MINOR, GIGASET_MINORS,
+				       GIGASET_MODULENAME, GIGASET_DEVNAME,
+				       GIGASET_DEVFSNAME, &ops,
+				       THIS_MODULE)) == NULL)
+		goto error;
+
+	/* allocate memory for our device state and intialize it */
+	cardstate = gigaset_initcs(driver, 1, 1, 0, cidmode, GIGASET_MODULENAME);
+	if (!cardstate)
+		goto error;
+
+	/* register this driver with the USB subsystem */
+	result = usb_register(&gigaset_usb_driver);
+	if (result < 0) {
+		err("usb_gigaset: usb_register failed (error %d)",
+		    -result);
+		goto error;
+	}
+
+	info(DRIVER_AUTHOR);
+	info(DRIVER_DESC);
+	return 0;
+
+error:	if (cardstate)
+		gigaset_freecs(cardstate);
+	cardstate = NULL;
+	if (driver)
+		gigaset_freedriver(driver);
+	driver = NULL;
+	return -1;
+}
+
+
+/**
+ *	usb_gigaset_exit
+ * This function is called while unloading the kernel-module
+ */
+static void __exit usb_gigaset_exit(void)
+{
+	gigaset_blockdriver(driver); /* => probe will fail
+				      * => no gigaset_start any more
+				      */
+
+	gigaset_shutdown(cardstate);
+	/* from now on, no isdn callback should be possible */
+
+	/* deregister this driver with the USB subsystem */
+	usb_deregister(&gigaset_usb_driver);
+	/* this will call the disconnect-callback */
+	/* from now on, no disconnect/probe callback should be running */
+
+	gigaset_freecs(cardstate);
+	cardstate = NULL;
+	gigaset_freedriver(driver);
+	driver = NULL;
+}
+
+
+module_init(usb_gigaset_init);
+module_exit(usb_gigaset_exit);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+
+MODULE_LICENSE("GPL");
--- linux-2.6.16-rc4.orig/drivers/isdn/gigaset/asyncdata.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.16-rc4-mm2/drivers/isdn/gigaset/asyncdata.c	2006-02-24 00:19:28.000000000 +0100
@@ -0,0 +1,600 @@
+/*
+ * Common data handling layer for ser_gigaset and usb_gigaset
+ *
+ * Copyright (c) 2005 by Tilman Schmidt <tilman@imap.cc>,
+ *                       Hansjoerg Lipp <hjlipp@web.de>,
+ *                       Stefan Eilers <Eilers.Stefan@epost.de>.
+ *
+ * =====================================================================
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation; either version 2 of
+ *	the License, or (at your option) any later version.
+ * =====================================================================
+ */
+
+#include "gigaset.h"
+#include <linux/crc-ccitt.h>
+
+//#define GIG_M10x_STUFF_VOICE_DATA
+
+/* check if byte must be stuffed/escaped
+ * I'm not sure which data should be encoded.
+ * Therefore I will go the hard way and decode every value
+ * less than 0x20, the flag sequence and the control escape char.
+ */
+static inline int muststuff(unsigned char c)
+{
+	if (c < PPP_TRANS) return 1;
+	if (c == PPP_FLAG) return 1;
+	if (c == PPP_ESCAPE) return 1;
+	/* other possible candidates: */
+	/* 0x91: XON with parity set */
+	/* 0x93: XOFF with parity set */
+	return 0;
+}
+
+/* == data input =========================================================== */
+
+/* process a block of received bytes in command mode (modem response)
+ * Return value:
+ *	number of processed bytes
+ */
+static inline int cmd_loop(unsigned char c, unsigned char *src, int numbytes,
+			   struct inbuf_t *inbuf)
+{
+	struct cardstate *cs = inbuf->cs;
+	unsigned cbytes      = cs->cbytes;
+	int inputstate = inbuf->inputstate;
+	int startbytes = numbytes;
+
+	for (;;) {
+		cs->respdata[cbytes] = c;
+		if (c == 10 || c == 13) {
+			gig_dbg(DEBUG_TRANSCMD, "%s: End of Command (%d Bytes)",
+				__func__, cbytes);
+			cs->cbytes = cbytes;
+			gigaset_handle_modem_response(cs); /* can change
+							      cs->dle */
+			cbytes = 0;
+
+			if (cs->dle &&
+			    !(inputstate & INS_DLE_command)) {
+				inputstate &= ~INS_command;
+				break;
+			}
+		} else {
+			/* advance in line buffer, checking for overflow */
+			if (cbytes < MAX_RESP_SIZE - 1)
+				cbytes++;
+			else
+				dev_warn(cs->dev, "response too large\n");
+		}
+
+		if (!numbytes)
+			break;
+		c = *src++;
+		--numbytes;
+		if (c == DLE_FLAG &&
+		    (cs->dle || inputstate & INS_DLE_command)) {
+			inputstate |= INS_DLE_char;
+			break;
+		}
+	}
+
+	cs->cbytes = cbytes;
+	inbuf->inputstate = inputstate;
+
+	return startbytes - numbytes;
+}
+
+/* process a block of received bytes in lock mode (tty i/f)
+ * Return value:
+ *	number of processed bytes
+ */
+static inline int lock_loop(unsigned char *src, int numbytes,
+			    struct inbuf_t *inbuf)
+{
+	struct cardstate *cs = inbuf->cs;
+
+	gigaset_dbg_buffer(DEBUG_LOCKCMD, "received response",
+			   numbytes, src, 0);
+	gigaset_if_receive(cs, src, numbytes);
+
+	return numbytes;
+}
+
+/* process a block of received bytes in HDLC data mode
+ * Collect HDLC frames, undoing byte stuffing and watching for DLE escapes.
+ * When a frame is complete, check the FCS and pass valid frames to the LL.
+ * If DLE is encountered, return immediately to let the caller handle it.
+ * Return value:
+ *	number of processed bytes
+ *	numbytes (all bytes processed) on error --FIXME
+ */
+static inline int hdlc_loop(unsigned char c, unsigned char *src, int numbytes,
+			    struct inbuf_t *inbuf)
+{
+	struct cardstate *cs = inbuf->cs;
+	struct bc_state *bcs = inbuf->bcs;
+	int inputstate;
+	__u16 fcs;
+	struct sk_buff *skb;
+	unsigned char error;
+	struct sk_buff *compskb;
+	int startbytes = numbytes;
+	int l;
+
+	IFNULLRETVAL(bcs, numbytes);
+	inputstate = bcs->inputstate;
+	fcs = bcs->fcs;
+	skb = bcs->skb;
+	IFNULLRETVAL(skb, numbytes);
+
+	if (unlikely(inputstate & INS_byte_stuff)) {
+		inputstate &= ~INS_byte_stuff;
+		goto byte_stuff;
+	}
+	for (;;) {
+		if (unlikely(c == PPP_ESCAPE)) {
+			if (unlikely(!numbytes)) {
+				inputstate |= INS_byte_stuff;
+				break;
+			}
+			c = *src++;
+			--numbytes;
+			if (unlikely(c == DLE_FLAG &&
+				     (cs->dle ||
+				      inbuf->inputstate & INS_DLE_command))) {
+				inbuf->inputstate |= INS_DLE_char;
+				inputstate |= INS_byte_stuff;
+				break;
+			}
+byte_stuff:
+			c ^= PPP_TRANS;
+#ifdef CONFIG_GIGASET_DEBUG
+			if (unlikely(!muststuff(c)))
+				gig_dbg(DEBUG_HDLC, "byte stuffed: 0x%02x", c);
+#endif
+		} else if (unlikely(c == PPP_FLAG)) {
+			if (unlikely(inputstate & INS_skip_frame)) {
+				if (!(inputstate & INS_have_data)) { /* 7E 7E */
+#ifdef CONFIG_GIGASET_DEBUG
+					++bcs->emptycount;
+#endif
+				} else
+					gig_dbg(DEBUG_HDLC,
+					    "7e----------------------------");
+
+				/* end of frame */
+				error = 1;
+				gigaset_rcv_error(NULL, cs, bcs);
+			} else if (!(inputstate & INS_have_data)) { /* 7E 7E */
+#ifdef CONFIG_GIGASET_DEBUG
+				++bcs->emptycount;
+#endif
+				break;
+			} else {
+				gig_dbg(DEBUG_HDLC,
+					"7e----------------------------");
+
+				/* end of frame */
+				error = 0;
+
+				if (unlikely(fcs != PPP_GOODFCS)) {
+					dev_err(cs->dev,
+					    "Packet checksum at %lu failed, "
+					    "packet is corrupted (%u bytes)!\n",
+					    bcs->rcvbytes, skb->len);
+					compskb = NULL;
+					gigaset_rcv_error(compskb, cs, bcs);
+					error = 1;
+				} else {
+					if (likely((l = skb->len) > 2)) {
+						skb->tail -= 2;
+						skb->len -= 2;
+					} else {
+						dev_kfree_skb(skb);
+						skb = NULL;
+						inputstate |= INS_skip_frame;
+						if (l == 1) {
+							dev_err(cs->dev,
+						  "invalid packet size (1)!\n");
+							error = 1;
+							gigaset_rcv_error(NULL,
+								cs, bcs);
+						}
+					}
+					if (likely(!(error ||
+						     (inputstate &
+						      INS_skip_frame)))) {
+						gigaset_rcv_skb(skb, cs, bcs);
+					}
+				}
+			}
+
+			if (unlikely(error))
+				if (skb)
+					dev_kfree_skb(skb);
+
+			fcs = PPP_INITFCS;
+			inputstate &= ~(INS_have_data | INS_skip_frame);
+			if (unlikely(bcs->ignore)) {
+				inputstate |= INS_skip_frame;
+				skb = NULL;
+			} else if (likely((skb = dev_alloc_skb(SBUFSIZE + HW_HDR_LEN)) != NULL)) {
+				skb_reserve(skb, HW_HDR_LEN);
+			} else {
+				dev_warn(cs->dev,
+					 "could not allocate new skb\n");
+				inputstate |= INS_skip_frame;
+			}
+
+			break;
+#ifdef CONFIG_GIGASET_DEBUG
+		} else if (unlikely(muststuff(c))) {
+			/* Should not happen. Possible after ZDLE=1<CR><LF>. */
+			gig_dbg(DEBUG_HDLC, "not byte stuffed: 0x%02x", c);
+#endif
+		}
+
+		/* add character */
+
+#ifdef CONFIG_GIGASET_DEBUG
+		if (unlikely(!(inputstate & INS_have_data))) {
+			gig_dbg(DEBUG_HDLC, "7e (%d x) ================",
+				bcs->emptycount);
+			bcs->emptycount = 0;
+		}
+#endif
+
+		inputstate |= INS_have_data;
+
+		if (likely(!(inputstate & INS_skip_frame))) {
+			if (unlikely(skb->len == SBUFSIZE)) {
+				dev_warn(cs->dev, "received packet too long\n");
+				dev_kfree_skb_any(skb);
+				skb = NULL;
+				inputstate |= INS_skip_frame;
+				break;
+			}
+			*gigaset_skb_put_quick(skb, 1) = c;
+			/* *__skb_put (skb, 1) = c; */
+			fcs = crc_ccitt_byte(fcs, c);
+		}
+
+		if (unlikely(!numbytes))
+			break;
+		c = *src++;
+		--numbytes;
+		if (unlikely(c == DLE_FLAG &&
+			     (cs->dle ||
+			      inbuf->inputstate & INS_DLE_command))) {
+			inbuf->inputstate |= INS_DLE_char;
+			break;
+		}
+	}
+	bcs->inputstate = inputstate;
+	bcs->fcs = fcs;
+	bcs->skb = skb;
+	return startbytes - numbytes;
+}
+
+/* process a block of received bytes in transparent data mode
+ * Invert bytes, undoing byte stuffing and watching for DLE escapes.
+ * If DLE is encountered, return immediately to let the caller handle it.
+ * Return value:
+ *	number of processed bytes
+ *	numbytes (all bytes processed) on error --FIXME
+ */
+static inline int iraw_loop(unsigned char c, unsigned char *src, int numbytes,
+			    struct inbuf_t *inbuf)
+{
+	struct cardstate *cs = inbuf->cs;
+	struct bc_state *bcs = inbuf->bcs;
+	int inputstate;
+	struct sk_buff *skb;
+	int startbytes = numbytes;
+
+	IFNULLRETVAL(bcs, numbytes);
+	inputstate = bcs->inputstate;
+	skb = bcs->skb;
+	IFNULLRETVAL(skb, numbytes);
+
+	for (;;) {
+		/* add character */
+		inputstate |= INS_have_data;
+
+		if (likely(!(inputstate & INS_skip_frame))) {
+			if (unlikely(skb->len == SBUFSIZE)) {
+				//FIXME just pass skb up and allocate a new one
+				dev_warn(cs->dev, "received packet too long\n");
+				dev_kfree_skb_any(skb);
+				skb = NULL;
+				inputstate |= INS_skip_frame;
+				break;
+			}
+			*gigaset_skb_put_quick(skb, 1) = gigaset_invtab[c];
+		}
+
+		if (unlikely(!numbytes))
+			break;
+		c = *src++;
+		--numbytes;
+		if (unlikely(c == DLE_FLAG &&
+			     (cs->dle ||
+			      inbuf->inputstate & INS_DLE_command))) {
+			inbuf->inputstate |= INS_DLE_char;
+			break;
+		}
+	}
+
+	/* pass data up */
+	if (likely(inputstate & INS_have_data)) {
+		if (likely(!(inputstate & INS_skip_frame))) {
+			gigaset_rcv_skb(skb, cs, bcs);
+		}
+		inputstate &= ~(INS_have_data | INS_skip_frame);
+		if (unlikely(bcs->ignore)) {
+			inputstate |= INS_skip_frame;
+			skb = NULL;
+		} else if (likely((skb = dev_alloc_skb(SBUFSIZE + HW_HDR_LEN))
+				  != NULL)) {
+			skb_reserve(skb, HW_HDR_LEN);
+		} else {
+			dev_warn(cs->dev, "could not allocate new skb\n");
+			inputstate |= INS_skip_frame;
+		}
+	}
+
+	bcs->inputstate = inputstate;
+	bcs->skb = skb;
+	return startbytes - numbytes;
+}
+
+/* process a block of data received from the device
+ */
+void gigaset_m10x_input(struct inbuf_t *inbuf)
+{
+	struct cardstate *cs;
+	unsigned tail, head, numbytes;
+	unsigned char *src, c;
+	int procbytes;
+
+	head = atomic_read(&inbuf->head);
+	tail = atomic_read(&inbuf->tail);
+	gig_dbg(DEBUG_INTR, "buffer state: %u -> %u", head, tail);
+
+	if (head != tail) {
+		cs = inbuf->cs;
+		src = inbuf->data + head;
+		numbytes = (head > tail ? RBUFSIZE : tail) - head;
+		gig_dbg(DEBUG_INTR, "processing %u bytes", numbytes);
+
+		while (numbytes) {
+			if (atomic_read(&cs->mstate) == MS_LOCKED) {
+				procbytes = lock_loop(src, numbytes, inbuf);
+				src += procbytes;
+				numbytes -= procbytes;
+			} else {
+				c = *src++;
+				--numbytes;
+				if (c == DLE_FLAG && (cs->dle ||
+				    inbuf->inputstate & INS_DLE_command)) {
+					if (!(inbuf->inputstate & INS_DLE_char)) {
+						inbuf->inputstate |= INS_DLE_char;
+						goto nextbyte;
+					}
+					/* <DLE> <DLE> => <DLE> in data stream */
+					inbuf->inputstate &= ~INS_DLE_char;
+				}
+
+				if (!(inbuf->inputstate & INS_DLE_char)) {
+
+					/* FIXME use function pointers?  */
+					if (inbuf->inputstate & INS_command)
+						procbytes = cmd_loop(c, src, numbytes, inbuf);
+					else if (inbuf->bcs->proto2 == ISDN_PROTO_L2_HDLC)
+						procbytes = hdlc_loop(c, src, numbytes, inbuf);
+					else
+						procbytes = iraw_loop(c, src, numbytes, inbuf);
+
+					src += procbytes;
+					numbytes -= procbytes;
+				} else {  /* DLE char */
+					inbuf->inputstate &= ~INS_DLE_char;
+					switch (c) {
+					case 'X': /*begin of command*/
+#ifdef CONFIG_GIGASET_DEBUG
+						if (inbuf->inputstate & INS_command)
+							dev_err(cs->dev,
+					"received <DLE> 'X' in command mode\n");
+#endif
+						inbuf->inputstate |=
+							INS_command | INS_DLE_command;
+						break;
+					case '.': /*end of command*/
+#ifdef CONFIG_GIGASET_DEBUG
+						if (!(inbuf->inputstate & INS_command))
+							dev_err(cs->dev,
+					"received <DLE> '.' in hdlc mode\n");
+#endif
+						inbuf->inputstate &= cs->dle ?
+							~(INS_DLE_command|INS_command)
+							: ~INS_DLE_command;
+						break;
+					//case DLE_FLAG: /*DLE_FLAG in data stream*/ /* schon oben behandelt! */
+					default:
+						dev_err(cs->dev,
+						      "received 0x10 0x%02x!\n",
+							(int) c);
+						/* FIXME: reset driver?? */
+					}
+				}
+			}
+nextbyte:
+			if (!numbytes) {
+				/* end of buffer, check for wrap */
+				if (head > tail) {
+					head = 0;
+					src = inbuf->data;
+					numbytes = tail;
+				} else {
+					head = tail;
+					break;
+				}
+			}
+		}
+
+		gig_dbg(DEBUG_INTR, "setting head to %u", head);
+		atomic_set(&inbuf->head, head);
+	}
+}
+
+
+/* == data output ========================================================== */
+
+/* Encoding of a PPP packet into an octet stuffed HDLC frame
+ * with FCS, opening and closing flags.
+ * parameters:
+ *	skb	skb containing original packet (freed upon return)
+ *	head	number of headroom bytes to allocate in result skb
+ *	tail	number of tailroom bytes to allocate in result skb
+ * Return value:
+ *	pointer to newly allocated skb containing the result frame
+ */
+static struct sk_buff *HDLC_Encode(struct sk_buff *skb, int head, int tail)
+{
+	struct sk_buff *hdlc_skb;
+	__u16 fcs;
+	unsigned char c;
+	unsigned char *cp;
+	int len;
+	unsigned int stuf_cnt;
+
+	stuf_cnt = 0;
+	fcs = PPP_INITFCS;
+	cp = skb->data;
+	len = skb->len;
+	while (len--) {
+		if (muststuff(*cp))
+			stuf_cnt++;
+		fcs = crc_ccitt_byte(fcs, *cp++);
+	}
+	fcs ^= 0xffff;			/* complement */
+
+	/* size of new buffer: original size + number of stuffing bytes
+	 * + 2 bytes FCS + 2 stuffing bytes for FCS (if needed) + 2 flag bytes
+	 */
+	hdlc_skb = dev_alloc_skb(skb->len + stuf_cnt + 6 + tail + head);
+	if (!hdlc_skb) {
+		dev_kfree_skb(skb);
+		return NULL;
+	}
+	skb_reserve(hdlc_skb, head);
+
+	/* Copy acknowledge request into new skb */
+	memcpy(hdlc_skb->head, skb->head, 2);
+
+	/* Add flag sequence in front of everything.. */
+	*(skb_put(hdlc_skb, 1)) = PPP_FLAG;
+
+	/* Perform byte stuffing while copying data. */
+	while (skb->len--) {
+		if (muststuff(*skb->data)) {
+			*(skb_put(hdlc_skb, 1)) = PPP_ESCAPE;
+			*(skb_put(hdlc_skb, 1)) = (*skb->data++) ^ PPP_TRANS;
+		} else
+			*(skb_put(hdlc_skb, 1)) = *skb->data++;
+	}
+
+	/* Finally add FCS (byte stuffed) and flag sequence */
+	c = (fcs & 0x00ff);	/* least significant byte first */
+	if (muststuff(c)) {
+		*(skb_put(hdlc_skb, 1)) = PPP_ESCAPE;
+		c ^= PPP_TRANS;
+	}
+	*(skb_put(hdlc_skb, 1)) = c;
+
+	c = ((fcs >> 8) & 0x00ff);
+	if (muststuff(c)) {
+		*(skb_put(hdlc_skb, 1)) = PPP_ESCAPE;
+		c ^= PPP_TRANS;
+	}
+	*(skb_put(hdlc_skb, 1)) = c;
+
+	*(skb_put(hdlc_skb, 1)) = PPP_FLAG;
+
+	dev_kfree_skb(skb);
+	return hdlc_skb;
+}
+
+/* Encoding of a raw packet into an octet stuffed bit inverted frame
+ * parameters:
+ *	skb	skb containing original packet (freed upon return)
+ *	head	number of headroom bytes to allocate in result skb
+ *	tail	number of tailroom bytes to allocate in result skb
+ * Return value:
+ *	pointer to newly allocated skb containing the result frame
+ */
+static struct sk_buff *iraw_encode(struct sk_buff *skb, int head, int tail)
+{
+	struct sk_buff *iraw_skb;
+	unsigned char c;
+	unsigned char *cp;
+	int len;
+
+	/* worst case: every byte must be stuffed */
+	iraw_skb = dev_alloc_skb(2*skb->len + tail + head);
+	if (!iraw_skb) {
+		dev_kfree_skb(skb);
+		return NULL;
+	}
+	skb_reserve(iraw_skb, head);
+
+	cp = skb->data;
+	len = skb->len;
+	while (len--) {
+		c = gigaset_invtab[*cp++];
+		if (c == DLE_FLAG)
+			*(skb_put(iraw_skb, 1)) = c;
+		*(skb_put(iraw_skb, 1)) = c;
+	}
+	dev_kfree_skb(skb);
+	return iraw_skb;
+}
+
+/* gigaset_send_skb
+ * called by common.c to queue an skb for sending
+ * and start transmission if necessary
+ * parameters:
+ *	B Channel control structure
+ *	skb
+ * Return value:
+ *	number of bytes accepted for sending
+ *	(skb->len if ok, 0 if out of buffer space)
+ *	or error code (< 0, eg. -EINVAL)
+ */
+int gigaset_m10x_send_skb(struct bc_state *bcs, struct sk_buff *skb)
+{
+	unsigned len;
+
+	IFNULLRETVAL(bcs, -EFAULT);
+	IFNULLRETVAL(skb, -EFAULT);
+	len = skb->len;
+
+	if (bcs->proto2 == ISDN_PROTO_L2_HDLC)
+		skb = HDLC_Encode(skb, HW_HDR_LEN, 0);
+	else
+		skb = iraw_encode(skb, HW_HDR_LEN, 0);
+	if (!skb) {
+		dev_err(bcs->cs->dev,
+			"unable to allocate memory for encoding!\n");
+		return -ENOMEM;
+	}
+
+	skb_queue_tail(&bcs->squeue, skb);
+	tasklet_schedule(&bcs->cs->write_tasklet);
+
+	return len;	/* ok so far */
+}
