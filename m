Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262510AbVCJK5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262510AbVCJK5B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 05:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262512AbVCJK5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 05:57:01 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:11203 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S262510AbVCJK4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 05:56:52 -0500
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: alan@lxorguk.ukuu.org.uk, LKML <linux-kernel@vger.kernel.org>
Date: Thu, 10 Mar 2005 21:56:45 +1100
Subject: [PATCH] 2.6.11-bk Stallion driver module clean up
Message-ID: <20050310105645.GD25458@cse.unsw.EDU.AU>
Mail-Followup-To: alan@lxorguk.ukuu.org.uk,
	LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches continue the work that Wayne Meissner
started and are against the current bk tree.

These patches allow the stallion driver to be built-in and
loaded at boot time, the current #ifdef MODULE only allows
the init code to be included if compiled as a module.

Tested for compile, boot and running on our console server
as module and built-in.

Signed-off-by Darren Williams <dsw@gelato.unsw.edu.au>
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/02/25 15:17:25+11:00 dsw@vanilla.gelato.unsw.edu.au 
#   stallion serial driver module clean up
# 
# drivers/char/stallion.c
#   2005/02/25 15:17:16+11:00 dsw@vanilla.gelato.unsw.edu.au +5 -18
#   Remove #define MODULE, and update module parameter declarations
# 
Index: linux-2.5-import/drivers/char/stallion.c
===================================================================
--- linux-2.5-import.orig/drivers/char/stallion.c	2005-03-10 21:09:13.000000000 +1100
+++ linux-2.5-import/drivers/char/stallion.c	2005-03-10 21:36:00.000000000 +1100
@@ -232,13 +232,12 @@
 
 /*****************************************************************************/
 
-#ifdef MODULE
 /*
  *	Define some string labels for arguments passed from the module
  *	load line. These allow for easy board definitions, and easy
  *	modification of the io, memory and irq resoucres.
  */
-
+static int	stl_nargs = 0;
 static char	*board0[4];
 static char	*board1[4];
 static char	*board2[4];
@@ -299,17 +298,15 @@
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
 
-#endif
-
 /*****************************************************************************/
 
 /*
@@ -464,12 +461,10 @@
  *	Declare all those functions in this driver!
  */
 
-#ifdef MODULE
 static void	stl_argbrds(void);
 static int	stl_parsebrd(stlconf_t *confp, char **argp);
 
 static unsigned long stl_atol(char *str);
-#endif
 
 int		stl_init(void);
 static int	stl_open(struct tty_struct *tty, struct file *filp);
@@ -726,8 +721,6 @@
 
 static struct class_simple *stallion_class;
 
-#ifdef MODULE
-
 /*
  *	Loadable module initialization stuff.
  */
@@ -950,8 +943,6 @@
 	return(1);
 }
 
-#endif
-
 /*****************************************************************************/
 
 /*
@@ -2787,9 +2778,7 @@
  */
 	for (i = 0; (i < stl_nrbrds); i++) {
 		confp = &stl_brdconf[i];
-#ifdef MODULE
 		stl_parsebrd(confp, stl_brdsp[i]);
-#endif
 		if ((brdp = stl_allocbrd()) == (stlbrd_t *) NULL)
 			return(-ENOMEM);
 		brdp->brdnr = i;
@@ -2805,9 +2794,7 @@
  *	Find any dynamically supported boards. That is via module load
  *	line options or auto-detected on the PCI bus.
  */
-#ifdef MODULE
 	stl_argbrds();
-#endif
 #ifdef CONFIG_PCI
 	stl_findpcibrds();
 #endif


# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/02/25 15:22:21+11:00 dsw@vanilla.gelato.unsw.edu.au 
#   remove old 'nrargs' module argument count
# 
# drivers/char/stallion.c
#   2005/02/25 15:22:12+11:00 dsw@vanilla.gelato.unsw.edu.au +2 -4
#   module arguments are now declared with module paramater declarations
# 
Index: linux-2.5-import/drivers/char/stallion.c
===================================================================
--- linux-2.5-import.orig/drivers/char/stallion.c	2005-03-10 21:36:00.000000000 +1100
+++ linux-2.5-import/drivers/char/stallion.c	2005-03-10 21:36:41.000000000 +1100
@@ -835,15 +835,13 @@
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



--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------
