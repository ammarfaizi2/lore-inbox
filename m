Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUG2Lov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUG2Lov (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 07:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264412AbUG2Lov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 07:44:51 -0400
Received: from everest.2mbit.com ([24.123.221.2]:194 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S264085AbUG2LnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 07:43:05 -0400
Message-ID: <4108E28F.9030007@greatcn.org>
Date: Thu, 29 Jul 2004 19:42:07 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Dike <jdike@addtoit.com>
CC: akpm@osdl.org, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <41078007.5000802@greatcn.org> <200407281714.i6SHEkeh002948@ccure.user-mode-linux.org>
In-Reply-To: <200407281714.i6SHEkeh002948@ccure.user-mode-linux.org>
X-Scan-Signature: a38a1d79908796c5b11b958ac09f4336
X-SA-Exim-Connect-IP: 218.24.184.157
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: [uml-devel] [PATCH] more cleanup on smp.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
	*  3.0 RCVD_IN_AHBL_CNKR RBL: AHBL: sender is listed in the AHBL China/Korea blocks
	*      [218.24.184.157 listed in cnkrbl.ahbl.org]
X-SA-Exim-Version: 4.0 (built Wed, 05 May 2004 12:02:20 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:

>coywolf@greatcn.org said:
>  
>
>>This patch removes a group of unused bh functions in um. This 2.2
>>legacy code should be cleaned up. 
>>    
>>
>
>Applied to my tree, thanks.
>

This includes the previous remove_old_bh patch, plus 8 more lines 
deletions in the same file.


smp.c |   43 -------------------------------------------
 1 files changed, 43 deletions(-)

diff -Nrup linux-2.6.8-rc2/arch/um/kernel/smp.c linux-2.6.8-rc2-cy/arch/um/kernel/smp.c
--- linux-2.6.8-rc2/arch/um/kernel/smp.c	2004-06-29 23:03:33.000000000 -0500
+++ linux-2.6.8-rc2-cy/arch/um/kernel/smp.c	2004-07-29 06:27:39.069874156 -0500
@@ -33,14 +33,6 @@ EXPORT_SYMBOL(cpu_online_map);
  */
 struct cpuinfo_um cpu_data[NR_CPUS];
 
-spinlock_t um_bh_lock = SPIN_LOCK_UNLOCKED;
-
-atomic_t global_bh_count;
-
-/* Not used by UML */
-unsigned char global_irq_holder = NO_PROC_ID;
-unsigned volatile long global_irq_lock;
-
 /* Set when the idlers are all forked */
 int smp_threads_ready = 0;
 
@@ -59,41 +51,6 @@ void smp_send_reschedule(int cpu)
 	num_reschedules_sent++;
 }
 
-static void show(char * str)
-{
-	int cpu = smp_processor_id();
-
-	printk(KERN_INFO "\n%s, CPU %d:\n", str, cpu);
-}
-	
-#define MAXCOUNT 100000000
-
-static inline void wait_on_bh(void)
-{
-	int count = MAXCOUNT;
-	do {
-		if (!--count) {
-			show("wait_on_bh");
-			count = ~0;
-		}
-		/* nothing .. wait for the other bh's to go away */
-	} while (atomic_read(&global_bh_count) != 0);
-}
-
-/*
- * This is called when we want to synchronize with
- * bottom half handlers. We need to wait until
- * no other CPU is executing any bottom half handler.
- *
- * Don't wait if we're already running in an interrupt
- * context or are inside a bh handler. 
- */
-void synchronize_bh(void)
-{
-	if (atomic_read(&global_bh_count) && !in_interrupt())
-		wait_on_bh();
-}
-
 void smp_send_stop(void)
 {
 	int i;



-- 
Coywolf Qi Hunt
Homepage http://greatcn.org/~coywolf/
Admin of http://GreatCN.org and http://LoveCN.org

