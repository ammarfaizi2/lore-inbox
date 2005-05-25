Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVEYRUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVEYRUk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 13:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVEYRUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 13:20:40 -0400
Received: from adsl-66-218-37-216.dslextreme.com ([66.218.37.216]:34442 "EHLO
	tyanhuey") by vger.kernel.org with ESMTP id S261498AbVEYRTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 13:19:35 -0400
From: Russell Miller <rmiller@duskglow.com>
To: marcelo.tosatti@cyclades.com
Subject: panic-on-oops patch
Date: Wed, 25 May 2005 10:16:23 -0700
User-Agent: KMail/1.8
Organization: Duskglow Consulting
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_nLLlCvh8TVofYx5"
Message-Id: <200505251016.23411.rmiller@duskglow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_nLLlCvh8TVofYx5
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

As you asked, here is the panic-on-oops patch as pulled from the 2.5 tree 
(when it was first applied).  There are two lines in it that I'm not sure of, 
but I'll leave it to you to decide whether they should be there.  I didn't 
apply them, myself.

--Russell

--Boundary-00=_nLLlCvh8TVofYx5
Content-Type: text/x-diff;
  charset="us-ascii";
  name="3430.0.panic-on-oops.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="3430.0.panic-on-oops.patch"


From: Russell Miller <rmiller@duskglow.com>

A BUG or an oops will often leave a machine in a useless state.  There is no
way to remotely recover the machine from that state.

The patch adds a /proc/sys/kernel/panic_on_oops sysctl which, when set, will
cause the x86 kernel to call panic() at the end of the oops handler.  If the
user has also set /proc/sys/kernel/panic then a reboot will occur.

The implementation will try to sleep for a while before panicing so the oops
info has a chance of hitting the logs.

The implementation is designed so that other architectures can easily do this
in their oops handlers.



 Documentation/sysctl/kernel.txt |   12 ++++++++++++
 arch/i386/kernel/traps.c        |    9 +++++++++
 include/linux/kernel.h          |    1 +
 include/linux/sysctl.h          |    1 +
 kernel/panic.c                  |    7 +++----
 kernel/sysctl.c                 |    2 ++
 6 files changed, 28 insertions(+), 4 deletions(-)

diff -puN arch/i386/kernel/traps.c~panic-on-oops arch/i386/kernel/traps.c
--- 25/arch/i386/kernel/traps.c~panic-on-oops	2003-04-02 21:50:15.000000000 -0800
+++ 25-akpm/arch/i386/kernel/traps.c	2003-04-02 21:57:44.000000000 -0800
@@ -302,6 +302,15 @@ void die(const char * str, struct pt_reg
 	show_registers(regs);
 	bust_spinlocks(0);
 	spin_unlock_irq(&die_lock);
+	if (in_interrupt())
+		panic("Fatal exception in interrupt");
+
+	if (panic_on_oops) {
+		printk(KERN_EMERG "Fatal exception: panic in 5 seconds\n");
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(5 * HZ);
+		panic("Fatal exception");
+	}
 	do_exit(SIGSEGV);
 }
 
diff -puN include/linux/kernel.h~panic-on-oops include/linux/kernel.h
--- 25/include/linux/kernel.h~panic-on-oops	2003-04-02 21:50:15.000000000 -0800
+++ 25-akpm/include/linux/kernel.h	2003-04-02 21:50:15.000000000 -0800
@@ -104,6 +104,7 @@ static inline void console_verbose(void)
 
 extern void bust_spinlocks(int yes);
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
+extern int panic_on_oops;
 
 extern int tainted;
 extern const char *print_tainted(void);
diff -puN include/linux/sysctl.h~panic-on-oops include/linux/sysctl.h
--- 25/include/linux/sysctl.h~panic-on-oops	2003-04-02 21:50:15.000000000 -0800
+++ 25-akpm/include/linux/sysctl.h	2003-04-02 21:50:15.000000000 -0800
@@ -130,6 +130,7 @@ enum
 	KERN_CADPID=54,		/* int: PID of the process to notify on CAD */
 	KERN_PIDMAX=55,		/* int: PID # limit */
   	KERN_CORE_PATTERN=56,	/* string: pattern for core-file names */
+	KERN_PANIC_ON_OOPS=57,  /* int: whether we will panic on an oops */
 };
 
 
diff -puN kernel/panic.c~panic-on-oops kernel/panic.c
--- 25/kernel/panic.c~panic-on-oops	2003-04-02 21:50:15.000000000 -0800
+++ 25-akpm/kernel/panic.c	2003-04-02 21:50:15.000000000 -0800
@@ -20,6 +20,8 @@
 asmlinkage void sys_sync(void);	/* it's really int */
 
 int panic_timeout;
+int panic_on_oops;
+int tainted;
 
 struct notifier_block *panic_notifier_list;
 
@@ -28,7 +30,6 @@ static int __init panic_setup(char *str)
 	panic_timeout = simple_strtoul(str, NULL, 0);
 	return 1;
 }
-
 __setup("panic=", panic_setup);
 
 /**
@@ -51,7 +52,7 @@ NORET_TYPE void panic(const char * fmt, 
 
 	bust_spinlocks(1);
 	va_start(args, fmt);
-	vsprintf(buf, fmt, args);
+	vsnprintf(buf, sizeof(buf), fmt, args);
 	va_end(args);
 	printk(KERN_EMERG "Kernel panic: %s\n",buf);
 	if (in_interrupt())
@@ -123,5 +124,3 @@ const char *print_tainted()
 		snprintf(buf, sizeof(buf), "Not tainted");
 	return(buf);
 }
-
-int tainted = 0;
diff -puN kernel/sysctl.c~panic-on-oops kernel/sysctl.c
--- 25/kernel/sysctl.c~panic-on-oops	2003-04-02 21:50:15.000000000 -0800
+++ 25-akpm/kernel/sysctl.c	2003-04-02 21:50:15.000000000 -0800
@@ -275,6 +275,8 @@ static ctl_table kern_table[] = {
 #endif
 	{KERN_PIDMAX, "pid_max", &pid_max, sizeof (int),
 	 0600, NULL, &proc_dointvec},
+	{KERN_PANIC_ON_OOPS,"panic_on_oops",
+	 &panic_on_oops,sizeof(int),0644,NULL,&proc_dointvec},
 	{0}
 };
 
diff -puN Documentation/sysctl/kernel.txt~panic-on-oops Documentation/sysctl/kernel.txt
--- 25/Documentation/sysctl/kernel.txt~panic-on-oops	2003-04-02 21:50:15.000000000 -0800
+++ 25-akpm/Documentation/sysctl/kernel.txt	2003-04-02 21:50:15.000000000 -0800
@@ -204,6 +204,18 @@ software watchdog, the recommended setti
 
 ==============================================================
 
+panic_on_oops:
+
+Controls the kernel's behaviour when an oops or BUG is encountered.
+
+0: try to continue operation
+
+1: delay a few seconds (to give klogd time to record the oops output) and
+   then panic.  If the `panic' sysctl is also non-zero then the machine will
+   be rebooted.
+
+==============================================================
+
 pid_max:
 
 PID allocation wrap value.  When the kenrel's next PID value

_

--Boundary-00=_nLLlCvh8TVofYx5--
