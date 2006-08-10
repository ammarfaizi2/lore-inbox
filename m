Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWHJUOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWHJUOa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbWHJTf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:35:57 -0400
Received: from ns2.suse.de ([195.135.220.15]:12523 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932383AbWHJTfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:39 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [22/145] x86_64: Kdump i386 nmi event notification fix
Message-Id: <20060810193535.3FF0F13B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:35 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Vivek Goyal <vgoyal@in.ibm.com>

After a crash we should wait for NMI IPI event and not for external NMI or
NMI watchdog tick.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
Signed-off-by: Andi Kleen <ak@suse.de>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/i386/kernel/crash.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux/arch/i386/kernel/crash.c
===================================================================
--- linux.orig/arch/i386/kernel/crash.c
+++ linux/arch/i386/kernel/crash.c
@@ -102,7 +102,7 @@ static int crash_nmi_callback(struct not
 	struct pt_regs fixed_regs;
 	int cpu;
 
-	if (val != DIE_NMI)
+	if (val != DIE_NMI_IPI)
 		return NOTIFY_OK;
 
 	regs = ((struct die_args *)data)->regs;
@@ -113,7 +113,7 @@ static int crash_nmi_callback(struct not
 	 * an NMI if system was initially booted with nmi_watchdog parameter.
 	 */
 	if (cpu == crashing_cpu)
-		return 1;
+		return NOTIFY_STOP;
 	local_irq_disable();
 
 	if (!user_mode_vm(regs)) {
