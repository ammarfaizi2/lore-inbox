Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318169AbSG3EJO>; Tue, 30 Jul 2002 00:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318207AbSG3EJO>; Tue, 30 Jul 2002 00:09:14 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:14031 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318169AbSG3EJN>;
	Tue, 30 Jul 2002 00:09:13 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Muli Ben-Yehuda <mulix@actcom.co.il>, torvalds@transmeta.com
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, sfr@canb.auug.org.au
Subject: Re: [PATCH] add num_possible_cpus() to fix 2.5.29 apm.c compilation 
In-reply-to: Your message of "Sun, 28 Jul 2002 17:17:50 +0300."
             <20020728141750.GB9573@alhambra.actcom.co.il> 
Date: Tue, 30 Jul 2002 13:20:19 +1000
Message-Id: <20020730041356.ACD76446E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020728141750.GB9573@alhambra.actcom.co.il> you write:
> This patch fixes the apm.c breakage in 2.5.29 by providing definitions
> for num_possible_cpus() for UP and SMP. There were several patches
> posted to fix it, but I think this is what the author intended. Rusty?

Actually, since i386 isn't going to be doing hotplug CPUs any time
soon, and the APM code will need a CPU notifier if/when that happens
anyway, best to revert that part of the patch.

Linus, please apply:
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.29/arch/i386/kernel/apm.c working-2.5.29-apm/arch/i386/kernel/apm.c
--- linux-2.5.29/arch/i386/kernel/apm.c	Sat Jul 27 15:24:35 2002
+++ working-2.5.29-apm/arch/i386/kernel/apm.c	Tue Jul 30 13:19:24 2002
@@ -1589,7 +1589,7 @@ static int apm_get_info(char *buf, char 
 
 	p = buf;
 
-	if ((num_possible_cpus() == 1) &&
+	if ((num_online_cpus() == 1) &&
 	    !(error = apm_get_power_status(&bx, &cx, &dx))) {
 		ac_line_status = (bx >> 8) & 0xff;
 		battery_status = bx & 0xff;
@@ -1720,7 +1720,7 @@ static int apm(void *unused)
 		}
 	}
 
-	if (debug && (num_possible_cpus() == 1)) {
+	if (debug && (num_online_cpus() == 1)) {
 		error = apm_get_power_status(&bx, &cx, &dx);
 		if (error)
 			printk(KERN_INFO "apm: power status not available\n");
@@ -1764,7 +1764,7 @@ static int apm(void *unused)
 		pm_power_off = apm_power_off;
 	register_sysrq_key('o', &sysrq_poweroff_op);
 
-	if (num_possible_cpus() == 1) {
+	if (num_online_cpus() == 1) {
 #if defined(CONFIG_APM_DISPLAY_BLANK) && defined(CONFIG_VT)
 		console_blank_hook = apm_console_blank;
 #endif
@@ -1907,7 +1907,9 @@ static int __init apm_init(void)
 		printk(KERN_NOTICE "apm: disabled on user request.\n");
 		return -ENODEV;
 	}
-	if ((num_possible_cpus() > 1) && !power_off) {
+	/* FIXME: When boot code changes, this will need to be
+           deactivated when/if a CPU comes up --RR */
+	if ((num_online_cpus() > 1) && !power_off) {
 		printk(KERN_NOTICE "apm: disabled - APM is not SMP safe.\n");
 		return -ENODEV;
 	}
@@ -1964,7 +1966,9 @@ static int __init apm_init(void)
 
 	kernel_thread(apm, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGHAND | SIGCHLD);
 
-	if (num_possible_cpus() > 1) {
+	/* FIXME: When boot code changes, this will need to be
+           deactivated when/if a CPU comes up --RR */
+	if (num_online_cpus() > 1) {
 		printk(KERN_NOTICE
 		   "apm: disabled - APM is not SMP safe (power off active).\n");
 		return 0;


--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
