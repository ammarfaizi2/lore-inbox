Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbVJPW1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbVJPW1M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 18:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbVJPW1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 18:27:12 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:45261 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751369AbVJPW1K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 18:27:10 -0400
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Mon, 17 Oct 2005 00:27:05 +0200
In-reply-to: <200100919343.123456789ble@anxur.fi.muni.cz>
Subject: [PATCHv3 3/6] char, isicom: Other little changes
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <20051016222704.2802B22B371@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Other little changes

Move some code from one place to another.
Get rid of ugly ifdefs in code in next p[patches, so here create functions
and macros to enable it.
Rename some functions and align some code to 80 chars.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

---
commit ef27dbef1dcc2b62a72b2c4bbb4e6c7229e48c43
tree c99a5cb69f2eb5fa774297685a1a8defc46885da
parent 0b6e0be0584825fb5c555a14e55b2bb80d0af942
author root <root@bellona.(none)> Sun, 16 Oct 2005 23:00:24 +0200
committer root <root@bellona.(none)> Sun, 16 Oct 2005 23:00:24 +0200

 drivers/char/isicom.c  |  161 ++++++++++++++++++++++++------------------------
 include/linux/isicom.h |    3 -
 2 files changed, 80 insertions(+), 84 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -135,6 +135,17 @@
 
 #include <linux/isicom.h>
 
+#define InterruptTheCard(base) outw(0, (base) + 0xc)
+#define ClearInterrupt(base) inw((base) + 0x0a)
+
+#ifdef DEBUG
+#define pr_dbg(str...) printk(KERN_DEBUG "ISICOM: " str)
+#define isicom_paranoia_check(a, b, c) __isicom_paranoia_check((a), (b), (c))
+#else
+#define pr_dbg(str...) do { } while (0)
+#define isicom_paranoia_check(a, b, c) 0
+#endif
+
 static struct pci_device_id isicom_pci_tbl[] = {
 	{ VENDOR_ID, 0x2028, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ VENDOR_ID, 0x2051, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
@@ -161,7 +172,6 @@ static void isicom_tx(unsigned long _dat
 static void isicom_start(struct tty_struct *tty);
 
 static unsigned char *tmp_buf;
-static DECLARE_MUTEX(tmp_buf_sem);
 
 /*   baud index mappings from linux defns to isi */
 
@@ -599,23 +609,20 @@ static int ISILoad_ioctl(struct inode *i
  *
  */
 
-static inline int isicom_paranoia_check(struct isi_port const *port, char *name,
-	const char *routine)
+static inline int __isicom_paranoia_check(struct isi_port const *port,
+	char *name, const char *routine)
 {
-#ifdef ISICOM_DEBUG
-	static const char *badmagic =
-			KERN_WARNING "ISICOM: Warning: bad isicom magic for dev %s in %s.\n";
-	static const char *badport =
-			KERN_WARNING "ISICOM: Warning: NULL isicom port for dev %s in %s.\n";
 	if (!port) {
-		printk(badport, name, routine);
+		printk(KERN_WARNING "ISICOM: Warning: bad isicom magic for "
+			"dev %s in %s.\n", name, routine);
 		return 1;
 	}
 	if (port->magic != ISICOM_MAGIC) {
-		printk(badmagic, name, routine);
+		printk(KERN_WARNING "ISICOM: Warning: NULL isicom port for "
+			"dev %s in %s.\n", name, routine);
 		return 1;
 	}
-#endif
+
 	return 0;
 }
 
@@ -674,12 +681,10 @@ static void isicom_tx(unsigned long _dat
 			unlock_card(&isi_card[card]);
 			continue;
 		}
-#ifdef ISICOM_DEBUG
-		printk(KERN_DEBUG "ISICOM: txing %d bytes, port%d.\n",
-				txcount, port->channel+1);
-#endif
-		outw((port->channel << isi_card[card].shift_count) | txcount
-					, base);
+		pr_dbg("txing %d bytes, port%d.\n", txcount,
+			port->channel + 1);
+		outw((port->channel << isi_card[card].shift_count) | txcount,
+			base);
 		residue = NO;
 		wrd = 0;
 		while (1) {
@@ -725,8 +730,11 @@ static void isicom_tx(unsigned long _dat
 
 	/*	schedule another tx for hopefully in about 10ms	*/
 sched_again:
-	if (!re_schedule)
-		return;
+	if (!re_schedule) {
+		re_schedule = 2;
+ 		return;
+	}
+
 	init_timer(&tx);
 	tx.expires = jiffies + HZ/100;
 	tx.data = 0;
@@ -830,9 +838,7 @@ static irqreturn_t isicom_interrupt(int 
 				if (port->status & ISI_DCD) {
 					if (!(header & ISI_DCD)) {
 					/* Carrier has been lost  */
-#ifdef ISICOM_DEBUG
-						printk(KERN_DEBUG "ISICOM: interrupt: DCD->low.\n");
-#endif
+						pr_dbg("interrupt: DCD->low.\n");
 						port->status &= ~ISI_DCD;
 						schedule_work(&port->hangup_tq);
 					}
@@ -840,9 +846,7 @@ static irqreturn_t isicom_interrupt(int 
 				else {
 					if (header & ISI_DCD) {
 					/* Carrier has been detected */
-#ifdef ISICOM_DEBUG
-						printk(KERN_DEBUG "ISICOM: interrupt: DCD->high.\n");
-#endif
+						pr_dbg("interrupt: DCD->high.\n");
 						port->status |= ISI_DCD;
 						wake_up_interruptible(&port->open_wait);
 					}
@@ -899,21 +903,18 @@ static irqreturn_t isicom_interrupt(int 
 			break;
 
 		case 2:	/* Statistics		 */
-			printk(KERN_DEBUG "ISICOM: isicom_interrupt: stats!!!.\n");
+			pr_dbg("isicom_interrupt: stats!!!.\n");
 			break;
 
 		default:
-			printk(KERN_WARNING "ISICOM: Intr: Unknown code in status packet.\n");
+			pr_dbg("Intr: Unknown code in status packet.\n");
 			break;
 		}
 	}
 	else {				/* Data   Packet */
 
 		count = tty_prepare_flip_string(tty, &rp, byte_count & ~1);
-#ifdef ISICOM_DEBUG
-		printk(KERN_DEBUG "ISICOM: Intr: Can rx %d of %d bytes.\n",
-					count, byte_count);
-#endif
+		pr_dbg("Intr: Can rx %d of %d bytes.\n", count, byte_count);
 		word_count = count >> 1;
 		insw(base, rp, word_count);
 		byte_count -= (word_count << 1);
@@ -922,8 +923,8 @@ static irqreturn_t isicom_interrupt(int 
 			byte_count -= 2;
 		}
 		if (byte_count > 0) {
-			printk(KERN_DEBUG "ISICOM: Intr(0x%lx:%d): Flip buffer overflow! dropping bytes...\n",
-					base, channel+1);
+			pr_dbg("Intr(0x%lx:%d): Flip buffer overflow! dropping "
+				"bytes...\n", base, channel + 1);
 			while(byte_count > 0) { /* drain out unread xtra data */
 				inw(base);
 				byte_count -= 2;
@@ -1116,9 +1117,7 @@ static int block_til_ready(struct tty_st
 	/* block if port is in the process of being closed */
 
 	if (tty_hung_up_p(filp) || port->flags & ASYNC_CLOSING) {
-#ifdef ISICOM_DEBUG
-		printk(KERN_DEBUG "ISICOM: block_til_ready: close in progress.\n");
-#endif
+		pr_dbg("block_til_ready: close in progress.\n");
 		interruptible_sleep_on(&port->close_wait);
 		if (port->flags & ASYNC_HUP_NOTIFY)
 			return -EAGAIN;
@@ -1129,9 +1128,7 @@ static int block_til_ready(struct tty_st
 	/* if non-blocking mode is set ... */
 
 	if ((filp->f_flags & O_NONBLOCK) || (tty->flags & (1 << TTY_IO_ERROR))) {
-#ifdef ISICOM_DEBUG
-		printk(KERN_DEBUG "ISICOM: block_til_ready: non-block mode.\n");
-#endif
+		pr_dbg("block_til_ready: non-block mode.\n");
 		port->flags |= ASYNC_NORMAL_ACTIVE;
 		return 0;
 	}
@@ -1271,7 +1268,7 @@ static void isicom_shutdown_port(struct 
 		set_bit(TTY_IO_ERROR, &tty->flags);
 
 	if (--card->count < 0) {
-		printk(KERN_DEBUG "ISICOM: isicom_shutdown_port: bad board(0x%lx) count %d.\n",
+		pr_dbg("isicom_shutdown_port: bad board(0x%lx) count %d.\n",
 			card->base, card->count);
 		card->count = 0;
 	}
@@ -1294,9 +1291,7 @@ static void isicom_close(struct tty_stru
 	if (isicom_paranoia_check(port, tty->name, "isicom_close"))
 		return;
 
-#ifdef ISICOM_DEBUG
-	printk(KERN_DEBUG "ISICOM: Close start!!!.\n");
-#endif
+	pr_dbg("Close start!!!.\n");
 
 	spin_lock_irqsave(&card->card_lock, flags);
 	if (tty_hung_up_p(filp)) {
@@ -1347,9 +1342,7 @@ static void isicom_close(struct tty_stru
 	if (port->blocked_open) {
 		spin_unlock_irqrestore(&card->card_lock, flags);
 		if (port->close_delay) {
-#ifdef ISICOM_DEBUG
-			printk(KERN_DEBUG "ISICOM: scheduling until time out.\n");
-#endif
+			pr_dbg("scheduling until time out.\n");
 			msleep_interruptible(jiffies_to_msecs(port->close_delay));
 		}
 		spin_lock_irqsave(&card->card_lock, flags);
@@ -1786,42 +1779,44 @@ static struct tty_operations isicom_ops 
 	.tiocmset		= isicom_tiocmset,
 };
 
-static int __devinit register_drivers(void)
+static int __devinit isicom_register_tty_driver(void)
 {
-	int error;
+	int error = -ENOMEM;
 
 	/* tty driver structure initialization */
 	isicom_normal = alloc_tty_driver(PORT_COUNT);
 	if (!isicom_normal)
-		return -ENOMEM;
+		goto end;
 
-	isicom_normal->owner	= THIS_MODULE;
-	isicom_normal->name 	= "ttyM";
-	isicom_normal->devfs_name = "isicom/";
-	isicom_normal->major	= ISICOM_NMAJOR;
-	isicom_normal->minor_start	= 0;
-	isicom_normal->type	= TTY_DRIVER_TYPE_SERIAL;
-	isicom_normal->subtype	= SERIAL_TYPE_NORMAL;
-	isicom_normal->init_termios	= tty_std_termios;
-	isicom_normal->init_termios.c_cflag	=
-				B9600 | CS8 | CREAD | HUPCL |CLOCAL;
-	isicom_normal->flags	= TTY_DRIVER_REAL_RAW;
+	isicom_normal->owner			= THIS_MODULE;
+	isicom_normal->name 			= "ttyM";
+	isicom_normal->devfs_name	 	= "isicom/";
+	isicom_normal->major			= ISICOM_NMAJOR;
+	isicom_normal->minor_start		= 0;
+	isicom_normal->type			= TTY_DRIVER_TYPE_SERIAL;
+	isicom_normal->subtype			= SERIAL_TYPE_NORMAL;
+	isicom_normal->init_termios		= tty_std_termios;
+	isicom_normal->init_termios.c_cflag	= B9600 | CS8 | CREAD | HUPCL |
+		CLOCAL;
+	isicom_normal->flags			= TTY_DRIVER_REAL_RAW;
 	tty_set_operations(isicom_normal, &isicom_ops);
 
-	if ((error=tty_register_driver(isicom_normal))!=0) {
-		printk(KERN_DEBUG "ISICOM: Couldn't register the dialin driver, error=%d\n",
+	if ((error = tty_register_driver(isicom_normal))) {
+		pr_dbg("Couldn't register the dialin driver, error=%d\n",
 			error);
 		put_tty_driver(isicom_normal);
-		return error;
 	}
-	return 0;
+end:
+	return error;
 }
 
-static void unregister_drivers(void)
+static void isicom_unregister_tty_driver(void)
 {
-	int error = tty_unregister_driver(isicom_normal);
-	if (error)
-		printk(KERN_DEBUG "ISICOM: couldn't unregister normal driver error=%d.\n",error);
+	int error;
+
+	if ((error = tty_unregister_driver(isicom_normal)))
+		pr_dbg("couldn't unregister normal driver, error=%d.\n", error);
+
 	put_tty_driver(isicom_normal);
 }
 
@@ -1891,7 +1886,7 @@ static int __devinit isicom_init(void)
 		free_page((unsigned long)tmp_buf);
 		return 0;
 	}
-	if (register_drivers())
+	if (isicom_register_tty_driver())
 	{
 		unregister_ioregion();
 		free_page((unsigned long)tmp_buf);
@@ -1899,7 +1894,7 @@ static int __devinit isicom_init(void)
 	}
 	if (!register_isr())
 	{
-		unregister_drivers();
+		isicom_unregister_tty_driver();
 		/*  ioports already uregistered in register_isr */
 		free_page((unsigned long)tmp_buf);
 		return 0;
@@ -1936,14 +1931,6 @@ static int __devinit isicom_init(void)
 static int io[4];
 static int irq[4];
 
-MODULE_AUTHOR("MultiTech");
-MODULE_DESCRIPTION("Driver for the ISI series of cards by MultiTech");
-MODULE_LICENSE("GPL");
-module_param_array(io, int, NULL, 0);
-MODULE_PARM_DESC(io, "I/O ports for the cards");
-module_param_array(irq, int, NULL, 0);
-MODULE_PARM_DESC(irq, "Interrupts for the cards");
-
 static int __devinit isicom_setup(void)
 {
 	struct pci_dev *dev = NULL;
@@ -2047,11 +2034,15 @@ static int __devinit isicom_setup(void)
 
 static void __exit isicom_exit(void)
 {
+	unsigned int index = 0;
+
 	re_schedule = 0;
-	/* FIXME */
-	msleep(1000);
+
+	while (re_schedule != 2 && index++ < 100)
+		msleep(10);
+
 	unregister_isr();
-	unregister_drivers();
+	isicom_unregister_tty_driver();
 	unregister_ioregion();
 	if (tmp_buf)
 		free_page((unsigned long)tmp_buf);
@@ -2061,3 +2052,11 @@ static void __exit isicom_exit(void)
 
 module_init(isicom_setup);
 module_exit(isicom_exit);
+
+MODULE_AUTHOR("MultiTech");
+MODULE_DESCRIPTION("Driver for the ISI series of cards by MultiTech");
+MODULE_LICENSE("GPL");
+module_param_array(io, int, NULL, 0);
+MODULE_PARM_DESC(io, "I/O ports for the cards");
+module_param_array(irq, int, NULL, 0);
+MODULE_PARM_DESC(irq, "Interrupts for the cards");
diff --git a/include/linux/isicom.h b/include/linux/isicom.h
--- a/include/linux/isicom.h
+++ b/include/linux/isicom.h
@@ -98,9 +98,6 @@ typedef	struct	{
 #define		ISICOM_INITIATE_XONXOFF	0x04
 #define		ISICOM_RESPOND_XONXOFF	0x08
 
-#define InterruptTheCard(base) (outw(0,(base)+0xc)) 
-#define ClearInterrupt(base) (inw((base)+0x0a))	
-
 #define	BOARD(line)  (((line) >> 4) & 0x3)
 
 	/*	isi kill queue bitmap	*/
