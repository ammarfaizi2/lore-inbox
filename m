Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265223AbUAWDuX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 22:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266502AbUAWDuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 22:50:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:28139 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265223AbUAWDuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 22:50:21 -0500
Date: Thu, 22 Jan 2004 19:51:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: "David S. Miller" <davem@redhat.com>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Simplify net/flow.c
Message-Id: <20040122195104.31cc2496.akpm@osdl.org>
In-Reply-To: <20040122101028.0eab2774.davem@redhat.com>
References: <20040122082303.3B1BC2C18C@lists.samba.org>
	<20040122101028.0eab2774.davem@redhat.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> wrote:
>
> On Thu, 22 Jan 2004 18:49:37 +1100
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > 	I still have this cleanup sitting around, and frankly it gets
> > in the way for the hotplug CPU code.  It works fine here, and is
> > basically trivial, but I'm happy to put it in -mm first for wider
> > testing if you want?
> 
> No, I made you wait long enough with this patch :) and I just read it
> over again a few times and it looks perfectly fine.
> 
> So I'm applying this now, thanks Rusty.

It doesn't link if CONFIG_SMP=n.  semaphore `cpucontrol', used in
flow_cache_flush() is defined in kernel/cpu.c which is not included in
uniprocessor builds.

Here's one possible fix.


diff -puN net/core/flow.c~flow-cpucontrol-fix net/core/flow.c
--- 25/net/core/flow.c~flow-cpucontrol-fix	2004-01-22 19:39:54.000000000 -0800
+++ 25-akpm/net/core/flow.c	2004-01-22 19:43:58.000000000 -0800
@@ -286,7 +286,7 @@ void flow_cache_flush(void)
 
 	/* Don't want cpus going down or up during this, also protects
 	 * against multiple callers. */
-	down(&cpucontrol);
+	down_cpucontrol();
 	atomic_set(&info.cpuleft, num_online_cpus());
 	init_completion(&info.completion);
 
@@ -296,7 +296,7 @@ void flow_cache_flush(void)
 	local_bh_enable();
 
 	wait_for_completion(&info.completion);
-	up(&cpucontrol);
+	up_cpucontrol();
 }
 
 static void __devinit flow_cache_cpu_prepare(int cpu)
diff -puN include/linux/cpu.h~flow-cpucontrol-fix include/linux/cpu.h
--- 25/include/linux/cpu.h~flow-cpucontrol-fix	2004-01-22 19:42:23.000000000 -0800
+++ 25-akpm/include/linux/cpu.h	2004-01-22 19:43:35.000000000 -0800
@@ -37,7 +37,12 @@ extern int register_cpu_notifier(struct 
 extern void unregister_cpu_notifier(struct notifier_block *nb);
 
 int cpu_up(unsigned int cpu);
+
+#define down_cpucontrol()	down(&cpucontrol)
+#define up_cpucontrol()		up(&cpucontrol)
+
 #else
+
 static inline int register_cpu_notifier(struct notifier_block *nb)
 {
 	return 0;
@@ -45,6 +50,10 @@ static inline int register_cpu_notifier(
 static inline void unregister_cpu_notifier(struct notifier_block *nb)
 {
 }
+
+#define down_cpucontrol()	do { } while (0)
+#define up_cpucontrol()		do { } while (0)
+
 #endif /* CONFIG_SMP */
 extern struct sysdev_class cpu_sysdev_class;
 

_

