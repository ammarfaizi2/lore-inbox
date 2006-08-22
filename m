Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWHVPJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWHVPJO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 11:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWHVPJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 11:09:14 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:18374 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932302AbWHVPJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 11:09:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:message-id;
        b=ciXkDOCVVTFQMMy7Wlm8LrJB9MINtFI0/3r10b+ZCoWegHuRPrKZLU958JwpTS7FXCuv8VlOdTcnCYImTp5vR2X7Opolp6p0gloBUzhHNkaieB6dX2cLd/8JNPFqYDXeFrWCZmMYH/ZxwKZUQptRUgZiDjFR0K2hqg9VhgFNZss=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/3] s/#include <asm/delay.h>/#include <linux/delay.h>/
Date: Tue, 22 Aug 2006 15:48:37 +0200
User-Agent: KMail/1.8.2
References: <200608221545.26019.vda.linux@googlemail.com>
In-Reply-To: <200608221545.26019.vda.linux@googlemail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1sw6EQXCazj7QJf"
Message-Id: <200608221548.37192.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_1sw6EQXCazj7QJf
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 22 August 2006 15:45, Denis Vlasenko wrote:
> Currently, magic in include/linux/delay.h
> inlines mdelay and ssleep, and various arches
> do the same to udelay.
> 
> This is pointless. We are going to perform a delay of 1000+
> CPU cycles anyway, no need to optimize away a few cycles.
> 
> This patchset converts calls to these functions
> into true functuon calls, with no additional
> math done or hidden arguments pushed to stack
> at the callsite.

A few arch files won't see the definition of udelay()
in asm/delay.h anymore. Prevent that from biting us later.

Signed-off-by: Denis Vlasenko <vda.linux@googlemail.com>
--
vda

--Boundary-00=_1sw6EQXCazj7QJf
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="delay_new7.1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="delay_new7.1.patch"

diff -urpN linux-2.6.17.9/arch/alpha/kernel/core_t2.c linux-2.6.17.9.new7.1/arch/alpha/kernel/core_t2.c
--- linux-2.6.17.9/arch/alpha/kernel/core_t2.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/alpha/kernel/core_t2.c	2006-08-22 15:23:28.000000000 +0200
@@ -18,9 +18,9 @@
 #include <linux/pci.h>
 #include <linux/sched.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 
 #include <asm/ptrace.h>
-#include <asm/delay.h>
 
 #include "proto.h"
 #include "pci_impl.h"
diff -urpN linux-2.6.17.9/arch/arm/mach-integrator/platsmp.c linux-2.6.17.9.new7.1/arch/arm/mach-integrator/platsmp.c
--- linux-2.6.17.9/arch/arm/mach-integrator/platsmp.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/arm/mach-integrator/platsmp.c	2006-08-22 15:23:28.000000000 +0200
@@ -13,10 +13,10 @@
 #include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/mm.h>
+#include <linux/delay.h>
 
 #include <asm/atomic.h>
 #include <asm/cacheflush.h>
-#include <asm/delay.h>
 #include <asm/mmu_context.h>
 #include <asm/procinfo.h>
 #include <asm/ptrace.h>
diff -urpN linux-2.6.17.9/arch/arm/mach-omap2/board-h4.c linux-2.6.17.9.new7.1/arch/arm/mach-omap2/board-h4.c
--- linux-2.6.17.9/arch/arm/mach-omap2/board-h4.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/arm/mach-omap2/board-h4.c	2006-08-22 15:23:28.000000000 +0200
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/workqueue.h>
 #include <linux/input.h>
+#include <linux/delay.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
@@ -39,7 +40,6 @@
 #include "prcm-regs.h"
 
 #include <asm/io.h>
-#include <asm/delay.h>
 
 static unsigned int row_gpios[6] = { 88, 89, 124, 11, 6, 96 };
 static unsigned int col_gpios[7] = { 90, 91, 100, 36, 12, 97, 98 };
diff -urpN linux-2.6.17.9/arch/arm/plat-omap/mcbsp.c linux-2.6.17.9.new7.1/arch/arm/plat-omap/mcbsp.c
--- linux-2.6.17.9/arch/arm/plat-omap/mcbsp.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/arm/plat-omap/mcbsp.c	2006-08-22 15:23:28.000000000 +0200
@@ -20,8 +20,8 @@
 #include <linux/interrupt.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 
