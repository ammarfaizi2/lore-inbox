Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422785AbWHEJyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422785AbWHEJyN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 05:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422791AbWHEJyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 05:54:13 -0400
Received: from halon.profiwh.com ([85.93.165.2]:41716 "EHLO orfeus.profiwh.com")
	by vger.kernel.org with ESMTP id S1422785AbWHEJyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 05:54:12 -0400
Message-id: <wonderful_life@hehe.blahblah>
Subject: [PATCH 1/1] Char: mxser, upgrade to 1.9.1
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: <support@moxa.com.tw>
X-SpamReason: {Bypass=00}-{0,00}-{0,00}-{0,00
Date: Sat, 5 Aug 2006 05:54:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser, upgrade to 1.9.1

Change driver according to original 1.9.1 moxa driver. Some int->ulong
conversions, outb ~UART_IER_THRI constant. Remove commented stuff.

I also added printk line with info, if somebody wants to test it, he should
contact me as I can potentially debug the driver with him or just to confirm
it works properly.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 817ebea29606c3cd98c4075aee126ea42d30dcba
tree 45e6382f7b9727e8b0c130fd10cd01cf5b96f63d
parent 5e05396307295bf0948908c1e0b12eed92b62814
author Jiri Slaby <ku@bellona.localdomain> Sat, 05 Aug 2006 11:38:28 +0159
committer Jiri Slaby <ku@bellona.localdomain> Sat, 05 Aug 2006 11:38:28 +0159

 drivers/char/mxser.c    |  396 +++++++++++++++++++++++------------------------
 include/linux/pci_ids.h |    3 
 2 files changed, 195 insertions(+), 204 deletions(-)

diff --git a/drivers/char/mxser.c b/drivers/char/mxser.c
index 556abd3..cd5b0d2 100644
--- a/drivers/char/mxser.c
+++ b/drivers/char/mxser.c
@@ -1,7 +1,7 @@
 /*
  *          mxser.c  -- MOXA Smartio/Industio family multiport serial driver.
  *
- *      Copyright (C) 1999-2001  Moxa Technologies (support@moxa.com.tw).
+ *      Copyright (C) 1999-2006  Moxa Technologies (support@moxa.com.tw).
  *
  *      This code is loosely based on the Linux serial driver, written by
  *      Linus Torvalds, Theodore T'so and others.
@@ -20,15 +20,6 @@
  *      along with this program; if not, write to the Free Software
  *      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- *	Original release	10/26/00
- *
- *	02/06/01	Support MOXA Industio family boards.
- *	02/06/01	Support TIOCGICOUNT.
- *	02/06/01	Fix the problem for connecting to serial mouse.
- *	02/06/01	Fix the problem for H/W flow control.
- *	02/06/01	Fix the compling warning when CONFIG_PCI
- *			don't be defined.
- *
  *	Fed through a cleanup, indent and remove of non 2.6 code by Alan Cox
  *	<alan@redhat.com>. The original 1.8 code is available on www.moxa.com.
  *	- Fixed x86_64 cleanness
@@ -66,7 +57,7 @@ #include <asm/uaccess.h>
 
 #include "mxser.h"
 
-#define	MXSER_VERSION	"1.8"
+#define	MXSER_VERSION	"1.9.1"
 #define	MXSERMAJOR	 174
 #define	MXSERCUMAJOR	 175
 
@@ -76,7 +67,7 @@ #define	MXSER_EVENT_HANGUP	2
 #define MXSER_BOARDS		4	/* Max. boards */
 #define MXSER_PORTS		32	/* Max. ports */
 #define MXSER_PORTS_PER_BOARD	8	/* Max. ports per board */
-#define MXSER_ISR_PASS_LIMIT	256
+#define MXSER_ISR_PASS_LIMIT	99999L
 
 #define	MXSER_ERR_IOADDR	-1
 #define	MXSER_ERR_IRQ		-2
@@ -125,6 +116,9 @@ enum {
 	MXSER_BOARD_CP118U,
 	MXSER_BOARD_CP102UL,
 	MXSER_BOARD_CP102U,
+	MXSER_BOARD_CP118EL,
+	MXSER_BOARD_CP168EL,
+	MXSER_BOARD_CP104EL
 };
 
 static char *mxser_brdname[] = {
@@ -149,6 +143,9 @@ static char *mxser_brdname[] = {
 	"CP-118U series",
 	"CP-102UL series",
 	"CP-102U series",
+	"CP-118EL series",
+	"CP-168EL series",
+	"CP-104EL series"
 };
 
 static int mxser_numports[] = {
@@ -173,6 +170,9 @@ static int mxser_numports[] = {
 	8,			/* CP118U */
 	2,			/* CP102UL */
 	2,			/* CP102U */
+	8,			/* CP118EL */
+	8,			/* CP168EL */
+	4			/* CP104EL */
 };
 
 #define UART_TYPE_NUM	2
@@ -205,22 +205,43 @@ static const struct mxpciuart_info Gpci_
 #ifdef CONFIG_PCI
 
 static struct pci_device_id mxser_pcibrds[] = {
-	{PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_C168, PCI_ANY_ID, PCI_ANY_ID, 0, 0, MXSER_BOARD_C168_PCI},
-	{PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_C104, PCI_ANY_ID, PCI_ANY_ID, 0, 0, MXSER_BOARD_C104_PCI},
-	{PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP132, PCI_ANY_ID, PCI_ANY_ID, 0, 0, MXSER_BOARD_CP132},
-	{PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP114, PCI_ANY_ID, PCI_ANY_ID, 0, 0, MXSER_BOARD_CP114},
-	{PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CT114, PCI_ANY_ID, PCI_ANY_ID, 0, 0, MXSER_BOARD_CT114},
-	{PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102, PCI_ANY_ID, PCI_ANY_ID, 0, 0, MXSER_BOARD_CP102},
-	{PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP104U, PCI_ANY_ID, PCI_ANY_ID, 0, 0, MXSER_BOARD_CP104U},
-	{PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP168U, PCI_ANY_ID, PCI_ANY_ID, 0, 0, MXSER_BOARD_CP168U},
-	{PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP132U, PCI_ANY_ID, PCI_ANY_ID, 0, 0, MXSER_BOARD_CP132U},
-	{PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP134U, PCI_ANY_ID, PCI_ANY_ID, 0, 0, MXSER_BOARD_CP134U},
-	{PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP104JU, PCI_ANY_ID, PCI_ANY_ID, 0, 0, MXSER_BOARD_CP104JU},
-	{PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_RC7000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, MXSER_BOARD_RC7000},
-	{PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP118U, PCI_ANY_ID, PCI_ANY_ID, 0, 0, MXSER_BOARD_CP118U},
-	{PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102UL, PCI_ANY_ID, PCI_ANY_ID, 0, 0, MXSER_BOARD_CP102UL},
-	{PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102U, PCI_ANY_ID, PCI_ANY_ID, 0, 0, MXSER_BOARD_CP102U},
-	{0}
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_C168),
+		.driver_data = MXSER_BOARD_C168_PCI },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_C104),
+		.driver_data = MXSER_BOARD_C104_PCI },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP132),
+		.driver_data = MXSER_BOARD_CP132 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP114),
+		.driver_data = MXSER_BOARD_CP114 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CT114),
+		.driver_data = MXSER_BOARD_CT114 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102),
+		.driver_data = MXSER_BOARD_CP102 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP104U),
+		.driver_data = MXSER_BOARD_CP104U },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP168U),
+		.driver_data = MXSER_BOARD_CP168U },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP132U),
+		.driver_data = MXSER_BOARD_CP132U },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP134U),
+		.driver_data = MXSER_BOARD_CP134U },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP104JU),
+		.driver_data = MXSER_BOARD_CP104JU },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_RC7000),
+		.driver_data = MXSER_BOARD_RC7000 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP118U),
+		.driver_data = MXSER_BOARD_CP118U },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102UL),
+		.driver_data = MXSER_BOARD_CP102UL },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102U),
+		.driver_data = MXSER_BOARD_CP102U },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP118EL),
+		.driver_data = MXSER_BOARD_CP118EL },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP168EL),
+		.driver_data = MXSER_BOARD_CP168EL },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP104EL),
+		.driver_data = MXSER_BOARD_CP104EL },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, mxser_pcibrds);
@@ -245,7 +266,6 @@ MODULE_AUTHOR("Casper Yang");
 MODULE_DESCRIPTION("MOXA Smartio/Industio Family Multiport Board Device Driver");
 module_param_array(ioaddr, int, NULL, 0);
 module_param(ttymajor, int, 0);
