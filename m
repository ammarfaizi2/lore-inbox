Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264426AbTEJQH1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 12:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264427AbTEJQH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 12:07:27 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:17310 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264426AbTEJQHV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 12:07:21 -0400
Date: Sat, 10 May 2003 18:19:36 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Parse new-style boot parameters just before initcalls
Message-ID: <Pine.SOL.4.30.0305101735410.20755-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I've redone this patch. I've tested it and works okay for me.
It is as minimal as possible and I hope it can go in 2.5 soon.

As already pointed by you for 2.7 we should have more flexible choice
of when to do boot parameters parsing: parameters tied with architecture,
with different subsystems, with different level of initcalls etc..

Note that patch breaks ide parameters, second one fixes this.

Testing & comments appreciated, patch below.
--
Bartlomiej

# Move parsing of new-style boot parameters (module_parm() and co.)
# before initcalls. Old-style boot parameters (using __setup())
# are still parsed early, so everything should work normally
# (except ide for which lack of parameters' uniqueness must be fixed).
#
# This change fe. removes requirement of keeping static data for storing
# parameters by drivers (ide, md etc.) because now they can use kmalloc().
#
# Thanks goes to Rusty for the idea and help.
#
# Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 include/linux/moduleparam.h |    2 +
 init/main.c                 |   57 +++++++++++++++++++++++++++++++++++---------
 kernel/params.c             |    2 -
 3 files changed, 49 insertions(+), 12 deletions(-)

diff -puN init/main.c~late_boot_params init/main.c
--- linux-2.5.69/init/main.c~late_boot_params	Fri May  9 23:07:38 2003
+++ linux-2.5.69-root/init/main.c	Sat May 10 18:09:55 2003
@@ -105,6 +105,11 @@ int system_running = 0;
 #define MAX_INIT_ARGS 8
 #define MAX_INIT_ENVS 8

+extern struct obs_kernel_param __setup_start, __setup_end;
+extern struct kernel_param __start___param, __stop___param;
+extern char saved_command_line[];
+static char *command_line;
+
 extern void time_init(void);
 extern void softirq_init(void);

@@ -149,20 +154,53 @@ __setup("profile=", profile_setup);
 static int __init obsolete_checksetup(char *line)
 {
 	struct obs_kernel_param *p;
-	extern struct obs_kernel_param __setup_start, __setup_end;

 	p = &__setup_start;
 	do {
 		int n = strlen(p->str);
-		if (!strncmp(line,p->str,n)) {
-			if (p->setup_func(line+n))
+		if (!strncmp(line, p->str, n))
+			/* parameters should be unique! */
+			if (n && (line[n-1] == '=' || line[n] =='\0'))
+				return p->setup_func(line + n);
+		p++;
+	} while (p < &__setup_end);
+	/* not found, probably normal parameter */
+	return 1;
+}
+
+static int __init obsolete_test_checksetup(char *line)
+{
+	struct obs_kernel_param *p;
+
+	p = &__setup_start;
+	do {
+		int n = strlen(p->str);
+		if (!strncmp(line, p->str, n))
+			/* parameters should be unique! */
+			if (n && (line[n-1] == '=' || line[n] =='\0'))
 				return 1;
-		}
 		p++;
 	} while (p < &__setup_end);
 	return 0;
 }

+static void __init parse_early_args(const char *name, char *args)
+{
+	char *param, *val;
+
+	while (*args) {
+		args = next_arg(args, &param, &val);
+		/* make "param" the full string */
+		if (val)
+			val[-1] = '=';
+		if (!obsolete_checksetup(param))
+			printk("%s: invalid parameter `%s'\n", name, param);
+		/* restore ' ' after val */
+		if (args[-1] == '\0')
+			args[-1] = ' ';
+	}
+}
+
 /* this should be approx 2 Bo*oMips to start (note initial shift), and will
    still work even if initially too large, it will just take slightly longer */
 unsigned long loops_per_jiffy = (1<<12);
@@ -241,7 +279,7 @@ static int __init unknown_bootoption(cha
 		val[-1] = '=';

 	/* Handle obsolete-style parameters */
-	if (obsolete_checksetup(param))
+	if (obsolete_test_checksetup(param))
 		return 0;

 	/* Preemptive maintenance for "why didn't my mispelled command
@@ -378,9 +416,6 @@ static void rest_init(void)

 asmlinkage void __init start_kernel(void)
 {
-	char * command_line;
-	extern char saved_command_line[];
-	extern struct kernel_param __start___param, __stop___param;
 /*
  * Interrupts are still disabled. Do necessary setups, then
  * enable them
@@ -399,9 +434,7 @@ asmlinkage void __init start_kernel(void
 	build_all_zonelists();
 	page_alloc_init();
 	printk("Kernel command line: %s\n", saved_command_line);
-	parse_args("Booting kernel", command_line, &__start___param,
-		   &__stop___param - &__start___param,
-		   &unknown_bootoption);
+	parse_early_args("Parsing early boot parameters", command_line);
 	trap_init();
 	rcu_init();
 	init_IRQ();
@@ -528,6 +561,8 @@ static void __init do_basic_setup(void)
 	sock_init();

 	init_workqueues();
+	parse_args("Parsing boot parameters", command_line, &__start___param,
+		   &__stop___param - &__start___param, &unknown_bootoption);
 	do_initcalls();
 }

diff -puN kernel/params.c~late_boot_params kernel/params.c
--- linux-2.5.69/kernel/params.c~late_boot_params	Fri May  9 23:07:42 2003
+++ linux-2.5.69-root/kernel/params.c	Sat May 10 00:15:41 2003
@@ -71,7 +71,7 @@ static int parse_one(char *param,

 /* You can use " around spaces, but can't escape ". */
 /* Hyphens and underscores equivalent in parameter names. */
-static char *next_arg(char *args, char **param, char **val)
+char *next_arg(char *args, char **param, char **val)
 {
 	unsigned int i, equals = 0;
 	int in_quote = 0;
diff -puN include/linux/moduleparam.h~late_boot_params include/linux/moduleparam.h
--- linux-2.5.69/include/linux/moduleparam.h~late_boot_params	Fri May  9 23:13:55 2003
+++ linux-2.5.69-root/include/linux/moduleparam.h	Sat May 10 00:16:22 2003
@@ -63,6 +63,8 @@ struct kparam_string {
 	module_param_call(name, param_set_copystring, param_get_charp,	\
 		   &__param_string_##name, perm)

+extern char *next_arg(char *args, char **param, char **val);
+
 /* Called on module insert or kernel boot */
 extern int parse_args(const char *name,
 		      char *args,

_

