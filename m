Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265233AbUEMWri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265233AbUEMWri (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 18:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbUEMWrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 18:47:37 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:17423 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265233AbUEMWrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 18:47:17 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] allow console drivers to be called early
Date: Thu, 13 May 2004 15:47:14 -0700
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_yr/oAkGvy4eI0aV"
Message-Id: <200405131547.14062.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_yr/oAkGvy4eI0aV
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This is a simple patch to allow arches to set early_printk_ok if they've 
registered console drivers that support early operation.  I've got an ia64 
specific bit and an sn2 specific bit that I can post for reference if 
anyone's interested, but they're pretty straightforward, so I'm just posting 
this for comments.  The ia64 one just adds a register_early_consoles() 
function to the ia64 code that gets called early on in setup_arch.  All it 
does is call the init routines of console drivers that are setup to do early 
printks.

Jesse

--Boundary-00=_yr/oAkGvy4eI0aV
Content-Type: text/plain;
  charset="us-ascii";
  name="early-printk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="early-printk.patch"

===== kernel/printk.c 1.37 vs edited =====
--- 1.37/kernel/printk.c	Tue May  4 10:48:06 2004
+++ edited/kernel/printk.c	Fri May  7 15:01:33 2004
@@ -54,6 +54,7 @@
 EXPORT_SYMBOL(console_printk);
 
 int oops_in_progress;
+int early_printk_ok;
 
 /*
  * console_sem protects the console_drivers list, and also
@@ -526,7 +527,7 @@
 			log_level_unknown = 1;
 	}
 
-	if (!cpu_online(smp_processor_id()) &&
+	if (!early_printk_ok && !cpu_online(smp_processor_id()) &&
 	    system_state != SYSTEM_RUNNING) {
 		/*
 		 * Some console drivers may assume that per-cpu resources have
===== include/linux/kernel.h 1.48 vs edited =====
--- 1.48/include/linux/kernel.h	Mon Apr 12 10:53:58 2004
+++ edited/include/linux/kernel.h	Fri May  7 16:16:49 2004
@@ -107,6 +107,7 @@
 }
 
 extern void bust_spinlocks(int yes);
+extern int early_printk_ok;		/* If set, console drivers will be called even if the system isn't up yet */
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
 extern int panic_on_oops;
 extern int system_state;		/* See values below */

--Boundary-00=_yr/oAkGvy4eI0aV--
