Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278701AbRKSNSN>; Mon, 19 Nov 2001 08:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278714AbRKSNSD>; Mon, 19 Nov 2001 08:18:03 -0500
Received: from ns.suse.de ([213.95.15.193]:41999 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S278701AbRKSNRt>;
	Mon, 19 Nov 2001 08:17:49 -0500
Date: Mon, 19 Nov 2001 14:17:48 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] K6-2 Write allocate bug.
Message-ID: <Pine.LNX.4.30.0111191349370.22614-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,
 Patch below reformats some ugly compound ifs, and in the process
fixes up a bug where we end up poking the WHCR in old-style and new-style
on some K6-2's (Due to a missing (c->x86_mask>7) (See 2nd hunk of patch).

regards,

Dave.

diff -urN --exclude-from=/home/davej/.exclude linux-2.4.15-pre5/arch/i386/kernel/setup.c linux-2.4.15-pre5-dj/arch/i386/kernel/setup.c
--- linux-2.4.15-pre5/arch/i386/kernel/setup.c	Mon Nov 19 12:08:00 2001
+++ linux-2.4.15-pre5-dj/arch/i386/kernel/setup.c	Mon Nov 19 12:22:26 2001
@@ -1233,13 +1233,12 @@
 			}

 			/* K6 with old style WHCR */
-			if( c->x86_model < 8 ||
-				(c->x86_model== 8 && c->x86_mask < 8))
-			{
+			if (c->x86_model < 8 ||
+			   (c->x86_model== 8 && c->x86_mask < 8)) {
 				/* We can only write allocate on the low 508Mb */
 				if(mbytes>508)
 					mbytes=508;
-
+
 				rdmsr(MSR_K6_WHCR, l, h);
 				if ((l&0x0000FFFF)==0) {
 					unsigned long flags;
@@ -1250,14 +1249,14 @@
 					local_irq_restore(flags);
 					printk(KERN_INFO "Enabling old style K6 write allocation for %d Mb\n",
 						mbytes);
-
 				}
 				break;
 			}
-			if (c->x86_model == 8 || c->x86_model == 9 || c->x86_model == 13)
-			{
+
+			if ((c->x86_model == 8 && c->x86_mask >7) ||
+			     c->x86_model == 9 || c->x86_model == 13) {
 				/* The more serious chips .. */
-
+
 				if(mbytes>4092)
 					mbytes=4092;

@@ -1274,10 +1273,8 @@
 				}

 				/*  Set MTRR capability flag if appropriate */
-				if ( (c->x86_model == 13) ||
-				     (c->x86_model == 9) ||
-				     ((c->x86_model == 8) &&
-				     (c->x86_mask >= 8)) )
+				if (c->x86_model == 13 || c->x86_model == 9 ||
+				   (c->x86_model == 8 && c->x86_mask >= 8))
 					set_bit(X86_FEATURE_K6_MTRR, &c->x86_capability);
 				break;
 			}


-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

