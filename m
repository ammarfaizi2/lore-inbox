Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751632AbVJ1OGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbVJ1OGg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 10:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbVJ1OGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 10:06:36 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:59133 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751632AbVJ1OGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 10:06:35 -0400
Date: Fri, 28 Oct 2005 16:06:42 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 2/14] s390: signal delivery.
Message-ID: <20051028140642.GB7300@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[patch 2/14] s390: signal delivery.

Always create all signal frames for pending signals before
returning to userspace, not just a single one.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/entry.S   |    4 ++--
 arch/s390/kernel/entry64.S |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-patched/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/entry64.S	2005-10-28 14:04:44.000000000 +0200
@@ -283,7 +283,7 @@ sysc_sigpending:     
 	jo	sysc_restart
 	tm	__TI_flags+7(%r9),_TIF_SINGLE_STEP
 	jo	sysc_singlestep
-	j	sysc_leave        # out of here, do NOT recheck
+	j	sysc_work_loop
 
 #
 # _TIF_RESTART_SVC is set, set up registers and restart svc
@@ -684,7 +684,7 @@ io_sigpending:     
 	slgr    %r3,%r3			# clear *oldset
 	brasl	%r14,do_signal		# call do_signal
 	stnsm   __SF_EMPTY(%r15),0xfc	# disable I/O and ext. interrupts
-	j	sysc_leave		# out of here, do NOT recheck
+	j	io_work_loop
 
 /*
  * External interrupt handler routine
diff -urpN linux-2.6/arch/s390/kernel/entry.S linux-2.6-patched/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/entry.S	2005-10-28 14:04:44.000000000 +0200
@@ -288,7 +288,7 @@ sysc_sigpending:     
 	bo	BASED(sysc_restart)
 	tm	__TI_flags+3(%r9),_TIF_SINGLE_STEP
 	bo	BASED(sysc_singlestep)
-	b	BASED(sysc_leave)      # out of here, do NOT recheck
+	b	BASED(sysc_work_loop)
 
 #
 # _TIF_RESTART_SVC is set, set up registers and restart svc
@@ -645,7 +645,7 @@ io_sigpending:     
         l       %r1,BASED(.Ldo_signal)
 	basr    %r14,%r1	       # call do_signal
         stnsm   __SF_EMPTY(%r15),0xfc  # disable I/O and ext. interrupts
-	b	BASED(io_leave)        # out of here, do NOT recheck
+	b	BASED(io_work_loop)
 
 /*
  * External interrupt handler routine
