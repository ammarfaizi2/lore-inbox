Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263783AbTJETW7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 15:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbTJETW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 15:22:59 -0400
Received: from gprs148-216.eurotel.cz ([160.218.148.216]:6784 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263783AbTJETWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 15:22:54 -0400
Date: Sun, 5 Oct 2003 21:22:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: paul.devriendt@amd.com, davej@redhat.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: powernowk8: microcleanups
Message-ID: <20031005192227.GA881@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

When you get oops in drv_init... its bad. Thus I renamed drv_* to
powernowk8_*, so oopsen are readable. Printing "drv_init" to user is
*really* bad. Please apply,
								Pavel

Index: arch/i386/kernel/cpu/cpufreq/powernow-k8.c
===================================================================
RCS file: /home/pavel/sf/bitbucket/bkcvs/linux-2.5/arch/i386/kernel/cpu/cpufreq/powernow-k8.c,v
retrieving revision 1.2
diff -u -u -r1.2 powernow-k8.c
--- arch/i386/kernel/cpu/cpufreq/powernow-k8.c	1 Oct 2003 17:33:23 -0000	1.2
+++ arch/i386/kernel/cpu/cpufreq/powernow-k8.c	5 Oct 2003 19:07:41 -0000
@@ -72,9 +72,9 @@
 			/* - set by BIOS in the PSB/PST                    */
 
 static struct cpufreq_driver cpufreq_amd64_driver = {
-	.verify = drv_verify,
-	.target = drv_target,
-	.init = drv_cpu_init,
+	.verify = powernowk8_verify,
+	.target = powernowk8_target,
+	.init = powernowk8_cpu_init,
 	.name = "cpufreq-amd64",
 	.owner = THIS_MODULE,
 };
@@ -90,7 +90,7 @@
 }
 
 /* Return a fid matching an input frequency in MHz */
-u32
+static u32
 find_fid_from_freq(u32 freq)
 {
 	return (freq - 800) / 100;
@@ -718,7 +718,7 @@
 
 /* Converts a frequency (that might not necessarily be a multiple of 200) */
 /* to a fid.                                                              */
-u32
+static u32
 find_closest_fid(u32 freq, int searchup)
 {
 	if (searchup == SEARCH_UP)
@@ -861,7 +861,7 @@
 
 /* Driver entry point to switch to the target frequency */
 static int
-drv_target(struct cpufreq_policy *pol, unsigned targfreq, unsigned relation)
+powernowk8_target(struct cpufreq_policy *pol, unsigned targfreq, unsigned relation)
 {
 	u32 checkfid = currfid;
 	u32 checkvid = currvid;
@@ -909,7 +909,7 @@
 
 /* Driver entry point to verify the policy and range of frequencies */
 static int
-drv_verify(struct cpufreq_policy *pol)
+powernowk8_verify(struct cpufreq_policy *pol)
 {
 	u32 min = pol->min / 1000;
 	u32 max = pol->max / 1000;
@@ -947,7 +947,7 @@
 
 /* per CPU init entry point to the driver */
 static int __init
-drv_cpu_init(struct cpufreq_policy *pol)
+powernowk8_cpu_init(struct cpufreq_policy *pol)
 {
 	if (pol->cpu != 0) {
 		printk(KERN_ERR PFX "init not cpu 0\n");
@@ -980,7 +981,7 @@
 
 /* driver entry point for init */
 static int __init
-drv_init(void)
+powernowk8_init(void)
 {
 	int rc;
 
@@ -994,7 +995,7 @@
 		return rc;
 
 	if (pending_bit_stuck()) {
-		printk(KERN_ERR PFX "drv_init fail, change pending bit set\n");
+		printk(KERN_ERR PFX "powernowk8_init fail, change pending bit set\n");
 		kfree(ppst);
 		return -EIO;
 	}
@@ -1004,9 +1005,9 @@
 
 /* driver entry point for term */
 static void __exit
-drv_exit(void)
+powernowk8_exit(void)
 {
-	dprintk(KERN_INFO PFX "drv_exit\n");
+	dprintk(KERN_INFO PFX "powernowk8_exit\n");
 
 	cpufreq_unregister_driver(&cpufreq_amd64_driver);
 	kfree(ppst);
@@ -1016,5 +1017,5 @@
 MODULE_DESCRIPTION("AMD Athlon 64 and Opteron processor frequency driver.");
 MODULE_LICENSE("GPL");
 
-module_init(drv_init);
-module_exit(drv_exit);
+module_init(powernowk8_init);
+module_exit(powernowk8_exit);
Index: arch/i386/kernel/cpu/cpufreq/powernow-k8.h
===================================================================
RCS file: /home/pavel/sf/bitbucket/bkcvs/linux-2.5/arch/i386/kernel/cpu/cpufreq/powernow-k8.h,v
retrieving revision 1.2
diff -u -u -r1.2 powernow-k8.h
--- arch/i386/kernel/cpu/cpufreq/powernow-k8.h	1 Oct 2003 17:33:23 -0000	1.2
+++ arch/i386/kernel/cpu/cpufreq/powernow-k8.h	5 Oct 2003 19:08:41 -0000
@@ -120,7 +120,7 @@
 static inline int core_voltage_pre_transition(u32 reqvid);
 static inline int core_voltage_post_transition(u32 reqvid);
 static inline int core_frequency_transition(u32 reqfid);
-static int drv_verify(struct cpufreq_policy *pol);
-static int drv_target(struct cpufreq_policy *pol, unsigned targfreq,
+static int powernowk8_verify(struct cpufreq_policy *pol);
+static int powernowk8_target(struct cpufreq_policy *pol, unsigned targfreq,
 		      unsigned relation);
-static int __init drv_cpu_init(struct cpufreq_policy *pol);
+static int __init powernowk8_cpu_init(struct cpufreq_policy *pol);

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
