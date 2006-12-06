Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937038AbWLFSlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937038AbWLFSlt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 13:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937086AbWLFSlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 13:41:49 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37308 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937038AbWLFSls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 13:41:48 -0500
Date: Wed, 6 Dec 2006 18:41:45 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: work_struct-induced breakage, part 1 of fsck-knows-how-many
Message-ID: <20061206184145.GC4587@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

diff --git a/drivers/char/istallion.c b/drivers/char/istallion.c
index ffdf9df..bd9195e 100644
--- a/drivers/char/istallion.c
+++ b/drivers/char/istallion.c
@@ -663,7 +663,7 @@ static int	stli_initopen(stlibrd_t *brdp
 static int	stli_rawopen(stlibrd_t *brdp, stliport_t *portp, unsigned long arg, int wait);
 static int	stli_rawclose(stlibrd_t *brdp, stliport_t *portp, unsigned long arg, int wait);
 static int	stli_waitcarrier(stlibrd_t *brdp, stliport_t *portp, struct file *filp);
-static void	stli_dohangup(void *arg);
+static void	stli_dohangup(struct work_struct *);
 static int	stli_setport(stliport_t *portp);
 static int	stli_cmdwait(stlibrd_t *brdp, stliport_t *portp, unsigned long cmd, void *arg, int size, int copyback);
 static void	stli_sendcmd(stlibrd_t *brdp, stliport_t *portp, unsigned long cmd, void *arg, int size, int copyback);
@@ -1990,9 +1990,9 @@ static void stli_start(struct tty_struct
  *	aren't that time critical).
  */
 
-static void stli_dohangup(void *arg)
+static void stli_dohangup(struct work_struct *ugly_api)
 {
-	stliport_t *portp = (stliport_t *) arg;
+	stliport_t *portp = container_of(ugly_api, stliport_t, tqhangup);
 	if (portp->tty != NULL) {
 		tty_hangup(portp->tty);
 	}
@@ -2898,7 +2898,7 @@ static int stli_initports(stlibrd_t *brd
 		portp->baud_base = STL_BAUDBASE;
 		portp->close_delay = STL_CLOSEDELAY;
 		portp->closing_wait = 30 * HZ;
-		INIT_WORK(&portp->tqhangup, stli_dohangup, portp);
+		INIT_WORK(&portp->tqhangup, stli_dohangup);
 		init_waitqueue_head(&portp->open_wait);
 		init_waitqueue_head(&portp->close_wait);
 		init_waitqueue_head(&portp->raw_wait);
diff --git a/drivers/char/riscom8.c b/drivers/char/riscom8.c
index 5ab32b3..722dd3e 100644
--- a/drivers/char/riscom8.c
+++ b/drivers/char/riscom8.c
@@ -1516,9 +1516,9 @@ static void rc_start(struct tty_struct *
  * 	do_rc_hangup() -> tty->hangup() -> rc_hangup()
  * 
  */
-static void do_rc_hangup(void *private_)
+static void do_rc_hangup(struct work_struct *ugly_api)
 {
-	struct riscom_port	*port = (struct riscom_port *) private_;
+	struct riscom_port	*port = container_of(ugly_api, struct riscom_port, tqueue_hangup);
 	struct tty_struct	*tty;
 	
 	tty = port->tty;
@@ -1567,9 +1567,9 @@ static void rc_set_termios(struct tty_st
 	}
 }
 
-static void do_softint(void *private_)
+static void do_softint(struct work_struct *ugly_api)
 {
-	struct riscom_port	*port = (struct riscom_port *) private_;
+	struct riscom_port	*port = container_of(ugly_api, struct riscom_port, tqueue);
 	struct tty_struct	*tty;
 	
 	if(!(tty = port->tty)) 
@@ -1632,8 +1632,8 @@ static inline int rc_init_drivers(void)
 	memset(rc_port, 0, sizeof(rc_port));
 	for (i = 0; i < RC_NPORT * RC_NBOARD; i++)  {
 		rc_port[i].magic = RISCOM8_MAGIC;
-		INIT_WORK(&rc_port[i].tqueue, do_softint, &rc_port[i]);
-		INIT_WORK(&rc_port[i].tqueue_hangup, do_rc_hangup, &rc_port[i]);
+		INIT_WORK(&rc_port[i].tqueue, do_softint);
+		INIT_WORK(&rc_port[i].tqueue_hangup, do_rc_hangup);
 		rc_port[i].close_delay = 50 * HZ/100;
 		rc_port[i].closing_wait = 3000 * HZ/100;
 		init_waitqueue_head(&rc_port[i].open_wait);
diff --git a/drivers/char/serial167.c b/drivers/char/serial167.c
index 3af7f09..9ba13af 100644
--- a/drivers/char/serial167.c
+++ b/drivers/char/serial167.c
@@ -706,9 +706,9 @@ #endif
  * had to poll every port to see if that port needed servicing.
  */
 static void
-do_softint(void *private_)
+do_softint(struct work_struct *ugly_api)
 {
-  struct cyclades_port *info = (struct cyclades_port *) private_;
+  struct cyclades_port *info = container_of(ugly_api, struct cyclades_port, tqueue);
   struct tty_struct    *tty;
 
     tty = info->tty;
@@ -2273,7 +2273,7 @@ #endif
 		info->blocked_open = 0;
 		info->default_threshold = 0;
 		info->default_timeout = 0;
-		INIT_WORK(&info->tqueue, do_softint, info);
+		INIT_WORK(&info->tqueue, do_softint);
 		init_waitqueue_head(&info->open_wait);
 		init_waitqueue_head(&info->close_wait);
 		/* info->session */
diff --git a/drivers/char/stallion.c b/drivers/char/stallion.c
index 522e88e..5e2de62 100644
--- a/drivers/char/stallion.c
+++ b/drivers/char/stallion.c
@@ -500,7 +500,7 @@ static int	stl_echatintr(stlbrd_t *brdp)
 static int	stl_echmcaintr(stlbrd_t *brdp);
 static int	stl_echpciintr(stlbrd_t *brdp);
 static int	stl_echpci64intr(stlbrd_t *brdp);
-static void	stl_offintr(void *private);
+static void	stl_offintr(struct work_struct *);
 static stlbrd_t *stl_allocbrd(void);
 static stlport_t *stl_getport(int brdnr, int panelnr, int portnr);
 
@@ -2081,14 +2081,12 @@ static int stl_echpci64intr(stlbrd_t *br
 /*
  *	Service an off-level request for some channel.
  */
-static void stl_offintr(void *private)
+static void stl_offintr(struct work_struct *work)
 {
-	stlport_t		*portp;
+	stlport_t		*portp = container_of(work, stlport_t, tqueue);
 	struct tty_struct	*tty;
 	unsigned int		oldsigs;
 
-	portp = private;
-
 #ifdef DEBUG
 	printk("stl_offintr(portp=%x)\n", (int) portp);
 #endif
@@ -2156,7 +2154,7 @@ #endif
 		portp->baud_base = STL_BAUDBASE;
 		portp->close_delay = STL_CLOSEDELAY;
 		portp->closing_wait = 30 * HZ;
-		INIT_WORK(&portp->tqueue, stl_offintr, portp);
+		INIT_WORK(&portp->tqueue, stl_offintr);
 		init_waitqueue_head(&portp->open_wait);
 		init_waitqueue_head(&portp->close_wait);
 		portp->stats.brd = portp->brdnr;
diff --git a/drivers/isdn/hysdn/boardergo.c b/drivers/isdn/hysdn/boardergo.c
index 82e42a8..a120649 100644
--- a/drivers/isdn/hysdn/boardergo.c
+++ b/drivers/isdn/hysdn/boardergo.c
@@ -71,8 +71,9 @@ ergo_interrupt(int intno, void *dev_id)
 /* may be queued from everywhere (interrupts included).                       */
 /******************************************************************************/
 static void
-ergo_irq_bh(hysdn_card * card)
+ergo_irq_bh(struct work_struct *ugli_api)
 {
+	hysdn_card * card = container_of(ugli_api, hysdn_card, irq_queue);
 	tErgDpram *dpr;
 	int again;
 	unsigned long flags;
@@ -442,7 +443,7 @@ ergo_inithardware(hysdn_card * card)
 	card->writebootseq = ergo_writebootseq;
 	card->waitpofready = ergo_waitpofready;
 	card->set_errlog_state = ergo_set_errlog_state;
-	INIT_WORK(&card->irq_queue, (void *) (void *) ergo_irq_bh, card);
+	INIT_WORK(&card->irq_queue, ergo_irq_bh);
 	card->hysdn_lock = SPIN_LOCK_UNLOCKED;
 
 	return (0);
diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
index be0bd34..d43ea81 100644
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -267,12 +267,12 @@ adb_probe_task(void *x)
 }
 
 static void
-__adb_probe_task(void *data)
+__adb_probe_task(struct work_struct *bullshit)
 {
 	adb_probe_task_pid = kernel_thread(adb_probe_task, NULL, SIGCHLD | CLONE_KERNEL);
 }
 
-static DECLARE_WORK(adb_reset_work, __adb_probe_task, NULL);
+static DECLARE_WORK(adb_reset_work, __adb_probe_task);
 
 int
 adb_reset_bus(void)
