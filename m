Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264374AbUD0W14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264374AbUD0W14 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 18:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbUD0W14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 18:27:56 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:11704 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264374AbUD0W1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 18:27:48 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC (xSeries Solutions
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.5-rc2: Configure APIC default enabled state
Date: Tue, 27 Apr 2004 15:27:41 -0700
User-Agent: KMail/1.5.4
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, John Stultz <johnstul@us.ibm.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_d5tjAs3BVa7Slye"
Message-Id: <200404271527.41098.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_d5tjAs3BVa7Slye
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Patch to make the default APIC state configurable.  Mostly useful for distro 
installer kernels.


diff -pru 2.6.5-rc2/arch/i386/Kconfig z5r2/arch/i386/Kconfig
--- 2.6.5-rc2/arch/i386/Kconfig	2004-03-19 16:11:02.000000000 -0800
+++ z5r2/arch/i386/Kconfig	2004-04-27 15:18:45.758181660 -0700
@@ -517,6 +517,18 @@ config X86_UP_IOAPIC
 	  If you have a system with several CPUs, you do not need to say Y
 	  here: the IO-APIC will be used automatically.
 
+config X86_UP_APIC_DEFAULT_OFF
+	bool "APIC support on uniprocessors defaults to off"
+	depends on !SMP && X86_UP_APIC
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
 	depends on !SMP && X86_UP_APIC
diff -pru 2.6.5-rc2/arch/i386/kernel/apic.c z5r2/arch/i386/kernel/apic.c
--- 2.6.5-rc2/arch/i386/kernel/apic.c	2004-03-19 16:12:09.000000000 -0800
+++ z5r2/arch/i386/kernel/apic.c	2004-04-27 15:18:45.760180861 -0700
@@ -608,7 +608,7 @@ static void apic_pm_activate(void) { }
 /*
  * Knob to control our willingness to enable the local APIC.
  */
-int enable_local_apic __initdata = 0; /* -1=force-disable, +1=force-enable 
*/
+int enable_local_apic __initdata = (X86_APIC_DEFAULT_OFF ? -1 : 0); /* 
-1=force-disable, +1=force-enable */
 
 static int __init lapic_disable(char *str)
 {
diff -pru 2.6.5-rc2/arch/i386/kernel/io_apic.c z5r2/arch/i386/kernel/
io_apic.c
--- 2.6.5-rc2/arch/i386/kernel/io_apic.c	2004-03-19 16:11:04.000000000 -0800
+++ z5r2/arch/i386/kernel/io_apic.c	2004-04-27 15:18:45.762180063 -0700
@@ -719,7 +719,7 @@ void fastcall send_IPI_self(int vector)
 #define MAX_PIRQS 8
 int pirq_entries [MAX_PIRQS];
 int pirqs_enabled;
-int skip_ioapic_setup;
+int skip_ioapic_setup = X86_APIC_DEFAULT_OFF;
 
 static int __init ioapic_setup(char *str)
 {
diff -pru 2.6.5-rc2/arch/i386/kernel/setup.c z5r2/arch/i386/kernel/setup.c
--- 2.6.5-rc2/arch/i386/kernel/setup.c	2004-03-19 16:11:09.000000000 -0800
+++ z5r2/arch/i386/kernel/setup.c	2004-04-27 15:18:45.764179265 -0700
@@ -594,6 +594,9 @@ static void __init parse_cmdline_early (
 		/* disable IO-APIC */
 		else if (!memcmp(from, "noapic", 6))
 			disable_ioapic_setup();
+		/* disable IO-APIC */
+		else if (!memcmp(from, "apic", 4))
+			enable_ioapic_setup();
 #endif /* CONFIG_X86_LOCAL_APIC */
 #endif /* CONFIG_ACPI_BOOT */
 
diff -pru 2.6.5-rc2/include/asm-i386/acpi.h z5r2/include/asm-i386/acpi.h
--- 2.6.5-rc2/include/asm-i386/acpi.h	2004-03-19 16:11:42.000000000 -0800
+++ z5r2/include/asm-i386/acpi.h	2004-04-27 15:18:45.766178467 -0700
@@ -128,6 +128,10 @@ static inline void disable_ioapic_setup(
 {
 	skip_ioapic_setup = 1;
 }
+static inline void enable_ioapic_setup(void)
+{
+	skip_ioapic_setup = 0;
+}
 
 static inline int ioapic_setup_disabled(void)
 {
diff -pru 2.6.5-rc2/include/asm-i386/apic.h z5r2/include/asm-i386/apic.h
--- 2.6.5-rc2/include/asm-i386/apic.h	2004-03-19 16:12:00.000000000 -0800
+++ z5r2/include/asm-i386/apic.h	2004-04-27 15:18:45.766178467 -0700
@@ -51,6 +51,12 @@ static __inline__ void apic_wait_icr_idl
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


-- 
James Cleverdon
IBM LTC (xSeries Linux Solutions)
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm

--Boundary-00=_d5tjAs3BVa7Slye
Content-Type: text/x-diff;
  charset="us-ascii";
  name="apic_default_off_2.6.5-rc2_2004-04-27"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="apic_default_off_2.6.5-rc2_2004-04-27"

diff -pru 2.6.5-rc2/arch/i386/Kconfig z5r2/arch/i386/Kconfig
--- 2.6.5-rc2/arch/i386/Kconfig	2004-03-19 16:11:02.000000000 -0800
+++ z5r2/arch/i386/Kconfig	2004-04-27 15:18:45.758181660 -0700
@@ -517,6 +517,18 @@ config X86_UP_IOAPIC
 	  If you have a system with several CPUs, you do not need to say Y
 	  here: the IO-APIC will be used automatically.
 
+config X86_UP_APIC_DEFAULT_OFF
+	bool "APIC support on uniprocessors defaults to off"
+	depends on !SMP && X86_UP_APIC
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
 	depends on !SMP && X86_UP_APIC
diff -pru 2.6.5-rc2/arch/i386/kernel/apic.c z5r2/arch/i386/kernel/apic.c
--- 2.6.5-rc2/arch/i386/kernel/apic.c	2004-03-19 16:12:09.000000000 -0800
+++ z5r2/arch/i386/kernel/apic.c	2004-04-27 15:18:45.760180861 -0700
@@ -608,7 +608,7 @@ static void apic_pm_activate(void) { }
 /*
  * Knob to control our willingness to enable the local APIC.
  */
-int enable_local_apic __initdata = 0; /* -1=force-disable, +1=force-enable */
+int enable_local_apic __initdata = (X86_APIC_DEFAULT_OFF ? -1 : 0); /* -1=force-disable, +1=force-enable */
 
 static int __init lapic_disable(char *str)
 {
diff -pru 2.6.5-rc2/arch/i386/kernel/io_apic.c z5r2/arch/i386/kernel/io_apic.c
--- 2.6.5-rc2/arch/i386/kernel/io_apic.c	2004-03-19 16:11:04.000000000 -0800
+++ z5r2/arch/i386/kernel/io_apic.c	2004-04-27 15:18:45.762180063 -0700
@@ -719,7 +719,7 @@ void fastcall send_IPI_self(int vector)
 #define MAX_PIRQS 8
 int pirq_entries [MAX_PIRQS];
 int pirqs_enabled;
-int skip_ioapic_setup;
+int skip_ioapic_setup = X86_APIC_DEFAULT_OFF;
 
 static int __init ioapic_setup(char *str)
 {
diff -pru 2.6.5-rc2/arch/i386/kernel/setup.c z5r2/arch/i386/kernel/setup.c
--- 2.6.5-rc2/arch/i386/kernel/setup.c	2004-03-19 16:11:09.000000000 -0800
+++ z5r2/arch/i386/kernel/setup.c	2004-04-27 15:18:45.764179265 -0700
@@ -594,6 +594,9 @@ static void __init parse_cmdline_early (
 		/* disable IO-APIC */
 		else if (!memcmp(from, "noapic", 6))
 			disable_ioapic_setup();
+		/* disable IO-APIC */
+		else if (!memcmp(from, "apic", 4))
+			enable_ioapic_setup();
 #endif /* CONFIG_X86_LOCAL_APIC */
 #endif /* CONFIG_ACPI_BOOT */
 
diff -pru 2.6.5-rc2/include/asm-i386/acpi.h z5r2/include/asm-i386/acpi.h
--- 2.6.5-rc2/include/asm-i386/acpi.h	2004-03-19 16:11:42.000000000 -0800
+++ z5r2/include/asm-i386/acpi.h	2004-04-27 15:18:45.766178467 -0700
@@ -128,6 +128,10 @@ static inline void disable_ioapic_setup(
 {
 	skip_ioapic_setup = 1;
 }
+static inline void enable_ioapic_setup(void)
+{
+	skip_ioapic_setup = 0;
+}
 
 static inline int ioapic_setup_disabled(void)
 {
diff -pru 2.6.5-rc2/include/asm-i386/apic.h z5r2/include/asm-i386/apic.h
--- 2.6.5-rc2/include/asm-i386/apic.h	2004-03-19 16:12:00.000000000 -0800
+++ z5r2/include/asm-i386/apic.h	2004-04-27 15:18:45.766178467 -0700
@@ -51,6 +51,12 @@ static __inline__ void apic_wait_icr_idl
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

--Boundary-00=_d5tjAs3BVa7Slye--

