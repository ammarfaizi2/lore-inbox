Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274761AbRIUFna>; Fri, 21 Sep 2001 01:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274762AbRIUFnM>; Fri, 21 Sep 2001 01:43:12 -0400
Received: from donna.siteprotect.com ([64.41.120.44]:58379 "EHLO
	donna.siteprotect.com") by vger.kernel.org with ESMTP
	id <S274761AbRIUFm7>; Fri, 21 Sep 2001 01:42:59 -0400
Date: Fri, 21 Sep 2001 01:43:18 -0400 (EDT)
From: John Clemens <john@deater.net>
X-X-Sender: <john@pianoman.cluster.toy>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Enabling SSE on K7's with broken BIOS's..
Message-ID: <Pine.LNX.4.33.0109210133210.4214-100000@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is pass #2 at the patch I posted yesterday.  I've managed to narrow
it down to the one bit in the HWCR that seems to control SSE.  BIT15 in
the register must be 0 to enable SSE.  Since I'm now only changing this
one bit, and only if SSE isn't enabled already, and only if it's a model 6
or 7 CPU, I think it's safe.  This patch is necessary for me to use SSE on
my HP Duron notebook.

It works for me, under light testing.  I'd like others in my situation to
test (most probably those with HP Athlon4/Duron laptops and those plugging
new AthlonMP's and XP's into old motherboards).

I'll wait for people to test/complain before i officially submit to Alan
and Linus.

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

