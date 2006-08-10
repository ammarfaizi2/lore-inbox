Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932673AbWHJT5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932673AbWHJT5I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWHJTzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:55:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:7660 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932662AbWHJThQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:16 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [116/145] i386: don't taint UP K7's running SMP kernels.
Message-Id: <20060810193715.12CE713C16@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:15 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Dave Jones <davej@redhat.com>

We have a test that looks for invalid pairings of certain athlon/durons
that weren't designed for SMP, and taint accordingly (with 'S') if we find
such a configuration.  However, this test shouldn't fire if there's only
a single CPU present. It's perfectly valid for an SMP kernel to boot on UP
hardware for example.

AK: changed to num_possible_cpus()

Signed-off-by: Dave Jones <davej@redhat.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/smpboot.c |    3 +++
 1 files changed, 3 insertions(+)

Index: linux/arch/i386/kernel/smpboot.c
===================================================================
--- linux.orig/arch/i386/kernel/smpboot.c
+++ linux/arch/i386/kernel/smpboot.c
@@ -177,6 +177,9 @@ static void __devinit smp_store_cpu_info
 	 */
 	if ((c->x86_vendor == X86_VENDOR_AMD) && (c->x86 == 6)) {
 
+		if (num_possible_cpus() == 1)
+			goto valid_k7;
+
 		/* Athlon 660/661 is valid. */	
 		if ((c->x86_model==6) && ((c->x86_mask==0) || (c->x86_mask==1)))
 			goto valid_k7;
