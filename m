Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbTHYJXL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 05:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbTHYJXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 05:23:11 -0400
Received: from [203.145.184.221] ([203.145.184.221]:19973 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S261556AbTHYJXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 05:23:05 -0400
From: "Krishnakumar. R" <krishnakumar@naturesoft.net>
Reply-To: krishnakumar@naturesoft.net
Organization: Naturesoft
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH-2.6.0-test4-mm1][drivers/char/stallion.c]Task queue to work queue conversion
Date: Mon, 25 Aug 2003 14:55:48 +0530
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308251455.48507.krishnakumar@naturesoft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Andrew and all,

Here is the fix for the drivers/char/stallion.c.
Some schedule_task's had not been changed
to schedule_work. This patch would change them.
The patch is against 2.6.0-test4-mm1.

Without this the drivers/char/stallion.c 
cannot be compiled as part of the kernel (make bzImage).

Please do apply!

Regards
KK

===========================================
The following is the patch:

--- linux-2.6.0-test4-mm1/drivers/char/stallion.orig.c	2003-08-23 05:28:12.000000000 +0530
+++ linux-2.6.0-test4-mm1/drivers/char/stallion.c	2003-08-25 14:29:56.000000000 +0530
@@ -4234,7 +4234,7 @@
 	misr = inb(ioaddr + EREG_DATA);
 	if (misr & MISR_DCD) {
 		set_bit(ASYI_DCDCHANGE, &portp->istate);
-		schedule_task(&portp->tqueue);
+		schedule_work(&portp->tqueue);
 		portp->stats.modem++;
 	}
 
@@ -5031,7 +5031,7 @@
 	if ((len == 0) || ((len < STL_TXBUFLOW) &&
 	    (test_bit(ASYI_TXLOW, &portp->istate) == 0))) {
 		set_bit(ASYI_TXLOW, &portp->istate);
-		schedule_task(&portp->tqueue); 
+		schedule_work(&portp->tqueue); 
 	}
 
 	if (len == 0) {
@@ -5248,7 +5248,7 @@
 		ipr = stl_sc26198getreg(portp, IPR);
 		if (ipr & IPR_DCDCHANGE) {
 			set_bit(ASYI_DCDCHANGE, &portp->istate);
-			schedule_task(&portp->tqueue); 
+			schedule_work(&portp->tqueue); 
 			portp->stats.modem++;
 		}
 		break;

==============================================
diffstat output:
stallion.c |    6 +++---
1 files changed, 3 insertions(+), 3 deletions(-)
==============================================
Compilation errors fixed:
drivers/char/stallion.c: In function `stl_cd1400mdmisr':
drivers/char/stallion.c:4237: warning: implicit declaration of function `schedule_task'
==============================================
Linking errors fixed:
drivers/built-in.o(.text+0x40ece): In function `stl_cd1400mdmisr':
: undefined reference to `schedule_task'
drivers/built-in.o(.text+0x42038): In function `stl_sc26198txisr':
: undefined reference to `schedule_task'
drivers/built-in.o(.text+0x424b9): In function `stl_sc26198otherisr':
: undefined reference to `schedule_task'
make: *** [.tmp_vmlinux1] Error 1
===============================================





