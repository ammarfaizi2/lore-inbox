Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266146AbUGTTpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266146AbUGTTpQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266147AbUGTToM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 15:44:12 -0400
Received: from amsfep18-int.chello.nl ([213.46.243.13]:7259 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S266146AbUGTSjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:39:44 -0400
Date: Tue, 20 Jul 2004 20:39:43 +0200
Message-Id: <200407201839.i6KIdhqx015500@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] !PCI warnings: Moxa serial
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kill warnings in MOXA Intellio and Smartio multiport serial drivers when !PCI.
Also kill warnings about unused variables in the non-modular case.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/drivers/char/moxa.c	2004-04-15 11:44:11.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/char/moxa.c	2004-07-19 23:25:41.000000000 +0200
@@ -104,6 +104,7 @@
 	"CP-204J series",
 };
 
+#ifdef CONFIG_PCI
 static struct pci_device_id moxa_pcibrds[] = {
 	{ PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_C218, PCI_ANY_ID, PCI_ANY_ID, 
 	  0, 0, MOXA_BOARD_C218_PCI },
@@ -114,6 +115,7 @@
 	{ 0 }
 };
 MODULE_DEVICE_TABLE(pci, moxa_pcibrds);
+#endif /* CONFIG_PCI */
 
 typedef struct _moxa_isa_board_conf {
 	int boardType;
@@ -190,9 +192,11 @@
 static int verbose = 0;
 static int ttymajor = MOXAMAJOR;
 /* Variables for insmod */
+#ifdef MODULE
 static int baseaddr[] 	= 	{0, 0, 0, 0};
 static int type[]	=	{0, 0, 0, 0};
 static int numports[] 	=	{0, 0, 0, 0};
+#endif
 
 MODULE_AUTHOR("William Chen");
 MODULE_DESCRIPTION("MOXA Intellio Family Multiport Board Device Driver");
@@ -215,7 +219,6 @@
 /*
  * static functions:
  */
-static int moxa_get_PCI_conf(struct pci_dev *, int, moxa_board_conf *);
 static void do_moxa_softint(void *);
 static int moxa_open(struct tty_struct *, struct file *);
 static void moxa_close(struct tty_struct *, struct file *);
@@ -296,6 +299,32 @@
 	.tiocmset = moxa_tiocmset,
 };
 
+#ifdef CONFIG_PCI
+static int moxa_get_PCI_conf(struct pci_dev *p, int board_type, moxa_board_conf * board)
+{
+	board->baseAddr = pci_resource_start (p, 2);
+	board->boardType = board_type;
+	switch (board_type) {
+	case MOXA_BOARD_C218_ISA:
+	case MOXA_BOARD_C218_PCI:
+		board->numPorts = 8;
+		break;
+
+	case MOXA_BOARD_CP204J:
+		board->numPorts = 4;
+		break;
+	default:
+		board->numPorts = 0;
+		break;
+	}
+	board->busType = MOXA_BUS_TYPE_PCI;
+	board->pciInfo.busNum = p->bus->number;
+	board->pciInfo.devNum = p->devfn >> 3;
+
+	return (0);
+}
+#endif /* CONFIG_PCI */
+
 static int __init moxa_init(void)
 {
 	int i, numBoards;
@@ -469,30 +498,6 @@
 module_init(moxa_init);
 module_exit(moxa_exit);
 
-static int moxa_get_PCI_conf(struct pci_dev *p, int board_type, moxa_board_conf * board)
-{
-	board->baseAddr = pci_resource_start (p, 2);
-	board->boardType = board_type;
-	switch (board_type) {
-	case MOXA_BOARD_C218_ISA:
-	case MOXA_BOARD_C218_PCI:
-		board->numPorts = 8;
-		break;
-
-	case MOXA_BOARD_CP204J:
-		board->numPorts = 4;
-		break;
-	default:
-		board->numPorts = 0;
-		break;
-	}
-	board->busType = MOXA_BUS_TYPE_PCI;
-	board->pciInfo.busNum = p->bus->number;
-	board->pciInfo.devNum = p->devfn >> 3;
-
-	return (0);
-}
-
 static void do_moxa_softint(void *private_)
 {
 	struct moxa_str *ch = (struct moxa_str *) private_;
--- linux-2.6.8-rc2/drivers/char/mxser.c	2004-07-15 23:14:13.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/char/mxser.c	2004-07-19 23:21:13.000000000 +0200
@@ -198,6 +198,7 @@
 #define         MOXA_GET_CUMAJOR      (MOXA + 64)
 #define         MOXA_GETMSTATUS       (MOXA + 65)
 
+#ifdef CONFIG_PCI
 static struct pci_device_id mxser_pcibrds[] = {
 	{ PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_C168, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
 	  MXSER_BOARD_C168_PCI },
@@ -214,6 +215,7 @@
 	{ 0 }
 };
 MODULE_DEVICE_TABLE(pci, mxser_pcibrds);
+#endif /* CONFIG_PCI */
 
 static int ioaddr[MXSER_BOARDS];
 static int ttymajor = MXSERMAJOR;
@@ -330,7 +332,6 @@
 
 static void mxser_getcfg(int board, struct mxser_hwconf *hwconf);
 static int mxser_get_ISA_conf(int, struct mxser_hwconf *);
-static int mxser_get_PCI_conf(struct pci_dev *, int, struct mxser_hwconf *);
 static void mxser_do_softint(void *);
 static int mxser_open(struct tty_struct *, struct file *);
 static void mxser_close(struct tty_struct *, struct file *);
@@ -461,6 +462,7 @@
 	mxsercfg[board] = *hwconf;
 }
 
+#ifdef CONFIG_PCI
 static int mxser_get_PCI_conf(struct pci_dev *pdev, int board_type, struct mxser_hwconf *hwconf)
 {
 	int i;
@@ -485,6 +487,7 @@
 	}
 	return (0);
 }
+#endif /* CONFIG_PCI */
 
 static struct tty_operations mxser_ops = {
 	.open = mxser_open,

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
