Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbULUC0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbULUC0P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 21:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbULUC0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 21:26:15 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:22931 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261208AbULUCZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 21:25:51 -0500
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: LKML <linux-kernel@vger.kernel.org>
Date: Tue, 21 Dec 2004 13:25:48 +1100
Subject: [PATCH] 2.6.10-rc3 allow stallion serial driver to be built-in + module clean up
Message-ID: <20041221022548.GC25474@cse.unsw.EDU.AU>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

:The patches attached allow the stallion multi-port serial card
to be compiled as a module or built-in. I have also updated the
driver to use the newer modules interface.

This driver is still NOT smp safe using cli() and save|restore_flags().
There is a bit more work to update these to spin-locks due to numerous
printk's spread throughout the code.

Tested on: x86 and ia64, as module and built-in. Run only on x86.

Darren

--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------

--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="stl-built-in-final-UP.patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/08 13:37:06+11:00 dsw@vanilla.gelato 
#   Allow stallion console driver to be built-in, and register irqs correctly with dev_id != NULL
# 
#   Signed-off Darren Williams <dswATgelato.unsw.edu.au>
# drivers/char/stallion.c
#   2004/12/08 13:36:57+11:00 dsw@vanilla.gelato +12 -15
#   Pass non NULL dev_id to request_irq to allow correct irq registration. We use the board pointer as the dev_id
#   to allow unique identification across shared interupts.
#   
#   Remove remaining #ifdef MODULES to allow for built-in support.
#
# Signed-off Darren Williams <dswATgelato.unsw.edu.au>
#  
diff -Nru a/drivers/char/stallion.c b/drivers/char/stallion.c
--- a/drivers/char/stallion.c	2004-12-08 13:44:57 +11:00
+++ b/drivers/char/stallion.c	2004-12-08 13:44:57 +11:00
@@ -240,7 +240,6 @@
 
 /*****************************************************************************/
 
-#ifdef MODULE
 /*
  *	Define some string labels for arguments passed from the module
  *	load line. These allow for easy board definitions, and easy
@@ -316,7 +315,6 @@
 MODULE_PARM(board3, "1-4s");
 MODULE_PARM_DESC(board3, "Board 3 config -> name[,ioaddr[,ioaddr2][,irq]]");
 
-#endif
 
 /*****************************************************************************/
 
@@ -472,12 +470,10 @@
  *	Declare all those functions in this driver!
  */
 
-#ifdef MODULE
 static void	stl_argbrds(void);
 static int	stl_parsebrd(stlconf_t *confp, char **argp);
 
 static unsigned long stl_atol(char *str);
-#endif
 
 int		stl_init(void);
 static int	stl_open(struct tty_struct *tty, struct file *filp);
@@ -504,7 +500,7 @@
 
 static int	stl_brdinit(stlbrd_t *brdp);
 static int	stl_initports(stlbrd_t *brdp, stlpanel_t *panelp);
-static int	stl_mapirq(int irq, char *name);
+static int	stl_mapirq(stlbrd_t *brdp, char *name);
 static int	stl_getserial(stlport_t *portp, struct serial_struct __user *sp);
 static int	stl_setserial(stlport_t *portp, struct serial_struct __user *sp);
 static int	stl_getbrdstats(combrd_t __user *bp);
@@ -735,7 +731,6 @@
 
 static struct class_simple *stallion_class;
 
-#ifdef MODULE
 
 /*
  *	Loadable module initialization stuff.
@@ -959,7 +954,6 @@
 	return(1);
 }
 
-#endif
 
 /*****************************************************************************/
 
@@ -2179,26 +2173,27 @@
  *	interrupt across multiple boards.
  */
 
-static int __init stl_mapirq(int irq, char *name)
+static int __init stl_mapirq(stlbrd_t *brdp, char *name)
 {
 	int	rc, i;
 
 #ifdef DEBUG
-	printk("stl_mapirq(irq=%d,name=%s)\n", irq, name);
+	printk("stl_mapirq(irq=%d,name=%s)\n", brdp->irq, name);
 #endif
 
 	rc = 0;
 	for (i = 0; (i < stl_numintrs); i++) {
-		if (stl_gotintrs[i] == irq)
+		if (stl_gotintrs[i] == brdp->irq)
 			break;
 	}
 	if (i >= stl_numintrs) {
-		if (request_irq(irq, stl_intr, SA_SHIRQ, name, NULL) != 0) {
+		/* pass the unique board pointer for shared interrupt dev_id */
+		if ( request_irq(brdp->irq, stl_intr, SA_SHIRQ, name, brdp) != 0) {
 			printk("STALLION: failed to register interrupt "
-				"routine for %s irq=%d\n", name, irq);
+				"routine for %s irq=%d\n", name, brdp->irq);
 			rc = -ENODEV;
 		} else {
-			stl_gotintrs[stl_numintrs++] = irq;
+			stl_gotintrs[stl_numintrs++] = brdp->irq;
 		}
 	}
 	return(rc);
@@ -2389,7 +2384,7 @@
 	brdp->nrpanels = 1;
 	brdp->state |= BRD_FOUND;
 	brdp->hwid = status;
-	rc = stl_mapirq(brdp->irq, name);
+	rc = stl_mapirq(brdp, name);
 	return(rc);
 }
 
@@ -2594,7 +2589,7 @@
 		outb((brdp->ioctrlval | ECH_BRDDISABLE), brdp->ioctrl);
 
 	brdp->state |= BRD_FOUND;
-	i = stl_mapirq(brdp->irq, name);
+	i = stl_mapirq(brdp, name);
 	return(i);
 }
 
