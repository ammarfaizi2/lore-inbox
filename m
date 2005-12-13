Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbVLMGhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbVLMGhm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 01:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbVLMGhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 01:37:42 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:59045 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932386AbVLMGhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 01:37:42 -0500
Message-ID: <439E6C58.6050301@jp.fujitsu.com>
Date: Tue, 13 Dec 2005 15:38:16 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add mem_nmi_panic enable system to panic on hard error
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some x86 server fires NMI with reason 0x80 up if a parity error
occurs on its PCI-bus system or DIMM module.
However, such NMI cannot stop the system and data pollution,
because the NMI is _not_ "unknown", through unknown_nmi_panic
can panic the system on NMI which has no reason bits.

This patch adds "mem_nmi_panic" sysctl parameter that enable
system to switch its action on such NMI originated in a hard error.
Also it seems that x86_86 has same situation and problem,
so this is a couple of patch for 2 archs, i386 and x86_64.

signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

H.Seto

-----

  Documentation/filesystems/proc.txt |   16 +++++++
  arch/i386/kernel/nmi.c             |   71 +++++++++++++++++++++++++++-------
  arch/x86_64/kernel/nmi.c           |   76 ++++++++++++++++++++++++++++---------
  arch/x86_64/kernel/traps.c         |    2
  include/asm-x86_64/nmi.h           |    1
  include/linux/sysctl.h             |    1
  kernel/sysctl.c                    |   13 ++++++
  7 files changed, 146 insertions(+), 34 deletions(-)

Index: linux-2.6.15-rc5/kernel/sysctl.c
===================================================================
--- linux-2.6.15-rc5.orig/kernel/sysctl.c
+++ linux-2.6.15-rc5/kernel/sysctl.c
@@ -72,6 +72,9 @@ extern int pid_max_min, pid_max_max;
  int unknown_nmi_panic;
  extern int proc_unknown_nmi_panic(ctl_table *, int, struct file *,
  				  void __user *, size_t *, loff_t *);
+int mem_nmi_panic;
+extern int proc_mem_nmi_panic(ctl_table *, int, struct file *,
+				  void __user *, size_t *, loff_t *);
  #endif

  /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
@@ -656,6 +659,16 @@ static ctl_table kern_table[] = {
  		.proc_handler	= &proc_dointvec,
  	},
  #endif
+#if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
+	{
+		.ctl_name       = KERN_MEM_NMI_PANIC,
+		.procname       = "mem_nmi_panic",
+		.data           = &mem_nmi_panic,
+		.maxlen         = sizeof (int),
+		.mode           = 0644,
+		.proc_handler   = &proc_mem_nmi_panic,
+	},
+#endif
  	{ .ctl_name = 0 }
  };

Index: linux-2.6.15-rc5/arch/i386/kernel/nmi.c
===================================================================
--- linux-2.6.15-rc5.orig/arch/i386/kernel/nmi.c
+++ linux-2.6.15-rc5/arch/i386/kernel/nmi.c
@@ -34,6 +34,7 @@

  unsigned int nmi_watchdog = NMI_NONE;
  extern int unknown_nmi_panic;
+extern int mem_nmi_panic;
  static unsigned int nmi_hz = HZ;
  static unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */
  static unsigned int nmi_p4_cccr_val;
