Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWI2WXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWI2WXN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 18:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWI2WXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 18:23:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:5863 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750827AbWI2WXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 18:23:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=ESjDeZfVf8sskYt2UHFkHt+nOJloPR/ISeQscWYk0dzCQr5IKmUpAqKpjwFaCiFit+3+SC2cepv0VEkexJohewmz5Q/0vu9tJPYYkVUUJBrw48UvvSncWZXtKkQhWBr0Oj23dxOtETOpuQ1Ucn3J/aMDUW72tTG6qfH5jUO5jik=
Date: Sat, 30 Sep 2006 02:24:35 +0400
From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-pm@lists.osdl.org, matt@nomadgs.com, amit.kucheria@nokia.com,
       igor.stoppa@nokia.com, ext-Tuukka.Tikkanen@nokia.com
Subject: [RFC] OMAP1 PM Core, PM Core  Implementation 2/2
Message-Id: <20060930022435.b2344b5f.eugeny.mints@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.15; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OMAP1 PM Core reference implementation

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f9362ee..05cd7f1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -745,6 +745,21 @@ config CPU_FREQ_INTEGRATOR
 
 endmenu
 
+if (ARCH_OMAP)
+
+menu "PM Core"
+
+config OMAP1_PM_CORE
+	tristate "OMAP1 PM Core"
+	depends POWEROP
+	help
+	This enables OMAP1 PM Core to control platform clocks/power via
+	PowerOP interface
+
+endmenu
+
+endif
+
 endif
 
 menu "Floating point emulation"
diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index 7165f74..de61ab1 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -38,3 +38,6 @@ led-$(CONFIG_MACH_OMAP_PERSEUS2)	+= leds
 led-$(CONFIG_MACH_OMAP_OSK)		+= leds-osk.o
 obj-$(CONFIG_LEDS)			+= $(led-y)
 