@@ -2807,9 +2802,7 @@
  */
 	for (i = 0; (i < stl_nrbrds); i++) {
 		confp = &stl_brdconf[i];
-#ifdef MODULE
 		stl_parsebrd(confp, stl_brdsp[i]);
-#endif
 		if ((brdp = stl_allocbrd()) == (stlbrd_t *) NULL)
 			return(-ENOMEM);
 		brdp->brdnr = i;
@@ -2825,9 +2818,7 @@
  *	Find any dynamically supported boards. That is via module load
  *	line options or auto-detected on the PCI bus.
  */
-#ifdef MODULE
 	stl_argbrds();
-#endif
 #ifdef CONFIG_PCI
 	stl_findpcibrds();
 #endif

--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="stl-built-in-final-module-clean-up.patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/21 09:26:35+11:00 dsw@vanilla.gelato 
#   Update module setup to use latest module interface and remove ia64 compiler warnings.
#   Tested on i386 and ia64,  built-in and as a module, run only on i386.
#   
#   Signed-off Darren Williams (dswATgelato.unsw.edu.au)
# 
# drivers/char/stallion.c
#   2004/12/21 09:26:26+11:00 dsw@vanilla.gelato +12 -13
#   - Replace deprecated MODULE_PARM->module_param_array
#   - Let module interface determine the number of args
#   - Remove printk compiler warnings for ia64
# 
diff -Nru a/drivers/char/stallion.c b/drivers/char/stallion.c
--- a/drivers/char/stallion.c	2004-12-21 09:33:05 +11:00
+++ b/drivers/char/stallion.c	2004-12-21 09:33:05 +11:00
@@ -246,6 +246,7 @@
  *	modification of the io, memory and irq resoucres.
  */
 
+static int	stl_nargs = 0;
 static char	*board0[4];
 static char	*board1[4];
 static char	*board2[4];
@@ -306,13 +307,13 @@
 MODULE_DESCRIPTION("Stallion Multiport Serial Driver");
 MODULE_LICENSE("GPL");
 
-MODULE_PARM(board0, "1-4s");
+module_param_array(board0, charp, &stl_nargs, 0);
 MODULE_PARM_DESC(board0, "Board 0 config -> name[,ioaddr[,ioaddr2][,irq]]");
-MODULE_PARM(board1, "1-4s");
+module_param_array(board1, charp, &stl_nargs, 0);
 MODULE_PARM_DESC(board1, "Board 1 config -> name[,ioaddr[,ioaddr2][,irq]]");
-MODULE_PARM(board2, "1-4s");
+module_param_array(board2, charp, &stl_nargs, 0);
 MODULE_PARM_DESC(board2, "Board 2 config -> name[,ioaddr[,ioaddr2][,irq]]");
-MODULE_PARM(board3, "1-4s");
+module_param_array(board3, charp, &stl_nargs, 0);
 MODULE_PARM_DESC(board3, "Board 3 config -> name[,ioaddr[,ioaddr2][,irq]]");
 
 
@@ -846,15 +847,13 @@
 {
 	stlconf_t	conf;
 	stlbrd_t	*brdp;
-	int		nrargs, i;
+	int		i;
 
 #ifdef DEBUG
 	printk("stl_argbrds()\n");
 #endif
 
-	nrargs = sizeof(stl_brdsp) / sizeof(char **);
-
-	for (i = stl_nrbrds; (i < nrargs); i++) {
+	for (i = stl_nrbrds; (i < stl_nargs); i++) {
 		memset(&conf, 0, sizeof(conf));
 		if (stl_parsebrd(&conf, stl_brdsp[i]) == 0)
 			continue;
@@ -978,8 +977,8 @@
 
 	brdp = (stlbrd_t *) stl_memalloc(sizeof(stlbrd_t));
 	if (brdp == (stlbrd_t *) NULL) {
-		printk("STALLION: failed to allocate memory (size=%d)\n",
-			sizeof(stlbrd_t));
+		printk("STALLION: failed to allocate memory (size=%lu)\n",
+			(unsigned long)sizeof(stlbrd_t));
 		return((stlbrd_t *) NULL);
 	}
 
@@ -2224,7 +2223,7 @@
 		portp = (stlport_t *) stl_memalloc(sizeof(stlport_t));
 		if (portp == (stlport_t *) NULL) {
 			printk("STALLION: failed to allocate memory "
-				"(size=%d)\n", sizeof(stlport_t));
+				"(size=%lu)\n", (unsigned long)sizeof(stlport_t));
 			break;
 		}
 		memset(portp, 0, sizeof(stlport_t));
@@ -2361,7 +2360,7 @@
 	panelp = (stlpanel_t *) stl_memalloc(sizeof(stlpanel_t));
 	if (panelp == (stlpanel_t *) NULL) {
 		printk(KERN_WARNING "STALLION: failed to allocate memory "
-			"(size=%d)\n", sizeof(stlpanel_t));
+			"(size=%lu)\n", (unsigned long)sizeof(stlpanel_t));
 		return(-ENOMEM);
 	}
 	memset(panelp, 0, sizeof(stlpanel_t));
@@ -2530,7 +2529,7 @@
 		panelp = (stlpanel_t *) stl_memalloc(sizeof(stlpanel_t));
 		if (panelp == (stlpanel_t *) NULL) {
 			printk("STALLION: failed to allocate memory "
-				"(size=%d)\n", sizeof(stlpanel_t));
+				"(size=%lu)\n", (unsigned long)sizeof(stlpanel_t));
 			break;
 		}
 		memset(panelp, 0, sizeof(stlpanel_t));

--h31gzZEtNLTqOjlF--
