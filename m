Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130684AbRCLW61>; Mon, 12 Mar 2001 17:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130683AbRCLW6R>; Mon, 12 Mar 2001 17:58:17 -0500
Received: from [194.73.73.176] ([194.73.73.176]:16278 "EHLO protactinium")
	by vger.kernel.org with ESMTP id <S130684AbRCLW6C>;
	Mon, 12 Mar 2001 17:58:02 -0500
Date: Mon, 12 Mar 2001 22:57:26 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon>
To: Troels Walsted Hansen <troels@thule.no>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@redhat.com>, <kcarnold@arnoldnet.net>
Subject: Re: [PATCH] Fix MTRR support for AMD Athlon
In-Reply-To: <3AAD35F4.61F47450@thule.no>
Message-ID: <Pine.LNX.4.31.0103122252490.608-100000@athlon>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Mar 2001, Troels Walsted Hansen wrote:

Hi Troels,

> Dave Jones' recent 2.4.2ac17 patch to mtrr.c to support the Cyrix III
> unfortunately broke the AMD Athlon support. Here's a patch to correct
> the problem (Dave must have overlooked the fall-through logic of the
> switch statement).

Indeed I did. I was about to look into this just as your mail arrived,
after someone told me about MTRRs with 'size=16773376MB'.
This should fix it. However I think the patch below would be a
better fix, removing the drop-through case, and making the switch
more obvious. It guarantees no-one will make the mistake again :)
(At least not with this switch).

Patch rediffed against 2.4.2-ac19

regards,

Dave.


diff -urN --exclude-from=/home/davej/.exclude linux/arch/i386/kernel/mtrr.c linux-dj/arch/i386/kernel/mtrr.c
--- linux/arch/i386/kernel/mtrr.c	Mon Mar 12 20:40:28 2001
+++ linux-dj/arch/i386/kernel/mtrr.c	Mon Mar 12 21:06:28 2001
@@ -235,6 +235,12 @@
   v1.38
     20010309   Dave Jones <davej@suse.de>
 	       Add support for Cyrix III.
+
+  v1.39
+    20010312   Dave Jones <davej@suse.de>
+               Ugh, I broke AMD support.
+	       Reworked fix by Troels Walsted Hansen <troels@thule.no>
+
 */
 #include <linux/types.h>
 #include <linux/errno.h>
@@ -274,7 +280,7 @@
 #include <asm/hardirq.h>
 #include <linux/irq.h>

-#define MTRR_VERSION            "1.37 (20001109)"
+#define MTRR_VERSION            "1.39 (20010312)"

 #define TRUE  1
 #define FALSE 0
@@ -1964,6 +1970,7 @@
 	get_mtrr = intel_get_mtrr;
 	set_mtrr_up = intel_set_mtrr_up;
 	switch (boot_cpu_data.x86_vendor) {
+
 	case X86_VENDOR_AMD:
 		/* The original Athlon docs said that
 		   total addressable memory is 44 bits wide.
@@ -1982,6 +1989,10 @@
 			size_and_mask = ~size_or_mask & 0xfff00000;
 			break;
 		}
+		size_or_mask  = 0xff000000; /* 36 bits */
+		size_and_mask = 0x00f00000;
+		break;
+
 	case X86_VENDOR_CENTAUR:
 		/* Cyrix III has Intel style MTRRs, but doesn't support PAE */
 		if (boot_cpu_data.x86 == 6 && boot_cpu_data.x86_model == 6) {
@@ -1996,6 +2007,7 @@
 		size_and_mask = 0x00f00000;
 		break;
 	}
+
     } else if ( test_bit(X86_FEATURE_K6_MTRR, &boot_cpu_data.x86_capability) ) {
 	/* Pre-Athlon (K6) AMD CPU MTRRs */
 	mtrr_if = MTRR_IF_AMD_K6;


-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

