Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965667AbWKDU25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965667AbWKDU25 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 15:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965669AbWKDU24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 15:28:56 -0500
Received: from cacti2.profiwh.com ([85.93.165.64]:52160 "EHLO
	cacti.profiwh.com") by vger.kernel.org with ESMTP id S965665AbWKDU2r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 15:28:47 -0500
Message-id: <24860128021257012263@wsc.cz>
Subject: [PATCH 4/8] Char: istallion, variables cleanup
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sat,  4 Nov 2006 21:28:57 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

istallion, variables cleanup

- wipe gcc -W warnings by int -> uint conversion
- move 2 global variables into their local place

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 5d593cca61510bc31b01025fa5f9070e143be2aa
tree da3ae4e443e2056dd03a0503e542aaebc93b5d7d
parent f138b6b285ea78dab9e9dbbc968b834d661727db
author Jiri Slaby <jirislaby@gmail.com> Sat, 04 Nov 2006 20:28:47 +0059
committer Jiri Slaby <jirislaby@gmail.com> Sat, 04 Nov 2006 20:28:47 +0059

 drivers/char/istallion.c  |  100 +++++++++++++++++++++++++--------------------
 include/linux/istallion.h |   24 +++++------
 2 files changed, 67 insertions(+), 57 deletions(-)

diff --git a/drivers/char/istallion.c b/drivers/char/istallion.c
index 24fae16..730db7f 100644
--- a/drivers/char/istallion.c
+++ b/drivers/char/istallion.c
@@ -110,7 +110,7 @@ struct stlconf {
 	int		irqtype;
 };
 
-static int	stli_nrbrds;
+static unsigned int stli_nrbrds;
 
 /* stli_lock must NOT be taken holding brd_lock */
 static spinlock_t stli_lock;	/* TTY logic lock */
@@ -186,8 +186,6 @@ static struct ktermios		stli_deftermios 
 static comstats_t	stli_comstats;
 static combrd_t		stli_brdstats;
 static struct asystats	stli_cdkstats;
-static struct stlibrd	stli_dummybrd;
-static struct stliport	stli_dummyport;
 
 /*****************************************************************************/
 
@@ -682,7 +680,7 @@ static void	stli_stalinit(struct stlibrd
 static void __iomem *stli_stalgetmemptr(struct stlibrd *brdp, unsigned long offset, int line);
 static void	stli_stalreset(struct stlibrd *brdp);
 
-static struct stliport *stli_getport(int brdnr, int panelnr, int portnr);
+static struct stliport *stli_getport(unsigned int brdnr, unsigned int panelnr, unsigned int portnr);
 
 static int	stli_initecp(struct stlibrd *brdp);
 static int	stli_initonb(struct stlibrd *brdp);
@@ -755,6 +753,7 @@ static int __init istallion_module_init(
 static void __exit istallion_module_exit(void)
 {
 	struct stlibrd	*brdp;
+	unsigned int j;
 	int		i;
 
 	printk(KERN_INFO "Unloading %s: version %s\n", stli_drvtitle,
@@ -777,8 +776,8 @@ static void __exit istallion_module_exit
 		return;
 	}
 	put_tty_driver(stli_serial);
-	for (i = 0; i < 4; i++)
-		class_device_destroy(istallion_class, MKDEV(STL_SIOMEMMAJOR, i));
+	for (j = 0; j < 4; j++)
+		class_device_destroy(istallion_class, MKDEV(STL_SIOMEMMAJOR, j));
 	class_destroy(istallion_class);
 	if ((i = unregister_chrdev(STL_SIOMEMMAJOR, "staliomem")))
 		printk("STALLION: failed to un-register serial memory device, "
@@ -786,8 +785,8 @@ static void __exit istallion_module_exit
 
 	kfree(stli_txcookbuf);
 
-	for (i = 0; (i < stli_nrbrds); i++) {
-		if ((brdp = stli_brds[i]) == NULL)
+	for (j = 0; (j < stli_nrbrds); j++) {
+		if ((brdp = stli_brds[j]) == NULL)
 			continue;
 
 		stli_cleanup_ports(brdp);
@@ -796,7 +795,7 @@ static void __exit istallion_module_exit
 		if (brdp->iosize > 0)
 			release_region(brdp->iobase, brdp->iosize);
 		kfree(brdp);
-		stli_brds[i] = NULL;
+		stli_brds[j] = NULL;
 	}
 }
 
@@ -811,8 +810,8 @@ module_exit(istallion_module_exit);
 
 static int stli_parsebrd(struct stlconf *confp, char **argp)
 {
+	unsigned int i;
 	char *sp;
-	int i;
 
 	if (argp[0] == NULL || *argp[0] == 0)
 		return 0;
@@ -843,8 +842,8 @@ static int stli_open(struct tty_struct *
 {
 	struct stlibrd *brdp;
 	struct stliport *portp;
-	unsigned int minordev;
-	int brdnr, portnr, rc;
+	unsigned int minordev, brdnr, portnr;
+	int rc;
 
 	minordev = tty->index;
 	brdnr = MINOR2BRD(minordev);
@@ -856,7 +855,7 @@ static int stli_open(struct tty_struct *
 	if ((brdp->state & BST_STARTED) == 0)
 		return -ENODEV;
 	portnr = MINOR2PORT(minordev);
-	if ((portnr < 0) || (portnr > brdp->nrports))
+	if (portnr > brdp->nrports)
 		return -ENODEV;
 
 	portp = brdp->ports[portnr];
@@ -1232,7 +1231,7 @@ static int stli_setport(struct stliport 
 		return -ENODEV;
 	if (portp->tty == NULL)
 		return -ENODEV;
-	if (portp->brdnr < 0 && portp->brdnr >= stli_nrbrds)
+	if (portp->brdnr >= stli_nrbrds)
 		return -ENODEV;
 	brdp = stli_brds[portp->brdnr];
 	if (brdp == NULL)
@@ -1324,7 +1323,7 @@ static int stli_write(struct tty_struct 
 	portp = tty->driver_data;
 	if (portp == NULL)
 		return 0;
-	if ((portp->brdnr < 0) || (portp->brdnr >= stli_nrbrds))
+	if (portp->brdnr >= stli_nrbrds)
 		return 0;
 	brdp = stli_brds[portp->brdnr];
 	if (brdp == NULL)
@@ -1446,7 +1445,7 @@ static void stli_flushchars(struct tty_s
 	portp = tty->driver_data;
 	if (portp == NULL)
 		return;
-	if ((portp->brdnr < 0) || (portp->brdnr >= stli_nrbrds))
+	if (portp->brdnr >= stli_nrbrds)
 		return;
 	brdp = stli_brds[portp->brdnr];
 	if (brdp == NULL)
@@ -1524,7 +1523,7 @@ static int stli_writeroom(struct tty_str
 	portp = tty->driver_data;
 	if (portp == NULL)
 		return 0;
-	if ((portp->brdnr < 0) || (portp->brdnr >= stli_nrbrds))
+	if (portp->brdnr >= stli_nrbrds)
 		return 0;
 	brdp = stli_brds[portp->brdnr];
 	if (brdp == NULL)
@@ -1572,7 +1571,7 @@ static int stli_charsinbuffer(struct tty
 	portp = tty->driver_data;
 	if (portp == NULL)
 		return 0;
-	if ((portp->brdnr < 0) || (portp->brdnr >= stli_nrbrds))
+	if (portp->brdnr >= stli_nrbrds)
 		return 0;
 	brdp = stli_brds[portp->brdnr];
 	if (brdp == NULL)
@@ -1670,7 +1669,7 @@ static int stli_tiocmget(struct tty_stru
 
 	if (portp == NULL)
 		return -ENODEV;
-	if (portp->brdnr < 0 || portp->brdnr >= stli_nrbrds)
+	if (portp->brdnr >= stli_nrbrds)
 		return 0;
 	brdp = stli_brds[portp->brdnr];
 	if (brdp == NULL)
@@ -1694,7 +1693,7 @@ static int stli_tiocmset(struct tty_stru
 
 	if (portp == NULL)
 		return -ENODEV;
-	if (portp->brdnr < 0 || portp->brdnr >= stli_nrbrds)
+	if (portp->brdnr >= stli_nrbrds)
 		return 0;
 	brdp = stli_brds[portp->brdnr];
 	if (brdp == NULL)
@@ -1728,7 +1727,7 @@ static int stli_ioctl(struct tty_struct 
 	portp = tty->driver_data;
 	if (portp == NULL)
 		return -ENODEV;
-	if (portp->brdnr < 0 || portp->brdnr >= stli_nrbrds)
+	if (portp->brdnr >= stli_nrbrds)
 		return 0;
 	brdp = stli_brds[portp->brdnr];
 	if (brdp == NULL)
@@ -1806,7 +1805,7 @@ static void stli_settermios(struct tty_s
 	portp = tty->driver_data;
 	if (portp == NULL)
 		return;
-	if (portp->brdnr < 0 || portp->brdnr >= stli_nrbrds)
+	if (portp->brdnr >= stli_nrbrds)
 		return;
 	brdp = stli_brds[portp->brdnr];
 	if (brdp == NULL)
@@ -1921,7 +1920,7 @@ static void stli_hangup(struct tty_struc
 	portp = tty->driver_data;
 	if (portp == NULL)
 		return;
-	if (portp->brdnr < 0 || portp->brdnr >= stli_nrbrds)
+	if (portp->brdnr >= stli_nrbrds)
 		return;
 	brdp = stli_brds[portp->brdnr];
 	if (brdp == NULL)
@@ -1974,7 +1973,7 @@ static void stli_flushbuffer(struct tty_
 	portp = tty->driver_data;
 	if (portp == NULL)
 		return;
-	if (portp->brdnr < 0 || portp->brdnr >= stli_nrbrds)
+	if (portp->brdnr >= stli_nrbrds)
 		return;
 	brdp = stli_brds[portp->brdnr];
 	if (brdp == NULL)
@@ -2011,7 +2010,7 @@ static void stli_breakctl(struct tty_str
 	portp = tty->driver_data;
 	if (portp == NULL)
 		return;
-	if (portp->brdnr < 0 || portp->brdnr >= stli_nrbrds)
+	if (portp->brdnr >= stli_nrbrds)
 		return;
 	brdp = stli_brds[portp->brdnr];
 	if (brdp == NULL)
@@ -2058,7 +2057,7 @@ static void stli_sendxchar(struct tty_st
 	portp = tty->driver_data;
 	if (portp == NULL)
 		return;
-	if (portp->brdnr < 0 || portp->brdnr >= stli_nrbrds)
+	if (portp->brdnr >= stli_nrbrds)
 		return;
 	brdp = stli_brds[portp->brdnr];
 	if (brdp == NULL)
@@ -2151,7 +2150,7 @@ static int stli_readproc(char *page, cha
 {
 	struct stlibrd *brdp;
 	struct stliport *portp;
-	int brdnr, portnr, totalport;
+	unsigned int brdnr, portnr, totalport;
 	int curoff, maxoff;
 	char *pos;
 
@@ -2603,7 +2602,7 @@ static void stli_poll(unsigned long arg)
 {
 	cdkhdr_t __iomem *hdrp;
 	struct stlibrd *brdp;
-	int brdnr;
+	unsigned int brdnr;
 
 	stli_timerlist.expires = STLI_TIMEOUT;
 	add_timer(&stli_timerlist);
@@ -2787,7 +2786,7 @@ static long stli_mktiocm(unsigned long s
 static int stli_initports(struct stlibrd *brdp)
 {
 	struct stliport	*portp;
-	int		i, panelnr, panelport;
+	unsigned int i, panelnr, panelport;
 
 	for (i = 0, panelnr = 0, panelport = 0; (i < brdp->nrports); i++) {
 		portp = kzalloc(sizeof(struct stliport), GFP_KERNEL);
@@ -3570,8 +3569,9 @@ static int stli_startbrd(struct stlibrd 
 	cdkmem_t __iomem *memp;
 	cdkasy_t __iomem *ap;
 	unsigned long flags;
+	unsigned int portnr, nrdevs, i;
 	struct stliport *portp;
-	int portnr, nrdevs, i, rc = 0;
+	int rc = 0;
 	u32 memoff;
 
 	spin_lock_irqsave(&brd_lock, flags);
@@ -3807,7 +3807,7 @@ static int stli_eisamemprobe(struct stli
 
 static int stli_getbrdnr(void)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < STL_MAXBRDS; i++) {
 		if (!stli_brds[i]) {
@@ -3834,8 +3834,8 @@ static int stli_getbrdnr(void)
 static int stli_findeisabrds(void)
 {
 	struct stlibrd *brdp;
-	unsigned int iobase, eid;
-	int i;
+	unsigned int iobase, eid, i;
+	int brdnr;
 
 /*
  *	Firstly check if this is an EISA system.  If this is not an EISA system then
@@ -3874,8 +3874,10 @@ static int stli_findeisabrds(void)
  */
 		if ((brdp = stli_allocbrd()) == NULL)
 			return -ENOMEM;
-		if ((brdp->brdnr = stli_getbrdnr()) < 0)
+		brdnr = stli_getbrdnr();
+		if (brdnr < 0)
 			return -ENOMEM;
+		brdp->brdnr = (unsigned int)brdnr;
 		eid = inb(iobase + 0xc82);
 		if (eid == ECP_EISAID)
 			brdp->brdtype = BRD_ECPE;
@@ -3911,7 +3913,7 @@ static int __devinit stli_pciprobe(struc
 		const struct pci_device_id *ent)
 {
 	struct stlibrd *brdp;
-	int retval = -EIO;
+	int brdnr, retval = -EIO;
 
 	retval = pci_enable_device(pdev);
 	if (retval)
@@ -3921,12 +3923,14 @@ static int __devinit stli_pciprobe(struc
 		retval = -ENOMEM;
 		goto err;
 	}
-	if ((brdp->brdnr = stli_getbrdnr()) < 0) { /* TODO: locking */
+	brdnr = stli_getbrdnr();
+	if (brdnr < 0) { /* TODO: locking */
 		printk(KERN_INFO "STALLION: too many boards found, "
 			"maximum supported %d\n", STL_MAXBRDS);
 		retval = -EIO;
 		goto err_fr;
 	}
+	brdp->brdnr = (unsigned int)brdnr;
 	brdp->brdtype = BRD_ECPPCI;
 /*
  *	We have all resources from the board, so lets setup the actual
@@ -3998,7 +4002,8 @@ static int stli_initbrds(void)
 {
 	struct stlibrd *brdp, *nxtbrdp;
 	struct stlconf conf;
-	int i, j, retval;
+	unsigned int i, j;
+	int retval;
 
 	for (stli_nrbrds = 0; stli_nrbrds < ARRAY_SIZE(stli_brdsp);
 			stli_nrbrds++) {
@@ -4074,7 +4079,8 @@ static ssize_t stli_memread(struct file 
 	unsigned long flags;
 	void __iomem *memptr;
 	struct stlibrd *brdp;
-	int brdnr, size, n;
+	unsigned int brdnr;
+	int size, n;
 	void *p;
 	loff_t off = *offp;
 
@@ -4138,7 +4144,8 @@ static ssize_t stli_memwrite(struct file
 	void __iomem *memptr;
 	struct stlibrd *brdp;
 	char __user *chbuf;
-	int brdnr, size, n;
+	unsigned int brdnr;
+	int size, n;
 	void *p;
 	loff_t off = *offp;
 
@@ -4198,7 +4205,7 @@ out:
 static int stli_getbrdstats(combrd_t __user *bp)
 {
 	struct stlibrd *brdp;
-	int i;
+	unsigned int i;
 
 	if (copy_from_user(&stli_brdstats, bp, sizeof(combrd_t)))
 		return -EFAULT;
@@ -4234,19 +4241,20 @@ static int stli_getbrdstats(combrd_t __u
  *	Resolve the referenced port number into a port struct pointer.
  */
 
-static struct stliport *stli_getport(int brdnr, int panelnr, int portnr)
+static struct stliport *stli_getport(unsigned int brdnr, unsigned int panelnr,
+		unsigned int portnr)
 {
 	struct stlibrd *brdp;
-	int i;
+	unsigned int i;
 
-	if (brdnr < 0 || brdnr >= STL_MAXBRDS)
+	if (brdnr >= STL_MAXBRDS)
 		return NULL;
 	brdp = stli_brds[brdnr];
 	if (brdp == NULL)
 		return NULL;
 	for (i = 0; (i < panelnr); i++)
 		portnr += brdp->panels[i];
-	if ((portnr < 0) || (portnr >= brdp->nrports))
+	if (portnr >= brdp->nrports)
 		return NULL;
 	return brdp->ports[portnr];
 }
@@ -4405,6 +4413,7 @@ static int stli_clrportstats(struct stli
 
 static int stli_getportstruct(struct stliport __user *arg)
 {
+	struct stliport stli_dummyport;
 	struct stliport *portp;
 
 	if (copy_from_user(&stli_dummyport, arg, sizeof(struct stliport)))
@@ -4426,11 +4435,12 @@ static int stli_getportstruct(struct stl
 
 static int stli_getbrdstruct(struct stlibrd __user *arg)
 {
+	struct stlibrd stli_dummybrd;
 	struct stlibrd *brdp;
 
 	if (copy_from_user(&stli_dummybrd, arg, sizeof(struct stlibrd)))
 		return -EFAULT;
-	if ((stli_dummybrd.brdnr < 0) || (stli_dummybrd.brdnr >= STL_MAXBRDS))
+	if (stli_dummybrd.brdnr >= STL_MAXBRDS)
 		return -ENODEV;
 	brdp = stli_brds[stli_dummybrd.brdnr];
 	if (!brdp)
diff --git a/include/linux/istallion.h b/include/linux/istallion.h
index af2c32d..106a5e8 100644
--- a/include/linux/istallion.h
+++ b/include/linux/istallion.h
@@ -51,11 +51,11 @@ #define	STL_MAXDEVS		(STL_MAXBRDS * STL_
  */
 struct stliport {
 	unsigned long		magic;
-	int			portnr;
-	int			panelnr;
-	int			brdnr;
+	unsigned int		portnr;
+	unsigned int		panelnr;
+	unsigned int		brdnr;
 	unsigned long		state;
-	int			devnr;
+	unsigned int		devnr;
 	int			flags;
 	int			baud_base;
 	int			custom_divisor;
@@ -91,23 +91,23 @@ struct stliport {
  */
 struct stlibrd {
 	unsigned long	magic;
-	int		brdnr;
-	int		brdtype;
-	int		state;
-	int		nrpanels;
-	int		nrports;
-	int		nrdevs;
+	unsigned int	brdnr;
+	unsigned int	brdtype;
+	unsigned int	state;
+	unsigned int	nrpanels;
+	unsigned int	nrports;
+	unsigned int	nrdevs;
 	unsigned int	iobase;
 	int		iosize;
 	unsigned long	memaddr;
 	void		__iomem *membase;
-	int		memsize;
+	unsigned long	memsize;
 	int		pagesize;
 	int		hostoffset;
 	int		slaveoffset;
 	int		bitsize;
 	int		enabval;
-	int		panels[STL_MAXPANELS];
+	unsigned int	panels[STL_MAXPANELS];
 	int		panelids[STL_MAXPANELS];
 	void		(*init)(struct stlibrd *brdp);
 	void		(*enable)(struct stlibrd *brdp);
