Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVFASgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVFASgg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 14:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVFASJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 14:09:32 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:1157 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S261534AbVFASFG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 14:05:06 -0400
Date: Wed, 1 Jun 2005 20:05:03 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 11/11] s390: pending interrupt after ipl from reader.
Message-ID: <20050601180503.GK6418@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 11/11] s390: pending interrupt after ipl from reader.

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Wait for interrupt and clear status pending after resetting the reader.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/head.S   |   19 +++++++++++++++++--
 arch/s390/kernel/head64.S |   19 +++++++++++++++++--
 2 files changed, 34 insertions(+), 4 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/head64.S linux-2.6-patched/arch/s390/kernel/head64.S
--- linux-2.6/arch/s390/kernel/head64.S	2005-06-01 19:43:22.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/head64.S	2005-06-01 19:43:22.000000000 +0200
@@ -344,10 +344,25 @@ iplstart:
 	bno   .Lnoreset
         la    %r2,.Lreset              
         lhi   %r3,26
-        .long 0x83230008
+	diag  %r2,%r3,8
+	mvc   0x78(8),.Lrdrnewpsw	       # set up IO interrupt psw
+.Lwaitrdrirq:
+	lpsw  .Lrdrwaitpsw
+.Lrdrint:
+	c     %r1,0xb8			       # compare subchannel number
+	bne   .Lwaitrdrirq
+	la    %r5,.Lirb
+	tsch  0(%r5)
 .Lnoreset:
+	b     .Lnoload
+
+	.align 8
+.Lrdrnewpsw:
+	.long  0x00080000,0x80000000+.Lrdrint
+.Lrdrwaitpsw:
+	.long  0x020a0000,0x80000000+.Lrdrint
 #endif
-	
+
 #
 # everything loaded, go for it
 #
diff -urpN linux-2.6/arch/s390/kernel/head.S linux-2.6-patched/arch/s390/kernel/head.S
--- linux-2.6/arch/s390/kernel/head.S	2005-06-01 19:43:22.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/head.S	2005-06-01 19:43:22.000000000 +0200
@@ -345,10 +345,25 @@ iplstart:
 	bno   .Lnoreset
         la    %r2,.Lreset              
         lhi   %r3,26
-        .long 0x83230008
+	diag  %r2,%r3,8
+	mvc   0x78(8),.Lrdrnewpsw              # set up IO interrupt psw
+.Lwaitrdrirq:
+	lpsw  .Lrdrwaitpsw
+.Lrdrint:
+	c     %r1,0xb8                         # compare subchannel number
+	bne   .Lwaitrdrirq
+	la    %r5,.Lirb
+	tsch  0(%r5)
 .Lnoreset:
+        b     .Lnoload
+
+	.align 8
+.Lrdrnewpsw:
+	.long  0x00080000,0x80000000+.Lrdrint
+.Lrdrwaitpsw:
+	.long  0x020a0000,0x80000000+.Lrdrint
 #endif
-	
+
 #
 # everything loaded, go for it
 #
