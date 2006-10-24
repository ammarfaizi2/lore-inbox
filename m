Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030429AbWJXQkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030429AbWJXQkn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 12:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030427AbWJXQkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 12:40:40 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:50141 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030424AbWJXQkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 12:40:11 -0400
Message-Id: <20061024163816.851732000@arndb.de>
References: <20061024163113.694643000@arndb.de>
User-Agent: quilt/0.45-1
Date: Tue, 24 Oct 2006 18:31:25 +0200
From: arnd@arndb.de
To: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, paulus@samba.org
Subject: [PATCH 12/16] cell: add temperature to SPU and CPU sysfs entries
Content-Disposition: inline; filename=cell-thermal-support-3.diff
Cc: Christian Krafft <krafft@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Krafft <krafft@de.ibm.com>

This patch adds a module that registers sysfs attributes to CPU and SPU
containing the temperature of the CBE.

They can be found under
/sys/devices/system/spu/cpuX/thermal/temperature[0|1]
/sys/devices/system/spu/spuX/thermal/temperature

The temperature is read from the on-chip temperature sensors.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/Kconfig
+++ linux-2.6/arch/powerpc/platforms/cell/Kconfig
@@ -20,4 +20,9 @@ config CBE_RAS
 	bool "RAS features for bare metal Cell BE"
 	default y
 
+config CBE_THERM
+	tristate "CBE thermal support"
+	default m
+	depends on CBE_RAS
+
 endmenu
Index: linux-2.6/arch/powerpc/platforms/cell/Makefile
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/Makefile
+++ linux-2.6/arch/powerpc/platforms/cell/Makefile
@@ -3,6 +3,8 @@ obj-$(CONFIG_PPC_CELL_NATIVE)		+= interr
 					   pmu.o
 obj-$(CONFIG_CBE_RAS)			+= ras.o
 
+obj-$(CONFIG_CBE_THERM)			+= cbe_thermal.o
+
 ifeq ($(CONFIG_SMP),y)
 obj-$(CONFIG_PPC_CELL_NATIVE)		+= smp.o
 endif
Index: linux-2.6/arch/powerpc/configs/cell_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/cell_defconfig
+++ linux-2.6/arch/powerpc/configs/cell_defconfig
@@ -149,6 +149,7 @@ CONFIG_MMIO_NVRAM=y
 CONFIG_SPU_FS=m
 CONFIG_SPU_BASE=y
 CONFIG_CBE_RAS=y
+CONFIG_CBE_THERM=m
 
 #
 # Kernel options
