Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbUJ0CE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUJ0CE7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 22:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbUJ0CE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 22:04:56 -0400
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:54792 "EHLO
	anchor-post-36.mail.demon.net") by vger.kernel.org with ESMTP
	id S261563AbUJ0CEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 22:04:35 -0400
Date: Wed, 27 Oct 2004 03:03:34 +0100 (BST)
From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
To: wli@holomorphy.com, davem@redhat.com
cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: PATCH for Sun4c clones with an 82077 FDC
Message-ID: <Pine.LNX.4.10.10410270242340.26459-100000@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I have been having trouble working out why my sun4c sparc clone could not
find the floppy drive. I was being blind as floppy.h assumes that all
sun4c machines only have an 82072 FDC. This asumption is not valid for
some clones (OPUS Personal Mainframe 5000 sun4c sparc1 clone for one).

The patch below checks to see if it is an 82072 using a simple test before
assuming that we have an 82072. It works on my clone but it needs to be
checked on a sun4c system with an 82072 FDC.

Can someone with a sun4c system that has an 82072 check it to see if it
works for them. The extra two printk messages are more for diagnostics
when the patch is being tested (via prom console). If it does not break
82072 sun4c systems then the two diagnostic messages can be removed. If it
does break the 82072 sun4c systems, then a more complicated test is
needed that does not.

Regards
	Mark Fortescue.
-------------------------------------------------------------------------  
##############################################################################
#
# Mark Fortescue (mark@mtfhpc.demon.co.uk)
#
# Linux 2.6.8.1 Sparc Floppy Disc Controller Enhancement
# Some sun4c systems have an 82077 FDC so we must detect this
# early on or it does not get detected as it has a different
# memory map.
# 
#
##############################################################################
diff -rupd ref-2.6.8.1/include/asm-sparc/floppy.h linux-2.6.8.1/include/asm-sparc/floppy.h
--- ref-2.6.8.1/include/asm-sparc/floppy.h	Sat Aug 14 11:54:46 2004
+++ linux-2.6.8.1/include/asm-sparc/floppy.h	Wed Oct 27 02:37:41 2004
@@ -333,12 +333,22 @@ static int sun_floppy_init(void)
 		goto no_sun_fdc;
 	}
 
-        if(sparc_cpu_model == sun4c) {
+	/* Mark Fortescue <mark@mtfhpc.demon.co.uk>
+	 * Some sun4c clones have an 80277 FDC so do a simple test.
+	 * This is based on what I beleive is the test SunOS 4.1.1 does.
+	 */
+	if ((sun_fdc->dor_82077    == sun_fdc->status_82072) &&
+	    (sun_fdc->status_82077 == sun_fdc->status_82072) &&
+	    (sparc_cpu_model       == sun4c)) {
+		/* extern unsigned long auxio_register; */ /* P3 */
+
+		printk ("Sparc FDC is 82072\n");
                 sun_fdops.fd_inb = sun_82072_fd_inb;
                 sun_fdops.fd_outb = sun_82072_fd_outb;
                 fdc_status = &sun_fdc->status_82072;
                 /* printk("AUXIO @0x%lx\n", auxio_register); */ /* P3 */
         } else {
+		printk ("Sparc FDC is 82077\n");
                 sun_fdops.fd_inb = sun_82077_fd_inb;
                 sun_fdops.fd_outb = sun_82077_fd_outb;
                 fdc_status = &sun_fdc->status_82077;
----------------------------------------------------------------------------

