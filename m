Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265470AbTIFKFK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 06:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265522AbTIFKFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 06:05:10 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:6030 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S265470AbTIFKFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 06:05:04 -0400
Date: Sat, 6 Sep 2003 11:04:56 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Move local_irq_enable() out of poll_idle()
Message-ID: <20030906100456.GA9928@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch: irq_idle-2.6.0-test4-01jl

Scheduling is not allowed with interrupts disabled.  So we know that
when schedule() returns, local irqs are enabled.  So poll_idle() doesn't
need to enable them.

I suggest this change, to remove any confusion over whether the
individual idle routines need to disable irqs themselves.  (As seen
recently in a thread about mwait_idle):

        - remove the local_irq_enable() from poll_idle().

        - add local_irq_enable() at the start of cpu_idle(), before the loop.

-- Jamie


diff -urN --exclude-from=dontdiff orig-2.6.0-test4/arch/i386/kernel/process.c idle_irqs-2.6.0-test4/arch/i386/kernel/process.c
--- orig-2.6.0-test4/arch/i386/kernel/process.c	2003-09-02 23:05:06.000000000 +0100
+++ idle_irqs-2.6.0-test4/arch/i386/kernel/process.c	2003-09-06 10:50:59.000000000 +0100
@@ -105,8 +105,6 @@
 {
 	int oldval;
 
-	local_irq_enable();
-
 	/*
 	 * Deal with another CPU just having chosen a thread to
 	 * run here:
@@ -136,6 +134,8 @@
  */
 void cpu_idle (void)
 {
+	local_irq_enable();
+
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched()) {
