Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759033AbWK3E0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759033AbWK3E0o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 23:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759014AbWK3E0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 23:26:23 -0500
Received: from www.swissdisk.com ([216.66.254.197]:23219 "EHLO
	swissweb.swissdisk.com") by vger.kernel.org with ESMTP
	id S1759015AbWK3E0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 23:26:18 -0500
From: Ben Collins <bcollins@ubuntu.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: [PATCH 1/4] [x86] Add command line option to enable/disable hyper-threading.
Reply-To: Ben Collins <bcollins@ubuntu.com>
Date: Wed, 29 Nov 2006 23:26:05 -0500
Message-Id: <11648607733630-git-send-email-bcollins@ubuntu.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11648607683157-git-send-email-bcollins@ubuntu.com>
References: <11648607683157-git-send-email-bcollins@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a config option to allow disabling hyper-threading by
default, and a kernel command line option to changes this default at
boot time.

Signed-off-by: Ben Collins <bcollins@ubuntu.com>
---
 Documentation/kernel-parameters.txt |    3 +++
 arch/i386/Kconfig                   |    5 +++++
 arch/i386/kernel/cpu/common.c       |   29 +++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 6747384..2b68d6e 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -600,6 +600,9 @@ and is between 256 and 4096 characters. 
 	hisax=		[HW,ISDN]
 			See Documentation/isdn/README.HiSax.
 
+	ht=		[HW,IA-32,SMP] Enable or disable hyper-threading.
+			Format: <on|off>
+
 	hugepages=	[HW,IA-32,IA-64] Maximal number of HugeTLB pages.
 
 	noirqbalance	[IA-32,SMP,KNL] Disable kernel irq balancing
diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index 8ff1c6f..b4a2461 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -1185,6 +1185,11 @@ config X86_HT
 	depends on SMP && !(X86_VISWS || X86_VOYAGER)
 	default y
 
+config X86_HT_DISABLE
+	bool "Disable Hyper-Threading by default"
+	depends on X86_HT
+	default n
+
 config X86_BIOS_REBOOT
 	bool
 	depends on !(X86_VISWS || X86_VOYAGER)
diff --git a/arch/i386/kernel/cpu/common.c b/arch/i386/kernel/cpu/common.c
index d9f3e3c..42d2361 100644
--- a/arch/i386/kernel/cpu/common.c
+++ b/arch/i386/kernel/cpu/common.c
@@ -482,6 +482,29 @@ void __cpuinit identify_cpu(struct cpuin
 }
 
 #ifdef CONFIG_X86_HT
+
+#ifdef CONFIG_X86_HT_DISABLE
+static int disable_ht __cpuinitdata = 1;
+#else
+static int disable_ht __cpuinitdata;
+#endif
+
+static int __init parse_ht(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	if (!memcmp(arg, "on", 2))
+		disable_ht = 0;
+	else if (!memcmp(arg, "off", 3))
+		disable_ht = 1;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+early_param("ht", parse_ht);
+
 void __cpuinit detect_ht(struct cpuinfo_x86 *c)
 {
 	u32 	eax, ebx, ecx, edx;
@@ -492,6 +515,12 @@ void __cpuinit detect_ht(struct cpuinfo_
 	if (!cpu_has(c, X86_FEATURE_HT) || cpu_has(c, X86_FEATURE_CMP_LEGACY))
 		return;
 
+	if (disable_ht) {
+		printk(KERN_INFO  "CPU: Hyper-Threading disabled by default. Enable with ht=on\n");
+		smp_num_siblings = 1;
+		return;
+	}
+
 	smp_num_siblings = (ebx & 0xff0000) >> 16;
 
 	if (smp_num_siblings == 1) {
-- 
1.4.1

