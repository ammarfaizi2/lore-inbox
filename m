Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266809AbSKUPvm>; Thu, 21 Nov 2002 10:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266816AbSKUPvl>; Thu, 21 Nov 2002 10:51:41 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:45203 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266809AbSKUPvk>;
	Thu, 21 Nov 2002 10:51:40 -0500
Date: Thu, 21 Nov 2002 15:56:49 GMT
Message-Id: <200211211556.gALFunG3014402@noodles.internal>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, alan@redhat.com
From: davej@codemonkey.org.uk
Subject: A new Athlon 'bug'.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Very recent Athlons (Model 8 stepping 1 and above) (XPs/MPs and mobiles)
have an interesting problem.  Certain bits in the CLK_CTL register need
to be programmed differently to those in earlier models. The problem arises
when people plug these new CPUs into boards running BIOSes that are unaware
of this fact.

The fix is to reprogram CLK_CTL to 200xxxxx instead of 0x600xxxxx as it was
in previous models. The AMD folks have found that this improves stability.

The patch below does this reprogramming if an affected model/bios is
detected. 

I'm interested if someone with an affected model could run some
benchmarks before and after to also see if this affects performance.

		Dave

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/cpu/amd.c linux-2.5/arch/i386/kernel/cpu/amd.c
--- bk-linus/arch/i386/kernel/cpu/amd.c	2002-11-21 02:09:31.000000000 +0000
+++ linux-2.5/arch/i386/kernel/cpu/amd.c	2002-11-21 15:31:56.000000000 +0000
@@ -164,12 +164,23 @@ static void __init init_amd(struct cpuin
 					set_bit(X86_FEATURE_XMM, c->x86_capability);
 				}
 			}
-			break;
 
+			/* It's been determined by AMD that Athlons since model 8 stepping 1
+			 * are more robust with CLK_CTL set to 200xxxxx instead of 600xxxxx
+			 * As per AMD technical note 27212 0.2
+			 */
+			if ((c->x86_model == 8 && c->x86_mask>=1) || (c->x86_model > 8)) {
+				rdmsr(MSR_K7_CLK_CTL, l, h);
+				if ((l & 0xfff00000) != 0x20000000) {
+					printk ("CPU: CLK_CTL MSR was %x. Reprogramming to %x\n", l,
+						((l & 0x000fffff)|0x20000000));
+					wrmsr(MSR_K7_CLK_CTL, (l & 0x000fffff)|0x20000000, h);
+				}
+			}
+			break;
 	}
 
 	display_cacheinfo(c);
-//	return r;
 }
 
 static unsigned int amd_size_cache(struct cpuinfo_x86 * c, unsigned int size)
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/include/asm-i386/msr.h linux-2.5/include/asm-i386/msr.h
--- bk-linus/include/asm-i386/msr.h	2002-11-21 02:21:51.000000000 +0000
+++ linux-2.5/include/asm-i386/msr.h	2002-11-21 15:40:18.000000000 +0000
@@ -107,6 +107,7 @@
 #define MSR_K7_PERFCTR2			0xC0010006
 #define MSR_K7_PERFCTR3			0xC0010007
 #define MSR_K7_HWCR			0xC0010015
+#define MSR_K7_CLK_CTL			0xC001001b
 #define MSR_K7_FID_VID_CTL		0xC0010041
 #define MSR_K7_VID_STATUS		0xC0010042
 

