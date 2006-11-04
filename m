Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965552AbWKDR0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965552AbWKDR0R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 12:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965554AbWKDR0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 12:26:17 -0500
Received: from cacti2.profiwh.com ([85.93.165.64]:61668 "EHLO
	cacti.profiwh.com") by vger.kernel.org with ESMTP id S965552AbWKDR0Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 12:26:16 -0500
Message-id: <484026072646411425@wsc.cz>
Subject: [PATCH 1/6] Char: stallion, functions cleanup
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sat,  4 Nov 2006 18:26:17 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stallion, functions cleanup

Delete macros and functions, that are implemented in kernel yet (strtoul,
min, tolower). Expand one function body in place, where it is called from.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 0dc9637900524e9d6b50d0d05368a19c8848dfb0
tree b467e0272cd5e1f3255e69d6359d6ad1cb7a5347
parent 47ab8364553fc2ad46746ea50216769392fd9e37
author Jiri Slaby <jirislaby@gmail.com> Thu, 02 Nov 2006 03:10:08 +0100
committer Jiri Slaby <jirislaby@gmail.com> Thu, 02 Nov 2006 03:10:08 +0100

 drivers/char/stallion.c |  207 +++++++++--------------------------------------
 1 files changed, 40 insertions(+), 167 deletions(-)

diff --git a/drivers/char/stallion.c b/drivers/char/stallion.c
index 7ab9cee..928f406 100644
--- a/drivers/char/stallion.c
+++ b/drivers/char/stallion.c
@@ -41,13 +41,12 @@ #include <linux/init.h>
 #include <linux/smp_lock.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/ctype.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
-#ifdef CONFIG_PCI
 #include <linux/pci.h>
-#endif
 
 /*****************************************************************************/
 
@@ -63,43 +62,16 @@ #define	BRD_ECHPCI	26
 #define	BRD_ECH64PCI	27
 #define	BRD_EASYIOPCI	28
 
-/*
- *	Define a configuration structure to hold the board configuration.
- *	Need to set this up in the code (for now) with the boards that are
- *	to be configured into the system. This is what needs to be modified
- *	when adding/removing/modifying boards. Each line entry in the
- *	stl_brdconf[] array is a board. Each line contains io/irq/memory
- *	ranges for that board (as well as what type of board it is).
- *	Some examples:
- *		{ BRD_EASYIO, 0x2a0, 0, 0, 10, 0 },
- *	This line would configure an EasyIO board (4 or 8, no difference),
- *	at io address 2a0 and irq 10.
- *	Another example:
- *		{ BRD_ECH, 0x2a8, 0x280, 0, 12, 0 },
- *	This line will configure an EasyConnection 8/32 board at primary io
- *	address 2a8, secondary io address 280 and irq 12.
- *	Enter as many lines into this array as you want (only the first 4
- *	will actually be used!). Any combination of EasyIO and EasyConnection
- *	boards can be specified. EasyConnection 8/32 boards can share their
- *	secondary io addresses between each other.
- *
- *	NOTE: there is no need to put any entries in this table for PCI
- *	boards. They will be found automatically by the driver - provided
- *	PCI BIOS32 support is compiled into the kernel.
- */
-
-static struct stlconf {
+struct stlconf {
 	int		brdtype;
 	int		ioaddr1;
 	int		ioaddr2;
 	unsigned long	memaddr;
 	int		irq;
 	int		irqtype;
-} stl_brdconf[] = {
-	/*{ BRD_EASYIO, 0x2a0, 0, 0, 10, 0 },*/
 };
 
-static int	stl_nrbrds = ARRAY_SIZE(stl_brdconf);
+static unsigned int stl_nrbrds;
 
 /*****************************************************************************/
 
@@ -432,15 +404,6 @@ static unsigned int	stl_baudrates[] = {
 	9600, 19200, 38400, 57600, 115200, 230400, 460800, 921600
 };
 
-/*
- *	Define some handy local macros...
- */
-#undef	MIN
-#define	MIN(a,b)	(((a) <= (b)) ? (a) : (b))
-
-#undef	TOLOWER
-#define	TOLOWER(x)	((((x) >= 'A') && ((x) <= 'Z')) ? ((x) + 0x20) : (x))
-
 /*****************************************************************************/
 
 /*
@@ -660,42 +623,6 @@ static struct class *stallion_class;
 /*****************************************************************************/
 
 /*
- *	Convert an ascii string number into an unsigned long.
- */
-
-static unsigned long stl_atol(char *str)
-{
-	unsigned long	val;
-	int		base, c;
-	char		*sp;
-
-	val = 0;
-	sp = str;
-	if ((*sp == '0') && (*(sp+1) == 'x')) {
-		base = 16;
-		sp += 2;
-	} else if (*sp == '0') {
-		base = 8;
-		sp++;
-	} else {
-		base = 10;
-	}
-
-	for (; (*sp != 0); sp++) {
-		c = (*sp > '9') ? (TOLOWER(*sp) - 'a' + 10) : (*sp - '0');
-		if ((c < 0) || (c >= base)) {
-			printk("STALLION: invalid argument %s\n", str);
-			val = 0;
-			break;
-		}
-		val = (val * base) + c;
-	}
-	return val;
-}
-
-/*****************************************************************************/
-
-/*
  *	Parse the supplied argument string, into the board conf struct.
  */
 
@@ -710,7 +637,7 @@ static int __init stl_parsebrd(struct st
 		return 0;
 
 	for (sp = argp[0], i = 0; ((*sp != 0) && (i < 25)); sp++, i++)
-		*sp = TOLOWER(*sp);
+		*sp = tolower(*sp);
 
 	for (i = 0; i < ARRAY_SIZE(stl_brdstr); i++) {
 		if (strcmp(stl_brdstr[i].name, argp[0]) == 0)
@@ -725,15 +652,15 @@ static int __init stl_parsebrd(struct st
 
 	i = 1;
 	if ((argp[i] != NULL) && (*argp[i] != 0))
-		confp->ioaddr1 = stl_atol(argp[i]);
+		confp->ioaddr1 = simple_strtoul(argp[i], NULL, 0);
 	i++;
 	if (confp->brdtype == BRD_ECH) {
 		if ((argp[i] != NULL) && (*argp[i] != 0))
-			confp->ioaddr2 = stl_atol(argp[i]);
+			confp->ioaddr2 = simple_strtoul(argp[i], NULL, 0);
 		i++;
 	}
 	if ((argp[i] != NULL) && (*argp[i] != 0))
-		confp->irq = stl_atol(argp[i]);
+		confp->irq = simple_strtoul(argp[i], NULL, 0);
 	return 1;
 }
 
@@ -758,32 +685,6 @@ static struct stlbrd *stl_allocbrd(void)
 	return brdp;
 }
 
-static void __init stl_argbrds(void)
-{
-	struct stlconf	conf;
-	struct stlbrd	*brdp;
-	int		i;
-
-	pr_debug("stl_argbrds()\n");
-
-	for (i = stl_nrbrds; (i < stl_nargs); i++) {
-		memset(&conf, 0, sizeof(conf));
-		if (stl_parsebrd(&conf, stl_brdsp[i]) == 0)
-			continue;
-		if ((brdp = stl_allocbrd()) == NULL)
-			continue;
-		stl_nrbrds = i + 1;
-		brdp->brdnr = i;
-		brdp->brdtype = conf.brdtype;
-		brdp->ioaddr1 = conf.ioaddr1;
-		brdp->ioaddr2 = conf.ioaddr2;
-		brdp->irq = conf.irq;
-		brdp->irqtype = conf.irqtype;
-		if (stl_brdinit(brdp))
-			kfree(brdp);
-	}
-}
-
 /*****************************************************************************/
 
 static int stl_open(struct tty_struct *tty, struct file *filp)
@@ -1089,10 +990,10 @@ static int stl_write(struct tty_struct *
 		stlen = len;
 	}
 
-	len = MIN(len, count);
+	len = min(len, (unsigned int)count);
 	count = 0;
 	while (len > 0) {
-		stlen = MIN(len, stlen);
+		stlen = min(len, stlen);
 		memcpy(head, chbuf, stlen);
 		len -= stlen;
 		chbuf += stlen;
@@ -2552,56 +2453,6 @@ static struct pci_driver stl_pcidriver =
 /*****************************************************************************/
 
 /*
- *	Scan through all the boards in the configuration and see what we
- *	can find. Handle EIO and the ECH boards a little differently here
- *	since the initial search and setup is too different.
- */
-
-static int __init stl_initbrds(void)
-{
-	struct stlbrd	*brdp;
-	struct stlconf	*confp;
-	int		i;
-
-	pr_debug("stl_initbrds()\n");
-
-	if (stl_nrbrds > STL_MAXBRDS) {
-		printk("STALLION: too many boards in configuration table, "
-			"truncating to %d\n", STL_MAXBRDS);
-		stl_nrbrds = STL_MAXBRDS;
-	}
-
-/*
- *	Firstly scan the list of static boards configured. Allocate
- *	resources and initialize the boards as found.
- */
-	for (i = 0; (i < stl_nrbrds); i++) {
-		confp = &stl_brdconf[i];
-		stl_parsebrd(confp, stl_brdsp[i]);
-		if ((brdp = stl_allocbrd()) == NULL)
-			return(-ENOMEM);
-		brdp->brdnr = i;
-		brdp->brdtype = confp->brdtype;
-		brdp->ioaddr1 = confp->ioaddr1;
-		brdp->ioaddr2 = confp->ioaddr2;
-		brdp->irq = confp->irq;
-		brdp->irqtype = confp->irqtype;
-		if (stl_brdinit(brdp))
-			kfree(brdp);
-	}
-
-/*
- *	Find any dynamically supported boards. That is via module load
- *	line options or auto-detected on the PCI bus.
- */
-	stl_argbrds();
-
-	return(0);
-}
-
-/*****************************************************************************/
-
-/*
  *	Return the board stats structure to user app.
  */
 
@@ -3693,9 +3544,9 @@ static void stl_cd1400txisr(struct stlpa
 		}
 		outb(srer, (ioaddr + EREG_DATA));
 	} else {
-		len = MIN(len, CD1400_TXFIFOSIZE);
+		len = min(len, CD1400_TXFIFOSIZE);
 		portp->stats.txtotal += len;
-		stlen = MIN(len, ((portp->tx.buf + STL_TXBUFSIZE) - tail));
+		stlen = min(len, ((portp->tx.buf + STL_TXBUFSIZE) - tail));
 		outb((TDR + portp->uartaddr), ioaddr);
 		outsb((ioaddr + EREG_DATA), tail, stlen);
 		len -= stlen;
@@ -3748,13 +3599,13 @@ static void stl_cd1400rxisr(struct stlpa
 		outb((RDCR + portp->uartaddr), ioaddr);
 		len = inb(ioaddr + EREG_DATA);
 		if (tty == NULL || (buflen = tty_buffer_request_room(tty, len)) == 0) {
-			len = MIN(len, sizeof(stl_unwanted));
+			len = min(len, sizeof(stl_unwanted));
 			outb((RDSR + portp->uartaddr), ioaddr);
 			insb((ioaddr + EREG_DATA), &stl_unwanted[0], len);
 			portp->stats.rxlost += len;
 			portp->stats.rxtotal += len;
 		} else {
-			len = MIN(len, buflen);
+			len = min(len, buflen);
 			if (len > 0) {
 				unsigned char *ptr;
 				outb((RDSR + portp->uartaddr), ioaddr);
@@ -4617,9 +4468,9 @@ static void stl_sc26198txisr(struct stlp
 			outb(mr0, (ioaddr + XP_DATA));
 		}
 	} else {
-		len = MIN(len, SC26198_TXFIFOSIZE);
+		len = min(len, SC26198_TXFIFOSIZE);
 		portp->stats.txtotal += len;
-		stlen = MIN(len, ((portp->tx.buf + STL_TXBUFSIZE) - tail));
+		stlen = min(len, ((portp->tx.buf + STL_TXBUFSIZE) - tail));
 		outb(GTXFIFO, (ioaddr + XP_ADDR));
 		outsb((ioaddr + XP_DATA), tail, stlen);
 		len -= stlen;
@@ -4660,13 +4511,13 @@ static void stl_sc26198rxisr(struct stlp
 
 	if ((iack & IVR_TYPEMASK) == IVR_RXDATA) {
 		if (tty == NULL || (buflen = tty_buffer_request_room(tty, len)) == 0) {
-			len = MIN(len, sizeof(stl_unwanted));
+			len = min(len, sizeof(stl_unwanted));
 			outb(GRXFIFO, (ioaddr + XP_ADDR));
 			insb((ioaddr + XP_DATA), &stl_unwanted[0], len);
 			portp->stats.rxlost += len;
 			portp->stats.rxtotal += len;
 		} else {
-			len = MIN(len, buflen);
+			len = min(len, buflen);
 			if (len > 0) {
 				unsigned char *ptr;
 				outb(GRXFIFO, (ioaddr + XP_ADDR));
@@ -4833,6 +4684,8 @@ static void stl_sc26198otherisr(struct s
  */
 static int __init stallion_module_init(void)
 {
+	struct stlbrd	*brdp;
+	struct stlconf	conf;
 	unsigned int i, retval;
 
 	printk(KERN_INFO "%s: version %s\n", stl_drvtitle, stl_drvversion);
@@ -4840,7 +4693,27 @@ static int __init stallion_module_init(v
 	spin_lock_init(&stallion_lock);
 	spin_lock_init(&brd_lock);
 
-	stl_initbrds();
+/*
+ *	Find any dynamically supported boards. That is via module load
+ *	line options.
+ */
+	for (i = stl_nrbrds; i < stl_nargs; i++) {
+		memset(&conf, 0, sizeof(conf));
+		if (stl_parsebrd(&conf, stl_brdsp[i]) == 0)
+			continue;
+		if ((brdp = stl_allocbrd()) == NULL)
+			continue;
+		brdp->brdnr = i;
+		brdp->brdtype = conf.brdtype;
+		brdp->ioaddr1 = conf.ioaddr1;
+		brdp->ioaddr2 = conf.ioaddr2;
+		brdp->irq = conf.irq;
+		brdp->irqtype = conf.irqtype;
+		if (stl_brdinit(brdp))
+			kfree(brdp);
+		else
+			stl_nrbrds = i + 1;
+	}
 
 	retval = pci_register_driver(&stl_pcidriver);
 	if (retval)
