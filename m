Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267992AbUHXPjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267992AbUHXPjE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 11:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268004AbUHXPjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 11:39:03 -0400
Received: from akana.de ([217.114.212.7]:52240 "EHLO akana.de")
	by vger.kernel.org with ESMTP id S267992AbUHXPe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 11:34:26 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] Fix stallion for UP
Organization: Disorganized
From: Ingo Korb <nospam@akana.de>
Date: Tue, 24 Aug 2004 17:02:57 +0200
Message-ID: <uhdqspoim.fsf@dragon.akana.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/20.7 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

When switching from 2.4 to 2.6 I noticed that the stallion driver didn't
load at all when compiled into the kernel and left a complaint about
sleeping in an invalid context in the log when loaded as a module.

The patch below attempts to fix this, but it will still be broken for
SMP as the code is sprinkled with cli() and I don't fully understand
what should be going on there yet.

As this is my first attempt at kernel stuff I'd appreciate any comments.

The driver originally used cli() in the module initialisation because it
routed all interrupts through a single ISR that accessed global
structures which may not have been fully initialized at that point. I
removed that procedure, taking advantage of the (originally NULL) dev_id
pointer and moved the request_irq to a later point where I think it
won't cause a race anymore.

Status of the patched driver: "Works for me" with a single PCI-board on
UP compiled as a module, I don't have more hardware to
test. Compile-tested, but not booted as a compiled-in driver.

Signed-off-by: Ingo Korb <ingo@akana.de>

diff -uprN -X dontdiff linux-2.6.8.1-orig/drivers/char/stallion.c linux-2.6.8.1/drivers/char/stallion.c
--- linux-2.6.8.1-orig/drivers/char/stallion.c	2004-08-24 16:03:55.000000000 +0200
+++ linux-2.6.8.1/drivers/char/stallion.c	2004-08-24 16:42:56.000000000 +0200
@@ -173,14 +173,6 @@ static stlport_t	stl_dummyport;
  */
 static char		stl_unwanted[SC26198_RXFIFOSIZE];
 
-/*
- *	Keep track of what interrupts we have requested for us.
- *	We don't need to request an interrupt twice if it is being
- *	shared with another Stallion board.
- */
-static int	stl_gotintrs[STL_MAXBRDS];
-static int	stl_numintrs;
-
 /*****************************************************************************/
 
 static stlbrd_t		*stl_brds[STL_MAXBRDS];