-#include <asm/delay.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 
diff -urpN linux-2.6.17.9/arch/cris/arch-v10/drivers/i2c.c linux-2.6.17.9.new7.1/arch/cris/arch-v10/drivers/i2c.c
--- linux-2.6.17.9/arch/cris/arch-v10/drivers/i2c.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/cris/arch-v10/drivers/i2c.c	2006-08-22 15:23:28.000000000 +0200
@@ -97,13 +97,13 @@
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/config.h>
+#include <linux/delay.h>
 
 #include <asm/etraxi2c.h>
 
 #include <asm/system.h>
 #include <asm/arch/svinto.h>
 #include <asm/io.h>
-#include <asm/delay.h>
 #include <asm/arch/io_interface_mux.h>
 
 #include "i2c.h"
diff -urpN linux-2.6.17.9/arch/cris/arch-v32/drivers/i2c.c linux-2.6.17.9.new7.1/arch/cris/arch-v32/drivers/i2c.c
--- linux-2.6.17.9/arch/cris/arch-v32/drivers/i2c.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/cris/arch-v32/drivers/i2c.c	2006-08-22 15:23:28.000000000 +0200
@@ -34,12 +34,12 @@
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/config.h>
+#include <linux/delay.h>
 
 #include <asm/etraxi2c.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
-#include <asm/delay.h>
 
 #include "i2c.h"
 
diff -urpN linux-2.6.17.9/arch/cris/arch-v32/kernel/smp.c linux-2.6.17.9.new7.1/arch/cris/arch-v32/kernel/smp.c
--- linux-2.6.17.9/arch/cris/arch-v32/kernel/smp.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/cris/arch-v32/kernel/smp.c	2006-08-22 15:23:28.000000000 +0200
@@ -1,4 +1,3 @@
-#include <asm/delay.h>
 #include <asm/arch/irq.h>
 #include <asm/arch/hwregs/intr_vect.h>
 #include <asm/arch/hwregs/intr_vect_defs.h>
@@ -8,6 +7,7 @@
 #include <asm/arch/hwregs/supp_reg.h>
 #include <asm/atomic.h>
 
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/timex.h>
diff -urpN linux-2.6.17.9/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c linux-2.6.17.9.new7.1/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
--- linux-2.6.17.9/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c	2006-08-22 15:23:28.000000000 +0200
@@ -33,8 +33,8 @@
 #include <linux/seq_file.h>
 #include <linux/compiler.h>
 #include <linux/sched.h>	/* current */
+#include <linux/delay.h>
 #include <asm/io.h>
-#include <asm/delay.h>
 #include <asm/uaccess.h>
 
 #include <linux/acpi.h>
diff -urpN linux-2.6.17.9/arch/i386/kernel/cpu/cpufreq/powernow-k8.c linux-2.6.17.9.new7.1/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
--- linux-2.6.17.9/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2006-08-22 15:23:28.000000000 +0200
@@ -33,10 +33,10 @@
 #include <linux/string.h>
 #include <linux/cpumask.h>
 #include <linux/sched.h>	/* for current / set_cpus_allowed() */
+#include <linux/delay.h>
 
 #include <asm/msr.h>
 #include <asm/io.h>
-#include <asm/delay.h>
 
 #ifdef CONFIG_X86_POWERNOW_K8_ACPI
 #include <linux/acpi.h>
diff -urpN linux-2.6.17.9/arch/i386/kernel/i8259.c linux-2.6.17.9.new7.1/arch/i386/kernel/i8259.c
--- linux-2.6.17.9/arch/i386/kernel/i8259.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/i386/kernel/i8259.c	2006-08-22 15:23:28.000000000 +0200
@@ -11,6 +11,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
 #include <linux/bitops.h>
+#include <linux/delay.h>
 
 #include <asm/8253pit.h>
 #include <asm/atomic.h>
@@ -18,7 +19,6 @@
 #include <asm/io.h>
 #include <asm/timer.h>
 #include <asm/pgtable.h>
-#include <asm/delay.h>
 #include <asm/desc.h>
 #include <asm/apic.h>
 #include <asm/arch_hooks.h>
diff -urpN linux-2.6.17.9/arch/i386/kernel/reboot_fixups.c linux-2.6.17.9.new7.1/arch/i386/kernel/reboot_fixups.c
--- linux-2.6.17.9/arch/i386/kernel/reboot_fixups.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/i386/kernel/reboot_fixups.c	2006-08-22 15:23:28.000000000 +0200
@@ -8,7 +8,7 @@
  *
  */
 
