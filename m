Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966328AbWKTSL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966328AbWKTSL3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966325AbWKTSKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:10:54 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:47569 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S934283AbWKTSHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:07:07 -0500
Message-Id: <20061120180520.418063000@arndb.de>
References: <20061120174454.067872000@arndb.de>
User-Agent: quilt/0.45-1
Date: Mon, 20 Nov 2006 18:44:55 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 01/22] powerpc: convert idle_loop to use hard_irq_disable()
Content-Disposition: inline; filename=idle-hard-irq-disable.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
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

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Index: linux-2.6/arch/powerpc/kernel/idle.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/idle.c
+++ linux-2.6/arch/powerpc/kernel/idle.c
@@ -66,13 +66,13 @@ void cpu_idle(void)
 				 * is ordered w.r.t. need_resched() test.
 				 */
 				smp_mb();
-				local_irq_disable();
+				hard_irq_disable();
 
 				/* check again after disabling irqs */
 				if (!need_resched() && !cpu_should_die())
 					ppc_md.power_save();
 
-				local_irq_enable();
+				hard_irq_enable();
 				set_thread_flag(TIF_POLLING_NRFLAG);
 
 			} else {

--

