Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318710AbSG0HxO>; Sat, 27 Jul 2002 03:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318711AbSG0HxO>; Sat, 27 Jul 2002 03:53:14 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:61667 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318710AbSG0HxO>;
	Sat, 27 Jul 2002 03:53:14 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.29 
In-reply-to: Your message of "Fri, 26 Jul 2002 23:52:44 MST."
             <3D42433C.C3BB8F4D@zip.com.au> 
Date: Sat, 27 Jul 2002 17:12:47 +1000
Message-Id: <20020727075743.37594417F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3D42433C.C3BB8F4D@zip.com.au> you write:
> While you're there, this register_cpu_notifier() call
> generates a compile warning on UP:
> 
> softirq.c: In function `spawn_ksoftirqd':
> softirq.c:416: warning: statement with no effect

Thanks Andrew...

Name: Hot-plug CPU notifier warning fix
Author: Rusty Russell
Status: Trivial

D: As pointed out by Andrew Morton, this fixes:
D:	softirq.c: In function `spawn_ksoftirqd':
D:	softirq.c:416: warning: statement with no effect

This patch alters the boot sequence to "plug in" each CPU, one at a

diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.29/include/linux/smp.h working-2.5.29-register-cpu-fix/include/linux/smp.h
--- linux-2.5.29/include/linux/smp.h	Sat Jul 27 15:24:39 2002
+++ working-2.5.29-register-cpu-fix/include/linux/smp.h	Sat Jul 27 17:10:04 2002
@@ -101,9 +101,13 @@ static inline void smp_send_reschedule_a
 #define this_cpu(var)				var
 
 /* Need to know about CPUs going up/down? */
-#define register_cpu_notifier(nb) 0
-#define unregister_cpu_notifier(nb) do { } while(0)
-
+static inline int register_cpu_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+static inline void unregister_cpu_notifier(struct notifier_block *nb)
+{
+}
 #endif /* !SMP */
 
 #define get_cpu()		({ preempt_disable(); smp_processor_id(); })
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
