Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbVJPW1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbVJPW1E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 18:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbVJPW1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 18:27:01 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:18893 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751121AbVJPW1B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 18:27:01 -0400
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Mon, 17 Oct 2005 00:26:55 +0200
In-reply-to: <200100919343.123456789ble@anxur.fi.muni.cz>
Subject: [PATCHv3 2/6] char, isicom: Type conversion and variables deletion
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <20051016222654.22AE222B371@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Type conversion and variables deletion

Type which is needed to have accurate size was converted to [us]{8,16}.
Removed void * cast.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

---
commit 0b6e0be0584825fb5c555a14e55b2bb80d0af942
tree 02b8c6d054a5cb3965f6447237665faca1963835
parent 9dcaeed8e21f210c0d8aeba3cd94695fe6829e0e
author root <root@bellona.(none)> Sat, 15 Oct 2005 01:42:21 +0200
committer root <root@bellona.(none)> Sat, 15 Oct 2005 01:42:21 +0200

 drivers/char/isicom.c |  131 +++++++++++++++++++++++--------------------------
 1 files changed, 61 insertions(+), 70 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -154,9 +154,6 @@ static struct tty_driver *isicom_normal;
 
 static struct timer_list tx;
 static char re_schedule = 1;
-#ifdef ISICOM_DEBUG
-static unsigned long tx_count = 0;
-#endif
 
 static int ISILoad_ioctl(struct inode *inode, struct file *filp, unsigned  int cmd, unsigned long arg);
 
