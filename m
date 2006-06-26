Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWFZUg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWFZUg2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWFZUg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:36:28 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34445 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932087AbWFZUg1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:36:27 -0400
Subject: PATCH: stallion clean up: Re: [2.6 patch] mark
	virt_to_bus/bus_to_virt as __deprecated on i386
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060626161411.GT23314@stusta.de>
References: <20060626151012.GR23314@stusta.de>
	 <20060626153834.GA18599@redhat.com>  <20060626161411.GT23314@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 26 Jun 2006 21:50:13 +0100
Message-Id: <1151355014.27147.73.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There are few drivers generating many warnings, e.g. stallion+istallion 
> alone give 138 __deprecated warnings only for cli/sti/restore_flags 
> usage. Most of the code doesn't have any problems.

Stallion locking is easy to fix as far as I can tell. I've left the
wake/sleep stuff for a janitor project

Signed-off-by: Alan Cox <alan@redhat.com>

There are two locking sets involved. One locks the board mappings and the
other is the tty open/close locking. The low level code was clearly designed
to be ported to OS's with spin locks already so pretty much comes out in the
wash

--- linux.vanilla-2.6.17/drivers/char/stallion.c	2006-06-19 17:29:45.000000000 +0100
+++ linux-2.6.17/drivers/char/stallion.c	2006-06-26 21:18:04.015037064 +0100
@@ -141,15 +141,6 @@
 static struct tty_driver	*stl_serial;
 
 /*
- *	We will need to allocate a temporary write buffer for chars that
- *	come direct from user space. The problem is that a copy from user
- *	space might cause a page fault (typically on a system that is
- *	swapping!). All ports will share one buffer - since if the system
- *	is already swapping a shared buffer won't make things any worse.
- */
-static char			*stl_tmpwritebuf;
-
-/*
  *	Define a local default termios struct. All ports will be created
  *	with this termios initially. Basically all it defines is a raw port
  *	at 9600, 8 data bits, 1 stop bit.
@@ -363,6 +354,14 @@
 };
 
 /*
+ *	Lock ordering is that you may not take stallion_lock holding
+ *	brd_lock.
+ */
+ 
+static spinlock_t brd_lock; 		/* Guard the board mapping */
+static spinlock_t stallion_lock;	/* Guard the tty driver */
+
+/*
  *	Set up enable and disable macros for the ECH boards. They require
  *	the secondary io address space to be activated and deactivated.
  *	This way all ECH boards can share their secondary io region.
@@ -725,17 +724,7 @@
 
 static int __init stallion_module_init(void)
 {
-	unsigned long	flags;
-
-#ifdef DEBUG
-	printk("init_module()\n");
-#endif
-
-	save_flags(flags);
-	cli();
 	stl_init();
-	restore_flags(flags);
-
 	return 0;
 }
 
@@ -746,7 +735,6 @@
 	stlbrd_t	*brdp;
 	stlpanel_t	*panelp;
 	stlport_t	*portp;
-	unsigned long	flags;
 	int		i, j, k;
 
 #ifdef DEBUG
@@ -756,9 +744,6 @@
 	printk(KERN_INFO "Unloading %s: version %s\n", stl_drvtitle,
 		stl_drvversion);
 
-	save_flags(flags);
-	cli();
-
 /*
  *	Free up all allocated resources used by the ports. This includes
  *	memory and interrupts. As part of this process we will also do
@@ -770,7 +755,6 @@
 	if (i) {
 		printk("STALLION: failed to un-register tty driver, "
 			"errno=%d\n", -i);
-		restore_flags(flags);
 		return;
 	}
 	for (i = 0; i < 4; i++) {
@@ -783,8 +767,6 @@
 			"errno=%d\n", -i);
 	class_destroy(stallion_class);
 
-	kfree(stl_tmpwritebuf);
-
 	for (i = 0; (i < stl_nrbrds); i++) {
 		if ((brdp = stl_brds[i]) == (stlbrd_t *) NULL)
 			continue;
@@ -814,8 +796,6 @@
 		kfree(brdp);
 		stl_brds[i] = (stlbrd_t *) NULL;
 	}
-
-	restore_flags(flags);
 }
 
 module_init(stallion_module_init);
@@ -948,7 +928,7 @@
 
 	brdp = kzalloc(sizeof(stlbrd_t), GFP_KERNEL);
 	if (!brdp) {
-		printk("STALLION: failed to allocate memory (size=%d)\n",
+		printk("STALLION: failed to allocate memory (size=%Zd)\n",
 			sizeof(stlbrd_t));
 		return NULL;
 	}
@@ -1066,16 +1046,17 @@
 	rc = 0;
 	doclocal = 0;
 
+	spin_lock_irqsave(&stallion_lock, flags);
+
 	if (portp->tty->termios->c_cflag & CLOCAL)
 		doclocal++;
 
-	save_flags(flags);
-	cli();
 	portp->openwaitcnt++;
 	if (! tty_hung_up_p(filp))
 		portp->refcount--;
 
 	for (;;) {
+		/* Takes brd_lock internally */
 		stl_setsignals(portp, 1, 1);
 		if (tty_hung_up_p(filp) ||
 		    ((portp->flags & ASYNC_INITIALIZED) == 0)) {
@@ -1093,13 +1074,14 @@
 			rc = -ERESTARTSYS;
 			break;
 		}
