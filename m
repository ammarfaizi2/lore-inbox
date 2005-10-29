Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbVJ2LfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbVJ2LfB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 07:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbVJ2LfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 07:35:01 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:12197 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1751013AbVJ2LfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 07:35:00 -0400
Message-ID: <43635E35.4050408@colorfullife.com>
Date: Sat, 29 Oct 2005 13:34:13 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: kenneth.w.chen@intel.com, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] slab: Use same schedule timeout for all cpus in cache_reap
Content-Type: multipart/mixed;
 boundary="------------010407050601030401060406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010407050601030401060406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Chen noticed that cache_reap uses REAPTIMEOUT_CPUC+smp_processor_id() as 
the timeout for rescheduling.
The "+smp_processor_id()" part is wrong, the timeout should be identical 
for all cpus: start_cpu_timer already adds a cpu dependant offset to 
avoid any clustering.
The attached patch removes smp_processor_id().

Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>

--------------010407050601030401060406
Content-Type: text/plain;
 name="patch-slab-notimeoffset"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-notimeoffset"

--- 2.6/mm/slab.c	2005-10-29 13:17:44.000000000 +0200
+++ build-2.6/mm/slab.c	2005-10-29 13:18:14.000000000 +0200
@@ -3276,7 +3276,7 @@
 
 	if (down_trylock(&cache_chain_sem)) {
 		/* Give up. Setup the next iteration. */
-		schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC + smp_processor_id());
+		schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC);
 		return;
 	}
 
@@ -3345,7 +3345,7 @@
 	up(&cache_chain_sem);
 	drain_remote_pages();
 	/* Setup the next iteration */
-	schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC + smp_processor_id());
+	schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC);
 }
 
 #ifdef CONFIG_PROC_FS

--------------010407050601030401060406--
