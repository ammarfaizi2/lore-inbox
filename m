Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVBXA0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVBXA0m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 19:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVBXA0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 19:26:12 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:63697 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261661AbVBXARJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 19:17:09 -0500
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: Burn Alting <burn@goldweb.com.au>
Date: Thu, 24 Feb 2005 11:16:47 +1100
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: stallion module cannot register it's ISR in a 2.6.10 kernel on a FC3 system
Message-ID: <20050224001647.GB25713@cse.unsw.EDU.AU>
Mail-Followup-To: Burn Alting <burn@goldweb.com.au>,
	linux-kernel@vger.kernel.org
References: <1108716493.6213.8.camel@swtf.comptex.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline
In-Reply-To: <1108716493.6213.8.camel@swtf.comptex.com.au>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Burn

Could you try the attached patch

It solved the same problem for me, it is NOT SMP safe due
to cli() calls, though will run fine on your system. I have been
running a console box for about 1mth non-stop with these applied.

The patch does two things it allows the driver to be built-in and
updates the call to request_irq, which is what is causing the
problem.

On Fri, 18 Feb 2005, Burn Alting wrote:

> Here is the bug report. Stallion was purchased by Lantronix and they
> don't really care about this bug.
> 

> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------

--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="02-stl-built-in-final-UP.patch"

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

--CblX+4bnyfN0pR09--