+		/* FIXME */
 		interruptible_sleep_on(&portp->open_wait);
 	}
 
 	if (! tty_hung_up_p(filp))
 		portp->refcount++;
 	portp->openwaitcnt--;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&stallion_lock, flags);
 
 	return rc;
 }
@@ -1119,16 +1101,15 @@
 	if (portp == (stlport_t *) NULL)
 		return;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&stallion_lock, flags);
 	if (tty_hung_up_p(filp)) {
-		restore_flags(flags);
+		spin_unlock_irqrestore(&stallion_lock, flags);
 		return;
 	}
 	if ((tty->count == 1) && (portp->refcount != 1))
 		portp->refcount = 1;
 	if (portp->refcount-- > 1) {
-		restore_flags(flags);
+		spin_unlock_irqrestore(&stallion_lock, flags);
 		return;
 	}
 
@@ -1142,11 +1123,18 @@
  *	(The sc26198 has no "end-of-data" interrupt only empty FIFO)
  */
 	tty->closing = 1;
+	
+	spin_unlock_irqrestore(&stallion_lock, flags);
+	
 	if (portp->closing_wait != ASYNC_CLOSING_WAIT_NONE)
 		tty_wait_until_sent(tty, portp->closing_wait);
 	stl_waituntilsent(tty, (HZ / 2));
 
+
+	spin_lock_irqsave(&stallion_lock, flags);
 	portp->flags &= ~ASYNC_INITIALIZED;
+	spin_unlock_irqrestore(&stallion_lock, flags);
+	
 	stl_disableintrs(portp);
 	if (tty->termios->c_cflag & HUPCL)
 		stl_setsignals(portp, 0, 0);
@@ -1173,7 +1161,6 @@
 
 	portp->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
 	wake_up_interruptible(&portp->close_wait);
-	restore_flags(flags);
 }
 
 /*****************************************************************************/
@@ -1195,9 +1182,6 @@
 		(int) tty, (int) buf, count);
 #endif
 
-	if ((tty == (struct tty_struct *) NULL) ||
-	    (stl_tmpwritebuf == (char *) NULL))
-		return 0;
 	portp = tty->driver_data;
 	if (portp == (stlport_t *) NULL)
 		return 0;
@@ -1302,11 +1286,6 @@
 	if (portp->tx.buf == (char *) NULL)
 		return;
 
-#if 0
-	if (tty->stopped || tty->hw_stopped ||
-	    (portp->tx.head == portp->tx.tail))
-		return;
-#endif
 	stl_startrxtx(portp, -1, 1);
 }
 
@@ -1977,12 +1956,14 @@
 	unsigned int	iobase;
 	int		handled = 0;
 
+	spin_lock(&brd_lock);
 	panelp = brdp->panels[0];
 	iobase = panelp->iobase;
 	while (inb(brdp->iostatus) & EIO_INTRPEND) {
 		handled = 1;
 		(* panelp->isr)(panelp, iobase);
 	}
+	spin_unlock(&brd_lock);
 	return handled;
 }
 
@@ -2168,7 +2149,7 @@
 		portp = kzalloc(sizeof(stlport_t), GFP_KERNEL);
 		if (!portp) {
 			printk("STALLION: failed to allocate memory "
-				"(size=%d)\n", sizeof(stlport_t));
+				"(size=%Zd)\n", sizeof(stlport_t));
 			break;
 		}
 
