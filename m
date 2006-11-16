Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423697AbWKPK06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423697AbWKPK06 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 05:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423712AbWKPK05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 05:26:57 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:15513 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1423697AbWKPK05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 05:26:57 -0500
Date: Thu, 16 Nov 2006 11:21:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [patch, -rc6] x86_64: UP build fix, arch/x86_64/kernel/mce_amd.c
Message-ID: <20061116102115.GA8379@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -3.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.3 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_05 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-0.4 BAYES_05               BODY: Bayesian spam probability is 1 to 5%
	[score: 0.0213]
	0.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] x86_64: UP build fix, arch/x86_64/kernel/mce_amd.c
From: Ingo Molnar <mingo@elte.hu>

fix x86_64/kernel/mce_amd.c build bug:

 arch/x86_64/kernel/mce_amd.c: In function ‘threshold_remove_bank’:
 arch/x86_64/kernel/mce_amd.c:597: error: ‘shared_bank’ undeclared (first use in this function)
 arch/x86_64/kernel/mce_amd.c:597: error: (Each undeclared identifier is reported only once
 arch/x86_64/kernel/mce_amd.c:597: error: for each function it appears in.)
 make[1]: *** [arch/x86_64/kernel/mce_amd.o] Error 1
 make: *** [arch/x86_64/kernel/mce_amd.o] Error 2

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/x86_64/kernel/mce_amd.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux/arch/x86_64/kernel/mce_amd.c
===================================================================
--- linux.orig/arch/x86_64/kernel/mce_amd.c
+++ linux/arch/x86_64/kernel/mce_amd.c
@@ -593,12 +593,14 @@ static void threshold_remove_bank(unsign
 
 	sprintf(name, "threshold_bank%i", bank);
 
+#ifdef CONFIG_SMP
 	/* sibling symlink */
 	if (shared_bank[bank] && b->blocks->cpu != cpu) {
 		sysfs_remove_link(&per_cpu(device_mce, cpu).kobj, name);
 		per_cpu(threshold_banks, cpu)[bank] = NULL;
 		return;
 	}
+#endif
 
 	/* remove all sibling symlinks before unregistering */
 	for_each_cpu_mask(i, b->cpus) {
