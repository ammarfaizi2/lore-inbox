Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759008AbWK3E0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759008AbWK3E0p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 23:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759015AbWK3E0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 23:26:25 -0500
Received: from www.swissdisk.com ([216.66.254.197]:23987 "EHLO
	swissweb.swissdisk.com") by vger.kernel.org with ESMTP
	id S1759009AbWK3E0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 23:26:18 -0500
From: Ben Collins <bcollins@ubuntu.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: [PATCH 2/4] [APIC] Allow disabling of UP APIC/IO-APIC by default, with command line option to turn it on.
Reply-To: Ben Collins <bcollins@ubuntu.com>
Date: Wed, 29 Nov 2006 23:26:06 -0500
Message-Id: <11648607732981-git-send-email-bcollins@ubuntu.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11648607683157-git-send-email-bcollins@ubuntu.com>
References: <11648607683157-git-send-email-bcollins@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ben Collins <bcollins@ubuntu.com>
---
 arch/i386/Kconfig          |   13 +++++++++++++
 arch/i386/kernel/apic.c    |   13 +++++++++++--
 arch/i386/kernel/io_apic.c |   10 +++++++++-
 include/asm-i386/apic.h    |    6 ++++++
 include/asm-i386/io_apic.h |    5 +++++
 5 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index b4a2461..ef2f2db 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -285,6 +285,19 @@ config X86_UP_IOAPIC
 	  to use it. If you say Y here even though your machine doesn't have
 	  an IO-APIC, then the kernel will still run with no slowdown at all.
 
+config X86_UP_APIC_DEFAULT_OFF
+	bool "APIC support on uniprocessors defaults to off"
+	depends on X86_UP_APIC
+	default n
+	help
+	  Some older systems have flaky APICs.  Say Y to turn off APIC
+	  support by default, while still allowing it to be enabled by the
+	  "lapic" and "apic" command line options.
+
+	  Usually this is only necessary for distro installer kernels that
+	  must work with everything.  Everyone else can safely say N here
+	  and configure APIC support in or out as needed.
+
 config X86_LOCAL_APIC
 	bool
 	depends on X86_UP_APIC || ((X86_VISWS || SMP) && !X86_VOYAGER) || X86_GENERICARCH
diff --git a/arch/i386/kernel/apic.c b/arch/i386/kernel/apic.c
index 2fd4b7d..2f2eb83 100644
--- a/arch/i386/kernel/apic.c
+++ b/arch/i386/kernel/apic.c
@@ -51,8 +51,9 @@ static cpumask_t timer_bcast_ipi;
 
 /*
  * Knob to control our willingness to enable the local APIC.
+ * -2=default-disable, -1=force-disable, 1=force-enable, 0=automatic
  */
-static int enable_local_apic __initdata = 0; /* -1=force-disable, +1=force-enable */
+static int enable_local_apic __initdata = (X86_APIC_DEFAULT_OFF ? -2 : 0);
 
 static inline void lapic_disable(void)
 {
@@ -801,7 +802,7 @@ static int __init detect_init_APIC (void
 		 * APIC only if "lapic" specified.
 		 */
 		if (enable_local_apic <= 0) {
-			printk("Local APIC disabled by BIOS -- "
+			printk("Local APIC disabled by BIOS (or by default) -- "
 			       "you can enable it with \"lapic\"\n");
 			return -1;
 		}
@@ -1350,6 +1351,14 @@ int __init APIC_init_uniprocessor (void)
 	if (!smp_found_config && !cpu_has_apic)
 		return -1;
 
+	/* If local apic is off due to config_x86_apic_off option, jump
+	 * out here. */
+	if (enable_local_apic < -1) {
+		printk(KERN_INFO "Local APIC disabled by default -- "
+		       "use 'lapic' to enable it.\n");
+		return -1;
+	}
+
 	/*
 	 * Complain if the BIOS pretends there is one.
 	 */
diff --git a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
index 3b7a63e..0122dba 100644
--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -767,7 +767,7 @@ #endif /* !CONFIG_SMP */
 #define MAX_PIRQS 8
 static int pirq_entries [MAX_PIRQS];
 static int pirqs_enabled;
-int skip_ioapic_setup;
+int skip_ioapic_setup = X86_APIC_DEFAULT_OFF;
 
 static int __init ioapic_setup(char *str)
 {
@@ -2887,3 +2887,11 @@ static int __init parse_noapic(char *arg
 	return 0;
 }
 early_param("noapic", parse_noapic);
+
+static int __init parse_apic(char *arg)
+{
+	/* enable IO-APIC */
+	enable_ioapic_setup();
+	return 0;
+}
+early_param("apic", parse_apic);
diff --git a/include/asm-i386/apic.h b/include/asm-i386/apic.h
index b952957..a06ca3f 100644
--- a/include/asm-i386/apic.h
+++ b/include/asm-i386/apic.h
@@ -71,6 +71,12 @@ # define apic_read_around(x) apic_read(x
 # define apic_write_around(x,y) apic_write_atomic((x),(y))
 #endif
 
+#ifdef CONFIG_X86_UP_APIC_DEFAULT_OFF
+# define X86_APIC_DEFAULT_OFF 1
+#else
+# define X86_APIC_DEFAULT_OFF 0
+#endif
+
 static inline void ack_APIC_irq(void)
 {
 	/*
diff --git a/include/asm-i386/io_apic.h b/include/asm-i386/io_apic.h
index 059a9ff..ddedeec 100644
--- a/include/asm-i386/io_apic.h
+++ b/include/asm-i386/io_apic.h
@@ -126,6 +126,11 @@ static inline void disable_ioapic_setup(
 	skip_ioapic_setup = 1;
 }
 
+static inline void enable_ioapic_setup(void)
+{
+	skip_ioapic_setup = 0;
+}
+
 static inline int ioapic_setup_disabled(void)
 {
 	return skip_ioapic_setup;
-- 
1.4.1