-#include <asm/delay.h>
+#include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/reboot_fixups.h>
 
diff -urpN linux-2.6.17.9/arch/i386/kernel/timers/timer_pit.c linux-2.6.17.9.new7.1/arch/i386/kernel/timers/timer_pit.c
--- linux-2.6.17.9/arch/i386/kernel/timers/timer_pit.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/i386/kernel/timers/timer_pit.c	2006-08-22 15:23:28.000000000 +0200
@@ -8,7 +8,7 @@
 #include <linux/device.h>
 #include <linux/sysdev.h>
 #include <linux/timex.h>
-#include <asm/delay.h>
+#include <linux/delay.h>
 #include <asm/mpspec.h>
 #include <asm/timer.h>
 #include <asm/smp.h>
diff -urpN linux-2.6.17.9/arch/i386/lib/delay.c linux-2.6.17.9.new7.1/arch/i386/lib/delay.c
--- linux-2.6.17.9/arch/i386/lib/delay.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/i386/lib/delay.c	2006-08-22 15:23:28.000000000 +0200
@@ -14,8 +14,8 @@
 #include <linux/sched.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/delay.h>
 #include <asm/processor.h>
-#include <asm/delay.h>
 #include <asm/timer.h>
 
 #ifdef CONFIG_SMP
diff -urpN linux-2.6.17.9/arch/ia64/kernel/mca.c linux-2.6.17.9.new7.1/arch/ia64/kernel/mca.c
--- linux-2.6.17.9/arch/ia64/kernel/mca.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/ia64/kernel/mca.c	2006-08-22 15:23:28.000000000 +0200
@@ -70,8 +70,8 @@
 #include <linux/smp.h>
 #include <linux/workqueue.h>
 #include <linux/cpumask.h>
+#include <linux/delay.h>
 
-#include <asm/delay.h>
 #include <asm/kdebug.h>
 #include <asm/machvec.h>
 #include <asm/meminit.h>
diff -urpN linux-2.6.17.9/arch/ia64/kernel/smpboot.c linux-2.6.17.9.new7.1/arch/ia64/kernel/smpboot.c
--- linux-2.6.17.9/arch/ia64/kernel/smpboot.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/ia64/kernel/smpboot.c	2006-08-22 15:23:28.000000000 +0200
@@ -41,11 +41,11 @@
 #include <linux/efi.h>
 #include <linux/percpu.h>
 #include <linux/bitops.h>
+#include <linux/delay.h>
 
 #include <asm/atomic.h>
 #include <asm/cache.h>
 #include <asm/current.h>
-#include <asm/delay.h>
 #include <asm/ia32.h>
 #include <asm/io.h>
 #include <asm/irq.h>
diff -urpN linux-2.6.17.9/arch/mips/galileo-boards/ev96100/setup.c linux-2.6.17.9.new7.1/arch/mips/galileo-boards/ev96100/setup.c
--- linux-2.6.17.9/arch/mips/galileo-boards/ev96100/setup.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/mips/galileo-boards/ev96100/setup.c	2006-08-22 15:23:28.000000000 +0200
@@ -39,12 +39,12 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <linux/pci.h>
+#include <linux/delay.h>
 
 #include <asm/cpu.h>
 #include <asm/bootinfo.h>
 #include <asm/mipsregs.h>
 #include <asm/irq.h>
-#include <asm/delay.h>
 #include <asm/gt64120.h>
 #include <asm/galileo-boards/ev96100int.h>
 
diff -urpN linux-2.6.17.9/arch/mips/pci/ops-gt96100.c linux-2.6.17.9.new7.1/arch/mips/pci/ops-gt96100.c
--- linux-2.6.17.9/arch/mips/pci/ops-gt96100.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/mips/pci/ops-gt96100.c	2006-08-22 15:23:28.000000000 +0200
@@ -37,8 +37,8 @@
 #include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 
-#include <asm/delay.h>
 #include <asm/gt64120.h>
 #include <asm/galileo-boards/ev96100.h>
 
diff -urpN linux-2.6.17.9/arch/parisc/kernel/smp.c linux-2.6.17.9.new7.1/arch/parisc/kernel/smp.c
--- linux-2.6.17.9/arch/parisc/kernel/smp.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/parisc/kernel/smp.c	2006-08-22 15:23:28.000000000 +0200
@@ -34,11 +34,11 @@
 #include <linux/mm.h>
 #include <linux/delay.h>
 #include <linux/bitops.h>