Index: linux-2.6/arch/powerpc/platforms/cell/cbe_thermal.c
===================================================================
--- /dev/null
+++ linux-2.6/arch/powerpc/platforms/cell/cbe_thermal.c
@@ -0,0 +1,225 @@
+/*
+ * thermal support for the cell processor
+ *
+ * (C) Copyright IBM Deutschland Entwicklung GmbH 2005
+ *
+ * Author: Christian Krafft <krafft@de.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/sysdev.h>
+#include <linux/kernel.h>
+#include <linux/cpu.h>
+#include <asm/spu.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+
+#include "cbe_regs.h"
+
+static struct cbe_pmd_regs __iomem *get_pmd_regs(struct sys_device *sysdev)
+{
+	struct spu *spu;
+
+	spu = container_of(sysdev, struct spu, sysdev);
+
+	return cbe_get_pmd_regs(spu->devnode);
+}
+
+/* returns the value for a given spu in a given register */
+static u8 spu_read_register_value(struct sys_device *sysdev, union spe_reg __iomem *reg)
+{
+	unsigned int *id;
+	union spe_reg value;
+	struct spu *spu;
+
+	/* getting the id from the reg attribute will not work on future device-tree layouts
+	 * in future we should store the id to the spu struct and use it here */
+	spu = container_of(sysdev, struct spu, sysdev);
+	id = (unsigned int *)get_property(spu->devnode, "reg", NULL);
+	value.val = in_be64(&reg->val);
+
+	return value.spe[*id];
+}
+
+static ssize_t spu_show_temp(struct sys_device *sysdev, char *buf)
+{
+	int value;
+	struct cbe_pmd_regs __iomem *pmd_regs;
+
+	pmd_regs = get_pmd_regs(sysdev);
+
+	value = spu_read_register_value(sysdev, &pmd_regs->ts_ctsr1);
+	/* clear all other bits */
+	value &= 0x3F;
+	/* temp is stored in steps of 2 degrees */
+	value *= 2;
+	/* base temp is 65 degrees */
+	value += 65;
+
+	return sprintf(buf, "%d\n", (int) value);
+}
+
+static ssize_t ppe_show_temp(struct sys_device *sysdev, char *buf, int pos)
+{
+	struct cbe_pmd_regs __iomem *pmd_regs;
+	u64 value;
+
+	pmd_regs = cbe_get_cpu_pmd_regs(sysdev->id);
+	value = in_be64(&pmd_regs->ts_ctsr2);
+
+	/* access the corresponding byte */
+	value >>= pos;
+	/* clear all other bits */
+	value &= 0x3F;
+	/* temp is stored in steps of 2 degrees */
+	value *= 2;
+	/* base temp is 65 degrees */
+	value += 65;
+
+	return sprintf(buf, "%d\n", (int) value);
+}
+
+
+/* shows the temperature of the DTS on the PPE,
+ * located near the linear thermal sensor */
+static ssize_t ppe_show_temp0(struct sys_device *sysdev, char *buf)
+{
+	return ppe_show_temp(sysdev, buf, 32);
+}
+
+/* shows the temperature of the second DTS on the PPE */
+static ssize_t ppe_show_temp1(struct sys_device *sysdev, char *buf)
+{
+	return ppe_show_temp(sysdev, buf, 0);
+}
+
+static struct sysdev_attribute attr_spu_temperature = {
+	.attr = {.name = "temperature", .mode = 0400 },
+	.show = spu_show_temp,
+};
+
+static struct attribute *spu_attributes[] = {
+	&attr_spu_temperature.attr,
+};
+
+static struct attribute_group spu_attribute_group = {
+	.name	= "thermal",
+	.attrs	= spu_attributes,
+};
+
+static struct sysdev_attribute attr_ppe_temperature0 = {
+	.attr = {.name = "temperature0", .mode = 0400 },
+	.show = ppe_show_temp0,
+};
+
+static struct sysdev_attribute attr_ppe_temperature1 = {
+	.attr = {.name = "temperature1", .mode = 0400 },
+	.show = ppe_show_temp1,
+};
+
+static struct attribute *ppe_attributes[] = {
+	&attr_ppe_temperature0.attr,
+	&attr_ppe_temperature1.attr,
+};
+
+static struct attribute_group ppe_attribute_group = {
+	.name	= "thermal",
+	.attrs	= ppe_attributes,
+};
+
+/*
+ * initialize throttling with default values
+ */
+static void __init init_default_values(void)
+{
+	int cpu;
+	struct cbe_pmd_regs __iomem *pmd_regs;
+	struct sys_device *sysdev;
+	union ppe_spe_reg tpr;
+	union spe_reg str1;
+	u64 str2;
+	union spe_reg cr1;
+	u64 cr2;
+
+	/* TPR defaults */
+	/* ppe
+	 *	1F - no full stop
+	 *	08 - dynamic throttling starts if over 80 degrees
+	 *	03 - dynamic throttling ceases if below 70 degrees */
+	tpr.ppe = 0x1F0803;
+	/* spe
+	 *	10 - full stopped when over 96 degrees
+	 *	08 - dynamic throttling starts if over 80 degrees
+	 *	03 - dynamic throttling ceases if below 70 degrees
+	 */
+	tpr.spe = 0x100803;
+
+	/* STR defaults */
+	/* str1
+	 *	10 - stop 16 of 32 cycles
+	 */
+	str1.val = 0x1010101010101010ull;
+	/* str2
+	 *	10 - stop 16 of 32 cycles
+	 */
+	str2 = 0x10;
+
+	/* CR defaults */
+	/* cr1
+	 *	4 - normal operation
+	 */
+	cr1.val = 0x0404040404040404ull;
+	/* cr2
+	 *	4 - normal operation
+	 */
+	cr2 = 0x04;
+
+	for_each_possible_cpu (cpu) {
+		pr_debug("processing cpu %d\n", cpu);
+		sysdev = get_cpu_sysdev(cpu);
+		pmd_regs = cbe_get_cpu_pmd_regs(sysdev->id);
+
+		out_be64(&pmd_regs->tm_str2, str2);
+		out_be64(&pmd_regs->tm_str1.val, str1.val);
+		out_be64(&pmd_regs->tm_tpr.val, tpr.val);
+		out_be64(&pmd_regs->tm_cr1.val, cr1.val);
+		out_be64(&pmd_regs->tm_cr2, cr2);
+	}
+}
+
+
+static int __init thermal_init(void)
+{
+	init_default_values();
+
+	spu_add_sysdev_attr_group(&spu_attribute_group);
+	cpu_add_sysdev_attr_group(&ppe_attribute_group);
+
+	return 0;
+}
+module_init(thermal_init);
+
+static void __exit thermal_exit(void)
+{
+	spu_remove_sysdev_attr_group(&spu_attribute_group);
+	cpu_remove_sysdev_attr_group(&ppe_attribute_group);
+}
+module_exit(thermal_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Christian Krafft <krafft@de.ibm.com>");
+

--

