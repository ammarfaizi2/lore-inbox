Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbVK3PAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbVK3PAO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 10:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbVK3PAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 10:00:14 -0500
Received: from rtsoft3.corbina.net ([85.21.88.6]:1550 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S1751259AbVK3PAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 10:00:13 -0500
Message-ID: <438DBE4B.4000709@ru.mvista.com>
Date: Wed, 30 Nov 2005 17:59:23 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Ingo Molnar <mingo@elte.hu>
Subject: [patch] linux-2.6.14-rt21 PPC32 signal delivery in realtime preemption.
Content-Type: multipart/mixed;
 boundary="------------010900090809060105070907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010900090809060105070907
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Patch description:
With CONFIG_PREEMPT_RT=y and CONFIG_DEBUG_PREEMPT=y
lots of sleeping-in-invalid-context BUG messages are displayed for PPC32 
architecture.
Kernel log:
Freeing unused kernel memory: 108k init
BUG: sleeping function called from invalid context init(1) at 
kernel/rt.c:1446
in_atomic():1 [00000001], irqs_disabled():0
Call trace:
 [c0012010] __might_sleep+0xf0/0xfc
 [c0031fd8] __spin_lock+0x38/0x70
 [c004ab68] lru_cache_add_active+0x20/0xa0
 [c0071c24] install_arg_page+0xf0/0x24c
 [c0071ee8] setup_arg_pages+0x168/0x1d4
 [c0095674] load_elf_binary+0x44c/0x11d8
 [c0072ff4] search_binary_handler+0xfc/0x338
 [c00733c0] do_execve+0x190/0x274
 [c0005b30] sys_execve+0x80/0xe0
 [c0002474] ret_from_syscall+0x0/0x70
 [c00050b8] execve+0x8/0x30
 [c00016a8] init+0x1b0/0x248
 [c0005090] original_kernel_thread+0x48/0x64

This happens because interrupts are not enabled in the realtime preemption
mode by the time kernel delivers signals to processes. This patch enables
interrupts so that realtime mutexes can be acquired in the "right" context.
The original code has been found in CONFIG_PREEMPT_RT support for i386 
architecture.
Thanks.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>



--------------010900090809060105070907
Content-Type: text/x-patch;
 name="ppc_premmpt_rt_signal.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc_premmpt_rt_signal.patch"

diff -rauN linux-2.6.14.orig/arch/ppc/kernel/signal.c linux-2.6.14/arch/ppc/kernel/signal.c
--- linux-2.6.14.orig/arch/ppc/kernel/signal.c	2005-10-28 04:02:08.000000000 +0400
+++ linux-2.6.14/arch/ppc/kernel/signal.c	2005-11-30 17:24:15.268137752 +0300
@@ -705,6 +705,14 @@
 	unsigned long frame, newsp;
 	int signr, ret;
 
+#ifdef CONFIG_PREEMPT_RT
+	/*
+	 * Fully-preemptible kernel does not need interrupts disabled:
+	 */
+	local_irq_enable();
+	preempt_check_resched();
+#endif
+
 	if (try_to_freeze()) {
 		signr = 0;
 		if (!signal_pending(current))

--------------010900090809060105070907--
