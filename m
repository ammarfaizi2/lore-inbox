Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264292AbTEaLnf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 07:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264293AbTEaLnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 07:43:35 -0400
Received: from ns.suse.de ([213.95.15.193]:16647 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264292AbTEaLnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 07:43:31 -0400
Date: Sat, 31 May 2003 13:56:53 +0200
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com
Subject: [PATCH] Eat keys on panic
Message-ID: <20030531115653.GA11119@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[forgot to cc linux-kernel with the other mail]

I have a weird KVM that refuses to switch consoles when the keyboard
controller doesn't process key presses. Actually it switches, but only
after a long delay which usually drives me crazy.

This patch changes the panic loop to eat keys from the keyboard controller
on i386 boxes. With that I can switch consoles after a panic.

The ioport should be available on all PC like boxes, the reset code also
depends on it being at a fixed place.

ioport.c is not the best place in the world to place the function,
but I didn't find a better one. It cannot be inlined to avoid include
hell.

-Andi

Index: linux/arch/i386/kernel/ioport.c
===================================================================
RCS file: /home/cvs/linux-2.5/arch/i386/kernel/ioport.c,v
retrieving revision 1.17
diff -u -u -r1.17 ioport.c
--- linux/arch/i386/kernel/ioport.c	30 May 2003 20:12:29 -0000	1.17
+++ linux/arch/i386/kernel/ioport.c	31 May 2003 10:24:18 -0000
@@ -15,6 +15,7 @@
 #include <linux/stddef.h>
 #include <linux/slab.h>
 #include <linux/thread_info.h>
+#include <asm/io.h>
 
 /* Set EXTENT bits starting at BASE in BITMAP to value TURN_ON. */
 static void set_bitmap(unsigned long *bitmap, short base, short extent, int new_value)
@@ -128,4 +129,10 @@
 	/* Make sure we return the long way (not sysenter) */
 	set_thread_flag(TIF_IRET);
 	return 0;
+}
+
+void eat_key(void)
+{
+        if (inb(0x60) & 1) 
+                inb(0x64);
 }
Index: linux/include/asm-i386/system.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-i386/system.h,v
retrieving revision 1.37
diff -u -u -r1.37 system.h
--- linux/include/asm-i386/system.h	30 May 2003 20:10:39 -0000	1.37
+++ linux/include/asm-i386/system.h	31 May 2003 10:24:24 -0000
@@ -476,4 +476,7 @@
 #define BROKEN_PNP_BIOS		0x0004
 #define BROKEN_CPUFREQ		0x0008
 
+#define HAVE_EAT_KEY
+void eat_key(void);
+
 #endif
Index: linux/kernel/panic.c
===================================================================
RCS file: /home/cvs/linux-2.5/kernel/panic.c,v
retrieving revision 1.20
diff -u -u -r1.20 panic.c
--- linux/kernel/panic.c	30 May 2003 20:14:20 -0000	1.20
+++ linux/kernel/panic.c	31 May 2003 10:24:26 -0000
@@ -96,8 +96,11 @@
         disabled_wait(caller);
 #endif
 	local_irq_enable();
-	for (;;)
-		;
+	for (;;) { 
+#ifdef HAVE_EAT_KEY
+		eat_key();
+#endif
+	} 
 }
 
 /**
