Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262510AbVAPOA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262510AbVAPOA7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 09:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbVAPOAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 09:00:14 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:21644 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S262510AbVAPNxL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 08:53:11 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Cc: akpm@osdl.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050116135310.30109.46857.21157@localhost.localdomain>
In-Reply-To: <20050116135223.30109.26479.55757@localhost.localdomain>
References: <20050116135223.30109.26479.55757@localhost.localdomain>
Subject: [PATCH 7/13] istallion: remove cli()/sti() in drivers/char/istallion.c
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [209.158.220.243] at Sun, 16 Jan 2005 07:53:10 -0600
Date: Sun, 16 Jan 2005 07:53:11 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.11-rc1-mm1-original/drivers/char/istallion.c linux-2.6.11-rc1-mm1/drivers/char/istallion.c
--- linux-2.6.11-rc1-mm1-original/drivers/char/istallion.c	2004-12-24 16:35:00.000000000 -0500
+++ linux-2.6.11-rc1-mm1/drivers/char/istallion.c	2005-01-16 07:32:19.327552657 -0500
@@ -807,10 +807,9 @@
 	printk("init_module()\n");
 #endif
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	stli_init();
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return(0);
 }
@@ -831,8 +830,7 @@
 	printk(KERN_INFO "Unloading %s: version %s\n", stli_drvtitle,
 		stli_drvversion);
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 /*
  *	Free up all allocated resources used by the ports. This includes
@@ -847,8 +845,7 @@
 	if (i) {
 		printk("STALLION: failed to un-register tty driver, "
 			"errno=%d\n", -i);
-		restore_flags(flags);
-		return;
+		goto out;
 	}
 	put_tty_driver(stli_serial);
 	for (i = 0; i < 4; i++) {
@@ -884,7 +881,7 @@
 		stli_brds[i] = (stlibrd_t *) NULL;
 	}
 
-	restore_flags(flags);
+out:	local_irq_restore(flags);
 }
 
 module_init(istallion_module_init);
@@ -1128,18 +1125,14 @@
 	if (portp == (stliport_t *) NULL)
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
 
 	portp->flags |= ASYNC_CLOSING;
 
@@ -1185,7 +1178,7 @@
 
 	portp->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
 	wake_up_interruptible(&portp->close_wait);
-	restore_flags(flags);
+out:	local_irq_restore(flags);
 }
 
 /*****************************************************************************/
@@ -1266,8 +1259,7 @@
 /*
  *	Send a message to the slave to open this port.
  */
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 /*
  *	Slave is already closing this port. This can happen if a hangup
@@ -1277,7 +1269,7 @@
  */
 	while (test_bit(ST_CLOSING, &portp->state)) {
 		if (signal_pending(current)) {
-			restore_flags(flags);
+			local_irq_restore(flags);
 			return(-ERESTARTSYS);
 		}
 		interruptible_sleep_on(&portp->raw_wait);
@@ -1299,7 +1291,7 @@
 	EBRDDISABLE(brdp);
 
 	if (wait == 0) {
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return(0);
 	}
 
@@ -1316,7 +1308,7 @@
 		}
 		interruptible_sleep_on(&portp->raw_wait);
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	if ((rc == 0) && (portp->rc != 0))
 		rc = -EIO;
@@ -1344,8 +1336,7 @@
 		(int) brdp, (int) portp, (int) arg, wait);
 #endif
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 /*
  *	Slave is already closing this port. This can happen if a hangup
@@ -1354,7 +1345,7 @@
 	if (wait) {
 		while (test_bit(ST_CLOSING, &portp->state)) {
 			if (signal_pending(current)) {
-				restore_flags(flags);
+				local_irq_restore(flags);
 				return(-ERESTARTSYS);
 			}
 			interruptible_sleep_on(&portp->raw_wait);
@@ -1376,7 +1367,7 @@
 
 	set_bit(ST_CLOSING, &portp->state);
 	if (wait == 0) {
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return(0);
 	}
 
@@ -1392,7 +1383,7 @@
 		}
 		interruptible_sleep_on(&portp->raw_wait);
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	if ((rc == 0) && (portp->rc != 0))
 		rc = -EIO;
@@ -1418,11 +1409,10 @@
 		(int) arg, size, copyback);
 #endif
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	while (test_bit(ST_CMDING, &portp->state)) {
 		if (signal_pending(current)) {
-			restore_flags(flags);
+			local_irq_restore(flags);
 			return(-ERESTARTSYS);
 		}
 		interruptible_sleep_on(&portp->raw_wait);
@@ -1432,12 +1422,12 @@
 
 	while (test_bit(ST_CMDING, &portp->state)) {
 		if (signal_pending(current)) {
-			restore_flags(flags);
+			local_irq_restore(flags);
 			return(-ERESTARTSYS);
 		}
 		interruptible_sleep_on(&portp->raw_wait);
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	if (portp->rc != 0)
 		return(-EIO);
@@ -1497,8 +1487,7 @@
 	if (portp->tty->termios->c_cflag & CLOCAL)
 		doclocal++;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	portp->openwaitcnt++;
 	if (! tty_hung_up_p(filp))
 		portp->refcount--;
@@ -1530,7 +1519,7 @@
 	if (! tty_hung_up_p(filp))
 		portp->refcount++;
 	portp->openwaitcnt--;
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return(rc);
 }
@@ -1577,8 +1566,7 @@
 /*
  *	All data is now local, shove as much as possible into shared memory.
  */
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	EBRDENABLE(brdp);
 	ap = (volatile cdkasy_t *) EBRDGETMEMPTR(brdp, portp->addr);
 	head = (unsigned int) ap->txq.head;
