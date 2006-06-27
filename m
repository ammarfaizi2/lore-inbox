Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161082AbWF0PHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161082AbWF0PHX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 11:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161080AbWF0PHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 11:07:22 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:30172 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161085AbWF0PHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 11:07:15 -0400
Subject: PATCH: fix up istallion
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 27 Jun 2006 16:22:58 +0100
Message-Id: <1151421778.32186.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Turned out to be rather more of a monster

Signed-off-by: Alan Cox <alan@redhat.com>

--- linux.vanilla-2.6.17/drivers/char/istallion.c	2006-06-19 17:29:45.000000000 +0100
+++ linux-2.6.17/drivers/char/istallion.c	2006-06-27 15:39:20.647862008 +0100
@@ -42,13 +42,12 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/device.h>
 #include <linux/wait.h>
+#include <linux/eisa.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
-#ifdef CONFIG_PCI
 #include <linux/pci.h>
-#endif
 
 /*****************************************************************************/
 
@@ -137,6 +136,10 @@
 
 static int	stli_nrbrds = ARRAY_SIZE(stli_brdconf);
 
+/* stli_lock must NOT be taken holding brd_lock */
+static spinlock_t stli_lock;	/* TTY logic lock */
+static spinlock_t brd_lock;	/* Board logic lock */
+
 /*
  *	There is some experimental EISA board detection code in this driver.
  *	By default it is disabled, but for those that want to try it out,
@@ -173,14 +176,6 @@
 
 static struct tty_driver	*stli_serial;
 
-/*
- *	We will need to allocate a temporary write buffer for chars that
- *	come direct from user space. The problem is that a copy from user
- *	space might cause a page fault (typically on a system that is
- *	swapping!). All ports will share one buffer - since if the system
- *	is already swapping a shared buffer won't make things any worse.
- */
-static char			*stli_tmpwritebuf;
 
 #define	STLI_TXBUFSIZE		4096
 
@@ -419,7 +414,7 @@
 #endif
 
 static struct pci_device_id istallion_pci_tbl[] = {
-	{ PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_ECRA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_ECRA), },
 	{ 0 }
 };
 MODULE_DEVICE_TABLE(pci, istallion_pci_tbl);
@@ -682,7 +677,7 @@
 static ssize_t	stli_memread(struct file *fp, char __user *buf, size_t count, loff_t *offp);
 static ssize_t	stli_memwrite(struct file *fp, const char __user *buf, size_t count, loff_t *offp);
 static int	stli_memioctl(struct inode *ip, struct file *fp, unsigned int cmd, unsigned long arg);
-static void	stli_brdpoll(stlibrd_t *brdp, volatile cdkhdr_t *hdrp);
+static void	stli_brdpoll(stlibrd_t *brdp, cdkhdr_t __iomem *hdrp);
 static void	stli_poll(unsigned long arg);
 static int	stli_hostcmd(stlibrd_t *brdp, stliport_t *portp);
 static int	stli_initopen(stlibrd_t *brdp, stliport_t *portp);
@@ -693,7 +688,8 @@
 static int	stli_setport(stliport_t *portp);
 static int	stli_cmdwait(stlibrd_t *brdp, stliport_t *portp, unsigned long cmd, void *arg, int size, int copyback);
 static void	stli_sendcmd(stlibrd_t *brdp, stliport_t *portp, unsigned long cmd, void *arg, int size, int copyback);
-static void	stli_dodelaycmd(stliport_t *portp, volatile cdkctrl_t *cp);
+static void	__stli_sendcmd(stlibrd_t *brdp, stliport_t *portp, unsigned long cmd, void *arg, int size, int copyback);
+static void	stli_dodelaycmd(stliport_t *portp, cdkctrl_t __iomem *cp);
 static void	stli_mkasyport(stliport_t *portp, asyport_t *pp, struct termios *tiosp);
 static void	stli_mkasysigs(asysigs_t *sp, int dtr, int rts);
 static long	stli_mktiocm(unsigned long sigvalue);
@@ -799,18 +795,8 @@
 
 static int __init istallion_module_init(void)
 {
-	unsigned long	flags;
-
-#ifdef DEBUG
-	printk("init_module()\n");
-#endif
-
-	save_flags(flags);
-	cli();
 	stli_init();
-	restore_flags(flags);
-
-	return(0);
+	return 0;
 }
 
 /*****************************************************************************/
