Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265148AbUBIN10 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 08:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265150AbUBIN10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 08:27:26 -0500
Received: from intra.cyclades.com ([64.186.161.6]:51871 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265148AbUBIN1S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 08:27:18 -0500
Date: Mon, 9 Feb 2004 11:07:51 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix pc300_tty.c -> implement tiocmset/tiocmget (fwd)
Message-ID: <Pine.LNX.4.58L.0402091104520.11921@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

This patch fixes pc300_tty.c, changelog in the message below.

Please apply.

---------- Forwarded message ----------
Date: Sat, 7 Feb 2004 01:42:25 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix pc300_tty.c  -> implement tiocmset/tiocmget


Hi,

PC300 MLPPP support is currently broken in 2.6.x.

To fix that, attached patch implements tiocmset/tiocmget methods on the
pc300_tty.c driver, which is the new method tty drivers are supposed to
use instead ioctl.

This fixes two related issues in the ioctl handler:

- ioctl requesting RTS signal would affect DTR signal
- The RTS signal is now handled.

Bonus: Throw out unused ioctl handler

diff -p -Nur linux-2.6.1.orig/drivers/net/wan/Kconfig linux-2.6.1/drivers/net/wan/Kconfig
--- linux-2.6.1.orig/drivers/net/wan/Kconfig	2004-02-07
00:11:13.663361616 +0000
+++ linux-2.6.1/drivers/net/wan/Kconfig	2004-02-07 00:11:43.230866672 +0000
@@ -382,7 +382,7 @@ config PC300

 config PC300_MLPPP
 	bool "Cyclades-PC300 MLPPP support"
-	depends on PC300 && PPP_MULTILINK && PPP_SYNC_TTY && HDLC_PPP && BROKEN
+	depends on PC300 && PPP_MULTILINK && PPP_SYNC_TTY && HDLC_PPP
 	help
 	  Say 'Y' to this option if you are planning to use Multilink PPP over the
 	  PC300 synchronous communication boards.
diff -p -Nur linux-2.6.1.orig/drivers/net/wan/pc300_tty.c linux-2.6.1/drivers/net/wan/pc300_tty.c
--- linux-2.6.1.orig/drivers/net/wan/pc300_tty.c	2004-02-07 00:08:23.343254208 +0000
+++ linux-2.6.1/drivers/net/wan/pc300_tty.c	2004-02-07 00:09:47.154512960 +0000
@@ -124,16 +124,18 @@ static int cpc_tty_write(struct tty_stru
 				const unsigned char *buf, int count);
 static int cpc_tty_write_room(struct tty_struct *tty);
 static int cpc_tty_chars_in_buffer(struct tty_struct *tty);
-static int cpc_tty_ioctl(struct tty_struct *tty, struct file *file,
-				unsigned int cmd, unsigned long arg);
 static void cpc_tty_flush_buffer(struct tty_struct *tty);
 static void cpc_tty_hangup(struct tty_struct *tty);
 static void cpc_tty_rx_work(void *data);
 static void cpc_tty_tx_work(void *data);
 static int cpc_tty_send_to_card(pc300dev_t *dev,void *buf, int len);
 static void cpc_tty_trace(pc300dev_t *dev, char* buf, int len, char rxtx);
-static void cpc_tty_dtr_off(pc300dev_t *pc300dev);
-static void cpc_tty_dtr_on(pc300dev_t *pc300dev);
+static void cpc_tty_signal_off(pc300dev_t *pc300dev, unsigned char);
+static void cpc_tty_signal_on(pc300dev_t *pc300dev, unsigned char);
+
+int pc300_tiocmset(struct tty_struct *, struct file *,
+			unsigned int, unsigned int);
+int pc300_tiocmget(struct tty_struct *, struct file *);

 /* functions called by PC300 driver */
 void cpc_tty_init(pc300dev_t *dev);
@@ -143,38 +145,38 @@ void cpc_tty_trigger_poll(pc300dev_t *pc
 void cpc_tty_reset_var(void);

 /*
- * PC300 TTY clear DTR signal
+ * PC300 TTY clear "signal"
  */
-static void cpc_tty_dtr_off(pc300dev_t *pc300dev)
+static void cpc_tty_signal_off(pc300dev_t *pc300dev, unsigned char signal)
 {
 	pc300ch_t *pc300chan = (pc300ch_t *)pc300dev->chan;
 	pc300_t *card = (pc300_t *) pc300chan->card;
 	int ch = pc300chan->channel;
 	unsigned long flags;

-	CPC_TTY_DBG("%s-tty: Clear signal DTR\n",
-		((struct net_device*)(pc300dev->hdlc))->name);
+	CPC_TTY_DBG("%s-tty: Clear signal %x\n",
+		((struct net_device*)(pc300dev->hdlc))->name, signal);
 	CPC_TTY_LOCK(card, flags);
 	cpc_writeb(card->hw.scabase + M_REG(CTL,ch),
-		cpc_readb(card->hw.scabase+M_REG(CTL,ch))& CTL_DTR);
+		cpc_readb(card->hw.scabase+M_REG(CTL,ch))& signal);
 	CPC_TTY_UNLOCK(card,flags);
 }

 /*
- * PC300 TTY set DTR signal to ON
+ * PC300 TTY set "signal" to ON
  */
-static void cpc_tty_dtr_on(pc300dev_t *pc300dev)
+static void cpc_tty_signal_on(pc300dev_t *pc300dev, unsigned char signal)
 {
 	pc300ch_t *pc300chan = (pc300ch_t *)pc300dev->chan;
 	pc300_t *card = (pc300_t *) pc300chan->card;
 	int ch = pc300chan->channel;
 	unsigned long flags;

-	CPC_TTY_DBG("%s-tty: Set signal DTR\n",
-		((struct net_device*)(pc300dev->hdlc))->name);
+	CPC_TTY_DBG("%s-tty: Set signal %x\n",
+		((struct net_device*)(pc300dev->hdlc))->name, signal);
 	CPC_TTY_LOCK(card, flags);
 	cpc_writeb(card->hw.scabase + M_REG(CTL,ch),
-		cpc_readb(card->hw.scabase+M_REG(CTL,ch))& ~CTL_DTR);
+		cpc_readb(card->hw.scabase+M_REG(CTL,ch))& ~signal);
 	CPC_TTY_UNLOCK(card,flags);
 }

