Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbVKGIva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbVKGIva (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 03:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbVKGIva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 03:51:30 -0500
Received: from fsmlabs.com ([168.103.115.128]:38861 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S932343AbVKGIva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 03:51:30 -0500
X-ASG-Debug-ID: 1131353486-22711-44-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Mon, 7 Nov 2005 00:57:23 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
cc: LKML <linux-kernel@vger.kernel.org>, cpufreq@lists.linux.org.uk,
       davej@codemonkey.org.uk
X-ASG-Orig-Subj: Re: sleeping function called from cpufreq
Subject: Re: sleeping function called from cpufreq
In-Reply-To: <436F1214.6000307@drzeus.cx>
Message-ID: <Pine.LNX.4.61.0511070051150.28199@montezuma.fsmlabs.com>
References: <436F1214.6000307@drzeus.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.5108
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2005, Pierre Ossman wrote:

> As of lately I've been getting tonnes of these:
> 
> [  610.185635] Debug: sleeping function called from invalid context at
> include/linux/rwsem.h:43
> [  610.185647] in_atomic():1, irqs_disabled():0
> [  610.185653]  [<c01041be>] dump_stack+0x1e/0x20
> [  610.185667]  [<c0119b62>] __might_sleep+0xa2/0xc0
> [  610.185678]  [<c029de86>] cpufreq_notify_transition+0x46/0x220
> [  610.185690]  [<e09d08fc>] centrino_target+0xfc/0x130 [speedstep_centrino]
> [  610.185708]  [<c029f17f>] __cpufreq_driver_target+0x5f/0x70
> [  610.185718]  [<c02a029d>] cpufreq_set+0x7d/0xa0
> [  610.185728]  [<c02a0339>] store_speed+0x49/0x50
> [  610.185737]  [<c029e6c6>] store+0x46/0x60
> [  610.185745]  [<c01a5f27>] flush_write_buffer+0x37/0x40
> [  610.185754]  [<c01a5f98>] sysfs_write_file+0x68/0x90
> [  610.185763]  [<c01639b8>] vfs_write+0xa8/0x190
> [  610.185773]  [<c0163b57>] sys_write+0x47/0x70
> [  610.185781]  [<c01032bb>] sysenter_past_esp+0x54/0x75
> 
> Ideas on solving it?

There is a fix for it in 2.6.14-mm1 but i think it also requires the 
following patch in order to link. I'm not actually advocating the hotplug 
in progress flag and would prefer using a previously posted 
preempt_disable/enable method.

--- linux-mm/include/linux/cpu.h.old	2005-11-06 22:08:39.000000000 -0500
+++ linux-mm/include/linux/cpu.h	2005-11-06 22:41:17.000000000 -0500
@@ -33,7 +33,6 @@
 
 extern int register_cpu(struct cpu *, int, struct node *);
 extern struct sys_device *get_cpu_sysdev(int cpu);
-extern int current_in_cpu_hotplug(void);
 #ifdef CONFIG_HOTPLUG_CPU
 extern void unregister_cpu(struct cpu *, struct node *);
 #endif
@@ -43,6 +42,7 @@
 /* Need to know about CPUs going up/down? */
 extern int register_cpu_notifier(struct notifier_block *nb);
 extern void unregister_cpu_notifier(struct notifier_block *nb);
+extern int current_in_cpu_hotplug(void);
 
 int cpu_up(unsigned int cpu);
 
@@ -55,6 +55,10 @@
 static inline void unregister_cpu_notifier(struct notifier_block *nb)
 {
 }
+static inline int current_in_cpu_hotplug(void)
+{
+	return 0;
+}
 
 #endif /* CONFIG_SMP */
 extern struct sysdev_class cpu_sysdev_class;
