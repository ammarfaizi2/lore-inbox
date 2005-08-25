Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbVHYC5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbVHYC5Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 22:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbVHYC5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 22:57:16 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:46585 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932504AbVHYC5P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 22:57:15 -0400
Date: Wed, 24 Aug 2005 19:57:11 -0700
From: Todd Poynor <tpoynor@mvista.com>
To: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: PowerOP Take 2 3/3: OMAP1 sysfs UI
Message-ID: <20050825025711.GD28662@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A PowerOP sysfs UI backend for OMAP1 platforms, adding sysfs attributes
and show/store functions that correspond to the platform power
parameters.  

An example usage on an OMAP1510 Innovator which does not have voltage
scaling and ignoring the DSP:

# echo -n 168-168-84 > /sys/powerop/new # DPLL 168MHz, ARM 168MHz, TC 84MHz
# echo -n 14 > /sys/powerop/168-168-84/dpllmult
# echo -n 0 > /sys/powerop/168-168-84/dplldiv
# echo -n 0 > /sys/powerop/168-168-84/armdiv
# echo -n 1 > /sys/powerop/168-168-84/tcdiv
# echo -n -1 > /sys/powerop/168-168-84/dspdiv
# echo -n -1 > /sys/powerop/168-168-84/lowpwr

# echo -n 60-60-60 > /sys/powerop/new # DPLL 60MHz, ARM 60MHz, TC 60MHz
# echo -n 5 > /sys/powerop/60-60-60/dpllmult
# echo -n 0 > /sys/powerop/60-60-60/dplldiv
# echo -n 0 > /sys/powerop/60-60-60/armdiv
# echo -n 0 > /sys/powerop/60-60-60/tcdiv
# echo -n -1 > /sys/powerop/60-60-60/dspdiv
# echo -n -1 > /sys/powerop/60-60-60/lowpwr

# echo -n 60-60-60 > /sys/powerop/active
# cat /sys/powerop/hw/dpllmult
5

The lower-powered operating point consumes about .07A less power using
my .config (it should be noted this is not a proper low-power evaluation
platform).


Index: linux-2.6.13-rc4/arch/arm/mach-omap1/Kconfig
===================================================================
--- linux-2.6.13-rc4.orig/arch/arm/mach-omap1/Kconfig
+++ linux-2.6.13-rc4/arch/arm/mach-omap1/Kconfig
@@ -155,3 +155,5 @@ source "arch/arm/plat-omap/dsp/Kconfig"
 config	POWEROP
 	bool "PowerOP Platform Core Power Management for OMAP1"
 	help
+
+source "drivers/powerop/Kconfig"
Index: linux-2.6.13-rc4/arch/arm/mach-omap1/powerop.c
===================================================================
--- linux-2.6.13-rc4.orig/arch/arm/mach-omap1/powerop.c
+++ linux-2.6.13-rc4/arch/arm/mach-omap1/powerop.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/powerop_sysfs.h>
 
 #include <asm/arch/powerop.h>
 #include <asm/hardware.h>
@@ -144,13 +145,141 @@ powerop_set_point(struct powerop_point *
 EXPORT_SYMBOL_GPL(powerop_get_point);
 EXPORT_SYMBOL_GPL(powerop_set_point);
 
+#ifdef CONFIG_POWEROP_SYSFS
+
+ssize_t lowpwr_show(struct powerop_point *op, char * buf)
+{
+	return sprintf(buf,"%d\n",op->lowpwr);
+}
+
+ssize_t lowpwr_store(struct powerop_point *op, const char * buf, size_t count)
+{
+	int error;
+
+	if ((error = sscanf(buf, "%d", &op->lowpwr)) == 1)
+		return count;
+	return error;
+}
+
+powerop_param_attr(lowpwr);
+
+ssize_t dpllmult_show(struct powerop_point *op, char * buf)
+{
+	return sprintf(buf,"%d\n",op->dpllmult);
+}
+
+ssize_t dpllmult_store(struct powerop_point *op, const char * buf, size_t count)
+{
+	int error;
+
+	if ((error = sscanf(buf, "%d", &op->dpllmult)) == 1)
+		return count;
+	return error;
+}
+
+powerop_param_attr(dpllmult);
+
+ssize_t dplldiv_show(struct powerop_point *op, char * buf)
+{
+	return sprintf(buf,"%d\n",op->dplldiv);
+}
+
+ssize_t dplldiv_store(struct powerop_point *op, const char * buf, size_t count)
+{
+	int error;
+
+	if ((error = sscanf(buf, "%d", &op->dplldiv)) == 1)
+		return count;
+	return error;
+}
+
+powerop_param_attr(dplldiv);
+
+ssize_t armdiv_show(struct powerop_point *op, char * buf)
+{
+	return sprintf(buf,"%d\n",op->armdiv);
+}
+
+ssize_t armdiv_store(struct powerop_point *op, const char * buf, size_t count)
+{
+	int error;
+
+	if ((error = sscanf(buf, "%d", &op->armdiv)) == 1)
+		return count;
+	return error;
+}
+
+powerop_param_attr(armdiv);
+
+ssize_t dspdiv_show(struct powerop_point *op, char * buf)
+{
+	return sprintf(buf,"%d\n",op->dspdiv);
+}
+
+ssize_t dspdiv_store(struct powerop_point *op, const char * buf, size_t count)
+{
+	int error;
+
+	if ((error = sscanf(buf, "%d", &op->dspdiv)) == 1)
+		return count;
+	return error;
+}
+
+powerop_param_attr(dspdiv);
+
+ssize_t tcdiv_show(struct powerop_point *op, char * buf)
+{
+	return sprintf(buf,"%d\n",op->tcdiv);
+}
+
+ssize_t tcdiv_store(struct powerop_point *op, const char * buf, size_t count)
+{
+	int error;
+
+	if ((error = sscanf(buf, "%d", &op->tcdiv)) == 1)
+		return count;
+	return error;
+}
+
+powerop_param_attr(tcdiv);
+
+static struct attribute *powerop_sysfs_param_attrs[] = {
+	&lowpwr_attr.attr,
+	&dpllmult_attr.attr,
+	&dplldiv_attr.attr,
+	&armdiv_attr.attr,
+	&dspdiv_attr.attr,
+	&tcdiv_attr.attr,
+	NULL,
+};
+
+static void powerop_omap1_sysfs_init()
+{
+	powerop_sysfs_register(powerop_sysfs_param_attrs);
+}
+
+static void powerop_omap1_sysfs_exit()
+{
+	powerop_sysfs_unregister(powerop_sysfs_param_attrs);
+}
+#else /* CONFIG_POWEROP_SYSFS */
+static void powerop_omap1_sysfs_init()
+{
+}
+static void powerop_omap1_sysfs_exit()
+{
+}
+#endif /* CONFIG_POWEROP_SYSFS */
+
 static int __init powerop_init(void)
 {
+	powerop_omap1_sysfs_init();
 	return 0;
 }
 
 static void __exit powerop_exit(void)
 {
+	powerop_omap1_sysfs_exit();
 }
 
 module_init(powerop_init);
