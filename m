Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030593AbWKUAyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030593AbWKUAyF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 19:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030618AbWKUAyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 19:54:05 -0500
Received: from gate.crashing.org ([63.228.1.57]:16605 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030593AbWKUAyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 19:54:02 -0500
Subject: Re: [PATCH 01/22] powerpc: convert idle_loop to use
	hard_irq_disable()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
In-Reply-To: <20061120180520.418063000@arndb.de>
References: <20061120174454.067872000@arndb.de>
	 <20061120180520.418063000@arndb.de>
Content-Type: text/plain
Date: Tue, 21 Nov 2006 11:53:44 +1100
Message-Id: <1164070425.8073.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got a bug report that I believe might be fixed by this
patch. The problem seems to be that with soft-disabled
interrupts in power_save, we can still get external exceptions
on Cell, even if we are in pause(0) a.k.a. sleep state.

When the CPU really wakes up through the 0x100 (system reset)
vector, while we have already started processing the 0x500
(external) exception, we get a panic in unrecoverable_exception()
because of the lost state.

This occurred in Systemsim for Cell, but as far as I can see,
it can theoretically occur on any machine that uses the
system reset exception to get out of sleep state.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
What about that patch instead ?

Index: linux-cell/arch/powerpc/platforms/cell/pervasive.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/pervasive.c	2006-11-21 11:01:12.000000000 +1100
+++ linux-cell/arch/powerpc/platforms/cell/pervasive.c	2006-11-21 11:48:12.000000000 +1100
@@ -41,6 +41,15 @@
 static void cbe_power_save(void)
 {
 	unsigned long ctrl, thread_switch_control;
+
+	/*
+	 * We need to hard disable interrupts, but we also need to mark them
+	 * hard disabled in the PACA so that the local_irq_enable() done by
+	 * our caller upon return propertly hard enables.
+	 */
+	hard_irq_disable();
+	get_paca()->hard_enabled = 0;
+
 	ctrl = mfspr(SPRN_CTRLF);
 
 	/* Enable DEC and EE interrupt request */


