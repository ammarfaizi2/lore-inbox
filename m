Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261333AbSKTSf2>; Wed, 20 Nov 2002 13:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261416AbSKTSf2>; Wed, 20 Nov 2002 13:35:28 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:13701 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261333AbSKTSf0>;
	Wed, 20 Nov 2002 13:35:26 -0500
Message-ID: <3DDBD70B.7090501@us.ibm.com>
Date: Wed, 20 Nov 2002 10:40:11 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: David Woodhouse <dwmw2@infradead.org>
Subject: [RFC][PATCH] early command-line parsing
Content-Type: multipart/mixed;
 boundary="------------020207050104080006020709"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020207050104080006020709
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

We need a way to parse command-line options before setup_arch() for 
early printk.  On x86, the only thing that is needed to get an early 
serial console is:
console_setup("ttyS0,115200");
serial8250_console_init();

So, in addition to this patch, all you need to get early printk on x86 
is serial8250_console_init() in i386's setup_arch() and a 
console=ttyS0,speed on the kernel command line.

Are there any architectures that can't even do a memcpy before 
setup_arch()?
-- 
Dave Hansen
haveblue@us.ibm.com

--------------020207050104080006020709
Content-Type: text/plain;
 name="early_setup-2.5.48-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="early_setup-2.5.48-2.patch"

diff -ru linux-2.5.48-clean/include/linux/init.h linux-2.5.48-early_setup/include/linux/init.h
--- linux-2.5.48-clean/include/linux/init.h	Tue Nov 19 13:53:09 2002
+++ linux-2.5.48-early_setup/include/linux/init.h	Tue Nov 19 12:02:45 2002
@@ -90,17 +90,21 @@
  * Used for kernel command line parameter setup
  */
 struct kernel_param {
+	int order;
 	const char *str;
 	int (*setup_func)(char *);
 };
 
 extern struct kernel_param __setup_start, __setup_end;
 
-#define __setup(str, fn)						\
+#define __early_setup(str, fn)	__raw_setup(0, str, fn)
+#define __setup(str, fn)	__raw_setup(1, str, fn)
+
+#define __raw_setup(order, str, fn)					\
 	static char __setup_str_##fn[] __initdata = str;		\
 	static struct kernel_param __setup_##fn				\
 		 __attribute__((unused,__section__ (".init.setup")))	\
-		= { __setup_str_##fn, fn }
+		= { order, __setup_str_##fn, fn }
 
 #endif /* __ASSEMBLY__ */
 
diff -ru linux-2.5.48-clean/init/main.c linux-2.5.48-early_setup/init/main.c
--- linux-2.5.48-clean/init/main.c	Tue Nov 19 13:53:09 2002
+++ linux-2.5.48-early_setup/init/main.c	Wed Nov 20 10:29:03 2002
@@ -36,6 +36,7 @@
 
 #include <asm/io.h>
 #include <asm/bugs.h>
+#include <asm/setup.h>
 
 #if defined(CONFIG_ARCH_S390)
 #include <asm/s390mach.h>
@@ -136,15 +137,17 @@
 
 __setup("profile=", profile_setup);
 
-static int __init checksetup(char *line)
+static int __init checksetup(int run_number, char *line) 
 {
 	struct kernel_param *p;
 
 	p = &__setup_start;
 	do {
 		int n = strlen(p->str);
-		if (!strncmp(line,p->str,n)) {
-			if (p->setup_func(line+n))
+		if(strncmp(linux, p->str, n)) {
+			if (p->order == run_number)
+				return (p->setup_func(line+n) != 0);
+			else if (p->order < run_number)
 				return 1;
 		}
 		p++;
@@ -230,7 +233,7 @@
  * This routine also checks for options meant for the kernel.
  * These options are not given to init - they are for internal kernel use only.
  */
-static void __init parse_options(char *line)
+static void __init parse_options(int setup_order, char *line)
 {
 	char *next,*quote;
 	int args, envs;
@@ -266,7 +269,7 @@
 			args = 0;
 			continue;
 		}
-		if (checksetup(line))
+		if (checksetup(setup_order, line))
 			continue;
 		
 		/*
@@ -386,6 +389,10 @@
  * Interrupts are still disabled. Do necessary setups, then
  * enable them
  */
+	memcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
+	command_line = saved_command_line;
+
+	parse_options(0, command_line);
 	lock_kernel();
 	printk(linux_banner);
 	setup_arch(&command_line);
@@ -393,7 +400,7 @@
 	build_all_zonelists();
 	page_alloc_init();
 	printk("Kernel command line: %s\n", saved_command_line);
-	parse_options(command_line);
+	parse_options(1, command_line);
 	trap_init();
 	extable_init();
 	rcu_init();
diff -ru linux-2.5.48-clean/kernel/printk.c linux-2.5.48-early_setup/kernel/printk.c
--- linux-2.5.48-clean/kernel/printk.c	Sun Nov 10 19:28:32 2002
+++ linux-2.5.48-early_setup/kernel/printk.c	Wed Nov 20 10:30:05 2002
@@ -149,7 +149,7 @@
 	return 1;
 }
 
-__setup("console=", console_setup);
+__early_setup("console=", console_setup);
 
 /*
  * Commands to do_syslog:

--------------020207050104080006020709--