+#include <linux/delay.h>
 
 #include <asm/system.h>
 #include <asm/atomic.h>
 #include <asm/current.h>
-#include <asm/delay.h>
 #include <asm/tlbflush.h>
 
 #include <asm/io.h>
diff -urpN linux-2.6.17.9/arch/powerpc/kernel/rtas.c linux-2.6.17.9.new7.1/arch/powerpc/kernel/rtas.c
--- linux-2.6.17.9/arch/powerpc/kernel/rtas.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/powerpc/kernel/rtas.c	2006-08-22 15:23:28.000000000 +0200
@@ -29,7 +29,6 @@
 #include <asm/page.h>
 #include <asm/param.h>
 #include <asm/system.h>
-#include <asm/delay.h>
 #include <asm/uaccess.h>
 #include <asm/lmb.h>
 #include <asm/udbg.h>
diff -urpN linux-2.6.17.9/arch/powerpc/kernel/rtas_flash.c linux-2.6.17.9.new7.1/arch/powerpc/kernel/rtas_flash.c
--- linux-2.6.17.9/arch/powerpc/kernel/rtas_flash.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/powerpc/kernel/rtas_flash.c	2006-08-22 15:23:28.000000000 +0200
@@ -16,7 +16,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
-#include <asm/delay.h>
+#include <linux/delay.h>
 #include <asm/uaccess.h>
 #include <asm/rtas.h>
 #include <asm/abs_addr.h>
diff -urpN linux-2.6.17.9/arch/ppc/platforms/mpc885ads_setup.c linux-2.6.17.9.new7.1/arch/ppc/platforms/mpc885ads_setup.c
--- linux-2.6.17.9/arch/ppc/platforms/mpc885ads_setup.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/ppc/platforms/mpc885ads_setup.c	2006-08-22 15:23:28.000000000 +0200
@@ -18,12 +18,12 @@
 #include <linux/string.h>
 #include <linux/ioport.h>
 #include <linux/device.h>
+#include <linux/delay.h>
 
 #include <linux/fs_enet_pd.h>
 #include <linux/fs_uart_pd.h>
 #include <linux/mii.h>
 
-#include <asm/delay.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
 #include <asm/page.h>
diff -urpN linux-2.6.17.9/arch/ppc/syslib/mpc52xx_pci.c linux-2.6.17.9.new7.1/arch/ppc/syslib/mpc52xx_pci.c
--- linux-2.6.17.9/arch/ppc/syslib/mpc52xx_pci.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/ppc/syslib/mpc52xx_pci.c	2006-08-22 15:23:28.000000000 +0200
@@ -12,13 +12,13 @@
  */
 
 #include <linux/config.h>
+#include <linux/delay.h>
 
 #include <asm/pci.h>
 
 #include <asm/mpc52xx.h>
 #include "mpc52xx_pci.h"
 
-#include <asm/delay.h>
 #include <asm/machdep.h>
 
 
diff -urpN linux-2.6.17.9/arch/ppc/syslib/mv64x60_dbg.c linux-2.6.17.9.new7.1/arch/ppc/syslib/mv64x60_dbg.c
--- linux-2.6.17.9/arch/ppc/syslib/mv64x60_dbg.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/ppc/syslib/mv64x60_dbg.c	2006-08-22 15:23:28.000000000 +0200
@@ -20,7 +20,7 @@
 
 #include <linux/config.h>
 #include <linux/irq.h>
-#include <asm/delay.h>
+#include <linux/delay.h>
 #include <asm/mv64x60.h>
 #include <asm/machdep.h>
 
diff -urpN linux-2.6.17.9/arch/ppc/syslib/ppc83xx_setup.c linux-2.6.17.9.new7.1/arch/ppc/syslib/ppc83xx_setup.c
--- linux-2.6.17.9/arch/ppc/syslib/ppc83xx_setup.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/ppc/syslib/ppc83xx_setup.c	2006-08-22 15:23:28.000000000 +0200
@@ -31,13 +31,13 @@
 #include <linux/tty.h>	/* for linux/serial_core.h */
 #include <linux/serial_core.h>
 #include <linux/serial_8250.h>
+#include <linux/delay.h>
 
 #include <asm/time.h>
 #include <asm/mpc83xx.h>
 #include <asm/mmu.h>
 #include <asm/ppc_sys.h>
 #include <asm/kgdb.h>
