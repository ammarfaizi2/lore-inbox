Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264329AbUEIKN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264329AbUEIKN0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 06:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264328AbUEIKNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 06:13:25 -0400
Received: from pop.gmx.net ([213.165.64.20]:30122 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264329AbUEIKNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 06:13:09 -0400
X-Authenticated: #1467763
Message-ID: <409E03C4.7080703@gmx.net>
Date: Sun, 09 May 2004 12:11:16 +0200
From: Sapier <sapier@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7b) Gecko/20040426
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Modified Longhaul Code to work with Nehemia CPU's
Content-Type: multipart/mixed;
 boundary="------------010406070807060102000301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010406070807060102000301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Modified the Kernel Longhaul driver to work now with Nehemia CPUs wich 
didn't have the max multiplier properly set. Patch works for 
2.6.4-2.6.6-rc3 (at least for me).
If anyone knows how to get information about the voltage scaling 
abilitys of nehemia please drop a note to me.
Andreas Meisinger sapier@gmx.net

--------------010406070807060102000301
Content-Type: text/plain;
 name="linux-2.6.6-rc3-longhaul_nehemia.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.6-rc3-longhaul_nehemia.patch"

--- linux/arch/i386/kernel/cpu/cpufreq/longhaul.c.orig	2004-04-25 22:28:11.000000000 +0200
+++ linux/arch/i386/kernel/cpu/cpufreq/longhaul.c	2004-04-26 01:09:58.000000000 +0200
@@ -82,6 +82,10 @@
 		if (lo & (1<<27))
 			invalue+=16;
 	}
+	if (longhaul_version==4) {
+		if (lo & (1<<27))
+			invalue+=16;
+	}
 	return eblcr_table[invalue];
 }
 
@@ -158,6 +162,22 @@
 		longhaul.bits.RevisionKey = 3;
 		wrmsrl (MSR_VIA_LONGHAUL, longhaul.val);
 		break;