@@ -2304,7 +2285,7 @@
 	panelp = kzalloc(sizeof(stlpanel_t), GFP_KERNEL);
 	if (!panelp) {
 		printk(KERN_WARNING "STALLION: failed to allocate memory "
-			"(size=%d)\n", sizeof(stlpanel_t));
+			"(size=%Zd)\n", sizeof(stlpanel_t));
 		return -ENOMEM;
 	}
 
@@ -2478,7 +2459,7 @@
 		panelp = kzalloc(sizeof(stlpanel_t), GFP_KERNEL);
 		if (!panelp) {
 			printk("STALLION: failed to allocate memory "
-				"(size=%d)\n", sizeof(stlpanel_t));
+				"(size=%Zd)\n", sizeof(stlpanel_t));
 			break;
 		}
 		panelp->magic = STL_PANELMAGIC;
@@ -2879,8 +2860,7 @@
 	portp->stats.lflags = 0;
 	portp->stats.rxbuffered = 0;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&stallion_lock, flags);
 	if (portp->tty != (struct tty_struct *) NULL) {
 		if (portp->tty->driver_data == portp) {
 			portp->stats.ttystate = portp->tty->flags;
@@ -2894,7 +2874,7 @@
 			}
 		}
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&stallion_lock, flags);
 
 	head = portp->tx.head;
 	tail = portp->tx.tail;
@@ -3056,14 +3036,6 @@
 		return -1;
 
 /*
- *	Allocate a temporary write buffer.
- */
-	stl_tmpwritebuf = kmalloc(STL_TXBUFSIZE, GFP_KERNEL);
-	if (!stl_tmpwritebuf)
-		printk("STALLION: failed to allocate memory (size=%d)\n",
-			STL_TXBUFSIZE);
-
-/*
  *	Set up a character driver for per board stuff. This is mainly used
  *	to do stats ioctls on the ports.
  */
@@ -3147,11 +3119,13 @@
 	unsigned int	gfrcr;
 	int		chipmask, i, j;
 	int		nrchips, uartaddr, ioaddr;
+	unsigned long   flags;
 
 #ifdef DEBUG
 	printk("stl_panelinit(brdp=%x,panelp=%x)\n", (int) brdp, (int) panelp);
 #endif
 
+	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(panelp->brdnr, panelp->pagenr);
 
 /*
@@ -3189,6 +3163,7 @@
 	}
 
 	BRDDISABLE(panelp->brdnr);
+	spin_unlock_irqrestore(&brd_lock, flags);
 	return chipmask;
 }
 
@@ -3200,6 +3175,7 @@
 
 static void stl_cd1400portinit(stlbrd_t *brdp, stlpanel_t *panelp, stlport_t *portp)
 {
+	unsigned long flags;
 #ifdef DEBUG
 	printk("stl_cd1400portinit(brdp=%x,panelp=%x,portp=%x)\n",
 		(int) brdp, (int) panelp, (int) portp);
@@ -3209,6 +3185,7 @@
 	    (portp == (stlport_t *) NULL))
 		return;
 
+	spin_lock_irqsave(&brd_lock, flags);
 	portp->ioaddr = panelp->iobase + (((brdp->brdtype == BRD_ECHPCI) ||
 		(portp->portnr < 8)) ? 0 : EREG_BANKSIZE);
 	portp->uartaddr = (portp->portnr & 0x04) << 5;
@@ -3219,6 +3196,7 @@
 	stl_cd1400setreg(portp, LIVR, (portp->portnr << 3));
 	portp->hwid = stl_cd1400getreg(portp, GFRCR);
 	BRDDISABLE(portp->brdnr);
+	spin_unlock_irqrestore(&brd_lock, flags);
 }
 
 /*****************************************************************************/
@@ -3428,8 +3406,7 @@
 		tiosp->c_cc[VSTART], tiosp->c_cc[VSTOP]);
 #endif
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_cd1400setreg(portp, CAR, (portp->portnr & 0x3));
 	srer = stl_cd1400getreg(portp, SRER);
@@ -3466,7 +3443,7 @@
 		portp->sigs &= ~TIOCM_CD;
 	stl_cd1400setreg(portp, SRER, ((srer & ~sreroff) | sreron));
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&brd_lock, flags);
 }
 
 /*****************************************************************************/
@@ -3492,8 +3469,7 @@
 	if (rts > 0)
 		msvr2 = MSVR2_RTS;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_cd1400setreg(portp, CAR, (portp->portnr & 0x03));
 	if (rts >= 0)
@@ -3501,7 +3477,7 @@
 	if (dtr >= 0)
 		stl_cd1400setreg(portp, MSVR1, msvr1);
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&brd_lock, flags);
 }
 
 /*****************************************************************************/