@@ -1624,7 +1612,7 @@
 	set_bit(ST_TXBUSY, &portp->state);
 	EBRDDISABLE(brdp);
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return(count);
 }
@@ -1706,8 +1694,7 @@
 	if (brdp == (stlibrd_t *) NULL)
 		return;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	EBRDENABLE(brdp);
 
 	ap = (volatile cdkasy_t *) EBRDGETMEMPTR(brdp, portp->addr);
@@ -1756,7 +1743,7 @@
 	set_bit(ST_TXBUSY, &portp->state);
 
 	EBRDDISABLE(brdp);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /*****************************************************************************/
@@ -1791,8 +1778,7 @@
 	if (brdp == (stlibrd_t *) NULL)
 		return(0);
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	EBRDENABLE(brdp);
 	rp = &((volatile cdkasy_t *) EBRDGETMEMPTR(brdp, portp->addr))->txq;
 	head = (unsigned int) rp->head;
@@ -1802,7 +1788,7 @@
 	len = (head >= tail) ? (portp->txsize - (head - tail)) : (tail - head);
 	len--;
 	EBRDDISABLE(brdp);
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	if (tty == stli_txcooktty) {
 		stli_txcookrealsize = len;
@@ -1846,8 +1832,7 @@
 	if (brdp == (stlibrd_t *) NULL)
 		return(0);
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	EBRDENABLE(brdp);
 	rp = &((volatile cdkasy_t *) EBRDGETMEMPTR(brdp, portp->addr))->txq;
 	head = (unsigned int) rp->head;
@@ -1858,7 +1843,7 @@
 	if ((len == 0) && test_bit(ST_TXBUSY, &portp->state))
 		len = 1;
 	EBRDDISABLE(brdp);
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return(len);
 }
@@ -2303,8 +2288,7 @@
 
 	portp->flags &= ~ASYNC_INITIALIZED;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	if (! test_bit(ST_CLOSING, &portp->state))
 		stli_rawclose(brdp, portp, 0, 0);
 	if (tty->termios->c_cflag & HUPCL) {
@@ -2318,7 +2302,7 @@
 				&portp->asig, sizeof(asysigs_t), 0);
 		}
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	clear_bit(ST_TXBUSY, &portp->state);
 	clear_bit(ST_RXSTOP, &portp->state);
@@ -2359,8 +2343,7 @@
 	if (brdp == (stlibrd_t *) NULL)
 		return;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	if (tty == stli_txcooktty) {
 		stli_txcooktty = (struct tty_struct *) NULL;
 		stli_txcooksize = 0;
@@ -2377,7 +2360,7 @@
 		stli_sendcmd(brdp, portp, A_FLUSH, &ftype,
 			sizeof(unsigned long), 0);
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	wake_up_interruptible(&tty->write_wait);
 	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
@@ -2653,14 +2636,12 @@
 		(int) arg, size, copyback);
 #endif
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	if (test_bit(ST_CMDING, &portp->state)) {
 		printk(KERN_ERR "STALLION: command already busy, cmd=%x!\n",
 				(int) cmd);
-		restore_flags(flags);
-		return;
+		goto out;
 	}
 
 	EBRDENABLE(brdp);
@@ -2680,7 +2661,7 @@
 	*bits |= portp->portbit;
 	set_bit(ST_CMDING, &portp->state);
 	EBRDDISABLE(brdp);
-	restore_flags(flags);
+out:	local_irq_restore(flags);
 }
 
 /*****************************************************************************/
@@ -4195,8 +4176,7 @@
 
 	rc = 0;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	EBRDENABLE(brdp);
 	hdrp = (volatile cdkhdr_t *) EBRDGETMEMPTR(brdp, CDK_CDKADDR);
 	nrdevs = hdrp->nrdevs;
@@ -4273,7 +4253,7 @@
 
 stli_donestartup:
 	EBRDDISABLE(brdp);
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	if (rc == 0)
 		brdp->state |= BST_STARTED;
@@ -4775,8 +4755,7 @@
 
 	size = MIN(count, (brdp->memsize - fp->f_pos));
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	EBRDENABLE(brdp);
 	while (size > 0) {
 		memptr = (void *) EBRDGETMEMPTR(brdp, fp->f_pos);
@@ -4791,7 +4770,7 @@
 	}
 out:
 	EBRDDISABLE(brdp);
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return(count);
 }
@@ -4831,8 +4810,7 @@
 	chbuf = (char __user *) buf;
 	size = MIN(count, (brdp->memsize - fp->f_pos));
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	EBRDENABLE(brdp);
 	while (size > 0) {
 		memptr = (void *) EBRDGETMEMPTR(brdp, fp->f_pos);
@@ -4847,7 +4825,7 @@
 	}
 out:
 	EBRDDISABLE(brdp);
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return(count);
 }
@@ -4950,8 +4928,7 @@
 	stli_comstats.state = portp->state;
 	stli_comstats.flags = portp->flags;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	if (portp->tty != (struct tty_struct *) NULL) {
 		if (portp->tty->driver_data == portp) {
 			stli_comstats.ttystate = portp->tty->flags;
@@ -4964,7 +4941,7 @@
 			}
 		}
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	stli_comstats.txtotal = stli_cdkstats.txchars;
 	stli_comstats.rxtotal = stli_cdkstats.rxchars + stli_cdkstats.ringover;
