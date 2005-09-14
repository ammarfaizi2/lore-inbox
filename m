Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbVINAM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbVINAM5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 20:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVINAM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 20:12:56 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:18055 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1751216AbVINAMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 20:12:55 -0400
Date: Wed, 14 Sep 2005 02:12:50 +0200
Message-Id: <200509140012.j8E0Cobd029162@localhost.localdomain>
In-reply-to: <200509140010.j8E0AQml029046@localhost.localdomain>
Subject: [PATCH 3/6] isicom: Others little changes
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Generated in 2.6.13-mm3 kernel version

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

Others little changes

Move some code from one place to another.
Get rid of ugly ifdefs in code in next p[patches, so here create functions
and macros to enable it.
Rename some functions and align some code to 80 chars.

---
 drivers/char/isicom.c  |  128 ++++++++++++++++++++++++++----------------------
 include/linux/isicom.h |    3 -
 2 files changed, 70 insertions(+), 61 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -135,6 +135,17 @@
 
 #include <linux/isicom.h>
 
+#define InterruptTheCard(base) outw(0, (base) + 0xc)
+#define ClearInterrupt(base) inw((base) + 0x0a)
+
+#ifdef ISICOM_DEBUG
+#define pr_deb(str, ...) printk((str), ##args);
+#define isicom_paranoia_check(a, b, c) __isicom_paranoia_check((a), (b), (c))
+#else
+#define pr_deb(str, ...)
+#define isicom_paranoia_check(a, b, c) 0
+#endif
+
 static struct pci_device_id isicom_pci_tbl[] = {
 	{ VENDOR_ID, 0x2028, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ VENDOR_ID, 0x2051, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
@@ -598,23 +609,20 @@ static int ISILoad_ioctl(struct inode *i
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
 
@@ -632,10 +640,6 @@ static void isicom_tx(unsigned long _dat
 	struct isi_port *port;
 	struct tty_struct *tty;
 
-#ifdef ISICOM_DEBUG
-	++tx_count;
-#endif
-
 	/*	find next active board	*/
 	card = (prev_card + 1) & 0x0003;
 	while(count-- > 0) {
@@ -677,12 +681,10 @@ static void isicom_tx(unsigned long _dat
 			unlock_card(&isi_card[card]);
 			continue;
 		}
-#ifdef ISICOM_DEBUG
-		printk(KERN_DEBUG "ISICOM: txing %d bytes, port%d.\n",
-				txcount, port->channel+1);
-#endif
-		outw((port->channel << isi_card[card].shift_count) | txcount
-					, base);
+		pr_deb(KERN_DEBUG "ISICOM: txing %d bytes, port%d.\n",
+			txcount, port->channel + 1);
+		outw((port->channel << isi_card[card].shift_count) | txcount,
+			base);
 		residue = NO;
 		wrd = 0;
 		while (1) {
@@ -728,8 +730,11 @@ static void isicom_tx(unsigned long _dat
 
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
@@ -1788,42 +1793,45 @@ static struct tty_operations isicom_ops 
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
-			error);
+	if ((error = tty_register_driver(isicom_normal))) {
+		printk(KERN_DEBUG "ISICOM: Couldn't register the dialin "
+			"driver, error=%d\n", error);
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
+		printk(KERN_DEBUG "ISICOM: couldn't unregister normal driver, "
+			"error=%d.\n", error);
+
 	put_tty_driver(isicom_normal);
 }
 
@@ -1893,7 +1901,7 @@ static int __devinit isicom_init(void)
 		free_page((unsigned long)tmp_buf);
 		return 0;
 	}
-	if (register_drivers())
+	if (isicom_register_tty_driver())
 	{
 		unregister_ioregion();
 		free_page((unsigned long)tmp_buf);
@@ -1901,7 +1909,7 @@ static int __devinit isicom_init(void)
 	}
 	if (!register_isr())
 	{
-		unregister_drivers();
+		isicom_unregister_tty_driver();
 		/*  ioports already uregistered in register_isr */
 		free_page((unsigned long)tmp_buf);
 		return 0;
@@ -1938,14 +1946,6 @@ static int __devinit isicom_init(void)
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
@@ -2049,11 +2049,15 @@ static int __devinit isicom_setup(void)
 
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
@@ -2063,3 +2067,11 @@ static void __exit isicom_exit(void)
 
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