+	case 4:
+		rdmsrl (MSR_VIA_LONGHAUL, longhaul.val);
+		longhaul.bits.SoftBusRatio = clock_ratio_index & 0xf;
+		longhaul.bits.SoftBusRatio4 = (clock_ratio_index & 0x10) >> 4;
+		longhaul.bits.EnableSoftBusRatio = 1;
+		
+		longhaul.bits.RevisionKey = 0x0;
+		
+		wrmsrl(MSR_VIA_LONGHAUL, longhaul.val);
+		__hlt();
+		
+		rdmsrl (MSR_VIA_LONGHAUL, longhaul.val);
+		longhaul.bits.EnableSoftBusRatio = 0;
+		longhaul.bits.RevisionKey = 0xf;
+		wrmsrl (MSR_VIA_LONGHAUL, longhaul.val);		
+		break;
 	}
 
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
@@ -207,7 +227,7 @@
 static int __init longhaul_get_ranges (void)
 {
 	struct cpuinfo_x86 *c = cpu_data;
-	unsigned long invalue;
+	unsigned long invalue,invalue2;
 	unsigned int minmult=0, maxmult=0;
 	unsigned int multipliers[32]= {
 		50,30,40,100,55,35,45,95,90,70,80,60,120,75,85,65,
@@ -234,8 +254,6 @@
 	case 2:
 		rdmsrl (MSR_VIA_LONGHAUL, longhaul.val);
 
-		//TODO: Nehemiah may have borken MaxMHzBR.
-		// need to extrapolate from FSB.
 		invalue = longhaul.bits.MaxMHzBR;
 		if (longhaul.bits.MaxMHzBR4)
 			invalue += 16;
@@ -258,6 +276,38 @@
 				break;
 		}
 		break;
+		
+	case 4:
+		rdmsrl (MSR_VIA_LONGHAUL, longhaul.val);
+		
+		//TODO: Nehemiah may have borken MaxMHzBR.
+		// need to extrapolate from FSB.
+		
+		invalue2 = longhaul.bits.MinMHzBR;
+		invalue = longhaul.bits.MaxMHzBR;
+		if (longhaul.bits.MaxMHzBR4) 
+			invalue += 16;
+		maxmult=multipliers[invalue];
+		
+		maxmult=longhaul_get_cpu_mult();
+		
+		printk(KERN_INFO PFX " invalue: %ld  maxmult: %d \n", invalue, maxmult);
+		printk(KERN_INFO PFX " invalue2: %ld \n", invalue2);
+		
+		minmult=50;
+		
+		switch (longhaul.bits.MaxMHzFSB) {
+		case 0x0:	fsb=133;
+				break;
+		case 0x1:	fsb=100;
+				break;
+		case 0x2:	printk (KERN_INFO PFX "Invalid (reserved) FSB!\n");
+			return -EINVAL;
+		case 0x3:	fsb=66;
+				break;
+		}
+		
+		break;	
 	}
 
 	dprintk (KERN_INFO PFX "MinMult=%d.%dx MaxMult=%d.%dx\n",
@@ -423,12 +473,27 @@
 		break;
 
 	case 9:
-		cpuname = "C3 'Nehemiah' [C5N]";
-		longhaul_version=2;
+		longhaul_version=4;
 		numscales=32;
-		memcpy (clock_ratio, nehemiah_clock_ratio, sizeof(nehemiah_clock_ratio));
-		memcpy (eblcr_table, nehemiah_eblcr, sizeof(nehemiah_eblcr));
+		switch (c->x86_mask) {
+		case 0 ... 1:
+			cpuname = "C3 'Nehemiah A' [C5N]";
+			memcpy (clock_ratio, nehemiah_a_clock_ratio, sizeof(nehemiah_a_clock_ratio));
+			memcpy (eblcr_table, nehemiah_a_eblcr, sizeof(nehemiah_a_eblcr));
+			break;
+		case 2 ... 4:
+			cpuname = "C3 'Nehemiah B' [C5N]";
+			memcpy (clock_ratio, nehemiah_b_clock_ratio, sizeof(nehemiah_b_clock_ratio));
+			memcpy (eblcr_table, nehemiah_b_eblcr, sizeof(nehemiah_b_eblcr));
+			break;
+		case 5 ... 15:
+			cpuname = "C3 'Nehemiah C' [C5N]";
+			memcpy (clock_ratio, nehemiah_c_clock_ratio, sizeof(nehemiah_c_clock_ratio));
+			memcpy (eblcr_table, nehemiah_c_eblcr, sizeof(nehemiah_c_eblcr));
+			break;
+		}
 		break;
+		
 
 	default:
 		cpuname = "Unknown";
--- linux/arch/i386/kernel/cpu/cpufreq/longhaul.h.orig	2004-03-11 03:55:24.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/longhaul.h	2004-04-25 23:12:39.000000000 +0200
@@ -234,14 +234,15 @@
 
 /*
  * VIA C3 Nehemiah */
-static int __initdata nehemiah_clock_ratio[32] = {
+ 
+static int __initdata nehemiah_a_clock_ratio[32] = {
 	100, /* 0000 -> 10.0x */
 	160, /* 0001 -> 16.0x */
-	-1,  /* 0010 -> RESERVED */
+	-1,  /* 0010 ->  RESERVED */
 	90,  /* 0011 ->  9.0x */
 	95,  /* 0100 ->  9.5x */
-	-1,  /* 0101 -> RESERVED */
-	-1,  /* 0110 -> RESERVED */
+	-1,  /* 0101 ->  RESERVED */
+	-1,  /* 0110 ->  RESERVED */
 	55,  /* 0111 ->  5.5x */
 	60,  /* 1000 ->  6.0x */
 	70,  /* 1001 ->  7.0x */
@@ -250,8 +251,77 @@
 	65,  /* 1100 ->  6.5x */
 	75,  /* 1101 ->  7.5x */
 	85,  /* 1110 ->  8.5x */
-	120, /* 1111 ->  12.0x */
+	120, /* 1111 -> 12.0x */
+	100, /* 0000 -> 10.0x */
+	-1,  /* 0001 -> RESERVED */
+	120, /* 0010 -> 12.0x */
+	90,  /* 0011 ->  9.0x */
+	105, /* 0100 -> 10.5x */
+	115, /* 0101 -> 11.5x */
+	125, /* 0110 -> 12.5x */
+	135, /* 0111 -> 13.5x */
+	140, /* 1000 -> 14.0x */
+	150, /* 1001 -> 15.0x */
+	160, /* 1010 -> 16.0x */
+	130, /* 1011 -> 13.0x */
+	145, /* 1100 -> 14.5x */
+	155, /* 1101 -> 15.5x */
+	-1,  /* 1110 -> RESERVED (13.0x) */
+	120, /* 1111 -> 12.0x */
+};
+
+static int __initdata  nehemiah_b_clock_ratio[32] = {
+	100, /* 0000 -> 10.0x */
+	160, /* 0001 -> 16.0x */
+	-1,  /* 0010 ->  RESERVED */
+	90,  /* 0011 ->  9.0x */
+	95,  /* 0100 ->  9.5x */
+	-1,  /* 0101 ->  RESERVED */
+	-1,  /* 0110 ->  RESERVED */
+	55,  /* 0111 ->  5.5x */
+	60,  /* 1000 ->  6.0x */
+	70,  /* 1001 ->  7.0x */
+	80,  /* 1010 ->  8.0x */
+	50,  /* 1011 ->  5.0x */
+	65,  /* 1100 ->  6.5x */
+	75,  /* 1101 ->  7.5x */
+	85,  /* 1110 ->  8.5x */
+	120, /* 1111 -> 12.0x */
+	100, /* 0000 -> 10.0x */
+	110, /* 0001 -> 11.0x */
+	120, /* 0010 -> 12.0x */
+	90,  /* 0011 ->  9.0x */
+	105, /* 0100 -> 10.5x */
+	115, /* 0101 -> 11.5x */
+	125, /* 0110 -> 12.5x */
+	135, /* 0111 -> 13.5x */
+	140, /* 1000 -> 14.0x */
+	150, /* 1001 -> 15.0x */
+	160, /* 1010 -> 16.0x */
+	130, /* 1011 -> 13.0x */
+	145, /* 1100 -> 14.5x */
+	155, /* 1101 -> 15.5x */
+	-1,  /* 1110 -> RESERVED (13.0x) */
+	120, /* 1111 -> 12.0x */
+};
 
+static int __initdata  nehemiah_c_clock_ratio[32] = {
+	100, /* 0000 -> 10.0x */
+	160, /* 0001 -> 16.0x */
+	40,  /* 0010 ->  RESERVED */
+	90,  /* 0011 ->  9.0x */
+	95,  /* 0100 ->  9.5x */
+	-1,  /* 0101 ->  RESERVED */
+	45,  /* 0110 ->  RESERVED */
+	55,  /* 0111 ->  5.5x */
+	60,  /* 1000 ->  6.0x */
+	70,  /* 1001 ->  7.0x */
+	80,  /* 1010 ->  8.0x */
+	50,  /* 1011 ->  5.0x */
+	65,  /* 1100 ->  6.5x */
+	75,  /* 1101 ->  7.5x */
+	85,  /* 1110 ->  8.5x */
+	120, /* 1111 -> 12.0x */
 	100, /* 0000 -> 10.0x */
 	110, /* 0001 -> 11.0x */
 	120, /* 0010 -> 12.0x */
@@ -266,18 +336,53 @@
 	130, /* 1011 -> 13.0x */
 	145, /* 1100 -> 14.5x */
 	155, /* 1101 -> 15.5x */
-	-1,  /* 1110 -> RESERVED */
+	-1,  /* 1110 -> RESERVED (13.0x) */
 	120, /* 1111 -> 12.0x */
 };
 
-static int __initdata nehemiah_eblcr[32] = {
+static int __initdata nehemiah_a_eblcr[32] = {
 	50,  /* 0000 ->  5.0x */
 	160, /* 0001 -> 16.0x */
-	-1,  /* 0010 -> RESERVED */
+	-1,  /* 0010 ->  RESERVED */
 	100, /* 0011 -> 10.0x */
 	55,  /* 0100 ->  5.5x */
-	-1,  /* 0101 -> RESERVED */
-	-1,  /* 0110 -> RESERVED */
+	-1,  /* 0101 ->  RESERVED */
+	-1,  /* 0110 ->  RESERVED */
+	95,  /* 0111 ->  9.5x */
+	90,  /* 1000 ->  9.0x */
+	70,  /* 1001 ->  7.0x */
+	80,  /* 1010 ->  8.0x */
+	60,  /* 1011 ->  6.0x */
+	120, /* 1100 -> 12.0x */
+	75,  /* 1101 ->  7.5x */
+	85,  /* 1110 ->  8.5x */
+	65,  /* 1111 ->  6.5x */
+	90,  /* 0000 ->  9.0x */
+	-1,  /* 0001 -> RESERVED */
+	120, /* 0010 -> 12.0x */
+	100, /* 0011 -> 10.0x */
+	135, /* 0100 -> 13.5x */
+	115, /* 0101 -> 11.5x */
+	125, /* 0110 -> 12.5x */
+	105, /* 0111 -> 10.5x */
+	130, /* 1000 -> 13.0x */
+	150, /* 1001 -> 15.0x */
+	160, /* 1010 -> 16.0x */
+	140, /* 1011 -> 14.0x */
+	120, /* 1100 -> 12.0x */
+	155, /* 1101 -> 15.5x */
+	-1,  /* 1110 -> RESERVED (13.0x) */
+	145 /* 1111 -> 14.5x */
+   /* end of table  */
+};
+static int __initdata nehemiah_b_eblcr[32] = {
+	50,  /* 0000 ->  5.0x */
+	160, /* 0001 -> 16.0x */
+	-1,  /* 0010 ->  RESERVED */
+	100, /* 0011 -> 10.0x */
+	55,  /* 0100 ->  5.5x */
+	-1,  /* 0101 ->  RESERVED */
+	-1,  /* 0110 ->  RESERVED */
 	95,  /* 0111 ->  9.5x */
 	90,  /* 1000 ->  9.0x */
 	70,  /* 1001 ->  7.0x */
@@ -287,7 +392,6 @@
 	75,  /* 1101 ->  7.5x */
 	85,  /* 1110 ->  8.5x */
 	65,  /* 1111 ->  6.5x */
-
 	90,  /* 0000 ->  9.0x */
 	110, /* 0001 -> 11.0x */
 	120, /* 0010 -> 12.0x */
@@ -302,9 +406,46 @@
 	140, /* 1011 -> 14.0x */
 	120, /* 1100 -> 12.0x */
 	155, /* 1101 -> 15.5x */
-	-1,  /* 1110 -> RESERVED */
-	-1,  /* 1111 -> RESERVED */
+	-1,  /* 1110 -> RESERVED (13.0x) */
+	145 /* 1111 -> 14.5x */
+	   /* end of table  */
 };
+static int __initdata nehemiah_c_eblcr[32] = {
+	50,  /* 0000 ->  5.0x */
+	160, /* 0001 -> 16.0x */
+	40,  /* 0010 ->  RESERVED */
+	100, /* 0011 -> 10.0x */
+	55,  /* 0100 ->  5.5x */
+	-1,  /* 0101 ->  RESERVED */
+	45,  /* 0110 ->  RESERVED */
+	95,  /* 0111 ->  9.5x */
+	90,  /* 1000 ->  9.0x */
+	70,  /* 1001 ->  7.0x */
+	80,  /* 1010 ->  8.0x */
+	60,  /* 1011 ->  6.0x */
+	120, /* 1100 -> 12.0x */
+	75,  /* 1101 ->  7.5x */
+	85,  /* 1110 ->  8.5x */
+	65,  /* 1111 ->  6.5x */
+	90,  /* 0000 ->  9.0x */
+	110, /* 0001 -> 11.0x */
+	120, /* 0010 -> 12.0x */
+	100, /* 0011 -> 10.0x */
+	135, /* 0100 -> 13.5x */
+	115, /* 0101 -> 11.5x */
+	125, /* 0110 -> 12.5x */
+	105, /* 0111 -> 10.5x */
+	130, /* 1000 -> 13.0x */
+	150, /* 1001 -> 15.0x */
+	160, /* 1010 -> 16.0x */
+	140, /* 1011 -> 14.0x */
+	120, /* 1100 -> 12.0x */
+	155, /* 1101 -> 15.5x */
+	-1,  /* 1110 -> RESERVED (13.0x) */
+	145 /* 1111 -> 14.5x */
+	  /* end of table  */
+};
+
 /* 
  * Voltage scales. Div/Mod by 1000 to get actual voltage.
  * Which scale to use depends on the VRM type in use.

--------------010406070807060102000301--