@@ -819,33 +805,24 @@
 {
 	stlibrd_t	*brdp;
 	stliport_t	*portp;
-	unsigned long	flags;
 	int		i, j;
 
-#ifdef DEBUG
-	printk("cleanup_module()\n");
-#endif
-
 	printk(KERN_INFO "Unloading %s: version %s\n", stli_drvtitle,
 		stli_drvversion);
 
-	save_flags(flags);
-	cli();
-
-/*
- *	Free up all allocated resources used by the ports. This includes
- *	memory and interrupts.
- */
+	/*
+	 *	Free up all allocated resources used by the ports. This includes
+	 *	memory and interrupts.
+	 */
 	if (stli_timeron) {
 		stli_timeron = 0;
-		del_timer(&stli_timerlist);
+		del_timer_sync(&stli_timerlist);
 	}
 
 	i = tty_unregister_driver(stli_serial);
 	if (i) {
 		printk("STALLION: failed to un-register tty driver, "
 			"errno=%d\n", -i);
-		restore_flags(flags);
 		return;
 	}
 	put_tty_driver(stli_serial);
@@ -859,16 +836,15 @@
 		printk("STALLION: failed to un-register serial memory device, "
 			"errno=%d\n", -i);
 
-	kfree(stli_tmpwritebuf);
 	kfree(stli_txcookbuf);
 
 	for (i = 0; (i < stli_nrbrds); i++) {
-		if ((brdp = stli_brds[i]) == (stlibrd_t *) NULL)
+		if ((brdp = stli_brds[i]) == NULL)
 			continue;
 		for (j = 0; (j < STL_MAXPORTS); j++) {
 			portp = brdp->ports[j];
-			if (portp != (stliport_t *) NULL) {
-				if (portp->tty != (struct tty_struct *) NULL)
+			if (portp != NULL) {
+				if (portp->tty != NULL)
 					tty_hangup(portp->tty);
 				kfree(portp);
 			}
@@ -878,10 +854,8 @@
 		if (brdp->iosize > 0)
 			release_region(brdp->iobase, brdp->iosize);
 		kfree(brdp);
-		stli_brds[i] = (stlibrd_t *) NULL;
+		stli_brds[i] = NULL;
 	}
-
-	restore_flags(flags);
 }
 
 module_init(istallion_module_init);
@@ -895,19 +869,15 @@
 
 static void stli_argbrds(void)
 {
-	stlconf_t	conf;
-	stlibrd_t	*brdp;
-	int		i;
-
-#ifdef DEBUG
-	printk("stli_argbrds()\n");
-#endif
+	stlconf_t conf;
+	stlibrd_t *brdp;
+	int i;
 
 	for (i = stli_nrbrds; i < ARRAY_SIZE(stli_brdsp); i++) {
 		memset(&conf, 0, sizeof(conf));
 		if (stli_parsebrd(&conf, stli_brdsp[i]) == 0)
 			continue;
-		if ((brdp = stli_allocbrd()) == (stlibrd_t *) NULL)
+		if ((brdp = stli_allocbrd()) == NULL)
 			continue;
 		stli_nrbrds = i + 1;
 		brdp->brdnr = i;
@@ -926,9 +896,9 @@
 
 static unsigned long stli_atol(char *str)
 {
-	unsigned long	val;
-	int		base, c;
-	char		*sp;
+	unsigned long val;
+	int base, c;
+	char *sp;
 
 	val = 0;
 	sp = str;
@@ -962,15 +932,11 @@
 
 static int stli_parsebrd(stlconf_t *confp, char **argp)
 {
-	char	*sp;
-	int	i;
-
-#ifdef DEBUG
-	printk("stli_parsebrd(confp=%x,argp=%x)\n", (int) confp, (int) argp);
-#endif
+	char *sp;
+	int i;
 
-	if ((argp[0] == (char *) NULL) || (*argp[0] == 0))
-		return(0);
+	if (argp[0] == NULL || *argp[0] == 0)
+		return 0;
 
 	for (sp = argp[0], i = 0; ((*sp != 0) && (i < 25)); sp++, i++)
 		*sp = TOLOWER(*sp);
@@ -985,9 +951,9 @@
 	}
 
 	confp->brdtype = stli_brdstr[i].type;
-	if ((argp[1] != (char *) NULL) && (*argp[1] != 0))
+	if (argp[1] != NULL && *argp[1] != 0)
 		confp->ioaddr1 = stli_atol(argp[1]);
-	if ((argp[2] != (char *) NULL) && (*argp[2] != 0))
+	if (argp[2] !=  NULL && *argp[2] != 0)
 		confp->memaddr = stli_atol(argp[2]);
 	return(1);
 }
@@ -998,34 +964,29 @@
 
 static int stli_open(struct tty_struct *tty, struct file *filp)
 {
-	stlibrd_t	*brdp;
-	stliport_t	*portp;
-	unsigned int	minordev;
-	int		brdnr, portnr, rc;
-
-#ifdef DEBUG
-	printk("stli_open(tty=%x,filp=%x): device=%s\n", (int) tty,
-		(int) filp, tty->name);
-#endif
+	stlibrd_t *brdp;
+	stliport_t *portp;
+	unsigned int minordev;
+	int brdnr, portnr, rc;
 
 	minordev = tty->index;
 	brdnr = MINOR2BRD(minordev);
 	if (brdnr >= stli_nrbrds)
-		return(-ENODEV);
+		return -ENODEV;
 	brdp = stli_brds[brdnr];
-	if (brdp == (stlibrd_t *) NULL)
-		return(-ENODEV);
+	if (brdp == NULL)
+		return -ENODEV;
 	if ((brdp->state & BST_STARTED) == 0)
-		return(-ENODEV);
+		return -ENODEV;
 	portnr = MINOR2PORT(minordev);
 	if ((portnr < 0) || (portnr > brdp->nrports))
-		return(-ENODEV);
+		return -ENODEV;
 
 	portp = brdp->ports[portnr];
-	if (portp == (stliport_t *) NULL)
-		return(-ENODEV);
+	if (portp == NULL)
+		return -ENODEV;
 	if (portp->devnr < 1)
-		return(-ENODEV);
+		return -ENODEV;
 
 
 /*
@@ -1037,8 +998,8 @@
 	if (portp->flags & ASYNC_CLOSING) {
 		interruptible_sleep_on(&portp->close_wait);
 		if (portp->flags & ASYNC_HUP_NOTIFY)
-			return(-EAGAIN);
-		return(-ERESTARTSYS);
+			return -EAGAIN;
+		return -ERESTARTSYS;
 	}
 
 /*
@@ -1054,7 +1015,7 @@
 	wait_event_interruptible(portp->raw_wait,
 			!test_bit(ST_INITIALIZING, &portp->state));
 	if (signal_pending(current))
-		return(-ERESTARTSYS);
+		return -ERESTARTSYS;
 
 	if ((portp->flags & ASYNC_INITIALIZED) == 0) {
 		set_bit(ST_INITIALIZING, &portp->state);
@@ -1065,7 +1026,7 @@
 		clear_bit(ST_INITIALIZING, &portp->state);
 		wake_up_interruptible(&portp->raw_wait);
 		if (rc < 0)
-			return(rc);
+			return rc;
 	}
 
 /*
@@ -1077,8 +1038,8 @@
 	if (portp->flags & ASYNC_CLOSING) {
 		interruptible_sleep_on(&portp->close_wait);
 		if (portp->flags & ASYNC_HUP_NOTIFY)
-			return(-EAGAIN);
-		return(-ERESTARTSYS);
+			return -EAGAIN;
+		return -ERESTARTSYS;
 	}
 
 /*
@@ -1088,38 +1049,33 @@
  */
 	if (!(filp->f_flags & O_NONBLOCK)) {
 		if ((rc = stli_waitcarrier(brdp, portp, filp)) != 0)
-			return(rc);
+			return rc;
 	}
 	portp->flags |= ASYNC_NORMAL_ACTIVE;
-	return(0);
+	return 0;
 }
 
 /*****************************************************************************/
 
 static void stli_close(struct tty_struct *tty, struct file *filp)
 {
-	stlibrd_t	*brdp;
-	stliport_t	*portp;
-	unsigned long	flags;
-
-#ifdef DEBUG
-	printk("stli_close(tty=%x,filp=%x)\n", (int) tty, (int) filp);
-#endif
+	stlibrd_t *brdp;
+	stliport_t *portp;
+	unsigned long flags;
 
 	portp = tty->driver_data;
-	if (portp == (stliport_t *) NULL)
+	if (portp == NULL)
 		return;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&stli_lock, flags);
 	if (tty_hung_up_p(filp)) {
-		restore_flags(flags);
+		spin_unlock_irqrestore(&stli_lock, flags);
 		return;
 	}
 	if ((tty->count == 1) && (portp->refcount != 1))
 		portp->refcount = 1;
 	if (portp->refcount-- > 1) {
-		restore_flags(flags);
+		spin_unlock_irqrestore(&stli_lock, flags);
 		return;
 	}
 
@@ -1134,6 +1090,8 @@
 	if (tty == stli_txcooktty)
 		stli_flushchars(tty);
 	tty->closing = 1;
+	spin_unlock_irqrestore(&stli_lock, flags);
+	
 	if (portp->closing_wait != ASYNC_CLOSING_WAIT_NONE)
 		tty_wait_until_sent(tty, portp->closing_wait);
 
@@ -1157,7 +1115,7 @@
 	stli_flushbuffer(tty);
 
 	tty->closing = 0;
-	portp->tty = (struct tty_struct *) NULL;
+	portp->tty = NULL;
 
 	if (portp->openwaitcnt) {
 		if (portp->close_delay)
@@ -1167,7 +1125,6 @@
 
 	portp->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
 	wake_up_interruptible(&portp->close_wait);
-	restore_flags(flags);
 }
 
 /*****************************************************************************/
@@ -1182,45 +1139,41 @@
 
 static int stli_initopen(stlibrd_t *brdp, stliport_t *portp)
 {
-	struct tty_struct	*tty;
-	asynotify_t		nt;
-	asyport_t		aport;
-	int			rc;
-
-#ifdef DEBUG
-	printk("stli_initopen(brdp=%x,portp=%x)\n", (int) brdp, (int) portp);
-#endif
+	struct tty_struct *tty;
+	asynotify_t nt;
+	asyport_t aport;
+	int rc;
 
 	if ((rc = stli_rawopen(brdp, portp, 0, 1)) < 0)
-		return(rc);
+		return rc;
 
 	memset(&nt, 0, sizeof(asynotify_t));
 	nt.data = (DT_TXLOW | DT_TXEMPTY | DT_RXBUSY | DT_RXBREAK);
 	nt.signal = SG_DCD;
 	if ((rc = stli_cmdwait(brdp, portp, A_SETNOTIFY, &nt,
 	    sizeof(asynotify_t), 0)) < 0)
-		return(rc);
+		return rc;
 
 	tty = portp->tty;
-	if (tty == (struct tty_struct *) NULL)
-		return(-ENODEV);
+	if (tty == NULL)
+		return -ENODEV;
 	stli_mkasyport(portp, &aport, tty->termios);
 	if ((rc = stli_cmdwait(brdp, portp, A_SETPORT, &aport,
 	    sizeof(asyport_t), 0)) < 0)
-		return(rc);
+		return rc;
 
 	set_bit(ST_GETSIGS, &portp->state);
 	if ((rc = stli_cmdwait(brdp, portp, A_GETSIGNALS, &portp->asig,
 	    sizeof(asysigs_t), 1)) < 0)
-		return(rc);
+		return rc;
 	if (test_and_clear_bit(ST_GETSIGS, &portp->state))
 		portp->sigs = stli_mktiocm(portp->asig.sigvalue);
 	stli_mkasysigs(&portp->asig, 1, 1);
 	if ((rc = stli_cmdwait(brdp, portp, A_SETSIGNALS, &portp->asig,
 	    sizeof(asysigs_t), 0)) < 0)
-		return(rc);
+		return rc;
 
-	return(0);
+	return 0;
 }
 
 /*****************************************************************************/
@@ -1234,22 +1187,15 @@
 
 static int stli_rawopen(stlibrd_t *brdp, stliport_t *portp, unsigned long arg, int wait)
 {
-	volatile cdkhdr_t	*hdrp;
-	volatile cdkctrl_t	*cp;
-	volatile unsigned char	*bits;
-	unsigned long		flags;
-	int			rc;
-
-#ifdef DEBUG
-	printk("stli_rawopen(brdp=%x,portp=%x,arg=%x,wait=%d)\n",
-		(int) brdp, (int) portp, (int) arg, wait);
-#endif
+	cdkhdr_t __iomem *hdrp;
+	cdkctrl_t __iomem *cp;
+	unsigned char __iomem *bits;
+	unsigned long flags;
+	int rc;
 
 /*
  *	Send a message to the slave to open this port.
  */
-	save_flags(flags);
-	cli();
 
 /*
  *	Slave is already closing this port. This can happen if a hangup
@@ -1260,7 +1206,6 @@
 	wait_event_interruptible(portp->raw_wait,
 			!test_bit(ST_CLOSING, &portp->state));
 	if (signal_pending(current)) {
-		restore_flags(flags);
 		return -ERESTARTSYS;
 	}
 
@@ -1269,19 +1214,20 @@
  *	memory. Once the message is in set the service bits to say that
  *	this port wants service.
  */
+	spin_lock_irqsave(&brd_lock, flags);
 	EBRDENABLE(brdp);
-	cp = &((volatile cdkasy_t *) EBRDGETMEMPTR(brdp, portp->addr))->ctrl;
-	cp->openarg = arg;
-	cp->open = 1;
-	hdrp = (volatile cdkhdr_t *) EBRDGETMEMPTR(brdp, CDK_CDKADDR);
-	bits = ((volatile unsigned char *) hdrp) + brdp->slaveoffset +
+	cp = &((cdkasy_t __iomem *) EBRDGETMEMPTR(brdp, portp->addr))->ctrl;
+	writel(arg, &cp->openarg);
+	writeb(1, &cp->open);
+	hdrp = (cdkhdr_t __iomem *) EBRDGETMEMPTR(brdp, CDK_CDKADDR);
+	bits = ((unsigned char __iomem *) hdrp) + brdp->slaveoffset +
 		portp->portidx;
-	*bits |= portp->portbit;
+	writeb(readb(bits) | portp->portbit, bits);
 	EBRDDISABLE(brdp);
 
 	if (wait == 0) {
-		restore_flags(flags);
-		return(0);
+		spin_unlock_irqrestore(&brd_lock, flags);
+		return 0;
 	}
 
 /*
@@ -1290,15 +1236,16 @@
  */
 	rc = 0;
 	set_bit(ST_OPENING, &portp->state);
+	spin_unlock_irqrestore(&brd_lock, flags);
+
 	wait_event_interruptible(portp->raw_wait,
 			!test_bit(ST_OPENING, &portp->state));
 	if (signal_pending(current))
 		rc = -ERESTARTSYS;
-	restore_flags(flags);
 
 	if ((rc == 0) && (portp->rc != 0))
 		rc = -EIO;
-	return(rc);
+	return rc;
 }
 
 /*****************************************************************************/
@@ -1311,19 +1258,11 @@
 
 static int stli_rawclose(stlibrd_t *brdp, stliport_t *portp, unsigned long arg, int wait)
 {
-	volatile cdkhdr_t	*hdrp;
-	volatile cdkctrl_t	*cp;
-	volatile unsigned char	*bits;
-	unsigned long		flags;
-	int			rc;
-
-#ifdef DEBUG
-	printk("stli_rawclose(brdp=%x,portp=%x,arg=%x,wait=%d)\n",
-		(int) brdp, (int) portp, (int) arg, wait);
-#endif
-
-	save_flags(flags);
-	cli();
+	cdkhdr_t __iomem *hdrp;
+	cdkctrl_t __iomem *cp;
+	unsigned char __iomem *bits;
+	unsigned long flags;
+	int rc;
 
 /*
  *	Slave is already closing this port. This can happen if a hangup
@@ -1333,7 +1272,6 @@
 		wait_event_interruptible(portp->raw_wait,
 				!test_bit(ST_CLOSING, &portp->state));
 		if (signal_pending(current)) {
-			restore_flags(flags);
 			return -ERESTARTSYS;
 		}
 	}
@@ -1341,21 +1279,22 @@
 /*
  *	Write the close command into shared memory.
  */
+	spin_lock_irqsave(&brd_lock, flags);
 	EBRDENABLE(brdp);
-	cp = &((volatile cdkasy_t *) EBRDGETMEMPTR(brdp, portp->addr))->ctrl;
-	cp->closearg = arg;
-	cp->close = 1;
-	hdrp = (volatile cdkhdr_t *) EBRDGETMEMPTR(brdp, CDK_CDKADDR);
-	bits = ((volatile unsigned char *) hdrp) + brdp->slaveoffset +
+	cp = &((cdkasy_t __iomem *) EBRDGETMEMPTR(brdp, portp->addr))->ctrl;
+	writel(arg, &cp->closearg);
+	writeb(1, &cp->close);
+	hdrp = (cdkhdr_t __iomem *) EBRDGETMEMPTR(brdp, CDK_CDKADDR);
+	bits = ((unsigned char __iomem *) hdrp) + brdp->slaveoffset +
 		portp->portidx;
-	*bits |= portp->portbit;
+	writeb(readb(bits) |portp->portbit, bits);
 	EBRDDISABLE(brdp);
 
 	set_bit(ST_CLOSING, &portp->state);
-	if (wait == 0) {
-		restore_flags(flags);
-		return(0);
-	}
+	spin_unlock_irqrestore(&brd_lock, flags);
+	
+	if (wait == 0)
+		return 0;
 
 /*
  *	Slave is in action, so now we must wait for the open acknowledgment
@@ -1366,11 +1305,10 @@
 			!test_bit(ST_CLOSING, &portp->state));
 	if (signal_pending(current))
 		rc = -ERESTARTSYS;
-	restore_flags(flags);
 
 	if ((rc == 0) && (portp->rc != 0))
 		rc = -EIO;
-	return(rc);
+	return rc;
 }
 
 /*****************************************************************************/
@@ -1384,36 +1322,21 @@
 
 static int stli_cmdwait(stlibrd_t *brdp, stliport_t *portp, unsigned long cmd, void *arg, int size, int copyback)
 {
-	unsigned long	flags;
-
-#ifdef DEBUG
-	printk("stli_cmdwait(brdp=%x,portp=%x,cmd=%x,arg=%x,size=%d,"
-		"copyback=%d)\n", (int) brdp, (int) portp, (int) cmd,
-		(int) arg, size, copyback);
-#endif
-
-	save_flags(flags);
-	cli();
 	wait_event_interruptible(portp->raw_wait,
 			!test_bit(ST_CMDING, &portp->state));
-	if (signal_pending(current)) {
-		restore_flags(flags);
+	if (signal_pending(current))
 		return -ERESTARTSYS;
-	}
 
 	stli_sendcmd(brdp, portp, cmd, arg, size, copyback);
 
 	wait_event_interruptible(portp->raw_wait,
 			!test_bit(ST_CMDING, &portp->state));
-	if (signal_pending(current)) {
-		restore_flags(flags);
+	if (signal_pending(current))
 		return -ERESTARTSYS;
-	}
-	restore_flags(flags);
 
 	if (portp->rc != 0)
-		return(-EIO);
-	return(0);
+		return -EIO;
+	return 0;
 }
 
 /*****************************************************************************/
@@ -1425,22 +1348,18 @@
 
 static int stli_setport(stliport_t *portp)
 {
-	stlibrd_t	*brdp;
-	asyport_t	aport;
-
-#ifdef DEBUG
-	printk("stli_setport(portp=%x)\n", (int) portp);
-#endif
+	stlibrd_t *brdp;
+	asyport_t aport;
 
-	if (portp == (stliport_t *) NULL)
-		return(-ENODEV);
-	if (portp->tty == (struct tty_struct *) NULL)
-		return(-ENODEV);
-	if ((portp->brdnr < 0) && (portp->brdnr >= stli_nrbrds))
-		return(-ENODEV);
+	if (portp == NULL)
+		return -ENODEV;
+	if (portp->tty == NULL)
+		return -ENODEV;
+	if (portp->brdnr < 0 && portp->brdnr >= stli_nrbrds)
+		return -ENODEV;
 	brdp = stli_brds[portp->brdnr];
-	if (brdp == (stlibrd_t *) NULL)
-		return(-ENODEV);
+	if (brdp == NULL)
+		return -ENODEV;
 
 	stli_mkasyport(portp, &aport, portp->tty->termios);
 	return(stli_cmdwait(brdp, portp, A_SETPORT, &aport, sizeof(asyport_t), 0));
@@ -1455,13 +1374,8 @@
 
 static int stli_waitcarrier(stlibrd_t *brdp, stliport_t *portp, struct file *filp)
 {
-	unsigned long	flags;
-	int		rc, doclocal;
-
-#ifdef DEBUG
-	printk("stli_waitcarrier(brdp=%x,portp=%x,filp=%x)\n",
-		(int) brdp, (int) portp, (int) filp);
-#endif
+	unsigned long flags;
+	int rc, doclocal;
 
 	rc = 0;
 	doclocal = 0;
@@ -1469,11 +1383,11 @@
 	if (portp->tty->termios->c_cflag & CLOCAL)
 		doclocal++;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&stli_lock, flags);
 	portp->openwaitcnt++;
 	if (! tty_hung_up_p(filp))
 		portp->refcount--;
+	spin_unlock_irqrestore(&stli_lock, flags);
 
 	for (;;) {
 		stli_mkasysigs(&portp->asig, 1, 1);
@@ -1499,12 +1413,13 @@
 		interruptible_sleep_on(&portp->open_wait);
 	}
 
+	spin_lock_irqsave(&stli_lock, flags);
 	if (! tty_hung_up_p(filp))
 		portp->refcount++;
 	portp->openwaitcnt--;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&stli_lock, flags);
 
-	return(rc);
+	return rc;
 }
 
 /*****************************************************************************/
@@ -1517,46 +1432,38 @@
 
 static int stli_write(struct tty_struct *tty, const unsigned char *buf, int count)
 {
-	volatile cdkasy_t	*ap;
-	volatile cdkhdr_t	*hdrp;
-	volatile unsigned char	*bits;
-	unsigned char		*shbuf, *chbuf;
-	stliport_t		*portp;
-	stlibrd_t		*brdp;
-	unsigned int		len, stlen, head, tail, size;
-	unsigned long		flags;
-
-#ifdef DEBUG
-	printk("stli_write(tty=%x,buf=%x,count=%d)\n",
-		(int) tty, (int) buf, count);
-#endif
+	cdkasy_t __iomem *ap;
+	cdkhdr_t __iomem *hdrp;
+	unsigned char __iomem *bits;
+	unsigned char __iomem *shbuf;
+	unsigned char *chbuf;
+	stliport_t *portp;
+	stlibrd_t *brdp;
+	unsigned int len, stlen, head, tail, size;
+	unsigned long flags;
 
-	if ((tty == (struct tty_struct *) NULL) ||
-	    (stli_tmpwritebuf == (char *) NULL))
-		return(0);
 	if (tty == stli_txcooktty)
 		stli_flushchars(tty);
 	portp = tty->driver_data;
-	if (portp == (stliport_t *) NULL)
-		return(0);
+	if (portp == NULL)
+		return 0;
 	if ((portp->brdnr < 0) || (portp->brdnr >= stli_nrbrds))
-		return(0);
+		return 0;
 	brdp = stli_brds[portp->brdnr];
-	if (brdp == (stlibrd_t *) NULL)
-		return(0);
+	if (brdp == NULL)
+		return 0;
 	chbuf = (unsigned char *) buf;
 
 /*
  *	All data is now local, shove as much as possible into shared memory.
  */
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&brd_lock, flags);
 	EBRDENABLE(brdp);
-	ap = (volatile cdkasy_t *) EBRDGETMEMPTR(brdp, portp->addr);
-	head = (unsigned int) ap->txq.head;
-	tail = (unsigned int) ap->txq.tail;
-	if (tail != ((unsigned int) ap->txq.tail))
-		tail = (unsigned int) ap->txq.tail;
+	ap = (cdkasy_t __iomem *) EBRDGETMEMPTR(brdp, portp->addr);
+	head = (unsigned int) readw(&ap->txq.head);
+	tail = (unsigned int) readw(&ap->txq.tail);
+	if (tail != ((unsigned int) readw(&ap->txq.tail)))
+		tail = (unsigned int) readw(&ap->txq.tail);
 	size = portp->txsize;
 	if (head >= tail) {
 		len = size - (head - tail) - 1;
@@ -1568,11 +1475,11 @@
 
 	len = MIN(len, count);
 	count = 0;
-	shbuf = (char *) EBRDGETMEMPTR(brdp, portp->txoffset);
+	shbuf = (char __iomem *) EBRDGETMEMPTR(brdp, portp->txoffset);
 
 	while (len > 0) {
 		stlen = MIN(len, stlen);
-		memcpy((shbuf + head), chbuf, stlen);
+		memcpy_toio(shbuf + head, chbuf, stlen);
 		chbuf += stlen;
 		len -= stlen;
 		count += stlen;
@@ -1583,20 +1490,19 @@
 		}
 	}
 
-	ap = (volatile cdkasy_t *) EBRDGETMEMPTR(brdp, portp->addr);
-	ap->txq.head = head;
+	ap = (cdkasy_t __iomem *) EBRDGETMEMPTR(brdp, portp->addr);
+	writew(head, &ap->txq.head);
 	if (test_bit(ST_TXBUSY, &portp->state)) {
-		if (ap->changed.data & DT_TXEMPTY)
-			ap->changed.data &= ~DT_TXEMPTY;
+		if (readl(&ap->changed.data) & DT_TXEMPTY)
+			writel(readl(&ap->changed.data) & ~DT_TXEMPTY, &ap->changed.data);
 	}
-	hdrp = (volatile cdkhdr_t *) EBRDGETMEMPTR(brdp, CDK_CDKADDR);
-	bits = ((volatile unsigned char *) hdrp) + brdp->slaveoffset +
+	hdrp = (cdkhdr_t __iomem *) EBRDGETMEMPTR(brdp, CDK_CDKADDR);
+	bits = ((unsigned char __iomem *) hdrp) + brdp->slaveoffset +
 		portp->portidx;
-	*bits |= portp->portbit;
+	writeb(readb(bits) | portp->portbit, bits);
 	set_bit(ST_TXBUSY, &portp->state);
 	EBRDDISABLE(brdp);
-
-	restore_flags(flags);
+	spin_unlock_irqrestore(&brd_lock, flags);
 
 	return(count);
 }
@@ -1613,14 +1519,8 @@
 
 static void stli_putchar(struct tty_struct *tty, unsigned char ch)
 {
-#ifdef DEBUG
-	printk("stli_putchar(tty=%x,ch=%x)\n", (int) tty, (int) ch);
-#endif
-
-	if (tty == (struct tty_struct *) NULL)
-		return;
 	if (tty != stli_txcooktty) {
-		if (stli_txcooktty != (struct tty_struct *) NULL)
+		if (stli_txcooktty != NULL)
 			stli_flushchars(stli_txcooktty);
 		stli_txcooktty = tty;
 	}
@@ -1640,29 +1540,26 @@
 
 static void stli_flushchars(struct tty_struct *tty)
 {
-	volatile cdkhdr_t	*hdrp;
-	volatile unsigned char	*bits;
-	volatile cdkasy_t	*ap;
-	struct tty_struct	*cooktty;
-	stliport_t		*portp;
-	stlibrd_t		*brdp;
-	unsigned int		len, stlen, head, tail, size, count, cooksize;
-	unsigned char		*buf, *shbuf;
-	unsigned long		flags;
-
-#ifdef DEBUG
-	printk("stli_flushchars(tty=%x)\n", (int) tty);
-#endif
+	cdkhdr_t __iomem *hdrp;
+	unsigned char __iomem *bits;
+	cdkasy_t __iomem *ap;
+	struct tty_struct *cooktty;
+	stliport_t *portp;
+	stlibrd_t *brdp;
+	unsigned int len, stlen, head, tail, size, count, cooksize;
+	unsigned char *buf;
+	unsigned char __iomem *shbuf;
+	unsigned long flags;
 
 	cooksize = stli_txcooksize;
 	cooktty = stli_txcooktty;
 	stli_txcooksize = 0;
 	stli_txcookrealsize = 0;
-	stli_txcooktty = (struct tty_struct *) NULL;
+	stli_txcooktty = NULL;
 
-	if (tty == (struct tty_struct *) NULL)
+	if (tty == NULL)
 		return;
-	if (cooktty == (struct tty_struct *) NULL)
+	if (cooktty == NULL)
 		return;
 	if (tty != cooktty)
 		tty = cooktty;
@@ -1670,23 +1567,22 @@
 		return;
 
 	portp = tty->driver_data;
-	if (portp == (stliport_t *) NULL)
+	if (portp == NULL)
 		return;
 	if ((portp->brdnr < 0) || (portp->brdnr >= stli_nrbrds))
 		return;
 	brdp = stli_brds[portp->brdnr];
-	if (brdp == (stlibrd_t *) NULL)
+	if (brdp == NULL)
 		return;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&brd_lock, flags);
 	EBRDENABLE(brdp);
 
-	ap = (volatile cdkasy_t *) EBRDGETMEMPTR(brdp, portp->addr);
-	head = (unsigned int) ap->txq.head;
-	tail = (unsigned int) ap->txq.tail;
-	if (tail != ((unsigned int) ap->txq.tail))
-		tail = (unsigned int) ap->txq.tail;
+	ap = (cdkasy_t __iomem *) EBRDGETMEMPTR(brdp, portp->addr);
+	head = (unsigned int) readw(&ap->txq.head);
+	tail = (unsigned int) readw(&ap->txq.tail);
+	if (tail != ((unsigned int) readw(&ap->txq.tail)))
+		tail = (unsigned int) readw(&ap->txq.tail);
 	size = portp->txsize;
 	if (head >= tail) {
 		len = size - (head - tail) - 1;
@@ -1703,7 +1599,7 @@
 
 	while (len > 0) {
 		stlen = MIN(len, stlen);
-		memcpy((shbuf + head), buf, stlen);
+		memcpy_toio(shbuf + head, buf, stlen);
 		buf += stlen;
 		len -= stlen;
 		count += stlen;
@@ -1714,73 +1610,66 @@
 		}
 	}
 
-	ap = (volatile cdkasy_t *) EBRDGETMEMPTR(brdp, portp->addr);
-	ap->txq.head = head;
+	ap = (cdkasy_t __iomem *) EBRDGETMEMPTR(brdp, portp->addr);
+	writew(head, &ap->txq.head);
 
 	if (test_bit(ST_TXBUSY, &portp->state)) {
-		if (ap->changed.data & DT_TXEMPTY)
-			ap->changed.data &= ~DT_TXEMPTY;
+		if (readl(&ap->changed.data) & DT_TXEMPTY)
+			writel(readl(&ap->changed.data) & ~DT_TXEMPTY, &ap->changed.data);
 	}
-	hdrp = (volatile cdkhdr_t *) EBRDGETMEMPTR(brdp, CDK_CDKADDR);
-	bits = ((volatile unsigned char *) hdrp) + brdp->slaveoffset +
+	hdrp = (cdkhdr_t __iomem *) EBRDGETMEMPTR(brdp, CDK_CDKADDR);
+	bits = ((unsigned char __iomem *) hdrp) + brdp->slaveoffset +
 		portp->portidx;
-	*bits |= portp->portbit;
+	writeb(readb(bits) | portp->portbit, bits);
 	set_bit(ST_TXBUSY, &portp->state);
 
 	EBRDDISABLE(brdp);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&brd_lock, flags);
 }
 
 /*****************************************************************************/
 
 static int stli_writeroom(struct tty_struct *tty)
 {
-	volatile cdkasyrq_t	*rp;
-	stliport_t		*portp;
-	stlibrd_t		*brdp;
-	unsigned int		head, tail, len;
-	unsigned long		flags;
-
-#ifdef DEBUG
-	printk("stli_writeroom(tty=%x)\n", (int) tty);
-#endif
+	cdkasyrq_t __iomem *rp;
+	stliport_t *portp;
+	stlibrd_t *brdp;
+	unsigned int head, tail, len;
+	unsigned long flags;
 
-	if (tty == (struct tty_struct *) NULL)
-		return(0);
 	if (tty == stli_txcooktty) {
 		if (stli_txcookrealsize != 0) {
 			len = stli_txcookrealsize - stli_txcooksize;
-			return(len);
+			return len;
 		}
 	}
 
 	portp = tty->driver_data;
-	if (portp == (stliport_t *) NULL)
-		return(0);
+	if (portp == NULL)
+		return 0;
 	if ((portp->brdnr < 0) || (portp->brdnr >= stli_nrbrds))
-		return(0);
+		return 0;
 	brdp = stli_brds[portp->brdnr];
-	if (brdp == (stlibrd_t *) NULL)
-		return(0);
+	if (brdp == NULL)
+		return 0;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&brd_lock, flags);
 	EBRDENABLE(brdp);
-	rp = &((volatile cdkasy_t *) EBRDGETMEMPTR(brdp, portp->addr))->txq;
-	head = (unsigned int) rp->head;
-	tail = (unsigned int) rp->tail;
-	if (tail != ((unsigned int) rp->tail))
-		tail = (unsigned int) rp->tail;
+	rp = &((cdkasy_t __iomem *) EBRDGETMEMPTR(brdp, portp->addr))->txq;
+	head = (unsigned int) readw(&rp->head);
+	tail = (unsigned int) readw(&rp->tail);
+	if (tail != ((unsigned int) readw(&rp->tail)))
+		tail = (unsigned int) readw(&rp->tail);
 	len = (head >= tail) ? (portp->txsize - (head - tail)) : (tail - head);
 	len--;
 	EBRDDISABLE(brdp);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&brd_lock, flags);
 
 	if (tty == stli_txcooktty) {
 		stli_txcookrealsize = len;
 		len -= stli_txcooksize;
 	}
-	return(len);
+	return len;
 }
 
 /*****************************************************************************/
