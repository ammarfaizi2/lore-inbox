Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbUC2PP0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 10:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbUC2PP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 10:15:26 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:30387 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S262951AbUC2PPQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 10:15:16 -0500
Date: Mon, 29 Mar 2004 08:15:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Sven Hartge <hartge@ds9.gnuu.de>, Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-pre* does not boot on my PReP PPC
Message-ID: <20040329151515.GD2895@smtp.west.cox.net>
References: <Pine.GSO.4.44.0403262029010.2460-100000@math.ut.ee> <20040326185103.GB20819@smtp.west.cox.net> <E1B7EHF-0004Jm-DY@ds9.argh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1B7EHF-0004Jm-DY@ds9.argh.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2004 at 02:55:09PM +0100, Sven Hartge wrote:

> Tom Rini <trini@kernel.crashing.org> wrote:
> > On Fri, Mar 26, 2004 at 08:33:18PM +0200, Meelis Roos wrote:
> 
> >> Recent 2.6.5-pre* and -rc1 and -BK don't boot on my Motorola Powerstack
> >> (PReP with no RTAS but with OF).
> >> 
> >> I use netboot to test new kernels.  Normally, the screen is changed to
> >> VGA text mode and the bootloader speaks some lines of info and asks for
> >> the kernel command line. Now, the image is loaded via tftp (as shown by
> >> tcpdump, the last datagram is smaller) and nothing more happens. The
> >> cursor stays where it is - at the beginning of the Booting ... line in
> >> graphics mode OF environment and that's all.
> 
> > Hmm.  Can you hook up a serial line, enable serial console as well and
> > see if anything pops out there?
> 
> I am seeing the same problem here too (Powerstack II with OF).

Ok.  Can both of you try the following patch on top of the version which
fails?
 arch/ppc/boot/simple/head.S      |    2 +-
 arch/ppc/boot/simple/misc-prep.c |    4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)
--- 1.8/arch/ppc/boot/simple/head.S	Mon Mar  1 16:34:28 2004
+++ edited/arch/ppc/boot/simple/head.S	Mon Mar 29 08:14:48 2004
@@ -99,8 +99,8 @@
 	mr	r25,r5
 #else
 	bl	disable_6xx_mmu
-#endif
 	bl	disable_6xx_l1cache
+#endif
 
 	CLEAR_CACHES
 #endif
--- 1.1/arch/ppc/boot/simple/misc-prep.c	Mon Mar  1 16:34:28 2004
+++ edited/arch/ppc/boot/simple/misc-prep.c	Mon Mar 29 08:13:08 2004
@@ -35,6 +35,7 @@
 extern struct bi_record *decompress_kernel(unsigned long load_addr,
 		int num_words, unsigned long cksum);
 extern void disable_6xx_mmu(void);
+extern void disable_6xx_l1cache(void);
 extern unsigned long mpc10x_get_mem_size(void);
 
 static void
@@ -152,8 +153,9 @@
 	}
 
 	/* Now go and clear out the BATs and ensure that our MSR is
-	 * correct .*/
+	 * correct.  Also disable the L1s finally. */
 	disable_6xx_mmu();
+	disable_6xx_l1cache();
 
 	/* Make r3 be a pointer to the residual data. */
 	return (unsigned long)hold_residual;

-- 
Tom Rini
http://gate.crashing.org/~trini/
