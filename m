Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUHJJJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUHJJJE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 05:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbUHJJI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 05:08:28 -0400
Received: from mail.math.TU-Berlin.DE ([130.149.12.212]:55200 "EHLO
	mail.math.TU-Berlin.DE") by vger.kernel.org with ESMTP
	id S263725AbUHJJHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 05:07:13 -0400
From: Thomas Richter <thor@math.TU-Berlin.DE>
Message-Id: <200408100906.LAA11342@cleopatra.math.tu-berlin.de>
Subject: Re: netmos patches
In-Reply-To: <20040809164623.5b7f9983.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 10 Aug 2004 11:06:58 +0200 (CEST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

> I don't have a clue what's going on here.  Please send a clean
> patch against 2.6.8-rc3 or later, thanks.

Seems you're confused. (-; The patch came in two parts, one that is
stable and tested, and an experimental one I don't have the hardware
for to test it.

But since you ask for, here we go: The following is a patch against
2.6.8-rc4 to add support for all NetMOS devices I could get hold of:

/* snip */

--- parport_pc.c.old	Tue Aug 10 10:53:38 2004
+++ parport_pc.c	Tue Aug 10 10:55:15 2004
@@ -2625,7 +2625,13 @@
 	syba_2p_epp,
 	syba_1p_ecp,
 	titan_010l,
+	titan_1284p1,
 	titan_1284p2,
+	netmos_9705,  /* thor: a couple of experimental netmos drivers follow... */
+	netmos_9735,
+	netmos_9715,
+	netmos_9835,
+	netmos_9755,  /* thor: netmos modifications end */
 	avlab_1p,
 	avlab_2p,
 	oxsemi_954,
@@ -2696,7 +2702,15 @@
 	/* syba_2p_epp AP138B */	{ 2, { { 0, 0x078 }, { 0, 0x178 }, } },
 	/* syba_1p_ecp W83787 */	{ 1, { { 0, 0x078 }, } },
 	/* titan_010l */		{ 1, { { 3, -1 }, } },
+	/* titan_1284p1 */              { 1, { { 0, 1 }, } },
 	/* titan_1284p2 */		{ 2, { { 0, 1 }, { 2, 3 }, } },
+	/* thor: untested experimental netmos cards follow */
+	/* netmos 9705  */              { 1, { { 0, 1 }, } },
+	/* netmos 9735  */              { 1, { { 2, 3 }, } },
+	/* netmos 9715  */              { 2, { { 0, 1}, { 2, 3 },} },
+	/* netmos 9835  */              { 1, { { 2, 3 }, } },
+	/* netmos 9755  */              { 2, { { 0, 1}, { 2, 3 },} },
+	/* thor: netmos addons end */
 	/* avlab_1p		*/	{ 1, { { 0, 1}, } },
 	/* avlab_2p		*/	{ 2, { { 0, 1}, { 2, 3 },} },
 	/* The Oxford Semi cards are unusual: 954 doesn't support ECP,
@@ -2767,7 +2781,15 @@
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, syba_1p_ecp },
 	{ PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_010L,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, titan_010l },
+	{ 0x9710, 0x9805, 0x1000, 0x0010, 0, 0, titan_1284p1 },
 	{ 0x9710, 0x9815, 0x1000, 0x0020, 0, 0, titan_1284p2 },
+	/* thor: Untested, experimental netmos based cards follow */
+	{ 0x9710, 0x9705, PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9705 },
+	{ 0x9710, 0x9735, PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9735 },
+	{ 0x9710, 0x9715, PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9715 },
+	{ 0x9710, 0x9835, PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9835 },
+	{ 0x9710, 0x9755, PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9755 },
+	/* thor: netmos support end */
 	/* PCI_VENDOR_ID_AVLAB/Intek21 has another bunch of cards ...*/
 	{ 0x14db, 0x2120, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1p}, /* AFAVLAB_TK9902 */
 	{ 0x14db, 0x2121, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_2p},

/* snip */

Ok, the support for the 9805, aka titan_1284p1 is tested and works. 
(That was the first patch). Support for the NetMOS 9815 is already in
for a while - that's the two-port version of the 9805.

What is experimental is the support for all other netmos devices, namely
the 9705, 9735, 9715, 9835 and 9755. Specifically, I don't have the full
PCI id's and replaced the vendor IDs by PCI_ID_ANY, which should *hopefully*
work out. In other words, this really requires some testing, at best by
someone who has the mentioned boards. The 9805 based board is sold here
in Germany in "every store round the corner". All others - I don't know -
might also come with additional serial ports.

Greetings,
	Thomas

