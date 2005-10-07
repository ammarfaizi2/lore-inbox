Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbVJGEOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbVJGEOe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 00:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbVJGEOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 00:14:34 -0400
Received: from quark.didntduck.org ([69.55.226.66]:31881 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1751368AbVJGEOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 00:14:33 -0400
Message-ID: <4345F656.9020601@didntduck.org>
Date: Fri, 07 Oct 2005 00:15:18 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.4 (X11/20050928)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Subject: [PATCH] Fix hotplug cpu on x86_64
References: <43437DEB.4080405@didntduck.org> <434414C4.8020109@didntduck.org>
In-Reply-To: <434414C4.8020109@didntduck.org>
Content-Type: multipart/mixed;
 boundary="------------050301060403040101070103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050301060403040101070103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Brian Gerst wrote:
> Brian Gerst wrote:
>> I've been seeing bogus values from /proc/loadavg on an x86-64 SMP 
>> kernel (but not UP).
>>
>> $ cat /proc/loadavg
>> -1012098.26 922203.26 -982431.60 1/112 2688
>>
>> This is in the current git tree.  I'm also seeing strange values in 
>> /proc/stat:
>>
>> cpu  2489 40 920 60530 9398 171 288 1844674407350
>> cpu0 2509 60 940 60550 9418 191 308 0
>>
>> The first line is the sum of all cpus (I only have one), so it's 
>> picking up up bad data from the non-present cpus.  The last value, 
>> stolen time, is completely bogus since that value is only ever used on 
>> s390.
>>
>> It looks to me like there is some problem with how the per-cpu 
>> structures are being initialized, or are getting corrupted.  I have 
>> not been able to test i386 SMP yet to see if the problem is x86_64 
>> specific.
> 
> I found the culprit: CPU hotplug.  The problem is that 
> prefill_possible_map() is called after setup_per_cpu_areas().  This 
> leaves the per-cpu data sections for the future cpus uninitialized 
> (still pointing to the original per-cpu data, which is initmem).  Since 
> the cpus exists in cpu_possible_map, for_each_cpu will iterate over them 
> even though the per-cpu data is invalid.

Initialize cpu_possible_map properly in the hotplug cpu case.  Before 
this, the map was filled in after the per-cpu areas were set up.  This 
left those cpus pointing to initmem and causing invalid data in 
/proc/stat and elsewhere.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

--------------050301060403040101070103
Content-Type: text/plain;
 name="0001-Fix-hotplug-cpu-on-x86_64.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Fix-hotplug-cpu-on-x86_64.txt"

Subject: [PATCH] Fix hotplug cpu on x86_64

Initialize cpu_possible_map properly in the hotplug cpu case.  Before
this, the map was filled in after the per-cpu areas were set up.  This left
those cpus pointing to initmem and causing invalid data in /proc/stat and
elsewhere.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

---

 arch/x86_64/kernel/smpboot.c |   41 ++++++++++++++++-------------------------
 1 files changed, 16 insertions(+), 25 deletions(-)

12027fcffd85447f0fbf28264c5ee072715c345b
diff --git a/arch/x86_64/kernel/smpboot.c b/arch/x86_64/kernel/smpboot.c
--- a/arch/x86_64/kernel/smpboot.c
+++ b/arch/x86_64/kernel/smpboot.c
@@ -80,7 +80,23 @@ EXPORT_SYMBOL(cpu_online_map);
 cpumask_t cpu_callin_map;
 cpumask_t cpu_callout_map;
 
+#ifdef CONFIG_HOTPLUG_CPU
+/*
+ * cpu_possible_map should be static, it cannot change as cpu's
+ * are onlined, or offlined. The reason is per-cpu data-structures
+ * are allocated by some modules at init time, and dont expect to
+ * do this dynamically on cpu arrival/departure.
+ * cpu_present_map on the other hand can change dynamically.
+ * In case when cpu_hotplug is not compiled, then we resort to current
+ * behaviour, which is cpu_possible == cpu_present.
+ * If cpu-hotplug is supported, then we need to preallocate for all
+ * those NR_CPUS, hence cpu_possible_map represents entire NR_CPUS range.
+ * - Ashok Raj
+ */
+cpumask_t cpu_possible_map = CPU_MASK_ALL;
+#else
 cpumask_t cpu_possible_map;
+#endif
 EXPORT_SYMBOL(cpu_possible_map);
 
 /* Per CPU bogomips and other parameters */
@@ -879,27 +895,6 @@ static __init void disable_smp(void)
 	cpu_set(0, cpu_core_map[0]);
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
-/*
- * cpu_possible_map should be static, it cannot change as cpu's
- * are onlined, or offlined. The reason is per-cpu data-structures
- * are allocated by some modules at init time, and dont expect to
- * do this dynamically on cpu arrival/departure.
- * cpu_present_map on the other hand can change dynamically.
- * In case when cpu_hotplug is not compiled, then we resort to current
- * behaviour, which is cpu_possible == cpu_present.
- * If cpu-hotplug is supported, then we need to preallocate for all
- * those NR_CPUS, hence cpu_possible_map represents entire NR_CPUS range.
- * - Ashok Raj
- */
-static void prefill_possible_map(void)
-{
-	int i;
-	for (i = 0; i < NR_CPUS; i++)
-		cpu_set(i, cpu_possible_map);
-}
-#endif
-
 /*
  * Various sanity checks.
  */
@@ -967,10 +962,6 @@ void __init smp_prepare_cpus(unsigned in
 	current_cpu_data = boot_cpu_data;
 	current_thread_info()->cpu = 0;  /* needed? */
 
-#ifdef CONFIG_HOTPLUG_CPU
-	prefill_possible_map();
-#endif
-
 	if (smp_sanity_check(max_cpus) < 0) {
 		printk(KERN_INFO "SMP disabled\n");
 		disable_smp();

--------------050301060403040101070103--
