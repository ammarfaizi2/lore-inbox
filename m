Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265044AbUF1Pzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265044AbUF1Pzx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 11:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265047AbUF1Pzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 11:55:53 -0400
Received: from everest.2mbit.com ([24.123.221.2]:53171 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S265044AbUF1Pzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 11:55:46 -0400
Message-ID: <40E03F71.8010902@greatcn.org>
Date: Mon, 28 Jun 2004 23:55:29 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org
X-Scan-Signature: 418ef03ee7cfcfbc6c4f32dd4f25d104
X-SA-Exim-Connect-IP: 218.24.186.243
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: [BUG FIX] [PATCH] fork_init() max_low_pfn fixes potential OOM bug
 on big highmem machine
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
	*  3.0 RCVD_IN_AHBL_CNKR RBL: AHBL: sender is listed in the AHBL China/Korea blocks
	*      [218.24.186.243 listed in cnkrbl.ahbl.org]
X-SA-Exim-Version: 4.0 (built Wed, 05 May 2004 12:02:20 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<http://localhost/lxr/ident?i=start_kernel>Hello all,

On machine with 16G(or 8G if 4k stacks) or more memory, high max_threads 
could let system run out of low memory.
This patch decides max_threads by the amount of low memory instead of 
the total physical memory.
Systems without high memory would not be affected.

        Coywolf

=====================================================================
diff -rup linux-2.6.7/init/main.c linux-2.6.7-cy/init/main.c
--- linux-2.6.7/init/main.c	Wed Jun  9 00:07:40 2004
+++ linux-2.6.7-cy/init/main.c	Thu Jun 17 04:55:54 2004
@@ -467,7 +467,7 @@ asmlinkage void __init start_kernel(void
 	if (efi_enabled)
 		efi_enter_virtual_mode();
 #endif
-	fork_init(num_physpages);
+	fork_init(max_low_pfn);
 	proc_caches_init();
 	buffer_init();
 	unnamed_dev_init();
diff -rup linux-2.6.7/kernel/fork.c linux-2.6.7-cy/kernel/fork.c
--- linux-2.6.7/kernel/fork.c	Wed Jun  9 00:07:40 2004
+++ linux-2.6.7-cy/kernel/fork.c	Mon Jun 28 22:55:50 2004
@@ -224,8 +224,8 @@ void __init fork_init(unsigned long memp
 
 	/*
 	 * The default maximum number of threads is set to a safe
-	 * value: the thread structures can take up at most half
-	 * of memory.
+	 * value: the thread structures can take up at most 1/8
+	 * of low memory.
 	 */
 	max_threads = mempages / (THREAD_SIZE/PAGE_SIZE) / 8;
 	/*

-- 
Coywolf Qi Hunt
Admin of http://GreatCN.org and http://LoveCN.org

