Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318202AbSHMQLr>; Tue, 13 Aug 2002 12:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318212AbSHMQLr>; Tue, 13 Aug 2002 12:11:47 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:16064 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318202AbSHMQLj>;
	Tue, 13 Aug 2002 12:11:39 -0400
Date: Tue, 13 Aug 2002 09:12:22 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] NUMA-Q relocate early ioremap
Message-ID: <1992130000.1029255142@flay>
In-Reply-To: <348510000.1028591286@flay>
References: <348510000.1028591286@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This moves the early ioremap call to after cpu_online_map is initialized.
Note everything is wrapped in clustered_apic_mode, so should be safe.
Tested on NUMA-Q and std 2-way SMP through LTP. Says it's against
2.5.25, but applies to and works on 2.5.31.

Please apply,

Martin.

diff -Nur linux-2.5.25-vanilla/arch/i386/kernel/smpboot.c linux-2.5.25-patched/arch/i386/kernel/smpboot.c
--- virgin-2.5.25/arch/i386/kernel/smpboot.c	Fri Jul  5 16:42:23 2002
+++ linux-2.5.25-ioremap/arch/i386/kernel/smpboot.c	Fri Jul 12 15:55:20 2002
@@ -968,16 +968,6 @@
 {
 	int apicid, cpu, bit;
 
-        if (clustered_apic_mode && (numnodes > 1)) {
-                printk("Remapping cross-quad port I/O for %d quads\n",
-			numnodes);
-                printk("xquad_portio vaddr 0x%08lx, len %08lx\n",
-                        (u_long) xquad_portio, 
-			(u_long) numnodes * XQUAD_PORTIO_LEN);
-                xquad_portio = ioremap (XQUAD_PORTIO_BASE, 
-			numnodes * XQUAD_PORTIO_LEN);
-        }
-
 #ifdef CONFIG_MTRR
 	/*  Must be done before other processors booted  */
 	mtrr_init_boot_cpu ();
@@ -1075,6 +1065,16 @@
 
 	if (GET_APIC_ID(apic_read(APIC_ID)) != boot_cpu_physical_apicid)
 		BUG();
+
+        if (clustered_apic_mode && (numnodes > 1)) {
+                printk("Remapping cross-quad port I/O for %d quads\n",
+			numnodes);
+                printk("xquad_portio vaddr 0x%08lx, len %08lx\n",
+                        (u_long) xquad_portio, 
+			(u_long) numnodes * XQUAD_PORTIO_LEN);
+                xquad_portio = ioremap (XQUAD_PORTIO_BASE, 
+			numnodes * XQUAD_PORTIO_LEN);
+        }
 
 	/*
 	 * Scan the CPU present map and fire up the other CPUs via do_boot_cpu

