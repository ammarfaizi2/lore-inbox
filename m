Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273800AbRIXFT0>; Mon, 24 Sep 2001 01:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273801AbRIXFTQ>; Mon, 24 Sep 2001 01:19:16 -0400
Received: from donna.siteprotect.com ([64.41.120.44]:5905 "EHLO
	donna.siteprotect.com") by vger.kernel.org with ESMTP
	id <S273800AbRIXFTH>; Mon, 24 Sep 2001 01:19:07 -0400
Date: Mon, 24 Sep 2001 01:19:19 -0400 (EDT)
From: John Clemens <john@deater.net>
X-X-Sender: <john@pianoman.cluster.toy>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Enable SSE on K7's with old/broken BIOS's. 
In-Reply-To: <E15lJDP-0000qe-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0109240106440.6419-100000@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, Alan..

Please consider applying the attached patch to the mainstream kernel(s).
It enables SSE support on Athlon4/MP/XP (later model) Athlon's if the BIOS
does not.  This is done by zero-ing bit 15 of the Athlon's HWCR.  The
patch has been tested for a few days by me and a few other people with
AthlonMP's and Athlon4's, with no negative reports.

It's a very simple patch, please consider applying.

john.c

-- 
John Clemens          http://www.deater.net/john
john@deater.net     ICQ: 7175925, IM: PianoManO8
      "I Hate Quotes" -- Samuel L. Clemens

diff -u --recursive linux-orig/arch/i386/kernel/setup.c linux/arch/i386/kernel/setup.c
--- linux-orig/arch/i386/kernel/setup.c	Wed Sep 19 22:49:11 2001
+++ linux/arch/i386/kernel/setup.c	Fri Sep 21 01:23:22 2001
@@ -1272,6 +1272,21 @@

 		case 6:	/* An Athlon/Duron. We can trust the BIOS probably */
 			mcheck_init(c);
+
+	                /* Bit 15 of Athlon specific MSR 15, needs to be 0
+			 * to enable SSE on Palomino/Morgan CPU's.
+			 * If the BIOS didn't enable it already, enable it
+			 * here.
+			 */
+			if (c->x86_model == 6 || c->x86_model == 7) {
+				if (!test_bit(X86_FEATURE_XMM, &c->x86_capability)) {
+					printk(KERN_INFO "Enabling K7/SSE support, since BIOS did not\n");
+				        rdmsr(MSR_K7_HWCR, l, h);
+				        l &= ~0x00008000;
+					wrmsr(MSR_K7_HWCR, l, h);
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

