Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271821AbRHRMnZ>; Sat, 18 Aug 2001 08:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271820AbRHRMnG>; Sat, 18 Aug 2001 08:43:06 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:37899 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S271819AbRHRMnB>;
	Sat, 18 Aug 2001 08:43:01 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15230.25235.599875.507597@cargo.ozlabs.ibm.com>
Date: Sat, 18 Aug 2001 22:41:55 +1000 (EST)
To: linux-kernel@vger.kernel.org
Subject: [PATCH] kbd_rate stuff for PPC
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds in the kbd_rate stuff for PPC.  Without this patch
the official 2.4.9 tree won't compile on PPC if you have CONFIG_VT
defined.

Paul.

diff -urN linux/arch/ppc/kernel/chrp_setup.c linuxppc_2_4/arch/ppc/kernel/chrp_setup.c
--- linux/arch/ppc/kernel/chrp_setup.c	Sat Jul 21 09:51:52 2001
+++ linuxppc_2_4/arch/ppc/kernel/chrp_setup.c	Mon Aug 13 15:52:20 2001
@@ -77,6 +77,7 @@
 			   char raw_mode);
 extern char pckbd_unexpected_up(unsigned char keycode);
 extern void pckbd_leds(unsigned char leds);
+extern int pckbd_rate(struct kbd_repeat *rep);
 extern void pckbd_init_hw(void);
 extern unsigned char pckbd_sysrq_xlate[128];
 extern int mackbd_setkeycode(unsigned int scancode, unsigned int keycode);
@@ -431,6 +432,7 @@
 		ppc_md.kbd_translate     = mackbd_translate;
 		ppc_md.kbd_unexpected_up = mackbd_unexpected_up;
 		ppc_md.kbd_leds          = mackbd_leds;
+		ppc_md.kbd_rate_fn	 = NULL;
 		ppc_md.kbd_init_hw       = mackbd_init_hw;
 #ifdef CONFIG_MAGIC_SYSRQ
 		ppc_md.ppc_kbd_sysrq_xlate	 = mackbd_sysrq_xlate;
@@ -584,6 +586,7 @@
 	ppc_md.kbd_translate     = pckbd_translate;
 	ppc_md.kbd_unexpected_up = pckbd_unexpected_up;
 	ppc_md.kbd_leds          = pckbd_leds;
+	ppc_md.kbd_rate_fn	 = pckbd_rate;
 	ppc_md.kbd_init_hw       = pckbd_init_hw;
 #ifdef CONFIG_MAGIC_SYSRQ
 	ppc_md.ppc_kbd_sysrq_xlate	 = pckbd_sysrq_xlate;
diff -urN linux/arch/ppc/kernel/prep_setup.c linuxppc_2_4/arch/ppc/kernel/prep_setup.c
--- linux/arch/ppc/kernel/prep_setup.c	Tue Aug 14 10:34:06 2001
+++ linuxppc_2_4/arch/ppc/kernel/prep_setup.c	Mon Aug 13 15:52:20 2001
@@ -85,6 +85,7 @@
 			   char raw_mode);
 extern char pckbd_unexpected_up(unsigned char keycode);
 extern void pckbd_leds(unsigned char leds);
+extern int pckbd_rate(struct kbd_repeat *rep);
 extern void pckbd_init_hw(void);
 extern unsigned char pckbd_sysrq_xlate[128];
 
@@ -932,6 +933,7 @@
 	ppc_md.kbd_translate     = pckbd_translate;
 	ppc_md.kbd_unexpected_up = pckbd_unexpected_up;
 	ppc_md.kbd_leds          = pckbd_leds;
+	ppc_md.kbd_rate_fn	 = pckbd_rate;
 	ppc_md.kbd_init_hw       = pckbd_init_hw;
 #ifdef CONFIG_MAGIC_SYSRQ
 	ppc_md.ppc_kbd_sysrq_xlate	 = pckbd_sysrq_xlate;
diff -urN linux/include/asm-ppc/keyboard.h linuxppc_2_4/include/asm-ppc/keyboard.h
--- linux/include/asm-ppc/keyboard.h	Sat May 26 12:39:54 2001
+++ linuxppc_2_4/include/asm-ppc/keyboard.h	Sat Aug 18 18:16:33 2001
@@ -23,6 +23,7 @@
 
 #include <linux/kernel.h>
 #include <linux/ioport.h>
+#include <linux/kd.h>
 #include <asm/io.h>
 
 #define KEYBOARD_IRQ			1
@@ -67,13 +68,14 @@
 	if ( ppc_md.kbd_leds )
 		ppc_md.kbd_leds(leds);
 }
-  
+
 static inline void kbd_init_hw(void)
 {
 	if ( ppc_md.kbd_init_hw )
 		ppc_md.kbd_init_hw();
 }
 
+#define kbd_rate	(ppc_md.kbd_rate_fn)
 #define kbd_sysrq_xlate	(ppc_md.ppc_kbd_sysrq_xlate)
 
 extern unsigned long SYSRQ_KEY;
diff -urN linux/include/asm-ppc/machdep.h linuxppc_2_4/include/asm-ppc/machdep.h
--- linux/include/asm-ppc/machdep.h	Wed Jul  4 14:33:57 2001
+++ linuxppc_2_4/include/asm-ppc/machdep.h	Mon Aug 13 15:52:20 2001
@@ -14,6 +14,7 @@
 struct pt_regs;
 struct pci_bus;	
 struct pci_dev;
+struct kbd_repeat;
 
 struct machdep_calls {
 	void		(*setup_arch)(void);
@@ -58,6 +59,7 @@
 				char raw_mode);
 	char		(*kbd_unexpected_up)(unsigned char keycode);
 	void		(*kbd_leds)(unsigned char leds);
+	int		(*kbd_rate_fn)(struct kbd_repeat *rep);
 	void		(*kbd_init_hw)(void);
 #ifdef CONFIG_MAGIC_SYSRQ
 	unsigned char 	*ppc_kbd_sysrq_xlate;