@@ -1795,44 +1684,37 @@
 
 static int stli_charsinbuffer(struct tty_struct *tty)
 {
-	volatile cdkasyrq_t	*rp;
-	stliport_t		*portp;
-	stlibrd_t		*brdp;
-	unsigned int		head, tail, len;
-	unsigned long		flags;
-
-#ifdef DEBUG
-	printk("stli_charsinbuffer(tty=%x)\n", (int) tty);
-#endif
+	cdkasyrq_t __iomem *rp;
+	stliport_t *portp;
+	stlibrd_t *brdp;
+	unsigned int head, tail, len;
+	unsigned long flags;
 
-	if (tty == (struct tty_struct *) NULL)
-		return(0);
 	if (tty == stli_txcooktty)
 		stli_flushchars(tty);
 	portp = tty->driver_data;
-	if (portp == (stliport_t *) NULL)
-		return(0);
+	if (portp == NULL)
+		return 0;
 	if ((portp->brdnr < 0) || (portp->brdnr >= stli_nrbrds))
-		return(0);
+		return 0;
 	brdp = stli_brds[portp->brdnr];
-	if (brdp == (stlibrd_t *) NULL)
-		return(0);
+	if (brdp == NULL)
+		return 0;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&brd_lock, flags);
 	EBRDENABLE(brdp);
-	rp = &((volatile cdkasy_t *) EBRDGETMEMPTR(brdp, portp->addr))->txq;
-	head = (unsigned int) rp->head;
-	tail = (unsigned int) rp->tail;
-	if (tail != ((unsigned int) rp->tail))
-		tail = (unsigned int) rp->tail;
+	rp = &((cdkasy_t __iomem *) EBRDGETMEMPTR(brdp, portp->addr))->txq;
+	head = (unsigned int) readw(&rp->head);
+	tail = (unsigned int) readw(&rp->tail);
+	if (tail != ((unsigned int) readw(&rp->tail)))
+		tail = (unsigned int) readw(&rp->tail);
 	len = (head >= tail) ? (head - tail) : (portp->txsize - (tail - head));
 	if ((len == 0) && test_bit(ST_TXBUSY, &portp->state))
 		len = 1;
 	EBRDDISABLE(brdp);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&brd_lock, flags);
 
-	return(len);
+	return len;
 }
 
 /*****************************************************************************/
@@ -1843,12 +1725,8 @@
 
 static int stli_getserial(stliport_t *portp, struct serial_struct __user *sp)
 {
-	struct serial_struct	sio;
-	stlibrd_t		*brdp;
-
-#ifdef DEBUG
-	printk("stli_getserial(portp=%x,sp=%x)\n", (int) portp, (int) sp);
-#endif
+	struct serial_struct sio;
+	stlibrd_t *brdp;
 
 	memset(&sio, 0, sizeof(struct serial_struct));
 	sio.type = PORT_UNKNOWN;
@@ -1863,7 +1741,7 @@
 	sio.hub6 = 0;
 
 	brdp = stli_brds[portp->brdnr];
-	if (brdp != (stlibrd_t *) NULL)
+	if (brdp != NULL)
 		sio.port = brdp->iobase;
 		
 	return copy_to_user(sp, &sio, sizeof(struct serial_struct)) ?
@@ -1880,12 +1758,8 @@
 
 static int stli_setserial(stliport_t *portp, struct serial_struct __user *sp)
 {
-	struct serial_struct	sio;
-	int			rc;
-
-#ifdef DEBUG
-	printk("stli_setserial(portp=%p,sp=%p)\n", portp, sp);
-#endif
+	struct serial_struct sio;
+	int rc;
 
 	if (copy_from_user(&sio, sp, sizeof(struct serial_struct)))
 		return -EFAULT;
@@ -1894,7 +1768,7 @@
 		    (sio.close_delay != portp->close_delay) ||
 		    ((sio.flags & ~ASYNC_USR_MASK) !=
 		    (portp->flags & ~ASYNC_USR_MASK)))
-			return(-EPERM);
+			return -EPERM;
 	} 
 
 	portp->flags = (portp->flags & ~ASYNC_USR_MASK) |
@@ -1905,8 +1779,8 @@
 	portp->custom_divisor = sio.custom_divisor;
 
 	if ((rc = stli_setport(portp)) < 0)
-		return(rc);
-	return(0);
+		return rc;
+	return 0;
 }
 
 /*****************************************************************************/
@@ -1917,19 +1791,19 @@
 	stlibrd_t *brdp;
 	int rc;
 
-	if (portp == (stliport_t *) NULL)
-		return(-ENODEV);
-	if ((portp->brdnr < 0) || (portp->brdnr >= stli_nrbrds))
-		return(0);
+	if (portp == NULL)
+		return -ENODEV;
+	if (portp->brdnr < 0 || portp->brdnr >= stli_nrbrds)
+		return 0;
 	brdp = stli_brds[portp->brdnr];
-	if (brdp == (stlibrd_t *) NULL)
-		return(0);
+	if (brdp == NULL)
+		return 0;
 	if (tty->flags & (1 << TTY_IO_ERROR))
-		return(-EIO);
+		return -EIO;
 
 	if ((rc = stli_cmdwait(brdp, portp, A_GETSIGNALS,
 			       &portp->asig, sizeof(asysigs_t), 1)) < 0)
-		return(rc);
+		return rc;
 
 	return stli_mktiocm(portp->asig.sigvalue);
 }
@@ -1941,15 +1815,15 @@
 	stlibrd_t *brdp;
 	int rts = -1, dtr = -1;
 
-	if (portp == (stliport_t *) NULL)
-		return(-ENODEV);
-	if ((portp->brdnr < 0) || (portp->brdnr >= stli_nrbrds))
-		return(0);
+	if (portp == NULL)
+		return -ENODEV;
+	if (portp->brdnr < 0 || portp->brdnr >= stli_nrbrds)
+		return 0;
 	brdp = stli_brds[portp->brdnr];
-	if (brdp == (stlibrd_t *) NULL)
-		return(0);
+	if (brdp == NULL)
+		return 0;
 	if (tty->flags & (1 << TTY_IO_ERROR))
-		return(-EIO);
+		return -EIO;
 
 	if (set & TIOCM_RTS)
 		rts = 1;
@@ -1968,32 +1842,25 @@
 
 static int stli_ioctl(struct tty_struct *tty, struct file *file, unsigned int cmd, unsigned long arg)
 {
-	stliport_t	*portp;
-	stlibrd_t	*brdp;
-	unsigned int	ival;
-	int		rc;
+	stliport_t *portp;
+	stlibrd_t *brdp;
+	unsigned int ival;
+	int rc;
 	void __user *argp = (void __user *)arg;
 
-#ifdef DEBUG
-	printk("stli_ioctl(tty=%x,file=%x,cmd=%x,arg=%x)\n",
-		(int) tty, (int) file, cmd, (int) arg);
-#endif
-
-	if (tty == (struct tty_struct *) NULL)
-		return(-ENODEV);
 	portp = tty->driver_data;
-	if (portp == (stliport_t *) NULL)
-		return(-ENODEV);
-	if ((portp->brdnr < 0) || (portp->brdnr >= stli_nrbrds))
-		return(0);
+	if (portp == NULL)
+		return -ENODEV;
+	if (portp->brdnr < 0 || portp->brdnr >= stli_nrbrds)
+		return 0;
 	brdp = stli_brds[portp->brdnr];
-	if (brdp == (stlibrd_t *) NULL)
-		return(0);
+	if (brdp == NULL)
+		return 0;
 
 	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
  	    (cmd != COM_GETPORTSTATS) && (cmd != COM_CLRPORTSTATS)) {
 		if (tty->flags & (1 << TTY_IO_ERROR))
-			return(-EIO);
+			return -EIO;
 	}
 
 	rc = 0;
@@ -2040,7 +1907,7 @@
 		break;
 	}
 
-	return(rc);
+	return rc;
 }
 
 /*****************************************************************************/
