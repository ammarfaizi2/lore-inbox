Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264936AbUGBVvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264936AbUGBVvB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 17:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264946AbUGBVvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 17:51:01 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:30426 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264936AbUGBVue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 17:50:34 -0400
Date: Fri, 2 Jul 2004 23:50:24 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>, Dave Jones <davej@codemonkey.org.uk>
Cc: limaunion@fibertel.com.ar, linux-kernel@vger.kernel.org,
       cpufreq@www.linux.org.uk, water modem <lundby@ameritech.net>
Subject: [patch] Re: 2.6.7-mm2 build errors...
Message-ID: <20040702215024.GL28324@fs.tum.de>
References: <40DCEFFB.5020605@fibertel.com.ar> <20040702205129.GK28324@fs.tum.de> <20040702140322.2ab47867.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040702140322.2ab47867.rddunlap@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 02:03:22PM -0700, Randy.Dunlap wrote:
> On Fri, 2 Jul 2004 22:51:29 +0200 Adrian Bunk wrote:
> 
> | On Sat, Jun 26, 2004 at 12:39:39AM -0300, limaunion wrote:
> | 
> | >   LD      .tmp_vmlinux1
> | > arch/i386/kernel/built-in.o(.text+0xbe14): In function `powernow_acpi_init':
> | > : undefined reference to `acpi_processor_register_performance'
> | > arch/i386/kernel/built-in.o(.text+0xbe3b): In function `powernow_acpi_init':
> | > : undefined reference to `acpi_processor_unregister_performance'
> | > arch/i386/kernel/built-in.o(.exit.text+0x3b): In function `powernow_exit':
> | > : undefined reference to `acpi_processor_unregister_performance'
> | > make: *** [.tmp_vmlinux1] Error 1
> | > 
> | > This also happens in 2.6.7-mm1, I'm wondering if this is my fault or 
> | > something's wrong?
> | 
> | It seems something is/was wrong.
> | 
> | Can you still reproduce it in 2.6.7-mm5?
> | If yes, please send your .config.
> 
> Same as this problem report:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=108752330915120&w=2
> 
> but my patch was insufficient:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=108753512102539&w=2
> 
> See reply from Dave Jones.  And I see what he means, but I don't
> see how to express it in Kconfig language.

What about the patch below?

> ~Randy

cu
Adrian


Fix compile errors with X86_POWERNOW_K{7,8}=y and ACPI_PROCESSOR=m.

diffstat output:
 arch/i386/kernel/cpu/cpufreq/Kconfig       |   10 ++++++++++
 arch/i386/kernel/cpu/cpufreq/powernow-k7.c |   10 +++++-----
 arch/i386/kernel/cpu/cpufreq/powernow-k8.c |    4 ++--
 arch/i386/kernel/cpu/cpufreq/powernow-k8.h |    2 +-
 4 files changed, 18 insertions(+), 8 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm5-full/arch/i386/kernel/cpu/cpufreq/Kconfig.old	2004-07-02 23:21:22.000000000 +0200
+++ linux-2.6.7-mm5-full/arch/i386/kernel/cpu/cpufreq/Kconfig	2004-07-02 23:39:15.000000000 +0200
@@ -88,6 +88,11 @@
 
 	  If in doubt, say N.
 
+config X86_POWERNOW_K7_ACPI
+	bool
+	default y
+	depends on (X86_POWERNOW_K7=m && ACPI_PROCESSOR) || (X86_POWERNOW_K7=y && ACPI_PROCESSOR=y)
+
 config X86_POWERNOW_K8
 	tristate "AMD Opteron/Athlon64 PowerNow!"
 	depends on CPU_FREQ && EXPERIMENTAL
@@ -98,6 +103,11 @@
 
 	  If in doubt, say N.
 
+config X86_POWERNOW_K8_ACPI
+	bool
+	default y
+	depends on (X86_POWERNOW_K8=m && ACPI_PROCESSOR) || (X86_POWERNOW_K8=y && ACPI_PROCESSOR=y)
+
 config X86_GX_SUSPMOD
 	tristate "Cyrix MediaGX/NatSemi Geode Suspend Modulation"
 	depends on CPU_FREQ