@@ -173,7 +170,7 @@ static signed char linuxb_to_isib[] = {
 };
 
 struct	isi_board {
-	unsigned short		base;
+	unsigned long		base;
 	unsigned char		irq;
 	unsigned char		port_count;
 	unsigned short		status;
@@ -192,9 +189,9 @@ struct	isi_port {
 	int			count;
 	int			blocked_open;
 	int			close_delay;
-	unsigned short		channel;
-	unsigned short		status;
-	unsigned short		closing_wait;
+	u16			channel;
+	u16			status;
+	u16			closing_wait;
 	struct isi_board	* card;
 	struct tty_struct 	* tty;
 	wait_queue_head_t	close_wait;
@@ -219,7 +216,7 @@ static struct isi_port  isi_ports[PORT_C
 static int lock_card(struct isi_board *card)
 {
 	char		retries;
-	unsigned short base = card->base;
+	unsigned long base = card->base;
 
 	for (retries = 0; retries < 100; retries++) {
 		spin_lock_irqsave(&card->card_lock, card->flags);
@@ -230,14 +227,14 @@ static int lock_card(struct isi_board *c
 			udelay(1000);   /* 1ms */
 		}
 	}
-	printk(KERN_WARNING "ISICOM: Failed to lock Card (0x%x)\n", card->base);
+	printk(KERN_WARNING "ISICOM: Failed to lock Card (0x%lx)\n", card->base);
 	return 0;	/* Failed to aquire the card! */
 }
 
 static int lock_card_at_interrupt(struct isi_board *card)
 {
 	unsigned char		retries;
-	unsigned short 		base = card->base;
+	unsigned long base = card->base;
 
 	for (retries = 0; retries < 200; retries++) {
 		spin_lock_irqsave(&card->card_lock, card->flags);
@@ -263,8 +260,8 @@ static void unlock_card(struct isi_board
 static void raise_dtr(struct isi_port *port)
 {
 	struct isi_board *card = port->card;
-	unsigned short base = card->base;
-	unsigned char channel = port->channel;
+	unsigned long base = card->base;
+	u16 channel = port->channel;
 
 	if (!lock_card(card))
 		return;
@@ -279,8 +276,8 @@ static void raise_dtr(struct isi_port *p
 static inline void drop_dtr(struct isi_port *port)
 {
 	struct isi_board *card = port->card;
-	unsigned short base = card->base;
-	unsigned char channel = port->channel;
+	unsigned long base = card->base;
+	u16 channel = port->channel;
 
 	if (!lock_card(card))
 		return;
@@ -295,8 +292,8 @@ static inline void drop_dtr(struct isi_p
 static inline void raise_rts(struct isi_port *port)
 {
 	struct isi_board *card = port->card;
-	unsigned short base = card->base;
-	unsigned char channel = port->channel;
+	unsigned long base = card->base;
+	u16 channel = port->channel;
 
 	if (!lock_card(card))
 		return;
@@ -310,8 +307,8 @@ static inline void raise_rts(struct isi_
 static inline void drop_rts(struct isi_port *port)
 {
 	struct isi_board *card = port->card;
-	unsigned short base = card->base;
-	unsigned char channel = port->channel;
+	unsigned long base = card->base;
+	u16 channel = port->channel;
 
 	if (!lock_card(card))
 		return;
@@ -326,8 +323,8 @@ static inline void drop_rts(struct isi_p
 static inline void raise_dtr_rts(struct isi_port *port)
 {
 	struct isi_board *card = port->card;
-	unsigned short base = card->base;
-	unsigned char channel = port->channel;
+	unsigned long base = card->base;
+	u16 channel = port->channel;
 
 	if (!lock_card(card))
 		return;
@@ -342,8 +339,8 @@ static inline void raise_dtr_rts(struct 
 static void drop_dtr_rts(struct isi_port *port)
 {
 	struct isi_board *card = port->card;
-	unsigned short base = card->base;
-	unsigned char channel = port->channel;
+	unsigned long base = card->base;
+	u16 channel = port->channel;
 
 	if (!lock_card(card))
 		return;
@@ -358,8 +355,8 @@ static void drop_dtr_rts(struct isi_port
 static inline void kill_queue(struct isi_port *port, short queue)
 {
 	struct isi_board *card = port->card;
-	unsigned short base = card->base;
-	unsigned char channel = port->channel;
+	unsigned long base = card->base;
+	u16 channel = port->channel;
 
 	if (!lock_card(card))
 		return;
@@ -386,7 +383,7 @@ static struct miscdevice isiloader_devic
 };
 
 
-static inline int WaitTillCardIsFree(unsigned short base)
+static inline int WaitTillCardIsFree(unsigned long base)
 {
 	unsigned long count=0;
 	while( (!(inw(base+0xe) & 0x1)) && (count++ < 6000000));
@@ -400,8 +397,8 @@ static int ISILoad_ioctl(struct inode *i
 	unsigned int cmd, unsigned long arg)
 {
 	unsigned int card, i, j, signature, status, portcount = 0;
-	unsigned long t;
-	unsigned short word_count, base;
+	unsigned long t, base;
+	u16 word_count;
 	bin_frame frame;
 	void __user *argp = (void __user *)arg;
 	/* exec_record exec_rec; */
@@ -421,7 +418,7 @@ static int ISILoad_ioctl(struct inode *i
 	case MIOCTL_RESET_CARD:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		printk(KERN_DEBUG "ISILoad:Resetting Card%d at 0x%x ",card+1,base);
+		printk(KERN_DEBUG "ISILoad:Resetting Card%d at 0x%lx ",card+1,base);
 
 		inw(base+0x8);
 
@@ -440,7 +437,7 @@ static int ISILoad_ioctl(struct inode *i
 #ifdef ISICOM_DEBUG
 				printk("\nbase+0x2=0x%x , base+0xe=0x%x",inw(base+0x2),inw(base+0xe));
 #endif
-				printk("\nISILoad:ISA Card%d reset failure (Possible bad I/O Port Address 0x%x).\n",card+1,base);
+				printk("\nISILoad:ISA Card%d reset failure (Possible bad I/O Port Address 0x%lx).\n",card+1,base);
 				return -EIO;
 			}
 		}
@@ -450,7 +447,7 @@ static int ISILoad_ioctl(struct inode *i
 #ifdef ISICOM_DEBUG
 				printk("\nbase+0x2=0x%x , base+0xe=0x%x",inw(base+0x2),inw(base+0xe));
 #endif
-				printk("\nISILoad:PCI Card%d reset failure (Possible bad I/O Port Address 0x%x).\n",card+1,base);
+				printk("\nISILoad:PCI Card%d reset failure (Possible bad I/O Port Address 0x%lx).\n",card+1,base);
 				return -EIO;
 			}
 		}
@@ -473,7 +470,7 @@ static int ISILoad_ioctl(struct inode *i
 				isi_card[card].shift_count = 11;
 				break;
 
-		default: printk("ISILoad:Card%d reset failure (Possible bad I/O Port Address 0x%x).\n",card+1,base);
+		default: printk("ISILoad:Card%d reset failure (Possible bad I/O Port Address 0x%lx).\n",card+1,base);
 #ifdef ISICOM_DEBUG
 			printk("Sig=0x%x\n",signature);
 #endif
@@ -636,10 +633,6 @@ static void isicom_tx(unsigned long _dat
 	struct isi_port *port;
 	struct tty_struct *tty;
 
-#ifdef ISICOM_DEBUG
-	++tx_count;
-#endif
-
 	/*	find next active board	*/
 	card = (prev_card + 1) & 0x0003;
 	while(count-- > 0) {
@@ -762,19 +755,16 @@ static void isicom_bottomhalf(void *data
  *	Main interrupt handler routine
  */
 
-static irqreturn_t isicom_interrupt(int irq, void *dev_id,
-					struct pt_regs *regs)
+static irqreturn_t isicom_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	struct isi_board *card;
+	struct isi_board *card = dev_id;
 	struct isi_port *port;
 	struct tty_struct *tty;
-	unsigned short base, header, word_count, count;
-	unsigned char channel;
+	unsigned long base;
+	u16 header, word_count, count, channel;
 	short byte_count;
 	unsigned char *rp;
 
-	card = (struct isi_board *) dev_id;
-
 	if (!card || !(card->status & FIRMWARE_LOADED))
 		return IRQ_NONE;
 
@@ -796,7 +786,7 @@ static irqreturn_t isicom_interrupt(int 
 	byte_count = header & 0xff;
 
 	if (channel + 1 > card->port_count) {
-		printk(KERN_WARNING "ISICOM: isicom_interrupt(0x%x): %d(channel) > port_count.\n",
+		printk(KERN_WARNING "ISICOM: isicom_interrupt(0x%lx): %d(channel) > port_count.\n",
 				base, channel+1);
 		if (card->isa)
 			ClearInterrupt(base);
@@ -932,7 +922,7 @@ static irqreturn_t isicom_interrupt(int 
 			byte_count -= 2;
 		}
 		if (byte_count > 0) {
-			printk(KERN_DEBUG "ISICOM: Intr(0x%x:%d): Flip buffer overflow! dropping bytes...\n",
+			printk(KERN_DEBUG "ISICOM: Intr(0x%lx:%d): Flip buffer overflow! dropping bytes...\n",
 					base, channel+1);
 			while(byte_count > 0) { /* drain out unread xtra data */
 				inw(base);
@@ -953,8 +943,9 @@ static void isicom_config_port(struct is
 	struct isi_board *card = port->card;
 	struct tty_struct *tty;
 	unsigned long baud;
-	unsigned short channel_setup, base = card->base;
-	unsigned short channel = port->channel, shift_count = card->shift_count;
+	unsigned long base = card->base;
+	u16 channel_setup, channel = port->channel,
+		shift_count = card->shift_count;
 	unsigned char flow_ctrl;
 
 	if (!(tty = port->tty) || !tty->termios)
@@ -1280,7 +1271,7 @@ static void isicom_shutdown_port(struct 
 		set_bit(TTY_IO_ERROR, &tty->flags);
 
 	if (--card->count < 0) {
-		printk(KERN_DEBUG "ISICOM: isicom_shutdown_port: bad board(0x%x) count %d.\n",
+		printk(KERN_DEBUG "ISICOM: isicom_shutdown_port: bad board(0x%lx) count %d.\n",
 			card->base, card->count);
 		card->count = 0;
 	}
@@ -1294,7 +1285,7 @@ static void isicom_shutdown_port(struct 
 
 static void isicom_close(struct tty_struct *tty, struct file *filp)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 	struct isi_board *card = port->card;
 	unsigned long flags;
 
@@ -1314,13 +1305,13 @@ static void isicom_close(struct tty_stru
 	}
 
 	if (tty->count == 1 && port->count != 1) {
-		printk(KERN_WARNING "ISICOM:(0x%x) isicom_close: bad port count"
+		printk(KERN_WARNING "ISICOM:(0x%lx) isicom_close: bad port count"
 			"tty->count = 1	port count = %d.\n",
 			card->base, port->count);
 		port->count = 1;
 	}
 	if (--port->count < 0) {
-		printk(KERN_WARNING "ISICOM:(0x%x) isicom_close: bad port count for"
+		printk(KERN_WARNING "ISICOM:(0x%lx) isicom_close: bad port count for"
 			"channel%d = %d", card->base, port->channel,
 			port->count);
 		port->count = 0;
@@ -1373,7 +1364,7 @@ static void isicom_close(struct tty_stru
 static int isicom_write(struct tty_struct *tty,	const unsigned char *buf,
 	int count)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 	struct isi_board *card = port->card;
 	unsigned long flags;
 	int cnt, total = 0;
@@ -1408,7 +1399,7 @@ static int isicom_write(struct tty_struc
 /* put_char et all */
 static void isicom_put_char(struct tty_struct *tty, unsigned char ch)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 	struct isi_board *card = port->card;
 	unsigned long flags;
 
@@ -1433,7 +1424,7 @@ static void isicom_put_char(struct tty_s
 /* flush_chars et all */
 static void isicom_flush_chars(struct tty_struct *tty)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 
 	if (isicom_paranoia_check(port, tty->name, "isicom_flush_chars"))
 		return;
@@ -1449,7 +1440,7 @@ static void isicom_flush_chars(struct tt
 /* write_room et all */
 static int isicom_write_room(struct tty_struct *tty)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 	int free;
 
 	if (isicom_paranoia_check(port, tty->name, "isicom_write_room"))
@@ -1464,7 +1455,7 @@ static int isicom_write_room(struct tty_
 /* chars_in_buffer et all */
 static int isicom_chars_in_buffer(struct tty_struct *tty)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 	if (isicom_paranoia_check(port, tty->name, "isicom_chars_in_buffer"))
 		return 0;
 	return port->xmit_cnt;
@@ -1474,7 +1465,7 @@ static int isicom_chars_in_buffer(struct
 static inline void isicom_send_break(struct isi_port *port, unsigned long length)
 {
 	struct isi_board *card = port->card;
-	unsigned short base = card->base;
+	unsigned long base = card->base;
 
 	if (!lock_card(card))
 		return;
@@ -1489,9 +1480,9 @@ static inline void isicom_send_break(str
 
 static int isicom_tiocmget(struct tty_struct *tty, struct file *file)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 	/* just send the port status */
-	unsigned short status = port->status;
+	u16 status = port->status;
 
 	if (isicom_paranoia_check(port, tty->name, "isicom_ioctl"))
 		return -ENODEV;
@@ -1507,7 +1498,7 @@ static int isicom_tiocmget(struct tty_st
 static int isicom_tiocmset(struct tty_struct *tty, struct file *file,
 	unsigned int set, unsigned int clear)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 
 	if (isicom_paranoia_check(port, tty->name, "isicom_ioctl"))
 		return -ENODEV;
@@ -1580,7 +1571,7 @@ static int isicom_get_serial_info(struct
 static int isicom_ioctl(struct tty_struct *tty, struct file *filp,
 	unsigned int cmd, unsigned long arg)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 	void __user *argp = (void __user *)arg;
 	int retval;
 
@@ -1632,7 +1623,7 @@ static int isicom_ioctl(struct tty_struc
 static void isicom_set_termios(struct tty_struct *tty,
 	struct termios *old_termios)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 
 	if (isicom_paranoia_check(port, tty->name, "isicom_set_termios"))
 		return;
@@ -1653,7 +1644,7 @@ static void isicom_set_termios(struct tt
 /* throttle et all */
 static void isicom_throttle(struct tty_struct *tty)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 	struct isi_board *card = port->card;
 
 	if (isicom_paranoia_check(port, tty->name, "isicom_throttle"))
@@ -1667,7 +1658,7 @@ static void isicom_throttle(struct tty_s
 /* unthrottle et all */
 static void isicom_unthrottle(struct tty_struct *tty)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 	struct isi_board *card = port->card;
 
 	if (isicom_paranoia_check(port, tty->name, "isicom_unthrottle"))
@@ -1681,7 +1672,7 @@ static void isicom_unthrottle(struct tty
 /* stop et all */
 static void isicom_stop(struct tty_struct *tty)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 
 	if (isicom_paranoia_check(port, tty->name, "isicom_stop"))
 		return;
@@ -1694,7 +1685,7 @@ static void isicom_stop(struct tty_struc
 /* start et all */
 static void isicom_start(struct tty_struct *tty)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 
 	if (isicom_paranoia_check(port, tty->name, "isicom_start"))
 		return;
@@ -1707,7 +1698,7 @@ static void isicom_start(struct tty_stru
 /* hangup et all */
 static void do_isicom_hangup(void *data)
 {
-	struct isi_port *port = (struct isi_port *) data;
+	struct isi_port *port = data;
 	struct tty_struct *tty;
 
 	tty = port->tty;
@@ -1717,7 +1708,7 @@ static void do_isicom_hangup(void *data)
 
 static void isicom_hangup(struct tty_struct *tty)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 
 	if (isicom_paranoia_check(port, tty->name, "isicom_hangup"))
 		return;
@@ -1732,7 +1723,7 @@ static void isicom_hangup(struct tty_str
 /* flush_buffer et all */
 static void isicom_flush_buffer(struct tty_struct *tty)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 	struct isi_board *card = port->card;
 	unsigned long flags;
 
@@ -1754,7 +1745,7 @@ static int __devinit register_ioregion(v
 	for (count=0; count < BOARD_COUNT; count++ ) {
 		if (isi_card[count].base)
 			if (!request_region(isi_card[count].base,16,ISICOM_NAME)) {
-				printk(KERN_DEBUG "ISICOM: I/O Region 0x%x-0x%x is busy. Card%d will be disabled.\n",
+				printk(KERN_DEBUG "ISICOM: I/O Region 0x%lx-0x%lx is busy. Card%d will be disabled.\n",
 					isi_card[count].base,isi_card[count].base+15,count+1);
 				isi_card[count].base=0;
 				done++;
@@ -1770,7 +1761,7 @@ static void unregister_ioregion(void)
 		if (isi_card[count].base) {
 			release_region(isi_card[count].base,16);
 #ifdef ISICOM_DEBUG
-			printk(KERN_DEBUG "ISICOM: I/O Region 0x%x-0x%x released for Card%d.\n",isi_card[count].base,isi_card[count].base+15,count+1);
+			printk(KERN_DEBUG "ISICOM: I/O Region 0x%lx-0x%lx released for Card%d.\n",isi_card[count].base,isi_card[count].base+15,count+1);
 #endif
 		}
 }
