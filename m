Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263058AbTH0D0X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 23:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263061AbTH0D0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 23:26:19 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:9879 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263058AbTH0D0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 23:26:11 -0400
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: support@stallion.oz.au
Date: Wed, 27 Aug 2003 13:26:03 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16204.9419.975808.761408@wombat.disy.cse.unsw.edu.au>
CC: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.0-test4 stallion serial driver cleanup
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The stallion driver currently fails to compile.
The attached patch fixes it, and fixes a couple of 32/64 bit problems
in printk statements.  The resulting driver appears to work on IA64
with an 8-port EasyIO board.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1292  -> 1.1293 
#	drivers/char/stallion.c	1.33    -> 1.34   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/27	peterc@gelato.unsw.edu.au	1.1293
# Stallion driver cleanup: schedule_task()->schedule_work(), 64-bit cleanups.
# --------------------------------------------
#
diff -Nru a/drivers/char/stallion.c b/drivers/char/stallion.c
--- a/drivers/char/stallion.c	Wed Aug 27 13:25:31 2003
+++ b/drivers/char/stallion.c	Wed Aug 27 13:25:32 2003
@@ -979,7 +979,7 @@
 
 	brdp = (stlbrd_t *) stl_memalloc(sizeof(stlbrd_t));
 	if (brdp == (stlbrd_t *) NULL) {
-		printk("STALLION: failed to allocate memory (size=%d)\n",
+		printk("STALLION: failed to allocate memory (size=%ld)\n",
 			sizeof(stlbrd_t));
 		return((stlbrd_t *) NULL);
 	}
@@ -2228,6 +2228,7 @@
 			break;
 	}
 	if (i >= stl_numintrs) {
+		/* FIXME -- pass in a valid device id */
 		if (request_irq(irq, stl_intr, SA_SHIRQ, name, NULL) != 0) {
 			printk("STALLION: failed to register interrupt "
 				"routine for %s irq=%d\n", name, irq);
@@ -2264,7 +2265,7 @@
 		portp = (stlport_t *) stl_memalloc(sizeof(stlport_t));
 		if (portp == (stlport_t *) NULL) {
 			printk("STALLION: failed to allocate memory "
-				"(size=%d)\n", sizeof(stlport_t));
+				"(size=%ld)\n", sizeof(stlport_t));
 			break;
 		}
 		memset(portp, 0, sizeof(stlport_t));
@@ -2401,7 +2402,7 @@
 	panelp = (stlpanel_t *) stl_memalloc(sizeof(stlpanel_t));
 	if (panelp == (stlpanel_t *) NULL) {
 		printk(KERN_WARNING "STALLION: failed to allocate memory "
-			"(size=%d)\n", sizeof(stlpanel_t));
+			"(size=%ld)\n", sizeof(stlpanel_t));
 		return(-ENOMEM);
 	}
 	memset(panelp, 0, sizeof(stlpanel_t));
@@ -2570,7 +2571,7 @@
 		panelp = (stlpanel_t *) stl_memalloc(sizeof(stlpanel_t));
 		if (panelp == (stlpanel_t *) NULL) {
 			printk("STALLION: failed to allocate memory "
-				"(size=%d)\n", sizeof(stlpanel_t));
+				"(size=%ld)\n", sizeof(stlpanel_t));
 			break;
 		}
 		memset(panelp, 0, sizeof(stlpanel_t));
@@ -4234,7 +4235,7 @@
 	misr = inb(ioaddr + EREG_DATA);
 	if (misr & MISR_DCD) {
 		set_bit(ASYI_DCDCHANGE, &portp->istate);
-		schedule_task(&portp->tqueue);
+		schedule_work(&portp->tqueue);
 		portp->stats.modem++;
 	}
 
@@ -5031,7 +5032,7 @@
 	if ((len == 0) || ((len < STL_TXBUFLOW) &&
 	    (test_bit(ASYI_TXLOW, &portp->istate) == 0))) {
 		set_bit(ASYI_TXLOW, &portp->istate);
-		schedule_task(&portp->tqueue); 
+		schedule_work(&portp->tqueue); 
 	}
 
 	if (len == 0) {
@@ -5248,7 +5249,7 @@
 		ipr = stl_sc26198getreg(portp, IPR);
 		if (ipr & IPR_DCDCHANGE) {
 			set_bit(ASYI_DCDCHANGE, &portp->istate);
-			schedule_task(&portp->tqueue); 
+			schedule_work(&portp->tqueue); 
 			portp->stats.modem++;
 		}
 		break;
