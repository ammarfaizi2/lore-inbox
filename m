Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318994AbSIJFiG>; Tue, 10 Sep 2002 01:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319041AbSIJFhF>; Tue, 10 Sep 2002 01:37:05 -0400
Received: from dp.samba.org ([66.70.73.150]:27265 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319040AbSIJFhB>;
	Tue, 10 Sep 2002 01:37:01 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [patch] fix NMI watchdog, 2.5.34 
In-reply-to: Your message of "Mon, 09 Sep 2002 21:45:20 +0200."
             <Pine.LNX.4.44.0209092144140.10544-100000@localhost.localdomain> 
Date: Tue, 10 Sep 2002 15:19:06 +1000
Message-Id: <20020910054147.CD7972C201@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0209092144140.10544-100000@localhost.localdomain> you
 write:
> 
> the attached patch fixes the NMI watchdog to trigger on all CPUs - the
> cpu_up() code broke it long time ago. With this patch NMI interrupts get
> generated on all CPUs, not just the boot CPU.

Well spotted.  You might want to test the following patch which
catches calls to smp_call_function() before the cpus are actually
online.  I ran a variant on my (crappy, old, SMP) box before I sent
the patch to Linus, and all I saw was the (harmless) tlb_flush.

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.34/arch/i386/kernel/smp.c working-2.5.34-smp_call_cpus/arch/i386/kernel/smp.c
--- linux-2.5.34/arch/i386/kernel/smp.c	Wed Aug 28 09:29:40 2002
+++ working-2.5.34-smp_call_cpus/arch/i386/kernel/smp.c	Tue Sep 10 14:50:15 2002
@@ -561,9 +561,15 @@ int smp_call_function (void (*func) (voi
  * hardware interrupt handler or from a bottom half handler.
  */
 {
+	extern int smp_done;
 	struct call_data_struct data;
 	int cpus = num_online_cpus()-1;
 
+	if (!smp_done) {
+		printk(KERN_ERR "smp_call_function %p called before SMP!\n",
+		       func);
+		show_stack(NULL);
+	}
 	if (!cpus)
 		return 0;
 
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.34/arch/i386/kernel/smpboot.c working-2.5.34-smp_call_cpus/arch/i386/kernel/smpboot.c
--- linux-2.5.34/arch/i386/kernel/smpboot.c	Sun Sep  1 12:22:57 2002
+++ working-2.5.34-smp_call_cpus/arch/i386/kernel/smpboot.c	Tue Sep 10 14:35:07 2002
@@ -1218,7 +1218,10 @@ int __devinit __cpu_up(unsigned int cpu)
 	return 0;
 }
 
+unsigned int smp_done = 0;
+
 void __init smp_cpus_done(unsigned int max_cpus)
 {
 	zap_low_mappings();
+	smp_done = 1;
 }
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
