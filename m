Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277718AbRJLOrt>; Fri, 12 Oct 2001 10:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277719AbRJLOrk>; Fri, 12 Oct 2001 10:47:40 -0400
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:50335 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S277718AbRJLOrX>; Fri, 12 Oct 2001 10:47:23 -0400
Date: Fri, 12 Oct 2001 15:49:33 +0100
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Updated cachesize errata
Message-ID: <20011012154933.A27312@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  The patch below fixes yet another CPU that reports incorrect cachesize.
This one is a little trickier than the previous fixes of this sort, as Intel
have made two CPUs with differing cachesizes, with the same model/stepping.
(Yes, we were meant to distinguish between with cachesize-- doh)

Buggy PIII Tualatins with 256K cache will automatically be fixed up with this patch.
Ones with 512K cache will need an extra boot time argument passed
'cachesize=512'

This bootflag may also come in useful if/when any future CPU makes this mistake
again. Now people can override what the CPU reports, without having to wait
for a kernel patch.

Patch applies to 2.4.13pre1, and 2.4.12-ac1 cleanly, and has been tested on
several boxes here without problems.

regards,

Dave.


diff -urN --exclude-from=/home/davej/.exclude linux/arch/i386/kernel/setup.c linux-dj/arch/i386/kernel/setup.c
--- linux/arch/i386/kernel/setup.c	Tue Sep 18 07:03:09 2001
+++ linux-dj/arch/i386/kernel/setup.c	Tue Oct  2 18:55:11 2001
@@ -67,6 +67,10 @@
  *
  *  AMD Athlon/Duron/Thunderbird bluesmoke support.
  *  Dave Jones <davej@suse.de>, April 2001.
+ *
+ *  CacheSize bug workaround updates for AMD, Intel & VIA Cyrix.
+ *  Dave Jones <davej@suse.de>, September, October 2001.
+ *
  */
 
 /*
@@ -1036,6 +1040,15 @@
 #endif
 }
 
+static int cachesize_override __initdata = -1;
+static int __init cachesize_setup(char *str)
+{
+	get_option (&str, &cachesize_override);
+	return 1;
+}
+__setup("cachesize=", cachesize_setup);
+
+
 #ifndef CONFIG_X86_TSC
 static int tsc_disable __initdata = 0;
 
@@ -1106,11 +1119,24 @@
 			l2size = 256;
 	}
 
+	/* Intel PIII Tualatin. This comes in two flavours.
+	 * One has 256kb of cache, the other 512. We have no way
+	 * to determine which, so we use a boottime override
+	 * for the 512kb model, and assume 256 otherwise.
+	 */
+	if ((c->x86_vendor == X86_VENDOR_INTEL) && (c->x86 == 6) &&
+		(c->x86_model == 11) && (l2size == 0))
+		l2size = 256;
+
 	/* VIA C3 CPUs (670-68F) need further shifting. */
 	if (c->x86_vendor == X86_VENDOR_CENTAUR && (c->x86 == 6) &&
 		((c->x86_model == 7) || (c->x86_model == 8))) {
 		l2size = l2size >> 8;
 	}
+
+	/* Allow user to override all this if necessary. */
+	if (cachesize_override != -1)
+		l2size = cachesize_override;
 
 	if ( l2size == 0 )
 		return;		/* Again, no L2 cache is possible */


-- 
| Dave Jones.                    http://www.codemonkey.org.uk
| SuSE Labs .
