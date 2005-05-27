Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbVE0ACk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVE0ACk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 20:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVE0ACk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 20:02:40 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:45264 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S261860AbVE0ACd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 20:02:33 -0400
Date: Thu, 26 May 2005 19:02:11 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       Kim.Phillips@freescale.com
Subject: [PATCH] ppc32: Simplified load string emulation error checking
Message-ID: <Pine.LNX.4.61.0505261858180.17674@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The error checking for emulation of load string instructions was overly
generous and would cause certain valid forms of the instructions to be
treated as illegal.  We drop the range checking since the architecture
allows this to be boundedly undefined.  Tests on CPUs that support these
instructions appear not do cause illegal instruction traps on range
errors and just allow the execution to occur.

Thanks to Kim Phillips for debugging this and figuring out what real HW 
was doing.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 219d058f65dbd666964b1e951b8d491e4b19dc0c
tree 109a4648d2cc627d17c129bc1ca102a736c817aa
parent 4b1b1ed3400c905819fc4668838dbec4099f2d8d
author Kumar K. Gala <kumar.gala@freescale.com> Thu, 26 May 2005 18:55:56 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Thu, 26 May 2005 18:55:56 -0500

 ppc/kernel/traps.c |    7 +------
 1 files changed, 1 insertion(+), 6 deletions(-)

Index: arch/ppc/kernel/traps.c
===================================================================
--- 94fc6c9507563e89a75b0838824003b2301b4321/arch/ppc/kernel/traps.c  (mode:100644)
+++ 109a4648d2cc627d17c129bc1ca102a736c817aa/arch/ppc/kernel/traps.c  (mode:100644)
@@ -408,12 +408,7 @@
 
 	/* Early out if we are an invalid form of lswx */
 	if ((instword & INST_STRING_MASK) == INST_LSWX)
-		if ((rA >= rT) || (NB_RB >= rT) || (rT == rA) || (rT == NB_RB))
-			return -EINVAL;
-
-	/* Early out if we are an invalid form of lswi */
-	if ((instword & INST_STRING_MASK) == INST_LSWI)
-		if ((rA >= rT) || (rT == rA))
+		if ((rT == rA) || (rT == NB_RB))
 			return -EINVAL;
 
 	EA = (rA == 0) ? 0 : regs->gpr[rA];
