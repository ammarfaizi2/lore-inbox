Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130196AbQLET3J>; Tue, 5 Dec 2000 14:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129991AbQLET27>; Tue, 5 Dec 2000 14:28:59 -0500
Received: from [62.172.234.2] ([62.172.234.2]:61571 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129563AbQLET2u>; Tue, 5 Dec 2000 14:28:50 -0500
Date: Tue, 5 Dec 2000 18:58:15 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] setup.c cpuinfo flags notsc
In-Reply-To: <3A296529.545192C2@transmeta.com>
Message-ID: <Pine.LNX.4.21.0012051807280.996-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

Some minor mods to test12-pre5 (and earlier) arch/i386/kernel/setup.c:
please pass on to Linus if you approve.

1. Your "features" was reverted to "flags", but an extra tab is needed.

2. identify_cpu() re-evaluates x86_capability, which left cpu_has_tsc true
   (and cpu MHz shown as 0.000) in non-SMP "notsc" case: #ifdef CONFIG_TSC
   was bogus.  And set X86_CR4_TSD here when testing this cpu's capability,
   not where cpu_init() tests cpu_has_tsc (boot_cpu's adjusted capability).

I have removed the "FIX-HPA" comment line: of course, that's none of my
business, but if you approve the patch I imagine you'd want that to go too
(I agree it's a bit ugly there, but safest to disable cpu_has_tsc soonest).

Hugh

--- test12-pre5/arch/i386/kernel/setup.c	Tue Dec  5 17:25:55 2000
+++ linux/arch/i386/kernel/setup.c	Tue Dec  5 17:56:35 2000
@@ -1999,10 +1999,14 @@
 	 * we do "generic changes."
 	 */
 
+#ifndef CONFIG_X86_TSC
 	/* TSC disabled? */
-#ifdef CONFIG_TSC
-	if ( tsc_disable )
-		clear_bit(X86_FEATURE_TSC, &c->x86_capability);
+	if ( test_bit(X86_FEATURE_TSC, &c->x86_capability) ) {
+		if (tsc_disable || !cpu_has_tsc) {
+			clear_bit(X86_FEATURE_TSC, &c->x86_capability);
+			set_in_cr4(X86_CR4_TSD);
+		}
+	}
 #endif
 
 	/* Disable the PN if appropriate */
@@ -2172,7 +2176,7 @@
 			        "fpu_exception\t: %s\n"
 			        "cpuid level\t: %d\n"
 			        "wp\t\t: %s\n"
-			        "flags\t:",
+			        "flags\t\t:",
 			     c->fdiv_bug ? "yes" : "no",
 			     c->hlt_works_ok ? "no" : "yes",
 			     c->f00f_bug ? "yes" : "no",
@@ -2218,9 +2222,7 @@
 #ifndef CONFIG_X86_TSC
 	if (tsc_disable && cpu_has_tsc) {
 		printk("Disabling TSC...\n");
-		/**** FIX-HPA: DOES THIS REALLY BELONG HERE? ****/
 		clear_bit(X86_FEATURE_TSC, boot_cpu_data.x86_capability);
-		set_in_cr4(X86_CR4_TSD);
 	}
 #endif
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
