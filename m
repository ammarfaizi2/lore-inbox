Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262509AbVAPONQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbVAPONQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 09:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbVAPOMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 09:12:00 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:10130 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S262515AbVAPNx5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 08:53:57 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Cc: akpm@osdl.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050116135351.30109.10028.75174@localhost.localdomain>
In-Reply-To: <20050116135223.30109.26479.55757@localhost.localdomain>
References: <20050116135223.30109.26479.55757@localhost.localdomain>
Subject: [PATCH 13/13] stallion: remove cli()/sti() in drivers/char/stallion.c
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [209.158.220.243] at Sun, 16 Jan 2005 07:53:51 -0600
Date: Sun, 16 Jan 2005 07:53:54 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.11-rc1-mm1-original/drivers/char/stallion.c linux-2.6.11-rc1-mm1/drivers/char/stallion.c
--- linux-2.6.11-rc1-mm1-original/drivers/char/stallion.c	2004-12-24 16:35:23.000000000 -0500
+++ linux-2.6.11-rc1-mm1/drivers/char/stallion.c	2005-01-16 07:32:19.543523749 -0500
@@ -749,10 +749,9 @@
 	printk("init_module()\n");
 #endif
 
-	save_flags(flags);
-	cli();
+	local_irq_save_(flags);
 	stl_init();
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return(0);
 }
@@ -774,8 +773,7 @@
 	printk(KERN_INFO "Unloading %s: version %s\n", stl_drvtitle,
 		stl_drvversion);
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 /*
  *	Free up all allocated resources used by the ports. This includes
@@ -788,8 +786,7 @@
 	if (i) {
 		printk("STALLION: failed to un-register tty driver, "
 			"errno=%d\n", -i);
-		restore_flags(flags);
-		return;
+		goto out;
 	}
 	for (i = 0; i < 4; i++) {
 		devfs_remove("staliomem/%d", i);
@@ -835,7 +832,7 @@
 	for (i = 0; (i < stl_numintrs); i++)
 		free_irq(stl_gotintrs[i], NULL);
 
-	restore_flags(flags);
+out:	local_irq_restore(flags);
 }
 
 module_init(stallion_module_init);
@@ -1106,8 +1103,7 @@
 	if (portp->tty->termios->c_cflag & CLOCAL)
 		doclocal++;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	portp->openwaitcnt++;
 	if (! tty_hung_up_p(filp))
 		portp->refcount--;
@@ -1136,7 +1132,7 @@
 	if (! tty_hung_up_p(filp))
 		portp->refcount++;
 	portp->openwaitcnt--;
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return(rc);
 }
@@ -1156,18 +1152,14 @@
 	if (portp == (stlport_t *) NULL)
 		return;
 
-	save_flags(flags);
-	cli();
-	if (tty_hung_up_p(filp)) {
-		restore_flags(flags);
-		return;
-	}
+	local_irq_save(flags);
+	if (tty_hung_up_p(filp))
+		goto out;
+
 	if ((tty->count == 1) && (portp->refcount != 1))
 		portp->refcount = 1;
-	if (portp->refcount-- > 1) {
-		restore_flags(flags);
-		return;
-	}
+	if (portp->refcount-- > 1)
+		goto out;
 
 	portp->refcount = 0;
 	portp->flags |= ASYNC_CLOSING;
@@ -1210,7 +1202,7 @@
 
 	portp->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
 	wake_up_interruptible(&portp->close_wait);
-	restore_flags(flags);
+out:	local_irq_restore(flags);
 }
 
 /*****************************************************************************/
@@ -2934,8 +2926,7 @@
 	portp->stats.lflags = 0;
 	portp->stats.rxbuffered = 0;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	if (portp->tty != (struct tty_struct *) NULL) {
 		if (portp->tty->driver_data == portp) {
 			portp->stats.ttystate = portp->tty->flags;
@@ -2948,7 +2939,7 @@
 			}
 		}
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	head = portp->tx.head;
 	tail = portp->tx.tail;
