Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752448AbWCPRo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448AbWCPRo5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 12:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752447AbWCPRo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 12:44:57 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:3812 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752448AbWCPRo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 12:44:56 -0500
Date: Thu, 16 Mar 2006 23:14:47 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, shaohua.li@intel.com, bryce@osdl.org
Subject: [PATCH] Check for online cpus before bringing them up
Message-ID: <20060316174447.GA8184@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryce reported a bug wherein offlining CPU0 (on x86 box) and then subsequently
onlining it resulted in a lockup. 

On x86, CPU0 is never offlined. The subsequent attempt to online CPU0
doesn't take that into account. It actually tries to bootup the already
booted CPU. Following patch fixes the problem (as acknowledged by
Bryce). Please consider for inclusion in 2.6.16.




Check if cpu is already online.

Signed-off-by : Srivatsa Vaddagiri <vatsa@in.ibm.com>

-

 arch/i386/kernel/smpboot.c |    6 ++++++
 1 files changed, 6 insertions(+)

diff -puN arch/i386/kernel/smpboot.c~cpuhp arch/i386/kernel/smpboot.c
--- linux-2.6.16-rc5/arch/i386/kernel/smpboot.c~cpuhp	2006-03-14 14:42:26.000000000 +0530
+++ linux-2.6.16-rc5-root/arch/i386/kernel/smpboot.c	2006-03-14 14:43:21.000000000 +0530
@@ -1029,6 +1029,12 @@ int __devinit smp_prepare_cpu(int cpu)
 	int	apicid, ret;
 
 	lock_cpu_hotplug();
+
+	if (cpu_online(cpu)) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
 	apicid = x86_cpu_to_apicid[cpu];
 	if (apicid == BAD_APICID) {
 		ret = -ENODEV;

_


-- 
Regards,
vatsa