@@ -572,15 +573,40 @@ void nmi_watchdog_tick (struct pt_regs *

  #ifdef CONFIG_SYSCTL

-static int unknown_nmi_panic_callback(struct pt_regs *regs, int cpu)
+static int nmi_panic_callback(struct pt_regs *regs, int cpu)
  {
  	unsigned char reason = get_nmi_reason();
  	char buf[64];

-	if (!(reason & 0xc0)) {
+	if (unknown_nmi_panic && !(reason & 0xc0)) {
  		sprintf(buf, "NMI received for unknown reason %02x\n", reason);
  		die_nmi(regs, buf);
  	}
+	if (mem_nmi_panic && (reason & 0x80)) {
+		sprintf(buf, "NMI received for possible memory parity error "
+			"%02x\n", reason);
+		die_nmi(regs, buf);
+	}
+	return 0;
+}
+
+static DEFINE_SPINLOCK(nmi_panic_callback_lock);
+static int nmi_panic_callback_active = 0;
+
+static int switch_nmi_panic_callback(void)
+{
+	if (unknown_nmi_panic || mem_nmi_panic) {
+		if (nmi_panic_callback_active)
+			return 0;
+		if (reserve_lapic_nmi() < 0)
+			return -EBUSY;
+		set_nmi_callback(nmi_panic_callback);
+		nmi_panic_callback_active = 1;
+	} else {
+		release_lapic_nmi();
+		unset_nmi_callback();
+		nmi_panic_callback_active = 0;
+	}
  	return 0;
  }

@@ -590,25 +616,40 @@ static int unknown_nmi_panic_callback(st
  int proc_unknown_nmi_panic(ctl_table *table, int write, struct file *file,
  			void __user *buffer, size_t *length, loff_t *ppos)
  {
-	int old_state;
+	int old_state, ret = 0;

+	spin_lock(&nmi_panic_callback_lock);
  	old_state = unknown_nmi_panic;
  	proc_dointvec(table, write, file, buffer, length, ppos);
-	if (!!old_state == !!unknown_nmi_panic)
-		return 0;

-	if (unknown_nmi_panic) {
-		if (reserve_lapic_nmi() < 0) {
+	if (!!old_state != !!unknown_nmi_panic) {
+		ret = switch_nmi_panic_callback();
+		if (ret)
  			unknown_nmi_panic = 0;
-			return -EBUSY;
-		} else {
-			set_nmi_callback(unknown_nmi_panic_callback);
-		}
-	} else {
-		release_lapic_nmi();
-		unset_nmi_callback();
  	}
-	return 0;
+	spin_unlock(&nmi_panic_callback_lock);
+	return ret;
+}
+
+/*
+ * proc handler for /proc/sys/kernel/mem_nmi_panic
+ */
+int proc_mem_nmi_panic(ctl_table *table, int write, struct file *file,
+			void __user *buffer, size_t *length, loff_t *ppos)
+{
+	int old_state, ret = 0;
+
+	spin_lock(&nmi_panic_callback_lock);
+	old_state = mem_nmi_panic;
+	proc_dointvec(table, write, file, buffer, length, ppos);
+
+	if (!!old_state != !!mem_nmi_panic) {
+		ret = switch_nmi_panic_callback();
+		if (ret)
+			mem_nmi_panic = 0;
+	}
+	spin_unlock(&nmi_panic_callback_lock);
+	return ret;
  }

  #endif
Index: linux-2.6.15-rc5/Documentation/filesystems/proc.txt
===================================================================
--- linux-2.6.15-rc5.orig/Documentation/filesystems/proc.txt
+++ linux-2.6.15-rc5/Documentation/filesystems/proc.txt
@@ -1130,6 +1130,22 @@ If a system hangs up, try pressing the N
     And NMI watchdog will be disabled when the value in this file is set to
     non-zero.

+mem_nmi_panic
+-----------------
+
+The value in this file affects behavior of handling NMI. When the value is
+non-zero, NMI with reason 0x80 is trapped and then panic occurs. At that time,
+kernel debugging information is displayed on console.
+
+Some x86 server fires NMI with reason 0x80 up if a parity error occurs on
+its PCI-bus system or DIMM module, for example.
+
+[NOTE]
+   This function and oprofile share a NMI callback. Therefore this function
+   cannot be enabled when oprofile is activated.
+   And NMI watchdog will be disabled when the value in this file is set to
+   non-zero.
+

  2.4 /proc/sys/vm - The virtual memory subsystem
  -----------------------------------------------
Index: linux-2.6.15-rc5/arch/x86_64/kernel/nmi.c
===================================================================
--- linux-2.6.15-rc5.orig/arch/x86_64/kernel/nmi.c
+++ linux-2.6.15-rc5/arch/x86_64/kernel/nmi.c
@@ -488,7 +488,7 @@ void nmi_watchdog_tick (struct pt_regs *
  				local_set(&__get_cpu_var(alert_counter), 0);
  				return;
  			}
-			die_nmi("NMI Watchdog detected LOCKUP on CPU %d\n", regs);
+			die_nmi("NMI Watchdog detected LOCKUP", regs);
  		}
  	} else {
  		__get_cpu_var(last_irq_sum) = sum;
@@ -540,14 +540,39 @@ void unset_nmi_callback(void)

  #ifdef CONFIG_SYSCTL

-static int unknown_nmi_panic_callback(struct pt_regs *regs, int cpu)
+static int nmi_panic_callback(struct pt_regs *regs, int cpu)
  {
  	unsigned char reason = get_nmi_reason();
  	char buf[64];

-	if (!(reason & 0xc0)) {
-		sprintf(buf, "NMI received for unknown reason %02x\n", reason);
-		die_nmi(buf,regs);
+	if (unknown_nmi_panic && !(reason & 0xc0)) {
+		sprintf(buf, "NMI received for unknown reason %02x", reason);
+		die_nmi(buf, regs);
+	}
+	if (mem_nmi_panic && (reason & 0x80)) {
+		sprintf(buf, "NMI received for possible memory parity error "
+			"%02x", reason);
+		die_nmi(buf, regs);
+	}
+	return 0;
+}
+
+static DEFINE_SPINLOCK(nmi_panic_callback_lock);
+static int nmi_panic_callback_active = 0;
+
+static int switch_nmi_panic_callback(void)
+{
+	if (unknown_nmi_panic || mem_nmi_panic) {
+		if (nmi_panic_callback_active)
+			return 0;
+		if (reserve_lapic_nmi() < 0)
+			return -EBUSY;
+		set_nmi_callback(nmi_panic_callback);
+		nmi_panic_callback_active = 1;
+	} else {
+		release_lapic_nmi();
+		unset_nmi_callback();
+		nmi_panic_callback_active = 0;
  	}
  	return 0;
  }
@@ -558,25 +583,40 @@ static int unknown_nmi_panic_callback(st
  int proc_unknown_nmi_panic(struct ctl_table *table, int write, struct file *file,
  			void __user *buffer, size_t *length, loff_t *ppos)
  {
-	int old_state;
+	int old_state, ret = 0;

+	spin_lock(&nmi_panic_callback_lock);
  	old_state = unknown_nmi_panic;
  	proc_dointvec(table, write, file, buffer, length, ppos);
-	if (!!old_state == !!unknown_nmi_panic)
-		return 0;

-	if (unknown_nmi_panic) {
-		if (reserve_lapic_nmi() < 0) {
+	if (!!old_state != !!unknown_nmi_panic) {
+		ret = switch_nmi_panic_callback();
+		if (ret)
  			unknown_nmi_panic = 0;
-			return -EBUSY;
-		} else {
-			set_nmi_callback(unknown_nmi_panic_callback);
-		}
-	} else {
-		release_lapic_nmi();
-		unset_nmi_callback();
  	}
-	return 0;
+	spin_unlock(&nmi_panic_callback_lock);
+	return ret;
+}
+
+/*
+ * proc handler for /proc/sys/kernel/mem_nmi_panic
+ */
+int proc_mem_nmi_panic(struct ctl_table *table, int write, struct file *file,
+			void __user *buffer, size_t *length, loff_t *ppos)
+{
+	int old_state, ret;
+
+	spin_lock(&nmi_panic_callback_lock);
+	old_state = mem_nmi_panic;
+	proc_dointvec(table, write, file, buffer, length, ppos);
+
+	if (!!old_state != !!mem_nmi_panic)
+		ret = switch_nmi_panic_callback();
+		if (ret)
+			mem_nmi_panic = 0;
+	}
+	spin_unlock(&nmi_panic_callback_lock);
+	return ret;
  }

  #endif
Index: linux-2.6.15-rc5/include/asm-x86_64/nmi.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-x86_64/nmi.h
+++ linux-2.6.15-rc5/include/asm-x86_64/nmi.h
@@ -53,6 +53,7 @@ extern void die_nmi(char *str, struct pt

  extern int panic_on_timeout;
  extern int unknown_nmi_panic;
+extern int mem_nmi_panic;

  extern int check_nmi_watchdog(void);

Index: linux-2.6.15-rc5/arch/x86_64/kernel/traps.c
===================================================================
--- linux-2.6.15-rc5.orig/arch/x86_64/kernel/traps.c
+++ linux-2.6.15-rc5/arch/x86_64/kernel/traps.c
@@ -413,7 +413,7 @@ void die_nmi(char *str, struct pt_regs *
  	 * We are in trouble anyway, lets at least try
  	 * to get a message out.
  	 */
-	printk(str, safe_smp_processor_id());
+	printk("%s on CPU %d\n", str, safe_smp_processor_id());
  	show_registers(regs);
  	if (panic_on_timeout || panic_on_oops)
  		panic("nmi watchdog");
Index: linux-2.6.15-rc5/include/linux/sysctl.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/sysctl.h
+++ linux-2.6.15-rc5/include/linux/sysctl.h
@@ -146,6 +146,7 @@ enum
  	KERN_RANDOMIZE=68, /* int: randomize virtual address space */
  	KERN_SETUID_DUMPABLE=69, /* int: behaviour of dumps for setuid core */
  	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
+	KERN_MEM_NMI_PANIC=71,	/* int: memory nmi panic flag */
  };