@@ -3480,8 +3471,7 @@
 		tiosp->c_cc[VSTART], tiosp->c_cc[VSTOP]);
 #endif
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_cd1400setreg(portp, CAR, (portp->portnr & 0x3));
 	srer = stl_cd1400getreg(portp, SRER);
@@ -3518,7 +3508,7 @@
 		portp->sigs &= ~TIOCM_CD;
 	stl_cd1400setreg(portp, SRER, ((srer & ~sreroff) | sreron));
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /*****************************************************************************/
@@ -3544,8 +3534,7 @@
 	if (rts > 0)
 		msvr2 = MSVR2_RTS;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_cd1400setreg(portp, CAR, (portp->portnr & 0x03));
 	if (rts >= 0)
@@ -3553,7 +3542,7 @@
 	if (dtr >= 0)
 		stl_cd1400setreg(portp, MSVR1, msvr1);
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /*****************************************************************************/
@@ -3572,14 +3561,13 @@
 	printk("stl_cd1400getsignals(portp=%x)\n", (int) portp);
 #endif
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_cd1400setreg(portp, CAR, (portp->portnr & 0x03));
 	msvr1 = stl_cd1400getreg(portp, MSVR1);
 	msvr2 = stl_cd1400getreg(portp, MSVR2);
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	sigs = 0;
 	sigs |= (msvr1 & MSVR1_DCD) ? TIOCM_CD : 0;
@@ -3621,15 +3609,14 @@
 	else if (rx > 0)
 		ccr |= CCR_RXENABLE;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_cd1400setreg(portp, CAR, (portp->portnr & 0x03));
 	stl_cd1400ccrwait(portp);
 	stl_cd1400setreg(portp, CCR, ccr);
 	stl_cd1400ccrwait(portp);
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /*****************************************************************************/
@@ -3661,8 +3648,7 @@
 	else if (rx > 0)
 		sreron |= SRER_RXDATA;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_cd1400setreg(portp, CAR, (portp->portnr & 0x03));
 	stl_cd1400setreg(portp, SRER,
@@ -3670,7 +3656,7 @@
 	BRDDISABLE(portp->brdnr);
 	if (tx > 0)
 		set_bit(ASYI_TXBUSY, &portp->istate);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /*****************************************************************************/
@@ -3686,13 +3672,12 @@
 #ifdef DEBUG
 	printk("stl_cd1400disableintrs(portp=%x)\n", (int) portp);
 #endif
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_cd1400setreg(portp, CAR, (portp->portnr & 0x03));
 	stl_cd1400setreg(portp, SRER, 0);
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /*****************************************************************************/
@@ -3705,8 +3690,7 @@
 	printk("stl_cd1400sendbreak(portp=%x,len=%d)\n", (int) portp, len);
 #endif
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_cd1400setreg(portp, CAR, (portp->portnr & 0x03));
 	stl_cd1400setreg(portp, SRER,
@@ -3716,7 +3700,7 @@
 	portp->brklen = len;
 	if (len == 1)
 		portp->stats.txbreaks++;
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /*****************************************************************************/
@@ -3740,8 +3724,7 @@
 	if (tty == (struct tty_struct *) NULL)
 		return;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_cd1400setreg(portp, CAR, (portp->portnr & 0x03));
 
@@ -3781,7 +3764,7 @@
 	}
 
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /*****************************************************************************/
@@ -3805,8 +3788,7 @@
 	if (tty == (struct tty_struct *) NULL)
 		return;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_cd1400setreg(portp, CAR, (portp->portnr & 0x03));
 	if (state) {
@@ -3821,7 +3803,7 @@
 		stl_cd1400ccrwait(portp);
 	}
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /*****************************************************************************/
@@ -3837,8 +3819,7 @@
 	if (portp == (stlport_t *) NULL)
 		return;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_cd1400setreg(portp, CAR, (portp->portnr & 0x03));
 	stl_cd1400ccrwait(portp);
@@ -3846,7 +3827,7 @@
 	stl_cd1400ccrwait(portp);
 	portp->tx.tail = portp->tx.head;
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /*****************************************************************************/
@@ -4496,8 +4477,7 @@
 		tiosp->c_cc[VSTART], tiosp->c_cc[VSTOP]);
 #endif
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_sc26198setreg(portp, IMR, 0);
 	stl_sc26198updatereg(portp, MR0, mr0);
