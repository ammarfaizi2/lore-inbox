Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751562AbWHJUOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbWHJUOZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbWHJTf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:35:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:12779 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932401AbWHJTfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:39 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [21/145] x86_64: kdump x86_64 nmi event notification fix
Message-Id: <20060810193534.312A313B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:34 +0200 (CEST)
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

 arch/x86_64/kernel/crash.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux/arch/x86_64/kernel/crash.c
===================================================================
--- linux.orig/arch/x86_64/kernel/crash.c
+++ linux/arch/x86_64/kernel/crash.c
@@ -102,7 +102,7 @@ static int crash_nmi_callback(struct not
 	struct pt_regs *regs;
 	int cpu;
 
-	if (val != DIE_NMI)
+	if (val != DIE_NMI_IPI)
 		return NOTIFY_OK;
 
 	regs = ((struct die_args *)data)->regs;
@@ -114,7 +114,7 @@ static int crash_nmi_callback(struct not
 	 * an NMI if system was initially booted with nmi_watchdog parameter.
 	 */
 	if (cpu == crashing_cpu)
-		return 1;
+		return NOTIFY_STOP;
 	local_irq_disable();
 
 	crash_save_this_cpu(regs, cpu);
