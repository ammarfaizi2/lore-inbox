Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWG2TaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWG2TaU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 15:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWG2TaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 15:30:19 -0400
Received: from halon.profiwh.com ([85.93.165.2]:49388 "EHLO orfeus.profiwh.com")
	by vger.kernel.org with ESMTP id S1752070AbWG2T3v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 15:29:51 -0400
Message-id: <and_too_few_time@hehe.blahblah>
Subject: [RFC 2/2] Char: mxser rework to allow dynamic structs
From: Jiri Slaby <jirislaby@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: <support@moxa.com.tw>
X-SpamReason: {Bypass=00}-{0,00}-{0,00}-{0,00
Date: Sat, 29 Jul 2006 15:29:51 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser rework to allow dynamic structs

This patch is preparing for further patches (probing) to allow allocated
structures to behave as private data in probe structures.
Union two different structures used in the driver (hw_conf and port/board
descriptor) to another 2: port and board not to initialize 2 different
things and to have ports contained in board.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 8e013921e94b248b33880b58b46e5eba4a931b51
tree c4f052cfb868f424ec51eec8c53b1528d21e70aa
parent 13ff0f1b364f40125fc25906bb3f05dda832d531
author Jiri Slaby <ku@bellona.localdomain> Sat, 29 Jul 2006 20:46:28 +0159
committer Jiri Slaby <ku@bellona.localdomain> Sat, 29 Jul 2006 20:46:28 +0159

 drivers/char/mxser.c | 1198 ++++++++++++++++++++++++--------------------------
 drivers/char/mxser.h |   16 -
 2 files changed, 586 insertions(+), 628 deletions(-)

diff --git a/drivers/char/mxser.c b/drivers/char/mxser.c
index 7a90b71..d006e5d 100644
--- a/drivers/char/mxser.c
+++ b/drivers/char/mxser.c
@@ -57,7 +57,7 @@ #include <asm/uaccess.h>
 
 #include "mxser.h"
 
-#define	MXSER_VERSION	"1.9.1"
+#define	MXSER_VERSION	"2.0"
 #define	MXSERMAJOR	 174
 #define	MXSERCUMAJOR	 175
 
@@ -85,8 +85,6 @@ #define UART_LSR_SPECIAL	0x1E
 #define RELEVANT_IFLAG(iflag)	(iflag & (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK|\
 					  IXON|IXOFF))
 
-#define IRQ_T(info) ((info->flags & ASYNC_SHARE_IRQ) ? IRQF_SHARED : IRQF_DISABLED)
-
 #define C168_ASIC_ID    1
 #define C104_ASIC_ID    2
 #define C102_ASIC_ID	0xB
@@ -202,8 +200,6 @@ static const struct mxpciuart_info Gpci_
 };
 
 
-#ifdef CONFIG_PCI
-
 static struct pci_device_id mxser_pcibrds[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_C168),
 		.driver_data = MXSER_BOARD_C168_PCI },
@@ -243,18 +239,8 @@ static struct pci_device_id mxser_pcibrd
 		.driver_data = MXSER_BOARD_CP104EL },
 	{ }
 };
-
 MODULE_DEVICE_TABLE(pci, mxser_pcibrds);
 
-
-#endif
-
-typedef struct _moxa_pci_info {
-	unsigned short busNum;
-	unsigned short devNum;
-	struct pci_dev *pdev;	/* add by Victor Yu. 06-23-2003 */
-} moxa_pci_info;
-
 static int ioaddr[MXSER_BOARDS] = { 0, 0, 0, 0 };
 static int ttymajor = MXSERMAJOR;
 static int calloutmajor = MXSERCUMAJOR;
@@ -301,69 +287,77 @@ struct mxser_mon_ext {
 	int iftype[32];
 };
 