@@ -239,7 +231,6 @@ static char	*stl_brdnames[] = {
 
 /*****************************************************************************/
 
-#ifdef MODULE
 /*
  *	Define some string labels for arguments passed from the module
  *	load line. These allow for easy board definitions, and easy
@@ -315,8 +306,6 @@ MODULE_PARM_DESC(board2, "Board 2 config
 MODULE_PARM(board3, "1-4s");
 MODULE_PARM_DESC(board3, "Board 3 config -> name[,ioaddr[,ioaddr2][,irq]]");
 
-#endif
-
 /*****************************************************************************/
 
 /*
@@ -471,12 +460,10 @@ static unsigned int	stl_baudrates[] = {
  *	Declare all those functions in this driver!
  */
 
-#ifdef MODULE
 static void	stl_argbrds(void);
 static int	stl_parsebrd(stlconf_t *confp, char **argp);
 
 static unsigned long stl_atol(char *str);
-#endif
 
 int		stl_init(void);
 static int	stl_open(struct tty_struct *tty, struct file *filp);
@@ -503,7 +490,6 @@ static int	stl_readproc(char *page, char
 
 static int	stl_brdinit(stlbrd_t *brdp);
 static int	stl_initports(stlbrd_t *brdp, stlpanel_t *panelp);
-static int	stl_mapirq(int irq, char *name);
 static int	stl_getserial(stlport_t *portp, struct serial_struct __user *sp);
 static int	stl_setserial(stlport_t *portp, struct serial_struct __user *sp);
 static int	stl_getbrdstats(combrd_t __user *bp);
@@ -513,11 +499,11 @@ static int	stl_getportstruct(stlport_t _
 static int	stl_getbrdstruct(stlbrd_t __user *arg);
 static int	stl_waitcarrier(stlport_t *portp, struct file *filp);
 static void	stl_delay(int len);
-static void	stl_eiointr(stlbrd_t *brdp);
-static void	stl_echatintr(stlbrd_t *brdp);
-static void	stl_echmcaintr(stlbrd_t *brdp);
-static void	stl_echpciintr(stlbrd_t *brdp);
-static void	stl_echpci64intr(stlbrd_t *brdp);
+static irqreturn_t stl_eiointr(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t stl_echatintr(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t stl_echmcaintr(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t stl_echpciintr(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t stl_echpci64intr(int irq, void *dev_id, struct pt_regs *regs);
 static void	stl_offintr(void *private);
 static void	*stl_memalloc(int len);
 static stlbrd_t *stl_allocbrd(void);
@@ -553,8 +539,8 @@ static void	stl_cd1400flowctrl(stlport_t
 static void	stl_cd1400sendflow(stlport_t *portp, int state);
 static void	stl_cd1400flush(stlport_t *portp);
 static int	stl_cd1400datastate(stlport_t *portp);
-static void	stl_cd1400eiointr(stlpanel_t *panelp, unsigned int iobase);
-static void	stl_cd1400echintr(stlpanel_t *panelp, unsigned int iobase);
+static irqreturn_t stl_cd1400eiointr(stlpanel_t *panelp, unsigned int iobase);
+static irqreturn_t stl_cd1400echintr(stlpanel_t *panelp, unsigned int iobase);
 static void	stl_cd1400txisr(stlpanel_t *panelp, int ioaddr);
 static void	stl_cd1400rxisr(stlpanel_t *panelp, int ioaddr);
 static void	stl_cd1400mdmisr(stlpanel_t *panelp, int ioaddr);
@@ -583,7 +569,7 @@ static void	stl_sc26198flush(stlport_t *
 static int	stl_sc26198datastate(stlport_t *portp);
 static void	stl_sc26198wait(stlport_t *portp);
 static void	stl_sc26198txunflow(stlport_t *portp, struct tty_struct *tty);
-static void	stl_sc26198intr(stlpanel_t *panelp, unsigned int iobase);
+static irqreturn_t stl_sc26198intr(stlpanel_t *panelp, unsigned int iobase);
 static void	stl_sc26198txisr(stlport_t *port);
 static void	stl_sc26198rxisr(stlport_t *port, unsigned int iack);
 static void	stl_sc26198rxbadch(stlport_t *portp, unsigned char status, char ch);
@@ -609,7 +595,7 @@ typedef struct uart {
 	void	(*sendflow)(stlport_t *portp, int state);
 	void	(*flush)(stlport_t *portp);
 	int	(*datastate)(stlport_t *portp);
-	void	(*intr)(stlpanel_t *panelp, unsigned int iobase);
+	irqreturn_t (*intr)(stlpanel_t *panelp, unsigned int iobase);
 } uart_t;
 
 /*
@@ -735,24 +721,17 @@ static struct file_operations	stl_fsiome
 
 static struct class_simple *stallion_class;
 
-#ifdef MODULE
-
 /*
  *	Loadable module initialization stuff.
  */
 
 static int __init stallion_module_init(void)
 {
-	unsigned long	flags;
-
 #ifdef DEBUG
 	printk("init_module()\n");
 #endif
 
-	save_flags(flags);
-	cli();
 	stl_init();
-	restore_flags(flags);
 
 	return(0);
 }
@@ -828,13 +807,12 @@ static void __exit stallion_module_exit(
 		if (brdp->iosize2 > 0)
 			release_region(brdp->ioaddr2, brdp->iosize2);
 
+		free_irq(brdp->irq,brdp);
+
 		kfree(brdp);
 		stl_brds[i] = (stlbrd_t *) NULL;
 	}
 
-	for (i = 0; (i < stl_numintrs); i++)
-		free_irq(stl_gotintrs[i], NULL);
-
 	restore_flags(flags);
 }
 
@@ -959,8 +937,6 @@ static int stl_parsebrd(stlconf_t *confp
 	return(1);
 }
 
-#endif
-
 /*****************************************************************************/
 
 /*
@@ -2024,46 +2000,22 @@ stl_readdone:
 /*****************************************************************************/
 
 /*
- *	All board interrupts are vectored through here first. This code then
- *	calls off to the approrpriate board interrupt handlers.
- */
-
-static irqreturn_t stl_intr(int irq, void *dev_id, struct pt_regs *regs)
-{
-	stlbrd_t	*brdp;
-	int		i;
-	int handled = 0;
-
-#ifdef DEBUG
-	printk("stl_intr(irq=%d,regs=%x)\n", irq, (int) regs);
-#endif
-
-	for (i = 0; (i < stl_nrbrds); i++) {
-		if ((brdp = stl_brds[i]) == (stlbrd_t *) NULL)
-			continue;
-		if (brdp->state == 0)
-			continue;
-		handled = 1;
-		(* brdp->isr)(brdp);
-	}
-	return IRQ_RETVAL(handled);
-}
-
-/*****************************************************************************/
-
-/*
  *	Interrupt service routine for EasyIO board types.
  */
 
-static void stl_eiointr(stlbrd_t *brdp)
+static irqreturn_t stl_eiointr(int irq, void *dev_id, struct pt_regs *regs)
 {
 	stlpanel_t	*panelp;
 	unsigned int	iobase;
+	stlbrd_t        *brdp = (stlbrd_t *)dev_id;
+	irqreturn_t     rc = IRQ_NONE;
 
 	panelp = brdp->panels[0];
 	iobase = panelp->iobase;
 	while (inb(brdp->iostatus) & EIO_INTRPEND)
-		(* panelp->isr)(panelp, iobase);
+		if ((* panelp->isr)(panelp, iobase) != IRQ_NONE)
+			rc = IRQ_HANDLED;
+	return rc;
 }
 
 /*****************************************************************************/
@@ -2072,11 +2024,13 @@ static void stl_eiointr(stlbrd_t *brdp)
  *	Interrupt service routine for ECH-AT board types.
  */
 
-static void stl_echatintr(stlbrd_t *brdp)
+static irqreturn_t stl_echatintr(int irq, void *dev_id, struct pt_regs *regs)
 {
 	stlpanel_t	*panelp;
 	unsigned int	ioaddr;
 	int		bnknr;
+	stlbrd_t        *brdp = (stlbrd_t *)dev_id;
+	irqreturn_t     rc = IRQ_NONE;
 
 	outb((brdp->ioctrlval | ECH_BRDENABLE), brdp->ioctrl);
 
@@ -2085,12 +2039,15 @@ static void stl_echatintr(stlbrd_t *brdp
 			ioaddr = brdp->bnkstataddr[bnknr];
 			if (inb(ioaddr) & ECH_PNLINTRPEND) {
 				panelp = brdp->bnk2panel[bnknr];
-				(* panelp->isr)(panelp, (ioaddr & 0xfffc));
+				if ((* panelp->isr)(panelp, (ioaddr & 0xfffc))
+				    != IRQ_NONE)
+					rc = IRQ_HANDLED;
 			}
 		}
 	}
 
 	outb((brdp->ioctrlval | ECH_BRDDISABLE), brdp->ioctrl);
+	return rc;
 }
 
 /*****************************************************************************/
@@ -2099,21 +2056,26 @@ static void stl_echatintr(stlbrd_t *brdp
  *	Interrupt service routine for ECH-MCA board types.
  */
 
-static void stl_echmcaintr(stlbrd_t *brdp)
+static irqreturn_t stl_echmcaintr(int irq, void *dev_id, struct pt_regs *regs)
 {
 	stlpanel_t	*panelp;
 	unsigned int	ioaddr;
 	int		bnknr;
+	stlbrd_t        *brdp = (stlbrd_t *)dev_id;
+	irqreturn_t     rc = IRQ_NONE;
 
 	while (inb(brdp->iostatus) & ECH_INTRPEND) {
 		for (bnknr = 0; (bnknr < brdp->nrbnks); bnknr++) {
 			ioaddr = brdp->bnkstataddr[bnknr];
 			if (inb(ioaddr) & ECH_PNLINTRPEND) {
 				panelp = brdp->bnk2panel[bnknr];
-				(* panelp->isr)(panelp, (ioaddr & 0xfffc));
+				if ((* panelp->isr)(panelp, (ioaddr & 0xfffc))
+				    != IRQ_NONE)
+					rc = IRQ_HANDLED;
 			}
 		}
 	}
+	return rc;
 }
 
 /*****************************************************************************/
@@ -2122,11 +2084,13 @@ static void stl_echmcaintr(stlbrd_t *brd
  *	Interrupt service routine for ECH-PCI board types.
  */
 
-static void stl_echpciintr(stlbrd_t *brdp)
+static irqreturn_t stl_echpciintr(int irq, void *dev_id, struct pt_regs *regs)
 {
 	stlpanel_t	*panelp;
 	unsigned int	ioaddr;
 	int		bnknr, recheck;
+	stlbrd_t        *brdp = (stlbrd_t *)dev_id;
+	irqreturn_t     rc = IRQ_NONE;
 
 	while (1) {
 		recheck = 0;
@@ -2135,13 +2099,16 @@ static void stl_echpciintr(stlbrd_t *brd
 			ioaddr = brdp->bnkstataddr[bnknr];
 			if (inb(ioaddr) & ECH_PNLINTRPEND) {
 				panelp = brdp->bnk2panel[bnknr];
-				(* panelp->isr)(panelp, (ioaddr & 0xfffc));
+				if ((* panelp->isr)(panelp, (ioaddr & 0xfffc))
+				    != IRQ_NONE)
+					rc = IRQ_HANDLED;
 				recheck++;
 			}
 		}
 		if (! recheck)
 			break;
 	}
+	return rc;
 }
 
 /*****************************************************************************/
@@ -2150,21 +2117,26 @@ static void stl_echpciintr(stlbrd_t *brd
  *	Interrupt service routine for ECH-8/64-PCI board types.
  */
 
-static void stl_echpci64intr(stlbrd_t *brdp)
+static irqreturn_t stl_echpci64intr(int irq, void *dev_id, struct pt_regs *regs)
 {
 	stlpanel_t	*panelp;
 	unsigned int	ioaddr;
 	int		bnknr;
+	stlbrd_t        *brdp = (stlbrd_t *)dev_id;
+	irqreturn_t     rc = IRQ_NONE;
 
 	while (inb(brdp->ioctrl) & 0x1) {
 		for (bnknr = 0; (bnknr < brdp->nrbnks); bnknr++) {
 			ioaddr = brdp->bnkstataddr[bnknr];
 			if (inb(ioaddr) & ECH_PNLINTRPEND) {
 				panelp = brdp->bnk2panel[bnknr];
-				(* panelp->isr)(panelp, (ioaddr & 0xfffc));
+				if ((* panelp->isr)(panelp, (ioaddr & 0xfffc))
+				    != IRQ_NONE)
+					rc = IRQ_HANDLED;
 			}
 		}
 	}
+	return rc;
 }
 
 /*****************************************************************************/
@@ -2215,39 +2187,6 @@ static void stl_offintr(void *private)
 /*****************************************************************************/
 
 /*
- *	Map in interrupt vector to this driver. Check that we don't
- *	already have this vector mapped, we might be sharing this
- *	interrupt across multiple boards.
- */
-
-static int __init stl_mapirq(int irq, char *name)
-{
-	int	rc, i;
-
-#ifdef DEBUG
-	printk("stl_mapirq(irq=%d,name=%s)\n", irq, name);
-#endif
-
-	rc = 0;
-	for (i = 0; (i < stl_numintrs); i++) {
-		if (stl_gotintrs[i] == irq)
-			break;
-	}
-	if (i >= stl_numintrs) {
-		if (request_irq(irq, stl_intr, SA_SHIRQ, name, NULL) != 0) {
-			printk("STALLION: failed to register interrupt "
-				"routine for %s irq=%d\n", name, irq);
-			rc = -ENODEV;
-		} else {
-			stl_gotintrs[stl_numintrs++] = irq;
-		}
-	}
-	return(rc);
-}
-
-/*****************************************************************************/
-
-/*
  *	Initialize all the ports on a panel.
  */
 
@@ -2307,8 +2246,6 @@ static inline int stl_initeio(stlbrd_t *
 {
 	stlpanel_t	*panelp;
 	unsigned int	status;
-	char		*name;
-	int		rc;
 
 #ifdef DEBUG
 	printk("stl_initeio(brdp=%x)\n", (int) brdp);
@@ -2328,11 +2265,9 @@ static inline int stl_initeio(stlbrd_t *
 	if (brdp->brdtype == BRD_EASYIOPCI) {
 		brdp->iosize1 = 0x80;
 		brdp->iosize2 = 0x80;
-		name = "serial(EIO-PCI)";
 		outb(0x41, (brdp->ioaddr2 + 0x4c));
 	} else {
 		brdp->iosize1 = 8;
-		name = "serial(EIO)";
 		if ((brdp->irq < 0) || (brdp->irq > 15) ||
 		    (stl_vecmap[brdp->irq] == (unsigned char) 0xff)) {
 			printk("STALLION: invalid irq=%d for brd=%d\n",
@@ -2344,7 +2279,7 @@ static inline int stl_initeio(stlbrd_t *
 			brdp->ioctrl);
 	}
 
-	if (!request_region(brdp->ioaddr1, brdp->iosize1, name)) {
+	if (!request_region(brdp->ioaddr1, brdp->iosize1, stl_brdnames[brdp->brdtype])) {
 		printk(KERN_WARNING "STALLION: Warning, board %d I/O address "
 			"%x conflicts with another device\n", brdp->brdnr, 
 			brdp->ioaddr1);
@@ -2352,7 +2287,7 @@ static inline int stl_initeio(stlbrd_t *
 	}
 	
 	if (brdp->iosize2 > 0)
-		if (!request_region(brdp->ioaddr2, brdp->iosize2, name)) {
+		if (!request_region(brdp->ioaddr2, brdp->iosize2, stl_brdnames[brdp->brdtype])) {
 			printk(KERN_WARNING "STALLION: Warning, board %d I/O "
 				"address %x conflicts with another device\n",
 				brdp->brdnr, brdp->ioaddr2);
@@ -2430,8 +2365,7 @@ static inline int stl_initeio(stlbrd_t *
 	brdp->nrpanels = 1;
 	brdp->state |= BRD_FOUND;
 	brdp->hwid = status;
-	rc = stl_mapirq(brdp->irq, name);
-	return(rc);
+	return 0;
 }
 
 /*****************************************************************************/
@@ -2446,7 +2380,6 @@ static inline int stl_initech(stlbrd_t *
 	stlpanel_t	*panelp;
 	unsigned int	status, nxtid, ioaddr, conflict;
 	int		panelnr, banknr, i;
-	char		*name;
 
 #ifdef DEBUG
 	printk("stl_initech(brdp=%x)\n", (int) brdp);
@@ -2484,7 +2417,6 @@ static inline int stl_initech(stlbrd_t *
 			outb((brdp->ioctrlval | ECH_BRDENABLE), brdp->ioctrl);
 		brdp->iosize1 = 2;
 		brdp->iosize2 = 32;
-		name = "serial(EC8/32)";
 		outb(status, brdp->ioaddr1);
 		break;
 
@@ -2504,7 +2436,6 @@ static inline int stl_initech(stlbrd_t *
 		outb(ECHMC_BRDRESET, brdp->ioctrl);
 		outb(ECHMC_INTENABLE, brdp->ioctrl);
 		brdp->iosize1 = 64;
-		name = "serial(EC8/32-MC)";
 		break;
 
 	case BRD_ECHPCI:
@@ -2512,7 +2443,6 @@ static inline int stl_initech(stlbrd_t *
 		brdp->ioctrl = brdp->ioaddr1 + 2;
 		brdp->iosize1 = 4;
 		brdp->iosize2 = 8;
-		name = "serial(EC8/32-PCI)";
 		break;
 
 	case BRD_ECH64PCI:
@@ -2521,7 +2451,6 @@ static inline int stl_initech(stlbrd_t *
 		outb(0x43, (brdp->ioaddr1 + 0x4c));
 		brdp->iosize1 = 0x80;
 		brdp->iosize2 = 0x80;
-		name = "serial(EC8/64-PCI)";
 		break;
 
 	default:
@@ -2534,7 +2463,7 @@ static inline int stl_initech(stlbrd_t *
  *	Check boards for possible IO address conflicts and return fail status 
  * 	if an IO conflict found.
  */
-	if (!request_region(brdp->ioaddr1, brdp->iosize1, name)) {
+	if (!request_region(brdp->ioaddr1, brdp->iosize1, stl_brdnames[brdp->brdtype])) {
 		printk(KERN_WARNING "STALLION: Warning, board %d I/O address "
 			"%x conflicts with another device\n", brdp->brdnr, 
 			brdp->ioaddr1);
@@ -2542,7 +2471,7 @@ static inline int stl_initech(stlbrd_t *
 	}
 	
 	if (brdp->iosize2 > 0)
-		if (!request_region(brdp->ioaddr2, brdp->iosize2, name)) {
+		if (!request_region(brdp->ioaddr2, brdp->iosize2, stl_brdnames[brdp->brdtype])) {
 			printk(KERN_WARNING "STALLION: Warning, board %d I/O "
 				"address %x conflicts with another device\n",
 				brdp->brdnr, brdp->ioaddr2);
@@ -2635,8 +2564,7 @@ static inline int stl_initech(stlbrd_t *
 		outb((brdp->ioctrlval | ECH_BRDDISABLE), brdp->ioctrl);
 
 	brdp->state |= BRD_FOUND;
-	i = stl_mapirq(brdp->irq, name);
-	return(i);
+	return 0;
 }
 
 /*****************************************************************************/
@@ -2685,6 +2613,16 @@ static int __init stl_brdinit(stlbrd_t *
 		if (brdp->panels[i] != (stlpanel_t *) NULL)
 			stl_initports(brdp, brdp->panels[i]);
 
+	if (request_irq(brdp->irq, brdp->isr, SA_SHIRQ, stl_brdnames[brdp->brdtype], brdp) != 0) {
+		printk("STALLION: failed to register interrupt "
+		       "routine for %s irq=%d\n", stl_brdnames[brdp->brdtype], brdp->irq);
+		if (brdp->iosize1 > 0)
+			release_region(brdp->ioaddr1, brdp->iosize1);
+		if (brdp->iosize2 > 0)
+			release_region(brdp->ioaddr2, brdp->iosize2);
+		return(EBUSY);
+	}
+
 	printk("STALLION: %s found, board=%d io=%x irq=%d "
 		"nrpanels=%d nrports=%d\n", stl_brdnames[brdp->brdtype],
 		brdp->brdnr, brdp->ioaddr1, brdp->irq, brdp->nrpanels,
@@ -2848,9 +2786,7 @@ static inline int stl_initbrds(void)
  */
 	for (i = 0; (i < stl_nrbrds); i++) {
 		confp = &stl_brdconf[i];
-#ifdef MODULE
 		stl_parsebrd(confp, stl_brdsp[i]);
-#endif
 		if ((brdp = stl_allocbrd()) == (stlbrd_t *) NULL)
 			return(-ENOMEM);
 		brdp->brdnr = i;
@@ -2866,9 +2802,7 @@ static inline int stl_initbrds(void)
  *	Find any dynamically supported boards. That is via module load
  *	line options or auto-detected on the PCI bus.
  */
-#ifdef MODULE
 	stl_argbrds();
-#endif
 #ifdef CONFIG_PCI
 	stl_findpcibrds();
 #endif
@@ -3917,7 +3851,7 @@ static int stl_cd1400datastate(stlport_t
  *	Interrupt service routine for cd1400 EasyIO boards.
  */
 
-static void stl_cd1400eiointr(stlpanel_t *panelp, unsigned int iobase)
+static irqreturn_t stl_cd1400eiointr(stlpanel_t *panelp, unsigned int iobase)
 {
 	unsigned char	svrtype;
 
@@ -3939,6 +3873,9 @@ static void stl_cd1400eiointr(stlpanel_t
 		stl_cd1400txisr(panelp, iobase);
 	else if (svrtype & SVRR_MDM)
 		stl_cd1400mdmisr(panelp, iobase);
+	else
+		return IRQ_NONE;
+	return IRQ_HANDLED;
 }
 
 /*****************************************************************************/
@@ -3947,7 +3884,7 @@ static void stl_cd1400eiointr(stlpanel_t
  *	Interrupt service routine for cd1400 panels.
  */
 
-static void stl_cd1400echintr(stlpanel_t *panelp, unsigned int iobase)
+static irqreturn_t stl_cd1400echintr(stlpanel_t *panelp, unsigned int iobase)
 {
 	unsigned char	svrtype;
 
@@ -3966,6 +3903,9 @@ static void stl_cd1400echintr(stlpanel_t
 		stl_cd1400txisr(panelp, iobase);
 	else if (svrtype & SVRR_MDM)
 		stl_cd1400mdmisr(panelp, iobase);
+	else
+		return IRQ_NONE;
+	return IRQ_HANDLED;
 }
 
 
@@ -4977,7 +4917,7 @@ static inline void stl_sc26198txunflow(s
  *	Interrupt service routine for sc26198 panels.
  */
 
-static void stl_sc26198intr(stlpanel_t *panelp, unsigned int iobase)
+static irqreturn_t stl_sc26198intr(stlpanel_t *panelp, unsigned int iobase)
 {
 	stlport_t	*portp;
 	unsigned int	iack;
@@ -4997,6 +4937,7 @@ static void stl_sc26198intr(stlpanel_t *
 		stl_sc26198txisr(portp);
 	else
 		stl_sc26198otherisr(portp, iack);
+	return IRQ_HANDLED;
 }
 
 /*****************************************************************************/
diff -uprN -X dontdiff linux-2.6.8.1-orig/include/linux/stallion.h linux-2.6.8.1/include/linux/stallion.h
--- linux-2.6.8.1-orig/include/linux/stallion.h	2004-08-24 16:04:43.000000000 +0200
+++ linux-2.6.8.1/include/linux/stallion.h	2004-08-24 16:11:04.000000000 +0200
@@ -110,7 +110,7 @@ typedef struct stlpanel {
 	int		nrports;
 	int		iobase;
 	void		*uartp;
-	void		(*isr)(struct stlpanel *panelp, unsigned int iobase);
+	irqreturn_t	(*isr)(struct stlpanel *panelp, unsigned int iobase);
 	unsigned int	hwid;
 	unsigned int	ackmask;
 	stlport_t	*ports[STL_PORTSPERPANEL];
@@ -126,7 +126,7 @@ typedef struct stlbrd {
 	int		nrbnks;
 	int		irq;
 	int		irqtype;
-	void		(*isr)(struct stlbrd *brdp);
+	irqreturn_t	(*isr)(int irq, void *dev_id, struct pt_regs *regs);
 	unsigned int	ioaddr1;
 	unsigned int	ioaddr2;
 	unsigned int	iosize1;

