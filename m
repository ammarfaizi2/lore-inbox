Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbTKTWfp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 17:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbTKTWfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 17:35:45 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:42960 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262955AbTKTWfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 17:35:30 -0500
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Date: Fri, 21 Nov 2003 09:35:27 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16317.16815.981658.437235@wombat.disy.cse.unsw.edu.au>
Subject: PIIX5 Doesn't work on IA64 (2.6.0-test9)
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	The PIIX5 IDE controller on I2000 IA64 boxen using the 460GX
chipset will hang on startup if an ordinary harddrive is plugged into
it (it seems to workj for the LSI120 and the CDROM drives).

This is because the 460GX chipset contains a PCI expanssion bridge
that works like the 450NX PXB, and has the same PCI ID (but a later
revision).  The PIIX driver, to work around interactions between PIIX4
and the 450NX PXB, tries to disable DMA.

Unfortunately, the way it tries to disable DMA doesn't work, and the
higher layers think that DMA is still on, and so timeout waiting for
DMA, and then hang on bootup.

A simple workaround is to tighten the check for the buggy chipset, as
in the attached patch.  However, someone with more time (and who
actually *understands* the IDE subsystem) needs to fix the real bug as
well.

===== piix.c 1.20 vs edited =====
--- 1.20/drivers/ide/pci/piix.c	Wed Oct 22 09:27:24 2003
+++ edited/piix.c	Fri Nov 21 09:28:43 2003
@@ -768,8 +768,8 @@
 		/* Only on the original revision: IDE DMA can hang */
 		if(rev == 0x00)
 			no_piix_dma = 1;
-		/* On all revisions PXB bus lock must be disabled for IDE */
-		else if(cfg & (1<<14))
+		/* On all revisions below 5 PXB bus lock must be disabled for IDE */
+		else if(cfg & (1<<14) && rev < 5)
 			no_piix_dma = 2;
 	}
 	if(no_piix_dma)



