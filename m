Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262134AbSIYWwU>; Wed, 25 Sep 2002 18:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262135AbSIYWwT>; Wed, 25 Sep 2002 18:52:19 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:54712 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262134AbSIYWwS>;
	Wed, 25 Sep 2002 18:52:18 -0400
Date: Wed, 25 Sep 2002 15:53:44 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] NUMA-Q fixes
Message-ID: <268530000.1032994424@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below are three tiny fixes that only affect NUMA-Q.

1. Remove the const that someone incorrectly stuck in there, it type conflicts.
	Alan has a better plan for fixing this long term, but this fixes the compile
	warning for now.

2. Move the printk of the xquad_portio setup *after* we put something in the variable
	so it actually prints something useful, not 0 ;-)

3. To derive the size of the xquad_portio area, multiply the number of nodes by the
	size of each nodes, not the size of two nodes (and remove define). Doh!

Please apply - thanks,

Martin.

diff -urN -X /home/mbligh/.diff.exclude virgin/arch/i386/boot/compressed/misc.c xquad_portio/arch/i386/boot/compressed/misc.c
--- virgin/arch/i386/boot/compressed/misc.c	Fri Sep 20 08:20:30 2002
+++ xquad_portio/arch/i386/boot/compressed/misc.c	Sat Sep 21 22:20:27 2002
@@ -121,7 +121,7 @@
 static int lines, cols;
 
 #ifdef CONFIG_MULTIQUAD
-static void * const xquad_portio = NULL;
+static void * xquad_portio = NULL;
 #endif
 
 #include "../../../../lib/inflate.c"
diff -urN -X /home/mbligh/.diff.exclude virgin/arch/i386/kernel/smpboot.c xquad_portio/arch/i386/kernel/smpboot.c
--- virgin/arch/i386/kernel/smpboot.c	Fri Sep 20 08:20:26 2002
+++ xquad_portio/arch/i386/kernel/smpboot.c	Sat Sep 21 22:17:03 2002
@@ -1060,11 +1060,11 @@
         if (clustered_apic_mode && (numnodes > 1)) {
                 printk("Remapping cross-quad port I/O for %d quads\n",
 			numnodes);
+                xquad_portio = ioremap (XQUAD_PORTIO_BASE, 
+			numnodes * XQUAD_PORTIO_QUAD);
                 printk("xquad_portio vaddr 0x%08lx, len %08lx\n",
                         (u_long) xquad_portio, 
-			(u_long) numnodes * XQUAD_PORTIO_LEN);
-                xquad_portio = ioremap (XQUAD_PORTIO_BASE, 
-			numnodes * XQUAD_PORTIO_LEN);
+			(u_long) numnodes * XQUAD_PORTIO_QUAD);
         }
 
 	/*
diff -urN -X /home/mbligh/.diff.exclude virgin/include/asm-i386/io.h xquad_portio/include/asm-i386/io.h
--- virgin/include/asm-i386/io.h	Fri Sep 20 08:20:25 2002
+++ xquad_portio/include/asm-i386/io.h	Sat Sep 21 22:17:49 2002
@@ -40,7 +40,6 @@
 
 #define XQUAD_PORTIO_BASE 0xfe400000
 #define XQUAD_PORTIO_QUAD 0x40000  /* 256k per quad. */
-#define XQUAD_PORTIO_LEN  0x80000  /* Only remapping first 2 quads */
 
 #ifdef __KERNEL__
 

