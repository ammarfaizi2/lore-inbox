Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318705AbSG0GXt>; Sat, 27 Jul 2002 02:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318706AbSG0GXt>; Sat, 27 Jul 2002 02:23:49 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:27350 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318705AbSG0GXs>;
	Sat, 27 Jul 2002 02:23:48 -0400
Date: Sat, 27 Jul 2002 16:26:04 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.29
Message-Id: <20020727162604.433daec3.rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.33.0207262004550.1357-100000@penguin.transmeta.com>
References: <Pine.LNX.4.33.0207262004550.1357-100000@penguin.transmeta.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2002 20:12:00 -0700 (PDT)
Linus Torvalds <torvalds@transmeta.com> wrote:

> 
> Hmm.. All over the map. IDE patches as usual, USB updates, tons of C99 
> named initializers work, ACPI update, fixes from Alan, driverfs race fixes
> and cleanups, SCSI driver fixes from Doug and tons of input layer updates.
> 
> Oh, and a new LDM driver, Rusty's CPU hotplug infrastructure

Badly broken on SMP by Linus.

You'll only get one migration thread, and one ksoftirqd.

Issue is that some initcalls (softirq.c and sched.c) are way easier before
other CPUs are brought up, but doing it the other way broke AGP and Linus
decided to call all the initcalls after CPUs are brought up in case someone
else needed it (I still strongly disagree).

This hack fixes it: real fix is the explicit initcall ordering patch,
which Linus hasn't commented on 8(

Name: Hot-plug CPU Boot ksoftirqd and migration fix
Author: Rusty Russell
Status: Tested on 2.5.29, x86 SMP

D: This patch fixes the calls to initialize ksoftirqd and the
D: migration threads.  This really should be done by the initcall
D: depends patch.

diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.29/init/main.c working-2.5.29/init/main.c
--- linux-2.5.29/init/main.c	Sat Jul 27 15:24:39 2002
+++ working-2.5.29/init/main.c	Sat Jul 27 16:09:42 2002
@@ -524,6 +524,15 @@ static void __init do_basic_setup(void)
 	do_initcalls();
 }
 
+static void do_pre_smp_initcalls(void)
+{
+	extern int migration_init(void);
+	extern int spawn_ksoftirqd(void);
+
+	migration_init();
+	spawn_ksoftirqd();
+}
+
 extern void prepare_namespace(void);
 
 static int init(void * unused)
@@ -533,6 +542,9 @@ static int init(void * unused)
 	lock_kernel();
 	/* Sets up cpus_possible() */
 	smp_prepare_cpus(max_cpus);
+
+	do_pre_smp_initcalls();
+
 	smp_init();
 	do_basic_setup();
 
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.29/kernel/sched.c working-2.5.29/kernel/sched.c
--- linux-2.5.29/kernel/sched.c	Sat Jul 27 15:24:39 2002
+++ working-2.5.29/kernel/sched.c	Sat Jul 27 16:21:58 2002
@@ -1894,6 +1894,8 @@ static int migration_call(struct notifie
 		       (long)hcpu);
 		kernel_thread(migration_thread, hcpu,
 			      CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
+		while (!cpu_rq((long)hcpu)->migration_thread)
+			yield();
 		break;
 	}
 	return NOTIFY_OK;
@@ -1901,7 +1903,7 @@ static int migration_call(struct notifie
 
 static struct notifier_block migration_notifier = { &migration_call, NULL, 0 };
 
-int __init migration_init(void)
+__init int migration_init(void)
 {
 	/* Start one for boot CPU. */
 	migration_call(&migration_notifier, CPU_ONLINE,
@@ -1910,7 +1912,6 @@ int __init migration_init(void)
 	return 0;
 }
 
-__initcall(migration_init);
 #endif
 
 extern void init_timervecs(void);
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.29/kernel/softirq.c working-2.5.29/kernel/softirq.c
--- linux-2.5.29/kernel/softirq.c	Sat Jul 27 15:24:39 2002
+++ working-2.5.29/kernel/softirq.c	Sat Jul 27 16:07:53 2002
@@ -410,11 +410,9 @@ static int __devinit cpu_callback(struct
 
 static struct notifier_block cpu_nfb = { &cpu_callback, NULL, 0 };
 
-static __init int spawn_ksoftirqd(void)
+__init int spawn_ksoftirqd(void)
 {
 	cpu_callback(&cpu_nfb, CPU_ONLINE, (void *)smp_processor_id());
 	register_cpu_notifier(&cpu_nfb);
 	return 0;
 }
-
-__initcall(spawn_ksoftirqd);


-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
