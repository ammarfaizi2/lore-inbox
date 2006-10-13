Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751931AbWJMVJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbWJMVJW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 17:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbWJMVJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 17:09:22 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:64493 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1751931AbWJMVJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 17:09:19 -0400
Message-id: <20547230732101616405@wsc.cz>
Subject: [PATCH 7/7] Char: stallion, remove many prototypes
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Fri, 13 Oct 2006 23:09:30 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stallion, remove many prototypes

Many prototypes are useless, since functions are declared before they are
called. Also some code was easy to move to resolve this dependency and delete
prototypes.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit ed395025a185ff6da5a564a55d320ffd8162304c
tree c49af51573d95186f453d520a9cacc70e5dfcfa6
parent d98c2128256f2d3e12868353ae0b07e68f47428a
author Jiri Slaby <jirislaby@gmail.com> Fri, 13 Oct 2006 00:27:22 +0200
committer Jiri Slaby <jirislaby@gmail.com> Fri, 13 Oct 2006 00:27:22 +0200

 drivers/char/stallion.c |  222 +++++++++++++++++++----------------------------
 1 files changed, 91 insertions(+), 131 deletions(-)

diff --git a/drivers/char/stallion.c b/drivers/char/stallion.c
index 51f46c2..8b49927 100644
--- a/drivers/char/stallion.c
+++ b/drivers/char/stallion.c
@@ -450,51 +450,11 @@ #define	TOLOWER(x)	((((x) >= 'A') && ((x
  *	Declare all those functions in this driver!
  */
 
-static void	stl_argbrds(void);
-static int	stl_parsebrd(struct stlconf *confp, char **argp);
-
-static unsigned long stl_atol(char *str);
-
-static int	stl_open(struct tty_struct *tty, struct file *filp);
-static void	stl_close(struct tty_struct *tty, struct file *filp);
-static int	stl_write(struct tty_struct *tty, const unsigned char *buf, int count);
-static void	stl_putchar(struct tty_struct *tty, unsigned char ch);
-static void	stl_flushchars(struct tty_struct *tty);
-static int	stl_writeroom(struct tty_struct *tty);
-static int	stl_charsinbuffer(struct tty_struct *tty);
-static int	stl_ioctl(struct tty_struct *tty, struct file *file, unsigned int cmd, unsigned long arg);
-static void	stl_settermios(struct tty_struct *tty, struct termios *old);
-static void	stl_throttle(struct tty_struct *tty);
-static void	stl_unthrottle(struct tty_struct *tty);
-static void	stl_stop(struct tty_struct *tty);
-static void	stl_start(struct tty_struct *tty);
-static void	stl_flushbuffer(struct tty_struct *tty);
-static void	stl_breakctl(struct tty_struct *tty, int state);
-static void	stl_waituntilsent(struct tty_struct *tty, int timeout);
-static void	stl_sendxchar(struct tty_struct *tty, char ch);
-static void	stl_hangup(struct tty_struct *tty);
 static int	stl_memioctl(struct inode *ip, struct file *fp, unsigned int cmd, unsigned long arg);
-static int	stl_portinfo(struct stlport *portp, int portnr, char *pos);
-static int	stl_readproc(char *page, char **start, off_t off, int count, int *eof, void *data);
-
 static int	stl_brdinit(struct stlbrd *brdp);
-static int	stl_initports(struct stlbrd *brdp, struct stlpanel *panelp);
-static int	stl_getserial(struct stlport *portp, struct serial_struct __user *sp);
-static int	stl_setserial(struct stlport *portp, struct serial_struct __user *sp);
-static int	stl_getbrdstats(combrd_t __user *bp);
 static int	stl_getportstats(struct stlport *portp, comstats_t __user *cp);
 static int	stl_clrportstats(struct stlport *portp, comstats_t __user *cp);
-static int	stl_getportstruct(struct stlport __user *arg);
-static int	stl_getbrdstruct(struct stlbrd __user *arg);
 static int	stl_waitcarrier(struct stlport *portp, struct file *filp);
-static int	stl_eiointr(struct stlbrd *brdp);
-static int	stl_echatintr(struct stlbrd *brdp);
-static int	stl_echmcaintr(struct stlbrd *brdp);
-static int	stl_echpciintr(struct stlbrd *brdp);
-static int	stl_echpci64intr(struct stlbrd *brdp);
-static void	stl_offintr(void *private);
-static struct stlbrd *stl_allocbrd(void);
-static struct stlport *stl_getport(int brdnr, int panelnr, int portnr);
 
 /*
  *	CD1400 uart specific handling functions.
@@ -700,31 +660,6 @@ static struct class *stallion_class;
  *	Check for any arguments passed in on the module load command line.
  */
 
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
-		stl_brdinit(brdp);
-	}
-}
-
 /*****************************************************************************/
 
 /*
@@ -826,6 +761,31 @@ static struct stlbrd *stl_allocbrd(void)
 	return brdp;
 }
 
+static void __init stl_argbrds(void)
+{
+	struct stlconf	conf;
+	struct stlbrd	*brdp;
+	int		i;
+
+	pr_debug("stl_argbrds()\n");
+
+	for (i = stl_nrbrds; (i < stl_nargs); i++) {
+		memset(&conf, 0, sizeof(conf));
+		if (stl_parsebrd(&conf, stl_brdsp[i]) == 0)
+			continue;
+		if ((brdp = stl_allocbrd()) == NULL)
+			continue;
+		stl_nrbrds = i + 1;
+		brdp->brdnr = i;
+		brdp->brdtype = conf.brdtype;
+		brdp->ioaddr1 = conf.ioaddr1;
+		brdp->ioaddr2 = conf.ioaddr2;
+		brdp->irq = conf.irq;
+		brdp->irqtype = conf.irqtype;
+		stl_brdinit(brdp);
+	}
+}
+
 /*****************************************************************************/
 
 static int stl_open(struct tty_struct *tty, struct file *filp)
