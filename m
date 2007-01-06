Return-Path: <linux-kernel-owner+w=401wt.eu-S1751436AbXAFQ7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbXAFQ7c (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 11:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbXAFQ7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 11:59:32 -0500
Received: from aa013msr.fastwebnet.it ([85.18.95.73]:41632 "EHLO
	aa013msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436AbXAFQ7b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 11:59:31 -0500
Date: Sat, 6 Jan 2007 17:59:06 +0100
From: Mattia Dongili <malattia@linux.it>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.20-rc3-mm1 - rewrite-lock-in-cpufreq-to-eliminate-cpufreq-hotplug-related-issues.patch
Message-ID: <20070106165906.GK13533@inferi.kami.home>
Mail-Followup-To: Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org
References: <20070104220200.ae4e9a46.akpm@osdl.org> <200701061344.l06DipYC003610@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701061344.l06DipYC003610@turing-police.cc.vt.edu>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.20-rc2-mm1-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2007 at 08:44:51AM -0500, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 04 Jan 2007 22:02:00 PST, Andrew Morton said:
> > 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc3-mm1/
> 
> One of these 3 patches:
> 
> rewrite-lock-in-cpufreq-to-eliminate-cpufreq-hotplug-related-issues.patch
> rewrite-lock-in-cpufreq-to-eliminate-cpufreq-hotplug-related-issues-fix.patch
> ondemand-governor-restructure-the-work-callback.patch
> 
> causes an oops in kref_put during early boot ("unable to handle paging
> request at 00078"). 
> 
> Dell Latitude D820 laptop, Core2 T7200 with a 64-bit kernel.
> 
> Hand-copied trace of the oops:
> 
> kobject_put+0x19/0x1b
> cpufreq_cpu_put+0xd/0x1e
> cpufreq_get+0x45/0x51
> handle_cpufreq_delayed_get+0x1e/0x41
> run_workqueue+0x9c/0x14e
> worker_thread+0x0/0x145
> worker_thread+0x10e/0x145
> default_wake_function+0x0/0xf
> worker_thread+0x0/0x145
> kthread+0x8/0x10b
> schedule_tail+0x38/0xa1
> child_rip+0xa/0x12
> kthread+0x0/0x10b
> child_rip+0x0/0x12

Does the following help?

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a7b17ab..1112f31 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1113,14 +1113,15 @@ unsigned int cpufreq_get(unsigned int cpu)
 		goto out;
 
 	if (unlikely(lock_policy_rwsem_read(cpu)))
-		goto out;
+		goto out_policy;
 
 	ret_freq = __cpufreq_get(cpu);
 
 	unlock_policy_rwsem_read(cpu);
 
-out:
+out_policy:
 	cpufreq_cpu_put(policy);
+out:
 	return (ret_freq);
 }
 EXPORT_SYMBOL(cpufreq_get);
-- 
mattia
:wq!