-module_param(calloutmajor, int, 0);
 module_param(verbose, bool, 0);
 MODULE_LICENSE("GPL");
 
@@ -285,23 +305,23 @@ struct mxser_hwconf {
 	int board_type;
 	int ports;
 	int irq;
-	int vector;
-	int vector_mask;
+	unsigned long vector;
+	unsigned long vector_mask;
 	int uart_type;
-	int ioaddr[MXSER_PORTS_PER_BOARD];
+	unsigned long ioaddr[MXSER_PORTS_PER_BOARD];
 	int baud_base[MXSER_PORTS_PER_BOARD];
 	moxa_pci_info pciInfo;
 	int IsMoxaMustChipFlag;	/* add by Victor Yu. 08-30-2002 */
 	int MaxCanSetBaudRate[MXSER_PORTS_PER_BOARD];	/* add by Victor Yu. 09-04-2002 */
-	int opmode_ioaddr[MXSER_PORTS_PER_BOARD];	/* add by Victor Yu. 01-05-2004 */
+	unsigned long opmode_ioaddr[MXSER_PORTS_PER_BOARD];	/* add by Victor Yu. 01-05-2004 */
 };
 
 struct mxser_struct {
 	int port;
-	int base;		/* port base address */
+	unsigned long base;	/* port base address */
 	int irq;		/* port using irq no. */
-	int vector;		/* port irq vector */
-	int vectormask;		/* port vector mask */
+	unsigned long vector;	/* port irq vector */
+	unsigned long vectormask;	/* port vector mask */
 	int rx_high_water;
 	int rx_trigger;		/* Rx fifo trigger level */
 	int rx_low_water;
@@ -337,7 +357,7 @@ struct mxser_struct {
 	int timeout;
 	int IsMoxaMustChipFlag;	/* add by Victor Yu. 08-30-2002 */
 	int MaxCanSetBaudRate;	/* add by Victor Yu. 09-04-2002 */
-	int opmode_ioaddr;	/* add by Victor Yu. 01-05-2004 */
+	unsigned long opmode_ioaddr;	/* add by Victor Yu. 01-05-2004 */
 	unsigned char stop_rx;
 	unsigned char ldisc_stop_rx;
 	long realbaud;
@@ -485,6 +505,9 @@ static int __init mxser_module_init(void
 
 	if (verbose)
 		printk(KERN_DEBUG "Loading module mxser ...\n");
+	printk(KERN_INFO "This is mxser driver version 1.9.1 and needs TESTING."
+		"If your are willing to test this driver, please report to "
+		"jirislaby@gmail.com. Thanks.\n");
 	ret = mxser_init();
 	if (verbose)
 		printk(KERN_DEBUG "Done.\n");
@@ -635,7 +658,7 @@ static int mxser_get_PCI_conf(int busnum
 {
 	int i, j;
 	/* unsigned int val; */
-	unsigned int ioaddress;
+	unsigned long ioaddress;
 	struct pci_dev *pdev = hwconf->pciInfo.pdev;
 
 	/* io address */
@@ -789,7 +812,7 @@ static int mxser_init(void)
 
 	/* Start finding ISA boards from module arg */
 	for (b = 0; b < MXSER_BOARDS && m < MXSER_BOARDS; b++) {
-		int cap;
+		unsigned long cap;
 
 		if (!(cap = ioaddr[b]))
 			continue;
@@ -924,12 +947,10 @@ static void mxser_do_softint(void *priva
 
 	tty = info->tty;
 
-	if (tty) {
-		if (test_and_clear_bit(MXSER_EVENT_TXLOW, &info->event))
-			tty_wakeup(tty);
-		if (test_and_clear_bit(MXSER_EVENT_HANGUP, &info->event))
-			tty_hangup(tty);
-	}
+	if (test_and_clear_bit(MXSER_EVENT_TXLOW, &info->event))
+		tty_wakeup(tty);
+	if (test_and_clear_bit(MXSER_EVENT_HANGUP, &info->event))
+		tty_hangup(tty);
 }
 
 static unsigned char mxser_get_msr(int baseaddr, int mode, int port, struct mxser_struct *info)
@@ -975,6 +996,7 @@ static int mxser_open(struct tty_struct 
 	/*
 	 * Start up serial port
 	 */
+	info->count++;
 	retval = mxser_startup(info);
 	if (retval)
 		return retval;
@@ -983,8 +1005,6 @@ static int mxser_open(struct tty_struct 
 	if (retval)
 		return retval;
 
-	info->count++;
-
 	if ((info->count == 1) && (info->flags & ASYNC_SPLIT_TERMIOS)) {
 		if (tty->driver->subtype == SERIAL_TYPE_NORMAL)
 			*tty->termios = info->normal_termios;
@@ -1146,11 +1166,13 @@ static int mxser_write(struct tty_struct
 		total += c;
 	}
 
-	if (info->xmit_cnt && !tty->stopped && !(info->IER & UART_IER_THRI)) {
+	if (info->xmit_cnt && !tty->stopped
+			/*&& !(info->IER & UART_IER_THRI)*/) {
 		if (!tty->hw_stopped ||
 				(info->type == PORT_16550A) ||
 				(info->IsMoxaMustChipFlag)) {
 			spin_lock_irqsave(&info->slock, flags);
+			outb(info->IER & ~UART_IER_THRI, info->base + UART_IER);
 			info->IER |= UART_IER_THRI;
 			outb(info->IER, info->base + UART_IER);
 			spin_unlock_irqrestore(&info->slock, flags);
@@ -1175,11 +1197,12 @@ static void mxser_put_char(struct tty_st
 	info->xmit_head &= SERIAL_XMIT_SIZE - 1;
 	info->xmit_cnt++;
 	spin_unlock_irqrestore(&info->slock, flags);
-	if (!tty->stopped && !(info->IER & UART_IER_THRI)) {
+	if (!tty->stopped /*&& !(info->IER & UART_IER_THRI)*/) {
 		if (!tty->hw_stopped ||
 				(info->type == PORT_16550A) ||
 				info->IsMoxaMustChipFlag) {
 			spin_lock_irqsave(&info->slock, flags);
+			outb(info->IER & ~UART_IER_THRI, info->base + UART_IER);
 			info->IER |= UART_IER_THRI;
 			outb(info->IER, info->base + UART_IER);
 			spin_unlock_irqrestore(&info->slock, flags);
@@ -1204,6 +1227,7 @@ static void mxser_flush_chars(struct tty
 
 	spin_lock_irqsave(&info->slock, flags);
 
+	outb(info->IER & ~UART_IER_THRI, info->base + UART_IER);
 	info->IER |= UART_IER_THRI;
 	outb(info->IER, info->base + UART_IER);
 
@@ -1224,7 +1248,12 @@ static int mxser_write_room(struct tty_s
 static int mxser_chars_in_buffer(struct tty_struct *tty)
 {
 	struct mxser_struct *info = tty->driver_data;
-	return info->xmit_cnt;
+	int len = info->xmit_cnt;
+
+	if (!(inb(info->base + UART_LSR) & UART_LSR_THRE))
+		len++;
+
+	return len;
 }
 
 static void mxser_flush_buffer(struct tty_struct *tty)
@@ -1266,7 +1295,8 @@ static int mxser_ioctl(struct tty_struct
 
 	/* following add by Victor Yu. 01-05-2004 */
 	if (cmd == MOXA_SET_OP_MODE || cmd == MOXA_GET_OP_MODE) {
-		int opmode, p;
+		int p;
+		unsigned long opmode;
 		static unsigned char ModeMask[] = { 0xfc, 0xf3, 0xcf, 0x3f };
 		int shiftbit;
 		unsigned char val, mask;
@@ -1568,9 +1598,8 @@ static int mxser_ioctl_special(unsigned 
 			return -EFAULT;
 		return 0;
 	case MOXA_ASPP_MON_EXT: {
-			int status;
-			int opmode, p;
-			int shiftbit;
+			int status, p, shiftbit;
+			unsigned long opmode;
 			unsigned cflag, iflag;
 
 			for (i = 0; i < MXSER_PORTS; i++) {
@@ -1650,73 +1679,52 @@ static int mxser_ioctl_special(unsigned 
 static void mxser_stoprx(struct tty_struct *tty)
 {
 	struct mxser_struct *info = tty->driver_data;
-	/* unsigned long flags; */
 
 	info->ldisc_stop_rx = 1;
 	if (I_IXOFF(tty)) {
-		/* MX_LOCK(&info->slock); */
 		/* following add by Victor Yu. 09-02-2002 */
 		if (info->IsMoxaMustChipFlag) {
 			info->IER &= ~MOXA_MUST_RECV_ISR;
 			outb(info->IER, info->base + UART_IER);
-		} else {
-			/* above add by Victor Yu. 09-02-2002 */
+		} else if (!(info->flags & ASYNC_CLOSING)) {
 			info->x_char = STOP_CHAR(tty);
-			/* mask by Victor Yu. 09-02-2002 */
-			/* outb(info->IER, 0); */
 			outb(0, info->base + UART_IER);
 			info->IER |= UART_IER_THRI;
-			/* force Tx interrupt */
 			outb(info->IER, info->base + UART_IER);
-		}		/* add by Victor Yu. 09-02-2002 */
-		/* MX_UNLOCK(&info->slock); */
+		}
 	}
 
 	if (info->tty->termios->c_cflag & CRTSCTS) {
-		/* MX_LOCK(&info->slock); */
 		info->MCR &= ~UART_MCR_RTS;
 		outb(info->MCR, info->base + UART_MCR);
-		/* MX_UNLOCK(&info->slock); */
 	}
 }
 
 static void mxser_startrx(struct tty_struct *tty)
 {
 	struct mxser_struct *info = tty->driver_data;
-	/* unsigned long flags; */
 
 	info->ldisc_stop_rx = 0;
 	if (I_IXOFF(tty)) {
 		if (info->x_char)
 			info->x_char = 0;
 		else {
-			/* MX_LOCK(&info->slock); */
-
 			/* following add by Victor Yu. 09-02-2002 */
 			if (info->IsMoxaMustChipFlag) {
 				info->IER |= MOXA_MUST_RECV_ISR;
 				outb(info->IER, info->base + UART_IER);
-			} else {
-				/* above add by Victor Yu. 09-02-2002 */
-
+			} else if (!(info->flags & ASYNC_CLOSING)) {
 				info->x_char = START_CHAR(tty);
-				/* mask by Victor Yu. 09-02-2002 */
-				/* outb(info->IER, 0); */
-				/* add by Victor Yu. 09-02-2002 */
 				outb(0, info->base + UART_IER);
-				/* force Tx interrupt */
 				info->IER |= UART_IER_THRI;
 				outb(info->IER, info->base + UART_IER);
-			}	/* add by Victor Yu. 09-02-2002 */
-			/* MX_UNLOCK(&info->slock); */
+			}
 		}
 	}
 
 	if (info->tty->termios->c_cflag & CRTSCTS) {
-		/* MX_LOCK(&info->slock); */
 		info->MCR |= UART_MCR_RTS;
 		outb(info->MCR, info->base + UART_MCR);
-		/* MX_UNLOCK(&info->slock); */
 	}
 }
 
@@ -1726,22 +1734,22 @@ static void mxser_startrx(struct tty_str
  */
 static void mxser_throttle(struct tty_struct *tty)
 {
-	/* struct mxser_struct *info = tty->driver_data; */
-	/* unsigned long flags; */
+	struct mxser_struct *info = tty->driver_data;
+	unsigned long flags;
 
-	/* MX_LOCK(&info->slock); */
+	spin_lock_irqsave(&info->slock, flags);
 	mxser_stoprx(tty);
-	/* MX_UNLOCK(&info->slock); */
+	spin_unlock_irqrestore(&info->slock, flags);
 }
 
 static void mxser_unthrottle(struct tty_struct *tty)
 {
-	/* struct mxser_struct *info = tty->driver_data; */
-	/* unsigned long flags; */
+	struct mxser_struct *info = tty->driver_data;
+	unsigned long flags;
 
-	/* MX_LOCK(&info->slock); */
+	spin_lock_irqsave(&info->slock, flags);
 	mxser_startrx(tty);
-	/* MX_UNLOCK(&info->slock); */
+	spin_unlock_irqrestore(&info->slock, flags);
 }
 
 static void mxser_set_termios(struct tty_struct *tty, struct termios *old_termios)
@@ -1803,7 +1811,9 @@ static void mxser_start(struct tty_struc
 	unsigned long flags;
 
 	spin_lock_irqsave(&info->slock, flags);
-	if (info->xmit_cnt && info->xmit_buf && !(info->IER & UART_IER_THRI)) {
+	if (info->xmit_cnt && info->xmit_buf
+			/* && !(info->IER & UART_IER_THRI) */) {
+		outb(info->IER & ~UART_IER_THRI, info->base + UART_IER);
 		info->IER |= UART_IER_THRI;
 		outb(info->IER, info->base + UART_IER);
 	}
@@ -1923,6 +1933,7 @@ static irqreturn_t mxser_interrupt(int i
 	struct mxser_struct *port;
 	int max, irqbits, bits, msr;
 	int pass_counter = 0;
+	unsigned int int_cnt;
 	int handled = IRQ_NONE;
 
 	port = NULL;
@@ -1953,90 +1964,77 @@ static irqreturn_t mxser_interrupt(int i
 				continue;
 			info = port + i;
 
-			/* following add by Victor Yu. 09-13-2002 */
-			iir = inb(info->base + UART_IIR);
-			if (iir & UART_IIR_NO_INT)
-				continue;
-			iir &= MOXA_MUST_IIR_MASK;
-			if (!info->tty) {
-				status = inb(info->base + UART_LSR);
-				outb(0x27, info->base + UART_FCR);
-				inb(info->base + UART_MSR);
-				continue;
-			}
-			/* above add by Victor Yu. 09-13-2002 */
-			/*
-			   if (info->tty->flip.count < TTY_FLIPBUF_SIZE / 4) {
-			   info->IER |= MOXA_MUST_RECV_ISR;
-			   outb(info->IER, info->base + UART_IER);
-			   }
-			 */
-
-
-			/* mask by Victor Yu. 09-13-2002
-			   if ( !info->tty ||
-			   (inb(info->base + UART_IIR) & UART_IIR_NO_INT) )
-			   continue;
-			 */
-			/* mask by Victor Yu. 09-02-2002
-			   status = inb(info->base + UART_LSR) & info->read_status_mask;
-			 */
-
-			/* following add by Victor Yu. 09-02-2002 */
-			status = inb(info->base + UART_LSR);
+			int_cnt = 0;
+			do {
+				/* following add by Victor Yu. 09-13-2002 */
+				iir = inb(info->base + UART_IIR);
+				if (iir & UART_IIR_NO_INT)
+					break;
+				iir &= MOXA_MUST_IIR_MASK;
+				if (!info->tty) {
+					status = inb(info->base + UART_LSR);
+					outb(0x27, info->base + UART_FCR);
+					inb(info->base + UART_MSR);
+					break;
+				}
+				/* above add by Victor Yu. 09-13-2002 */
 
-			if (status & UART_LSR_PE)
-				info->err_shadow |= NPPI_NOTIFY_PARITY;
-			if (status & UART_LSR_FE)
-				info->err_shadow |= NPPI_NOTIFY_FRAMING;
-			if (status & UART_LSR_OE)
-				info->err_shadow |= NPPI_NOTIFY_HW_OVERRUN;
-			if (status & UART_LSR_BI)
-				info->err_shadow |= NPPI_NOTIFY_BREAK;
+				spin_lock(&info->slock);
+				/* following add by Victor Yu. 09-02-2002 */
+				status = inb(info->base + UART_LSR);
 
-			if (info->IsMoxaMustChipFlag) {
-				/*
-				   if ( (status & 0x02) && !(status & 0x01) ) {
-				   outb(info->base+UART_FCR,  0x23);
-				   continue;
-				   }
-				 */
-				if (iir == MOXA_MUST_IIR_GDA ||
-						iir == MOXA_MUST_IIR_RDA ||
-						iir == MOXA_MUST_IIR_RTO ||
-						iir == MOXA_MUST_IIR_LSR)
-					mxser_receive_chars(info, &status);
+				if (status & UART_LSR_PE)
+					info->err_shadow |= NPPI_NOTIFY_PARITY;
+				if (status & UART_LSR_FE)
+					info->err_shadow |= NPPI_NOTIFY_FRAMING;
+				if (status & UART_LSR_OE)
+					info->err_shadow |=
+						NPPI_NOTIFY_HW_OVERRUN;
+				if (status & UART_LSR_BI)
+					info->err_shadow |= NPPI_NOTIFY_BREAK;
+
+				if (info->IsMoxaMustChipFlag) {
+					/*
+					   if ( (status & 0x02) && !(status & 0x01) ) {
+					   outb(info->base+UART_FCR,  0x23);
+					   continue;
+					   }
+					 */
+					if (iir == MOXA_MUST_IIR_GDA ||
+					    iir == MOXA_MUST_IIR_RDA ||
+					    iir == MOXA_MUST_IIR_RTO ||
+					    iir == MOXA_MUST_IIR_LSR)
+						mxser_receive_chars(info,
+								&status);
 
-			} else {
-				/* above add by Victor Yu. 09-02-2002 */
+				} else {
+					/* above add by Victor Yu. 09-02-2002 */
 
-				status &= info->read_status_mask;
-				if (status & UART_LSR_DR)
-					mxser_receive_chars(info, &status);
-			}
-			msr = inb(info->base + UART_MSR);
-			if (msr & UART_MSR_ANY_DELTA) {
-				mxser_check_modem_status(info, msr);
-			}
-			/* following add by Victor Yu. 09-13-2002 */
-			if (info->IsMoxaMustChipFlag) {
-				if ((iir == 0x02) && (status & UART_LSR_THRE)) {
-					mxser_transmit_chars(info);
+					status &= info->read_status_mask;
+					if (status & UART_LSR_DR)
+						mxser_receive_chars(info,
+								&status);
 				}
-			} else {
-				/* above add by Victor Yu. 09-13-2002 */
+				msr = inb(info->base + UART_MSR);
+				if (msr & UART_MSR_ANY_DELTA)
+					mxser_check_modem_status(info, msr);
+
+				/* following add by Victor Yu. 09-13-2002 */
+				if (info->IsMoxaMustChipFlag) {
+					if (iir == 0x02 && (status &
+								UART_LSR_THRE))
+						mxser_transmit_chars(info);
+				} else {
+					/* above add by Victor Yu. 09-13-2002 */
 
-				if (status & UART_LSR_THRE) {
-/* 8-2-99 by William
-			    if ( info->x_char || (info->xmit_cnt > 0) )
-*/
-					mxser_transmit_chars(info);
+					if (status & UART_LSR_THRE)
+						mxser_transmit_chars(info);
 				}
-			}
+				spin_unlock(&info->slock);
+			} while (int_cnt++ < MXSER_ISR_PASS_LIMIT);
 		}
-		if (pass_counter++ > MXSER_ISR_PASS_LIMIT) {
+		if (pass_counter++ > MXSER_ISR_PASS_LIMIT)
 			break;	/* Prevent infinite loops */
-		}
 	}
 
       irq_stop:
@@ -2066,9 +2064,8 @@ static void mxser_receive_chars(struct m
 	/* following add by Victor Yu. 09-02-2002 */
 	if (info->IsMoxaMustChipFlag != MOXA_OTHER_UART) {
 
-		if (*status & UART_LSR_SPECIAL) {
+		if (*status & UART_LSR_SPECIAL)
 			goto intr_old;
-		}
 		/* following add by Victor Yu. 02-11-2004 */
 		if (info->IsMoxaMustChipFlag == MOXA_MUST_MU860_HWID &&
 				(*status & MOXA_MUST_LSR_RERR))
@@ -2093,12 +2090,6 @@ static void mxser_receive_chars(struct m
 			ch = inb(info->base + UART_RX);
 			tty_insert_flip_char(tty, ch, 0);
 			cnt++;
-			/*
-			   if ((cnt >= HI_WATER) && (info->stop_rx == 0)) {
-			   mxser_stoprx(tty);
-			   info->stop_rx = 1;
-			   break;
-			   } */
 		}
 		goto end_intr;
 	}
@@ -2108,17 +2099,11 @@ static void mxser_receive_chars(struct m
 	do {
 		if (max-- < 0)
 			break;
-		/*
-		   if ((cnt >= HI_WATER) && (info->stop_rx == 0)) {
-		   mxser_stoprx(tty);
-		   info->stop_rx=1;
-		   break;
-		   }
-		 */
 
 		ch = inb(info->base + UART_RX);
 		/* following add by Victor Yu. 09-02-2002 */
-		if (info->IsMoxaMustChipFlag && (*status & UART_LSR_OE) /*&& !(*status&UART_LSR_DR) */ )
+		if (info->IsMoxaMustChipFlag && (*status & UART_LSR_OE)
+				/*&& !(*status&UART_LSR_DR) */)
 			outb(0x23, info->base + UART_FCR);
 		*status &= info->read_status_mask;
 		/* above add by Victor Yu. 09-02-2002 */
@@ -2132,26 +2117,25 @@ static void mxser_receive_chars(struct m
 					flag = TTY_BREAK;
 /* added by casper 1/11/2000 */
 					info->icount.brk++;
-/* */
+
 					if (info->flags & ASYNC_SAK)
 						do_SAK(tty);
 				} else if (*status & UART_LSR_PE) {
 					flag = TTY_PARITY;
 /* added by casper 1/11/2000 */
 					info->icount.parity++;
-/* */
 				} else if (*status & UART_LSR_FE) {
 					flag = TTY_FRAME;
 /* added by casper 1/11/2000 */
 					info->icount.frame++;
-/* */
 				} else if (*status & UART_LSR_OE) {
 					flag = TTY_OVERRUN;
 /* added by casper 1/11/2000 */
 					info->icount.overrun++;
-/* */
-				}
-			}
+				} else
+					flags = TTY_BREAK;
+			} else
+				flags = 0;
 			tty_insert_flip_char(tty, ch, flag);
 			cnt++;
 			if (cnt >= recv_room) {
@@ -2167,7 +2151,6 @@ static void mxser_receive_chars(struct m
 		/* following add by Victor Yu. 09-02-2002 */
 		if (info->IsMoxaMustChipFlag)
 			break;
-		/* above add by Victor Yu. 09-02-2002 */
 
 		/* mask by Victor Yu. 09-02-2002
 		 *status = inb(info->base + UART_LSR) & info->read_status_mask;
@@ -2202,24 +2185,25 @@ static void mxser_transmit_chars(struct 
 
 /* added by casper 1/11/2000 */
 		info->icount.tx++;
-/* */
-		spin_unlock_irqrestore(&info->slock, flags);
-		return;
+		goto unlock;
 	}
 
-	if (info->xmit_buf == 0) {
-		spin_unlock_irqrestore(&info->slock, flags);
-		return;
-	}
+	if (info->xmit_buf == 0)
+		goto unlock;
 
-	if ((info->xmit_cnt <= 0) || info->tty->stopped ||
-			(info->tty->hw_stopped &&
+	if (info->xmit_cnt == 0) {
+		if (info->xmit_cnt < WAKEUP_CHARS) { /* XXX what's this for?? */
+			set_bit(MXSER_EVENT_TXLOW, &info->event);
+			schedule_work(&info->tqueue);
+		}
+		goto unlock;
+	}
+	if (info->tty->stopped || (info->tty->hw_stopped &&
 			(info->type != PORT_16550A) &&
 			(!info->IsMoxaMustChipFlag))) {
 		info->IER &= ~UART_IER_THRI;
 		outb(info->IER, info->base + UART_IER);
-		spin_unlock_irqrestore(&info->slock, flags);
-		return;
+		goto unlock;
 	}
 
 	cnt = info->xmit_cnt;
@@ -2236,11 +2220,9 @@ static void mxser_transmit_chars(struct 
 /* added by James 03-12-2004. */
 	info->mon_data.txcnt += (cnt - info->xmit_cnt);
 	info->mon_data.up_txcnt += (cnt - info->xmit_cnt);
-/* (above) added by James. */
 
 /* added by casper 1/11/2000 */
 	info->icount.tx += (cnt - info->xmit_cnt);
-/* */
 
 	if (info->xmit_cnt < WAKEUP_CHARS) {
 		set_bit(MXSER_EVENT_TXLOW, &info->event);
@@ -2250,6 +2232,7 @@ static void mxser_transmit_chars(struct 
 		info->IER &= ~UART_IER_THRI;
 		outb(info->IER, info->base + UART_IER);
 	}
+unlock:
 	spin_unlock_irqrestore(&info->slock, flags);
 }
 
@@ -2280,16 +2263,19 @@ static void mxser_check_modem_status(str
 
 				if ((info->type != PORT_16550A) &&
 						(!info->IsMoxaMustChipFlag)) {
+					outb(info->IER & ~UART_IER_THRI,
+							info->base + UART_IER);
 					info->IER |= UART_IER_THRI;
 					outb(info->IER, info->base + UART_IER);
 				}
 				set_bit(MXSER_EVENT_TXLOW, &info->event);
-				schedule_work(&info->tqueue);			}
+				schedule_work(&info->tqueue);
+			}
 		} else {
 			if (!(status & UART_MSR_CTS)) {
 				info->tty->hw_stopped = 1;
-				if ((info->type != PORT_16550A) &&
-						(!info->IsMoxaMustChipFlag)) {
+				if (info->type != PORT_16550A &&
+						!info->IsMoxaMustChipFlag) {
 					info->IER &= ~UART_IER_THRI;
 					outb(info->IER, info->base + UART_IER);
 				}
@@ -2705,8 +2691,10 @@ #endif
 			if (info->tty->hw_stopped) {
 				if (status & UART_MSR_CTS) {
 					info->tty->hw_stopped = 0;
-					if ((info->type != PORT_16550A) &&
-							(!info->IsMoxaMustChipFlag)) {
+					if (info->type != PORT_16550A &&
+							!info->IsMoxaMustChipFlag) {
+						outb(info->IER & ~UART_IER_THRI,
+							info->base + UART_IER);
 						info->IER |= UART_IER_THRI;
 						outb(info->IER, info->base + UART_IER);
 					}
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 90bcd65..cc82399 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1777,14 +1777,17 @@ #define PCI_DEVICE_ID_MOXA_CP102U	0x1022
 #define PCI_DEVICE_ID_MOXA_C104		0x1040
 #define PCI_DEVICE_ID_MOXA_CP104U	0x1041
 #define PCI_DEVICE_ID_MOXA_CP104JU	0x1042
+#define PCI_DEVICE_ID_MOXA_CP104EL	0x1043
 #define PCI_DEVICE_ID_MOXA_CT114	0x1140
 #define PCI_DEVICE_ID_MOXA_CP114	0x1141
 #define PCI_DEVICE_ID_MOXA_CP118U	0x1180
+#define PCI_DEVICE_ID_MOXA_CP118EL	0x1181
 #define PCI_DEVICE_ID_MOXA_CP132	0x1320
 #define PCI_DEVICE_ID_MOXA_CP132U	0x1321
 #define PCI_DEVICE_ID_MOXA_CP134U	0x1340
 #define PCI_DEVICE_ID_MOXA_C168		0x1680
 #define PCI_DEVICE_ID_MOXA_CP168U	0x1681
+#define PCI_DEVICE_ID_MOXA_CP168EL	0x1682
 
 #define PCI_VENDOR_ID_CCD		0x1397
 #define PCI_DEVICE_ID_CCD_2BD0		0x2bd0
