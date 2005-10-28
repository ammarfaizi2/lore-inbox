Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751639AbVJ1OHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbVJ1OHn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 10:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbVJ1OHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 10:07:43 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:9147 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751639AbVJ1OHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 10:07:41 -0400
Date: Fri, 28 Oct 2005 16:07:48 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 5/14] s390: memory query wait psw.
Message-ID: <20051028140748.GE7300@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[patch 5/14] s390: memory query wait psw.

Don't switch back to 24 bit addressing mode when waiting for an external
interrupt and set the correct bit in wait PSW (external mask instead of
I/O mask).

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/head.S   |    3 +--
 arch/s390/kernel/head64.S |    5 ++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/head64.S linux-2.6-patched/arch/s390/kernel/head64.S
--- linux-2.6/arch/s390/kernel/head64.S	2005-10-28 14:04:41.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/head64.S	2005-10-28 14:04:47.000000000 +0200
@@ -530,7 +530,7 @@ startup:basr  %r13,0                    
 	be    .Lfchunk-.LPG1(%r13)	# leave
 	chi   %r1,2
 	be    .Lservicecall-.LPG1(%r13)
-	lpsw  .Lwaitsclp-.LPG1(%r13)
+	lpswe .Lwaitsclp-.LPG1(%r13)
 .Lsclph:
 	lh    %r1,.Lsccbr-PARMAREA(%r4)
 	chi   %r1,0x10			# 0x0010 is the sucess code
@@ -567,8 +567,7 @@ startup:basr  %r13,0                    
 .Lcr:
 	.quad 0x00  # place holder for cr0
 .Lwaitsclp:
-	.long 0x020A0000
-	.quad .Lsclph
+	.quad  0x0102000180000000,.Lsclph
 .Lrcp:
 	.int 0x00120001 # Read SCP forced code
 .Lrcp2:
diff -urpN linux-2.6/arch/s390/kernel/head.S linux-2.6-patched/arch/s390/kernel/head.S
--- linux-2.6/arch/s390/kernel/head.S	2005-10-28 14:04:41.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/head.S	2005-10-28 14:04:47.000000000 +0200
@@ -572,8 +572,7 @@ startup:basr  %r13,0                    
 .Lcr:
 	.long 0x00			# place holder for cr0
 .Lwaitsclp:
-	.long 0x020A0000
-	.long .Lsclph
+	.long 0x010a0000,0x80000000 + .Lsclph
 .Lrcp:
 	.int 0x00120001			# Read SCP forced code
 .Lrcp2:
