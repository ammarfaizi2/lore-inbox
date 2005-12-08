Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932692AbVLHWgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932692AbVLHWgX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 17:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932691AbVLHWgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 17:36:22 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:20082 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932689AbVLHWgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 17:36:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=daiJO69H9xaEfi38FdaoWfKxohUNe77JlqxoUG46AgwvYkwMgktYS609nAnk8akXuZx3tInvoaxDU62t3s5cRHxT64DavWNmmD3sx8FYLwWgxga2O/vFjLQzgR+xl6rY02sUlIRUrrR64T0U1BMtIFtxc5vD9yZc6Uo7bKw42kc=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Decrease number of pointer derefs in jsm_tty.c
Date: Thu, 8 Dec 2005 23:36:45 +0100
User-Agent: KMail/1.9
Cc: Scott H Kilau <Scott_Kilau@digi.com>,
       Wendy Xiong <wendyx@us.ltcfwd.linux.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200512082336.46198.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a small patch to decrease the number of pointer derefs in
drivers/serial/jsm/jsm_tty.c

Benefits of the patch:
 - Fewer pointer dereferences should make the code slightly faster.
 - Size of generated code is smaller
 - Improved readability

Please consider applying.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/serial/jsm/jsm_tty.c |   29 +++++++++++++++++------------
 1 files changed, 17 insertions(+), 12 deletions(-)

orig:
   text    data     bss     dec     hex filename
   7937      80       0    8017    1f51 drivers/serial/jsm/jsm_tty.o

patched:
   text    data     bss     dec     hex filename
   7874      80       0    7954    1f12 drivers/serial/jsm/jsm_tty.o

--- linux-2.6.15-rc5-git1-orig/drivers/serial/jsm/jsm_tty.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc5-git1/drivers/serial/jsm/jsm_tty.c	2005-12-08 22:45:48.000000000 +0100
@@ -140,12 +140,14 @@ static void jsm_tty_send_xchar(struct ua
 {
 	unsigned long lock_flags;
 	struct jsm_channel *channel = (struct jsm_channel *)port;
+	struct termios *termios;
 
 	spin_lock_irqsave(&port->lock, lock_flags);
-	if (ch == port->info->tty->termios->c_cc[VSTART])
+	termios = port->info->tty->termios;
+	if (ch == termios->c_cc[VSTART])
 		channel->ch_bd->bd_ops->send_start_character(channel);
 
-	if (ch == port->info->tty->termios->c_cc[VSTOP])
+	if (ch == termios->c_cc[VSTOP])
 		channel->ch_bd->bd_ops->send_stop_character(channel);
 	spin_unlock_irqrestore(&port->lock, lock_flags);
 }
@@ -176,6 +178,7 @@ static int jsm_tty_open(struct uart_port
 	struct jsm_board *brd;
 	int rc = 0;
 	struct jsm_channel *channel = (struct jsm_channel *)port;
+	struct termios *termios;
 
 	/* Get board pointer from our array of majors we have allocated */
 	brd = channel->ch_bd;
@@ -237,12 +240,13 @@ static int jsm_tty_open(struct uart_port
 	channel->ch_cached_lsr = 0;
 	channel->ch_stops_sent = 0;
 
-	channel->ch_c_cflag	= port->info->tty->termios->c_cflag;
-	channel->ch_c_iflag	= port->info->tty->termios->c_iflag;
-	channel->ch_c_oflag	= port->info->tty->termios->c_oflag;
-	channel->ch_c_lflag	= port->info->tty->termios->c_lflag;
-	channel->ch_startc = port->info->tty->termios->c_cc[VSTART];
-	channel->ch_stopc = port->info->tty->termios->c_cc[VSTOP];
+	termios = port->info->tty->termios;
+	channel->ch_c_cflag	= termios->c_cflag;
+	channel->ch_c_iflag	= termios->c_iflag;
+	channel->ch_c_oflag	= termios->c_oflag;
+	channel->ch_c_lflag	= termios->c_lflag;
+	channel->ch_startc	= termios->c_cc[VSTART];
+	channel->ch_stopc	= termios->c_cc[VSTOP];
 
 	/* Tell UART to init itself */
 	brd->bd_ops->uart_init(channel);
@@ -863,6 +867,7 @@ static void jsm_carrier(struct jsm_chann
 
 void jsm_check_queue_flow_control(struct jsm_channel *ch)
 {
+	struct board_ops *bd_ops = ch->ch_bd->bd_ops;
 	int qleft = 0;
 
 	/* Store how much space we have left in the queue */
@@ -888,7 +893,7 @@ void jsm_check_queue_flow_control(struct
 		/* HWFLOW */
 		if (ch->ch_c_cflag & CRTSCTS) {
 			if(!(ch->ch_flags & CH_RECEIVER_OFF)) {
-				ch->ch_bd->bd_ops->disable_receiver(ch);
+				bd_ops->disable_receiver(ch);
 				ch->ch_flags |= (CH_RECEIVER_OFF);
 				jsm_printk(READ, INFO, &ch->ch_bd->pci_dev,
 					"Internal queue hit hilevel mark (%d)! Turning off interrupts.\n",
@@ -898,7 +903,7 @@ void jsm_check_queue_flow_control(struct
 		/* SWFLOW */
 		else if (ch->ch_c_iflag & IXOFF) {
 			if (ch->ch_stops_sent <= MAX_STOPS_SENT) {
-				ch->ch_bd->bd_ops->send_stop_character(ch);
+				bd_ops->send_stop_character(ch);
 				ch->ch_stops_sent++;
 				jsm_printk(READ, INFO, &ch->ch_bd->pci_dev,
 					"Sending stop char! Times sent: %x\n", ch->ch_stops_sent);
@@ -925,7 +930,7 @@ void jsm_check_queue_flow_control(struct
 		/* HWFLOW */
 		if (ch->ch_c_cflag & CRTSCTS) {
 			if (ch->ch_flags & CH_RECEIVER_OFF) {
-				ch->ch_bd->bd_ops->enable_receiver(ch);
+				bd_ops->enable_receiver(ch);
 				ch->ch_flags &= ~(CH_RECEIVER_OFF);
 				jsm_printk(READ, INFO, &ch->ch_bd->pci_dev,
 					"Internal queue hit lowlevel mark (%d)! Turning on interrupts.\n",
@@ -935,7 +940,7 @@ void jsm_check_queue_flow_control(struct
 		/* SWFLOW */
 		else if (ch->ch_c_iflag & IXOFF && ch->ch_stops_sent) {
 			ch->ch_stops_sent = 0;
-			ch->ch_bd->bd_ops->send_start_character(ch);
+			bd_ops->send_start_character(ch);
 			jsm_printk(READ, INFO, &ch->ch_bd->pci_dev, "Sending start char!\n");
 		}
 	}



