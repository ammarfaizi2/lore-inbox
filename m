Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319035AbSH2BSv>; Wed, 28 Aug 2002 21:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319044AbSH2BSv>; Wed, 28 Aug 2002 21:18:51 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:19388 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319035AbSH2BSt>; Wed, 28 Aug 2002 21:18:49 -0400
Subject: [FTF][PATCH] linux-2.4.20-pre5_bad-tsc_A0
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, pavel@elf.ucw.cz,
       andrea <andrea@suse.de>, Mikael Pettersson <mikpe@csd.uu.se>,
       msw@redhat.com, Ulrich Drepper <drepper@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 28 Aug 2002 18:20:07 -0700
Message-Id: <1030584008.3056.53.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FTF = Fan The Flames :)

Hi all, 
	Since there are some folks who felt this could still be useful as a
boot option, here is the "badtsc" half of my earlier tsc-disable patch.
Briefly, the patch keeps the kernel from using possibly unsynced TSCs
for gettimeofday calculations, while sill allowing userspace to read the
TSCs without warning. 

Personally, I've been swayed by Andrea that this isn't the proper
solution to keep user-space apps that blindly use the rdtsc instruction
from crashing when the TSCs are disabled. Instead I feel forcing apps
(and i686 compiled glibc, <nudge, nudge, Ulrich> ;) to check the CR4 for
availability is the proper solution. 

However, if one wants to still use the TSCs from userspace, for
statistical purposes only, with the understanding that values read may
not be sane, this patch will let them do so by passing "badtsc" as a
boot option. 

As long as folks still seem interested in this, I'll keep on maintaining
it, but if you feel it should just die, let me know.

thanks
-john


diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Wed Aug 28 18:17:53 2002
+++ b/arch/i386/kernel/time.c	Wed Aug 28 18:17:53 2002
@@ -70,6 +70,9 @@
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
 
+/*boot option flag to keep gettimeofday from using do_fastgettimeoffset */
+static int  bad_tsc __initdata = 0;
+
 static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
 
 /* Cached *multiplier* to convert TSC counts to microseconds.
@@ -637,6 +640,18 @@
 	return 0;
 }
 
+#ifndef CONFIG_X86_TSC
+/* badtsc boot option: Used to keep do_gettimeofday from 
+ * using do_fast_gettimeoffset()
+ */
+static int __init badtsc_setup(char *str)
+{
+	bad_tsc = 1;
+	return 1;
+}
+__setup("badtsc", badtsc_setup);
+#endif
+
 void __init time_init(void)
 {
 	extern int x86_udelay_tsc;
@@ -675,16 +690,17 @@
 		unsigned long tsc_quotient = calibrate_tsc();
 		if (tsc_quotient) {
 			fast_gettimeoffset_quotient = tsc_quotient;
-			use_tsc = 1;
 			/*
 			 *	We could be more selective here I suspect
 			 *	and just enable this for the next intel chips ?
 			 */
-			x86_udelay_tsc = 1;
+			if(!bad_tsc){
+				use_tsc = 1;
+				x86_udelay_tsc = 1;
 #ifndef do_gettimeoffset
-			do_gettimeoffset = do_fast_gettimeoffset;
+				do_gettimeoffset = do_fast_gettimeoffset;
 #endif
-
+			}
 			/* report CPU clock rate in Hz.
 			 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
 			 * clock/second. Our precision is about 100 ppm.