@@ -229,7 +231,8 @@ void cpc_tty_init(pc300dev_t *pc300dev)
 		serial_drv.write = cpc_tty_write;
 		serial_drv.write_room = cpc_tty_write_room;
 		serial_drv.chars_in_buffer = cpc_tty_chars_in_buffer;
-		serial_drv.ioctl = cpc_tty_ioctl;
+		serial_drv.tiocmset = pc300_tiocmset;
+		serial_drv.tiocmget = pc300_tiocmget;
 		serial_drv.flush_buffer = cpc_tty_flush_buffer;
 		serial_drv.hangup = cpc_tty_hangup;

@@ -270,7 +273,7 @@ void cpc_tty_init(pc300dev_t *pc300dev)
 	memcpy(&cpc_tty->name[aux], "-tty", 5);

 	cpc_open((struct net_device *)pc300dev->hdlc);
-	cpc_tty_dtr_off(pc300dev);
+	cpc_tty_signal_off(pc300dev, CTL_DTR);

 	CPC_TTY_DBG("%s: Initializing TTY Sync Driver, tty major#%d minor#%i\n",
 			cpc_tty->name,CPC_TTY_MAJOR,cpc_tty->tty_minor);
@@ -332,7 +335,7 @@ static int cpc_tty_open(struct tty_struc
 		cpc_tty_area[port].tty = tty;
 		tty->driver_data = &cpc_tty_area[port];

-		cpc_tty_dtr_on(cpc_tty->pc300dev);
+		cpc_tty_signal_on(cpc_tty->pc300dev, CTL_DTR);
 	}

 	cpc_tty->num_open++;
@@ -379,7 +382,7 @@ static void cpc_tty_close(struct tty_str
 		return;
 	}

