Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267013AbTBCTjB>; Mon, 3 Feb 2003 14:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267005AbTBCTjB>; Mon, 3 Feb 2003 14:39:01 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:5318 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267003AbTBCTi6>;
	Mon, 3 Feb 2003 14:38:58 -0500
Subject: [RFC][PATCH] linux-2.5.59_enable-cyclone_A0
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1044301569.19552.55.camel@w-jstultz2.beaverton.ibm.com>
References: <1044301569.19552.55.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1044301646.19553.57.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 03 Feb 2003 11:47:26 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All, 
	This patch simply enables the existing timer_cyclone code for
Summit/x440 systems.  It depends on cyclone-fixes_A0.
	
Comments, flames and suggestions welcome.

thanks
-john

diff -Nru a/arch/i386/kernel/timers/Makefile b/arch/i386/kernel/timers/Makefile
--- a/arch/i386/kernel/timers/Makefile	Mon Feb  3 11:24:53 2003
+++ b/arch/i386/kernel/timers/Makefile	Mon Feb  3 11:24:53 2003
@@ -4,4 +4,4 @@
 
 obj-y := timer.o timer_none.o timer_tsc.o timer_pit.o
 
-obj-$(CONFIG_X86_CYCLONE)	+= timer_cyclone.o
+obj-$(CONFIG_X86_SUMMIT)	+= timer_cyclone.o
diff -Nru a/arch/i386/kernel/timers/timer.c b/arch/i386/kernel/timers/timer.c
--- a/arch/i386/kernel/timers/timer.c	Mon Feb  3 11:24:53 2003
+++ b/arch/i386/kernel/timers/timer.c	Mon Feb  3 11:24:53 2003
@@ -4,9 +4,14 @@
 /* list of externed timers */
 extern struct timer_opts timer_pit;
 extern struct timer_opts timer_tsc;
-
+#ifdef CONFIG_X86_SUMMIT
+extern struct timer_opts timer_cyclone;
+#endif
 /* list of timers, ordered by preference, NULL terminated */
 static struct timer_opts* timers[] = {
+#ifdef CONFIG_X86_SUMMIT
+	&timer_cyclone,
+#endif
 	&timer_tsc,
 	&timer_pit,
 	NULL,
diff -Nru a/include/asm-i386/fixmap.h b/include/asm-i386/fixmap.h
--- a/include/asm-i386/fixmap.h	Mon Feb  3 11:24:53 2003
+++ b/include/asm-i386/fixmap.h	Mon Feb  3 11:24:53 2003
@@ -60,7 +60,7 @@
 #ifdef CONFIG_X86_F00F_BUG
 	FIX_F00F_IDT,	/* Virtual mapping for IDT */
 #endif
-#ifdef CONFIG_X86_CYCLONE
+#ifdef CONFIG_X86_SUMMIT
 	FIX_CYCLONE_TIMER, /*cyclone timer register*/
 #endif 
 #ifdef CONFIG_HIGHMEM
diff -Nru a/include/asm-i386/mach-summit/mach_mpparse.h b/include/asm-i386/mach-summit/mach_mpparse.h
--- a/include/asm-i386/mach-summit/mach_mpparse.h	Mon Feb  3 11:24:53 2003
+++ b/include/asm-i386/mach-summit/mach_mpparse.h	Mon Feb  3 11:24:53 2003
@@ -1,6 +1,8 @@
 #ifndef __ASM_MACH_MPPARSE_H
 #define __ASM_MACH_MPPARSE_H
 
+extern int use_cyclone;
+
 static inline void mpc_oem_bus_info(struct mpc_config_bus *m, char *name, 
 				struct mpc_config_translation *translation)
 {
@@ -17,14 +19,18 @@
 {
 	if (!strncmp(oem, "IBM ENSW", 8) && 
 			(!strncmp(productid, "VIGIL SMP", 9) 
-			 || !strncmp(productid, "RUTHLESS SMP", 12)))
+			 || !strncmp(productid, "RUTHLESS SMP", 12))){
 		x86_summit = 1;
+		use_cyclone = 1; /*enable cyclone-timer*/
+	}
 }
 
 /* Hook from generic ACPI tables.c */
 static inline void acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 {
-	if (!strncmp(oem_id, "IBM", 3) && !strncmp(oem_table_id, "SERVIGIL", 8))
+	if (!strncmp(oem_id, "IBM", 3) && !strncmp(oem_table_id, "SERVIGIL", 8)){
 		x86_summit = 1;
+		use_cyclone = 1; /*enable cyclone-timer*/
+	}
 }
 #endif /* __ASM_MACH_MPPARSE_H */



