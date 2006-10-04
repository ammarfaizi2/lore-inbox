Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbWJDIwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWJDIwT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 04:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbWJDIwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 04:52:19 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:32523
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S964901AbWJDIwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 04:52:18 -0400
Message-Id: <452392AA.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 04 Oct 2006 09:53:30 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andrew Morton" <akpm@osdl.org>,
       "Andreas Mohr" <andi@rhlx01.fht-esslingen.de>
Cc: <rgooch@atnf.csiro.au>, "Kurt Garloff" <garloff@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] fix buggy MTRR address checks
References: <20061003125553.GA3648@rhlx01.fht-esslingen.de>
In-Reply-To: <20061003125553.GA3648@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ack

>>> Andreas Mohr <andi@rhlx01.fht-esslingen.de> 03.10.06 14:55 >>>
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


diff -urN linux-2.6.18-mm3.orig/arch/i386/kernel/cpu/mtrr/generic.c
linux-2.6.18-mm3/arch/i386/kernel/cpu/mtrr/generic.c
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
 			printk(KERN_WARNING "mtrr: writable mtrr between 0x70000000 and 0x7003FFFF may hang the
CPU.\n");
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