@@ -4524,7 +4504,7 @@
 	portp->imr = (portp->imr & ~imroff) | imron;
 	stl_sc26198setreg(portp, IMR, portp->imr);
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /*****************************************************************************/
@@ -4554,13 +4534,12 @@
 	else if (rts > 0)
 		iopioron |= IPR_RTS;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_sc26198setreg(portp, IOPIOR,
 		((stl_sc26198getreg(portp, IOPIOR) & ~iopioroff) | iopioron));
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /*****************************************************************************/
@@ -4579,12 +4558,11 @@
 	printk("stl_sc26198getsignals(portp=%x)\n", (int) portp);
 #endif
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	ipr = stl_sc26198getreg(portp, IPR);
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	sigs = 0;
 	sigs |= (ipr & IPR_DCD) ? 0 : TIOCM_CD;
@@ -4621,13 +4599,12 @@
 	else if (rx > 0)
 		ccr |= CR_RXENABLE;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_sc26198setreg(portp, SCCR, ccr);
 	BRDDISABLE(portp->brdnr);
 	portp->crenable = ccr;
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /*****************************************************************************/
@@ -4656,15 +4633,14 @@
 	else if (rx > 0)
 		imr |= IR_RXRDY | IR_RXBREAK | IR_RXWATCHDOG;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_sc26198setreg(portp, IMR, imr);
 	BRDDISABLE(portp->brdnr);
 	portp->imr = imr;
 	if (tx > 0)
 		set_bit(ASYI_TXBUSY, &portp->istate);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /*****************************************************************************/
@@ -4681,13 +4657,12 @@
 	printk("stl_sc26198disableintrs(portp=%x)\n", (int) portp);
 #endif
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	portp->imr = 0;
 	stl_sc26198setreg(portp, IMR, 0);
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /*****************************************************************************/
@@ -4700,8 +4675,7 @@
 	printk("stl_sc26198sendbreak(portp=%x,len=%d)\n", (int) portp, len);
 #endif
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	if (len == 1) {
 		stl_sc26198setreg(portp, SCCR, CR_TXSTARTBREAK);
@@ -4710,7 +4684,7 @@
 		stl_sc26198setreg(portp, SCCR, CR_TXSTOPBREAK);
 	}
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /*****************************************************************************/
@@ -4735,8 +4709,7 @@
 	if (tty == (struct tty_struct *) NULL)
 		return;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 
 	if (state) {
@@ -4782,7 +4755,7 @@
 	}
 
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /*****************************************************************************/
@@ -4807,8 +4780,7 @@
 	if (tty == (struct tty_struct *) NULL)
 		return;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	if (state) {
 		mr0 = stl_sc26198getreg(portp, MR0);
@@ -4828,7 +4800,7 @@
 		stl_sc26198setreg(portp, MR0, mr0);
 	}
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /*****************************************************************************/
@@ -4844,14 +4816,13 @@
 	if (portp == (stlport_t *) NULL)
 		return;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	stl_sc26198setreg(portp, SCCR, CR_TXRESET);
 	stl_sc26198setreg(portp, SCCR, portp->crenable);
 	BRDDISABLE(portp->brdnr);
 	portp->tx.tail = portp->tx.head;
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /*****************************************************************************/
@@ -4878,12 +4849,11 @@
 	if (test_bit(ASYI_TXBUSY, &portp->istate))
 		return(1);
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	BRDENABLE(portp->brdnr, portp->pagenr);
 	sr = stl_sc26198getreg(portp, SR);
 	BRDDISABLE(portp->brdnr);
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return((sr & SR_TXEMPTY) ? 0 : 1);
 }
