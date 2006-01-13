Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161660AbWAMDVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161660AbWAMDVy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 22:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161666AbWAMDUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 22:20:17 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:23683 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161663AbWAMDUK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 22:20:10 -0500
Message-Id: <20060113032240.800883000@sorel.sous-sol.org>
References: <20060113032102.154909000@sorel.sous-sol.org>
Date: Thu, 12 Jan 2006 18:37:42 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "David S. Miller" <davem@davemloft.net>,
       "Luis F. Ortiz" <lfo@Polyad.Org>
Subject: [PATCH 04/17] [ATYFB]: Fix onboard video on SPARC Blade 100 for 2.6.{13,14,15}
Content-Disposition: inline; filename=fix-ATY-video-on-sunblade.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

	I have recently been switching from using 2.4.32 on my trusty
old Sparc Blade 100 to using 2.6.15 .  Some of the problems I ran into
were distorted video when the console was active (missing first
character, skipped dots) and when running X windows (colored snow,
stripes, missing pixels).  A quick examination of the 2.6 versus 2.4
source for the ATY driver revealed alot of changes.

         A closer look at the code/data for the 64GR/XL chip revealed
two minor "typos" that the rewriter(s) of the code made.  The first is
a incorrect clock value (230 .vs. 235) and the second is a missing
flag (M64F_SDRAM_MAGIC_PLL).  Making both these changes seems to have
fixed my problem.  I tend to think the 235 value is the correct one,
as there is a 29.4 Mhz clock crystal close to the video chip and 235.2
(29.4*8) is too close to 235 to make it a coincidence.

	The flag for M64F_SDRAM_MAGIC_PLL was dropped during the
changes made by adaplas in file revision 1.72 on the old bitkeeper
repository.

	The change relating to the clock rate has been there forever,
at least in the 2.6 tree.  I'm not sure where to look for the old 2.5
tree or if anyone cares when it happened.

On SPARC Blades 100's, which use the ATY MACH64GR video chipset, the
clock crystal frequency is 235.2 Mhz, not 230 Mhz.  The chipset also
requires the use of M64F_SDRAM_MAGIC_PLL in order to setup the PLL
properly for the DRAM.

Signed-off-by: "Luis F. Ortiz" <lfo@Polyad.Org>
Signed-off-by: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/video/aty/atyfb_base.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.15.y.orig/drivers/video/aty/atyfb_base.c
+++ linux-2.6.15.y/drivers/video/aty/atyfb_base.c
@@ -403,7 +403,7 @@ static struct {
 	{ PCI_CHIP_MACH64GM, "3D RAGE XL (Mach64 GM, AGP)", 230, 83, 63, ATI_CHIP_264XL },
 	{ PCI_CHIP_MACH64GN, "3D RAGE XL (Mach64 GN, AGP)", 230, 83, 63, ATI_CHIP_264XL },
 	{ PCI_CHIP_MACH64GO, "3D RAGE XL (Mach64 GO, PCI-66/BGA)", 230, 83, 63, ATI_CHIP_264XL },
-	{ PCI_CHIP_MACH64GR, "3D RAGE XL (Mach64 GR, PCI-33MHz)", 230, 83, 63, ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GR, "3D RAGE XL (Mach64 GR, PCI-33MHz)", 235, 83, 63, ATI_CHIP_264XL | M64F_SDRAM_MAGIC_PLL },
 	{ PCI_CHIP_MACH64GL, "3D RAGE XL (Mach64 GL, PCI)", 230, 83, 63, ATI_CHIP_264XL },
 	{ PCI_CHIP_MACH64GS, "3D RAGE XL (Mach64 GS, PCI)", 230, 83, 63, ATI_CHIP_264XL },
 

--