-struct mxser_hwconf {
-	int board_type;
-	int ports;
-	int irq;
-	unsigned long vector;
-	unsigned long vector_mask;
-	int uart_type;
-	unsigned long ioaddr[MXSER_PORTS_PER_BOARD];
-	int baud_base[MXSER_PORTS_PER_BOARD];
-	moxa_pci_info pciInfo;
-	int IsMoxaMustChipFlag;	/* add by Victor Yu. 08-30-2002 */
-	int MaxCanSetBaudRate[MXSER_PORTS_PER_BOARD];	/* add by Victor Yu. 09-04-2002 */
-	unsigned long opmode_ioaddr[MXSER_PORTS_PER_BOARD];	/* add by Victor Yu. 01-05-2004 */
-};
+struct mxser_board;
+
+struct mxser_port {
+	struct mxser_board *board;
+	struct tty_struct *tty;
+
+	unsigned long ioaddr;
+	unsigned long opmode_ioaddr;
+	int max_baud;
 
-struct mxser_struct {
-	int port;
-	unsigned long base;	/* port base address */
-	int irq;		/* port using irq no. */
-	unsigned long vector;	/* port irq vector */
-	unsigned long vectormask;	/* port vector mask */
 	int rx_high_water;
 	int rx_trigger;		/* Rx fifo trigger level */
 	int rx_low_water;
 	int baud_base;		/* max. speed */
-	int flags;		/* defined in tty.h */
+	long realbaud;
 	int type;		/* UART type */
-	struct tty_struct *tty;
-	int read_status_mask;
-	int ignore_status_mask;
-	int xmit_fifo_size;
-	int custom_divisor;
+	int flags;		/* defined in tty.h */
+	long session;		/* Session of opening process */
+	long pgrp;		/* pgrp of opening process */
+
 	int x_char;		/* xon/xoff character */
-	int close_delay;
-	unsigned short closing_wait;
 	int IER;		/* Interrupt Enable Register */
 	int MCR;		/* Modem control register */
+
+	unsigned char stop_rx;
+	unsigned char ldisc_stop_rx;
+
+	int custom_divisor;
+	int close_delay;
+	unsigned short closing_wait;
+	unsigned char err_shadow;
 	unsigned long event;
+
 	int count;		/* # of fd on device */
 	int blocked_open;	/* # of blocked opens */
-	long session;		/* Session of opening process */
-	long pgrp;		/* pgrp of opening process */
+	struct async_icount icount; /* kernel counters for 4 input interrupts */
+	int timeout;
+
+	int read_status_mask;
+	int ignore_status_mask;
+	int xmit_fifo_size;
 	unsigned char *xmit_buf;
 	int xmit_head;
 	int xmit_tail;
 	int xmit_cnt;
-	struct work_struct tqueue;
+
 	struct termios normal_termios;
 	struct termios callout_termios;
+
+	struct mxser_mon mon_data;
+
+	spinlock_t slock;
+	struct work_struct tqueue;
 	wait_queue_head_t open_wait;
 	wait_queue_head_t close_wait;
 	wait_queue_head_t delta_msr_wait;
-	struct async_icount icount;	/* kernel counters for the 4 input interrupts */
-	int timeout;
-	int IsMoxaMustChipFlag;	/* add by Victor Yu. 08-30-2002 */
-	int MaxCanSetBaudRate;	/* add by Victor Yu. 09-04-2002 */
-	unsigned long opmode_ioaddr;	/* add by Victor Yu. 01-05-2004 */
-	unsigned char stop_rx;
-	unsigned char ldisc_stop_rx;
-	long realbaud;
-	struct mxser_mon mon_data;
-	unsigned char err_shadow;
-	spinlock_t slock;
+};
+
+struct mxser_board {
+	struct pci_dev *pdev; /* temporary (until pci probing) */
+
+	int irq;
+	int board_type;
+	unsigned int nports;
+	unsigned long vector;
+	unsigned long vector_mask;
+
+	int chip_flag;
+	int uart_type;
+
+	struct mxser_port ports[MXSER_PORTS_PER_BOARD];
 };
 
 struct mxser_mstatus {
@@ -381,8 +375,8 @@ static int mxserBoardCAP[MXSER_BOARDS] =
 	/*  0x180, 0x280, 0x200, 0x320 */
 };
 
+static struct mxser_board mxser_boards[MXSER_BOARDS];
 static struct tty_driver *mxvar_sdriver;
-static struct mxser_struct mxvar_table[MXSER_PORTS];
 static struct tty_struct *mxvar_tty[MXSER_PORTS + 1];
 static struct termios *mxvar_termios[MXSER_PORTS + 1];
 static struct termios *mxvar_termios_locked[MXSER_PORTS + 1];
@@ -394,21 +388,13 @@ static int mxser_set_baud_method[MXSER_P
 static spinlock_t gm_lock;
 
 /*
- * This is used to figure out the divisor speeds and the timeouts
- */
-
-static struct mxser_hwconf mxsercfg[MXSER_BOARDS];
-
-/*
  * static functions:
  */
 
-static void mxser_getcfg(int board, struct mxser_hwconf *hwconf);
 static int mxser_init(void);
 
 /* static void   mxser_poll(unsigned long); */
-static int mxser_get_ISA_conf(int, struct mxser_hwconf *);
-static int mxser_get_PCI_conf(int, int, int, struct mxser_hwconf *);
+static int mxser_get_ISA_conf(int, struct mxser_board *);
 static void mxser_do_softint(void *);
 static int mxser_open(struct tty_struct *, struct file *);
 static void mxser_close(struct tty_struct *, struct file *);
@@ -428,24 +414,28 @@ static void mxser_start(struct tty_struc
 static void mxser_hangup(struct tty_struct *);
 static void mxser_rs_break(struct tty_struct *, int);
 static irqreturn_t mxser_interrupt(int, void *, struct pt_regs *);
-static void mxser_receive_chars(struct mxser_struct *, int *);
-static void mxser_transmit_chars(struct mxser_struct *);
-static void mxser_check_modem_status(struct mxser_struct *, int);
-static int mxser_block_til_ready(struct tty_struct *, struct file *, struct mxser_struct *);
-static int mxser_startup(struct mxser_struct *);
-static void mxser_shutdown(struct mxser_struct *);
-static int mxser_change_speed(struct mxser_struct *, struct termios *old_termios);
-static int mxser_get_serial_info(struct mxser_struct *, struct serial_struct __user *);
-static int mxser_set_serial_info(struct mxser_struct *, struct serial_struct __user *);
-static int mxser_get_lsr_info(struct mxser_struct *, unsigned int __user *);
-static void mxser_send_break(struct mxser_struct *, int);
+static void mxser_receive_chars(struct mxser_port *, int *);
+static void mxser_transmit_chars(struct mxser_port *);
+static void mxser_check_modem_status(struct mxser_port *, int);
+static int mxser_block_til_ready(struct tty_struct *, struct file *,
+		struct mxser_port *);
+static int mxser_startup(struct mxser_port *);
+static void mxser_shutdown(struct mxser_port *);
+static int mxser_change_speed(struct mxser_port *, struct termios *);
+static int mxser_get_serial_info(struct mxser_port *,
+		struct serial_struct __user *);
+static int mxser_set_serial_info(struct mxser_port *,
+		struct serial_struct __user *);
+static int mxser_get_lsr_info(struct mxser_port *, unsigned int __user *);
+static void mxser_send_break(struct mxser_port *, int);
 static int mxser_tiocmget(struct tty_struct *, struct file *);
-static int mxser_tiocmset(struct tty_struct *, struct file *, unsigned int, unsigned int);
-static int mxser_set_baud(struct mxser_struct *info, long newspd);
-static void mxser_wait_until_sent(struct tty_struct *tty, int timeout);
+static int mxser_tiocmset(struct tty_struct *, struct file *, unsigned int,
+		unsigned int);
+static int mxser_set_baud(struct mxser_port *, long);
+static void mxser_wait_until_sent(struct tty_struct *, int);
 
-static void mxser_startrx(struct tty_struct *tty);
-static void mxser_stoprx(struct tty_struct *tty);
+static void mxser_startrx(struct tty_struct *);
+static void mxser_stoprx(struct tty_struct *);
 
 
 static int CheckIsMoxaMust(int io)
@@ -527,17 +517,17 @@ static void __exit mxser_module_exit(voi
 	for (i = 0; i < MXSER_BOARDS; i++) {
 		struct pci_dev *pdev;
 
-		if (mxsercfg[i].board_type == -1)
+		if (mxser_boards[i].board_type == -1)
 			continue;
 		else {
-			pdev = mxsercfg[i].pciInfo.pdev;
-			free_irq(mxsercfg[i].irq, &mxvar_table[i * MXSER_PORTS_PER_BOARD]);
+			pdev = mxser_boards[i].pdev;
+			free_irq(mxser_boards[i].irq, &mxser_boards[i]);
 			if (pdev != NULL) {	/* PCI */
 				release_region(pci_resource_start(pdev, 2), pci_resource_len(pdev, 2));
 				release_region(pci_resource_start(pdev, 3), pci_resource_len(pdev, 3));
 			} else {
-				release_region(mxsercfg[i].ioaddr[0], 8 * mxsercfg[i].ports);
-				release_region(mxsercfg[i].vector, 1);
+				release_region(mxser_boards[i].ports[0].ioaddr, 8 * mxser_boards[i].nports);
+				release_region(mxser_boards[i].vector, 1);
 			}
 		}
 	}
@@ -545,7 +535,7 @@ static void __exit mxser_module_exit(voi
 		printk(KERN_DEBUG "Done.\n");
 }
 
-static void process_txrx_fifo(struct mxser_struct *info)
+static void process_txrx_fifo(struct mxser_port *info)
 {
 	int i;
 
@@ -554,60 +544,44 @@ static void process_txrx_fifo(struct mxs
 		info->rx_high_water = 1;
 		info->rx_low_water = 1;
 		info->xmit_fifo_size = 1;
-	} else {
-		for (i = 0; i < UART_INFO_NUM; i++) {
-			if (info->IsMoxaMustChipFlag == Gpci_uart_info[i].type) {
+	} else
+		for (i = 0; i < UART_INFO_NUM; i++)
+			if (info->board->chip_flag == Gpci_uart_info[i].type) {
 				info->rx_trigger = Gpci_uart_info[i].rx_trigger;
 				info->rx_low_water = Gpci_uart_info[i].rx_low_water;
 				info->rx_high_water = Gpci_uart_info[i].rx_high_water;
 				info->xmit_fifo_size = Gpci_uart_info[i].xmit_fifo_size;
 				break;
 			}
-		}
-	}
 }
 
-static int mxser_initbrd(int board, struct mxser_hwconf *hwconf)
+static int mxser_initbrd(struct mxser_board *brd)
 {
-	struct mxser_struct *info;
+	struct mxser_port *info;
+	unsigned int i;
 	int retval;
-	int i, n;
 
-	n = board * MXSER_PORTS_PER_BOARD;
-	info = &mxvar_table[n];
 	/*if (verbose) */  {
-		printk(KERN_DEBUG "        ttyM%d - ttyM%d ",
-			n, n + hwconf->ports - 1);
 		printk(" max. baud rate = %d bps.\n",
-			hwconf->MaxCanSetBaudRate[0]);
+			brd->ports[0].max_baud);
 	}
 
-	for (i = 0; i < hwconf->ports; i++, n++, info++) {
-		info->port = n;
-		info->base = hwconf->ioaddr[i];
-		info->irq = hwconf->irq;
-		info->vector = hwconf->vector;
-		info->vectormask = hwconf->vector_mask;
-		info->opmode_ioaddr = hwconf->opmode_ioaddr[i];	/* add by Victor Yu. 01-05-2004 */
+	for (i = 0; i < brd->nports; i++) {
+		info = &brd->ports[i];
+		info->board = brd;
 		info->stop_rx = 0;
 		info->ldisc_stop_rx = 0;
 
-		info->IsMoxaMustChipFlag = hwconf->IsMoxaMustChipFlag;
 		/* Enhance mode enabled here */
-		if (info->IsMoxaMustChipFlag != MOXA_OTHER_UART) {
-			ENABLE_MOXA_MUST_ENCHANCE_MODE(info->base);
-		}
+		if (brd->chip_flag != MOXA_OTHER_UART)
+			ENABLE_MOXA_MUST_ENCHANCE_MODE(info->ioaddr);
 
 		info->flags = ASYNC_SHARE_IRQ;
-		info->type = hwconf->uart_type;
-		info->baud_base = hwconf->baud_base[i];
-
-		info->MaxCanSetBaudRate = hwconf->MaxCanSetBaudRate[i];
+		info->type = brd->uart_type;
 
 		process_txrx_fifo(info);
 
-
-		info->custom_divisor = hwconf->baud_base[i] * 16;
+		info->custom_divisor = info->baud_base * 16;
 		info->close_delay = 5 * HZ / 10;
 		info->closing_wait = 30 * HZ;
 		INIT_WORK(&info->tqueue, mxser_do_softint, info);
@@ -618,118 +592,102 @@ static int mxser_initbrd(int board, stru
 		memset(&info->mon_data, 0, sizeof(struct mxser_mon));
 		info->err_shadow = 0;
 		spin_lock_init(&info->slock);
+
+		/* before set INT ISR, disable all int */
+		outb(inb(info->ioaddr + UART_IER) & 0xf0,
+			info->ioaddr + UART_IER);
 	}
 	/*
 	 * Allocate the IRQ if necessary
 	 */
 
-
-	/* before set INT ISR, disable all int */
-	for (i = 0; i < hwconf->ports; i++) {
-		outb(inb(hwconf->ioaddr[i] + UART_IER) & 0xf0,
-			hwconf->ioaddr[i] + UART_IER);
-	}
-
-	n = board * MXSER_PORTS_PER_BOARD;
-	info = &mxvar_table[n];
-
-	retval = request_irq(hwconf->irq, mxser_interrupt, IRQ_T(info),
-				"mxser", info);
+	retval = request_irq(brd->irq, mxser_interrupt,
+			(brd->ports[0].flags & ASYNC_SHARE_IRQ) ? IRQF_SHARED :
+			IRQF_DISABLED, "mxser", brd);
 	if (retval) {
-		printk(KERN_ERR "Board %d: %s",
-			board, mxser_brdname[hwconf->board_type - 1]);
-		printk("  Request irq failed, IRQ (%d) may conflict with"
-			" another device.\n", info->irq);
+		printk(KERN_ERR "Board %s: Request irq failed, IRQ (%d) may "
+			"conflict with another device.\n",
+			mxser_brdname[brd->board_type - 1], brd->irq);
 		return retval;
 	}
 	return 0;
 }
 
-static void mxser_getcfg(int board, struct mxser_hwconf *hwconf)
-{
-	mxsercfg[board] = *hwconf;
-}
-
-#ifdef CONFIG_PCI
-static int mxser_get_PCI_conf(int busnum, int devnum, int board_type, struct mxser_hwconf *hwconf)
+static int mxser_get_PCI_conf(int board_type, struct mxser_board *brd,
+		struct pci_dev *pdev)
 {
-	int i, j;
-	/* unsigned int val; */
+	unsigned int i, j;
 	unsigned long ioaddress;
-	struct pci_dev *pdev = hwconf->pciInfo.pdev;
 
 	/* io address */
-	hwconf->board_type = board_type;
-	hwconf->ports = mxser_numports[board_type - 1];
+	brd->board_type = board_type;
+	brd->nports = mxser_numports[board_type - 1];
 	ioaddress = pci_resource_start(pdev, 2);
 	request_region(pci_resource_start(pdev, 2), pci_resource_len(pdev, 2),
 			"mxser(IO)");
 
-	for (i = 0; i < hwconf->ports; i++)
-		hwconf->ioaddr[i] = ioaddress + 8 * i;
+	for (i = 0; i < brd->nports; i++)
+		brd->ports[i].ioaddr = ioaddress + 8 * i;
 
 	/* vector */
 	ioaddress = pci_resource_start(pdev, 3);
 	request_region(pci_resource_start(pdev, 3), pci_resource_len(pdev, 3),
 			"mxser(vector)");
-	hwconf->vector = ioaddress;
+	brd->vector = ioaddress;
 
 	/* irq */
-	hwconf->irq = hwconf->pciInfo.pdev->irq;
+	brd->irq = pdev->irq;
 
-	hwconf->IsMoxaMustChipFlag = CheckIsMoxaMust(hwconf->ioaddr[0]);
-	hwconf->uart_type = PORT_16550A;
-	hwconf->vector_mask = 0;
+	brd->chip_flag = CheckIsMoxaMust(brd->ports[0].ioaddr);
+	brd->uart_type = PORT_16550A;
+	brd->vector_mask = 0;
 
-
-	for (i = 0; i < hwconf->ports; i++) {
+	for (i = 0; i < brd->nports; i++) {
 		for (j = 0; j < UART_INFO_NUM; j++) {
-			if (Gpci_uart_info[j].type == hwconf->IsMoxaMustChipFlag) {
-				hwconf->MaxCanSetBaudRate[i] = Gpci_uart_info[j].max_baud;
+			if (Gpci_uart_info[j].type == brd->chip_flag) {
+				brd->ports[i].max_baud =
+					Gpci_uart_info[j].max_baud;
 
 				/* exception....CP-102 */
 				if (board_type == MXSER_BOARD_CP102)
-					hwconf->MaxCanSetBaudRate[i] = 921600;
+					brd->ports[i].max_baud = 921600;
 				break;
 			}
 		}
 	}
 
-	if (hwconf->IsMoxaMustChipFlag == MOXA_MUST_MU860_HWID) {
-		for (i = 0; i < hwconf->ports; i++) {
+	if (brd->chip_flag == MOXA_MUST_MU860_HWID) {
+		for (i = 0; i < brd->nports; i++) {
 			if (i < 4)
-				hwconf->opmode_ioaddr[i] = ioaddress + 4;
+				brd->ports[i].opmode_ioaddr = ioaddress + 4;
 			else
-				hwconf->opmode_ioaddr[i] = ioaddress + 0x0c;
+				brd->ports[i].opmode_ioaddr = ioaddress + 0x0c;
 		}
 		outb(0, ioaddress + 4);	/* default set to RS232 mode */
 		outb(0, ioaddress + 0x0c);	/* default set to RS232 mode */
 	}
 
-	for (i = 0; i < hwconf->ports; i++) {
-		hwconf->vector_mask |= (1 << i);
-		hwconf->baud_base[i] = 921600;
+	for (i = 0; i < brd->nports; i++) {
+		brd->vector_mask |= (1 << i);
+		brd->ports[i].baud_base = 921600;
 	}
 	return 0;
 }
-#endif
 
 static int mxser_init(void)
 {
-	int i, m, retval, b, n;
 	struct pci_dev *pdev = NULL;
-	int index;
-	unsigned char busnum, devnum;
-	struct mxser_hwconf hwconf;
+	struct mxser_board *brd;
+	unsigned int i, m;
+	int retval, b, n;
 
 	mxvar_sdriver = alloc_tty_driver(MXSER_PORTS + 1);
 	if (!mxvar_sdriver)
 		return -ENOMEM;
 	spin_lock_init(&gm_lock);
 
-	for (i = 0; i < MXSER_BOARDS; i++) {
-		mxsercfg[i].board_type = -1;
-	}
+	for (i = 0; i < MXSER_BOARDS; i++)
+		mxser_boards[i].board_type = -1;
 
 	printk(KERN_INFO "MOXA Smartio/Industio family driver version %s\n",
 		MXSER_VERSION);
@@ -752,13 +710,12 @@ static int mxser_init(void)
 	mxvar_sdriver->termios_locked = mxvar_termios_locked;
 
 	mxvar_diagflag = 0;
-	memset(mxvar_table, 0, MXSER_PORTS * sizeof(struct mxser_struct));
+	memset(mxser_boards, 0, sizeof(mxser_boards));
 	memset(&mxvar_log, 0, sizeof(struct mxser_log));
 
 	memset(&mxser_msr, 0, sizeof(unsigned char) * (MXSER_PORTS + 1));
 	memset(&mon_data_ext, 0, sizeof(struct mxser_mon_ext));
 	memset(&mxser_set_baud_method, 0, sizeof(int) * (MXSER_PORTS + 1));
-	memset(&hwconf, 0, sizeof(struct mxser_hwconf));
 
 	m = 0;
 	/* Start finding ISA boards here */
@@ -768,11 +725,12 @@ static int mxser_init(void)
 		if (!(cap = mxserBoardCAP[b]))
 			continue;
 
-		retval = mxser_get_ISA_conf(cap, &hwconf);
+		brd = &mxser_boards[m];
+		retval = mxser_get_ISA_conf(cap, brd);
 
 		if (retval != 0)
 			printk(KERN_INFO "Found MOXA %s board (CAP=0x%x)\n",
-				mxser_brdname[hwconf.board_type - 1], ioaddr[b]);
+				mxser_brdname[brd->board_type - 1], ioaddr[b]);
 
 		if (retval <= 0) {
 			if (retval == MXSER_ERR_IRQ)
@@ -791,17 +749,10 @@ static int mxser_init(void)
 			continue;
 		}
 
-		hwconf.pciInfo.busNum = 0;
-		hwconf.pciInfo.devNum = 0;
-		hwconf.pciInfo.pdev = NULL;
+		brd->pdev = NULL;
 
-		mxser_getcfg(m, &hwconf);
-		/*
-		 * init mxsercfg first,
-		 * or mxsercfg data is not correct on ISR.
-		 */
 		/* mxser_initbrd will hook ISR. */
-		if (mxser_initbrd(m, &hwconf) < 0)
+		if (mxser_initbrd(brd) < 0)
 			continue;
 
 		m++;
@@ -814,11 +765,12 @@ static int mxser_init(void)
 		if (!(cap = ioaddr[b]))
 			continue;
 
-		retval = mxser_get_ISA_conf(cap, &hwconf);
+		brd = &mxser_boards[m];
+		retval = mxser_get_ISA_conf(cap, &mxser_boards[m]);
 
 		if (retval != 0)
 			printk(KERN_INFO "Found MOXA %s board (CAP=0x%x)\n",
-				mxser_brdname[hwconf.board_type - 1], ioaddr[b]);
+				mxser_brdname[brd->board_type - 1], ioaddr[b]);
 
 		if (retval <= 0) {
 			if (retval == MXSER_ERR_IRQ)
@@ -837,41 +789,29 @@ static int mxser_init(void)
 			continue;
 		}
 
-		hwconf.pciInfo.busNum = 0;
-		hwconf.pciInfo.devNum = 0;
-		hwconf.pciInfo.pdev = NULL;
+		brd->pdev = NULL;
 
-		mxser_getcfg(m, &hwconf);
-		/*
-		 * init mxsercfg first,
-		 * or mxsercfg data is not correct on ISR.
-		 */
 		/* mxser_initbrd will hook ISR. */
-		if (mxser_initbrd(m, &hwconf) < 0)
+		if (mxser_initbrd(brd) < 0)
 			continue;
 
 		m++;
 	}
 
 	/* start finding PCI board here */
-#ifdef CONFIG_PCI
 	n = ARRAY_SIZE(mxser_pcibrds) - 1;
-	index = 0;
 	b = 0;
 	while (b < n) {
 		pdev = pci_find_device(mxser_pcibrds[b].vendor,
 				mxser_pcibrds[b].device, pdev);
-			if (pdev == NULL) {
+		if (pdev == NULL) {
 			b++;
 			continue;
 		}
-		hwconf.pciInfo.busNum = busnum = pdev->bus->number;
-		hwconf.pciInfo.devNum = devnum = PCI_SLOT(pdev->devfn) << 3;
-		hwconf.pciInfo.pdev = pdev;
 		printk(KERN_INFO "Found MOXA %s board(BusNo=%d,DevNo=%d)\n",
 			mxser_brdname[(int) (mxser_pcibrds[b].driver_data) - 1],
-			busnum, devnum >> 3);
-		index++;
+			pdev->bus->number, PCI_SLOT(pdev->devfn));
+
 		if (m >= MXSER_BOARDS)
 			printk(KERN_ERR
 				"Too many Smartio/Industio family boards find "
@@ -883,9 +823,11 @@ #ifdef CONFIG_PCI
 					"fail !\n");
 				continue;
 			}
-			retval = mxser_get_PCI_conf(busnum, devnum,
+			brd = &mxser_boards[m];
+			brd->pdev = pdev;
+			retval = mxser_get_PCI_conf(
 					(int)mxser_pcibrds[b].driver_data,
-					&hwconf);
+					brd, pdev);
 			if (retval < 0) {
 				if (retval == MXSER_ERR_IRQ)
 					printk(KERN_ERR
@@ -905,17 +847,12 @@ #ifdef CONFIG_PCI
 						"board not configured\n");
 				continue;
 			}
-			mxser_getcfg(m, &hwconf);
-			/* init mxsercfg first,
-			 * or mxsercfg data is not correct on ISR.
-			 */
 			/* mxser_initbrd will hook ISR. */
-			if (mxser_initbrd(m, &hwconf) < 0)
+			if (mxser_initbrd(brd) < 0)
 				continue;
 			m++;
 		}
 	}
-#endif
 
 	retval = tty_register_driver(mxvar_sdriver);
 	if (retval) {
@@ -924,10 +861,10 @@ #endif
 		put_tty_driver(mxvar_sdriver);
 
 		for (i = 0; i < MXSER_BOARDS; i++) {
-			if (mxsercfg[i].board_type == -1)
+			if (mxser_boards[i].board_type == -1)
 				continue;
 			else {
-				free_irq(mxsercfg[i].irq, &mxvar_table[i * MXSER_PORTS_PER_BOARD]);
+				free_irq(mxser_boards[i].irq, &mxser_boards[i]);
 				/* todo: release io, vector */
 			}
 		}
@@ -939,7 +876,7 @@ #endif
 
 static void mxser_do_softint(void *private_)
 {
-	struct mxser_struct *info = private_;
+	struct mxser_port *info = private_;
 	struct tty_struct *tty;
 
 	tty = info->tty;
@@ -950,7 +887,7 @@ static void mxser_do_softint(void *priva
 		tty_hangup(tty);
 }
 
-static unsigned char mxser_get_msr(int baseaddr, int mode, int port, struct mxser_struct *info)
+static unsigned char mxser_get_msr(int baseaddr, int mode, int port)
 {
 	unsigned char status = 0;
 
@@ -973,7 +910,7 @@ static unsigned char mxser_get_msr(int b
  */
 static int mxser_open(struct tty_struct *tty, struct file *filp)
 {
-	struct mxser_struct *info;
+	struct mxser_port *info;
 	int retval, line;
 
 	/* initialize driver_data in case something fails */
@@ -984,8 +921,8 @@ static int mxser_open(struct tty_struct 
 		return 0;
 	if (line < 0 || line > MXSER_PORTS)
 		return -ENODEV;
-	info = mxvar_table + line;
-	if (!info->base)
+	info = &mxser_boards[line / MXSER_PORTS_PER_BOARD].ports[line % MXSER_PORTS_PER_BOARD];
+	if (!info->ioaddr)
 		return -ENODEV;
 
 	tty->driver_data = info;
@@ -1031,7 +968,7 @@ static int mxser_open(struct tty_struct 
  */
 static void mxser_close(struct tty_struct *tty, struct file *filp)
 {
-	struct mxser_struct *info = tty->driver_data;
+	struct mxser_port *info = tty->driver_data;
 
 	unsigned long timeout;
 	unsigned long flags;
@@ -1062,7 +999,7 @@ static void mxser_close(struct tty_struc
 	}
 	if (--info->count < 0) {
 		printk(KERN_ERR "mxser_close: bad serial port count for "
-			"ttys%d: %d\n", info->port, info->count);
+			"ttys%d: %d\n", tty->index, info->count);
 		info->count = 0;
 	}
 	if (info->count) {
@@ -1091,20 +1028,20 @@ static void mxser_close(struct tty_struc
 	 * line status register.
 	 */
 	info->IER &= ~UART_IER_RLSI;
-	if (info->IsMoxaMustChipFlag)
+	if (info->board->chip_flag)
 		info->IER &= ~MOXA_MUST_RECV_ISR;
 /* by William
 	info->read_status_mask &= ~UART_LSR_DR;
 */
 	if (info->flags & ASYNC_INITIALIZED) {
-		outb(info->IER, info->base + UART_IER);
+		outb(info->IER, info->ioaddr + UART_IER);
 		/*
 		 * Before we drop DTR, make sure the UART transmitter
 		 * has completely drained; this is especially
 		 * important if there is a transmit FIFO!
 		 */
 		timeout = jiffies + HZ;
-		while (!(inb(info->base + UART_LSR) & UART_LSR_TEMT)) {
+		while (!(inb(info->ioaddr + UART_LSR) & UART_LSR_TEMT)) {
 			schedule_timeout_interruptible(5);
 			if (time_after(jiffies, timeout))
 				break;
@@ -1139,7 +1076,7 @@ static void mxser_close(struct tty_struc
 static int mxser_write(struct tty_struct *tty, const unsigned char *buf, int count)
 {
 	int c, total = 0;
-	struct mxser_struct *info = tty->driver_data;
+	struct mxser_port *info = tty->driver_data;
 	unsigned long flags;
 
 	if (!info->xmit_buf)
@@ -1167,11 +1104,12 @@ static int mxser_write(struct tty_struct
 			/*&& !(info->IER & UART_IER_THRI)*/) {
 		if (!tty->hw_stopped ||
 				(info->type == PORT_16550A) ||
-				(info->IsMoxaMustChipFlag)) {
+				(info->board->chip_flag)) {
 			spin_lock_irqsave(&info->slock, flags);
-			outb(info->IER & ~UART_IER_THRI, info->base + UART_IER);
+			outb(info->IER & ~UART_IER_THRI, info->ioaddr +
+					UART_IER);
 			info->IER |= UART_IER_THRI;
-			outb(info->IER, info->base + UART_IER);
+			outb(info->IER, info->ioaddr + UART_IER);
 			spin_unlock_irqrestore(&info->slock, flags);
 		}
 	}
@@ -1180,7 +1118,7 @@ static int mxser_write(struct tty_struct
 
 static void mxser_put_char(struct tty_struct *tty, unsigned char ch)
 {
-	struct mxser_struct *info = tty->driver_data;
+	struct mxser_port *info = tty->driver_data;
 	unsigned long flags;
 
 	if (!info->xmit_buf)
@@ -1197,11 +1135,11 @@ static void mxser_put_char(struct tty_st
 	if (!tty->stopped /*&& !(info->IER & UART_IER_THRI)*/) {
 		if (!tty->hw_stopped ||
 				(info->type == PORT_16550A) ||
-				info->IsMoxaMustChipFlag) {
+				info->board->chip_flag) {
 			spin_lock_irqsave(&info->slock, flags);
-			outb(info->IER & ~UART_IER_THRI, info->base + UART_IER);
+			outb(info->IER & ~UART_IER_THRI, info->ioaddr + UART_IER);
 			info->IER |= UART_IER_THRI;
-			outb(info->IER, info->base + UART_IER);
+			outb(info->IER, info->ioaddr + UART_IER);
 			spin_unlock_irqrestore(&info->slock, flags);
 		}
 	}
@@ -1210,7 +1148,7 @@ static void mxser_put_char(struct tty_st
 
 static void mxser_flush_chars(struct tty_struct *tty)
 {
-	struct mxser_struct *info = tty->driver_data;
+	struct mxser_port *info = tty->driver_data;
 	unsigned long flags;
 
 	if (info->xmit_cnt <= 0 ||
@@ -1218,22 +1156,22 @@ static void mxser_flush_chars(struct tty
 			!info->xmit_buf ||
 			(tty->hw_stopped &&
 			 (info->type != PORT_16550A) &&
-			 (!info->IsMoxaMustChipFlag)
+			 (!info->board->chip_flag)
 			))
 		return;
 
 	spin_lock_irqsave(&info->slock, flags);
 
-	outb(info->IER & ~UART_IER_THRI, info->base + UART_IER);
+	outb(info->IER & ~UART_IER_THRI, info->ioaddr + UART_IER);
 	info->IER |= UART_IER_THRI;
-	outb(info->IER, info->base + UART_IER);
+	outb(info->IER, info->ioaddr + UART_IER);
 
 	spin_unlock_irqrestore(&info->slock, flags);
 }
 
 static int mxser_write_room(struct tty_struct *tty)
 {
-	struct mxser_struct *info = tty->driver_data;
+	struct mxser_port *info = tty->driver_data;
 	int ret;
 
 	ret = SERIAL_XMIT_SIZE - info->xmit_cnt - 1;
@@ -1244,10 +1182,10 @@ static int mxser_write_room(struct tty_s
 
 static int mxser_chars_in_buffer(struct tty_struct *tty)
 {
-	struct mxser_struct *info = tty->driver_data;
+	struct mxser_port *info = tty->driver_data;
 	int len = info->xmit_cnt;
 
-	if (!(inb(info->base + UART_LSR) & UART_LSR_THRE))
+	if (!(inb(info->ioaddr + UART_LSR) & UART_LSR_THRE))
 		len++;
 
 	return len;
@@ -1255,7 +1193,7 @@ static int mxser_chars_in_buffer(struct 
 
 static void mxser_flush_buffer(struct tty_struct *tty)
 {
-	struct mxser_struct *info = tty->driver_data;
+	struct mxser_port *info = tty->driver_data;
 	char fcr;
 	unsigned long flags;
 
@@ -1264,10 +1202,10 @@ static void mxser_flush_buffer(struct tt
 	info->xmit_cnt = info->xmit_head = info->xmit_tail = 0;
 
 	/* below added by shinhay */
-	fcr = inb(info->base + UART_FCR);
+	fcr = inb(info->ioaddr + UART_FCR);
 	outb((fcr | UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT),
-		info->base + UART_FCR);
-	outb(fcr, info->base + UART_FCR);
+		info->ioaddr + UART_FCR);
+	outb(fcr, info->ioaddr + UART_FCR);
 
 	spin_unlock_irqrestore(&info->slock, flags);
 	/* above added by shinhay */
@@ -1279,7 +1217,7 @@ static void mxser_flush_buffer(struct tt
 
 static int mxser_ioctl(struct tty_struct *tty, struct file *file, unsigned int cmd, unsigned long arg)
 {
-	struct mxser_struct *info = tty->driver_data;
+	struct mxser_port *info = tty->driver_data;
 	int retval;
 	struct async_icount cprev, cnow;	/* kernel counter temps */
 	struct serial_icounter_struct __user *p_cuser;
@@ -1298,7 +1236,7 @@ static int mxser_ioctl(struct tty_struct
 		int shiftbit;
 		unsigned char val, mask;
 
-		p = info->port % 4;
+		p = tty->index % 4;
 		if (cmd == MOXA_SET_OP_MODE) {
 			if (get_user(opmode, (int __user *) argp))
 				return -EFAULT;
@@ -1458,7 +1396,7 @@ static int mxser_ioctl(struct tty_struct
 
 			len = mxser_chars_in_buffer(tty);
 
-			lsr = inb(info->base + UART_LSR) & UART_LSR_TEMT;
+			lsr = inb(info->ioaddr + UART_LSR) & UART_LSR_TEMT;
 
 			len += (lsr ? 0 : 1);
 
@@ -1472,10 +1410,10 @@ static int mxser_ioctl(struct tty_struct
 
 			/* info->mon_data.ser_param = tty->termios->c_cflag; */
 
-			status = mxser_get_msr(info->base, 1, info->port, info);
+			status = mxser_get_msr(info->ioaddr, 1, tty->index);
 			mxser_check_modem_status(info, status);
 
-			mcr = inb(info->base + UART_MCR);
+			mcr = inb(info->ioaddr + UART_MCR);
 			if (mcr & MOXA_MUST_MCR_XON_FLAG)
 				info->mon_data.hold_reason &= ~NPPI_NOTIFY_XOFFHOLD;
 			else
@@ -1511,7 +1449,7 @@ static int mxser_ioctl(struct tty_struct
 
 			if (get_user(method, (int __user *)argp))
 				return -EFAULT;
-			mxser_set_baud_method[info->port] = method;
+			mxser_set_baud_method[tty->index] = method;
 			if (copy_to_user(argp, &method, sizeof(int)))
 				return -EFAULT;
 
@@ -1529,14 +1467,17 @@ #endif
 
 static int mxser_ioctl_special(unsigned int cmd, void __user *argp)
 {
-	int i, result, status;
+	struct mxser_port *port;
+	int result, status;
+	unsigned int i, j;
 
 	switch (cmd) {
 	case MOXA_GET_CONF:
-		if (copy_to_user(argp, mxsercfg,
+/*		if (copy_to_user(argp, mxsercfg,
 				sizeof(struct mxser_hwconf) * 4))
 			return -EFAULT;
-		return 0;
+		return 0;*/
+		return -ENXIO;
 	case MOXA_GET_MAJOR:
 		if (copy_to_user(argp, &ttymajor, sizeof(int)))
 			return -EFAULT;
@@ -1549,96 +1490,106 @@ static int mxser_ioctl_special(unsigned 
 
 	case MOXA_CHKPORTENABLE:
 		result = 0;
-		for (i = 0; i < MXSER_PORTS; i++) {
-			if (mxvar_table[i].base)
-				result |= (1 << i);
-		}
+
+		for (i = 0; i < MXSER_BOARDS; i++)
+			for (j = 0; j < MXSER_PORTS_PER_BOARD; j++)
+				if (mxser_boards[i].ports[j].ioaddr)
+					result |= (1 << i);
+
 		return put_user(result, (unsigned long __user *)argp);
 	case MOXA_GETDATACOUNT:
 		if (copy_to_user(argp, &mxvar_log, sizeof(mxvar_log)))
 			return -EFAULT;
 		return 0;
 	case MOXA_GETMSTATUS:
-		for (i = 0; i < MXSER_PORTS; i++) {
-			GMStatus[i].ri = 0;
-			if (!mxvar_table[i].base) {
-				GMStatus[i].dcd = 0;
-				GMStatus[i].dsr = 0;
-				GMStatus[i].cts = 0;
-				continue;
-			}
+		for (i = 0; i < MXSER_BOARDS; i++)
+			for (j = 0; j < MXSER_PORTS_PER_BOARD; j++) {
+				port = &mxser_boards[i].ports[j];
+
+				GMStatus[i].ri = 0;
+				if (!port->ioaddr) {
+					GMStatus[i].dcd = 0;
+					GMStatus[i].dsr = 0;
+					GMStatus[i].cts = 0;
+					continue;
+				}
 
-			if (!mxvar_table[i].tty || !mxvar_table[i].tty->termios)
-				GMStatus[i].cflag = mxvar_table[i].normal_termios.c_cflag;
-			else
-				GMStatus[i].cflag = mxvar_table[i].tty->termios->c_cflag;
+				if (!port->tty || !port->tty->termios)
+					GMStatus[i].cflag =
+						port->normal_termios.c_cflag;
+				else
+					GMStatus[i].cflag =
+						port->tty->termios->c_cflag;
 
-			status = inb(mxvar_table[i].base + UART_MSR);
-			if (status & 0x80 /*UART_MSR_DCD */ )
-				GMStatus[i].dcd = 1;
-			else
-				GMStatus[i].dcd = 0;
+				status = inb(port->ioaddr + UART_MSR);
+				if (status & 0x80 /*UART_MSR_DCD */ )
+					GMStatus[i].dcd = 1;
+				else
+					GMStatus[i].dcd = 0;
 
-			if (status & 0x20 /*UART_MSR_DSR */ )
-				GMStatus[i].dsr = 1;
-			else
-				GMStatus[i].dsr = 0;
+				if (status & 0x20 /*UART_MSR_DSR */ )
+					GMStatus[i].dsr = 1;
+				else
+					GMStatus[i].dsr = 0;
 
 
-			if (status & 0x10 /*UART_MSR_CTS */ )
-				GMStatus[i].cts = 1;
-			else
-				GMStatus[i].cts = 0;
-		}
+				if (status & 0x10 /*UART_MSR_CTS */ )
+					GMStatus[i].cts = 1;
+				else
+					GMStatus[i].cts = 0;
+			}
 		if (copy_to_user(argp, GMStatus,
 				sizeof(struct mxser_mstatus) * MXSER_PORTS))
 			return -EFAULT;
 		return 0;
 	case MOXA_ASPP_MON_EXT: {
-			int status, p, shiftbit;
-			unsigned long opmode;
-			unsigned cflag, iflag;
+		int status, p, shiftbit;
+		unsigned long opmode;
+		unsigned cflag, iflag;
 
-			for (i = 0; i < MXSER_PORTS; i++) {
-				if (!mxvar_table[i].base)
+		for (i = 0; i < MXSER_BOARDS; i++)
+			for (j = 0; j < MXSER_PORTS_PER_BOARD; j++) {
+				port = &mxser_boards[i].ports[j];
+				if (!port->ioaddr)
 					continue;
 
-				status = mxser_get_msr(mxvar_table[i].base, 0,
-							i, &(mxvar_table[i]));
-				/*
-				mxser_check_modem_status(&mxvar_table[i],
-								status);
-				*/
+				status = mxser_get_msr(port->ioaddr, 0, i);
+/*				mxser_check_modem_status(port, status); */
+
 				if (status & UART_MSR_TERI)
-					mxvar_table[i].icount.rng++;
+					port->icount.rng++;
 				if (status & UART_MSR_DDSR)
-					mxvar_table[i].icount.dsr++;
+					port->icount.dsr++;
 				if (status & UART_MSR_DDCD)
-					mxvar_table[i].icount.dcd++;
+					port->icount.dcd++;
 				if (status & UART_MSR_DCTS)
-					mxvar_table[i].icount.cts++;
-
-				mxvar_table[i].mon_data.modem_status = status;
-				mon_data_ext.rx_cnt[i] = mxvar_table[i].mon_data.rxcnt;
-				mon_data_ext.tx_cnt[i] = mxvar_table[i].mon_data.txcnt;
-				mon_data_ext.up_rxcnt[i] = mxvar_table[i].mon_data.up_rxcnt;
-				mon_data_ext.up_txcnt[i] = mxvar_table[i].mon_data.up_txcnt;
-				mon_data_ext.modem_status[i] = mxvar_table[i].mon_data.modem_status;
-				mon_data_ext.baudrate[i] = mxvar_table[i].realbaud;
-
-				if (!mxvar_table[i].tty || !mxvar_table[i].tty->termios) {
-					cflag = mxvar_table[i].normal_termios.c_cflag;
-					iflag = mxvar_table[i].normal_termios.c_iflag;
+					port->icount.cts++;
+
+				port->mon_data.modem_status = status;
+				mon_data_ext.rx_cnt[i] = port->mon_data.rxcnt;
+				mon_data_ext.tx_cnt[i] = port->mon_data.txcnt;
+				mon_data_ext.up_rxcnt[i] =
+					port->mon_data.up_rxcnt;
+				mon_data_ext.up_txcnt[i] =
+					port->mon_data.up_txcnt;
+				mon_data_ext.modem_status[i] =
+					port->mon_data.modem_status;
+				mon_data_ext.baudrate[i] = port->realbaud;
+
+				if (!port->tty || !port->tty->termios) {
+					cflag = port->normal_termios.c_cflag;
+					iflag = port->normal_termios.c_iflag;
 				} else {
-					cflag = mxvar_table[i].tty->termios->c_cflag;
-					iflag = mxvar_table[i].tty->termios->c_iflag;
+					cflag = port->tty->termios->c_cflag;
+					iflag = port->tty->termios->c_iflag;
 				}
 
 				mon_data_ext.databits[i] = cflag & CSIZE;
 
 				mon_data_ext.stopbits[i] = cflag & CSTOPB;
 
-				mon_data_ext.parity[i] = cflag & (PARENB | PARODD | CMSPAR);
+				mon_data_ext.parity[i] =
+					cflag & (PARENB | PARODD | CMSPAR);
 
 				mon_data_ext.flowctrl[i] = 0x00;
 
@@ -1648,26 +1599,26 @@ static int mxser_ioctl_special(unsigned 
 				if (iflag & (IXON | IXOFF))
 					mon_data_ext.flowctrl[i] |= 0x0C;
 
-				if (mxvar_table[i].type == PORT_16550A)
+				if (port->type == PORT_16550A)
 					mon_data_ext.fifo[i] = 1;
 				else
 					mon_data_ext.fifo[i] = 0;
 
 				p = i % 4;
 				shiftbit = p * 2;
-				opmode = inb(mxvar_table[i].opmode_ioaddr) >> shiftbit;
+				opmode = inb(port->opmode_ioaddr) >> shiftbit;
 				opmode &= OP_MODE_MASK;
 
 				mon_data_ext.iftype[i] = opmode;
 
 			}
-			if (copy_to_user(argp, &mon_data_ext, sizeof(struct mxser_mon_ext)))
+			if (copy_to_user(argp, &mon_data_ext,
+						sizeof(mon_data_ext)))
 				return -EFAULT;
 
 			return 0;
 
-		}
-	default:
+	} default:
 		return -ENOIOCTLCMD;
 	}
 	return 0;
@@ -1675,31 +1626,31 @@ static int mxser_ioctl_special(unsigned 
 
 static void mxser_stoprx(struct tty_struct *tty)
 {
-	struct mxser_struct *info = tty->driver_data;
+	struct mxser_port *info = tty->driver_data;
 
 	info->ldisc_stop_rx = 1;
 	if (I_IXOFF(tty)) {
 		/* following add by Victor Yu. 09-02-2002 */
-		if (info->IsMoxaMustChipFlag) {
+		if (info->board->chip_flag) {
 			info->IER &= ~MOXA_MUST_RECV_ISR;
-			outb(info->IER, info->base + UART_IER);
+			outb(info->IER, info->ioaddr + UART_IER);
 		} else if (!(info->flags & ASYNC_CLOSING)) {
 			info->x_char = STOP_CHAR(tty);
-			outb(0, info->base + UART_IER);
+			outb(0, info->ioaddr + UART_IER);
 			info->IER |= UART_IER_THRI;
-			outb(info->IER, info->base + UART_IER);
+			outb(info->IER, info->ioaddr + UART_IER);
 		}
 	}
 
 	if (info->tty->termios->c_cflag & CRTSCTS) {
 		info->MCR &= ~UART_MCR_RTS;
-		outb(info->MCR, info->base + UART_MCR);
+		outb(info->MCR, info->ioaddr + UART_MCR);
 	}
 }
 
 static void mxser_startrx(struct tty_struct *tty)
 {
-	struct mxser_struct *info = tty->driver_data;
+	struct mxser_port *info = tty->driver_data;
 
 	info->ldisc_stop_rx = 0;
 	if (I_IXOFF(tty)) {
@@ -1707,21 +1658,21 @@ static void mxser_startrx(struct tty_str
 			info->x_char = 0;
 		else {
 			/* following add by Victor Yu. 09-02-2002 */
-			if (info->IsMoxaMustChipFlag) {
+			if (info->board->chip_flag) {
 				info->IER |= MOXA_MUST_RECV_ISR;
-				outb(info->IER, info->base + UART_IER);
+				outb(info->IER, info->ioaddr + UART_IER);
 			} else if (!(info->flags & ASYNC_CLOSING)) {
 				info->x_char = START_CHAR(tty);
-				outb(0, info->base + UART_IER);
+				outb(0, info->ioaddr + UART_IER);
 				info->IER |= UART_IER_THRI;
-				outb(info->IER, info->base + UART_IER);
+				outb(info->IER, info->ioaddr + UART_IER);
 			}
 		}
 	}
 
 	if (info->tty->termios->c_cflag & CRTSCTS) {
 		info->MCR |= UART_MCR_RTS;
-		outb(info->MCR, info->base + UART_MCR);
+		outb(info->MCR, info->ioaddr + UART_MCR);
 	}
 }
 
@@ -1731,7 +1682,7 @@ static void mxser_startrx(struct tty_str
  */
 static void mxser_throttle(struct tty_struct *tty)
 {
-	struct mxser_struct *info = tty->driver_data;
+	struct mxser_port *info = tty->driver_data;
 	unsigned long flags;
 
 	spin_lock_irqsave(&info->slock, flags);
@@ -1741,7 +1692,7 @@ static void mxser_throttle(struct tty_st
 
 static void mxser_unthrottle(struct tty_struct *tty)
 {
-	struct mxser_struct *info = tty->driver_data;
+	struct mxser_port *info = tty->driver_data;
 	unsigned long flags;
 
 	spin_lock_irqsave(&info->slock, flags);
@@ -1751,7 +1702,7 @@ static void mxser_unthrottle(struct tty_
 
 static void mxser_set_termios(struct tty_struct *tty, struct termios *old_termios)
 {
-	struct mxser_struct *info = tty->driver_data;
+	struct mxser_port *info = tty->driver_data;
 	unsigned long flags;
 
 	if ((tty->termios->c_cflag != old_termios->c_cflag) ||
@@ -1772,9 +1723,9 @@ static void mxser_set_termios(struct tty
 		tty->stopped = 0;
 
 		/* following add by Victor Yu. 09-02-2002 */
-		if (info->IsMoxaMustChipFlag) {
+		if (info->board->chip_flag) {
 			spin_lock_irqsave(&info->slock, flags);
-			DISABLE_MOXA_MUST_RX_SOFTWARE_FLOW_CONTROL(info->base);
+			DISABLE_MOXA_MUST_RX_SOFTWARE_FLOW_CONTROL(info->ioaddr);
 			spin_unlock_irqrestore(&info->slock, flags);
 		}
 		/* above add by Victor Yu. 09-02-2002 */
@@ -1791,28 +1742,28 @@ static void mxser_set_termios(struct tty
  */
 static void mxser_stop(struct tty_struct *tty)
 {
-	struct mxser_struct *info = tty->driver_data;
+	struct mxser_port *info = tty->driver_data;
 	unsigned long flags;
 
 	spin_lock_irqsave(&info->slock, flags);
 	if (info->IER & UART_IER_THRI) {
 		info->IER &= ~UART_IER_THRI;
-		outb(info->IER, info->base + UART_IER);
+		outb(info->IER, info->ioaddr + UART_IER);
 	}
 	spin_unlock_irqrestore(&info->slock, flags);
 }
 
 static void mxser_start(struct tty_struct *tty)
 {
-	struct mxser_struct *info = tty->driver_data;
+	struct mxser_port *info = tty->driver_data;
 	unsigned long flags;
 
 	spin_lock_irqsave(&info->slock, flags);
 	if (info->xmit_cnt && info->xmit_buf
 			/* && !(info->IER & UART_IER_THRI) */) {
-		outb(info->IER & ~UART_IER_THRI, info->base + UART_IER);
+		outb(info->IER & ~UART_IER_THRI, info->ioaddr + UART_IER);
 		info->IER |= UART_IER_THRI;
-		outb(info->IER, info->base + UART_IER);
+		outb(info->IER, info->ioaddr + UART_IER);
 	}
 	spin_unlock_irqrestore(&info->slock, flags);
 }
@@ -1822,7 +1773,7 @@ static void mxser_start(struct tty_struc
  */
 static void mxser_wait_until_sent(struct tty_struct *tty, int timeout)
 {
-	struct mxser_struct *info = tty->driver_data;
+	struct mxser_port *info = tty->driver_data;
 	unsigned long orig_jiffies, char_time;
 	int lsr;
 
@@ -1863,7 +1814,7 @@ #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
 		timeout, char_time);
 	printk("jiff=%lu...", jiffies);
 #endif
-	while (!((lsr = inb(info->base + UART_LSR)) & UART_LSR_TEMT)) {
+	while (!((lsr = inb(info->ioaddr + UART_LSR)) & UART_LSR_TEMT)) {
 #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
 		printk("lsr = %d (jiff=%lu)...", lsr, jiffies);
 #endif
@@ -1886,7 +1837,7 @@ #endif
  */
 void mxser_hangup(struct tty_struct *tty)
 {
-	struct mxser_struct *info = tty->driver_data;
+	struct mxser_port *info = tty->driver_data;
 
 	mxser_flush_buffer(tty);
 	mxser_shutdown(info);
@@ -1904,16 +1855,16 @@ void mxser_hangup(struct tty_struct *tty
  */
 static void mxser_rs_break(struct tty_struct *tty, int break_state)
 {
-	struct mxser_struct *info = tty->driver_data;
+	struct mxser_port *info = tty->driver_data;
 	unsigned long flags;
 
 	spin_lock_irqsave(&info->slock, flags);
 	if (break_state == -1)
-		outb(inb(info->base + UART_LCR) | UART_LCR_SBC,
-			info->base + UART_LCR);
+		outb(inb(info->ioaddr + UART_LCR) | UART_LCR_SBC,
+			info->ioaddr + UART_LCR);
 	else
-		outb(inb(info->base + UART_LCR) & ~UART_LCR_SBC,
-			info->base + UART_LCR);
+		outb(inb(info->ioaddr + UART_LCR) & ~UART_LCR_SBC,
+			info->ioaddr + UART_LCR);
 	spin_unlock_irqrestore(&info->slock, flags);
 }
 
@@ -1926,74 +1877,72 @@ static void mxser_rs_break(struct tty_st
 static irqreturn_t mxser_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	int status, iir, i;
-	struct mxser_struct *info;
-	struct mxser_struct *port;
+	struct mxser_board *brd = NULL;
+	struct mxser_port *port;
 	int max, irqbits, bits, msr;
 	int pass_counter = 0;
 	unsigned int int_cnt;
 	int handled = IRQ_NONE;
 
-	port = NULL;
 	/* spin_lock(&gm_lock); */
 
-	for (i = 0; i < MXSER_BOARDS; i++) {
-		if (dev_id == &(mxvar_table[i * MXSER_PORTS_PER_BOARD])) {
-			port = dev_id;
+	for (i = 0; i < MXSER_BOARDS; i++)
+		if (dev_id == &mxser_boards[i]) {
+			brd = dev_id;
 			break;
 		}
-	}
 
 	if (i == MXSER_BOARDS)
 		goto irq_stop;
-	if (port == 0)
+	if (brd == NULL)
 		goto irq_stop;
-	max = mxser_numports[mxsercfg[i].board_type - 1];
+	max = mxser_numports[brd->board_type - 1];
 	while (1) {
-		irqbits = inb(port->vector) & port->vectormask;
-		if (irqbits == port->vectormask)
+		irqbits = inb(brd->vector) & brd->vector_mask;
+		if (irqbits == brd->vector_mask)
 			break;
 
 		handled = IRQ_HANDLED;
 		for (i = 0, bits = 1; i < max; i++, irqbits |= bits, bits <<= 1) {
-			if (irqbits == port->vectormask)
+			if (irqbits == brd->vector_mask)
 				break;
 			if (bits & irqbits)
 				continue;
-			info = port + i;
+			port = &brd->ports[i];
 
 			int_cnt = 0;
 			do {
 				/* following add by Victor Yu. 09-13-2002 */
-				iir = inb(info->base + UART_IIR);
+				iir = inb(port->ioaddr + UART_IIR);
 				if (iir & UART_IIR_NO_INT)
 					break;
 				iir &= MOXA_MUST_IIR_MASK;
-				if (!info->tty) {
-					status = inb(info->base + UART_LSR);
-					outb(0x27, info->base + UART_FCR);
-					inb(info->base + UART_MSR);
+				if (!port->tty) {
+					status = inb(port->ioaddr + UART_LSR);
+					outb(0x27, port->ioaddr + UART_FCR);
+					inb(port->ioaddr + UART_MSR);
 					break;
 				}
 				/* above add by Victor Yu. 09-13-2002 */
 
-				spin_lock(&info->slock);
+				spin_lock(&port->slock);
 				/* following add by Victor Yu. 09-02-2002 */
-				status = inb(info->base + UART_LSR);
+				status = inb(port->ioaddr + UART_LSR);
 
 				if (status & UART_LSR_PE)
-					info->err_shadow |= NPPI_NOTIFY_PARITY;
+					port->err_shadow |= NPPI_NOTIFY_PARITY;
 				if (status & UART_LSR_FE)
-					info->err_shadow |= NPPI_NOTIFY_FRAMING;
+					port->err_shadow |= NPPI_NOTIFY_FRAMING;
 				if (status & UART_LSR_OE)
-					info->err_shadow |=
+					port->err_shadow |=
 						NPPI_NOTIFY_HW_OVERRUN;
 				if (status & UART_LSR_BI)
-					info->err_shadow |= NPPI_NOTIFY_BREAK;
+					port->err_shadow |= NPPI_NOTIFY_BREAK;
 
-				if (info->IsMoxaMustChipFlag) {
+				if (port->board->chip_flag) {
 					/*
 					   if ( (status & 0x02) && !(status & 0x01) ) {
-					   outb(info->base+UART_FCR,  0x23);
+					   outb(port->ioaddr+UART_FCR,  0x23);
 					   continue;
 					   }
 					 */
@@ -2001,33 +1950,33 @@ static irqreturn_t mxser_interrupt(int i
 					    iir == MOXA_MUST_IIR_RDA ||
 					    iir == MOXA_MUST_IIR_RTO ||
 					    iir == MOXA_MUST_IIR_LSR)
-						mxser_receive_chars(info,
+						mxser_receive_chars(port,
 								&status);
 
 				} else {
 					/* above add by Victor Yu. 09-02-2002 */
 
-					status &= info->read_status_mask;
+					status &= port->read_status_mask;
 					if (status & UART_LSR_DR)
-						mxser_receive_chars(info,
+						mxser_receive_chars(port,
 								&status);
 				}
-				msr = inb(info->base + UART_MSR);
+				msr = inb(port->ioaddr + UART_MSR);
 				if (msr & UART_MSR_ANY_DELTA)
-					mxser_check_modem_status(info, msr);
+					mxser_check_modem_status(port, msr);
 
 				/* following add by Victor Yu. 09-13-2002 */
-				if (info->IsMoxaMustChipFlag) {
+				if (port->board->chip_flag) {
 					if (iir == 0x02 && (status &
 								UART_LSR_THRE))
-						mxser_transmit_chars(info);
+						mxser_transmit_chars(port);
 				} else {
 					/* above add by Victor Yu. 09-13-2002 */
 
 					if (status & UART_LSR_THRE)
-						mxser_transmit_chars(info);
+						mxser_transmit_chars(port);
 				}
-				spin_unlock(&info->slock);
+				spin_unlock(&port->slock);
 			} while (int_cnt++ < MXSER_ISR_PASS_LIMIT);
 		}
 		if (pass_counter++ > MXSER_ISR_PASS_LIMIT)
@@ -2039,9 +1988,9 @@ static irqreturn_t mxser_interrupt(int i
 	return handled;
 }
 
-static void mxser_receive_chars(struct mxser_struct *info, int *status)
+static void mxser_receive_chars(struct mxser_port *port, int *status)
 {
-	struct tty_struct *tty = info->tty;
+	struct tty_struct *tty = port->tty;
 	unsigned char ch, gdl;
 	int ignored = 0;
 	int cnt = 0;
@@ -2049,42 +1998,42 @@ static void mxser_receive_chars(struct m
 	int max = 256;
 	unsigned long flags;
 
-	spin_lock_irqsave(&info->slock, flags);
+	spin_lock_irqsave(&port->slock, flags);
 
 	recv_room = tty->receive_room;
-	if ((recv_room == 0) && (!info->ldisc_stop_rx)) {
+	if ((recv_room == 0) && (!port->ldisc_stop_rx)) {
 		/* mxser_throttle(tty); */
 		mxser_stoprx(tty);
 		/* return; */
 	}
 
 	/* following add by Victor Yu. 09-02-2002 */
-	if (info->IsMoxaMustChipFlag != MOXA_OTHER_UART) {
+	if (port->board->chip_flag != MOXA_OTHER_UART) {
 
 		if (*status & UART_LSR_SPECIAL)
 			goto intr_old;
 		/* following add by Victor Yu. 02-11-2004 */
-		if (info->IsMoxaMustChipFlag == MOXA_MUST_MU860_HWID &&
+		if (port->board->chip_flag == MOXA_MUST_MU860_HWID &&
 				(*status & MOXA_MUST_LSR_RERR))
 			goto intr_old;
 		/* above add by Victor Yu. 02-14-2004 */
 		if (*status & MOXA_MUST_LSR_RERR)
 			goto intr_old;
 
-		gdl = inb(info->base + MOXA_MUST_GDL_REGISTER);
+		gdl = inb(port->ioaddr + MOXA_MUST_GDL_REGISTER);
 
 		/* add by Victor Yu. 02-11-2004 */
-		if (info->IsMoxaMustChipFlag == MOXA_MUST_MU150_HWID)
+		if (port->board->chip_flag == MOXA_MUST_MU150_HWID)
 			gdl &= MOXA_MUST_GDL_MASK;
 		if (gdl >= recv_room) {
-			if (!info->ldisc_stop_rx) {
+			if (!port->ldisc_stop_rx) {
 				/* mxser_throttle(tty); */
 				mxser_stoprx(tty);
 			}
 			/* return; */
 		}
 		while (gdl--) {
-			ch = inb(info->base + UART_RX);
+			ch = inb(port->ioaddr + UART_RX);
 			tty_insert_flip_char(tty, ch, 0);
 			cnt++;
 		}
@@ -2097,14 +2046,14 @@ static void mxser_receive_chars(struct m
 		if (max-- < 0)
 			break;
 
-		ch = inb(info->base + UART_RX);
+		ch = inb(port->ioaddr + UART_RX);
 		/* following add by Victor Yu. 09-02-2002 */
-		if (info->IsMoxaMustChipFlag && (*status & UART_LSR_OE)
+		if (port->board->chip_flag && (*status & UART_LSR_OE)
 				/*&& !(*status&UART_LSR_DR) */)
-			outb(0x23, info->base + UART_FCR);
-		*status &= info->read_status_mask;
+			outb(0x23, port->ioaddr + UART_FCR);
+		*status &= port->read_status_mask;
 		/* above add by Victor Yu. 09-02-2002 */
-		if (*status & info->ignore_status_mask) {
+		if (*status & port->ignore_status_mask) {
 			if (++ignored > 100)
 				break;
 		} else {
@@ -2113,22 +2062,22 @@ static void mxser_receive_chars(struct m
 				if (*status & UART_LSR_BI) {
 					flag = TTY_BREAK;
 /* added by casper 1/11/2000 */
-					info->icount.brk++;
+					port->icount.brk++;
 
-					if (info->flags & ASYNC_SAK)
+					if (port->flags & ASYNC_SAK)
 						do_SAK(tty);
 				} else if (*status & UART_LSR_PE) {
 					flag = TTY_PARITY;
 /* added by casper 1/11/2000 */
-					info->icount.parity++;
+					port->icount.parity++;
 				} else if (*status & UART_LSR_FE) {
 					flag = TTY_FRAME;
 /* added by casper 1/11/2000 */
-					info->icount.frame++;
+					port->icount.frame++;
 				} else if (*status & UART_LSR_OE) {
 					flag = TTY_OVERRUN;
 /* added by casper 1/11/2000 */
-					info->icount.overrun++;
+					port->icount.overrun++;
 				} else
 					flags = TTY_BREAK;
 			} else
@@ -2136,7 +2085,7 @@ static void mxser_receive_chars(struct m
 			tty_insert_flip_char(tty, ch, flag);
 			cnt++;
 			if (cnt >= recv_room) {
-				if (!info->ldisc_stop_rx) {
+				if (!port->ldisc_stop_rx) {
 					/* mxser_throttle(tty); */
 					mxser_stoprx(tty);
 				}
@@ -2146,142 +2095,144 @@ static void mxser_receive_chars(struct m
 		}
 
 		/* following add by Victor Yu. 09-02-2002 */
-		if (info->IsMoxaMustChipFlag)
+		if (port->board->chip_flag)
 			break;
 
 		/* mask by Victor Yu. 09-02-2002
-		 *status = inb(info->base + UART_LSR) & info->read_status_mask;
+		 *status = inb(port->ioaddr + UART_LSR) & port->read_status_mask;
 		 */
 		/* following add by Victor Yu. 09-02-2002 */
-		*status = inb(info->base + UART_LSR);
+		*status = inb(port->ioaddr + UART_LSR);
 		/* above add by Victor Yu. 09-02-2002 */
 	} while (*status & UART_LSR_DR);
 
 end_intr:		/* add by Victor Yu. 09-02-2002 */
-	mxvar_log.rxcnt[info->port] += cnt;
-	info->mon_data.rxcnt += cnt;
-	info->mon_data.up_rxcnt += cnt;
-	spin_unlock_irqrestore(&info->slock, flags);
+	mxvar_log.rxcnt[port->tty->index] += cnt;
+	port->mon_data.rxcnt += cnt;
+	port->mon_data.up_rxcnt += cnt;
+	spin_unlock_irqrestore(&port->slock, flags);
 
 	tty_flip_buffer_push(tty);
 }
 
-static void mxser_transmit_chars(struct mxser_struct *info)
+static void mxser_transmit_chars(struct mxser_port *port)
 {
 	int count, cnt;
 	unsigned long flags;
 
-	spin_lock_irqsave(&info->slock, flags);
+	spin_lock_irqsave(&port->slock, flags);
 
-	if (info->x_char) {
-		outb(info->x_char, info->base + UART_TX);
-		info->x_char = 0;
-		mxvar_log.txcnt[info->port]++;
-		info->mon_data.txcnt++;
-		info->mon_data.up_txcnt++;
+	if (port->x_char) {
+		outb(port->x_char, port->ioaddr + UART_TX);
+		port->x_char = 0;
+		mxvar_log.txcnt[port->tty->index]++;
+		port->mon_data.txcnt++;
+		port->mon_data.up_txcnt++;
 
 /* added by casper 1/11/2000 */
-		info->icount.tx++;
+		port->icount.tx++;
 		goto unlock;
 	}
 
-	if (info->xmit_buf == 0)
+	if (port->xmit_buf == 0)
 		goto unlock;
 
-	if (info->xmit_cnt == 0) {
-		if (info->xmit_cnt < WAKEUP_CHARS) { /* XXX what's this for?? */
-			set_bit(MXSER_EVENT_TXLOW, &info->event);
-			schedule_work(&info->tqueue);
+	if (port->xmit_cnt == 0) {
+		if (port->xmit_cnt < WAKEUP_CHARS) { /* XXX what's this for?? */
+			set_bit(MXSER_EVENT_TXLOW, &port->event);
+			schedule_work(&port->tqueue);
 		}
 		goto unlock;
 	}
-	if (info->tty->stopped || (info->tty->hw_stopped &&
-			(info->type != PORT_16550A) &&
-			(!info->IsMoxaMustChipFlag))) {
-		info->IER &= ~UART_IER_THRI;
-		outb(info->IER, info->base + UART_IER);
+	if (port->tty->stopped || (port->tty->hw_stopped &&
+			(port->type != PORT_16550A) &&
+			(!port->board->chip_flag))) {
+		port->IER &= ~UART_IER_THRI;
+		outb(port->IER, port->ioaddr + UART_IER);
 		goto unlock;
 	}
 
-	cnt = info->xmit_cnt;
-	count = info->xmit_fifo_size;
+	cnt = port->xmit_cnt;
+	count = port->xmit_fifo_size;
 	do {
-		outb(info->xmit_buf[info->xmit_tail++],
-			info->base + UART_TX);
-		info->xmit_tail = info->xmit_tail & (SERIAL_XMIT_SIZE - 1);
-		if (--info->xmit_cnt <= 0)
+		outb(port->xmit_buf[port->xmit_tail++],
+			port->ioaddr + UART_TX);
+		port->xmit_tail = port->xmit_tail & (SERIAL_XMIT_SIZE - 1);
+		if (--port->xmit_cnt <= 0)
 			break;
 	} while (--count > 0);
-	mxvar_log.txcnt[info->port] += (cnt - info->xmit_cnt);
+	mxvar_log.txcnt[port->tty->index] += (cnt - port->xmit_cnt);
 
 /* added by James 03-12-2004. */
-	info->mon_data.txcnt += (cnt - info->xmit_cnt);
-	info->mon_data.up_txcnt += (cnt - info->xmit_cnt);
+	port->mon_data.txcnt += (cnt - port->xmit_cnt);
+	port->mon_data.up_txcnt += (cnt - port->xmit_cnt);
 
 /* added by casper 1/11/2000 */
-	info->icount.tx += (cnt - info->xmit_cnt);
+	port->icount.tx += (cnt - port->xmit_cnt);
 
-	if (info->xmit_cnt < WAKEUP_CHARS) {
-		set_bit(MXSER_EVENT_TXLOW, &info->event);
-		schedule_work(&info->tqueue);
+	if (port->xmit_cnt < WAKEUP_CHARS) {
+		set_bit(MXSER_EVENT_TXLOW, &port->event);
+		schedule_work(&port->tqueue);
 	}
-	if (info->xmit_cnt <= 0) {
-		info->IER &= ~UART_IER_THRI;
-		outb(info->IER, info->base + UART_IER);
+	if (port->xmit_cnt <= 0) {
+		port->IER &= ~UART_IER_THRI;
+		outb(port->IER, port->ioaddr + UART_IER);
 	}
 unlock:
-	spin_unlock_irqrestore(&info->slock, flags);
+	spin_unlock_irqrestore(&port->slock, flags);
 }
 
-static void mxser_check_modem_status(struct mxser_struct *info, int status)
+static void mxser_check_modem_status(struct mxser_port *port, int status)
 {
 	/* update input line counters */
 	if (status & UART_MSR_TERI)
-		info->icount.rng++;
+		port->icount.rng++;
 	if (status & UART_MSR_DDSR)
-		info->icount.dsr++;
+		port->icount.dsr++;
 	if (status & UART_MSR_DDCD)
-		info->icount.dcd++;
+		port->icount.dcd++;
 	if (status & UART_MSR_DCTS)
-		info->icount.cts++;
-	info->mon_data.modem_status = status;
-	wake_up_interruptible(&info->delta_msr_wait);
+		port->icount.cts++;
+	port->mon_data.modem_status = status;
+	wake_up_interruptible(&port->delta_msr_wait);
 
-	if ((info->flags & ASYNC_CHECK_CD) && (status & UART_MSR_DDCD)) {
+	if ((port->flags & ASYNC_CHECK_CD) && (status & UART_MSR_DDCD)) {
 		if (status & UART_MSR_DCD)
-			wake_up_interruptible(&info->open_wait);
-		schedule_work(&info->tqueue);
+			wake_up_interruptible(&port->open_wait);
+		schedule_work(&port->tqueue);
 	}
 
-	if (info->flags & ASYNC_CTS_FLOW) {
-		if (info->tty->hw_stopped) {
+	if (port->flags & ASYNC_CTS_FLOW) {
+		if (port->tty->hw_stopped) {
 			if (status & UART_MSR_CTS) {
-				info->tty->hw_stopped = 0;
-
-				if ((info->type != PORT_16550A) &&
-						(!info->IsMoxaMustChipFlag)) {
-					outb(info->IER & ~UART_IER_THRI,
-							info->base + UART_IER);
-					info->IER |= UART_IER_THRI;
-					outb(info->IER, info->base + UART_IER);
+				port->tty->hw_stopped = 0;
+
+				if ((port->type != PORT_16550A) &&
+						(!port->board->chip_flag)) {
+					outb(port->IER & ~UART_IER_THRI,
+						port->ioaddr + UART_IER);
+					port->IER |= UART_IER_THRI;
+					outb(port->IER, port->ioaddr +
+							UART_IER);
 				}
-				set_bit(MXSER_EVENT_TXLOW, &info->event);
-				schedule_work(&info->tqueue);
+				set_bit(MXSER_EVENT_TXLOW, &port->event);
+				schedule_work(&port->tqueue);
 			}
 		} else {
 			if (!(status & UART_MSR_CTS)) {
-				info->tty->hw_stopped = 1;
-				if (info->type != PORT_16550A &&
-						!info->IsMoxaMustChipFlag) {
-					info->IER &= ~UART_IER_THRI;
-					outb(info->IER, info->base + UART_IER);
+				port->tty->hw_stopped = 1;
+				if (port->type != PORT_16550A &&
+						!port->board->chip_flag) {
+					port->IER &= ~UART_IER_THRI;
+					outb(port->IER, port->ioaddr +
+							UART_IER);
 				}
 			}
 		}
 	}
 }
 
-static int mxser_block_til_ready(struct tty_struct *tty, struct file *filp, struct mxser_struct *info)
+static int mxser_block_til_ready(struct tty_struct *tty, struct file *filp, struct mxser_port *port)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	int retval;
@@ -2293,7 +2244,7 @@ static int mxser_block_til_ready(struct 
 	 * then make the check up front and then exit.
 	 */
 	if ((filp->f_flags & O_NONBLOCK) || (tty->flags & (1 << TTY_IO_ERROR))) {
-		info->flags |= ASYNC_NORMAL_ACTIVE;
+		port->flags |= ASYNC_NORMAL_ACTIVE;
 		return 0;
 	}
 
@@ -2303,34 +2254,34 @@ static int mxser_block_til_ready(struct 
 	/*
 	 * Block waiting for the carrier detect and the line to become
 	 * free (i.e., not in use by the callout).  While we are in
-	 * this loop, info->count is dropped by one, so that
+	 * this loop, port->count is dropped by one, so that
 	 * mxser_close() knows when to free things.  We restore it upon
 	 * exit, either normal or abnormal.
 	 */
 	retval = 0;
-	add_wait_queue(&info->open_wait, &wait);
+	add_wait_queue(&port->open_wait, &wait);
 
-	spin_lock_irqsave(&info->slock, flags);
+	spin_lock_irqsave(&port->slock, flags);
 	if (!tty_hung_up_p(filp))
-		info->count--;
-	spin_unlock_irqrestore(&info->slock, flags);
-	info->blocked_open++;
+		port->count--;
+	spin_unlock_irqrestore(&port->slock, flags);
+	port->blocked_open++;
 	while (1) {
-		spin_lock_irqsave(&info->slock, flags);
-		outb(inb(info->base + UART_MCR) |
-			UART_MCR_DTR | UART_MCR_RTS, info->base + UART_MCR);
-		spin_unlock_irqrestore(&info->slock, flags);
+		spin_lock_irqsave(&port->slock, flags);
+		outb(inb(port->ioaddr + UART_MCR) |
+			UART_MCR_DTR | UART_MCR_RTS, port->ioaddr + UART_MCR);
+		spin_unlock_irqrestore(&port->slock, flags);
 		set_current_state(TASK_INTERRUPTIBLE);
-		if (tty_hung_up_p(filp) || !(info->flags & ASYNC_INITIALIZED)) {
-			if (info->flags & ASYNC_HUP_NOTIFY)
+		if (tty_hung_up_p(filp) || !(port->flags & ASYNC_INITIALIZED)) {
+			if (port->flags & ASYNC_HUP_NOTIFY)
 				retval = -EAGAIN;
 			else
 				retval = -ERESTARTSYS;
 			break;
 		}
-		if (!(info->flags & ASYNC_CLOSING) &&
+		if (!(port->flags & ASYNC_CLOSING) &&
 				(do_clocal ||
-				(inb(info->base + UART_MSR) & UART_MSR_DCD)))
+				(inb(port->ioaddr + UART_MSR) & UART_MSR_DCD)))
 			break;
 		if (signal_pending(current)) {
 			retval = -ERESTARTSYS;
@@ -2339,17 +2290,17 @@ static int mxser_block_til_ready(struct 
 		schedule();
 	}
 	set_current_state(TASK_RUNNING);
-	remove_wait_queue(&info->open_wait, &wait);
+	remove_wait_queue(&port->open_wait, &wait);
 	if (!tty_hung_up_p(filp))
-		info->count++;
-	info->blocked_open--;
+		port->count++;
+	port->blocked_open--;
 	if (retval)
 		return retval;
-	info->flags |= ASYNC_NORMAL_ACTIVE;
+	port->flags |= ASYNC_NORMAL_ACTIVE;
 	return 0;
 }
 
-static int mxser_startup(struct mxser_struct *info)
+static int mxser_startup(struct mxser_port *info)
 {
 	unsigned long page;
 	unsigned long flags;
@@ -2366,7 +2317,7 @@ static int mxser_startup(struct mxser_st
 		return 0;
 	}
 
-	if (!info->base || !info->type) {
+	if (!info->ioaddr || !info->type) {
 		if (info->tty)
 			set_bit(TTY_IO_ERROR, &info->tty->flags);
 		free_page(page);
@@ -2382,20 +2333,20 @@ static int mxser_startup(struct mxser_st
 	 * Clear the FIFO buffers and disable them
 	 * (they will be reenabled in mxser_change_speed())
 	 */
-	if (info->IsMoxaMustChipFlag)
+	if (info->board->chip_flag)
 		outb((UART_FCR_CLEAR_RCVR |
 			UART_FCR_CLEAR_XMIT |
-			MOXA_MUST_FCR_GDA_MODE_ENABLE), info->base + UART_FCR);
+			MOXA_MUST_FCR_GDA_MODE_ENABLE), info->ioaddr + UART_FCR);
 	else
 		outb((UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT),
-			info->base + UART_FCR);
+			info->ioaddr + UART_FCR);
 
 	/*
 	 * At this point there's no way the LSR could still be 0xFF;
 	 * if it is, then bail out, because there's likely no UART
 	 * here.
 	 */
-	if (inb(info->base + UART_LSR) == 0xff) {
+	if (inb(info->ioaddr + UART_LSR) == 0xff) {
 		spin_unlock_irqrestore(&info->slock, flags);
 		if (capable(CAP_SYS_ADMIN)) {
 			if (info->tty)
@@ -2408,17 +2359,17 @@ static int mxser_startup(struct mxser_st
 	/*
 	 * Clear the interrupt registers.
 	 */
-	(void) inb(info->base + UART_LSR);
-	(void) inb(info->base + UART_RX);
-	(void) inb(info->base + UART_IIR);
-	(void) inb(info->base + UART_MSR);
+	(void) inb(info->ioaddr + UART_LSR);
+	(void) inb(info->ioaddr + UART_RX);
+	(void) inb(info->ioaddr + UART_IIR);
+	(void) inb(info->ioaddr + UART_MSR);
 
 	/*
 	 * Now, initialize the UART
 	 */
-	outb(UART_LCR_WLEN8, info->base + UART_LCR);	/* reset DLAB */
+	outb(UART_LCR_WLEN8, info->ioaddr + UART_LCR);	/* reset DLAB */
 	info->MCR = UART_MCR_DTR | UART_MCR_RTS;
-	outb(info->MCR, info->base + UART_MCR);
+	outb(info->MCR, info->ioaddr + UART_MCR);
 
 	/*
 	 * Finally, enable interrupts
@@ -2427,18 +2378,18 @@ static int mxser_startup(struct mxser_st
 	/* info->IER = UART_IER_RLSI | UART_IER_RDI; */
 
 	/* following add by Victor Yu. 08-30-2002 */
-	if (info->IsMoxaMustChipFlag)
+	if (info->board->chip_flag)
 		info->IER |= MOXA_MUST_IER_EGDAI;
 	/* above add by Victor Yu. 08-30-2002 */
-	outb(info->IER, info->base + UART_IER);	/* enable interrupts */
+	outb(info->IER, info->ioaddr + UART_IER);	/* enable interrupts */
 
 	/*
 	 * And clear the interrupt registers again for luck.
 	 */
-	(void) inb(info->base + UART_LSR);
-	(void) inb(info->base + UART_RX);
-	(void) inb(info->base + UART_IIR);
-	(void) inb(info->base + UART_MSR);
+	(void) inb(info->ioaddr + UART_LSR);
+	(void) inb(info->ioaddr + UART_RX);
+	(void) inb(info->ioaddr + UART_IIR);
+	(void) inb(info->ioaddr + UART_MSR);
 
 	if (info->tty)
 		clear_bit(TTY_IO_ERROR, &info->tty->flags);
@@ -2458,7 +2409,7 @@ static int mxser_startup(struct mxser_st
  * This routine will shutdown a serial port; interrupts maybe disabled, and
  * DTR is dropped if the hangup on close termio flag is on.
  */
-static void mxser_shutdown(struct mxser_struct *info)
+static void mxser_shutdown(struct mxser_port *info)
 {
 	unsigned long flags;
 
@@ -2482,25 +2433,25 @@ static void mxser_shutdown(struct mxser_
 	}
 
 	info->IER = 0;
-	outb(0x00, info->base + UART_IER);
+	outb(0x00, info->ioaddr + UART_IER);
 
 	if (!info->tty || (info->tty->termios->c_cflag & HUPCL))
 		info->MCR &= ~(UART_MCR_DTR | UART_MCR_RTS);
-	outb(info->MCR, info->base + UART_MCR);
+	outb(info->MCR, info->ioaddr + UART_MCR);
 
 	/* clear Rx/Tx FIFO's */
 	/* following add by Victor Yu. 08-30-2002 */
-	if (info->IsMoxaMustChipFlag)
-		outb((UART_FCR_CLEAR_RCVR |
-			UART_FCR_CLEAR_XMIT |
-			MOXA_MUST_FCR_GDA_MODE_ENABLE), info->base + UART_FCR);
+	if (info->board->chip_flag)
+		outb(UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT |
+				MOXA_MUST_FCR_GDA_MODE_ENABLE,
+				info->ioaddr + UART_FCR);
 	else
 		/* above add by Victor Yu. 08-30-2002 */
-		outb((UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT),
-			info->base + UART_FCR);
+		outb(UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
+			info->ioaddr + UART_FCR);
 
 	/* read data port to reset things */
-	(void) inb(info->base + UART_RX);
+	(void) inb(info->ioaddr + UART_RX);
 
 	if (info->tty)
 		set_bit(TTY_IO_ERROR, &info->tty->flags);
@@ -2508,8 +2459,8 @@ static void mxser_shutdown(struct mxser_
 	info->flags &= ~ASYNC_INITIALIZED;
 
 	/* following add by Victor Yu. 09-23-2002 */
-	if (info->IsMoxaMustChipFlag)
-		SET_MOXA_MUST_NO_SOFTWARE_FLOW_CONTROL(info->base);
+	if (info->board->chip_flag)
+		SET_MOXA_MUST_NO_SOFTWARE_FLOW_CONTROL(info->ioaddr);
 	/* above add by Victor Yu. 09-23-2002 */
 
 	spin_unlock_irqrestore(&info->slock, flags);
@@ -2519,7 +2470,8 @@ static void mxser_shutdown(struct mxser_
  * This routine is called to set the UART divisor registers to match
  * the specified baud rate for a serial port.
  */
-static int mxser_change_speed(struct mxser_struct *info, struct termios *old_termios)
+static int mxser_change_speed(struct mxser_port *info,
+		struct termios *old_termios)
 {
 	unsigned cflag, cval, fcr;
 	int ret = 0;
@@ -2530,13 +2482,13 @@ static int mxser_change_speed(struct mxs
 	if (!info->tty || !info->tty->termios)
 		return ret;
 	cflag = info->tty->termios->c_cflag;
-	if (!(info->base))
+	if (!(info->ioaddr))
 		return ret;
 
 #ifndef B921600
 #define B921600 (B460800 +1)
 #endif
-	if (mxser_set_baud_method[info->port] == 0) {
+	if (mxser_set_baud_method[info->tty->index] == 0) {
 		switch (cflag & (CBAUD | CBAUDEX)) {
 		case B921600:
 			baud = 921600;
@@ -2633,7 +2585,7 @@ #endif
 		cval |= UART_LCR_SPAR;
 
 	if ((info->type == PORT_8250) || (info->type == PORT_16450)) {
-		if (info->IsMoxaMustChipFlag) {
+		if (info->board->chip_flag) {
 			fcr = UART_FCR_ENABLE_FIFO;
 			fcr |= MOXA_MUST_FCR_GDA_MODE_ENABLE;
 			SET_MOXA_MUST_FIFO_VALUE(info);
@@ -2642,7 +2594,7 @@ #endif
 	} else {
 		fcr = UART_FCR_ENABLE_FIFO;
 		/* following add by Victor Yu. 08-30-2002 */
-		if (info->IsMoxaMustChipFlag) {
+		if (info->board->chip_flag) {
 			fcr |= MOXA_MUST_FCR_GDA_MODE_ENABLE;
 			SET_MOXA_MUST_FIFO_VALUE(info);
 		} else {
@@ -2670,9 +2622,9 @@ #endif
 	if (cflag & CRTSCTS) {
 		info->flags |= ASYNC_CTS_FLOW;
 		info->IER |= UART_IER_MSI;
-		if ((info->type == PORT_16550A) || (info->IsMoxaMustChipFlag)) {
+		if ((info->type == PORT_16550A) || (info->board->chip_flag)) {
 			info->MCR |= UART_MCR_AFE;
-			/* status = mxser_get_msr(info->base, 0, info->port); */
+/*			status = mxser_get_msr(info->ioaddr, 0, info->port); */
 /*
 	save_flags(flags);
 	cli();
@@ -2681,19 +2633,21 @@ #endif
 */
 			/* mxser_check_modem_status(info, status); */
 		} else {
-			/* status = mxser_get_msr(info->base, 0, info->port); */
+/*			status = mxser_get_msr(info->ioaddr, 0, info->port); */
 			/* MX_LOCK(&info->slock); */
-			status = inb(info->base + UART_MSR);
+			status = inb(info->ioaddr + UART_MSR);
 			/* MX_UNLOCK(&info->slock); */
 			if (info->tty->hw_stopped) {
 				if (status & UART_MSR_CTS) {
 					info->tty->hw_stopped = 0;
 					if (info->type != PORT_16550A &&
-							!info->IsMoxaMustChipFlag) {
+							!info->board->chip_flag) {
 						outb(info->IER & ~UART_IER_THRI,
-							info->base + UART_IER);
+							info->ioaddr +
+							UART_IER);
 						info->IER |= UART_IER_THRI;
-						outb(info->IER, info->base + UART_IER);
+						outb(info->IER, info->ioaddr +
+								UART_IER);
 					}
 					set_bit(MXSER_EVENT_TXLOW, &info->event);
 					schedule_work(&info->tqueue);				}
@@ -2701,9 +2655,10 @@ #endif
 				if (!(status & UART_MSR_CTS)) {
 					info->tty->hw_stopped = 1;
 					if ((info->type != PORT_16550A) &&
-							(!info->IsMoxaMustChipFlag)) {
+							(!info->board->chip_flag)) {
 						info->IER &= ~UART_IER_THRI;
-						outb(info->IER, info->base + UART_IER);
+						outb(info->IER, info->ioaddr +
+								UART_IER);
 					}
 				}
 			}
@@ -2711,14 +2666,14 @@ #endif
 	} else {
 		info->flags &= ~ASYNC_CTS_FLOW;
 	}
-	outb(info->MCR, info->base + UART_MCR);
+	outb(info->MCR, info->ioaddr + UART_MCR);
 	if (cflag & CLOCAL) {
 		info->flags &= ~ASYNC_CHECK_CD;
 	} else {
 		info->flags |= ASYNC_CHECK_CD;
 		info->IER |= UART_IER_MSI;
 	}
-	outb(info->IER, info->base + UART_IER);
+	outb(info->IER, info->ioaddr + UART_IER);
 
 	/*
 	 * Set up parity check flag
@@ -2750,27 +2705,27 @@ #endif
 		}
 	}
 	/* following add by Victor Yu. 09-02-2002 */
-	if (info->IsMoxaMustChipFlag) {
+	if (info->board->chip_flag) {
 		spin_lock_irqsave(&info->slock, flags);
-		SET_MOXA_MUST_XON1_VALUE(info->base, START_CHAR(info->tty));
-		SET_MOXA_MUST_XOFF1_VALUE(info->base, STOP_CHAR(info->tty));
+		SET_MOXA_MUST_XON1_VALUE(info->ioaddr, START_CHAR(info->tty));
+		SET_MOXA_MUST_XOFF1_VALUE(info->ioaddr, STOP_CHAR(info->tty));
 		if (I_IXON(info->tty)) {
-			ENABLE_MOXA_MUST_RX_SOFTWARE_FLOW_CONTROL(info->base);
+			ENABLE_MOXA_MUST_RX_SOFTWARE_FLOW_CONTROL(info->ioaddr);
 		} else {
-			DISABLE_MOXA_MUST_RX_SOFTWARE_FLOW_CONTROL(info->base);
+			DISABLE_MOXA_MUST_RX_SOFTWARE_FLOW_CONTROL(info->ioaddr);
 		}
 		if (I_IXOFF(info->tty)) {
-			ENABLE_MOXA_MUST_TX_SOFTWARE_FLOW_CONTROL(info->base);
+			ENABLE_MOXA_MUST_TX_SOFTWARE_FLOW_CONTROL(info->ioaddr);
 		} else {
-			DISABLE_MOXA_MUST_TX_SOFTWARE_FLOW_CONTROL(info->base);
+			DISABLE_MOXA_MUST_TX_SOFTWARE_FLOW_CONTROL(info->ioaddr);
 		}
 		/*
 		   if ( I_IXANY(info->tty) ) {
 		   info->MCR |= MOXA_MUST_MCR_XON_ANY;
-		   ENABLE_MOXA_MUST_XON_ANY_FLOW_CONTROL(info->base);
+		   ENABLE_MOXA_MUST_XON_ANY_FLOW_CONTROL(info->ioaddr);
 		   } else {
 		   info->MCR &= ~MOXA_MUST_MCR_XON_ANY;
-		   DISABLE_MOXA_MUST_XON_ANY_FLOW_CONTROL(info->base);
+		   DISABLE_MOXA_MUST_XON_ANY_FLOW_CONTROL(info->ioaddr);
 		   }
 		 */
 		spin_unlock_irqrestore(&info->slock, flags);
@@ -2778,14 +2733,14 @@ #endif
 	/* above add by Victor Yu. 09-02-2002 */
 
 
-	outb(fcr, info->base + UART_FCR);	/* set fcr */
-	outb(cval, info->base + UART_LCR);
+	outb(fcr, info->ioaddr + UART_FCR);	/* set fcr */
+	outb(cval, info->ioaddr + UART_LCR);
 
 	return ret;
 }
 
 
-static int mxser_set_baud(struct mxser_struct *info, long newspd)
+static int mxser_set_baud(struct mxser_port *info, long newspd)
 {
 	int quot = 0;
 	unsigned char cval;
@@ -2795,10 +2750,10 @@ static int mxser_set_baud(struct mxser_s
 	if (!info->tty || !info->tty->termios)
 		return ret;
 
-	if (!(info->base))
+	if (!(info->ioaddr))
 		return ret;
 
-	if (newspd > info->MaxCanSetBaudRate)
+	if (newspd > info->max_baud)
 		return 0;
 
 	info->realbaud = newspd;
@@ -2818,23 +2773,23 @@ static int mxser_set_baud(struct mxser_s
 	if (quot) {
 		spin_lock_irqsave(&info->slock, flags);
 		info->MCR |= UART_MCR_DTR;
-		outb(info->MCR, info->base + UART_MCR);
+		outb(info->MCR, info->ioaddr + UART_MCR);
 		spin_unlock_irqrestore(&info->slock, flags);
 	} else {
 		spin_lock_irqsave(&info->slock, flags);
 		info->MCR &= ~UART_MCR_DTR;
-		outb(info->MCR, info->base + UART_MCR);
+		outb(info->MCR, info->ioaddr + UART_MCR);
 		spin_unlock_irqrestore(&info->slock, flags);
 		return ret;
 	}
 
-	cval = inb(info->base + UART_LCR);
+	cval = inb(info->ioaddr + UART_LCR);
 
-	outb(cval | UART_LCR_DLAB, info->base + UART_LCR);	/* set DLAB */
+	outb(cval | UART_LCR_DLAB, info->ioaddr + UART_LCR);	/* set DLAB */
 
-	outb(quot & 0xff, info->base + UART_DLL);	/* LS of divisor */
-	outb(quot >> 8, info->base + UART_DLM);	/* MS of divisor */
-	outb(cval, info->base + UART_LCR);	/* reset DLAB */
+	outb(quot & 0xff, info->ioaddr + UART_DLL);	/* LS of divisor */
+	outb(quot >> 8, info->ioaddr + UART_DLM);	/* MS of divisor */
+	outb(cval, info->ioaddr + UART_LCR);	/* reset DLAB */
 
 
 	return ret;
@@ -2845,7 +2800,8 @@ static int mxser_set_baud(struct mxser_s
  * friends of mxser_ioctl()
  * ------------------------------------------------------------
  */
-static int mxser_get_serial_info(struct mxser_struct *info, struct serial_struct __user *retinfo)
+static int mxser_get_serial_info(struct mxser_port *info,
+		struct serial_struct __user *retinfo)
 {
 	struct serial_struct tmp;
 
@@ -2853,9 +2809,9 @@ static int mxser_get_serial_info(struct 
 		return -EFAULT;
 	memset(&tmp, 0, sizeof(tmp));
 	tmp.type = info->type;
-	tmp.line = info->port;
-	tmp.port = info->base;
-	tmp.irq = info->irq;
+	tmp.line = info->tty->index;
+	tmp.port = info->ioaddr;
+	tmp.irq = info->board->irq;
 	tmp.flags = info->flags;
 	tmp.baud_base = info->baud_base;
 	tmp.close_delay = info->close_delay;
@@ -2867,19 +2823,20 @@ static int mxser_get_serial_info(struct 
 	return 0;
 }
 
-static int mxser_set_serial_info(struct mxser_struct *info, struct serial_struct __user *new_info)
+static int mxser_set_serial_info(struct mxser_port *info,
+		struct serial_struct __user *new_info)
 {
 	struct serial_struct new_serial;
 	unsigned int flags;
 	int retval = 0;
 
-	if (!new_info || !info->base)
+	if (!new_info || !info->ioaddr)
 		return -EFAULT;
 	if (copy_from_user(&new_serial, new_info, sizeof(new_serial)))
 		return -EFAULT;
 
-	if ((new_serial.irq != info->irq) ||
-			(new_serial.port != info->base) ||
+	if ((new_serial.irq != info->board->irq) ||
+			(new_serial.port != info->ioaddr) ||
 			(new_serial.custom_divisor != info->custom_divisor) ||
 			(new_serial.baud_base != info->baud_base))
 		return -EPERM;
@@ -2913,12 +2870,11 @@ static int mxser_set_serial_info(struct 
 	process_txrx_fifo(info);
 
 	if (info->flags & ASYNC_INITIALIZED) {
-		if (flags != (info->flags & ASYNC_SPD_MASK)) {
+		if (flags != (info->flags & ASYNC_SPD_MASK))
 			mxser_change_speed(info, NULL);
-		}
-	} else {
+	} else
 		retval = mxser_startup(info);
-	}
+
 	return retval;
 }
 
@@ -2932,14 +2888,15 @@ static int mxser_set_serial_info(struct 
  *	    transmit holding register is empty.  This functionality
  *	    allows an RS485 driver to be written in user space.
  */
-static int mxser_get_lsr_info(struct mxser_struct *info, unsigned int __user *value)
+static int mxser_get_lsr_info(struct mxser_port *info,
+		unsigned int __user *value)
 {
 	unsigned char status;
 	unsigned int result;
 	unsigned long flags;
 
 	spin_lock_irqsave(&info->slock, flags);
-	status = inb(info->base + UART_LSR);
+	status = inb(info->ioaddr + UART_LSR);
 	spin_unlock_irqrestore(&info->slock, flags);
 	result = ((status & UART_LSR_TEMT) ? TIOCSER_TEMT : 0);
 	return put_user(result, value);
@@ -2948,27 +2905,27 @@ static int mxser_get_lsr_info(struct mxs
 /*
  * This routine sends a break character out the serial port.
  */
-static void mxser_send_break(struct mxser_struct *info, int duration)
+static void mxser_send_break(struct mxser_port *info, int duration)
 {
 	unsigned long flags;
 
-	if (!info->base)
+	if (!info->ioaddr)
 		return;
 	set_current_state(TASK_INTERRUPTIBLE);
 	spin_lock_irqsave(&info->slock, flags);
-	outb(inb(info->base + UART_LCR) | UART_LCR_SBC,
-		info->base + UART_LCR);
+	outb(inb(info->ioaddr + UART_LCR) | UART_LCR_SBC,
+		info->ioaddr + UART_LCR);
 	spin_unlock_irqrestore(&info->slock, flags);
 	schedule_timeout(duration);
 	spin_lock_irqsave(&info->slock, flags);
-	outb(inb(info->base + UART_LCR) & ~UART_LCR_SBC,
-		info->base + UART_LCR);
+	outb(inb(info->ioaddr + UART_LCR) & ~UART_LCR_SBC,
+		info->ioaddr + UART_LCR);
 	spin_unlock_irqrestore(&info->slock, flags);
 }
 
 static int mxser_tiocmget(struct tty_struct *tty, struct file *file)
 {
-	struct mxser_struct *info = tty->driver_data;
+	struct mxser_port *info = tty->driver_data;
 	unsigned char control, status;
 	unsigned long flags;
 
@@ -2981,7 +2938,7 @@ static int mxser_tiocmget(struct tty_str
 	control = info->MCR;
 
 	spin_lock_irqsave(&info->slock, flags);
-	status = inb(info->base + UART_MSR);
+	status = inb(info->ioaddr + UART_MSR);
 	if (status & UART_MSR_ANY_DELTA)
 		mxser_check_modem_status(info, status);
 	spin_unlock_irqrestore(&info->slock, flags);
@@ -2993,9 +2950,10 @@ static int mxser_tiocmget(struct tty_str
 		    ((status & UART_MSR_CTS) ? TIOCM_CTS : 0);
 }
 
-static int mxser_tiocmset(struct tty_struct *tty, struct file *file, unsigned int set, unsigned int clear)
+static int mxser_tiocmset(struct tty_struct *tty, struct file *file,
+		unsigned int set, unsigned int clear)
 {
-	struct mxser_struct *info = tty->driver_data;
+	struct mxser_port *info = tty->driver_data;
 	unsigned long flags;
 
 
@@ -3016,7 +2974,7 @@ static int mxser_tiocmset(struct tty_str
 	if (clear & TIOCM_DTR)
 		info->MCR &= ~UART_MCR_DTR;
 
-	outb(info->MCR, info->base + UART_MCR);
+	outb(info->MCR, info->ioaddr + UART_MCR);
 	spin_unlock_irqrestore(&info->slock, flags);
 	return 0;
 }
@@ -3026,49 +2984,49 @@ static int mxser_read_register(int, unsi
 static int mxser_program_mode(int);
 static void mxser_normal_mode(int);
 
-static int mxser_get_ISA_conf(int cap, struct mxser_hwconf *hwconf)
+static int mxser_get_ISA_conf(int cap, struct mxser_board *brd)
 {
 	int id, i, bits;
 	unsigned short regs[16], irq;
 	unsigned char scratch, scratch2;
 
-	hwconf->IsMoxaMustChipFlag = MOXA_OTHER_UART;
+	brd->chip_flag = MOXA_OTHER_UART;
 
 	id = mxser_read_register(cap, regs);
 	if (id == C168_ASIC_ID) {
-		hwconf->board_type = MXSER_BOARD_C168_ISA;
-		hwconf->ports = 8;
+		brd->board_type = MXSER_BOARD_C168_ISA;
+		brd->nports = 8;
 	} else if (id == C104_ASIC_ID) {
-		hwconf->board_type = MXSER_BOARD_C104_ISA;
-		hwconf->ports = 4;
+		brd->board_type = MXSER_BOARD_C104_ISA;
+		brd->nports = 4;
 	} else if (id == C102_ASIC_ID) {
-		hwconf->board_type = MXSER_BOARD_C102_ISA;
-		hwconf->ports = 2;
+		brd->board_type = MXSER_BOARD_C102_ISA;
+		brd->nports = 2;
 	} else if (id == CI132_ASIC_ID) {
-		hwconf->board_type = MXSER_BOARD_CI132;
-		hwconf->ports = 2;
+		brd->board_type = MXSER_BOARD_CI132;
+		brd->nports = 2;
 	} else if (id == CI134_ASIC_ID) {
-		hwconf->board_type = MXSER_BOARD_CI134;
-		hwconf->ports = 4;
+		brd->board_type = MXSER_BOARD_CI134;
+		brd->nports = 4;
 	} else if (id == CI104J_ASIC_ID) {
-		hwconf->board_type = MXSER_BOARD_CI104J;
-		hwconf->ports = 4;
+		brd->board_type = MXSER_BOARD_CI104J;
+		brd->nports = 4;
 	} else
 		return 0;
 
 	irq = 0;
-	if (hwconf->ports == 2) {
+	if (brd->nports == 2) {
 		irq = regs[9] & 0xF000;
 		irq = irq | (irq >> 4);
 		if (irq != (regs[9] & 0xFF00))
 			return MXSER_ERR_IRQ_CONFLIT;
-	} else if (hwconf->ports == 4) {
+	} else if (brd->nports == 4) {
 		irq = regs[9] & 0xF000;
 		irq = irq | (irq >> 4);
 		irq = irq | (irq >> 8);
 		if (irq != regs[9])
 			return MXSER_ERR_IRQ_CONFLIT;
-	} else if (hwconf->ports == 8) {
+	} else if (brd->nports == 8) {
 		irq = regs[9] & 0xF000;
 		irq = irq | (irq >> 4);
 		irq = irq | (irq >> 8);
@@ -3078,23 +3036,23 @@ static int mxser_get_ISA_conf(int cap, s
 
 	if (!irq)
 		return MXSER_ERR_IRQ;
-	hwconf->irq = ((int)(irq & 0xF000) >> 12);
+	brd->irq = ((int)(irq & 0xF000) >> 12);
 	for (i = 0; i < 8; i++)
-		hwconf->ioaddr[i] = (int) regs[i + 1] & 0xFFF8;
+		brd->ports[i].ioaddr = (int) regs[i + 1] & 0xFFF8;
 	if ((regs[12] & 0x80) == 0)
 		return MXSER_ERR_VECTOR;
-	hwconf->vector = (int)regs[11];	/* interrupt vector */
+	brd->vector = (int)regs[11];	/* interrupt vector */
 	if (id == 1)
-		hwconf->vector_mask = 0x00FF;
+		brd->vector_mask = 0x00FF;
 	else
-		hwconf->vector_mask = 0x000F;
+		brd->vector_mask = 0x000F;
 	for (i = 7, bits = 0x0100; i >= 0; i--, bits <<= 1) {
 		if (regs[12] & bits) {
-			hwconf->baud_base[i] = 921600;
-			hwconf->MaxCanSetBaudRate[i] = 921600;	/* add by Victor Yu. 09-04-2002 */
+			brd->ports[i].baud_base = 921600;
+			brd->ports[i].max_baud = 921600;	/* add by Victor Yu. 09-04-2002 */
 		} else {
-			hwconf->baud_base[i] = 115200;
-			hwconf->MaxCanSetBaudRate[i] = 115200;	/* add by Victor Yu. 09-04-2002 */
+			brd->ports[i].baud_base = 115200;
+			brd->ports[i].max_baud = 115200;	/* add by Victor Yu. 09-04-2002 */
 		}
 	}
 	scratch2 = inb(cap + UART_LCR) & (~UART_LCR_DLAB);
@@ -3105,16 +3063,16 @@ static int mxser_get_ISA_conf(int cap, s
 	scratch = inb(cap + UART_IIR);
 
 	if (scratch & 0xC0)
-		hwconf->uart_type = PORT_16550A;
+		brd->uart_type = PORT_16550A;
 	else
-		hwconf->uart_type = PORT_16450;
+		brd->uart_type = PORT_16450;
 	if (id == 1)
-		hwconf->ports = 8;
+		brd->nports = 8;
 	else
-		hwconf->ports = 4;
-	request_region(hwconf->ioaddr[0], 8 * hwconf->ports, "mxser(IO)");
-	request_region(hwconf->vector, 1, "mxser(vector)");
-	return hwconf->ports;
+		brd->nports = 4;
+	request_region(brd->ports[0].ioaddr, 8 * brd->nports, "mxser(IO)");
+	request_region(brd->vector, 1, "mxser(vector)");
+	return brd->nports;
 }
 
 #define CHIP_SK 	0x01	/* Serial Data Clock  in Eprom */
diff --git a/drivers/char/mxser.h b/drivers/char/mxser.h
index 7e188a4..1f0c285 100644
--- a/drivers/char/mxser.h
+++ b/drivers/char/mxser.h
@@ -300,16 +300,16 @@ #define SET_MOXA_MUST_THRTL_VALUE(baseio
 //#define MOXA_MUST_RBRL_VALUE  4
 #define SET_MOXA_MUST_FIFO_VALUE(info) {	\
 	u8	__oldlcr, __efr;	\
-	__oldlcr = inb((info)->base+UART_LCR);	\
-	outb(MOXA_MUST_ENTER_ENCHANCE, (info)->base+UART_LCR);	\
-	__efr = inb((info)->base+MOXA_MUST_EFR_REGISTER);	\
+	__oldlcr = inb((info)->ioaddr+UART_LCR);	\
+	outb(MOXA_MUST_ENTER_ENCHANCE, (info)->ioaddr+UART_LCR);	\
+	__efr = inb((info)->ioaddr+MOXA_MUST_EFR_REGISTER);	\
 	__efr &= ~MOXA_MUST_EFR_BANK_MASK;	\
 	__efr |= MOXA_MUST_EFR_BANK1;	\
-	outb(__efr, (info)->base+MOXA_MUST_EFR_REGISTER);	\
-	outb((u8)((info)->rx_high_water), (info)->base+MOXA_MUST_RBRTH_REGISTER);	\
-	outb((u8)((info)->rx_trigger), (info)->base+MOXA_MUST_RBRTI_REGISTER);	\
-	outb((u8)((info)->rx_low_water), (info)->base+MOXA_MUST_RBRTL_REGISTER);	\
-	outb(__oldlcr, (info)->base+UART_LCR);	\
+	outb(__efr, (info)->ioaddr+MOXA_MUST_EFR_REGISTER);	\
+	outb((u8)((info)->rx_high_water), (info)->ioaddr+MOXA_MUST_RBRTH_REGISTER);	\
+	outb((u8)((info)->rx_trigger), (info)->ioaddr+MOXA_MUST_RBRTI_REGISTER);	\
+	outb((u8)((info)->rx_low_water), (info)->ioaddr+MOXA_MUST_RBRTL_REGISTER);	\
+	outb(__oldlcr, (info)->ioaddr+UART_LCR);	\
 }
 
 
