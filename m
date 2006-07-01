Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751898AbWGARQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbWGARQK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 13:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbWGARQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 13:16:09 -0400
Received: from mail.parknet.jp ([210.171.160.80]:4367 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1751898AbWGARQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 13:16:08 -0400
X-AuthUser: hirofumi@parknet.jp
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix moduler msr.ko/cpuid.ko
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 02 Jul 2006 02:15:59 +0900
Message-ID: <87sllljlf4.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With recently change, if CONFIG_HOTPLUG_CPU is disabled,
register_cpu_notifier() is not exported. And it breaked moduler
msr.ko/cpuid.ko.

We need to use register_hotcpu_notifier() now in module, instead of
register_cpu_notifier().

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 arch/i386/kernel/cpuid.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff -puN arch/i386/kernel/cpuid.c~register_cpu_notifier-export-fix arch/i386/kernel/cpuid.c
--- linux-2.6/arch/i386/kernel/cpuid.c~register_cpu_notifier-export-fix	2006-07-02 02:12:36.000000000 +0900
+++ linux-2.6-hirofumi/arch/i386/kernel/cpuid.c	2006-07-02 02:12:36.000000000 +0900
@@ -167,6 +167,7 @@ static int cpuid_class_device_create(int
 	return err;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
 static int cpuid_class_cpu_callback(struct notifier_block *nfb, unsigned long action, void *hcpu)
 {
 	unsigned int cpu = (unsigned long)hcpu;
@@ -186,6 +187,7 @@ static struct notifier_block __cpuinitda
 {
 	.notifier_call = cpuid_class_cpu_callback,
 };
+#endif /* !CONFIG_HOTPLUG_CPU */
 
 static int __init cpuid_init(void)
 {
@@ -208,7 +210,7 @@ static int __init cpuid_init(void)
 		if (err != 0) 
 			goto out_class;
 	}
-	register_cpu_notifier(&cpuid_class_cpu_notifier);
+	register_hotcpu_notifier(&cpuid_class_cpu_notifier);
 
 	err = 0;
 	goto out;
@@ -233,7 +235,7 @@ static void __exit cpuid_exit(void)
 		class_device_destroy(cpuid_class, MKDEV(CPUID_MAJOR, cpu));
 	class_destroy(cpuid_class);
 	unregister_chrdev(CPUID_MAJOR, "cpu/cpuid");
-	unregister_cpu_notifier(&cpuid_class_cpu_notifier);
+	unregister_hotcpu_notifier(&cpuid_class_cpu_notifier);
 }
 
 module_init(cpuid_init);
_
