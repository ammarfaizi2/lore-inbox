Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbSI3WHw>; Mon, 30 Sep 2002 18:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261352AbSI3WHw>; Mon, 30 Sep 2002 18:07:52 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:30411 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261346AbSI3WHt>;
	Mon, 30 Sep 2002 18:07:49 -0400
Date: Mon, 30 Sep 2002 23:15:36 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br
Subject: Re: CPU/cache detection wrong
Message-ID: <20020930221536.GA6987@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alexander Hoogerhuis <alexh@ihatent.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	marcelo@conectiva.com.br
References: <m3hegaxpp0.fsf@lapper.ihatent.com> <1033403655.16933.20.camel@irongate.swansea.linux.org.uk> <m3wup3bcgb.fsf@lapper.ihatent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3wup3bcgb.fsf@lapper.ihatent.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2002 at 07:43:16PM +0200, Alexander Hoogerhuis wrote:

 > PU: Before vendor init, caps: 3febf9ff 00000000 00000000, vendor = 0
 > Cache info byte: 50

Instruction TLB (ignored)

 > Cache info byte: 5B

Data TLB (ignored)

 > Cache info byte: 66

8K L1 data cache
 
 > Cache info byte: 00
 > Cache info byte: 00
 > Cache info byte: 00
 > Cache info byte: 00
 > Cache info byte: 00
 > Cache info byte: 00
 > Cache info byte: 00
 > Cache info byte: 00

Null
 
 > Cache info byte: 40

No 3rd level cache.

 > Cache info byte: 70

12K-uops trace cache

 > Cache info byte: 7B

512K L2 cache

 > Cache info byte: 00

Null.
 
 > CPU: L1 I cache: 0K, L1 D cache: 8K
 > CPU: L2 cache: 512K

So all is correct, except for the missing trace cache entries.

Patch below adds several missing descriptors, fixes up
an errata workaround, and adds reporting for the trace cache.
I've no Intel hardware to test this code with, so if people can
make sure I've not broken anything, that'd be good (I hate touching this code).

Alex, with this patch, you should see..

CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K

Confirmed ?

		Dave

diff -urpN --exclude-from=/home/davej/.exclude linux-2.4.20-pre8/arch/i386/kernel/setup.c linux-2.4.20-pre8-leakfix/arch/i386/kernel/setup.c
--- linux-2.4.20-pre8/arch/i386/kernel/setup.c	2002-09-26 15:29:12.000000000 +0100
+++ linux-2.4.20-pre8-leakfix/arch/i386/kernel/setup.c	2002-09-30 23:03:04.000000000 +0100
@@ -1256,15 +1256,6 @@ static void __init display_cacheinfo(str
 			l2size = 256;
 	}
 
-	/* Intel PIII Tualatin. This comes in two flavours.
-	 * One has 256kb of cache, the other 512. We have no way
-	 * to determine which, so we use a boottime override
-	 * for the 512kb model, and assume 256 otherwise.
-	 */
-	if ((c->x86_vendor == X86_VENDOR_INTEL) && (c->x86 == 6) &&
-		(c->x86_model == 11) && (l2size == 0))
-		l2size = 256;
-
 	/* VIA C3 CPUs (670-68F) need further shifting. */
 	if (c->x86_vendor == X86_VENDOR_CENTAUR && (c->x86 == 6) &&
 		((c->x86_model == 7) || (c->x86_model == 8))) {
@@ -2180,6 +2171,7 @@ extern void trap_init_f00f_bug(void);
 #define LVL_1_DATA      2
 #define LVL_2           3
 #define LVL_3           4
+#define LVL_TRACE       5
 
 struct _cache_table
 {
@@ -2199,6 +2191,8 @@ static struct _cache_table cache_table[]
 	{ 0x23, LVL_3,      1024 },
 	{ 0x25, LVL_3,      2048 },
 	{ 0x29, LVL_3,      4096 },
+	{ 0x39, LVL_2,      128 },
+	{ 0x3C, LVL_2,      256 },
 	{ 0x41, LVL_2,      128 },
 	{ 0x42, LVL_2,      256 },
 	{ 0x43, LVL_2,      512 },
@@ -2207,11 +2201,15 @@ static struct _cache_table cache_table[]
 	{ 0x66, LVL_1_DATA, 8 },
 	{ 0x67, LVL_1_DATA, 16 },
 	{ 0x68, LVL_1_DATA, 32 },
+	{ 0x70, LVL_TRACE,  12 },
+	{ 0x71, LVL_TRACE,  16 },
+	{ 0x72, LVL_TRACE,  32 },
 	{ 0x79, LVL_2,      128 },
 	{ 0x7A, LVL_2,      256 },
 	{ 0x7B, LVL_2,      512 },
 	{ 0x7C, LVL_2,      1024 },
 	{ 0x82, LVL_2,      256 },
+	{ 0x83, LVL_2,      512 },
 	{ 0x84, LVL_2,      1024 },
 	{ 0x85, LVL_2,      2048 },
 	{ 0x00, 0, 0}
@@ -2219,7 +2217,7 @@ static struct _cache_table cache_table[]
 
 static void __init init_intel(struct cpuinfo_x86 *c)
 {
-	unsigned int l1i = 0, l1d = 0, l2 = 0, l3 = 0; /* Cache sizes */
+	unsigned int trace = 0, l1i = 0, l1d = 0, l2 = 0, l3 = 0; /* Cache sizes */
 	char *p = NULL;
 #ifndef CONFIG_X86_F00F_WORKS_OK
 	static int f00f_workaround_enabled = 0;
@@ -2279,8 +2277,10 @@ static void __init init_intel(struct cpu
 						case LVL_3:
 							l3 += cache_table[k].size;
 							break;
+						case LVL_TRACE:
+							trace += cache_table[k].size;
+							break;
 						}
-
 						break;
 					}
 
@@ -2288,9 +2288,25 @@ static void __init init_intel(struct cpu
 				}
 			}
 		}
-		if ( l1i || l1d )
-			printk(KERN_INFO "CPU: L1 I cache: %dK, L1 D cache: %dK\n",
-			       l1i, l1d);
+
+		/* Intel PIII Tualatin. This comes in two flavours.
+		 * One has 256kb of cache, the other 512. We have no way
+		 * to determine which, so we use a boottime override
+		 * for the 512kb model, and assume 256 otherwise.
+		 */
+		if ((c->x86 == 6) && (c->x86_model == 11) && (l2 == 0))
+			l2 = 256;
+		/* Allow user to override all this if necessary. */
+		if (cachesize_override != -1)
+			l2 = cachesize_override;
+
+		if ( trace )
+			printk (KERN_INFO "CPU: Trace cache: %dK uops", trace);
+		else if ( l1i )
+			printk (KERN_INFO "CPU: L1 I cache: %dK", l1i);
+		if ( l1d )
+			printk(", L1 D cache: %dK\n", l1d);
+
 		if ( l2 )
 			printk(KERN_INFO "CPU: L2 cache: %dK\n", l2);
 		if ( l3 )

-- 
| Dave Jones.        http://www.codemonkey.org.uk
