Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268587AbTGTV3F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 17:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268589AbTGTV3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 17:29:05 -0400
Received: from mithril.c-zone.net ([63.172.74.235]:27659 "EHLO mail.c-zone.net")
	by vger.kernel.org with ESMTP id S268587AbTGTV3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 17:29:02 -0400
Message-ID: <3F1B0D4A.8000908@c-zone.net>
Date: Sun, 20 Jul 2003 14:44:42 -0700
From: jiho@c-zone.net
Organization: Kidding of Course
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       B.Zolnierkiewicz@elka.pw.edu.pl, vojtech@suse.cz
Subject: [PATCH] 2.6.0-test1 - IDE driver VIA support (obscure bug)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Apoligies if line-wrapping is nuts, I've been confined to Mozilla....)

This patch fixes a *very* obscure bug, which only applies to VIA chipsets that
support UDMA-133 mode, and which is only known to be tickled by one UDMA-66 hard
drive (Maxtor 91360U4) that happens to report 80-wire cable detection opposite to
the ATA standard.

The bug appears in a test to see how the BIOS set up UDMA timing.  This test is
only reached when the drive says 80-wire *and* the chipset says 40-wire (which is
only known to happen with this drive).

The timing bits that are checked represent clocks T minus 2, i.e., ((N - 2) * T).
But Vojtech forgot to subtract 2, and applied N = 8 rather than N = 6 in the
test.  Since the test masks the bits at 7, they are always less than 8, and the
test always succeeds, even though the BIOS set UDMA-33.


--- drivers/ide/pci/via82cxxx.c-orig	Fri Jun 13 07:51:33 2003
+++ drivers/ide/pci/via82cxxx.c	Sun Jul 20 11:38:42 2003
@@ -484,7 +484,7 @@
			for (i = 24; i >= 0; i -= 8)
				if (((u >> i) & 0x10) ||
				    (((u >> i) & 0x20) &&
-				     (((u >> i) & 7) < 8))) {
+				     (((u >> i) & 7) < 6))) {
					/* BIOS 80-wire bit or
					 * UDMA w/ < 60ns/cycle
					 */



