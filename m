Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbWITJil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWITJil (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 05:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWITJil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 05:38:41 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:63448 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750864AbWITJik
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 05:38:40 -0400
Message-ID: <45110C1B.7020304@fr.ibm.com>
Date: Wed, 20 Sep 2006 11:38:35 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Paul Mackerras <paulus@samba.org>
Subject: [RFC][PATCH -mm] replace cad_pid by a struct pid
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few places in the kernel where the init task is
signaled. The ctrl+alt+del sequence is one them. It kills a task,
usually init, using a cached pid (cad_pid).

This patch replaces the pid_t by a struct pid to avoid pid wrap around
problem. The struct pid is initialized at boot time in init() and can
be modified through systctl with

	/proc/sys/kernel/cad_pid

[ I haven't found any distro using it ? ]

It also introduces a small helper routine kill_cad_pid() which is used
where it seemed ok to use cad_pid instead of pid 1.

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>

---
 arch/mips/sgi-ip22/ip22-reset.c     |    2 +-
 arch/mips/sgi-ip32/ip32-reset.c     |    2 +-
 arch/powerpc/platforms/iseries/mf.c |    2 +-
 drivers/char/nwbutton.c             |    2 +-
 drivers/char/snsc_event.c           |    2 +-
 drivers/parisc/power.c              |    2 +-
 drivers/s390/s390mach.c             |    2 +-
 include/linux/sched.h               |    7 +++++++
 init/main.c                         |    2 ++
 kernel/sys.c                        |    5 ++---
 kernel/sysctl.c                     |   30 +++++++++++++++++++++++++++---
 11 files changed, 45 insertions(+), 13 deletions(-)

Index: 2.6.18-rc7-mm1/kernel/sysctl.c
===================================================================
--- 2.6.18-rc7-mm1.orig/kernel/sysctl.c
+++ 2.6.18-rc7-mm1/kernel/sysctl.c
@@ -65,7 +65,6 @@ extern int sysrq_enabled;
 extern int core_uses_pid;
 extern int suid_dumpable;
 extern char core_pattern[];
-extern int cad_pid;
 extern int pid_max;
 extern int min_free_kbytes;
 extern int printk_ratelimit_jiffies;
@@ -148,6 +147,9 @@ static int parse_table(int __user *, int
 static int proc_do_uts_string(ctl_table *table, int write, struct file *filp,
 		  void __user *buffer, size_t *lenp, loff_t *ppos);
 
+static int proc_do_cad_pid(ctl_table *table, int write, struct file *filp,
+		  void __user *buffer, size_t *lenp, loff_t *ppos);
+
 static ctl_table root_table[];
 static struct ctl_table_header root_table_header =
 	{ root_table, LIST_HEAD_INIT(root_table_header.ctl_entry) };
@@ -562,10 +564,10 @@ static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_CADPID,
 		.procname	= "cad_pid",
-		.data		= &cad_pid,
+		.data		= NULL,
 		.maxlen		= sizeof (int),
 		.mode		= 0600,
-		.proc_handler	= &proc_dointvec,
+		.proc_handler	= &proc_do_cad_pid,
 	},
 	{
 		.ctl_name	= KERN_MAX_THREADS,
@@ -2478,6 +2480,28 @@ proc_minmax:
 }
 #endif
 
+static int proc_do_cad_pid(ctl_table *table, int write, struct file *filp,
+			   void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct pid *new_pid;
+	pid_t tmp;
+	int r;
+
+	tmp = pid_nr(cad_pid);
+
+	r = __do_proc_dointvec(&tmp, table, write, filp, buffer,
+			       lenp, ppos, NULL, NULL);
+	if (r || !write)
+		return r;
+
+	new_pid = find_get_pid(tmp);
+	if (!new_pid)
+		return -ESRCH;
+
+	put_pid(xchg(&cad_pid, new_pid));
+	return 0;
+}
+
 #else /* CONFIG_PROC_FS */
 
 int proc_dostring(ctl_table *table, int write, struct file *filp,
Index: 2.6.18-rc7-mm1/include/linux/sched.h
===================================================================
--- 2.6.18-rc7-mm1.orig/include/linux/sched.h
+++ 2.6.18-rc7-mm1/include/linux/sched.h
@@ -1096,6 +1096,8 @@ static inline int is_init(struct task_st
 	return tsk->pid == 1;
 }
 
+extern struct pid* cad_pid;
+
 extern void free_task(struct task_struct *tsk);
 #define get_task_struct(tsk) do { atomic_inc(&(tsk)->usage); } while(0)
 
@@ -1323,6 +1325,11 @@ extern int send_group_sigqueue(int, stru
 extern int do_sigaction(int, struct k_sigaction *, struct k_sigaction *);
 extern int do_sigaltstack(const stack_t __user *, stack_t __user *, unsigned long);
 
+static inline int kill_cad_pid(int sig, int priv)
+{
+	return kill_pid(cad_pid, sig, priv);
+}
+
 /* These can be the second arg to send_sig_info/send_group_sig_info.  */
 #define SEND_SIG_NOINFO ((struct siginfo *) 0)
 #define SEND_SIG_PRIV	((struct siginfo *) 1)
Index: 2.6.18-rc7-mm1/init/main.c
===================================================================
--- 2.6.18-rc7-mm1.orig/init/main.c
+++ 2.6.18-rc7-mm1/init/main.c
@@ -726,6 +726,8 @@ static int init(void * unused)
 	 */
 	child_reaper = current;
 
+	cad_pid = task_pid(current);
+
 	smp_prepare_cpus(max_cpus);
 
 	do_pre_smp_initcalls();
Index: 2.6.18-rc7-mm1/kernel/sys.c
===================================================================
--- 2.6.18-rc7-mm1.orig/kernel/sys.c
+++ 2.6.18-rc7-mm1/kernel/sys.c
@@ -92,7 +92,7 @@ EXPORT_SYMBOL(fs_overflowgid);
  */
 
 int C_A_D = 1;
-int cad_pid = 1;
+struct pid* cad_pid = NULL;
 
 /*
  *	Notifier list for kernel code which wants to be called
@@ -896,10 +896,9 @@ void ctrl_alt_del(void)
 	if (C_A_D)
 		schedule_work(&cad_work);
 	else
-		kill_proc(cad_pid, SIGINT, 1);
+		kill_cad_pid(SIGINT, 1);
 }
 	
-
 /*
  * Unprivileged users may change the real gid to the effective gid
  * or vice versa.  (BSD-style)
Index: 2.6.18-rc7-mm1/arch/mips/sgi-ip32/ip32-reset.c
===================================================================
--- 2.6.18-rc7-mm1.orig/arch/mips/sgi-ip32/ip32-reset.c
+++ 2.6.18-rc7-mm1/arch/mips/sgi-ip32/ip32-reset.c
@@ -120,7 +120,7 @@ static inline void ip32_power_button(voi
 	if (has_panicked)
 		return;
 
-	if (shuting_down || kill_proc(1, SIGINT, 1)) {
+	if (shuting_down || kill_cad_pid(SIGINT, 1)) {
 		/* No init process or button pressed twice.  */
 		ip32_machine_power_off();
 	}
Index: 2.6.18-rc7-mm1/arch/powerpc/platforms/iseries/mf.c
===================================================================
--- 2.6.18-rc7-mm1.orig/arch/powerpc/platforms/iseries/mf.c
+++ 2.6.18-rc7-mm1/arch/powerpc/platforms/iseries/mf.c
@@ -357,7 +357,7 @@ static int dma_and_signal_ce_msg(char *c
  */
 static int shutdown(void)
 {
-	int rc = kill_proc(1, SIGINT, 1);
+	int rc = kill_cad_pid(SIGINT, 1);
 
 	if (rc) {
 		printk(KERN_ALERT "mf.c: SIGINT to init failed (%d), "
Index: 2.6.18-rc7-mm1/drivers/char/nwbutton.c
===================================================================
--- 2.6.18-rc7-mm1.orig/drivers/char/nwbutton.c
+++ 2.6.18-rc7-mm1/drivers/char/nwbutton.c
@@ -128,7 +128,7 @@ static void button_sequence_finished (un
 {
 #ifdef CONFIG_NWBUTTON_REBOOT		/* Reboot using button is enabled */
 	if (button_press_count == reboot_count) {
-		kill_proc (1, SIGINT, 1);	/* Ask init to reboot us */
+		kill_cad_pid(SIGINT, 1);	/* Ask init to reboot us */
 	}
 #endif /* CONFIG_NWBUTTON_REBOOT */
 	button_consume_callbacks (button_press_count);
Index: 2.6.18-rc7-mm1/drivers/char/snsc_event.c
===================================================================
--- 2.6.18-rc7-mm1.orig/drivers/char/snsc_event.c
+++ 2.6.18-rc7-mm1/drivers/char/snsc_event.c
@@ -220,7 +220,7 @@ scdrv_dispatch_event(char *event, int le
 			       " Sending SIGPWR to init...\n");
 
 		/* give a SIGPWR signal to init proc */
-		kill_proc(1, SIGPWR, 0);
+		kill_cad_pid(SIGPWR, 0);
 	} else {
 		/* print to system log */
 		printk("%s|$(0x%x)%s\n", severity, esp_code, desc);
Index: 2.6.18-rc7-mm1/drivers/parisc/power.c
===================================================================
--- 2.6.18-rc7-mm1.orig/drivers/parisc/power.c
+++ 2.6.18-rc7-mm1/drivers/parisc/power.c
@@ -85,7 +85,7 @@
 static void deferred_poweroff(void *dummy)
 {
 	extern int cad_pid;	/* from kernel/sys.c */
-	if (kill_proc(cad_pid, SIGINT, 1)) {
+	if (kill_cad_pid(SIGINT, 1)) {
 		/* just in case killing init process failed */
 		machine_power_off();
 	}
Index: 2.6.18-rc7-mm1/drivers/s390/s390mach.c
===================================================================
--- 2.6.18-rc7-mm1.orig/drivers/s390/s390mach.c
+++ 2.6.18-rc7-mm1/drivers/s390/s390mach.c
@@ -208,7 +208,7 @@ s390_handle_mcck(void)
 		 */
 		__ctl_clear_bit(14, 24);	/* Disable WARNING MCH */
 		if (xchg(&mchchk_wng_posted, 1) == 0)
-			kill_proc(1, SIGPWR, 1);
+			kill_cad_pid(SIGPWR, 1);
 	}
 #endif
 
Index: 2.6.18-rc7-mm1/arch/mips/sgi-ip22/ip22-reset.c
===================================================================
--- 2.6.18-rc7-mm1.orig/arch/mips/sgi-ip22/ip22-reset.c
+++ 2.6.18-rc7-mm1/arch/mips/sgi-ip22/ip22-reset.c
@@ -123,7 +123,7 @@ static inline void power_button(void)
 	if (machine_state & MACHINE_PANICED)
 		return;
 
-	if ((machine_state & MACHINE_SHUTTING_DOWN) || kill_proc(1,SIGINT,1)) {
+	if ((machine_state & MACHINE_SHUTTING_DOWN) || kill_cad_pid(SIGINT, 1)) {
 		/* No init process or button pressed twice.  */
 		sgi_machine_power_off();
 	}