+#PM Core
+obj-$(CONFIG_OMAP1_PM_CORE)		+=pm_core.o
+
diff --git a/arch/arm/mach-omap1/pm_core.c b/arch/arm/mach-omap1/pm_core.c
new file mode 100644
index 0000000..d144928
--- /dev/null
+++ b/arch/arm/mach-omap1/pm_core.c
@@ -0,0 +1,530 @@
+/*
+ * arch/arm/mach-omap1/pm_core.c
+ *
+ * PM Core implementation by Eugeny S. Mints <eugeny.mints@gmail.com>
+ *
+ * Copyright (C) 2006, Nomad Global Solutions, Inc.
+ *
+ * Based on code by Todd Poynor, Matthew Locke, Dmitry Chigirev, and 
+ * Bishop Brock.
+ *
+ * Copyright (C) 2002, 2004 MontaVista Software <source@mvista.com>.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ */
+#include <linux/config.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/kmod.h>
+#include <linux/module.h>
+#include <linux/stat.h>
+#include <linux/string.h>
+#include <linux/device.h>
+#include <linux/pm.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/powerop.h>
+#include <linux/powerop_sysfs.h>
+#include <linux/pm_core.h>
+#include <linux/plat_pwr_param.h>
+
+#include <asm/hardirq.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/processor.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/mach-types.h>
+#include <asm/arch/hardware.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/board.h>
+#include <asm/arch/mux.h>
+#include <asm/arch/pm.h>
+#include <asm/arch/system.h>
+#include <asm/mach/time.h>
+#include <asm/arch/pm_core.h>
+
+#if defined(CONFIG_MACH_OMAP_H2)
+#define V_CORE_HIGH		1500
+#define V_CORE_LOW		1300
+#define DVS_SUPPORT
+#elif defined(CONFIG_MACH_OMAP_H3)
+#define V_CORE_HIGH		1300
+#define V_CORE_LOW		1050
+#define DVS_SUPPORT
+#else
+#define V_CORE_HIGH		1500
+#endif
+
+#define ULPD_MIN_MAX_REG (1 << 11)
+#define ULPD_DVS_ENABLE  (1 << 10)
+#define ULPD_LOW_PWR_REQ (1 << 1)
+#define LOW_POWER (ULPD_MIN_MAX_REG | ULPD_DVS_ENABLE | ULPD_LOW_PWR_REQ | \
+		   ULPD_LOW_PWR_EN)
+
+/* 
+ * REVISIT: this function is implemented here temporary.
+ * Once Clock/Voltage Framework is in  place this routine
+ * implementation will be hided in the framework (along with 
+ * struct voltage)
+ */ 
+struct voltage {
+	int v; /* mV */
+};
+static struct voltage vhandle;
+
+static unsigned int
+vtg_get_voltage(struct voltage *handle)
+{
+	unsigned int v;
+
+#ifdef DVS_SUPPORT
+	if (omap_readw(ULPD_POWER_CTRL) & (1 << 1))
+		v = V_CORE_LOW;
+	else
+#endif
+		v = V_CORE_HIGH;
+
+	return v;
+}
+
+/* 
+ * auxiliary routines to get/set rate of various clocks 
+ * RETURN: rates in KHz
+ */
+static long 
+get_clk_rate(const char *clk_name)
+{
+	struct clk *clk;
+	long        ret;
+
+	clk = clk_get(0, clk_name);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ret = clk_get_rate(clk);
+	clk_put(clk);
+
+	return ret/1000;
+}
+
+static long 
+set_clk_rate(const char *clk_name, unsigned int rate)
+{
+	struct clk *clk;
+	long        ret;
+
+	clk = clk_get(0, clk_name);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ret = clk_set_rate(clk, rate);
+	clk_put(clk);
+
+	return ret;
+}
+
+/* 
+ * auxiliary routines to get/set rate voltages 
+ * RETURN: mV
+ */
+static long 
+get_vtg(const char *vdomain)
+{
+	long ret = 0;
+#ifdef VOLTAGE_FRAMEWORK
+	struct voltage *v;
+
+	v = vtg_get(0, vdomain);
+	if (IS_ERR(v))
+		return PTR_ERR(v);
+
+	ret = vtg_get_voltage(v);
+	vtg_put(v);
+#else
+	ret = vtg_get_voltage(&vhandle);
+#endif /* VOLTAGE_FRAMEWORK */	
+	return ret;
+}
+
+static long 
+set_vtg(const char *vdomain, int val)
+{
+	long ret = 0;
+#ifdef VOLTAGE_FRAMEWORK
+	struct voltage *v;
+
+	v = vtg_get(0, vdomain);
+	if (IS_ERR(v))
+		return PTR_ERR(v);
+
+	ret = vtg_request(v, val);
+	vtg_put(v);
+#endif /* VOLTAGE_FRAMEWORK */
+	return ret;
+}
+
+/* FIXME: verification is incomplete */
+static int
+omap_pm_core_verify_opt(struct pm_core_point *opt)
+{
+	/* 
+	 * Let's do some upfront error checking. If we fail any of these, 
+	 * then the whole operating point is suspect and therefore invalid.
+	 *
+	 * Vrification includes but is not limited to checking that passed
+	 * parameters are withing ranges.
+	 *
+	 * FIXME: who should be responsible for checking whether the values
+	 * are consistent in regard to clock modes (fully sycn/scalable sync/
+	 * etc)?
+	 */
+	if (opt == NULL)
+		return -EINVAL;
+
+#ifdef DVS_SUPPORT
+	if ((opt->cpu_vltg != -1) && ((opt->cpu_vltg != V_CORE_LOW) && 
+	    (opt->cpu_vltg != V_CORE_HIGH))) {
+		printk(KERN_WARNING "%s: Core voltage can not be other"
+		       "than %dmV or %dmV\n"
+		       "Core voltage %d out of range!", __FUNCTION__, 
+			V_CORE_LOW, V_CORE_HIGH, opt->cpu_vltg);
+		return -EINVAL;
+	}
+#endif
+
+	/* TODO: implement all necessary checking */
+
+	return 0;
+}
+
+#define PWR_PARAM_MAX_LENGTH	20
+/* REVISIT: with the current approach which allows only subset of platform 
+ * power parameters to be explicitly listed at an operating point creation the
+ * following aspect needs attention. PM Core puts '-1' to all power parameters
+ * which are not listed explicitly. omap_pm_core_verify_opt() replaces '-1'
+ * with values inherited from current operating point and resulting full set of  * power parameters may appear
+ * to be invalid (for example ivalid combination of dsp and dspmmu frequencies)
+ * The are two options. First one is to leave it upto to an upper layer to 
+ * provide correct resulting operating point regadless of how many power 
+ * parameters are listed explicitly. The other option is to provide an
+ * interface to a caller which in case of resulting point after replacement of 
+ * all implicit parameters occurs to be invalid returns a valid operating point
+ * with the original value for explicitly set power parameters but with
+ * implicit parameters set to complement of explicit parameter upto a valid
+ * operating point instead of just inherited implicit parameters from the 
+ * current operatin point. Of course just if such combination exists.
+ *
+ * NOTE: implicit changes of various power parameters underneath PM Core 
+ * layer like set_clk_rate() for "mpu" clock does will be prohibited and
+ * removed in the future since otherwise PM Core will validate one operating
+ * point while system will actually switch to completely different one
+ */
+static void *
+omap_pm_create_point(struct powerop_pwr_param *pwr_params, int size)
+{
+	struct pm_core_point *opt;
+	int i = 0;
+	int err;
+
+	opt = kmalloc(sizeof(struct pm_core_point), GFP_KERNEL);
+	if (opt == NULL)
+		return NULL;
+	/* 
+	 * PM Core puts '-1' for all power parameters which are not listed
+	 * explicitly
+	 */
+	OMAP_PM_CORE_INIT_OPT(opt);
+
+	for (i = 0; i < size; i++)
+	{
+		struct platform_pwr_param *p = 
+				to_platform_pwr_param(pwr_params[i].attr);
+		p->store(opt, pwr_params[i].value); 
+	}
+
+	err = omap_pm_core_verify_opt(opt);
+	if (err != 0)
+		goto out;
+
+	return (void *)opt;
+out:
+	kfree(opt);
+	return NULL;
+}
+
+/* FIXME: synchronization aspect may need attention */
+/*
+ * FIXME: notifiers  aspect is not highlighted here. There are 3 options:
+ *  1) let an upper layer to handle notifiers
+ *  2) handle notifiers at PM Core layer
+ *  3) handle notifiers at clock(voltage) framework layer
+ */ 
+static int
+omap_pm_core_set_opt(void *md_opt)
+{
+	int ret = 0;
+	struct pm_core_point *new = (struct pm_core_point *)md_opt;
+
+	ret = omap_pm_core_verify_opt(new);
+	if (ret != 0)
+		return ret;
+
+#define PM_CORE_USE_MPU_CLOCK
+#ifdef PM_CORE_USE_MPU_CLOCK
+	/* 
+	 * OMAP1 clock framework exports "smart" virtual clock "mpu". 
+	 * "mpu" clock hides and hardcodes interdependencies between
+	 * ck_dpll1, arm_ck, dsp_ck, dspmmu_ck, tc_ck via the
+	 * rate_table[].
+	 * "mpu" clock rate needs to be set to desired cpu clock rate 
+	 *
+	 * current implementation of "mpu" clock allows to switch between
+	 * only those cpu frequencies defined in the rate_table[] which 
+	 * have the same ck_ref and dpll_ck1 rates.
+	 *
+	 * since CONFIG_OMAP_ARM_192MHZ provides the widest range of 
+	 * available frequencies which meet the above constraints we 
+	 * use this config for pm_core reference code    
+	 */
+
+	ret = set_clk_rate("mpu", new->cpu * 1000);
+	if (ret != 0)
+		return ret;
+#else
+	/* 
+	 * go through op parameters and set as requested if changed 
+	 * if at least one failed then restore cur_opt
+	 *
+	 * NOTE: auxiliary access to hw registers may occur here for
+	 * example for proper handling of coupled simultaneous clock and 
+	 * voltage changes  
+	 *
+	 * FIXME: not all parameters are implemented so far
+	 * REVISIT: '-1' option is not implemented yet
+	 */
+	if (cur_opt.cpu_vltg != new->cpu_vltg)
+		if ((ret = set_vtg("v1", new->cpu_vltg)) != 0)
+			goto failed;
+
+	if (cur_opt.dpll != new->dpll)
+		if ((ret = set_clk_rate("ck_dpll1", new->dpll)) != 0)
+			goto failed;
+
+	if (cur_opt.cpu != new->cpu)
+		if ((ret = set_clk_rate("arm_ck", new->cpu)) != 0)
+			goto failed;
+
+	if (cur_opt.tc != new->tc)
+		if ((ret = set_clk_rate("tc_ck", new->tc)) != 0)
+			goto failed;
+
+	if (cur_opt.dsp != new->dsp)
+		if ((ret = set_clk_rate("dsp_ck", new->dsp)) != 0)
+			goto failed;
+
+	if (cur_opt.dspmmu != new->dspmmu)
+		if ((ret = set_clk_rate("dspmmu_ck", new->dspmmu)) != 0)
+			goto failed;
+#endif /* PM_CORE_USE_MPU_CLOCK */ 
+	return ret;
+}
+
+/* 
+ * Fully determine the current machine-dependent operating point, and fill in 
+ * a structure presented by a caller.
+ *
+ * RETURN: -ENOENT on error; in error case one should not rely on any 
+ * power parameter value returned
+ */
+static int
+omap_pm_core_access_opt(void *md_opt, struct powerop_pwr_param *pwr_params,
+			int size, int op)
+{
+	struct pm_core_point *opt = (struct pm_core_point *)md_opt;
+	struct platform_pwr_param *p;
+	int i = 0;
+
+	if ((pwr_params == NULL) && (size != 0))
+		return -EINVAL;
+
+	if (op == POWEROP_GET_PARAMS) {
+		for (i = 0; i < size; i++) {
+			p = to_platform_pwr_param(pwr_params[i].attr);
+			if (p->show(opt, &pwr_params[i].value))
+				return -EIO;
+		} 
+	} else {
+		for (i = 0; i < size; i++) {
+			p = to_platform_pwr_param(pwr_params[i].attr);					p->store(opt, pwr_params[i].value);
+		}
+	} 
+
+	return 0;
+}
+
+static struct powerop_driver omap_pm_core_driver = {
+	.owner                  = THIS_MODULE,
+	.name                   = "omap1 pm core driver",
+	.create_point           = omap_pm_create_point,
+	.access_point           = omap_pm_core_access_opt,
+	.set_point              = omap_pm_core_set_opt, 
+};
+
+static int cpu_vltg_show(void *md_opt, int *value)
+{
+	int rc = 0;
+	if (md_opt == NULL) {
+		if ((*value = get_vtg("v1")) <= 0)
+			return -EIO;
+	}
+	else {
+		struct pm_core_point *opt = (struct pm_core_point *)md_opt;
+		*value = opt->cpu_vltg;
+	}
+
+	return rc;
+}
+
+/* FIXME: in all *_store routines we can check that a value is within range */
+static void cpu_vltg_store(void *md_opt, int value)
+{
+	struct pm_core_point *opt = (struct pm_core_point *)md_opt;
+	opt->cpu_vltg = value;
+}
+
+static int dpll_show(void *md_opt, int *value)
+{
+	int rc = 0;
+	if (md_opt == NULL) {
+		if ((*value = get_clk_rate("ck_dpll1")) <= 0)
+			return -EIO;
+	}
+	else {
+		struct pm_core_point *opt = (struct pm_core_point *)md_opt;
+		*value = opt->dpll;
+	}
+
+	return rc;
+}
+
+static void dpll_store(void *md_opt, int value)
+{
+	struct pm_core_point *opt = (struct pm_core_point *)md_opt;
+	opt->dpll = value;
+}
+
+static int cpu_show(void *md_opt, int *value)
+{
+	int rc = 0;
+	if (md_opt == NULL) {
+		if ((*value = get_clk_rate("arm_ck")) <= 0)
+			return -EIO;
+	}
+	else {
+		struct pm_core_point *opt = (struct pm_core_point *)md_opt;
+		*value = opt->cpu;
+	}
+
+	return rc;
+}
+
+static void cpu_store(void *md_opt, int value)
+{
+	struct pm_core_point *opt = (struct pm_core_point *)md_opt;
+	opt->cpu = value;
+}
+
+static int tc_show(void *md_opt, int *value)
+{
+	int rc = 0;
+	if (md_opt == NULL) {
+		if ((*value = get_clk_rate("tc_ck")) <= 0)
+			return -EIO;
+	}
+	else {
+		struct pm_core_point *opt = (struct pm_core_point *)md_opt;
+		*value = opt->tc;
+	}
+
+	return rc;
+}
+
+static void tc_store(void *md_opt, int value)
+{
+	struct pm_core_point *opt = (struct pm_core_point *)md_opt;
+	opt->tc = value;
+}
+
+static int per_show(void *md_opt, int *value)
+{
+	int rc = 0;
+	if (md_opt == NULL) {
+		if ((*value = get_clk_rate("armper_ck")) <= 0)
+			return -EIO;
+	}
+	else {
+		struct pm_core_point *opt = (struct pm_core_point *)md_opt;
+		*value = opt->per;
+	}
+
+	return rc;
+}
+
+static void per_store(void *md_opt, int value)
+{
+	struct pm_core_point *opt = (struct pm_core_point *)md_opt;
+	opt->per = value;
+}
+
+platform_pwr_param_init(cpu_vltg);
+platform_pwr_param_init(dpll);
+platform_pwr_param_init(cpu);
+platform_pwr_param_init(tc);
+platform_pwr_param_init(per);
+
+static struct attribute *platform_pwr_params[] = {
+	&cpu_vltg_attr.attr,
+	&dpll_attr.attr,
+	&cpu_attr.attr,
+	&tc_attr.attr,
+	&per_attr.attr,
+	NULL,
+};
+
+int 
+platform_pwr_param_get_names(struct attribute ***platform_pwr_params_names)
+{
+	*platform_pwr_params_names = platform_pwr_params;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(platform_pwr_param_get_names);
+
+int __init
+omap_pm_core_init(void)
+{
+	int rc;
+
+	rc = powerop_driver_register(&omap_pm_core_driver);
+	if (rc != 0)
+		return rc;
+
+	return powerop_sysfs_register_pwr_params(platform_pwr_params);
+}
+
+postcore_initcall(omap_pm_core_init);
+
diff --git a/include/asm-arm/arch-omap/pm_core.h b/include/asm-arm/arch-omap/pm_core.h
new file mode 100644
index 0000000..fd406d8
--- /dev/null
+++ b/include/asm-arm/arch-omap/pm_core.h
@@ -0,0 +1,48 @@
+/*
+ * Set of power parameters supported for OMAP1
+ *
+ * Based on DPM OMAP code by Matthew Locke, Dmitry Chigirev, Vladimir
+ * Barinov, and Todd Poynor.
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifndef __ASM_ARCH_OMAP_PM_CORE_H__
+#define __ASM_ARCH_OMAP_PM_CORE_H__
+
+#define PM_CORE_PRE_NOTIFICATION    1
+#define PM_CORE_POST_NOTIFICATION   2
+/* 
+ * Instances of this structure define operating points
+ *
+ * -1 for any following fields indicates no change from current op 
+ */
+
+struct pm_core_point {
+	int cpu_vltg; /* voltage in mV */
+	int dpll;     /* in KHz */
+	int cpu;      /* CPU frequency in KHz */
+	int tc;       /* in KHz */
+	int per;      /* in KHz */
+	int dsp;      /* in KHz */
+	int dspmmu;   /* in KHz */
+	int lcd;      /* in KHz */
+};
+
+#define OMAP_PM_CORE_INIT_OPT(point)    \
+	do {                            \
+		(point)->cpu_vltg = -1; \
+		(point)->dpll = -1;     \
+		(point)->cpu = -1;      \
+		(point)->tc = -1;       \
+		(point)->per = -1;      \
+		(point)->dsp = -1;      \
+		(point)->dspmmu = -1;   \
+		(point)->lcd = -1;      \
+	} while (0)   
+
+#endif /* __ASM_ARCH_OMAP_PM_CORE_H__ */
+
