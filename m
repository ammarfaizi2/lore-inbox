Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbVIMQxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbVIMQxW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbVIMQxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:53:21 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:57224 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S964886AbVIMQxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:53:18 -0400
Date: Tue, 13 Sep 2005 18:52:56 +0200
Message-Id: <200509131652.j8DGquNe022111@localhost.localdomain>
In-reply-to: <200509131649.j8DGnNnw021871@localhost.localdomain>
Subject: [PATCH 2/5] isicom: types
From: Jiri Slaby <jirislaby@gmail.com>
To: akpm@osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 isicom.c |  203 ++++++++++++++++++++++++++++++---------------------------------
 1 files changed, 98 insertions(+), 105 deletions(-)

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
 
@@ -164,7 +161,6 @@ static void isicom_tx(unsigned long _dat
 static void isicom_start(struct tty_struct *tty);
 
 static unsigned char *tmp_buf;
-static DECLARE_MUTEX(tmp_buf_sem);
 
 /*   baud index mappings from linux defns to isi */
 
@@ -173,35 +169,35 @@ static signed char linuxb_to_isib[] = {
 };
 
 struct	isi_board {
-	unsigned short		base;
-	unsigned char		irq;
-	unsigned char		port_count;
-	unsigned short		status;
-	unsigned short		port_status; /* each bit represents a single port */
-	unsigned short		shift_count;
-	struct isi_port		* ports;
-	signed char		count;
-	unsigned char		isa;
+	u16			base;
+	u8			irq;
+	u8			port_count;
+	u16			status;
+	u16			port_status; /* each bit for each port */
+	u16			shift_count;
+	struct isi_port		*ports;
+	s8			count;
+	u8			isa;
 	spinlock_t		card_lock; /* Card wide lock 11/5/00 -sameer */
 	unsigned long		flags;
 };
 
 struct	isi_port {
-	unsigned short		magic;
+	u16			magic;
 	unsigned int		flags;
 	int			count;
 	int			blocked_open;
 	int			close_delay;
-	unsigned short		channel;
-	unsigned short		status;
-	unsigned short		closing_wait;
-	struct isi_board	* card;
-	struct tty_struct 	* tty;
+	u16			channel;
+	u16			status;
+	u16			closing_wait;
+	struct isi_board	*card;
+	struct tty_struct 	*tty;
 	wait_queue_head_t	close_wait;
 	wait_queue_head_t	open_wait;
 	struct work_struct	hangup_tq;
 	struct work_struct	bh_tqueue;
-	unsigned char		* xmit_buf;
+	u8			*xmit_buf;
 	int			xmit_head;
 	int			xmit_tail;
 	int			xmit_cnt;
@@ -219,7 +215,7 @@ static struct isi_port  isi_ports[PORT_C
 static int lock_card(struct isi_board *card)
 {
 	char		retries;
-	unsigned short base = card->base;
+	u16 base = card->base;
 
 	for (retries = 0; retries < 100; retries++) {
 		spin_lock_irqsave(&card->card_lock, card->flags);
@@ -237,7 +233,7 @@ static int lock_card(struct isi_board *c
 static int lock_card_at_interrupt(struct isi_board *card)
 {
 	unsigned char		retries;
-	unsigned short 		base = card->base;
+	u16 		base = card->base;
 
 	for (retries = 0; retries < 200; retries++) {
 		spin_lock_irqsave(&card->card_lock, card->flags);
@@ -263,8 +259,8 @@ static void unlock_card(struct isi_board
 static void raise_dtr(struct isi_port *port)
 {
 	struct isi_board *card = port->card;
-	unsigned short base = card->base;
-	unsigned char channel = port->channel;
+	u16 base = card->base;
+	u8 channel = port->channel;
 
 	if (!lock_card(card))
 		return;
@@ -279,8 +275,8 @@ static void raise_dtr(struct isi_port *p
 static inline void drop_dtr(struct isi_port *port)
 {
 	struct isi_board *card = port->card;
-	unsigned short base = card->base;
-	unsigned char channel = port->channel;
+	u16 base = card->base;
+	u8 channel = port->channel;
 
 	if (!lock_card(card))
 		return;
@@ -295,8 +291,8 @@ static inline void drop_dtr(struct isi_p
 static inline void raise_rts(struct isi_port *port)
 {
 	struct isi_board *card = port->card;
-	unsigned short base = card->base;
-	unsigned char channel = port->channel;
+	u16 base = card->base;
+	u8 channel = port->channel;
 
 	if (!lock_card(card))
 		return;
@@ -310,8 +306,8 @@ static inline void raise_rts(struct isi_
 static inline void drop_rts(struct isi_port *port)
 {
 	struct isi_board *card = port->card;
-	unsigned short base = card->base;
-	unsigned char channel = port->channel;
+	u16 base = card->base;
+	u8 channel = port->channel;
 
 	if (!lock_card(card))
 		return;
@@ -326,8 +322,8 @@ static inline void drop_rts(struct isi_p
 static inline void raise_dtr_rts(struct isi_port *port)
 {
 	struct isi_board *card = port->card;
-	unsigned short base = card->base;
-	unsigned char channel = port->channel;
+	u16 base = card->base;
+	u8 channel = port->channel;
 
 	if (!lock_card(card))
 		return;
@@ -342,8 +338,8 @@ static inline void raise_dtr_rts(struct 
 static void drop_dtr_rts(struct isi_port *port)
 {
 	struct isi_board *card = port->card;
-	unsigned short base = card->base;
-	unsigned char channel = port->channel;
+	u16 base = card->base;
+	u8 channel = port->channel;
 
 	if (!lock_card(card))
 		return;
@@ -358,8 +354,8 @@ static void drop_dtr_rts(struct isi_port
 static inline void kill_queue(struct isi_port *port, short queue)
 {
 	struct isi_board *card = port->card;
-	unsigned short base = card->base;
-	unsigned char channel = port->channel;
+	u16 base = card->base;
+	u8 channel = port->channel;
 
 	if (!lock_card(card))
 		return;
@@ -386,7 +382,7 @@ static struct miscdevice isiloader_devic
 };
 
 
-static inline int WaitTillCardIsFree(unsigned short base)
+static inline int WaitTillCardIsFree(u16 base)
 {
 	unsigned long count=0;
 	while( (!(inw(base+0xe) & 0x1)) && (count++ < 6000000));
@@ -401,20 +397,20 @@ static int ISILoad_ioctl(struct inode *i
 {
 	unsigned int card, i, j, signature, status, portcount = 0;
 	unsigned long t;
-	unsigned short word_count, base;
+	u16 word_count, base;
 	bin_frame frame;
 	void __user *argp = (void __user *)arg;
 	/* exec_record exec_rec; */
 
-	if(get_user(card, (int __user *)argp))
+	if (get_user(card, (int __user *)argp))
 		return -EFAULT;
 
-	if(card < 0 || card >= BOARD_COUNT)
+	if (card < 0 || card >= BOARD_COUNT)
 		return -ENXIO;
 
 	base=isi_card[card].base;
 
-	if(base==0)
+	if (base==0)
 		return -ENXIO;	/* disabled or not used */
 
 	switch(cmd) {
@@ -425,12 +421,12 @@ static int ISILoad_ioctl(struct inode *i
 
 		inw(base+0x8);
 
-		for(t=jiffies+HZ/100;time_before(jiffies, t););
+		for (t=jiffies+HZ/100;time_before(jiffies, t););
 
 		outw(0,base+0x8); /* Reset */
 
-		for(j=1;j<=3;j++) {
-			for(t=jiffies+HZ;time_before(jiffies, t););
+		for (j=1;j<=3;j++) {
+			for (t=jiffies+HZ;time_before(jiffies, t););
 			printk(".");
 		}
 		signature=(inw(base+0x4)) & 0xff;
@@ -486,7 +482,7 @@ static int ISILoad_ioctl(struct inode *i
 			if (!capable(CAP_SYS_ADMIN))
 				return -EPERM;
 
-			if(copy_from_user(&frame, argp, sizeof(bin_frame)))
+			if (copy_from_user(&frame, argp, sizeof(bin_frame)))
 				return -EFAULT;
 
 			if (WaitTillCardIsFree(base))
@@ -500,7 +496,7 @@ static int ISILoad_ioctl(struct inode *i
 			outw(word_count, base);
 			InterruptTheCard(base);
 
-			for(i=0;i<=0x2f;i++);	/* a wee bit of delay */
+			for (i=0;i<=0x2f;i++);	/* a wee bit of delay */
 
 			if (WaitTillCardIsFree(base))
 				return -EIO;
@@ -514,7 +510,7 @@ static int ISILoad_ioctl(struct inode *i
 
 			InterruptTheCard(base);
 
-			for(i=0;i<=0x0f;i++);	/* another wee bit of delay */
+			for (i=0;i<=0x0f;i++);	/* another wee bit of delay */
 
 			if (WaitTillCardIsFree(base))
 				return -EIO;
@@ -529,7 +525,7 @@ static int ISILoad_ioctl(struct inode *i
 			if (!capable(CAP_SYS_ADMIN))
 				return -EPERM;
 
-			if(copy_from_user(&frame, argp, sizeof(bin_header)))
+			if (copy_from_user(&frame, argp, sizeof(bin_header)))
 				return -EFAULT;
 
 			if (WaitTillCardIsFree(base))
@@ -543,7 +539,7 @@ static int ISILoad_ioctl(struct inode *i
 			outw(word_count+1, base);
 			InterruptTheCard(base);
 
-			for(i=0;i<=0xf;i++);	/* a wee bit of delay */
+			for (i=0;i<=0xf;i++);	/* a wee bit of delay */
 
 			if (WaitTillCardIsFree(base))
 				return -EIO;
@@ -558,7 +554,7 @@ static int ISILoad_ioctl(struct inode *i
 			insw(base, frame.bin_data, word_count);
 			InterruptTheCard(base);
 
-			for(i=0;i<=0x0f;i++);	/* another wee bit of delay */
+			for (i=0;i<=0x0f;i++);	/* another wee bit of delay */
 
 			if (WaitTillCardIsFree(base))
 				return -EIO;
@@ -568,7 +564,7 @@ static int ISILoad_ioctl(struct inode *i
 				return -EIO;
 			}
 
-			if(copy_to_user(argp, &frame, sizeof(bin_frame)))
+			if (copy_to_user(argp, &frame, sizeof(bin_frame)))
 				return -EFAULT;
 			return 0;
 
@@ -667,7 +663,7 @@ static void isicom_tx(unsigned long _dat
 		tty = port->tty;
 
 
-		if(tty == NULL) {
+		if (tty == NULL) {
 			unlock_card(&isi_card[card]);
 			continue;
 		}
@@ -762,19 +758,16 @@ static void isicom_bottomhalf(void *data
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
+	u16 base, header, word_count, count;
+	u8 channel;
 	short byte_count;
 	unsigned char *rp;
 
-	card = (struct isi_board *) dev_id;
-
 	if (!card || !(card->status & FIRMWARE_LOADED))
 		return IRQ_NONE;
 
@@ -953,8 +946,8 @@ static void isicom_config_port(struct is
 	struct isi_board *card = port->card;
 	struct tty_struct *tty;
 	unsigned long baud;
-	unsigned short channel_setup, base = card->base;
-	unsigned short channel = port->channel, shift_count = card->shift_count;
+	u16 channel_setup, base = card->base;
+	u16 channel = port->channel, shift_count = card->shift_count;
 	unsigned char flow_ctrl;
 
 	if (!(tty = port->tty) || !tty->termios)
@@ -1071,7 +1064,7 @@ static inline void isicom_setup_board(st
 	port = bp->ports;
 	bp->status |= BOARD_ACTIVE;
 	spin_unlock_irqrestore(&bp->card_lock, flags);
-	for(channel = 0; channel < bp->port_count; channel++, port++)
+	for (channel = 0; channel < bp->port_count; channel++, port++)
 		drop_dtr_rts(port);
 	return;
 }
@@ -1094,7 +1087,7 @@ static int isicom_setup_port(struct isi_
 			free_page(page);
 			return -ERESTARTSYS;
 		}
-		port->xmit_buf = (unsigned char *) page;
+		port->xmit_buf = (u8*) page;
 	}
 
 	spin_lock_irqsave(&card->card_lock, flags);
@@ -1286,7 +1279,7 @@ static void isicom_shutdown_port(struct 
 	}
 
 	/* last port was closed , shutdown that boad too */
-	if(C_HUPCL(tty)) {
+	if (C_HUPCL(tty)) {
 		if (!card->count)
 			isicom_shutdown_board(card);
 	}
@@ -1294,7 +1287,7 @@ static void isicom_shutdown_port(struct 
 
 static void isicom_close(struct tty_struct *tty, struct file *filp)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 	struct isi_board *card = port->card;
 	unsigned long flags;
 
@@ -1373,7 +1366,7 @@ static void isicom_close(struct tty_stru
 static int isicom_write(struct tty_struct *tty,	const unsigned char *buf,
 	int count)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 	struct isi_board *card = port->card;
 	unsigned long flags;
 	int cnt, total = 0;
@@ -1408,7 +1401,7 @@ static int isicom_write(struct tty_struc
 /* put_char et all */
 static void isicom_put_char(struct tty_struct *tty, unsigned char ch)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 	struct isi_board *card = port->card;
 	unsigned long flags;
 
@@ -1433,7 +1426,7 @@ static void isicom_put_char(struct tty_s
 /* flush_chars et all */
 static void isicom_flush_chars(struct tty_struct *tty)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 
 	if (isicom_paranoia_check(port, tty->name, "isicom_flush_chars"))
 		return;
@@ -1449,7 +1442,7 @@ static void isicom_flush_chars(struct tt
 /* write_room et all */
 static int isicom_write_room(struct tty_struct *tty)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 	int free;
 
 	if (isicom_paranoia_check(port, tty->name, "isicom_write_room"))
@@ -1464,7 +1457,7 @@ static int isicom_write_room(struct tty_
 /* chars_in_buffer et all */
 static int isicom_chars_in_buffer(struct tty_struct *tty)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 	if (isicom_paranoia_check(port, tty->name, "isicom_chars_in_buffer"))
 		return 0;
 	return port->xmit_cnt;
@@ -1474,9 +1467,9 @@ static int isicom_chars_in_buffer(struct
 static inline void isicom_send_break(struct isi_port *port, unsigned long length)
 {
 	struct isi_board *card = port->card;
-	unsigned short base = card->base;
+	u16 base = card->base;
 
-	if(!lock_card(card))
+	if (!lock_card(card))
 		return;
 
 	outw(0x8000 | ((port->channel) << (card->shift_count)) | 0x3, base);
@@ -1489,9 +1482,9 @@ static inline void isicom_send_break(str
 
 static int isicom_tiocmget(struct tty_struct *tty, struct file *file)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 	/* just send the port status */
-	unsigned short status = port->status;
+	u16 status = port->status;
 
 	if (isicom_paranoia_check(port, tty->name, "isicom_ioctl"))
 		return -ENODEV;
@@ -1507,7 +1500,7 @@ static int isicom_tiocmget(struct tty_st
 static int isicom_tiocmset(struct tty_struct *tty, struct file *file,
 	unsigned int set, unsigned int clear)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 
 	if (isicom_paranoia_check(port, tty->name, "isicom_ioctl"))
 		return -ENODEV;
@@ -1531,7 +1524,7 @@ static int isicom_set_serial_info(struct
 	struct serial_struct newinfo;
 	int reconfig_port;
 
-	if(copy_from_user(&newinfo, info, sizeof(newinfo)))
+	if (copy_from_user(&newinfo, info, sizeof(newinfo)))
 		return -EFAULT;
 
 	reconfig_port = ((port->flags & ASYNC_SPD_MASK) !=
@@ -1572,7 +1565,7 @@ static int isicom_get_serial_info(struct
 /*	out_info.baud_base = ? */
 	out_info.close_delay = port->close_delay;
 	out_info.closing_wait = port->closing_wait;
-	if(copy_to_user(info, &out_info, sizeof(out_info)))
+	if (copy_to_user(info, &out_info, sizeof(out_info)))
 		return -EFAULT;
 	return 0;
 }
@@ -1580,7 +1573,7 @@ static int isicom_get_serial_info(struct
 static int isicom_ioctl(struct tty_struct *tty, struct file *filp,
 	unsigned int cmd, unsigned long arg)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 	void __user *argp = (void __user *)arg;
 	int retval;
 
@@ -1609,7 +1602,7 @@ static int isicom_ioctl(struct tty_struc
 		return put_user(C_CLOCAL(tty) ? 1 : 0, (unsigned long __user *)argp);
 
 	case TIOCSSOFTCAR:
-		if(get_user(arg, (unsigned long __user *) argp))
+		if (get_user(arg, (unsigned long __user *) argp))
 			return -EFAULT;
 		tty->termios->c_cflag =
 			((tty->termios->c_cflag & ~CLOCAL) |
@@ -1632,7 +1625,7 @@ static int isicom_ioctl(struct tty_struc
 static void isicom_set_termios(struct tty_struct *tty,
 	struct termios *old_termios)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 
 	if (isicom_paranoia_check(port, tty->name, "isicom_set_termios"))
 		return;
@@ -1653,7 +1646,7 @@ static void isicom_set_termios(struct tt
 /* throttle et all */
 static void isicom_throttle(struct tty_struct *tty)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 	struct isi_board *card = port->card;
 
 	if (isicom_paranoia_check(port, tty->name, "isicom_throttle"))
@@ -1667,7 +1660,7 @@ static void isicom_throttle(struct tty_s
 /* unthrottle et all */
 static void isicom_unthrottle(struct tty_struct *tty)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 	struct isi_board *card = port->card;
 
 	if (isicom_paranoia_check(port, tty->name, "isicom_unthrottle"))
@@ -1681,7 +1674,7 @@ static void isicom_unthrottle(struct tty
 /* stop et all */
 static void isicom_stop(struct tty_struct *tty)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 
 	if (isicom_paranoia_check(port, tty->name, "isicom_stop"))
 		return;
@@ -1694,7 +1687,7 @@ static void isicom_stop(struct tty_struc
 /* start et all */
 static void isicom_start(struct tty_struct *tty)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 
 	if (isicom_paranoia_check(port, tty->name, "isicom_start"))
 		return;
@@ -1707,7 +1700,7 @@ static void isicom_start(struct tty_stru
 /* hangup et all */
 static void do_isicom_hangup(void *data)
 {
-	struct isi_port *port = (struct isi_port *) data;
+	struct isi_port *port = data;
 	struct tty_struct *tty;
 
 	tty = port->tty;
@@ -1717,7 +1710,7 @@ static void do_isicom_hangup(void *data)
 
 static void isicom_hangup(struct tty_struct *tty)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 
 	if (isicom_paranoia_check(port, tty->name, "isicom_hangup"))
 		return;
@@ -1732,7 +1725,7 @@ static void isicom_hangup(struct tty_str
 /* flush_buffer et all */
 static void isicom_flush_buffer(struct tty_struct *tty)
 {
-	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = tty->driver_data;
 	struct isi_board *card = port->card;
 	unsigned long flags;
 
@@ -1776,23 +1769,23 @@ static void unregister_ioregion(void)
 }
 
 static struct tty_operations isicom_ops = {
-	.open	= isicom_open,
-	.close	= isicom_close,
-	.write	= isicom_write,
-	.put_char	= isicom_put_char,
-	.flush_chars	= isicom_flush_chars,
-	.write_room	= isicom_write_room,
+	.open			= isicom_open,
+	.close			= isicom_close,
+	.write			= isicom_write,
+	.put_char		= isicom_put_char,
+	.flush_chars		= isicom_flush_chars,
+	.write_room		= isicom_write_room,
 	.chars_in_buffer	= isicom_chars_in_buffer,
-	.ioctl	= isicom_ioctl,
-	.set_termios	= isicom_set_termios,
-	.throttle	= isicom_throttle,
-	.unthrottle	= isicom_unthrottle,
-	.stop	= isicom_stop,
-	.start	= isicom_start,
-	.hangup	= isicom_hangup,
-	.flush_buffer	= isicom_flush_buffer,
-	.tiocmget	= isicom_tiocmget,
-	.tiocmset	= isicom_tiocmset,
+	.ioctl			= isicom_ioctl,
+	.set_termios		= isicom_set_termios,
+	.throttle		= isicom_throttle,
+	.unthrottle		= isicom_unthrottle,
+	.stop			= isicom_stop,
+	.start			= isicom_start,
+	.hangup			= isicom_hangup,
+	.flush_buffer		= isicom_flush_buffer,
+	.tiocmget		= isicom_tiocmget,
+	.tiocmset		= isicom_tiocmset,
 };
 
 static int __devinit register_drivers(void)
@@ -1961,7 +1954,7 @@ static int __devinit isicom_setup(void)
 	unsigned int ioaddr;
 
 	card = 0;
-	for(idx=0; idx < BOARD_COUNT; idx++) {
+	for (idx=0; idx < BOARD_COUNT; idx++) {
 		if (io[idx]) {
 			isi_card[idx].base=io[idx];
 			isi_card[idx].irq=irq[idx];
@@ -2062,7 +2055,7 @@ static void __exit isicom_exit(void)
 	unregister_isr();
 	unregister_drivers();
 	unregister_ioregion();
-	if(tmp_buf)
+	if (tmp_buf)
 		free_page((unsigned long)tmp_buf);
 	if (misc_deregister(&isiloader_device))
 		printk(KERN_ERR "ISICOM: Unable to unregister Firmware Loader driver\n");
