Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVGCVEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVGCVEp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 17:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVGCVDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 17:03:34 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53681 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261542AbVGCVCC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 17:02:02 -0400
Date: Sun, 3 Jul 2005 22:38:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Cc: davej@codemonkey.org.uk, cpufreq@lists.linux.org.uk
Subject: [patch] fix u32 vs. pm_message_t confusion in cpufreq
Message-ID: <20050703203806.GA2715@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bernard Blackham <bernard@blackham.com.au>

Fix u32 vs pm_message_t confusion in cpufreq.

Signed-off-by: Bernard Blackham <bernard@blackham.com.au>
Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 6780dabdaed66056555f71892e164ee75dd216ae
tree 11d5c08aafecbba7a6f724f2ff46b8956e834b94
parent d12ef8b1f693eac4f683a09d8ff341bfe78d69b7
author <pavel@amd.(none)> Tue, 21 Jun 2005 23:43:49 +0200
committer <pavel@amd.(none)> Tue, 21 Jun 2005 23:43:49 +0200

 arch/ppc/platforms/pmac_cpufreq.c |    2 +-
 drivers/cpufreq/cpufreq.c         |    4 ++--
 include/linux/cpufreq.h           |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/ppc/platforms/pmac_cpufreq.c b/arch/ppc/platforms/pmac_cpufreq.c
--- a/arch/ppc/platforms/pmac_cpufreq.c
+++ b/arch/ppc/platforms/pmac_cpufreq.c
@@ -452,7 +452,7 @@ static u32 __pmac read_gpio(struct devic
 	return offset;
 }
 
-static int __pmac pmac_cpufreq_suspend(struct cpufreq_policy *policy, u32 state)
+static int __pmac pmac_cpufreq_suspend(struct cpufreq_policy *policy, pm_message_t pmsg)
 {
 	/* Ok, this could be made a bit smarter, but let's be robust for now. We
 	 * always force a speed change to high speed before sleep, to make sure
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -869,7 +869,7 @@ EXPORT_SYMBOL(cpufreq_get);
  *	cpufreq_suspend - let the low level driver prepare for suspend
  */
 
-static int cpufreq_suspend(struct sys_device * sysdev, u32 state)
+static int cpufreq_suspend(struct sys_device * sysdev, pm_message_t pmsg)
 {
 	int cpu = sysdev->id;
 	unsigned int ret = 0;
@@ -897,7 +897,7 @@ static int cpufreq_suspend(struct sys_de
 	}
 
 	if (cpufreq_driver->suspend) {
-		ret = cpufreq_driver->suspend(cpu_policy, state);
+		ret = cpufreq_driver->suspend(cpu_policy, pmsg);
 		if (ret) {
 			printk(KERN_ERR "cpufreq: suspend failed in ->suspend "
 					"step on CPU %u\n", cpu_policy->cpu);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -201,7 +201,7 @@ struct cpufreq_driver {
 
 	/* optional */
 	int	(*exit)		(struct cpufreq_policy *policy);
-	int	(*suspend)	(struct cpufreq_policy *policy, u32 state);
+	int	(*suspend)	(struct cpufreq_policy *policy, pm_message_t pmsg);
 	int	(*resume)	(struct cpufreq_policy *policy);
 	struct freq_attr	**attr;
 };

-- 
teflon -- maybe it is a trademark, but it should not be.
