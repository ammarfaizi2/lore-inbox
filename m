Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbULAFJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbULAFJM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 00:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbULAFJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 00:09:12 -0500
Received: from 70-56-133-193.albq.qwest.net ([70.56.133.193]:18390 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261168AbULAFJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 00:09:01 -0500
Date: Tue, 30 Nov 2004 22:07:55 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andrew Morton <akpm@osdl.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       linux@rainbow-software.org, Dave Jones <davej@redhat.com>
Subject: [PATCH] Cyrix MII cpuid returns stale %ecx
Message-ID: <Pine.LNX.4.61.0411302125350.1243@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is for the following bug, thanks to Ondrej Zary for 
reporting, testing and submitting a patch.

http://bugzilla.kernel.org/show_bug.cgi?id=3767

It appears that the Cyrix MII won't touch %ecx at all resulting in stale 
data being returned as extended attributes, so clear ecx before issuing 
the cpuid. I have also made the capability print code display all the 
capability words for easier debugging in future.

Signed-off-by: Zwane Mwaikambo <zwane@linuxpower.ca>

Index: linux-2.6.10-rc2-mm4/include/asm-i386/processor.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc2-mm4/include/asm-i386/processor.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 processor.h
--- linux-2.6.10-rc2-mm4/include/asm-i386/processor.h	30 Nov 2004 18:52:25 -0000	1.1.1.1
+++ linux-2.6.10-rc2-mm4/include/asm-i386/processor.h	1 Dec 2004 04:25:11 -0000
@@ -126,6 +126,8 @@ extern void dodgy_tsc(void);
 
 /*
  * Generic CPUID function
+ * clear %ecx since some cpus (Cyrix MII) do not set or clear %ecx
+ * resulting in stale register contents being returned.
  */
 static inline void cpuid(int op, int *eax, int *ebx, int *ecx, int *edx)
 {
@@ -134,7 +136,7 @@ static inline void cpuid(int op, int *ea
 		  "=b" (*ebx),
 		  "=c" (*ecx),
 		  "=d" (*edx)
-		: "0" (op));
+		: "0" (op), "c"(0));
 }
 
 /*
Index: linux-2.6.10-rc2-mm4/arch/i386/kernel/cpu/common.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc2-mm4/arch/i386/kernel/cpu/common.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 common.c
--- linux-2.6.10-rc2-mm4/arch/i386/kernel/cpu/common.c	30 Nov 2004 18:52:19 -0000	1.1.1.1
+++ linux-2.6.10-rc2-mm4/arch/i386/kernel/cpu/common.c	1 Dec 2004 04:18:46 -0000
@@ -334,21 +334,19 @@ void __init identify_cpu(struct cpuinfo_
 
 	generic_identify(c);
 
-	printk(KERN_DEBUG "CPU: After generic identify, caps: %08lx %08lx %08lx %08lx\n",
-		c->x86_capability[0],
-		c->x86_capability[1],
-		c->x86_capability[2],
-		c->x86_capability[3]);
+	printk(KERN_DEBUG "CPU: After generic identify, caps:");
+	for (i = 0; i < NCAPINTS; i++)
+		printk(" %08lx", c->x86_capability[i]);
+	printk("\n");
 
 	if (this_cpu->c_identify) {
 		this_cpu->c_identify(c);
 
-	printk(KERN_DEBUG "CPU: After vendor identify, caps:  %08lx %08lx %08lx %08lx\n",
-		c->x86_capability[0],
-		c->x86_capability[1],
-		c->x86_capability[2],
-		c->x86_capability[3]);
-}
+		printk(KERN_DEBUG "CPU: After vendor identify, caps:");
+		for (i = 0; i < NCAPINTS; i++)
+			printk(" %08lx", c->x86_capability[i]);
+		printk("\n");
+	}
 
 	/*
 	 * Vendor-specific initialization.  In this section we
@@ -398,11 +396,10 @@ void __init identify_cpu(struct cpuinfo_
 
 	/* Now the feature flags better reflect actual CPU features! */
 
-	printk(KERN_DEBUG "CPU: After all inits, caps:        %08lx %08lx %08lx %08lx\n",
-	       c->x86_capability[0],
-	       c->x86_capability[1],
-	       c->x86_capability[2],
-	       c->x86_capability[3]);
+	printk(KERN_DEBUG "CPU: After all inits, caps:");
+	for (i = 0; i < NCAPINTS; i++)
+		printk(" %08lx", c->x86_capability[i]);
+	printk("\n");
 
 	/*
 	 * On SMP, boot_cpu_data holds the common feature set between
