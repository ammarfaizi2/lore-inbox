Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWJCMz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWJCMz4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 08:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWJCMz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 08:55:56 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:59587 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932103AbWJCMzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 08:55:55 -0400
Date: Tue, 3 Oct 2006 14:55:53 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: rgooch@atnf.csiro.au, Jan Beulich <jbeulich@novell.com>,
       Kurt Garloff <garloff@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH -mm] fix buggy MTRR address checks
Message-ID: <20061003125553.GA3648@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checks that failed to realize that values are 4-kB-unit-sized
(note the format strings in this same diff context which *do* realize the
unit size, via appended "000"!).
Also fix an incorrect below-1MB area check (as gathered from Jan Beulich's
unapplied patch at
http://www.ussg.iu.edu/hypermail/linux/kernel/0411.1/1378.html )
Update mtrr_add_page() docu to make 4-kB-sized calculation more obvious.



Given several further items mentioned in Jan's patch mail, all in all
MTRR code seems surprisingly buggy, for a surprisingly long period of time
(many years). Further work/investigation would be useful.

Note that my patch is pretty much UNTESTED, since I can only verify that
it successfully boots my machine, but I cannot test against actual buggy
hardware which would require these (formerly broken) checks.
Long -mm simmering would make sense, especially since these now-working
checks might turn out to have adverse effects on unaffected hardware.

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.18-mm3.orig/arch/i386/kernel/cpu/mtrr/generic.c linux-2.6.18-mm3/arch/i386/kernel/cpu/mtrr/generic.c
--- linux-2.6.18-mm3.orig/arch/i386/kernel/cpu/mtrr/generic.c	2006-10-11 11:59:45.000000000 +0200
+++ linux-2.6.18-mm3/arch/i386/kernel/cpu/mtrr/generic.c	2006-10-11 12:04:37.000000000 +0200
@@ -366,7 +366,7 @@
 			printk(KERN_WARNING "mtrr: base(0x%lx000) is not 4 MiB aligned\n", base);
 			return -EINVAL;
 		}
-		if (!(base + size < 0x70000000 || base > 0x7003FFFF) &&
+		if (!(base + size < 0x70000 || base > 0x7003F) &&
 		    (type == MTRR_TYPE_WRCOMB
 		     || type == MTRR_TYPE_WRBACK)) {
 			printk(KERN_WARNING "mtrr: writable mtrr between 0x70000000 and 0x7003FFFF may hang the CPU.\n");
@@ -374,7 +374,7 @@
 		}
 	}
 
-	if (base + size < 0x100) {
+	if (base < 0x100) {
 		printk(KERN_WARNING "mtrr: cannot set region below 1 MiB (0x%lx000,0x%lx000)\n",
 		       base, size);
 		return -EINVAL;
diff -urN linux-2.6.18-mm3.orig/arch/i386/kernel/cpu/mtrr/main.c linux-2.6.18-mm3/arch/i386/kernel/cpu/mtrr/main.c
--- linux-2.6.18-mm3.orig/arch/i386/kernel/cpu/mtrr/main.c	2006-08-18 20:03:00.000000000 +0200
+++ linux-2.6.18-mm3/arch/i386/kernel/cpu/mtrr/main.c	2006-10-11 12:04:37.000000000 +0200
@@ -263,8 +263,8 @@
 
 /**
  *	mtrr_add_page - Add a memory type region
- *	@base: Physical base address of region in pages (4 KB)
- *	@size: Physical size of region in pages (4 KB)
+ *	@base: Physical base address of region in pages (in units of 4 kB!)
+ *	@size: Physical size of region in pages (4 kB)
  *	@type: Type of MTRR desired
  *	@increment: If this is true do usage counting on the region
  *
