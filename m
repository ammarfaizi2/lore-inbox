Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274298AbRITDap>; Wed, 19 Sep 2001 23:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274299AbRITDag>; Wed, 19 Sep 2001 23:30:36 -0400
Received: from donna.siteprotect.com ([64.41.120.44]:10769 "EHLO
	donna.siteprotect.com") by vger.kernel.org with ESMTP
	id <S274298AbRITDaW>; Wed, 19 Sep 2001 23:30:22 -0400
Date: Wed, 19 Sep 2001 23:30:41 -0400 (EDT)
From: John Clemens <john@deater.net>
X-X-Sender: <john@pianoman.cluster.toy>
To: <linux-kernel@vger.kernel.org>
Subject: [prelim-PATCH] Enable SSE on K7 without BIOS support. 
Message-ID: <Pine.LNX.4.33.0109192306150.371-100000@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This following patch enables SSE on K7 systems that:

a) support SSE (are Palomino or Morgan cores)
b) Have broken BIOS's that don't enable SSE for you.

Appearently, SSE support is not enabled by default on Athlon4/MP's and
model 7 Durons, and the BIOS is supposted to enable the feature.  My
laptop's BIOS doesn't do this, so it became a moral crusade to figure out
why I couldn't use SSE.  On a hint from an AMD support person who told me
register 15 needs to be 0 to enable SSE, and an obscure web reference to
a "Athlon HWCR MSR15", we've discovered that writing '0' to the MSR
0xc0010015 enables SSE.

While this appears to work for me, I'd like for people to test this on
machines that -do- currently support SSE on the k7 and make sure it
doesn't break anything.

Also weird, is that before writing a '0' to this MSR, the MSR reads
0x00000000-0x04009000.  After writing a 0, it reads 0x00000000-0x04000000,
and SSE seems to work fine.  What those other flags do, and why it remains
set even after writing a 0, I have no idea without proper documentation.
I'd like to know what other people's MSR15 values are on K7's.

Vince Weaver (weave@deater.net) co-authored this patch.

feedback appreciated...
john.c

-- 
John Clemens          http://www.deater.net/john
john@deater.net     ICQ: 7175925, IM: PianoManO8
      "I Hate Quotes" -- Samuel L. Clemens

diff -u --recursive linux-orig/arch/i386/kernel/setup.c linux/arch/i386/kernel/setup.c
--- linux-orig/arch/i386/kernel/setup.c	Wed Sep 19 22:49:11 2001
+++ linux/arch/i386/kernel/setup.c	Wed Sep 19 22:51:34 2001
@@ -1272,6 +1272,14 @@

 		case 6:	/* An Athlon/Duron. We can trust the BIOS probably */
 			mcheck_init(c);
+			if (c->x86_model == 6 || c->x86_model == 7) {
+			        rdmsr(MSR_K7_HWCR, l, h);
+				if ( (h|l) != 0 ) {
+					printk(KERN_INFO "Palomino/Morgan: Enabling K7/SSE support (your BIOS didn't..)\n");
+					wrmsr(MSR_K7_HWCR, 0, 0);
+					set_bit(X86_FEATURE_XMM, &c->x86_capability);
+				}
+			}
 			break;
 	}

diff -u --recursive linux-orig/include/asm-i386/msr.h linux/include/asm-i386/msr.h
--- linux-orig/include/asm-i386/msr.h	Wed Sep 19 22:49:27 2001
+++ linux/include/asm-i386/msr.h	Wed Sep 19 22:57:32 2001
@@ -81,6 +81,7 @@

 #define MSR_K7_EVNTSEL0			0xC0010000
 #define MSR_K7_PERFCTR0			0xC0010004
+#define MSR_K7_HWCR			0xC0010015

 /* Centaur-Hauls/IDT defined MSRs. */
 #define MSR_IDT_FCR1			0x107

