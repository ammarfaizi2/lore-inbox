Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbTESNNz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 09:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbTESNNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 09:13:55 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:38017
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S262459AbTESNNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 09:13:54 -0400
Date: Mon, 19 May 2003 09:17:09 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5] APM does unsafe conditional set_cpus_allowed
Message-ID: <Pine.LNX.4.50.0305190907510.28750-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kapmd does a conditional check in order to decide whether to set the 
task's cpu affinity mask. This can change during runtime, therefore we 
unconditionally set it. There is an early exit in set_cpus_allowed if the 
current processor is in the allowed mask anyway.

	Zwane

Index: linux-2.5-devel/arch/i386/kernel/apm.c
===================================================================
RCS file: /home/cvs/linux-2.5/arch/i386/kernel/apm.c,v
retrieving revision 1.52
diff -u -p -B -r1.52 apm.c
--- linux-2.5-devel/arch/i386/kernel/apm.c	15 May 2003 03:43:20 -0000	1.52
+++ linux-2.5-devel/arch/i386/kernel/apm.c	19 May 2003 12:14:05 -0000
@@ -512,9 +512,8 @@ static unsigned long apm_save_cpus(void)
 {
 	unsigned long x = current->cpus_allowed;
 	/* Some bioses don't like being called from CPU != 0 */
-	set_cpus_allowed(current, 1 << 0);
-	if (unlikely(smp_processor_id() != 0))
-		BUG();
+	set_cpus_allowed(current, 1UL << 0);
+	BUG_ON(smp_processor_id() != 0);
 	return x;
 }
 
@@ -914,11 +913,8 @@ static void apm_power_off(void)
 	 */
 #ifdef CONFIG_SMP
 	/* Some bioses don't like being called from CPU != 0 */
-	if (smp_processor_id() != 0) {
-		set_cpus_allowed(current, 1 << 0);
-		if (unlikely(smp_processor_id() != 0))
-			BUG();
-	}
+	set_cpus_allowed(current, 1UL << 0);
+	BUG_ON(smp_processor_id() != 0);
 #endif
 	if (apm_info.realmode_power_off)
 	{
@@ -1708,11 +1704,8 @@ static int apm(void *unused)
 	 * Some bioses don't like being called from CPU != 0.
 	 * Method suggested by Ingo Molnar.
 	 */
-	if (smp_processor_id() != 0) {
-		set_cpus_allowed(current, 1 << 0);
-		if (unlikely(smp_processor_id() != 0))
-			BUG();
-	}
+	set_cpus_allowed(current, 1UL << 0);
+	BUG_ON(smp_processor_id() != 0);
 #endif
 
 	if (apm_info.connection_version == 0) {
-- 
function.linuxpower.ca
