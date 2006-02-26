Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWBZXIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWBZXIK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 18:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWBZXIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 18:08:10 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:20102 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932235AbWBZXIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 18:08:09 -0500
Subject: [PATCH] fix voyager after topology.c move
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Dan Hecht <dhect@vmware.com>, Zachary Amsden <zach@vmware.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 26 Feb 2006 17:07:45 -0600
Message-Id: <1140995265.3692.20.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch:

[PATCH] Fix topology.c location

Broke voyager again rather subtly because it already had its own
topology exporting functions, so now each CPU gets registered twice.  I
think we can actually use the generic ones, so I don't propose reverting
it.  The attached should eliminate the voyager topology functions in
favour of the generic ones.  I also added a define to ensure voyager is
never hotplug CPU (we don't have the support in the SMP harness).

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

---

diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index 0afec85..af41159 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -733,7 +733,7 @@ config PHYSICAL_START
 
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
-	depends on SMP && HOTPLUG && EXPERIMENTAL
+	depends on SMP && HOTPLUG && EXPERIMENTAL && !X86_VOYAGER
 	---help---
 	  Say Y here to experiment with turning CPUs off and on.  CPUs
 	  can be controlled through /sys/devices/system/cpu.
diff --git a/arch/i386/mach-voyager/voyager_basic.c b/arch/i386/mach-voyager/voyager_basic.c
index 6761d29..b584060 100644
--- a/arch/i386/mach-voyager/voyager_basic.c
+++ b/arch/i386/mach-voyager/voyager_basic.c
@@ -25,7 +25,6 @@
 #include <linux/sysrq.h>
 #include <linux/smp.h>
 #include <linux/nodemask.h>
-#include <asm/cpu.h>
 #include <asm/io.h>
 #include <asm/voyager.h>
 #include <asm/vic.h>
@@ -331,16 +330,3 @@ void machine_power_off(void)
 	if (pm_power_off)
 		pm_power_off();
 }
-
-static struct i386_cpu cpu_devices[NR_CPUS];
-
-static int __init topology_init(void)
-{
-	int i;
-
-	for_each_present_cpu(i)
-		register_cpu(&cpu_devices[i].cpu, i, NULL);
-	return 0;
-}
-
-subsys_initcall(topology_init);