@@ -2052,24 +1919,20 @@
 
 static void stli_settermios(struct tty_struct *tty, struct termios *old)
 {
-	stliport_t	*portp;
-	stlibrd_t	*brdp;
-	struct termios	*tiosp;
-	asyport_t	aport;
-
-#ifdef DEBUG
-	printk("stli_settermios(tty=%x,old=%x)\n", (int) tty, (int) old);
-#endif
+	stliport_t *portp;
+	stlibrd_t *brdp;
+	struct termios *tiosp;
+	asyport_t aport;
 
-	if (tty == (struct tty_struct *) NULL)
+	if (tty == NULL)
 		return;
 	portp = tty->driver_data;
-	if (portp == (stliport_t *) NULL)
+	if (portp == NULL)
 		return;
-	if ((portp->brdnr < 0) || (portp->brdnr >= stli_nrbrds))
+	if (portp->brdnr < 0 || portp->brdnr >= stli_nrbrds)
 		return;
 	brdp = stli_brds[portp->brdnr];
-	if (brdp == (stlibrd_t *) NULL)
+	if (brdp == NULL)
 		return;
 
 	tiosp = tty->termios;
@@ -2102,18 +1965,9 @@
 
 static void stli_throttle(struct tty_struct *tty)
 {
-	stliport_t	*portp;
-
-#ifdef DEBUG
-	printk("stli_throttle(tty=%x)\n", (int) tty);
-#endif
-
-	if (tty == (struct tty_struct *) NULL)
+	stliport_t	*portp = tty->driver_data;
+	if (portp == NULL)
 		return;
-	portp = tty->driver_data;
-	if (portp == (stliport_t *) NULL)
-		return;
-
 	set_bit(ST_RXSTOP, &portp->state);
 }
 
@@ -2127,88 +1981,30 @@
 
 static void stli_unthrottle(struct tty_struct *tty)
 {
-	stliport_t	*portp;
-
-#ifdef DEBUG
-	printk("stli_unthrottle(tty=%x)\n", (int) tty);
-#endif
-
-	if (tty == (struct tty_struct *) NULL)
-		return;
-	portp = tty->driver_data;
-	if (portp == (stliport_t *) NULL)
+	stliport_t	*portp = tty->driver_data;
+	if (portp == NULL)
 		return;
-
 	clear_bit(ST_RXSTOP, &portp->state);
 }
 
 /*****************************************************************************/
 
 /*
- *	Stop the transmitter. Basically to do this we will just turn TX
- *	interrupts off.
+ *	Stop the transmitter.
  */
 
 static void stli_stop(struct tty_struct *tty)
 {
-	stlibrd_t	*brdp;
-	stliport_t	*portp;
-	asyctrl_t	actrl;
-
-#ifdef DEBUG
-	printk("stli_stop(tty=%x)\n", (int) tty);
-#endif
-
-	if (tty == (struct tty_struct *) NULL)
-		return;
-	portp = tty->driver_data;
-	if (portp == (stliport_t *) NULL)
-		return;
-	if ((portp->brdnr < 0) || (portp->brdnr >= stli_nrbrds))
-		return;
-	brdp = stli_brds[portp->brdnr];
-	if (brdp == (stlibrd_t *) NULL)
-		return;
-
-	memset(&actrl, 0, sizeof(asyctrl_t));
-	actrl.txctrl = CT_STOPFLOW;
-#if 0
-	stli_cmdwait(brdp, portp, A_PORTCTRL, &actrl, sizeof(asyctrl_t), 0);
-#endif
 }
 
 /*****************************************************************************/
 
 /*
- *	Start the transmitter again. Just turn TX interrupts back on.
+ *	Start the transmitter again.
  */
 
 static void stli_start(struct tty_struct *tty)
 {
-	stliport_t	*portp;
-	stlibrd_t	*brdp;
-	asyctrl_t	actrl;
-
-#ifdef DEBUG
-	printk("stli_start(tty=%x)\n", (int) tty);
-#endif
-
-	if (tty == (struct tty_struct *) NULL)
-		return;
-	portp = tty->driver_data;
-	if (portp == (stliport_t *) NULL)
-		return;
-	if ((portp->brdnr < 0) || (portp->brdnr >= stli_nrbrds))
-		return;
-	brdp = stli_brds[portp->brdnr];
-	if (brdp == (stlibrd_t *) NULL)
-		return;
-
-	memset(&actrl, 0, sizeof(asyctrl_t));
-	actrl.txctrl = CT_STARTFLOW;
-#if 0
-	stli_cmdwait(brdp, portp, A_PORTCTRL, &actrl, sizeof(asyctrl_t), 0);
-#endif
 }
 
 /*****************************************************************************/
@@ -2224,22 +2020,9 @@
 
 static void stli_dohangup(void *arg)
 {
-	stliport_t	*portp;
-
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_dohangup(portp=%x)\n", (int) arg);
-#endif
-
-	/*
-	 * FIXME: There's a module removal race here: tty_hangup
-	 * calls schedule_work which will call into this
-	 * driver later.
-	 */
-	portp = (stliport_t *) arg;
-	if (portp != (stliport_t *) NULL) {
-		if (portp->tty != (struct tty_struct *) NULL) {
-			tty_hangup(portp->tty);
-		}
+	stliport_t *portp = (stliport_t *) arg;
+	if (portp->tty != NULL) {
+		tty_hangup(portp->tty);
 	}
 }
 
@@ -2254,31 +2037,25 @@
 
 static void stli_hangup(struct tty_struct *tty)
 {
-	stliport_t	*portp;
-	stlibrd_t	*brdp;
-	unsigned long	flags;
-
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_hangup(tty=%x)\n", (int) tty);
-#endif
+	stliport_t *portp;
+	stlibrd_t *brdp;
+	unsigned long flags;
 
-	if (tty == (struct tty_struct *) NULL)
-		return;
 	portp = tty->driver_data;
-	if (portp == (stliport_t *) NULL)
+	if (portp == NULL)
 		return;
-	if ((portp->brdnr < 0) || (portp->brdnr >= stli_nrbrds))
+	if (portp->brdnr < 0 || portp->brdnr >= stli_nrbrds)
 		return;
 	brdp = stli_brds[portp->brdnr];
-	if (brdp == (stlibrd_t *) NULL)
+	if (brdp == NULL)
 		return;
 
 	portp->flags &= ~ASYNC_INITIALIZED;
 
-	save_flags(flags);
-	cli();
-	if (! test_bit(ST_CLOSING, &portp->state))
+	if (!test_bit(ST_CLOSING, &portp->state))
 		stli_rawclose(brdp, portp, 0, 0);
+
+	spin_lock_irqsave(&stli_lock, flags);
 	if (tty->termios->c_cflag & HUPCL) {
 		stli_mkasysigs(&portp->asig, 0, 0);
 		if (test_bit(ST_CMDING, &portp->state)) {
@@ -2290,14 +2067,15 @@
 				&portp->asig, sizeof(asysigs_t), 0);
 		}
 	}
-	restore_flags(flags);
 
 	clear_bit(ST_TXBUSY, &portp->state);
 	clear_bit(ST_RXSTOP, &portp->state);
 	set_bit(TTY_IO_ERROR, &tty->flags);
-	portp->tty = (struct tty_struct *) NULL;
+	portp->tty = NULL;
 	portp->flags &= ~ASYNC_NORMAL_ACTIVE;
 	portp->refcount = 0;
+	spin_unlock_irqrestore(&stli_lock, flags);
+	
 	wake_up_interruptible(&portp->open_wait);
 }
 
@@ -2312,29 +2090,22 @@
 
 static void stli_flushbuffer(struct tty_struct *tty)
 {
-	stliport_t	*portp;
-	stlibrd_t	*brdp;
-	unsigned long	ftype, flags;
-
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_flushbuffer(tty=%x)\n", (int) tty);
-#endif
+	stliport_t *portp;
+	stlibrd_t *brdp;
+	unsigned long ftype, flags;
 
-	if (tty == (struct tty_struct *) NULL)
-		return;
 	portp = tty->driver_data;
-	if (portp == (stliport_t *) NULL)
+	if (portp == NULL)
 		return;
-	if ((portp->brdnr < 0) || (portp->brdnr >= stli_nrbrds))
+	if (portp->brdnr < 0 || portp->brdnr >= stli_nrbrds)
 		return;
 	brdp = stli_brds[portp->brdnr];
-	if (brdp == (stlibrd_t *) NULL)
+	if (brdp == NULL)
 		return;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&brd_lock, flags);
 	if (tty == stli_txcooktty) {
-		stli_txcooktty = (struct tty_struct *) NULL;
+		stli_txcooktty = NULL;
 		stli_txcooksize = 0;
 		stli_txcookrealsize = 0;
 	}
@@ -2346,15 +2117,10 @@
 			ftype |= FLUSHRX;
 			clear_bit(ST_DOFLUSHRX, &portp->state);
 		}
-		stli_sendcmd(brdp, portp, A_FLUSH, &ftype,
-			sizeof(unsigned long), 0);
+		__stli_sendcmd(brdp, portp, A_FLUSH, &ftype, sizeof(u32), 0);
 	}
-	restore_flags(flags);
-
-	wake_up_interruptible(&tty->write_wait);
-	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
-	    tty->ldisc.write_wakeup)
-		(tty->ldisc.write_wakeup)(tty);
+	spin_unlock_irqrestore(&brd_lock, flags);
+	tty_wakeup(tty);
 }
 
 /*****************************************************************************/
@@ -2364,55 +2130,31 @@
 	stlibrd_t	*brdp;
 	stliport_t	*portp;
 	long		arg;
-	/* long savestate, savetime; */
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_breakctl(tty=%x,state=%d)\n", (int) tty, state);
-#endif
-
-	if (tty == (struct tty_struct *) NULL)
-		return;
 	portp = tty->driver_data;
-	if (portp == (stliport_t *) NULL)
+	if (portp == NULL)
 		return;
-	if ((portp->brdnr < 0) || (portp->brdnr >= stli_nrbrds))
+	if (portp->brdnr < 0 || portp->brdnr >= stli_nrbrds)
 		return;
 	brdp = stli_brds[portp->brdnr];
-	if (brdp == (stlibrd_t *) NULL)
+	if (brdp == NULL)
 		return;
 
-/*
- *	Due to a bug in the tty send_break() code we need to preserve
- *	the current process state and timeout...
-	savetime = current->timeout;
-	savestate = current->state;
- */
-
 	arg = (state == -1) ? BREAKON : BREAKOFF;
 	stli_cmdwait(brdp, portp, A_BREAK, &arg, sizeof(long), 0);
-
-/*
- *
-	current->timeout = savetime;
-	current->state = savestate;
- */
 }
 
 /*****************************************************************************/
 
 static void stli_waituntilsent(struct tty_struct *tty, int timeout)
 {
-	stliport_t	*portp;
-	unsigned long	tend;
-
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_waituntilsent(tty=%x,timeout=%x)\n", (int) tty, timeout);
-#endif
+	stliport_t *portp;
+	unsigned long tend;
 
-	if (tty == (struct tty_struct *) NULL)
+	if (tty == NULL)
 		return;
 	portp = tty->driver_data;
-	if (portp == (stliport_t *) NULL)
+	if (portp == NULL)
 		return;
 
 	if (timeout == 0)
@@ -2436,19 +2178,13 @@
 	stliport_t	*portp;
 	asyctrl_t	actrl;
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_sendxchar(tty=%x,ch=%x)\n", (int) tty, ch);
-#endif
-
-	if (tty == (struct tty_struct *) NULL)
-		return;
 	portp = tty->driver_data;
-	if (portp == (stliport_t *) NULL)
+	if (portp == NULL)
 		return;
-	if ((portp->brdnr < 0) || (portp->brdnr >= stli_nrbrds))
+	if (portp->brdnr < 0 || portp->brdnr >= stli_nrbrds)
 		return;
 	brdp = stli_brds[portp->brdnr];
-	if (brdp == (stlibrd_t *) NULL)
+	if (brdp == NULL)
 		return;
 
 	memset(&actrl, 0, sizeof(asyctrl_t));
@@ -2460,7 +2196,6 @@
 		actrl.txctrl = CT_SENDCHR;
 		actrl.tximdch = ch;
 	}
-
 	stli_cmdwait(brdp, portp, A_PORTCTRL, &actrl, sizeof(asyctrl_t), 0);
 }
 
