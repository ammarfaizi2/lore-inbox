Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751802AbWF3QNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbWF3QNx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 12:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbWF3QNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 12:13:53 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:14741 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751797AbWF3QNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 12:13:52 -0400
Date: Fri, 30 Jun 2006 18:13:51 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH -mm] ide_end_drive_cmd(): avoid instruction pipeline stall
Message-ID: <20060630161351.GA17434@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use an independently-formatted "unsigned int" for data instead of a
restrictive "u16" to avoid instruction fetch pipeline stalls
probably caused by the byte calculations later.


ide_end_drive_cmd() uses an u16 variable for the result of an INW()
which it then does some byte masking operations on.
On my P3/700, this results in a highly visible IFU_MEM_STALL oprofile blip
when doing a simple "load 30 larger GUI apps in parallel" benchmark
(which takes about 1:30 or so, BTW):
The ide_end_drive_cmd() IFU_MEM_STALL amounts to 0.59% of all IFU_MEM_STALL
events during the profiling, with this opcode line amounting to > 95%
IFU_MEM_STALL within the function itself.

Replacing the u16 by an architecture-independently formatted unsigned int
to ease the byte-masking operations:

	/* no u16 here: caused severe IFU_MEM_STALL! */
	unsigned int data                               = hwif->INW(IDE_DATA_REG);
	args->tfRegister[IDE_DATA_OFFSET]       = (data) & 0xFF;
	args->hobRegister[IDE_DATA_OFFSET]      = (data >> 8) & 0xFF;

completely puts ide_end_drive_cmd() off the IFU_MEM_STALL radar during
repeated profiling attempts (after a fresh reboot with the modified kernel),
as opposed to having been the *top* oprofile trace item before.

I suppose that this is something like a textbook example of why it's
sometimes not beneficial to not use native-sized (i.e., 32bit) variables,
right?

Run-tested on 2.6.17-mm4.

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-mm4.orig/drivers/ide/ide-io.c linux-2.6.17-mm4.my/drivers/ide/ide-io.c
--- linux-2.6.17-mm4.orig/drivers/ide/ide-io.c	2006-06-29 11:57:12.000000000 +0200
+++ linux-2.6.17-mm4.my/drivers/ide/ide-io.c	2006-06-30 11:54:12.000000000 +0200
@@ -397,7 +397,8 @@
 			
 		if (args) {
 			if (args->tf_in_flags.b.data) {
-				u16 data				= hwif->INW(IDE_DATA_REG);
+				/* no u16 here: caused severe IFU_MEM_STALL! */
+				unsigned int data				= hwif->INW(IDE_DATA_REG);
 				args->tfRegister[IDE_DATA_OFFSET]	= (data) & 0xFF;
 				args->hobRegister[IDE_DATA_OFFSET]	= (data >> 8) & 0xFF;
 			}
