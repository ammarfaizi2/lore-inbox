Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVETOlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVETOlo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 10:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVETOlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 10:41:44 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:56078 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261243AbVETOlb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 10:41:31 -0400
Message-Id: <200505201436.j4KEZxjh006235@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 4/9] UML - Delay loop cleanups 
In-Reply-To: Your message of "Wed, 18 May 2005 14:18:00 PDT."
             <20050518141800.299476d9.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 20 May 2005 10:35:57 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@osdl.org said:
> I'll drop this in light of the review comments - pls redo&&resend 

Here 'tis.

This patch cleans up the delay implementations a bit, makes the loops
unoptimizable, and exports __udelay and __const_udelay.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/sys-i386/delay.c
===================================================================
--- linux-2.6.11.orig/arch/um/sys-i386/delay.c	2005-05-19 13:18:50.000000000 -0400
+++ linux-2.6.11/arch/um/sys-i386/delay.c	2005-05-19 13:19:40.000000000 -0400
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
+                cpu_relax();
 }
 
+EXPORT_SYMBOL(__udelay);
+
 void __const_udelay(unsigned long usecs)
 {
 	int i, n;
 
 	n = (loops_per_jiffy * HZ * usecs) / MILLION;
-	for(i=0;i<n;i++) ;
+        for(i=0;i<n;i++)
+                cpu_relax();
 }
+
+EXPORT_SYMBOL(__const_udelay);
Index: linux-2.6.11/arch/um/sys-x86_64/delay.c
===================================================================
--- linux-2.6.11.orig/arch/um/sys-x86_64/delay.c	2005-05-19 13:18:50.000000000 -0400
+++ linux-2.6.11/arch/um/sys-x86_64/delay.c	2005-05-19 13:19:40.000000000 -0400
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
+                cpu_relax();
 }
 
 void __udelay(unsigned long usecs)
 {
-	int i, n;
+	unsigned long i, n;
 
 	n = (loops_per_jiffy * HZ * usecs) / MILLION;
-	for(i=0;i<n;i++) ;
+        for(i=0;i<n;i++)
+                cpu_relax();
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
+                cpu_relax();
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