@@ -3520,14 +3496,13 @@
 	printk("stl_cd1400getsignals(portp=%x)\n", (int) portp);
 #endif
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_cd1400setreg(portp, CAR, (portp->portnr & 0x03));
 	msvr1 = stl_cd1400getreg(portp, MSVR1);
 	msvr2 = stl_cd1400getreg(portp, MSVR2);
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&brd_lock, flags);
 
 	sigs = 0;
 	sigs |= (msvr1 & MSVR1_DCD) ? TIOCM_CD : 0;
@@ -3569,15 +3544,14 @@
 	else if (rx > 0)
 		ccr |= CCR_RXENABLE;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_cd1400setreg(portp, CAR, (portp->portnr & 0x03));
 	stl_cd1400ccrwait(portp);
 	stl_cd1400setreg(portp, CCR, ccr);
 	stl_cd1400ccrwait(portp);
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&brd_lock, flags);
 }
 
 /*****************************************************************************/
@@ -3609,8 +3583,7 @@
 	else if (rx > 0)
 		sreron |= SRER_RXDATA;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_cd1400setreg(portp, CAR, (portp->portnr & 0x03));
 	stl_cd1400setreg(portp, SRER,
@@ -3618,7 +3591,7 @@
 	BRDDISABLE(portp->brdnr);
 	if (tx > 0)
 		set_bit(ASYI_TXBUSY, &portp->istate);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&brd_lock, flags);
 }
 
 /*****************************************************************************/
@@ -3634,13 +3607,12 @@
 #ifdef DEBUG
 	printk("stl_cd1400disableintrs(portp=%x)\n", (int) portp);
 #endif
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_cd1400setreg(portp, CAR, (portp->portnr & 0x03));
 	stl_cd1400setreg(portp, SRER, 0);
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&brd_lock, flags);
 }
 
 /*****************************************************************************/
@@ -3653,8 +3625,7 @@
 	printk("stl_cd1400sendbreak(portp=%x,len=%d)\n", (int) portp, len);
 #endif
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_cd1400setreg(portp, CAR, (portp->portnr & 0x03));
 	stl_cd1400setreg(portp, SRER,
@@ -3664,7 +3635,7 @@
 	portp->brklen = len;
 	if (len == 1)
 		portp->stats.txbreaks++;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&brd_lock, flags);
 }
 
 /*****************************************************************************/
@@ -3688,8 +3659,7 @@
 	if (tty == (struct tty_struct *) NULL)
 		return;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_cd1400setreg(portp, CAR, (portp->portnr & 0x03));
 
@@ -3729,7 +3699,7 @@
 	}
 
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&brd_lock, flags);
 }
 
 /*****************************************************************************/
@@ -3753,8 +3723,7 @@
 	if (tty == (struct tty_struct *) NULL)
 		return;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_cd1400setreg(portp, CAR, (portp->portnr & 0x03));
 	if (state) {
@@ -3769,7 +3738,7 @@
 		stl_cd1400ccrwait(portp);
 	}
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&brd_lock, flags);
 }
 
 /*****************************************************************************/
@@ -3785,8 +3754,7 @@
 	if (portp == (stlport_t *) NULL)
 		return;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_cd1400setreg(portp, CAR, (portp->portnr & 0x03));
 	stl_cd1400ccrwait(portp);
@@ -3794,7 +3762,7 @@
 	stl_cd1400ccrwait(portp);
 	portp->tx.tail = portp->tx.head;
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&brd_lock, flags);
 }
 
 /*****************************************************************************/
@@ -3833,6 +3801,7 @@
 		(int) panelp, iobase);
 #endif
 
+	spin_lock(&brd_lock);
 	outb(SVRR, iobase);
 	svrtype = inb(iobase + EREG_DATA);
 	if (panelp->nrports > 4) {
@@ -3846,6 +3815,8 @@
 		stl_cd1400txisr(panelp, iobase);
 	else if (svrtype & SVRR_MDM)
 		stl_cd1400mdmisr(panelp, iobase);
+		
+	spin_unlock(&brd_lock);
 }
 
 /*****************************************************************************/
@@ -4433,8 +4404,7 @@
 		tiosp->c_cc[VSTART], tiosp->c_cc[VSTOP]);
 #endif
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_sc26198setreg(portp, IMR, 0);
 	stl_sc26198updatereg(portp, MR0, mr0);