-#include <asm/delay.h>
 #include <asm/machdep.h>
 
 #include <syslib/ppc83xx_setup.h>
diff -urpN linux-2.6.17.9/arch/sparc/kernel/process.c linux-2.6.17.9.new7.1/arch/sparc/kernel/process.c
--- linux-2.6.17.9/arch/sparc/kernel/process.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/sparc/kernel/process.c	2006-08-22 15:23:28.000000000 +0200
@@ -29,6 +29,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 
 #include <asm/auxio.h>
 #include <asm/oplib.h>
@@ -37,7 +38,6 @@
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
-#include <asm/delay.h>
 #include <asm/processor.h>
 #include <asm/psr.h>
 #include <asm/elf.h>
diff -urpN linux-2.6.17.9/arch/sparc/kernel/sun4d_smp.c linux-2.6.17.9.new7.1/arch/sparc/kernel/sun4d_smp.c
--- linux-2.6.17.9/arch/sparc/kernel/sun4d_smp.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/sparc/kernel/sun4d_smp.c	2006-08-22 15:23:28.000000000 +0200
@@ -20,11 +20,11 @@
 #include <linux/mm.h>
 #include <linux/swap.h>
 #include <linux/profile.h>
+#include <linux/delay.h>
 
 #include <asm/ptrace.h>
 #include <asm/atomic.h>
 
-#include <asm/delay.h>
 #include <asm/irq.h>
 #include <asm/page.h>
 #include <asm/pgalloc.h>
diff -urpN linux-2.6.17.9/arch/sparc/kernel/sun4m_smp.c linux-2.6.17.9.new7.1/arch/sparc/kernel/sun4m_smp.c
--- linux-2.6.17.9/arch/sparc/kernel/sun4m_smp.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/sparc/kernel/sun4m_smp.c	2006-08-22 15:23:28.000000000 +0200
@@ -17,13 +17,13 @@
 #include <linux/mm.h>
 #include <linux/swap.h>
 #include <linux/profile.h>
+#include <linux/delay.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
 #include <asm/ptrace.h>
 #include <asm/atomic.h>
 
-#include <asm/delay.h>
 #include <asm/irq.h>
 #include <asm/page.h>
 #include <asm/pgalloc.h>
diff -urpN linux-2.6.17.9/arch/x86_64/kernel/i8259.c linux-2.6.17.9.new7.1/arch/x86_64/kernel/i8259.c
--- linux-2.6.17.9/arch/x86_64/kernel/i8259.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/x86_64/kernel/i8259.c	2006-08-22 15:23:28.000000000 +0200
@@ -13,6 +13,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
 #include <linux/bitops.h>
+#include <linux/delay.h>
 
 #include <asm/acpi.h>
 #include <asm/atomic.h>
@@ -20,7 +21,6 @@
 #include <asm/io.h>
 #include <asm/hw_irq.h>
 #include <asm/pgtable.h>
-#include <asm/delay.h>
 #include <asm/desc.h>
 #include <asm/apic.h>
 
diff -urpN linux-2.6.17.9/arch/x86_64/kernel/reboot.c linux-2.6.17.9.new7.1/arch/x86_64/kernel/reboot.c
--- linux-2.6.17.9/arch/x86_64/kernel/reboot.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/x86_64/kernel/reboot.c	2006-08-22 15:23:29.000000000 +0200
@@ -7,9 +7,9 @@
 #include <linux/ctype.h>
 #include <linux/string.h>
 #include <linux/pm.h>
+#include <linux/delay.h>
 #include <asm/io.h>
 #include <asm/kdebug.h>
-#include <asm/delay.h>
 #include <asm/hw_irq.h>
 #include <asm/system.h>
 #include <asm/pgtable.h>
diff -urpN linux-2.6.17.9/arch/x86_64/lib/delay.c linux-2.6.17.9.new7.1/arch/x86_64/lib/delay.c
--- linux-2.6.17.9/arch/x86_64/lib/delay.c	2006-08-18 18:26:24.000000000 +0200
+++ linux-2.6.17.9.new7.1/arch/x86_64/lib/delay.c	2006-08-22 15:23:29.000000000 +0200
@@ -11,7 +11,7 @@
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
-#include <asm/delay.h>
+#include <linux/delay.h>
 #include <asm/msr.h>
 
 #ifdef CONFIG_SMP

--Boundary-00=_1sw6EQXCazj7QJf--
