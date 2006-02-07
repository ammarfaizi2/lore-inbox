Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbWBGWdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWBGWdb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbWBGWdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:33:31 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:33192 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030210AbWBGWda
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:33:30 -0500
Subject: [PATCH -mm] i386: Don't disable the TSC on single node NUMAQs
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, "Martin J. Bligh" <mbligh@google.com>,
       apw@uk.ibm.com
Content-Type: text/plain
Date: Tue, 07 Feb 2006 14:33:27 -0800
Message-Id: <1139351607.10057.223.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Currently on NUMAQ hardware we set tsc_disable=1 because on multi-node
NUMAQ hardware the TSC is not synced. However, it is safe to use the TSC
on single node NUMAQs. Thus this patch only disables the TSC if
num_online_nodes() > 1.

This should fix performance issues seen w/ -mm by mbligh on elm3b132
(which is a single node NUMAQ). These performance issues originated
because with mainline code, the function that disables the TSC runs
after time_init, thus the TSC is used regardless, allowing for possible
timekeeping errors on multi-node systems.

With my new timekeeping work (in 2.6.16-rc1-mm1,mm2 and mm5), we do not
select the TSC until later, so we see the TSC has been disabled and use
the slower PIT instead as the original code intends. This caused the
performance regression. 

While this patch allows the TSC to be used safely only on single node
NUMAQs, multi-node NUMAQs may still see a performance drop from using
the PIT, but this is necessary as using unsynched TSCs will result in
incorrect timekeeping. 


For test results, please see the graph:
	http://test.kernel.org/perf/kernbench.elm3b132.png

2.6.16-rc1-mm5: without this patch
2.6.16-rc1-mm5+p22126: with this patch


This patch also fixes the typo'ed function name.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

diff --git a/arch/i386/kernel/numaq.c b/arch/i386/kernel/numaq.c
index 5f5b075..0caf146 100644
--- a/arch/i386/kernel/numaq.c
+++ b/arch/i386/kernel/numaq.c
@@ -79,10 +79,12 @@ int __init get_memcfg_numaq(void)
 	return 1;
 }
 
-static int __init numaq_dsc_disable(void)
+static int __init numaq_tsc_disable(void)
 {
-	printk(KERN_DEBUG "NUMAQ: disabling TSC\n");
-	tsc_disable = 1;
+	if (num_online_nodes() > 1) {
+		printk(KERN_DEBUG "NUMAQ: disabling TSC\n");
+		tsc_disable = 1;
+	}
 	return 0;
 }
-core_initcall(numaq_dsc_disable);
+arch_initcall(numaq_tsc_disable);