@@ -4461,7 +4431,7 @@
 	portp->imr = (portp->imr & ~imroff) | imron;
 	stl_sc26198setreg(portp, IMR, portp->imr);
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&brd_lock, flags);
 }
 
 /*****************************************************************************/
@@ -4491,13 +4461,12 @@
 	else if (rts > 0)
 		iopioron |= IPR_RTS;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_sc26198setreg(portp, IOPIOR,
 		((stl_sc26198getreg(portp, IOPIOR) & ~iopioroff) | iopioron));
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&brd_lock, flags);
 }
 
 /*****************************************************************************/
@@ -4516,12 +4485,11 @@
 	printk("stl_sc26198getsignals(portp=%x)\n", (int) portp);
 #endif
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	ipr = stl_sc26198getreg(portp, IPR);
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&brd_lock, flags);
 
 	sigs = 0;
 	sigs |= (ipr & IPR_DCD) ? 0 : TIOCM_CD;
@@ -4558,13 +4526,12 @@
 	else if (rx > 0)
 		ccr |= CR_RXENABLE;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_sc26198setreg(portp, SCCR, ccr);
 	BRDDISABLE(portp->brdnr);
 	portp->crenable = ccr;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&brd_lock, flags);
 }
 
 /*****************************************************************************/
@@ -4593,15 +4560,14 @@
 	else if (rx > 0)
 		imr |= IR_RXRDY | IR_RXBREAK | IR_RXWATCHDOG;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_sc26198setreg(portp, IMR, imr);
 	BRDDISABLE(portp->brdnr);
 	portp->imr = imr;
 	if (tx > 0)
 		set_bit(ASYI_TXBUSY, &portp->istate);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&brd_lock, flags);
 }
 
 /*****************************************************************************/
@@ -4618,13 +4584,12 @@
 	printk("stl_sc26198disableintrs(portp=%x)\n", (int) portp);
 #endif
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	portp->imr = 0;
 	stl_sc26198setreg(portp, IMR, 0);
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&brd_lock, flags);
 }
 
 /*****************************************************************************/
@@ -4637,8 +4602,7 @@
 	printk("stl_sc26198sendbreak(portp=%x,len=%d)\n", (int) portp, len);
 #endif
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	if (len == 1) {
 		stl_sc26198setreg(portp, SCCR, CR_TXSTARTBREAK);
@@ -4647,7 +4611,7 @@
 		stl_sc26198setreg(portp, SCCR, CR_TXSTOPBREAK);
 	}
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&brd_lock, flags);
 }
 
 /*****************************************************************************/
@@ -4672,8 +4636,7 @@
 	if (tty == (struct tty_struct *) NULL)
 		return;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 
 	if (state) {
@@ -4719,7 +4682,7 @@
 	}
 
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&brd_lock, flags);
 }
 
 /*****************************************************************************/
@@ -4744,8 +4707,7 @@
 	if (tty == (struct tty_struct *) NULL)
 		return;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	if (state) {
 		mr0 = stl_sc26198getreg(portp, MR0);
@@ -4765,7 +4727,7 @@
 		stl_sc26198setreg(portp, MR0, mr0);
 	}
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&brd_lock, flags);
 }
 
 /*****************************************************************************/
@@ -4781,14 +4743,13 @@
 	if (portp == (stlport_t *) NULL)
 		return;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_sc26198setreg(portp, SCCR, CR_TXRESET);
 	stl_sc26198setreg(portp, SCCR, portp->crenable);
 	BRDDISABLE(portp->brdnr);
 	portp->tx.tail = portp->tx.head;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&brd_lock, flags);
 }
 
 /*****************************************************************************/
@@ -4815,12 +4776,11 @@
 	if (test_bit(ASYI_TXBUSY, &portp->istate))
 		return 1;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&brd_lock, flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	sr = stl_sc26198getreg(portp, SR);
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&brd_lock, flags);
 
 	return (sr & SR_TXEMPTY) ? 0 : 1;
 }
@@ -4877,6 +4837,8 @@
 {
 	stlport_t	*portp;
 	unsigned int	iack;
+	
+	spin_lock(&brd_lock);
 
 /* 
  *	Work around bug in sc26198 chip... Cannot have A6 address
@@ -4893,6 +4855,8 @@
 		stl_sc26198txisr(portp);
 	else
 		stl_sc26198otherisr(portp, iack);
+		
+	spin_unlock(&brd_lock);
 }
 
 /*****************************************************************************/

