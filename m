Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbUJYB4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbUJYB4Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 21:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbUJYB4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 21:56:25 -0400
Received: from gate.crashing.org ([63.228.1.57]:18893 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261660AbUJYB4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 21:56:01 -0400
Subject: [PATCH] ppc64: Some cleanups of prom_init.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 25 Oct 2004 11:53:57 +1000
Message-Id: <1098669237.26697.12.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch does a few cleanups of arch/ppc64/kernel/prom_init.c, making
the RTAS instanciation code more readable & more robust, fixing a bug
in the code bringing in additional CPUs (would work with IBM firmware,
but not with another firmware of an upcoming platform), plus remove some
old commented out cruft left-over from the big cleanup.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc64/kernel/prom_init.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/prom_init.c	2004-10-25 10:24:50.000000000 +1000
+++ linux-work/arch/ppc64/kernel/prom_init.c	2004-10-25 11:51:04.888577136 +1000
@@ -159,8 +159,6 @@
 
 extern unsigned long klimit;
 
-//int global_width = 640, global_height = 480, global_depth = 8, global_pitch;
-//unsigned global_address;
 /* prom structure */
 static struct prom_t __initdata prom;
 
@@ -705,46 +703,50 @@
 	struct prom_t *_prom = PTRRELOC(&prom);
 	phandle prom_rtas;
 	u64 base, entry = 0;
-        u32 size;
+        u32 size = 0;
 
 	prom_debug("prom_instantiate_rtas: start...\n");
 
 	prom_rtas = call_prom("finddevice", 1, 1, ADDR("/rtas"));
-	if (prom_rtas != (phandle) -1) {
-		prom_getprop(prom_rtas, "rtas-size", &size, sizeof(size));
-		if (size != 0) {
-			base = alloc_down(size, PAGE_SIZE, 0);
-			if (base == 0) {
-				prom_printf("RTAS allocation failed !\n");
-				return;
-			}
-			prom_printf("instantiating rtas at 0x%x", base);
+	prom_debug("prom_rtas: %x\n", prom_rtas);
+	if (prom_rtas == (phandle) -1)
+		return;
 
-			prom_rtas = call_prom("open", 1, 1, ADDR("/rtas"));
-			prom_printf("...");
+	prom_getprop(prom_rtas, "rtas-size", &size, sizeof(size));
+	if (size == 0)
+		return;
 
-			if (call_prom("call-method", 3, 2,
-				      ADDR("instantiate-rtas"),
-				      prom_rtas, base) != PROM_ERROR) {
-				entry = (long)_prom->args.rets[1];
-			}
-			if (entry == 0) {
-				prom_printf(" failed\n");
-				return;
-			}
-			prom_printf(" done\n");
+	base = alloc_down(size, PAGE_SIZE, 0);
+	if (base == 0) {
+		prom_printf("RTAS allocation failed !\n");
+		return;
+	}
+	prom_printf("instantiating rtas at 0x%x", base);
 
-	       		reserve_mem(base, size);
-		}
+	prom_rtas = call_prom("open", 1, 1, ADDR("/rtas"));
+	prom_printf("...");
 
-		prom_setprop(_prom->chosen, "linux,rtas-base", &base, sizeof(base));
-		prom_setprop(_prom->chosen, "linux,rtas-entry", &entry, sizeof(entry));
-		prom_setprop(_prom->chosen, "linux,rtas-size", &size, sizeof(size));
-
-		prom_debug("rtas base     = 0x%x\n", base);
-		prom_debug("rtas entry    = 0x%x\n", entry);
-		prom_debug("rtas size     = 0x%x\n", (long)size);
+	if (call_prom("call-method", 3, 2,
+		      ADDR("instantiate-rtas"),
+		      prom_rtas, base) != PROM_ERROR) {
+		entry = (long)_prom->args.rets[1];
 	}
+	if (entry == 0) {
+		prom_printf(" failed\n");
+		return;
+	}
+	prom_printf(" done\n");
+
+	reserve_mem(base, size);
+
+	prom_setprop(_prom->chosen, "linux,rtas-base", &base, sizeof(base));
+	prom_setprop(_prom->chosen, "linux,rtas-entry", &entry, sizeof(entry));
+	prom_setprop(_prom->chosen, "linux,rtas-size", &size, sizeof(size));
+
+	prom_debug("rtas base     = 0x%x\n", base);
+	prom_debug("rtas entry    = 0x%x\n", entry);
+	prom_debug("rtas size     = 0x%x\n", (long)size);
+
 	prom_debug("prom_instantiate_rtas: end...\n");
 }
 
@@ -951,9 +953,9 @@
 			continue;
 
 		/* Skip non-configured cpus. */
-		prom_getprop(node, "status", type, sizeof(type));
-		if (strcmp(type, RELOC("okay")) != 0)
-			continue;
+		if (prom_getprop(node, "status", type, sizeof(type)) > 0)
+			if (strcmp(type, RELOC("okay")) != 0)
+				continue;
 
 		reg = -1;
 		prom_getprop(node, "reg", &reg, sizeof(reg));
@@ -993,7 +995,8 @@
 				  secondary_hold, cpuid);
 
 			for ( i = 0 ; (i < 100000000) && 
-			      (*acknowledge == ((unsigned long)-1)); i++ ) ;
+			      (*acknowledge == ((unsigned long)-1)); i++ )
+				mb();
 
 			if (*acknowledge == cpuid) {
 				prom_printf("done\n");
@@ -1160,7 +1163,7 @@
  * So we check whether we will need to open the display,
  * and if so, open it now.
  */
-static unsigned long __init prom_check_displays(void)
+static void __init prom_check_displays(void)
 {
 	unsigned long offset = reloc_offset();
 	struct prom_t *_prom = PTRRELOC(&prom);


