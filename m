Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265206AbUFBW6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265206AbUFBW6g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 18:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265230AbUFBW6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 18:58:35 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:26578 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S265206AbUFBW6I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 18:58:08 -0400
Message-ID: <40BE5B6E.7060109@austin.ibm.com>
Date: Wed, 02 Jun 2004 17:57:50 -0500
From: Nathan Lynch <nathanl@austin.ibm.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>
Subject: [PATCH] ppc64 gives up too quickly on hotplugged cpu
Content-Type: multipart/mixed;
 boundary="------------000400050000070907000809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000400050000070907000809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi-

On some systems it can take a hotplugged cpu much longer to come up than 
it would at boot.  If the cpu comes up after we've given up on it, it 
tends to die in its first attempt to kmem_cache_alloc (uninitialized 
percpu data, I imagine).

In my experimentation I haven't seen a processor take more than one 
second to become available; the patch waits five seconds just to be safe.

Patch is against 2.6.7-rc2; please apply.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>

--------------000400050000070907000809
Content-Type: text/x-patch;
 name="ppc64_cpu_up_be_more_patient.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc64_cpu_up_be_more_patient.patch"

diff -Naurp -X ../dontdiff 2.6.7-rc2/arch/ppc64/kernel/smp.c 2.6.7-rc2.new/arch/ppc64/kernel/smp.c
--- 2.6.7-rc2/arch/ppc64/kernel/smp.c	2004-06-02 17:08:48.000000000 -0500
+++ 2.6.7-rc2.new/arch/ppc64/kernel/smp.c	2004-06-02 17:12:16.000000000 -0500
@@ -912,8 +912,20 @@ int __devinit __cpu_up(unsigned int cpu)
 	 * use this value that I found through experimentation.
 	 * -- Cort
 	 */
-	for (c = 5000; c && !cpu_callin_map[cpu]; c--)
-		udelay(100);
+	if (system_state == SYSTEM_BOOTING)
+		for (c = 5000; c && !cpu_callin_map[cpu]; c--)
+			udelay(100);
+#ifdef CONFIG_HOTPLUG_CPU
+	else
+		/* 
+		 * CPUs can take much longer to come up in the
+		 * hotplug case.  Wait five seconds.
+		 */
+		for (c = 25; c && !cpu_callin_map[cpu]; c--) {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout(HZ/5);
+		}
+#endif
 
 	if (!cpu_callin_map[cpu]) {
 		printk("Processor %u is stuck.\n", cpu);

--------------000400050000070907000809--
