Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262670AbVG2RMC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262670AbVG2RMC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 13:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbVG2RMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 13:12:01 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:39065 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S262671AbVG2RLn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 13:11:43 -0400
Date: Fri, 29 Jul 2005 19:11:39 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 2/4] s390: check for interrupt before waiting.
Message-ID: <20050729171139.GB5663@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The patch that introduced waiting for interrupts after resetting
the reader can cause the boot to fail because the system is waiting
for an interrupt that will never arrive. Add code to check if an
interrupt is supposed to arrive before waiting endlessly.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/head.S   |    7 +++++++
 arch/s390/kernel/head64.S |    7 +++++++
 2 files changed, 14 insertions(+)

diff -urpN linux-2.6/arch/s390/kernel/head64.S linux-2.6-patched/arch/s390/kernel/head64.S
--- linux-2.6/arch/s390/kernel/head64.S	2005-07-29 18:43:05.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/head64.S	2005-07-29 18:43:38.000000000 +0200
@@ -345,6 +345,13 @@ iplstart:
         la    %r2,.Lreset              
         lhi   %r3,26
 	diag  %r2,%r3,8
+	la    %r5,.Lirb
+	stsch 0(%r5)			       # check if irq is pending
+	tm    30(%r5),0x0f		       # by verifying if any of the
+	bnz   .Lwaitforirq		       # activity or status control
+	tm    31(%r5),0xff		       # bits is set in the schib
+	bz    .Lnoreset
+.Lwaitforirq:
 	mvc   0x78(8),.Lrdrnewpsw	       # set up IO interrupt psw
 .Lwaitrdrirq:
 	lpsw  .Lrdrwaitpsw
diff -urpN linux-2.6/arch/s390/kernel/head.S linux-2.6-patched/arch/s390/kernel/head.S
--- linux-2.6/arch/s390/kernel/head.S	2005-07-29 18:43:05.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/head.S	2005-07-29 18:43:38.000000000 +0200
@@ -346,6 +346,13 @@ iplstart:
         la    %r2,.Lreset              
         lhi   %r3,26
 	diag  %r2,%r3,8
+	la    %r5,.Lirb
+	stsch 0(%r5)			       # check if irq is pending
+	tm    30(%r5),0x0f		       # by verifying if any of the
+	bnz   .Lwaitforirq		       # activity or status control
+	tm    31(%r5),0xff		       # bits is set in the schib
+	bz    .Lnoreset
+.Lwaitforirq:
 	mvc   0x78(8),.Lrdrnewpsw              # set up IO interrupt psw
 .Lwaitrdrirq:
 	lpsw  .Lrdrwaitpsw
