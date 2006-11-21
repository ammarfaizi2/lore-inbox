Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966885AbWKUHz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966885AbWKUHz2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 02:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966896AbWKUHz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 02:55:28 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:51641 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S966885AbWKUHz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 02:55:26 -0500
Date: Tue, 21 Nov 2006 08:54:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compile problems Re: 2.6.19-rc6-rt5
Message-ID: <20061121075400.GC24711@elte.hu>
References: <20061120220230.GA30835@elte.hu> <1164078473.3258.8.camel@monteirov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164078473.3258.8.camel@monteirov>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0010]
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Sergio Monteiro Basto <sergio@sergiomb.no-ip.org> wrote:

> On Mon, 2006-11-20 at 23:02 +0100, Ingo Molnar wrote:
> >   http://redhat.com/~mingo/realtime-preempt/patch-2.6.19-rc6-rt5
> 
> if I don't put in .config 
> CONFIG_HOTPLUG_CPU=y
> 
> I got  
> UPD     include/linux/compile.h
> arch/x86_64/kernel/vsyscall.c: In function 'vsyscall_init':
> arch/x86_64/kernel/vsyscall.c:334: error: 'cpu_vsyscall_notifier' undeclared (first use in this function)
> arch/x86_64/kernel/vsyscall.c:334: error: (Each undeclared identifier is reported only once

this one should be fixed by the patch below.

	Ingo

Index: linux/arch/x86_64/kernel/vsyscall.c
===================================================================
--- linux.orig/arch/x86_64/kernel/vsyscall.c
+++ linux/arch/x86_64/kernel/vsyscall.c
@@ -300,7 +300,6 @@ static void __cpuinit cpu_vsyscall_init(
 	vsyscall_set_cpu(raw_smp_processor_id());
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 static int __cpuinit
 cpu_vsyscall_notifier(struct notifier_block *n, unsigned long action, void *arg)
 {
@@ -309,7 +308,6 @@ cpu_vsyscall_notifier(struct notifier_bl
 		smp_call_function_single(cpu, cpu_vsyscall_init, NULL, 0, 1);
 	return NOTIFY_DONE;
 }
-#endif
 
 static void __init map_vsyscall(void)
 {
Index: linux/mm/page_alloc.c
===================================================================
--- linux.orig/mm/page_alloc.c
+++ linux/mm/page_alloc.c
@@ -2768,7 +2768,6 @@ void __init free_area_init(unsigned long
 			__pa(PAGE_OFFSET) >> PAGE_SHIFT, NULL);
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 static int page_alloc_cpu_notify(struct notifier_block *self,
 				 unsigned long action, void *hcpu)
 {
@@ -2786,7 +2785,6 @@ static int page_alloc_cpu_notify(struct 
 	}
 	return NOTIFY_OK;
 }
-#endif /* CONFIG_HOTPLUG_CPU */
 
 void __init page_alloc_init(void)
 {
