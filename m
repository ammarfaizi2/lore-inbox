Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031130AbWKPJBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031130AbWKPJBI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 04:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031131AbWKPJBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 04:01:08 -0500
Received: from ns2.suse.de ([195.135.220.15]:39562 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1031130AbWKPJBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 04:01:06 -0500
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch, -rc6] x86_64: UP build fixes
Date: Thu, 16 Nov 2006 10:01:01 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20061116084855.GA8848@elte.hu>
In-Reply-To: <20061116084855.GA8848@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611161001.01407.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 November 2006 09:48, Ingo Molnar wrote:

> arch/x86_64/kernel/vsyscall.c: In function 'cpu_vsyscall_notifier':
> arch/x86_64/kernel/vsyscall.c:282: warning: implicit declaration of function 'smp_call_function_single'
> arch/x86_64/kernel/vsyscall.c: At top level:
> arch/x86_64/kernel/vsyscall.c:279: warning: 'cpu_vsyscall_notifier' defined but not used


Oops. My fault indeed.

Here's a simpler patch to fix it.

-Andi

Fix vsyscall.c compilation on UP

Broken by earlier patch by me.

Index: linux/arch/x86_64/kernel/vsyscall.c
===================================================================
--- linux.orig/arch/x86_64/kernel/vsyscall.c
+++ linux/arch/x86_64/kernel/vsyscall.c
@@ -274,6 +274,7 @@ static void __cpuinit cpu_vsyscall_init(
 	vsyscall_set_cpu(raw_smp_processor_id());
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
 static int __cpuinit
 cpu_vsyscall_notifier(struct notifier_block *n, unsigned long action, void *arg)
 {
@@ -282,6 +283,7 @@ cpu_vsyscall_notifier(struct notifier_bl
 		smp_call_function_single(cpu, cpu_vsyscall_init, NULL, 0, 1);
 	return NOTIFY_DONE;
 }
+#endif
 
 static void __init map_vsyscall(void)
 {
@@ -303,7 +305,9 @@ static int __init vsyscall_init(void)
 	register_sysctl_table(kernel_root_table2, 0);
 #endif
 	on_each_cpu(cpu_vsyscall_init, NULL, 0, 1);
+#ifdef CONFIG_HOTPLUG_CPU
 	hotcpu_notifier(cpu_vsyscall_notifier, 0);
+#endif
 	return 0;
 }
 
