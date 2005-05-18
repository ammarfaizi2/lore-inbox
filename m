Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbVERMxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbVERMxd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 08:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVERMxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 08:53:33 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:35853 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262133AbVERMxI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 08:53:08 -0400
Message-Id: <200505180420.j4I4KQ6H017322@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH 4/9] UML - Delay loop cleanups
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 18 May 2005 00:20:26 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up the delay implementations a bit, makes the loops
unoptimizable, and exports __udelay and __const_udelay.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/sys-i386/delay.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/sys-i386/delay.c	2005-05-17 18:02:25.000000000 -0400
+++ linux-2.6.12-rc/arch/um/sys-i386/delay.c	2005-05-17 18:11:21.000000000 -0400
@@ -1,5 +1,7 @@
-#include "linux/delay.h"
-#include "asm/param.h"
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <asm/param.h>
 
 void __delay(unsigned long time)
 {
@@ -20,13 +22,19 @@ void __udelay(unsigned long usecs)
 	int i, n;
 
 	n = (loops_per_jiffy * HZ * usecs) / MILLION;
-	for(i=0;i<n;i++) ;
+        for(i=0;i<n;i++)
+                barrier();
 }
 
+EXPORT_SYMBOL(__udelay);
+
 void __const_udelay(unsigned long usecs)
 {
 	int i, n;
 
 	n = (loops_per_jiffy * HZ * usecs) / MILLION;
-	for(i=0;i<n;i++) ;
+        for(i=0;i<n;i++)
+                barrier();
 }
+
+EXPORT_SYMBOL(__const_udelay);
Index: linux-2.6.12-rc/arch/um/sys-x86_64/delay.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/sys-x86_64/delay.c	2005-05-17 18:02:25.000000000 -0400
+++ linux-2.6.12-rc/arch/um/sys-x86_64/delay.c	2005-05-17 18:11:21.000000000 -0400
@@ -5,40 +5,37 @@
  * Licensed under the GPL
  */
 
-#include "linux/delay.h"
-#include "asm/processor.h"
-#include "asm/param.h"
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <asm/processor.h>
+#include <asm/param.h>
 
 void __delay(unsigned long loops)
 {
 	unsigned long i;
 
-	for(i = 0; i < loops; i++) ;
+        for(i = 0; i < loops; i++)
+                barrier();
 }
 
 void __udelay(unsigned long usecs)
 {
-	int i, n;
+	unsigned long i, n;
 
 	n = (loops_per_jiffy * HZ * usecs) / MILLION;
-	for(i=0;i<n;i++) ;
+        for(i=0;i<n;i++)
+                barrier();
 }
 
+EXPORT_SYMBOL(__udelay);
+
 void __const_udelay(unsigned long usecs)
 {
-	int i, n;
+	unsigned long i, n;
 
 	n = (loops_per_jiffy * HZ * usecs) / MILLION;
-	for(i=0;i<n;i++) ;
+        for(i=0;i<n;i++)
+                barrier();
 }
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
+EXPORT_SYMBOL(__const_udelay);