@@ -2476,17 +2211,17 @@
 
 static int stli_portinfo(stlibrd_t *brdp, stliport_t *portp, int portnr, char *pos)
 {
-	char	*sp, *uart;
-	int	rc, cnt;
+	char *sp, *uart;
+	int rc, cnt;
 
 	rc = stli_portcmdstats(portp);
 
 	uart = "UNKNOWN";
 	if (brdp->state & BST_STARTED) {
 		switch (stli_comstats.hwid) {
-		case 0:		uart = "2681"; break;
-		case 1:		uart = "SC26198"; break;
-		default:	uart = "CD1400"; break;
+		case 0:	uart = "2681"; break;
+		case 1:	uart = "SC26198"; break;
+		default:uart = "CD1400"; break;
 		}
 	}
 
@@ -2537,17 +2272,11 @@
 
 static int stli_readproc(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	stlibrd_t	*brdp;
-	stliport_t	*portp;
-	int		brdnr, portnr, totalport;
-	int		curoff, maxoff;
-	char		*pos;
-
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_readproc(page=%x,start=%x,off=%x,count=%d,eof=%x,"
-		"data=%x\n", (int) page, (int) start, (int) off, count,
-		(int) eof, (int) data);
-#endif
+	stlibrd_t *brdp;
+	stliport_t *portp;
+	int brdnr, portnr, totalport;
+	int curoff, maxoff;
+	char *pos;
 
 	pos = page;
 	totalport = 0;
@@ -2568,7 +2297,7 @@
  */
 	for (brdnr = 0; (brdnr < stli_nrbrds); brdnr++) {
 		brdp = stli_brds[brdnr];
-		if (brdp == (stlibrd_t *) NULL)
+		if (brdp == NULL)
 			continue;
 		if (brdp->state == 0)
 			continue;
@@ -2583,7 +2312,7 @@
 		for (portnr = 0; (portnr < brdp->nrports); portnr++,
 		    totalport++) {
 			portp = brdp->ports[portnr];
-			if (portp == (stliport_t *) NULL)
+			if (portp == NULL)
 				continue;
 			if (off >= (curoff += MAXLINE))
 				continue;
@@ -2610,49 +2339,54 @@
  *	a poll routine that does not have user context. Therefore you cannot
  *	copy back directly into user space, or to the kernel stack of a
  *	process. This routine does not sleep, so can be called from anywhere.
+ *
+ *	The caller must hold the brd_lock (see also stli_sendcmd the usual
+ *	entry point)
  */
 
-static void stli_sendcmd(stlibrd_t *brdp, stliport_t *portp, unsigned long cmd, void *arg, int size, int copyback)
+static void __stli_sendcmd(stlibrd_t *brdp, stliport_t *portp, unsigned long cmd, void *arg, int size, int copyback)
 {
-	volatile cdkhdr_t	*hdrp;
-	volatile cdkctrl_t	*cp;
-	volatile unsigned char	*bits;
-	unsigned long		flags;
-
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_sendcmd(brdp=%x,portp=%x,cmd=%x,arg=%x,size=%d,"
-		"copyback=%d)\n", (int) brdp, (int) portp, (int) cmd,
-		(int) arg, size, copyback);
-#endif
+	cdkhdr_t __iomem *hdrp;
+	cdkctrl_t __iomem *cp;
+	unsigned char __iomem *bits;
+	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&brd_lock, flags);
 
 	if (test_bit(ST_CMDING, &portp->state)) {
 		printk(KERN_ERR "STALLION: command already busy, cmd=%x!\n",
 				(int) cmd);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&brd_lock, flags);
 		return;
 	}
 
 	EBRDENABLE(brdp);
-	cp = &((volatile cdkasy_t *) EBRDGETMEMPTR(brdp, portp->addr))->ctrl;
+	cp = &((cdkasy_t __iomem *) EBRDGETMEMPTR(brdp, portp->addr))->ctrl;
 	if (size > 0) {
-		memcpy((void *) &(cp->args[0]), arg, size);
+		memcpy_toio((void __iomem *) &(cp->args[0]), arg, size);
 		if (copyback) {
 			portp->argp = arg;
 			portp->argsize = size;
 		}
 	}
-	cp->status = 0;
-	cp->cmd = cmd;
-	hdrp = (volatile cdkhdr_t *) EBRDGETMEMPTR(brdp, CDK_CDKADDR);
-	bits = ((volatile unsigned char *) hdrp) + brdp->slaveoffset +
+	writel(0, &cp->status);
+	writel(cmd, &cp->cmd);
+	hdrp = (cdkhdr_t __iomem *) EBRDGETMEMPTR(brdp, CDK_CDKADDR);
+	bits = ((unsigned char __iomem *) hdrp) + brdp->slaveoffset +
 		portp->portidx;
-	*bits |= portp->portbit;
+	writeb(readb(bits) | portp->portbit, bits);
 	set_bit(ST_CMDING, &portp->state);
 	EBRDDISABLE(brdp);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&brd_lock, flags);
+}
+
+static void stli_sendcmd(stlibrd_t *brdp, stliport_t *portp, unsigned long cmd, void *arg, int size, int copyback)
+{
+	unsigned long		flags;
+
+	spin_lock_irqsave(&brd_lock, flags);
+	__stli_sendcmd(brdp, portp, cmd, arg, size, copyback);
+	spin_unlock_irqrestore(&brd_lock, flags);
 }
 
 /*****************************************************************************/
@@ -2667,28 +2401,23 @@
 
 static void stli_read(stlibrd_t *brdp, stliport_t *portp)
 {
-	volatile cdkasyrq_t	*rp;
-	volatile char		*shbuf;
+	cdkasyrq_t __iomem *rp;
+	char __iomem *shbuf;
 	struct tty_struct	*tty;
-	unsigned int		head, tail, size;
-	unsigned int		len, stlen;
-
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_read(brdp=%x,portp=%d)\n",
-			(int) brdp, (int) portp);
-#endif
+	unsigned int head, tail, size;
+	unsigned int len, stlen;
 
 	if (test_bit(ST_RXSTOP, &portp->state))
 		return;
 	tty = portp->tty;
-	if (tty == (struct tty_struct *) NULL)
+	if (tty == NULL)
 		return;
 
-	rp = &((volatile cdkasy_t *) EBRDGETMEMPTR(brdp, portp->addr))->rxq;
-	head = (unsigned int) rp->head;
-	if (head != ((unsigned int) rp->head))
-		head = (unsigned int) rp->head;
-	tail = (unsigned int) rp->tail;
+	rp = &((cdkasy_t __iomem *) EBRDGETMEMPTR(brdp, portp->addr))->rxq;
+	head = (unsigned int) readw(&rp->head);
+	if (head != ((unsigned int) readw(&rp->head)))
+		head = (unsigned int) readw(&rp->head);
+	tail = (unsigned int) readw(&rp->tail);
 	size = portp->rxsize;
 	if (head >= tail) {
 		len = head - tail;
@@ -2699,12 +2428,15 @@
 	}
 
 	len = tty_buffer_request_room(tty, len);
-	/* FIXME : iomap ? */
-	shbuf = (volatile char *) EBRDGETMEMPTR(brdp, portp->rxoffset);
+
+	shbuf = (char __iomem *) EBRDGETMEMPTR(brdp, portp->rxoffset);
 
 	while (len > 0) {
+		unsigned char *cptr;
+		
 		stlen = MIN(len, stlen);
-		tty_insert_flip_string(tty, (char *)(shbuf + tail), stlen);
+		tty_prepare_flip_string(tty, &cptr, stlen);
+		memcpy_fromio(cptr, shbuf + tail, stlen);
 		len -= stlen;
 		tail += stlen;
 		if (tail >= size) {
@@ -2712,8 +2444,8 @@
 			stlen = head;
 		}
 	}
-	rp = &((volatile cdkasy_t *) EBRDGETMEMPTR(brdp, portp->addr))->rxq;
-	rp->tail = tail;
+	rp = &((cdkasy_t __iomem *) EBRDGETMEMPTR(brdp, portp->addr))->rxq;
+	writew(tail, &rp->tail);
 
 	if (head != tail)
 		set_bit(ST_RXING, &portp->state);
@@ -2729,9 +2461,9 @@
  *	difficult to deal with them here.
  */
 
-static void stli_dodelaycmd(stliport_t *portp, volatile cdkctrl_t *cp)
+static void stli_dodelaycmd(stliport_t *portp, cdkctrl_t __iomem *cp)
 {
-	int	cmd;
+	int cmd;
 
 	if (test_bit(ST_DOSIGS, &portp->state)) {
 		if (test_bit(ST_DOFLUSHTX, &portp->state) &&
@@ -2746,10 +2478,10 @@
 		clear_bit(ST_DOFLUSHTX, &portp->state);
 		clear_bit(ST_DOFLUSHRX, &portp->state);
 		clear_bit(ST_DOSIGS, &portp->state);
-		memcpy((void *) &(cp->args[0]), (void *) &portp->asig,
+		memcpy_toio((void __iomem *) &(cp->args[0]), (void *) &portp->asig,
 			sizeof(asysigs_t));
-		cp->status = 0;
-		cp->cmd = cmd;
+		writel(0, &cp->status);
+		writel(cmd, &cp->cmd);
 		set_bit(ST_CMDING, &portp->state);
 	} else if (test_bit(ST_DOFLUSHTX, &portp->state) ||
 	    test_bit(ST_DOFLUSHRX, &portp->state)) {
@@ -2757,9 +2489,9 @@
 		cmd |= ((test_bit(ST_DOFLUSHRX, &portp->state)) ? FLUSHRX : 0);
 		clear_bit(ST_DOFLUSHTX, &portp->state);
 		clear_bit(ST_DOFLUSHRX, &portp->state);
-		memcpy((void *) &(cp->args[0]), (void *) &cmd, sizeof(int));
-		cp->status = 0;
-		cp->cmd = A_FLUSH;
+		memcpy_toio((void __iomem *) &(cp->args[0]), (void *) &cmd, sizeof(int));
+		writel(0, &cp->status);
+		writel(A_FLUSH, &cp->cmd);
 		set_bit(ST_CMDING, &portp->state);
 	}
 }
@@ -2779,30 +2511,25 @@
 
 static int stli_hostcmd(stlibrd_t *brdp, stliport_t *portp)
 {
-	volatile cdkasy_t	*ap;
-	volatile cdkctrl_t	*cp;
-	struct tty_struct	*tty;
-	asynotify_t		nt;
-	unsigned long		oldsigs;
-	int			rc, donerx;
-
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_hostcmd(brdp=%x,channr=%d)\n",
-			(int) brdp, channr);
-#endif
+	cdkasy_t __iomem *ap;
+	cdkctrl_t __iomem *cp;
+	struct tty_struct *tty;
+	asynotify_t nt;
+	unsigned long oldsigs;
+	int rc, donerx;
 
-	ap = (volatile cdkasy_t *) EBRDGETMEMPTR(brdp, portp->addr);
+	ap = (cdkasy_t __iomem *) EBRDGETMEMPTR(brdp, portp->addr);
 	cp = &ap->ctrl;
 
 /*
  *	Check if we are waiting for an open completion message.
  */
 	if (test_bit(ST_OPENING, &portp->state)) {
-		rc = (int) cp->openarg;
-		if ((cp->open == 0) && (rc != 0)) {
+		rc = readl(&cp->openarg);
+		if (readb(&cp->open) == 0 && rc != 0) {
 			if (rc > 0)
 				rc--;
-			cp->openarg = 0;
+			writel(0, &cp->openarg);
 			portp->rc = rc;
 			clear_bit(ST_OPENING, &portp->state);
 			wake_up_interruptible(&portp->raw_wait);
@@ -2813,11 +2540,11 @@
  *	Check if we are waiting for a close completion message.
  */
 	if (test_bit(ST_CLOSING, &portp->state)) {
-		rc = (int) cp->closearg;
-		if ((cp->close == 0) && (rc != 0)) {
+		rc = (int) readl(&cp->closearg);
+		if (readb(&cp->close) == 0 && rc != 0) {
 			if (rc > 0)
 				rc--;
-			cp->closearg = 0;
+			writel(0, &cp->closearg);
 			portp->rc = rc;
 			clear_bit(ST_CLOSING, &portp->state);
 			wake_up_interruptible(&portp->raw_wait);
@@ -2829,16 +2556,16 @@
  *	need to copy out the command results associated with this command.
  */
 	if (test_bit(ST_CMDING, &portp->state)) {
-		rc = cp->status;
-		if ((cp->cmd == 0) && (rc != 0)) {
+		rc = readl(&cp->status);
+		if (readl(&cp->cmd) == 0 && rc != 0) {
 			if (rc > 0)
 				rc--;
-			if (portp->argp != (void *) NULL) {
-				memcpy(portp->argp, (void *) &(cp->args[0]),
+			if (portp->argp != NULL) {
+				memcpy_fromio(portp->argp, (void __iomem *) &(cp->args[0]),
 					portp->argsize);
-				portp->argp = (void *) NULL;
+				portp->argp = NULL;
 			}
-			cp->status = 0;
+			writel(0, &cp->status);
 			portp->rc = rc;
 			clear_bit(ST_CMDING, &portp->state);
 			stli_dodelaycmd(portp, cp);
@@ -2877,18 +2604,15 @@
 		if (nt.data & DT_TXEMPTY)
 			clear_bit(ST_TXBUSY, &portp->state);
 		if (nt.data & (DT_TXEMPTY | DT_TXLOW)) {
-			if (tty != (struct tty_struct *) NULL) {
-				if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
-				    tty->ldisc.write_wakeup) {
-					(tty->ldisc.write_wakeup)(tty);
-					EBRDENABLE(brdp);
-				}
+			if (tty != NULL) {
+				tty_wakeup(tty);
+				EBRDENABLE(brdp);
 				wake_up_interruptible(&tty->write_wait);
 			}
 		}
 
 		if ((nt.data & DT_RXBREAK) && (portp->rxmarkmsk & BRKINT)) {
-			if (tty != (struct tty_struct *) NULL) {
+			if (tty != NULL) {
 				tty_insert_flip_char(tty, 0, TTY_BREAK);
 				if (portp->flags & ASYNC_SAK) {
 					do_SAK(tty);
@@ -2932,14 +2656,14 @@
  *	at the cdk header structure.
  */
 
-static void stli_brdpoll(stlibrd_t *brdp, volatile cdkhdr_t *hdrp)
+static void stli_brdpoll(stlibrd_t *brdp, cdkhdr_t __iomem *hdrp)
 {
-	stliport_t	*portp;
-	unsigned char	hostbits[(STL_MAXCHANS / 8) + 1];
-	unsigned char	slavebits[(STL_MAXCHANS / 8) + 1];
-	unsigned char	*slavep;
-	int		bitpos, bitat, bitsize;
-	int 		channr, nrdevs, slavebitchange;
+	stliport_t *portp;
+	unsigned char hostbits[(STL_MAXCHANS / 8) + 1];
+	unsigned char slavebits[(STL_MAXCHANS / 8) + 1];
+	unsigned char __iomem *slavep;
+	int bitpos, bitat, bitsize;
+	int channr, nrdevs, slavebitchange;
 
 	bitsize = brdp->bitsize;
 	nrdevs = brdp->nrdevs;
@@ -2951,7 +2675,7 @@
  *	8 service bits at a time in the inner loop, so we can bypass
  *	the lot if none of them want service.
  */
-	memcpy(&hostbits[0], (((unsigned char *) hdrp) + brdp->hostoffset),
+	memcpy_fromio(&hostbits[0], (((unsigned char __iomem *) hdrp) + brdp->hostoffset),
 		bitsize);
 
 	memset(&slavebits[0], 0, bitsize);
@@ -2978,11 +2702,11 @@
  *	service may initiate more slave requests.
  */
 	if (slavebitchange) {
-		hdrp = (volatile cdkhdr_t *) EBRDGETMEMPTR(brdp, CDK_CDKADDR);
-		slavep = ((unsigned char *) hdrp) + brdp->slaveoffset;
+		hdrp = (cdkhdr_t __iomem *) EBRDGETMEMPTR(brdp, CDK_CDKADDR);
+		slavep = ((unsigned char __iomem *) hdrp) + brdp->slaveoffset;
 		for (bitpos = 0; (bitpos < bitsize); bitpos++) {
-			if (slavebits[bitpos])
-				slavep[bitpos] &= ~slavebits[bitpos];
+			if (readb(slavebits + bitpos))
+				writeb(readb(slavep + bitpos) & ~slavebits[bitpos], slavebits + bitpos);
 		}
 	}
 }
@@ -3000,9 +2724,9 @@
 
 static void stli_poll(unsigned long arg)
 {
-	volatile cdkhdr_t	*hdrp;
-	stlibrd_t		*brdp;
-	int 			brdnr;
+	cdkhdr_t __iomem *hdrp;
+	stlibrd_t *brdp;
+	int brdnr;
 
 	stli_timerlist.expires = STLI_TIMEOUT;
 	add_timer(&stli_timerlist);
@@ -3012,16 +2736,18 @@
  */
 	for (brdnr = 0; (brdnr < stli_nrbrds); brdnr++) {
 		brdp = stli_brds[brdnr];
-		if (brdp == (stlibrd_t *) NULL)
+		if (brdp == NULL)
 			continue;
 		if ((brdp->state & BST_STARTED) == 0)
 			continue;
 
+		spin_lock(&brd_lock);
 		EBRDENABLE(brdp);
-		hdrp = (volatile cdkhdr_t *) EBRDGETMEMPTR(brdp, CDK_CDKADDR);
-		if (hdrp->hostreq)
+		hdrp = (cdkhdr_t __iomem *) EBRDGETMEMPTR(brdp, CDK_CDKADDR);
+		if (readb(&hdrp->hostreq))
 			stli_brdpoll(brdp, hdrp);
 		EBRDDISABLE(brdp);
+		spin_unlock(&brd_lock);
 	}
 }
 
@@ -3034,11 +2760,6 @@
 
 static void stli_mkasyport(stliport_t *portp, asyport_t *pp, struct termios *tiosp)
 {
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_mkasyport(portp=%x,pp=%x,tiosp=%d)\n",
-		(int) portp, (int) pp, (int) tiosp);
-#endif
-
 	memset(pp, 0, sizeof(asyport_t));
 
 /*
@@ -3157,11 +2878,6 @@
 
 static void stli_mkasysigs(asysigs_t *sp, int dtr, int rts)
 {
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_mkasysigs(sp=%x,dtr=%d,rts=%d)\n",
-			(int) sp, dtr, rts);
-#endif
-
 	memset(sp, 0, sizeof(asysigs_t));
 	if (dtr >= 0) {
 		sp->signal |= SG_DTR;
@@ -3182,13 +2898,7 @@
 
 static long stli_mktiocm(unsigned long sigvalue)
 {
-	long	tiocm;
-
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_mktiocm(sigvalue=%x)\n", (int) sigvalue);
-#endif
-
-	tiocm = 0;
+	long	tiocm = 0;
 	tiocm |= ((sigvalue & SG_DCD) ? TIOCM_CD : 0);
 	tiocm |= ((sigvalue & SG_CTS) ? TIOCM_CTS : 0);
 	tiocm |= ((sigvalue & SG_RI) ? TIOCM_RI : 0);
@@ -3210,10 +2920,6 @@
 	stliport_t	*portp;
 	int		i, panelnr, panelport;
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_initports(brdp=%x)\n", (int) brdp);
-#endif
-
 	for (i = 0, panelnr = 0, panelport = 0; (i < brdp->nrports); i++) {
 		portp = kzalloc(sizeof(stliport_t), GFP_KERNEL);
 		if (!portp) {
@@ -3240,7 +2946,7 @@
 		brdp->ports[i] = portp;
 	}
 
-	return(0);
+	return 0;
 }
 
 /*****************************************************************************/
@@ -3253,10 +2959,6 @@
 {
 	unsigned long	memconf;
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_ecpinit(brdp=%d)\n", (int) brdp);
-#endif
-
 	outb(ECP_ATSTOP, (brdp->iobase + ECP_ATCONFR));
 	udelay(10);
 	outb(ECP_ATDISABLE, (brdp->iobase + ECP_ATCONFR));
@@ -3270,9 +2972,6 @@
 
 static void stli_ecpenable(stlibrd_t *brdp)
 {	
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_ecpenable(brdp=%x)\n", (int) brdp);
-#endif
 	outb(ECP_ATENABLE, (brdp->iobase + ECP_ATCONFR));
 }
 
@@ -3280,9 +2979,6 @@
 
 static void stli_ecpdisable(stlibrd_t *brdp)
 {	
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_ecpdisable(brdp=%x)\n", (int) brdp);
-#endif
 	outb(ECP_ATDISABLE, (brdp->iobase + ECP_ATCONFR));
 }
 
@@ -3290,13 +2986,8 @@
 
 static char *stli_ecpgetmemptr(stlibrd_t *brdp, unsigned long offset, int line)
 {	
-	void		*ptr;
-	unsigned char	val;
-
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_ecpgetmemptr(brdp=%x,offset=%x)\n", (int) brdp,
-		(int) offset);
-#endif
+	void *ptr;
+	unsigned char val;
 
 	if (offset > brdp->memsize) {
 		printk(KERN_ERR "STALLION: shared memory pointer=%x out of "
@@ -3316,10 +3007,6 @@
 
 static void stli_ecpreset(stlibrd_t *brdp)
 {	
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_ecpreset(brdp=%x)\n", (int) brdp);
-#endif
-
 	outb(ECP_ATSTOP, (brdp->iobase + ECP_ATCONFR));
 	udelay(10);
 	outb(ECP_ATDISABLE, (brdp->iobase + ECP_ATCONFR));
@@ -3330,9 +3017,6 @@
 
 static void stli_ecpintr(stlibrd_t *brdp)
 {	
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_ecpintr(brdp=%x)\n", (int) brdp);
-#endif
 	outb(0x1, brdp->iobase);
 }
 
@@ -3346,10 +3030,6 @@
 {
 	unsigned long	memconf;
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_ecpeiinit(brdp=%x)\n", (int) brdp);
-#endif
-
 	outb(0x1, (brdp->iobase + ECP_EIBRDENAB));
 	outb(ECP_EISTOP, (brdp->iobase + ECP_EICONFR));
 	udelay(10);
@@ -3383,11 +3063,6 @@
 	void		*ptr;
 	unsigned char	val;
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_ecpeigetmemptr(brdp=%x,offset=%x,line=%d)\n",
-		(int) brdp, (int) offset, line);
-#endif
-
 	if (offset > brdp->memsize) {
 		printk(KERN_ERR "STALLION: shared memory pointer=%x out of "
 				"range at line=%d(%d), brd=%d\n",
@@ -3437,8 +3112,8 @@
 
 static char *stli_ecpmcgetmemptr(stlibrd_t *brdp, unsigned long offset, int line)
 {	
-	void		*ptr;
-	unsigned char	val;
+	void *ptr;
+	unsigned char val;
 
 	if (offset > brdp->memsize) {
 		printk(KERN_ERR "STALLION: shared memory pointer=%x out of "
@@ -3472,10 +3147,6 @@
 
 static void stli_ecppciinit(stlibrd_t *brdp)
 {
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_ecppciinit(brdp=%x)\n", (int) brdp);
-#endif
-
 	outb(ECP_PCISTOP, (brdp->iobase + ECP_PCICONFR));
 	udelay(10);
 	outb(0, (brdp->iobase + ECP_PCICONFR));
@@ -3489,11 +3160,6 @@
 	void		*ptr;
 	unsigned char	val;
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_ecppcigetmemptr(brdp=%x,offset=%x,line=%d)\n",
-		(int) brdp, (int) offset, line);
-#endif
-
 	if (offset > brdp->memsize) {
 		printk(KERN_ERR "STALLION: shared memory pointer=%x out of "
 				"range at line=%d(%d), board=%d\n",
@@ -3528,10 +3194,6 @@
 {
 	unsigned long	memconf;
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_onbinit(brdp=%d)\n", (int) brdp);
-#endif
-
 	outb(ONB_ATSTOP, (brdp->iobase + ONB_ATCONFR));
 	udelay(10);
 	outb(ONB_ATDISABLE, (brdp->iobase + ONB_ATCONFR));
@@ -3547,9 +3209,6 @@
 
 static void stli_onbenable(stlibrd_t *brdp)
 {	
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_onbenable(brdp=%x)\n", (int) brdp);
-#endif
 	outb((brdp->enabval | ONB_ATENABLE), (brdp->iobase + ONB_ATCONFR));
 }
 
@@ -3557,9 +3216,6 @@
 
 static void stli_onbdisable(stlibrd_t *brdp)
 {	
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_onbdisable(brdp=%x)\n", (int) brdp);
-#endif
 	outb((brdp->enabval | ONB_ATDISABLE), (brdp->iobase + ONB_ATCONFR));
 }
 
@@ -3569,11 +3225,6 @@
 {	
 	void	*ptr;
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_onbgetmemptr(brdp=%x,offset=%x)\n", (int) brdp,
-		(int) offset);
-#endif
-
 	if (offset > brdp->memsize) {
 		printk(KERN_ERR "STALLION: shared memory pointer=%x out of "
 				"range at line=%d(%d), brd=%d\n",
@@ -3589,11 +3240,6 @@
 
 static void stli_onbreset(stlibrd_t *brdp)
 {	
-
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_onbreset(brdp=%x)\n", (int) brdp);
-#endif
-
 	outb(ONB_ATSTOP, (brdp->iobase + ONB_ATCONFR));
 	udelay(10);
 	outb(ONB_ATDISABLE, (brdp->iobase + ONB_ATCONFR));
@@ -3610,10 +3256,6 @@
 {
 	unsigned long	memconf;
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_onbeinit(brdp=%d)\n", (int) brdp);
-#endif
-
 	outb(0x1, (brdp->iobase + ONB_EIBRDENAB));
 	outb(ONB_EISTOP, (brdp->iobase + ONB_EICONFR));
 	udelay(10);
@@ -3632,9 +3274,6 @@
 
 static void stli_onbeenable(stlibrd_t *brdp)
 {	
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_onbeenable(brdp=%x)\n", (int) brdp);
-#endif
 	outb(ONB_EIENABLE, (brdp->iobase + ONB_EICONFR));
 }
 
@@ -3642,9 +3281,6 @@
 
 static void stli_onbedisable(stlibrd_t *brdp)
 {	
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_onbedisable(brdp=%x)\n", (int) brdp);
-#endif
 	outb(ONB_EIDISABLE, (brdp->iobase + ONB_EICONFR));
 }
 
@@ -3652,13 +3288,8 @@
 
 static char *stli_onbegetmemptr(stlibrd_t *brdp, unsigned long offset, int line)
 {	
-	void		*ptr;
-	unsigned char	val;
-
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_onbegetmemptr(brdp=%x,offset=%x,line=%d)\n",
-		(int) brdp, (int) offset, line);
-#endif
+	void *ptr;
+	unsigned char val;
 
 	if (offset > brdp->memsize) {
 		printk(KERN_ERR "STALLION: shared memory pointer=%x out of "
@@ -3681,11 +3312,6 @@
 
 static void stli_onbereset(stlibrd_t *brdp)
 {	
-
-#ifdef DEBUG
-	printk(KERN_ERR "stli_onbereset(brdp=%x)\n", (int) brdp);
-#endif
-
 	outb(ONB_EISTOP, (brdp->iobase + ONB_EICONFR));
 	udelay(10);
 	outb(ONB_EIDISABLE, (brdp->iobase + ONB_EICONFR));
@@ -3700,11 +3326,6 @@
 
 static void stli_bbyinit(stlibrd_t *brdp)
 {
-
-#ifdef DEBUG
-	printk(KERN_ERR "stli_bbyinit(brdp=%d)\n", (int) brdp);
-#endif
-
 	outb(BBY_ATSTOP, (brdp->iobase + BBY_ATCONFR));
 	udelay(10);
 	outb(0, (brdp->iobase + BBY_ATCONFR));
@@ -3717,24 +3338,13 @@
 
 static char *stli_bbygetmemptr(stlibrd_t *brdp, unsigned long offset, int line)
 {	
-	void		*ptr;
-	unsigned char	val;
+	void *ptr;
+	unsigned char val;
 
-#ifdef DEBUG
-	printk(KERN_ERR "stli_bbygetmemptr(brdp=%x,offset=%x)\n", (int) brdp,
-		(int) offset);
-#endif
+	BUG_ON(offset > brdp->memsize);
 
-	if (offset > brdp->memsize) {
-		printk(KERN_ERR "STALLION: shared memory pointer=%x out of "
-				"range at line=%d(%d), brd=%d\n",
-				(int) offset, line, __LINE__, brdp->brdnr);
-		ptr = NULL;
-		val = 0;
-	} else {
-		ptr = brdp->membase + (offset % BBY_PAGESIZE);
-		val = (unsigned char) (offset / BBY_PAGESIZE);
-	}
+	ptr = brdp->membase + (offset % BBY_PAGESIZE);
+	val = (unsigned char) (offset / BBY_PAGESIZE);
 	outb(val, (brdp->iobase + BBY_ATCONFR));
 	return(ptr);
 }
@@ -3743,11 +3353,6 @@
 
 static void stli_bbyreset(stlibrd_t *brdp)
 {	
-
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_bbyreset(brdp=%x)\n", (int) brdp);
-#endif
-
 	outb(BBY_ATSTOP, (brdp->iobase + BBY_ATCONFR));
 	udelay(10);
 	outb(0, (brdp->iobase + BBY_ATCONFR));
@@ -3762,11 +3367,6 @@
 
 static void stli_stalinit(stlibrd_t *brdp)
 {
-
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_stalinit(brdp=%d)\n", (int) brdp);
-#endif
-
 	outb(0x1, brdp->iobase);
 	mdelay(1000);
 }
@@ -3775,36 +3375,18 @@
 
 static char *stli_stalgetmemptr(stlibrd_t *brdp, unsigned long offset, int line)
 {	
-	void	*ptr;
-
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_stalgetmemptr(brdp=%x,offset=%x)\n", (int) brdp,
-		(int) offset);
-#endif
-
-	if (offset > brdp->memsize) {
-		printk(KERN_ERR "STALLION: shared memory pointer=%x out of "
-				"range at line=%d(%d), brd=%d\n",
-				(int) offset, line, __LINE__, brdp->brdnr);
-		ptr = NULL;
-	} else {
-		ptr = brdp->membase + (offset % STAL_PAGESIZE);
-	}
-	return(ptr);
+	BUG_ON(offset > brdp->memsize);
+	return brdp->membase + (offset % STAL_PAGESIZE);
 }
 
 /*****************************************************************************/
 
 static void stli_stalreset(stlibrd_t *brdp)
 {	
-	volatile unsigned long	*vecp;
+	u32 __iomem *vecp;
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_stalreset(brdp=%x)\n", (int) brdp);
-#endif
-
-	vecp = (volatile unsigned long *) (brdp->membase + 0x30);
-	*vecp = 0xffff0000;
+	vecp = (u32 __iomem *) (brdp->membase + 0x30);
+	writel(0xffff0000, vecp);
 	outb(0, brdp->iobase);
 	mdelay(1000);
 }
@@ -3818,15 +3400,11 @@
 
 static int stli_initecp(stlibrd_t *brdp)
 {
-	cdkecpsig_t	sig;
-	cdkecpsig_t	*sigsp;
-	unsigned int	status, nxtid;
-	char		*name;
-	int		panelnr, nrports;
-
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_initecp(brdp=%x)\n", (int) brdp);
-#endif
+	cdkecpsig_t sig;
+	cdkecpsig_t __iomem *sigsp;
+	unsigned int status, nxtid;
+	char *name;
+	int panelnr, nrports;
 
 	if (!request_region(brdp->iobase, brdp->iosize, "istallion"))
 		return -EIO;
@@ -3834,7 +3412,7 @@
 	if ((brdp->iobase == 0) || (brdp->memaddr == 0))
 	{
 		release_region(brdp->iobase, brdp->iosize);
-		return(-ENODEV);
+		return -ENODEV;
 	}
 
 	brdp->iosize = ECP_IOSIZE;
@@ -3903,7 +3481,7 @@
 
 	default:
 		release_region(brdp->iobase, brdp->iosize);
-		return(-EINVAL);
+		return -EINVAL;
 	}
 
 /*
@@ -3915,10 +3493,10 @@
 	EBRDINIT(brdp);
 
 	brdp->membase = ioremap(brdp->memaddr, brdp->memsize);
-	if (brdp->membase == (void *) NULL)
+	if (brdp->membase == NULL)
 	{
 		release_region(brdp->iobase, brdp->iosize);
-		return(-ENOMEM);
+		return -ENOMEM;
 	}
 
 /*
@@ -3927,23 +3505,14 @@
  *	this is, and what it is connected to it.
  */
 	EBRDENABLE(brdp);
-	sigsp = (cdkecpsig_t *) EBRDGETMEMPTR(brdp, CDK_SIGADDR);
+	sigsp = (cdkecpsig_t __iomem *) EBRDGETMEMPTR(brdp, CDK_SIGADDR);
 	memcpy(&sig, sigsp, sizeof(cdkecpsig_t));
 	EBRDDISABLE(brdp);
 
-#if 0
-	printk("%s(%d): sig-> magic=%x rom=%x panel=%x,%x,%x,%x,%x,%x,%x,%x\n",
-		__FILE__, __LINE__, (int) sig.magic, sig.romver, sig.panelid[0],
-		(int) sig.panelid[1], (int) sig.panelid[2],
-		(int) sig.panelid[3], (int) sig.panelid[4],
-		(int) sig.panelid[5], (int) sig.panelid[6],
-		(int) sig.panelid[7]);
-#endif
-
-	if (sig.magic != ECP_MAGIC)
+	if (sig.magic != cpu_to_le32(ECP_MAGIC))
 	{
 		release_region(brdp->iobase, brdp->iosize);
-		return(-ENODEV);
+		return -ENODEV;
 	}
 
 /*
@@ -3967,7 +3536,7 @@
 
 
 	brdp->state |= BST_FOUND;
-	return(0);
+	return 0;
 }
 
 /*****************************************************************************/
@@ -3979,20 +3548,16 @@
 
 static int stli_initonb(stlibrd_t *brdp)
 {
-	cdkonbsig_t	sig;
-	cdkonbsig_t	*sigsp;
-	char		*name;
-	int		i;
-
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_initonb(brdp=%x)\n", (int) brdp);
-#endif
+	cdkonbsig_t sig;
+	cdkonbsig_t __iomem *sigsp;
+	char *name;
+	int i;
 
 /*
  *	Do a basic sanity check on the IO and memory addresses.
  */
-	if ((brdp->iobase == 0) || (brdp->memaddr == 0))
-		return(-ENODEV);
+	if (brdp->iobase == 0 || brdp->memaddr == 0)
+		return -ENODEV;
 
 	brdp->iosize = ONB_IOSIZE;
 	
@@ -4010,7 +3575,6 @@
 	case BRD_ONBOARD2:
 	case BRD_ONBOARD2_32:
 	case BRD_ONBOARDRS:
-		brdp->membase = (void *) brdp->memaddr;
 		brdp->memsize = ONB_MEMSIZE;
 		brdp->pagesize = ONB_ATPAGESIZE;
 		brdp->init = stli_onbinit;
@@ -4028,7 +3592,6 @@
 		break;
 
 	case BRD_ONBOARDE:
-		brdp->membase = (void *) brdp->memaddr;
 		brdp->memsize = ONB_EIMEMSIZE;
 		brdp->pagesize = ONB_EIPAGESIZE;
 		brdp->init = stli_onbeinit;
@@ -4044,7 +3607,6 @@
 	case BRD_BRUMBY4:
 	case BRD_BRUMBY8:
 	case BRD_BRUMBY16:
-		brdp->membase = (void *) brdp->memaddr;
 		brdp->memsize = BBY_MEMSIZE;
 		brdp->pagesize = BBY_PAGESIZE;
 		brdp->init = stli_bbyinit;
@@ -4058,7 +3620,6 @@
 		break;
 
 	case BRD_STALLION:
-		brdp->membase = (void *) brdp->memaddr;
 		brdp->memsize = STAL_MEMSIZE;
 		brdp->pagesize = STAL_PAGESIZE;
 		brdp->init = stli_stalinit;
@@ -4073,7 +3634,7 @@
 
 	default:
 		release_region(brdp->iobase, brdp->iosize);
-		return(-EINVAL);
+		return -EINVAL;
 	}
 
 /*
@@ -4085,10 +3646,10 @@
 	EBRDINIT(brdp);
 
 	brdp->membase = ioremap(brdp->memaddr, brdp->memsize);
-	if (brdp->membase == (void *) NULL)
+	if (brdp->membase == NULL)
 	{
 		release_region(brdp->iobase, brdp->iosize);
-		return(-ENOMEM);
+		return -ENOMEM;
 	}
 
 /*
@@ -4097,21 +3658,17 @@
  *	this is, and how many ports.
  */
 	EBRDENABLE(brdp);
-	sigsp = (cdkonbsig_t *) EBRDGETMEMPTR(brdp, CDK_SIGADDR);
-	memcpy(&sig, sigsp, sizeof(cdkonbsig_t));
+	sigsp = (cdkonbsig_t __iomem *) EBRDGETMEMPTR(brdp, CDK_SIGADDR);
+	memcpy_fromio(&sig, sigsp, sizeof(cdkonbsig_t));
 	EBRDDISABLE(brdp);
 
-#if 0
-	printk("%s(%d): sig-> magic=%x:%x:%x:%x romver=%x amask=%x:%x:%x\n",
-		__FILE__, __LINE__, sig.magic0, sig.magic1, sig.magic2,
-		sig.magic3, sig.romver, sig.amask0, sig.amask1, sig.amask2);
-#endif
-
-	if ((sig.magic0 != ONB_MAGIC0) || (sig.magic1 != ONB_MAGIC1) ||
-	    (sig.magic2 != ONB_MAGIC2) || (sig.magic3 != ONB_MAGIC3))
+	if (sig.magic0 != cpu_to_le16(ONB_MAGIC0) || 
+	    sig.magic1 != cpu_to_le16(ONB_MAGIC1) ||
+	    sig.magic2 != cpu_to_le16(ONB_MAGIC2) || 
+	    sig.magic3 != cpu_to_le16(ONB_MAGIC3))
 	{
 		release_region(brdp->iobase, brdp->iosize);
-		return(-ENODEV);
+		return -ENODEV;
 	}
 
 /*
@@ -4132,7 +3689,7 @@
 
 
 	brdp->state |= BST_FOUND;
-	return(0);
+	return 0;
 }
 
 /*****************************************************************************/
@@ -4145,31 +3702,25 @@
 
 static int stli_startbrd(stlibrd_t *brdp)
 {
-	volatile cdkhdr_t	*hdrp;
-	volatile cdkmem_t	*memp;
-	volatile cdkasy_t	*ap;
-	unsigned long		flags;
-	stliport_t		*portp;
-	int			portnr, nrdevs, i, rc;
-
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_startbrd(brdp=%x)\n", (int) brdp);
-#endif
-
-	rc = 0;
+	cdkhdr_t __iomem *hdrp;
+	cdkmem_t __iomem *memp;
+	cdkasy_t __iomem *ap;
+	unsigned long flags;
+	stliport_t *portp;
+	int portnr, nrdevs, i, rc = 0;
+	u32 memoff;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&brd_lock, flags);
 	EBRDENABLE(brdp);
-	hdrp = (volatile cdkhdr_t *) EBRDGETMEMPTR(brdp, CDK_CDKADDR);
+	hdrp = (cdkhdr_t __iomem *) EBRDGETMEMPTR(brdp, CDK_CDKADDR);
 	nrdevs = hdrp->nrdevs;
 
 #if 0
 	printk("%s(%d): CDK version %d.%d.%d --> "
 		"nrdevs=%d memp=%x hostp=%x slavep=%x\n",
-		 __FILE__, __LINE__, hdrp->ver_release, hdrp->ver_modification,
-		 hdrp->ver_fix, nrdevs, (int) hdrp->memp, (int) hdrp->hostp,
-		 (int) hdrp->slavep);
+		 __FILE__, __LINE__, readb(&hdrp->ver_release), readb(&hdrp->ver_modification),
+		 readb(&hdrp->ver_fix), nrdevs, (int) readl(&hdrp->memp), readl(&hdrp->hostp),
+		 readl(&hdrp->slavep));
 #endif
 
 	if (nrdevs < (brdp->nrports + 1)) {
@@ -4181,14 +3732,14 @@
 	brdp->hostoffset = hdrp->hostp - CDK_CDKADDR;
 	brdp->slaveoffset = hdrp->slavep - CDK_CDKADDR;
 	brdp->bitsize = (nrdevs + 7) / 8;
-	memp = (volatile cdkmem_t *) hdrp->memp;
-	if (((unsigned long) memp) > brdp->memsize) {
+	memoff = readl(&hdrp->memp);
+	if (memoff > brdp->memsize) {
 		printk(KERN_ERR "STALLION: corrupted shared memory region?\n");
 		rc = -EIO;
 		goto stli_donestartup;
 	}
-	memp = (volatile cdkmem_t *) EBRDGETMEMPTR(brdp, (unsigned long) memp);
-	if (memp->dtype != TYP_ASYNCTRL) {
+	memp = (cdkmem_t __iomem *) EBRDGETMEMPTR(brdp, memoff);
+	if (readw(&memp->dtype) != TYP_ASYNCTRL) {
 		printk(KERN_ERR "STALLION: no slave control device found\n");
 		goto stli_donestartup;
 	}
@@ -4200,19 +3751,19 @@
  *	change pages while reading memory map.
  */
 	for (i = 1, portnr = 0; (i < nrdevs); i++, portnr++, memp++) {
-		if (memp->dtype != TYP_ASYNC)
+		if (readw(&memp->dtype) != TYP_ASYNC)
 			break;
 		portp = brdp->ports[portnr];
-		if (portp == (stliport_t *) NULL)
+		if (portp == NULL)
 			break;
 		portp->devnr = i;
-		portp->addr = memp->offset;
+		portp->addr = readl(&memp->offset);
 		portp->reqbit = (unsigned char) (0x1 << (i * 8 / nrdevs));
 		portp->portidx = (unsigned char) (i / 8);
 		portp->portbit = (unsigned char) (0x1 << (i % 8));
 	}
 
-	hdrp->slavereq = 0xff;
+	writeb(0xff, &hdrp->slavereq);
 
 /*
  *	For each port setup a local copy of the RX and TX buffer offsets
@@ -4221,22 +3772,22 @@
  */
 	for (i = 1, portnr = 0; (i < nrdevs); i++, portnr++) {
 		portp = brdp->ports[portnr];
-		if (portp == (stliport_t *) NULL)
+		if (portp == NULL)
 			break;
 		if (portp->addr == 0)
 			break;
-		ap = (volatile cdkasy_t *) EBRDGETMEMPTR(brdp, portp->addr);
-		if (ap != (volatile cdkasy_t *) NULL) {
-			portp->rxsize = ap->rxq.size;
-			portp->txsize = ap->txq.size;
-			portp->rxoffset = ap->rxq.offset;
-			portp->txoffset = ap->txq.offset;
+		ap = (cdkasy_t __iomem *) EBRDGETMEMPTR(brdp, portp->addr);
+		if (ap != NULL) {
+			portp->rxsize = readw(&ap->rxq.size);
+			portp->txsize = readw(&ap->txq.size);
+			portp->rxoffset = readl(&ap->rxq.offset);
+			portp->txoffset = readl(&ap->txq.offset);
 		}
 	}
 
 stli_donestartup:
 	EBRDDISABLE(brdp);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&brd_lock, flags);
 
 	if (rc == 0)
 		brdp->state |= BST_STARTED;
@@ -4247,7 +3798,7 @@
 		add_timer(&stli_timerlist);
 	}
 
-	return(rc);
+	return rc;
 }
 
 /*****************************************************************************/
@@ -4258,10 +3809,6 @@
 
 static int __init stli_brdinit(stlibrd_t *brdp)
 {
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_brdinit(brdp=%x)\n", (int) brdp);
-#endif
-
 	stli_brds[brdp->brdnr] = brdp;
 
 	switch (brdp->brdtype) {
@@ -4289,11 +3836,11 @@
 	case BRD_ECHPCI:
 		printk(KERN_ERR "STALLION: %s board type not supported in "
 				"this driver\n", stli_brdnames[brdp->brdtype]);
-		return(ENODEV);
+		return -ENODEV;
 	default:
 		printk(KERN_ERR "STALLION: board=%d is unknown board "
 				"type=%d\n", brdp->brdnr, brdp->brdtype);
-		return(ENODEV);
+		return -ENODEV;
 	}
 
 	if ((brdp->state & BST_FOUND) == 0) {
@@ -4301,7 +3848,7 @@
 				"io=%x mem=%x\n",
 			stli_brdnames[brdp->brdtype], brdp->brdnr,
 			brdp->iobase, (int) brdp->memaddr);
-		return(ENODEV);
+		return -ENODEV;
 	}
 
 	stli_initports(brdp);
@@ -4309,7 +3856,7 @@
 		"nrpanels=%d nrports=%d\n", stli_brdnames[brdp->brdtype],
 		brdp->brdnr, brdp->iobase, (int) brdp->memaddr,
 		brdp->nrpanels, brdp->nrports);
-	return(0);
+	return 0;
 }
 
 /*****************************************************************************/
@@ -4321,14 +3868,10 @@
 
 static int stli_eisamemprobe(stlibrd_t *brdp)
 {
-	cdkecpsig_t	ecpsig, *ecpsigp;
-	cdkonbsig_t	onbsig, *onbsigp;
+	cdkecpsig_t	ecpsig, __iomem *ecpsigp;
+	cdkonbsig_t	onbsig, __iomem *onbsigp;
 	int		i, foundit;
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_eisamemprobe(brdp=%x)\n", (int) brdp);
-#endif
-
 /*
  *	First up we reset the board, to get it into a known state. There
  *	is only 2 board types here we need to worry about. Don;t use the
@@ -4352,7 +3895,7 @@
 		mdelay(1);
 		stli_onbeenable(brdp);
 	} else {
-		return(-ENODEV);
+		return -ENODEV;
 	}
 
 	foundit = 0;
@@ -4364,25 +3907,24 @@
  */
 	for (i = 0; (i < stli_eisamempsize); i++) {
 		brdp->memaddr = stli_eisamemprobeaddrs[i];
-		brdp->membase = (void *) brdp->memaddr;
 		brdp->membase = ioremap(brdp->memaddr, brdp->memsize);
-		if (brdp->membase == (void *) NULL)
+		if (brdp->membase == NULL)
 			continue;
 
 		if (brdp->brdtype == BRD_ECPE) {
-			ecpsigp = (cdkecpsig_t *) stli_ecpeigetmemptr(brdp,
+			ecpsigp = (cdkecpsig_t __iomem *) stli_ecpeigetmemptr(brdp,
 				CDK_SIGADDR, __LINE__);
-			memcpy(&ecpsig, ecpsigp, sizeof(cdkecpsig_t));
-			if (ecpsig.magic == ECP_MAGIC)
+			memcpy_fromio(&ecpsig, ecpsigp, sizeof(cdkecpsig_t));
+			if (ecpsig.magic == cpu_to_le32(ECP_MAGIC))
 				foundit = 1;
 		} else {
-			onbsigp = (cdkonbsig_t *) stli_onbegetmemptr(brdp,
+			onbsigp = (cdkonbsig_t __iomem *) stli_onbegetmemptr(brdp,
 				CDK_SIGADDR, __LINE__);
-			memcpy(&onbsig, onbsigp, sizeof(cdkonbsig_t));
-			if ((onbsig.magic0 == ONB_MAGIC0) &&
-			    (onbsig.magic1 == ONB_MAGIC1) &&
-			    (onbsig.magic2 == ONB_MAGIC2) &&
-			    (onbsig.magic3 == ONB_MAGIC3))
+			memcpy_fromio(&onbsig, onbsigp, sizeof(cdkonbsig_t));
+			if ((onbsig.magic0 == cpu_to_le16(ONB_MAGIC0)) &&
+			    (onbsig.magic1 == cpu_to_le16(ONB_MAGIC1)) &&
+			    (onbsig.magic2 == cpu_to_le16(ONB_MAGIC2)) &&
+			    (onbsig.magic3 == cpu_to_le16(ONB_MAGIC3)))
 				foundit = 1;
 		}
 
@@ -4406,9 +3948,9 @@
 		printk(KERN_ERR "STALLION: failed to probe shared memory "
 				"region for %s in EISA slot=%d\n",
 			stli_brdnames[brdp->brdtype], (brdp->iobase >> 12));
-		return(-ENODEV);
+		return -ENODEV;
 	}
-	return(0);
+	return 0;
 }
 
 static int stli_getbrdnr(void)
@@ -4439,22 +3981,16 @@
 
 static int stli_findeisabrds(void)
 {
-	stlibrd_t	*brdp;
-	unsigned int	iobase, eid;
-	int		i;
-
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_findeisabrds()\n");
-#endif
+	stlibrd_t *brdp;
+	unsigned int iobase, eid;
+	int i;
 
 /*
- *	Firstly check if this is an EISA system. Do this by probing for
- *	the system board EISA ID. If this is not an EISA system then
+ *	Firstly check if this is an EISA system.  If this is not an EISA system then
  *	don't bother going any further!
  */
-	outb(0xff, 0xc80);
-	if (inb(0xc80) == 0xff)
-		return(0);
+	if (EISA_bus)
+		return 0;
 
 /*
  *	Looks like an EISA system, so go searching for EISA boards.
@@ -4472,7 +4008,7 @@
  */
 		for (i = 0; (i < STL_MAXBRDS); i++) {
 			brdp = stli_brds[i];
-			if (brdp == (stlibrd_t *) NULL)
+			if (brdp == NULL)
 				continue;
 			if (brdp->iobase == iobase)
 				break;
@@ -4484,10 +4020,10 @@
  *		We have found a Stallion board and it is not configured already.
  *		Allocate a board structure and initialize it.
  */
-		if ((brdp = stli_allocbrd()) == (stlibrd_t *) NULL)
-			return(-ENOMEM);
+		if ((brdp = stli_allocbrd()) == NULL)
+			return -ENOMEM;
 		if ((brdp->brdnr = stli_getbrdnr()) < 0)
-			return(-ENOMEM);
+			return -ENOMEM;
 		eid = inb(iobase + 0xc82);
 		if (eid == ECP_EISAID)
 			brdp->brdtype = BRD_ECPE;
@@ -4502,7 +4038,7 @@
 		stli_brdinit(brdp);
 	}
 
-	return(0);
+	return 0;
 }
 
 /*****************************************************************************/
@@ -4523,32 +4059,18 @@
 
 static int stli_initpcibrd(int brdtype, struct pci_dev *devp)
 {
-	stlibrd_t	*brdp;
-
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_initpcibrd(brdtype=%d,busnr=%x,devnr=%x)\n",
-		brdtype, dev->bus->number, dev->devfn);
-#endif
+	stlibrd_t *brdp;
 
 	if (pci_enable_device(devp))
-		return(-EIO);
-	if ((brdp = stli_allocbrd()) == (stlibrd_t *) NULL)
-		return(-ENOMEM);
+		return -EIO;
+	if ((brdp = stli_allocbrd()) == NULL)
+		return -ENOMEM;
 	if ((brdp->brdnr = stli_getbrdnr()) < 0) {
 		printk(KERN_INFO "STALLION: too many boards found, "
 			"maximum supported %d\n", STL_MAXBRDS);
-		return(0);
+		return 0;
 	}
 	brdp->brdtype = brdtype;
-
-#ifdef DEBUG
-	printk(KERN_DEBUG "%s(%d): BAR[]=%lx,%lx,%lx,%lx\n", __FILE__, __LINE__,
-		pci_resource_start(devp, 0),
-		pci_resource_start(devp, 1),
-		pci_resource_start(devp, 2),
-		pci_resource_start(devp, 3));
-#endif
-
 /*
  *	We have all resources from the board, so lets setup the actual
  *	board structure now.
@@ -4557,7 +4079,7 @@
 	brdp->memaddr = pci_resource_start(devp, 2);
 	stli_brdinit(brdp);
 
-	return(0);
+	return 0;
 }
 
 /*****************************************************************************/
@@ -4569,20 +4091,12 @@
 
 static int stli_findpcibrds(void)
 {
-	struct pci_dev	*dev = NULL;
-	int		rc;
-
-#ifdef DEBUG
-	printk("stli_findpcibrds()\n");
-#endif
+	struct pci_dev *dev = NULL;
 
-	while ((dev = pci_find_device(PCI_VENDOR_ID_STALLION,
-	    PCI_DEVICE_ID_ECRA, dev))) {
-		if ((rc = stli_initpcibrd(BRD_ECPPCI, dev)))
-			return(rc);
+	while ((dev = pci_get_device(PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_ECRA, dev))) {
+		stli_initpcibrd(BRD_ECPPCI, dev);
 	}
-
-	return(0);
+	return 0;
 }
 
 #endif
@@ -4595,17 +4109,16 @@
 
 static stlibrd_t *stli_allocbrd(void)
 {
-	stlibrd_t	*brdp;
+	stlibrd_t *brdp;
 
 	brdp = kzalloc(sizeof(stlibrd_t), GFP_KERNEL);
 	if (!brdp) {
 		printk(KERN_ERR "STALLION: failed to allocate memory "
-				"(size=%d)\n", sizeof(stlibrd_t));
+				"(size=%Zd)\n", sizeof(stlibrd_t));
 		return NULL;
 	}
-
 	brdp->magic = STLI_BOARDMAGIC;
-	return(brdp);
+	return brdp;
 }
 
 /*****************************************************************************/
@@ -4617,13 +4130,9 @@
 
 static int stli_initbrds(void)
 {
-	stlibrd_t	*brdp, *nxtbrdp;
-	stlconf_t	*confp;
-	int		i, j;
-
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_initbrds()\n");
-#endif
+	stlibrd_t *brdp, *nxtbrdp;
+	stlconf_t *confp;
+	int i, j;
 
 	if (stli_nrbrds > STL_MAXBRDS) {
 		printk(KERN_INFO "STALLION: too many boards in configuration "
@@ -4638,11 +4147,9 @@
  */
 	for (i = 0; (i < stli_nrbrds); i++) {
 		confp = &stli_brdconf[i];
-#ifdef MODULE
 		stli_parsebrd(confp, stli_brdsp[i]);
-#endif
-		if ((brdp = stli_allocbrd()) == (stlibrd_t *) NULL)
-			return(-ENOMEM);
+		if ((brdp = stli_allocbrd()) == NULL)
+			return -ENOMEM;
 		brdp->brdnr = i;
 		brdp->brdtype = confp->brdtype;
 		brdp->iobase = confp->ioaddr1;
@@ -4654,9 +4161,7 @@
  *	Static configuration table done, so now use dynamic methods to
  *	see if any more boards should be configured.
  */
-#ifdef MODULE
 	stli_argbrds();
-#endif
 	if (STLI_EISAPROBE)
 		stli_findeisabrds();
 #ifdef CONFIG_PCI
@@ -4672,11 +4177,11 @@
 	if (stli_nrbrds > 1) {
 		for (i = 0; (i < stli_nrbrds); i++) {
 			brdp = stli_brds[i];
-			if (brdp == (stlibrd_t *) NULL)
+			if (brdp == NULL)
 				continue;
 			for (j = i + 1; (j < stli_nrbrds); j++) {
 				nxtbrdp = stli_brds[j];
-				if (nxtbrdp == (stlibrd_t *) NULL)
+				if (nxtbrdp == NULL)
 					continue;
 				if ((brdp->membase >= nxtbrdp->membase) &&
 				    (brdp->membase <= (nxtbrdp->membase +
@@ -4691,7 +4196,7 @@
 	if (stli_shared == 0) {
 		for (i = 0; (i < stli_nrbrds); i++) {
 			brdp = stli_brds[i];
-			if (brdp == (stlibrd_t *) NULL)
+			if (brdp == NULL)
 				continue;
 			if (brdp->state & BST_FOUND) {
 				EBRDENABLE(brdp);
@@ -4701,7 +4206,7 @@
 		}
 	}
 
-	return(0);
+	return 0;
 }
 
 /*****************************************************************************/
@@ -4714,48 +4219,55 @@
 
 static ssize_t stli_memread(struct file *fp, char __user *buf, size_t count, loff_t *offp)
 {
-	unsigned long	flags;
-	void		*memptr;
-	stlibrd_t	*brdp;
-	int		brdnr, size, n;
-
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_memread(fp=%x,buf=%x,count=%x,offp=%x)\n",
-			(int) fp, (int) buf, count, (int) offp);
-#endif
+	unsigned long flags;
+	void *memptr;
+	stlibrd_t *brdp;
+	int brdnr, size, n;
+	void *p;
+	loff_t off = *offp;
 
 	brdnr = iminor(fp->f_dentry->d_inode);
 	if (brdnr >= stli_nrbrds)
-		return(-ENODEV);
+		return -ENODEV;
 	brdp = stli_brds[brdnr];
-	if (brdp == (stlibrd_t *) NULL)
-		return(-ENODEV);
+	if (brdp == NULL)
+		return -ENODEV;
 	if (brdp->state == 0)
-		return(-ENODEV);
-	if (fp->f_pos >= brdp->memsize)
-		return(0);
+		return -ENODEV;
+	if (off >= brdp->memsize || off + count < off)
+		return 0;
 
-	size = MIN(count, (brdp->memsize - fp->f_pos));
+	size = MIN(count, (brdp->memsize - off));
+
+	/*
+	 *	Copy the data a page at a time
+	 */
+
+	p = (void *)__get_free_page(GFP_KERNEL);
+	if(p == NULL)
+		return -ENOMEM;
 
-	save_flags(flags);
-	cli();
-	EBRDENABLE(brdp);
 	while (size > 0) {
-		memptr = (void *) EBRDGETMEMPTR(brdp, fp->f_pos);
-		n = MIN(size, (brdp->pagesize - (((unsigned long) fp->f_pos) % brdp->pagesize)));
-		if (copy_to_user(buf, memptr, n)) {
+		spin_lock_irqsave(&brd_lock, flags);
+		EBRDENABLE(brdp);
+		memptr = (void *) EBRDGETMEMPTR(brdp, off);
+		n = MIN(size, (brdp->pagesize - (((unsigned long) off) % brdp->pagesize)));
+		n = MIN(n, PAGE_SIZE);
+		memcpy_fromio(p, memptr, n);
+		EBRDDISABLE(brdp);
+		spin_unlock_irqrestore(&brd_lock, flags);
+		if (copy_to_user(buf, p, n)) {
 			count = -EFAULT;
 			goto out;
 		}
-		fp->f_pos += n;
+		off += n;
 		buf += n;
 		size -= n;
 	}
 out:
-	EBRDDISABLE(brdp);
-	restore_flags(flags);
-
-	return(count);
+	*offp = off;
+	free_page((unsigned long)p);
+	return count;
 }
 
 /*****************************************************************************/
@@ -4764,54 +4276,65 @@
  *	Code to handle an "staliomem" write operation. This device is the 
  *	contents of the board shared memory. It is used for down loading
  *	the slave image (and debugging :-)
+ *
+ *	FIXME: copy under lock
  */
 
 static ssize_t stli_memwrite(struct file *fp, const char __user *buf, size_t count, loff_t *offp)
 {
-	unsigned long	flags;
-	void		*memptr;
-	stlibrd_t	*brdp;
-	char		__user *chbuf;
-	int		brdnr, size, n;
-
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_memwrite(fp=%x,buf=%x,count=%x,offp=%x)\n",
-			(int) fp, (int) buf, count, (int) offp);
-#endif
+	unsigned long flags;
+	void *memptr;
+	stlibrd_t *brdp;
+	char __user *chbuf;
+	int brdnr, size, n;
+	void *p;
+	loff_t off = *offp;
 
 	brdnr = iminor(fp->f_dentry->d_inode);
+	
 	if (brdnr >= stli_nrbrds)
-		return(-ENODEV);
+		return -ENODEV;
 	brdp = stli_brds[brdnr];
-	if (brdp == (stlibrd_t *) NULL)
-		return(-ENODEV);
+	if (brdp == NULL)
+		return -ENODEV;
 	if (brdp->state == 0)
-		return(-ENODEV);
-	if (fp->f_pos >= brdp->memsize)
-		return(0);
+		return -ENODEV;
+	if (off >= brdp->memsize || off + count < off)
+		return 0;
 
 	chbuf = (char __user *) buf;
-	size = MIN(count, (brdp->memsize - fp->f_pos));
+	size = MIN(count, (brdp->memsize - off));
+	
+	/*
+	 *	Copy the data a page at a time
+	 */
 
-	save_flags(flags);
-	cli();
-	EBRDENABLE(brdp);
+	p = (void *)__get_free_page(GFP_KERNEL);
+	if(p == NULL)
+		return -ENOMEM;
+		
 	while (size > 0) {
-		memptr = (void *) EBRDGETMEMPTR(brdp, fp->f_pos);
-		n = MIN(size, (brdp->pagesize - (((unsigned long) fp->f_pos) % brdp->pagesize)));
-		if (copy_from_user(memptr, chbuf, n)) {
-			count = -EFAULT;
+		n = MIN(size, (brdp->pagesize - (((unsigned long) off) % brdp->pagesize)));
+		n = MIN(n, PAGE_SIZE);
+		if (copy_from_user(p, chbuf, n)) {
+			if (count == 0)
+				count = -EFAULT;
 			goto out;
 		}
-		fp->f_pos += n;
+		spin_lock_irqsave(&brd_lock, flags);
+		EBRDENABLE(brdp);
+		memptr = (void *) EBRDGETMEMPTR(brdp, off);
+		memcpy_toio(memptr, p, n);
+		EBRDDISABLE(brdp);
+		spin_unlock_irqrestore(&brd_lock, flags);
+		off += n;
 		chbuf += n;
 		size -= n;
 	}
 out:
-	EBRDDISABLE(brdp);
-	restore_flags(flags);
-
-	return(count);
+	free_page((unsigned long) p);
+	*offp = off;
+	return count;
 }
 
 /*****************************************************************************/
@@ -4822,16 +4345,16 @@
 
 static int stli_getbrdstats(combrd_t __user *bp)
 {
-	stlibrd_t	*brdp;
-	int		i;
+	stlibrd_t *brdp;
+	int i;
 
 	if (copy_from_user(&stli_brdstats, bp, sizeof(combrd_t)))
 		return -EFAULT;
 	if (stli_brdstats.brd >= STL_MAXBRDS)
-		return(-ENODEV);
+		return -ENODEV;
 	brdp = stli_brds[stli_brdstats.brd];
-	if (brdp == (stlibrd_t *) NULL)
-		return(-ENODEV);
+	if (brdp == NULL)
+		return -ENODEV;
 
 	memset(&stli_brdstats, 0, sizeof(combrd_t));
 	stli_brdstats.brd = brdp->brdnr;
@@ -4850,7 +4373,7 @@
 
 	if (copy_to_user(bp, &stli_brdstats, sizeof(combrd_t)))
 		return -EFAULT;
-	return(0);
+	return 0;
 }
 
 /*****************************************************************************/
@@ -4861,19 +4384,19 @@
 
 static stliport_t *stli_getport(int brdnr, int panelnr, int portnr)
 {
-	stlibrd_t	*brdp;
-	int		i;
+	stlibrd_t *brdp;
+	int i;
 
-	if ((brdnr < 0) || (brdnr >= STL_MAXBRDS))
-		return((stliport_t *) NULL);
+	if (brdnr < 0 || brdnr >= STL_MAXBRDS)
+		return NULL;
 	brdp = stli_brds[brdnr];
-	if (brdp == (stlibrd_t *) NULL)
-		return((stliport_t *) NULL);
+	if (brdp == NULL)
+		return NULL;
 	for (i = 0; (i < panelnr); i++)
 		portnr += brdp->panels[i];
 	if ((portnr < 0) || (portnr >= brdp->nrports))
-		return((stliport_t *) NULL);
-	return(brdp->ports[portnr]);
+		return NULL;
+	return brdp->ports[portnr];
 }
 
 /*****************************************************************************/
@@ -4892,16 +4415,16 @@
 
 	memset(&stli_comstats, 0, sizeof(comstats_t));
 
-	if (portp == (stliport_t *) NULL)
-		return(-ENODEV);
+	if (portp == NULL)
+		return -ENODEV;
 	brdp = stli_brds[portp->brdnr];
-	if (brdp == (stlibrd_t *) NULL)
-		return(-ENODEV);
+	if (brdp == NULL)
+		return -ENODEV;
 
 	if (brdp->state & BST_STARTED) {
 		if ((rc = stli_cmdwait(brdp, portp, A_GETSTATS,
 		    &stli_cdkstats, sizeof(asystats_t), 1)) < 0)
-			return(rc);
+			return rc;
 	} else {
 		memset(&stli_cdkstats, 0, sizeof(asystats_t));
 	}
@@ -4912,13 +4435,12 @@
 	stli_comstats.state = portp->state;
 	stli_comstats.flags = portp->flags;
 
-	save_flags(flags);
-	cli();
-	if (portp->tty != (struct tty_struct *) NULL) {
+	spin_lock_irqsave(&brd_lock, flags);
+	if (portp->tty != NULL) {
 		if (portp->tty->driver_data == portp) {
 			stli_comstats.ttystate = portp->tty->flags;
-			stli_comstats.rxbuffered = -1 /*portp->tty->flip.count*/;
-			if (portp->tty->termios != (struct termios *) NULL) {
+			stli_comstats.rxbuffered = -1;
+			if (portp->tty->termios != NULL) {
 				stli_comstats.cflags = portp->tty->termios->c_cflag;
 				stli_comstats.iflags = portp->tty->termios->c_iflag;
 				stli_comstats.oflags = portp->tty->termios->c_oflag;
@@ -4926,7 +4448,7 @@
 			}
 		}
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&brd_lock, flags);
 
 	stli_comstats.txtotal = stli_cdkstats.txchars;
 	stli_comstats.rxtotal = stli_cdkstats.rxchars + stli_cdkstats.ringover;
@@ -4948,7 +4470,7 @@
 	stli_comstats.hwid = stli_cdkstats.hwid;
 	stli_comstats.signals = stli_mktiocm(stli_cdkstats.signals);
 
-	return(0);
+	return 0;
 }
 
 /*****************************************************************************/
@@ -4961,8 +4483,8 @@
 
 static int stli_getportstats(stliport_t *portp, comstats_t __user *cp)
 {
-	stlibrd_t	*brdp;
-	int		rc;
+	stlibrd_t *brdp;
+	int rc;
 
 	if (!portp) {
 		if (copy_from_user(&stli_comstats, cp, sizeof(comstats_t)))
@@ -4992,8 +4514,8 @@
 
 static int stli_clrportstats(stliport_t *portp, comstats_t __user *cp)
 {
-	stlibrd_t	*brdp;
-	int		rc;
+	stlibrd_t *brdp;
+	int rc;
 
 	if (!portp) {
 		if (copy_from_user(&stli_comstats, cp, sizeof(comstats_t)))
@@ -5031,7 +4553,7 @@
 
 static int stli_getportstruct(stliport_t __user *arg)
 {
-	stliport_t	*portp;
+	stliport_t *portp;
 
 	if (copy_from_user(&stli_dummyport, arg, sizeof(stliport_t)))
 		return -EFAULT;
@@ -5052,7 +4574,7 @@
 
 static int stli_getbrdstruct(stlibrd_t __user *arg)
 {
-	stlibrd_t	*brdp;
+	stlibrd_t *brdp;
 
 	if (copy_from_user(&stli_dummybrd, arg, sizeof(stlibrd_t)))
 		return -EFAULT;
@@ -5076,15 +4598,10 @@
 
 static int stli_memioctl(struct inode *ip, struct file *fp, unsigned int cmd, unsigned long arg)
 {
-	stlibrd_t	*brdp;
-	int		brdnr, rc, done;
+	stlibrd_t *brdp;
+	int brdnr, rc, done;
 	void __user *argp = (void __user *)arg;
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "stli_memioctl(ip=%x,fp=%x,cmd=%x,arg=%x)\n",
-			(int) ip, (int) fp, cmd, (int) arg);
-#endif
-
 /*
  *	First up handle the board independent ioctls.
  */
@@ -5115,7 +4632,7 @@
 	}
 
 	if (done)
-		return(rc);
+		return rc;
 
 /*
  *	Now handle the board specific ioctls. These all depend on the
@@ -5123,12 +4640,12 @@
  */
 	brdnr = iminor(ip);
 	if (brdnr >= STL_MAXBRDS)
-		return(-ENODEV);
+		return -ENODEV;
 	brdp = stli_brds[brdnr];
 	if (!brdp)
-		return(-ENODEV);
+		return -ENODEV;
 	if (brdp->state == 0)
-		return(-ENODEV);
+		return -ENODEV;
 
 	switch (cmd) {
 	case STL_BINTR:
@@ -5152,8 +4669,7 @@
 		rc = -ENOIOCTLCMD;
 		break;
 	}
-
-	return(rc);
+	return rc;
 }
 
 static struct tty_operations stli_ops = {
@@ -5187,6 +4703,9 @@
 	int i;
 	printk(KERN_INFO "%s: version %s\n", stli_drvtitle, stli_drvversion);
 
+	spin_lock_init(&stli_lock);
+	spin_lock_init(&brd_lock);
+	
 	stli_initbrds();
 
 	stli_serial = alloc_tty_driver(STL_MAXBRDS * STL_MAXPORTS);
@@ -5196,10 +4715,6 @@
 /*
  *	Allocate a temporary write buffer.
  */
-	stli_tmpwritebuf = kmalloc(STLI_TXBUFSIZE, GFP_KERNEL);
-	if (!stli_tmpwritebuf)
-		printk(KERN_ERR "STALLION: failed to allocate memory "
-				"(size=%d)\n", STLI_TXBUFSIZE);
 	stli_txcookbuf = kmalloc(STLI_TXBUFSIZE, GFP_KERNEL);
 	if (!stli_txcookbuf)
 		printk(KERN_ERR "STALLION: failed to allocate memory "
@@ -5243,7 +4758,7 @@
 		printk(KERN_ERR "STALLION: failed to register serial driver\n");
 		return -EBUSY;
 	}
-	return(0);
+	return 0;
 }
 
 /*****************************************************************************/

