Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278879AbRKSNuq>; Mon, 19 Nov 2001 08:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278911AbRKSNuh>; Mon, 19 Nov 2001 08:50:37 -0500
Received: from ns.suse.de ([213.95.15.193]:6660 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S278879AbRKSNu2>;
	Mon, 19 Nov 2001 08:50:28 -0500
Date: Mon, 19 Nov 2001 14:50:26 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Clean up Machine Check init.
Message-ID: <Pine.LNX.4.30.0111191448250.22614-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus.
 Patch below removes multiple calls to mcheck_init from vendor
specific setup, as mcheck_init() does vendor checking itself
and does 'the right thing' on chips without it.

hand-editted old diff, still applies to pre6.

regards,
Dave.

diff -urN --exclude-from=/home/davej/.exclude linux-2.4.14-pre6/arch/i386/kernel/setup.c linux-2.4.13-ac6/arch/i386/kernel/setup.c
--- linux-2.4.14-pre6/arch/i386/kernel/setup.c	Sat Nov  3 00:08:02 2001
+++ linux-2.4.13-ac6/arch/i386/kernel/setup.c	Sat Nov  3 00:24:55 2001
@@ -1251,7 +1309,6 @@
 			break;

 		case 6:	/* An Athlon/Duron. We can trust the BIOS probably */
-			mcheck_init(c);
 			break;
 	}

@@ -1879,7 +1936,6 @@
 				c->x86_cache_size = (cc>>24)+(dd>>24);
 			}
 			sprintf( c->x86_model_id, "WinChip %s", name );
-			mcheck_init(c);
 			break;

 		case 6:
@@ -2165,7 +2231,6 @@
 		strcpy(c->x86_model_id, p);

 	/* Enable MCA if available */
-	mcheck_init(c);
 }

 void __init get_cpu_vendor(struct cpuinfo_x86 *c)
@@ -2546,7 +2610,7 @@
 		init_rise(c);
 		break;
 	}
-
+
 	printk(KERN_DEBUG "CPU: After vendor init, caps: %08x %08x %08x %08x\n",
 	       c->x86_capability[0],
 	       c->x86_capability[1],
@@ -2573,6 +2637,9 @@
 	/* Disable the PN if appropriate */
 	squash_the_stupid_serial_number(c);

+	/* Init Machine Check Exception if available. */
+	mcheck_init(c);
+
 	/* If the model name is still unset, do table lookup. */
 	if ( !c->x86_model_id[0] ) {
 		char *p;


-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

