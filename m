Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbVCHJ4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVCHJ4b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 04:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbVCHJ4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 04:56:30 -0500
Received: from ozlabs.org ([203.10.76.45]:4310 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261939AbVCHJ4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 04:56:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16941.30361.394084.376509@cargo.ozlabs.ibm.com>
Date: Tue, 8 Mar 2005 20:55:37 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: ntl@pobox.com, anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 call idle_task_exit with irqs disabled
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Nathan Lynch <ntl@pobox.com>.

Seeing this very occasionally during cpu hotplug testing:

 Badness in slb_flush_and_rebolt at arch/ppc64/mm/slb.c:52
 Call Trace:
 [c0000000ef0efbe0] [c0000000000127a0] .__switch_to+0xa4/0xf0 (unreliable)
 [c0000000ef0efc80] [c000000000050178] .idle_task_exit+0xbc/0x15c
 [c0000000ef0efd10] [c00000000000d108] .cpu_die+0x18/0x68
 [c0000000ef0efd90] [c00000000001023c] .dedicated_idle+0x1fc/0x254
 [c0000000ef0efe80] [c00000000000fc80] .cpu_idle+0x3c/0x54
 [c0000000ef0eff00] [c00000000003aa90] .start_secondary+0x108/0x148
 [c0000000ef0eff90] [c00000000000bd28] .enable_64b_mode+0x0/0x28

idle_task_exit can result in a call to slb_flush_and_rebolt, which
must not be called with interrupts enabled.  Make the call with
interrupts disabled.


Signed-off-by: Nathan Lynch <ntl@pobox.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

 pSeries_setup.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.11-bk2/arch/ppc64/kernel/pSeries_setup.c
===================================================================
--- linux-2.6.11-bk2.orig/arch/ppc64/kernel/pSeries_setup.c	2005-03-07 04:09:29.000000000 +0000
+++ linux-2.6.11-bk2/arch/ppc64/kernel/pSeries_setup.c	2005-03-07 04:15:22.000000000 +0000
@@ -322,8 +322,8 @@ static  void __init pSeries_discover_pic
 
 static void pSeries_mach_cpu_die(void)
 {
-	idle_task_exit();
 	local_irq_disable();
+	idle_task_exit();
 	/* Some hardware requires clearing the CPPR, while other hardware does not
 	 * it is safe either way
 	 */