-	cpc_tty_dtr_off(cpc_tty->pc300dev);
+	cpc_tty_signal_off(cpc_tty->pc300dev, CTL_DTR);

 	CPC_TTY_LOCK(cpc_tty->pc300dev->chan->card, flags);  /* lock irq */
 	cpc_tty->tty = NULL;
@@ -556,18 +559,13 @@ static int cpc_tty_chars_in_buffer(struc
 	return(0);
 }

-/*
- * PC300 TTY IOCTL routine
- *
- * This routine treats TIOCMBIS (set DTR signal) and TIOCMBIC (clear DTR
- * signal)IOCTL commands.
- */
-static int cpc_tty_ioctl(struct tty_struct *tty, struct file *file,
-		unsigned int cmd, unsigned long arg)
-
+int pc300_tiocmset(struct tty_struct *tty, struct file *file,
+			unsigned int set, unsigned int clear)
 {
 	st_cpc_tty_area    *cpc_tty;

+	CPC_TTY_DBG("%s: set:%x clear:%x\n", __FUNCTION__, set, clear);
+
 	if (!tty || !tty->driver_data ) {
 	   	CPC_TTY_DBG("hdlcX-tty: no TTY to chars in buffer\n");
 		return -ENODEV;
@@ -575,26 +573,44 @@ static int cpc_tty_ioctl(struct tty_stru

 	cpc_tty = (st_cpc_tty_area *) tty->driver_data;

-	if ((cpc_tty->tty != tty) ||  (cpc_tty->state != CPC_TTY_ST_OPEN)) {
-		CPC_TTY_DBG("%s: TTY is not opened\n",cpc_tty->name);
-		return -ENODEV;
-	}
+	if (set & TIOCM_RTS)
+		cpc_tty_signal_on(cpc_tty->pc300dev, CTL_RTS);
+	if (set & TIOCM_DTR)
+		cpc_tty_signal_on(cpc_tty->pc300dev, CTL_DTR);
+
+	if (clear & TIOCM_RTS)
+		cpc_tty_signal_off(cpc_tty->pc300dev, CTL_RTS);
+	if (clear & TIOCM_DTR)
+		cpc_tty_signal_off(cpc_tty->pc300dev, CTL_DTR);

-	CPC_TTY_DBG("%s: IOCTL cmd %x\n",cpc_tty->name,cmd);
-
-	switch (cmd) {
-		case TIOCMBIS :    /* set DTR */
-			cpc_tty_dtr_on(cpc_tty->pc300dev);
-			break;
-
-		case TIOCMBIC:     /* clear DTR */
-			cpc_tty_dtr_off(cpc_tty->pc300dev);
-			break;
-		default :
-			return -ENOIOCTLCMD;
-	}
 	return 0;
-}
+}
+
+int pc300_tiocmget(struct tty_struct *tty, struct file *file)
+{
+	unsigned int result;
+	unsigned char status;
+	unsigned long flags;
+	st_cpc_tty_area  *cpc_tty = (st_cpc_tty_area *) tty->driver_data;
+	pc300dev_t *pc300dev = cpc_tty->pc300dev;
+	pc300ch_t *pc300chan = (pc300ch_t *)pc300dev->chan;
+	pc300_t *card = (pc300_t *) pc300chan->card;
+	int ch = pc300chan->channel;
+
+	cpc_tty = (st_cpc_tty_area *) tty->driver_data;
+
+	CPC_TTY_DBG("%s-tty: tiocmget\n",
+		((struct net_device*)(pc300dev->hdlc))->name);
+
+	CPC_TTY_LOCK(card, flags);
+	status = cpc_readb(card->hw.scabase+M_REG(CTL,ch));
+	CPC_TTY_UNLOCK(card,flags);
+
+	result = ((status & CTL_DTR) ? TIOCM_DTR : 0) |
+		 ((status & CTL_RTS) ? TIOCM_RTS : 0);
+
+	return result;
+}

 /*
  * PC300 TTY Flush Buffer routine
@@ -660,7 +676,7 @@ static void cpc_tty_hangup(struct tty_st
 							cpc_tty->name,res);
 		}
 	}
-	cpc_tty_dtr_off(cpc_tty->pc300dev);
+	cpc_tty_signal_off(cpc_tty->pc300dev, CTL_DTR);
 }