--- linux-2.6.7-mm5-full/arch/i386/kernel/cpu/cpufreq/powernow-k7.c.old	2004-07-02 23:25:47.000000000 +0200
+++ linux-2.6.7-mm5-full/arch/i386/kernel/cpu/cpufreq/powernow-k7.c	2004-07-02 23:37:05.000000000 +0200
@@ -29,7 +29,7 @@
 #include <asm/io.h>
 #include <asm/system.h>
 
-#if defined(CONFIG_ACPI_PROCESSOR) || defined(CONFIG_ACPI_PROCESSOR_MODULE)
+#ifdef CONFIG_X86_POWERNOW_K7_ACPI
 #include <linux/acpi.h>
 #include <acpi/processor.h>
 #endif
@@ -64,7 +64,7 @@
 	u8 numpstates;
 };
 
-#if defined(CONFIG_ACPI_PROCESSOR) || defined(CONFIG_ACPI_PROCESSOR_MODULE)
+#ifdef CONFIG_X86_POWERNOW_K7_ACPI
 union powernow_acpi_control_t {
 	struct {
 		unsigned long fid:5,
@@ -190,7 +190,7 @@
 		speed = powernow_table[j].frequency;
 
 		if ((fid_codes[fid] % 10)==5) {
-#if defined(CONFIG_ACPI_PROCESSOR) || defined(CONFIG_ACPI_PROCESSOR_MODULE)
+#ifdef CONFIG_X86_POWERNOW_K7_ACPI
 			if (have_a0 == 1)
 				powernow_table[j].frequency = CPUFREQ_ENTRY_INVALID;
 #endif
@@ -294,7 +294,7 @@
 }
 
 
-#if defined(CONFIG_ACPI_PROCESSOR) || defined(CONFIG_ACPI_PROCESSOR_MODULE)
+#ifdef CONFIG_X86_POWERNOW_K7_ACPI
 
 struct acpi_processor_performance *acpi_processor_perf;
 
@@ -668,7 +668,7 @@
 
 static void __exit powernow_exit (void)
 {
-#if defined(CONFIG_ACPI_PROCESSOR) || defined(CONFIG_ACPI_PROCESSOR_MODULE)
+#ifdef CONFIG_X86_POWERNOW_K7_ACPI
 	if (acpi_processor_perf) {
 		acpi_processor_unregister_performance(acpi_processor_perf, 0);
 		kfree(acpi_processor_perf);
--- linux-2.6.7-mm5-full/arch/i386/kernel/cpu/cpufreq/powernow-k8.h.old	2004-07-02 23:33:50.000000000 +0200
+++ linux-2.6.7-mm5-full/arch/i386/kernel/cpu/cpufreq/powernow-k8.h	2004-07-02 23:34:21.000000000 +0200
@@ -29,7 +29,7 @@
 	 * frequency is in kHz */
 	struct cpufreq_frequency_table  *powernow_table;
 
-#if defined(CONFIG_ACPI_PROCESSOR) || defined(CONFIG_ACPI_PROCESSOR_MODULE)
+#ifdef CONFIG_X86_POWERNOW_K8_ACPI
 	/* the acpi table needs to be kept. it's only available if ACPI was
 	 * used to determine valid frequency/vid/fid states */
 	struct acpi_processor_performance acpi_data;
--- linux-2.6.7-mm5-full/arch/i386/kernel/cpu/cpufreq/powernow-k8.c.old	2004-07-02 23:26:42.000000000 +0200
+++ linux-2.6.7-mm5-full/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2004-07-02 23:36:48.000000000 +0200
@@ -32,7 +32,7 @@
 #include <asm/io.h>
 #include <asm/delay.h>
 
-#if defined(CONFIG_ACPI_PROCESSOR) || defined(CONFIG_ACPI_PROCESSOR_MODULE)
+#ifdef CONFIG_X86_POWERNOW_K8_ACPI
 #include <linux/acpi.h>
 #include <acpi/processor.h>
 #endif
@@ -664,7 +664,7 @@
 	return -ENODEV;
 }
 
-#if defined(CONFIG_ACPI_PROCESSOR) || defined(CONFIG_ACPI_PROCESSOR_MODULE)
+#ifdef CONFIG_X86_POWERNOW_K8_ACPI
 static void powernow_k8_acpi_pst_values(struct powernow_k8_data *data, unsigned int index)
 {
 	if (!data->acpi_data.state_count)