@@ -972,6 +932,52 @@ static int stl_waitcarrier(struct stlpor
 
 /*****************************************************************************/
 
+static void stl_flushbuffer(struct tty_struct *tty)
+{
+	struct stlport	*portp;
+
+	pr_debug("stl_flushbuffer(tty=%p)\n", tty);
+
+	if (tty == NULL)
+		return;
+	portp = tty->driver_data;
+	if (portp == NULL)
+		return;
+
+	stl_flush(portp);
+	tty_wakeup(tty);
+}
+
+/*****************************************************************************/
+
+static void stl_waituntilsent(struct tty_struct *tty, int timeout)
+{
+	struct stlport	*portp;
+	unsigned long	tend;
+
+	pr_debug("stl_waituntilsent(tty=%p,timeout=%d)\n", tty, timeout);
+
+	if (tty == NULL)
+		return;
+	portp = tty->driver_data;
+	if (portp == NULL)
+		return;
+
+	if (timeout == 0)
+		timeout = HZ;
+	tend = jiffies + timeout;
+
+	while (stl_datastate(portp)) {
+		if (signal_pending(current))
+			break;
+		msleep_interruptible(20);
+		if (time_after_eq(jiffies, tend))
+			break;
+	}
+}
+
+/*****************************************************************************/
+
 static void stl_close(struct tty_struct *tty, struct file *filp)
 {
 	struct stlport	*portp;
@@ -1401,6 +1407,26 @@ static int stl_ioctl(struct tty_struct *
 
 /*****************************************************************************/
 
+/*
+ *	Start the transmitter again. Just turn TX interrupts back on.
+ */
+
+static void stl_start(struct tty_struct *tty)
+{
+	struct stlport	*portp;
+
+	pr_debug("stl_start(tty=%p)\n", tty);
+
+	if (tty == NULL)
+		return;
+	portp = tty->driver_data;
+	if (portp == NULL)
+		return;
+	stl_startrxtx(portp, -1, 1);
+}
+
+/*****************************************************************************/
+
 static void stl_settermios(struct tty_struct *tty, struct termios *old)
 {
 	struct stlport	*portp;
@@ -1495,26 +1521,6 @@ static void stl_stop(struct tty_struct *
 /*****************************************************************************/
 
 /*
- *	Start the transmitter again. Just turn TX interrupts back on.
- */
-
-static void stl_start(struct tty_struct *tty)
-{
-	struct stlport	*portp;
-
-	pr_debug("stl_start(tty=%p)\n", tty);
-
-	if (tty == NULL)
-		return;
-	portp = tty->driver_data;
-	if (portp == NULL)
-		return;
-	stl_startrxtx(portp, -1, 1);
-}
-
-/*****************************************************************************/
-
-/*
  *	Hangup this port. This is pretty much like closing the port, only
  *	a little more brutal. No waiting for data to drain. Shutdown the
  *	port and maybe drop signals.
@@ -1554,24 +1560,6 @@ static void stl_hangup(struct tty_struct
 
 /*****************************************************************************/
 
-static void stl_flushbuffer(struct tty_struct *tty)
-{
-	struct stlport	*portp;
-
-	pr_debug("stl_flushbuffer(tty=%p)\n", tty);
-
-	if (tty == NULL)
-		return;
-	portp = tty->driver_data;
-	if (portp == NULL)
-		return;
-
-	stl_flush(portp);
-	tty_wakeup(tty);
-}
-
-/*****************************************************************************/
-
 static void stl_breakctl(struct tty_struct *tty, int state)
 {
 	struct stlport	*portp;
@@ -1589,34 +1577,6 @@ static void stl_breakctl(struct tty_stru
 
 /*****************************************************************************/
 
-static void stl_waituntilsent(struct tty_struct *tty, int timeout)
-{
-	struct stlport	*portp;
-	unsigned long	tend;
-
-	pr_debug("stl_waituntilsent(tty=%p,timeout=%d)\n", tty, timeout);
-
-	if (tty == NULL)
-		return;
-	portp = tty->driver_data;
-	if (portp == NULL)
-		return;
-
-	if (timeout == 0)
-		timeout = HZ;
-	tend = jiffies + timeout;
-
-	while (stl_datastate(portp)) {
-		if (signal_pending(current))
-			break;
-		msleep_interruptible(20);
-		if (time_after_eq(jiffies, tend))
-			break;
-	}
-}
-
-/*****************************************************************************/
-
 static void stl_sendxchar(struct tty_struct *tty, char ch)
 {
 	struct stlport	*portp;
