Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbTJUC72 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 22:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbTJUC71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 22:59:27 -0400
Received: from fmr05.intel.com ([134.134.136.6]:16819 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262788AbTJUC4w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 22:56:52 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C3977E.F5DFAB08"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: [PATCH] 3/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Date: Mon, 20 Oct 2003 19:56:44 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB60077914@scsmsx403.sc.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 3/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Thread-Index: AcOXfvSGeoZq95RFQxuM4M5LuLIFCQ==
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <cpufreq@www.linux.org.uk>, <linux-kernel@vger.kernel.org>,
       "linux-acpi" <linux-acpi@intel.com>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Dominik Brodowski" <linux@brodo.de>
X-OriginalArrivalTime: 21 Oct 2003 02:56:44.0668 (UTC) FILETIME=[F613EBC0:01C3977E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C3977E.F5DFAB08
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Patch 3/3: New dynamic cpufreq driver (called=20
DemandBasedSwitch driver), which periodically monitors CPU=20
usage and changes the CPU frequency based on the demand.

diffstat dbs3.patch=20
drivers/cpufreq/Kconfig       |   25 ++++
drivers/cpufreq/Makefile      |    1=20
drivers/cpufreq/cpufreq_dbs.c |  214
++++++++++++++++++++++++++++++++++++++++++
include/linux/cpufreq.h       |    3=20
4 files changed, 243 insertions(+)

diff -purN linux-2.6.0-test7/drivers/cpufreq/cpufreq_dbs.c
linux-2.6.0-test7-dbs/drivers/cpufreq/cpufreq_dbs.c
--- linux-2.6.0-test7/drivers/cpufreq/cpufreq_dbs.c	1969-12-31
16:00:00.000000000 -0800
+++ linux-2.6.0-test7-dbs/drivers/cpufreq/cpufreq_dbs.c	2003-10-20
17:38:05.000000000 -0700
@@ -0,0 +1,214 @@
+/*
+ *  drivers/cpufreq/cpufreq_dbs.c
+ *
+ *  Copyright (C)  2001 Russell King
+ *            (C)  2002 - 2003 Dominik Brodowski <linux@brodo.de>
+ *            (C)  2003 Venkatesh Pallipadi
<venkatesh.pallipadi@intel.com>.
+ *                      Jun Nakajima <jun.nakajima@intel.com>
+ *
+ * $Id:$
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/smp.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/ctype.h>
+#include <linux/cpufreq.h>
+#include <linux/sysctl.h>
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <linux/sysfs.h>
+#include <linux/sched.h>
+#include <linux/kmod.h>
+#include <linux/workqueue.h>
+#include <linux/jiffies.h>
+#include <linux/config.h>
+#include <linux/kernel_stat.h>
+
+#define DBS_RATE		(HZ/4)	/* timer rate is 250ms */
+#define LOW_LATENCY_FREQUENCY_CHANGE_LIMIT 	100 /* in uS */
+
+static void do_dbs_timer(void *data);
+
+typedef struct {
+	struct cpufreq_policy 	*cur_policy;
+	unsigned int 		prev_cpu_idle;
+	unsigned int 		enable;
+} ____cacheline_aligned cpu_dbs_info_t;
+static cpu_dbs_info_t cpu_dbs_info[NR_CPUS];
+
+static unsigned int dbs_enable; 	/* number of CPUs using DBS
policy */
+
+static DECLARE_MUTEX 	(dbs_sem);
+static DECLARE_WORK	(dbs_work, do_dbs_timer, NULL);
+
+static void dbs_check_cpu(int cpu)
+{
+	unsigned int idle_ticks;
+
+	if (!cpu_dbs_info[cpu].enable)
+		return;
+
+	idle_ticks =3D kstat_cpu(cpu).cpustat.idle -=20
+		cpu_dbs_info[cpu].prev_cpu_idle;
+	cpu_dbs_info[cpu].prev_cpu_idle =3D kstat_cpu(cpu).cpustat.idle;
+
+	/*=20
+	 * The current safe range is 20% to 80%=20
+	 * - If current idle time is less than 20%, then we try to=20
+	 * increase frequency
+	 * - If current idle time is more than 80%, then we try to
+	 * decrease frequency
+	 */
+	if (idle_ticks < (DBS_RATE / 5))
+		cpufreq_driver_target(cpu_dbs_info[cpu].cur_policy,
+			cpu_dbs_info[cpu].cur_policy->cur + 1,=20
+			CPUFREQ_RELATION_L);
+	else if (idle_ticks > (4 * DBS_RATE / 5))
+		cpufreq_driver_target(cpu_dbs_info[cpu].cur_policy,
+			cpu_dbs_info[cpu].cur_policy->cur - 1,=20
+			CPUFREQ_RELATION_H);
+}
+
+static void do_dbs_timer(void *data)
+{=20
+	int i;
+	down(&dbs_sem);
+	for (i =3D 0; i < NR_CPUS; i++)
+		if (cpu_online(i))
+			dbs_check_cpu(i);
+	schedule_delayed_work(&dbs_work, DBS_RATE);=20
+	up(&dbs_sem);
+}=20
+
+static inline int dbs_timer_init(void)
+{
+	schedule_work(&dbs_work);
+	return 0;
+}
+
+static inline void dbs_timer_exit(void)
+{
+	cancel_delayed_work(&dbs_work);
+	return;
+}
+
+/************************** sysfs interface ************************/
+static ssize_t show_speed (struct cpufreq_policy *policy, char *buf)
+{
+	return sprintf (buf, "%u\n", policy->cur);
+}
+
+static struct freq_attr freq_attr_scaling_getspeed =3D {
+	.attr =3D { .name =3D "scaling_getspeed", .mode =3D 0444 },
+	.show =3D show_speed,
+};
+
+static int cpufreq_governor_dbs(struct cpufreq_policy *policy,
+				   unsigned int event)
+{
+	unsigned int cpu =3D policy->cpu;
+
+	switch (event) {
+	case CPUFREQ_GOV_START:
+		if ((!cpu_online(cpu)) || (!try_module_get(THIS_MODULE))
||
+		    !policy->cur)
+			return -EINVAL;
+		if (policy->cpuinfo.transition_latency >=20
+				LOW_LATENCY_FREQUENCY_CHANGE_LIMIT)
+			return -EINVAL;
+		if (cpu_dbs_info[cpu].enable) /* Already enabled */
+			break;
+
+		printk(KERN_DEBUG "DBS START: cpu %d, max %d, min %d,
cur %d\n",
+				policy->cpu, policy->max,
+				policy->min, policy->cur);
+		down(&dbs_sem);
+		cpu_dbs_info[cpu].cur_policy =3D policy;
+		cpu_dbs_info[cpu].prev_cpu_idle =3D
kstat_cpu(cpu).cpustat.idle;
+		cpu_dbs_info[cpu].enable =3D 1;
+		sysfs_create_file(&policy->kobj,=20
+				&freq_attr_scaling_getspeed.attr);
+		dbs_enable++;
+		/*
+		 * Start the timerschedule work, when this governer
+		 * is used for first time
+		 */
+		if (dbs_enable =3D=3D 1)=20
+			dbs_timer_init();
+	=09
+		up(&dbs_sem);
+		break;
+
+	case CPUFREQ_GOV_STOP:
+		printk(KERN_DEBUG "DBS STOP: cpu %d, max %d, min %d, cur
%d\n",
+				policy->cpu, policy->max,
+				policy->min, policy->cur);
+		down(&dbs_sem);
+		sysfs_remove_file(&policy->kobj,=20
+				&freq_attr_scaling_getspeed.attr);
+		cpu_dbs_info[cpu].enable =3D 0;
+		dbs_enable--;
+		/*
+		 * Start the timerschedule work, when this governer
+		 * is used for first time
+		 */
+		if (dbs_enable =3D=3D 0)=20
+			dbs_timer_exit();
+	=09
+		up(&dbs_sem);
+		module_put(THIS_MODULE);
+		break;
+
+	case CPUFREQ_GOV_LIMITS:
+		printk(KERN_DEBUG "DBS LIMIT: cpu %d, max %d, min %d,
cur %d\n",
+				policy->cpu, policy->max,
+				policy->min, policy->cur);
+		down(&dbs_sem);
+		if (policy->max < cpu_dbs_info[cpu].cur_policy->cur)
+
__cpufreq_driver_target(cpu_dbs_info[cpu].cur_policy,
+				       	policy->max,
CPUFREQ_RELATION_H);
+		else if (policy->min >
cpu_dbs_info[cpu].cur_policy->cur)
+
__cpufreq_driver_target(cpu_dbs_info[cpu].cur_policy,
+				       	policy->min,
CPUFREQ_RELATION_L);
+		up(&dbs_sem);
+		break;
+	}
+	return 0;
+}
+
+struct cpufreq_governor cpufreq_gov_dbs =3D {
+	.name		=3D "demandbased",
+	.governor	=3D cpufreq_governor_dbs,
+	.owner		=3D THIS_MODULE,
+};
+EXPORT_SYMBOL(cpufreq_gov_dbs);
+
+static int __init cpufreq_gov_dbs_init(void)
+{
+	return cpufreq_register_governor(&cpufreq_gov_dbs);
+}
+
+static void __exit cpufreq_gov_dbs_exit(void)
+{
+	/* Make sure that the scheduled work is indeed not running */
+	flush_scheduled_work();
+	cpufreq_unregister_governor(&cpufreq_gov_dbs);
+}
+
+
+MODULE_AUTHOR ("Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>");
+MODULE_DESCRIPTION ("DBS(Demand Based Switching)- "
+		"A dynamic processor frequency governor for "
+		"Low Latency Frequency Transition capable processors");
+MODULE_LICENSE ("GPL");
+
+module_init(cpufreq_gov_dbs_init);
+module_exit(cpufreq_gov_dbs_exit);
diff -purN linux-2.6.0-test7/drivers/cpufreq/Kconfig
linux-2.6.0-test7-dbs/drivers/cpufreq/Kconfig
--- linux-2.6.0-test7/drivers/cpufreq/Kconfig	2003-10-20
00:24:33.000000000 -0700
+++ linux-2.6.0-test7-dbs/drivers/cpufreq/Kconfig	2003-10-20
17:27:57.000000000 -0700
@@ -35,6 +35,16 @@ config CPU_FREQ_DEFAULT_GOV_USERSPACE
 	  programm shall be able to set the CPU dynamically without
having
 	  to enable the userspace governor manually.
=20
+config CPU_FREQ_DEFAULT_GOV_DEMANDBASED
+	bool "demandbased"
+	select CPU_FREQ_GOV_DEMANDBASED
+	help
+	  Use the CPUFreq governor 'demandbased' as default. This
enables
+	  kernel to dynamically motnitor the CPU usage and adjust the
+	  CPU frequency accordingly, with no manual intervenation.
+	  This will be enabled only if CPU supports 'Low Latency
+	  Frequency Transitions'
+
 endchoice
=20
 config CPU_FREQ_GOV_PERFORMANCE
@@ -68,6 +78,21 @@ config CPU_FREQ_GOV_USERSPACE
=20
 	  If in doubt, say Y.
=20
+config CPU_FREQ_GOV_DEMANDBASED
+	tristate "Demand Based Switching - Dynamic cpufreq policy
governer"
+	depends on CPU_FREQ
+	help
+	  This driver adds a cpufreq policy governer called Demand Based
+	  Switching.  The driver does a periodic polling and dynamically

+	  changes frequency based on the processor utilization.
+	  The policy depends on processor capability to
+	  do fast frequency switching (i.e, very low latency frequency
+	  transitions).=20
+
+	  For details, take a look at linux/Documentation/cpu-freq.
+
+	  If in doubt, say N.
+
 config CPU_FREQ_24_API
 	bool "/proc/sys/cpu/ interface (2.4. / OLD)"
 	depends on CPU_FREQ && SYSCTL && CPU_FREQ_GOV_USERSPACE
diff -purN linux-2.6.0-test7/drivers/cpufreq/Makefile
linux-2.6.0-test7-dbs/drivers/cpufreq/Makefile
--- linux-2.6.0-test7/drivers/cpufreq/Makefile	2003-10-20
00:24:33.000000000 -0700
+++ linux-2.6.0-test7-dbs/drivers/cpufreq/Makefile	2003-10-20
17:06:05.000000000 -0700
@@ -5,6 +5,7 @@ obj-$(CONFIG_CPU_FREQ)			+=3D cpufreq.o
 obj-$(CONFIG_CPU_FREQ_GOV_PERFORMANCE)	+=3D cpufreq_performance.o
 obj-$(CONFIG_CPU_FREQ_GOV_POWERSAVE)	+=3D cpufreq_powersave.o
 obj-$(CONFIG_CPU_FREQ_GOV_USERSPACE)	+=3D cpufreq_userspace.o
+obj-$(CONFIG_CPU_FREQ_GOV_DEMANDBASED)	+=3D cpufreq_dbs.o
=20
 # CPUfreq cross-arch helpers
 obj-$(CONFIG_CPU_FREQ_TABLE)		+=3D freq_table.o
diff -purN linux-2.6.0-test7/include/linux/cpufreq.h
linux-2.6.0-test7-dbs/include/linux/cpufreq.h
--- linux-2.6.0-test7/include/linux/cpufreq.h	2003-10-08
12:24:16.000000000 -0700
+++ linux-2.6.0-test7-dbs/include/linux/cpufreq.h	2003-10-20
17:36:34.000000000 -0700
@@ -303,6 +303,9 @@ extern struct cpufreq_governor cpufreq_g
 #elif defined(CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE)
 extern struct cpufreq_governor cpufreq_gov_userspace;
 #define CPUFREQ_DEFAULT_GOVERNOR	&cpufreq_gov_userspace
+#elif defined(CONFIG_CPU_FREQ_DEFAULT_GOV_DEMANDBASED)
+extern struct cpufreq_governor cpufreq_gov_dbs;
+#define CPUFREQ_DEFAULT_GOVERNOR	&cpufreq_gov_dbs
 #endif
=20
 /*********************************************************************

------_=_NextPart_001_01C3977E.F5DFAB08
Content-Type: application/octet-stream;
	name="dbs3.patch"
Content-Transfer-Encoding: base64
Content-Description: dbs3.patch
Content-Disposition: attachment;
	filename="dbs3.patch"

ZGlmZiAtcHVyTiBsaW51eC0yLjYuMC10ZXN0Ny9kcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcV9kYnMu
YyBsaW51eC0yLjYuMC10ZXN0Ny1kYnMvZHJpdmVycy9jcHVmcmVxL2NwdWZyZXFfZGJzLmMKLS0t
IGxpbnV4LTIuNi4wLXRlc3Q3L2RyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxX2Ricy5jCTE5NjktMTIt
MzEgMTY6MDA6MDAuMDAwMDAwMDAwIC0wODAwCisrKyBsaW51eC0yLjYuMC10ZXN0Ny1kYnMvZHJp
dmVycy9jcHVmcmVxL2NwdWZyZXFfZGJzLmMJMjAwMy0xMC0yMCAxNzozODowNS4wMDAwMDAwMDAg
LTA3MDAKQEAgLTAsMCArMSwyMTQgQEAKKy8qCisgKiAgZHJpdmVycy9jcHVmcmVxL2NwdWZyZXFf
ZGJzLmMKKyAqCisgKiAgQ29weXJpZ2h0IChDKSAgMjAwMSBSdXNzZWxsIEtpbmcKKyAqICAgICAg
ICAgICAgKEMpICAyMDAyIC0gMjAwMyBEb21pbmlrIEJyb2Rvd3NraSA8bGludXhAYnJvZG8uZGU+
CisgKiAgICAgICAgICAgIChDKSAgMjAwMyBWZW5rYXRlc2ggUGFsbGlwYWRpIDx2ZW5rYXRlc2gu
cGFsbGlwYWRpQGludGVsLmNvbT4uCisgKiAgICAgICAgICAgICAgICAgICAgICBKdW4gTmFrYWpp
bWEgPGp1bi5uYWthamltYUBpbnRlbC5jb20+CisgKgorICogJElkOiQKKyAqCisgKiBUaGlzIHBy
b2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1v
ZGlmeQorICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGlj
ZW5zZSB2ZXJzaW9uIDIgYXMKKyAqIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3Vu
ZGF0aW9uLgorICoKKyAqLworCisjaW5jbHVkZSA8bGludXgva2VybmVsLmg+CisjaW5jbHVkZSA8
bGludXgvbW9kdWxlLmg+CisjaW5jbHVkZSA8bGludXgvc21wLmg+CisjaW5jbHVkZSA8bGludXgv
aW5pdC5oPgorI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPgorI2luY2x1ZGUgPGxpbnV4L2N0
eXBlLmg+CisjaW5jbHVkZSA8bGludXgvY3B1ZnJlcS5oPgorI2luY2x1ZGUgPGxpbnV4L3N5c2N0
bC5oPgorI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+CisjaW5jbHVkZSA8bGludXgvZnMuaD4KKyNp
bmNsdWRlIDxsaW51eC9zeXNmcy5oPgorI2luY2x1ZGUgPGxpbnV4L3NjaGVkLmg+CisjaW5jbHVk
ZSA8bGludXgva21vZC5oPgorI2luY2x1ZGUgPGxpbnV4L3dvcmtxdWV1ZS5oPgorI2luY2x1ZGUg
PGxpbnV4L2ppZmZpZXMuaD4KKyNpbmNsdWRlIDxsaW51eC9jb25maWcuaD4KKyNpbmNsdWRlIDxs
aW51eC9rZXJuZWxfc3RhdC5oPgorCisjZGVmaW5lIERCU19SQVRFCQkoSFovNCkJLyogdGltZXIg
cmF0ZSBpcyAyNTBtcyAqLworI2RlZmluZSBMT1dfTEFURU5DWV9GUkVRVUVOQ1lfQ0hBTkdFX0xJ
TUlUIAkxMDAgLyogaW4gdVMgKi8KKworc3RhdGljIHZvaWQgZG9fZGJzX3RpbWVyKHZvaWQgKmRh
dGEpOworCit0eXBlZGVmIHN0cnVjdCB7CisJc3RydWN0IGNwdWZyZXFfcG9saWN5IAkqY3VyX3Bv
bGljeTsKKwl1bnNpZ25lZCBpbnQgCQlwcmV2X2NwdV9pZGxlOworCXVuc2lnbmVkIGludCAJCWVu
YWJsZTsKK30gX19fX2NhY2hlbGluZV9hbGlnbmVkIGNwdV9kYnNfaW5mb190Oworc3RhdGljIGNw
dV9kYnNfaW5mb190IGNwdV9kYnNfaW5mb1tOUl9DUFVTXTsKKworc3RhdGljIHVuc2lnbmVkIGlu
dCBkYnNfZW5hYmxlOyAJLyogbnVtYmVyIG9mIENQVXMgdXNpbmcgREJTIHBvbGljeSAqLworCitz
dGF0aWMgREVDTEFSRV9NVVRFWCAJKGRic19zZW0pOworc3RhdGljIERFQ0xBUkVfV09SSwkoZGJz
X3dvcmssIGRvX2Ric190aW1lciwgTlVMTCk7CisKK3N0YXRpYyB2b2lkIGRic19jaGVja19jcHUo
aW50IGNwdSkKK3sKKwl1bnNpZ25lZCBpbnQgaWRsZV90aWNrczsKKworCWlmICghY3B1X2Ric19p
bmZvW2NwdV0uZW5hYmxlKQorCQlyZXR1cm47CisKKwlpZGxlX3RpY2tzID0ga3N0YXRfY3B1KGNw
dSkuY3B1c3RhdC5pZGxlIC0gCisJCWNwdV9kYnNfaW5mb1tjcHVdLnByZXZfY3B1X2lkbGU7CisJ
Y3B1X2Ric19pbmZvW2NwdV0ucHJldl9jcHVfaWRsZSA9IGtzdGF0X2NwdShjcHUpLmNwdXN0YXQu
aWRsZTsKKworCS8qIAorCSAqIFRoZSBjdXJyZW50IHNhZmUgcmFuZ2UgaXMgMjAlIHRvIDgwJSAK
KwkgKiAtIElmIGN1cnJlbnQgaWRsZSB0aW1lIGlzIGxlc3MgdGhhbiAyMCUsIHRoZW4gd2UgdHJ5
IHRvIAorCSAqIGluY3JlYXNlIGZyZXF1ZW5jeQorCSAqIC0gSWYgY3VycmVudCBpZGxlIHRpbWUg
aXMgbW9yZSB0aGFuIDgwJSwgdGhlbiB3ZSB0cnkgdG8KKwkgKiBkZWNyZWFzZSBmcmVxdWVuY3kK
KwkgKi8KKwlpZiAoaWRsZV90aWNrcyA8IChEQlNfUkFURSAvIDUpKQorCQljcHVmcmVxX2RyaXZl
cl90YXJnZXQoY3B1X2Ric19pbmZvW2NwdV0uY3VyX3BvbGljeSwKKwkJCWNwdV9kYnNfaW5mb1tj
cHVdLmN1cl9wb2xpY3ktPmN1ciArIDEsIAorCQkJQ1BVRlJFUV9SRUxBVElPTl9MKTsKKwllbHNl
IGlmIChpZGxlX3RpY2tzID4gKDQgKiBEQlNfUkFURSAvIDUpKQorCQljcHVmcmVxX2RyaXZlcl90
YXJnZXQoY3B1X2Ric19pbmZvW2NwdV0uY3VyX3BvbGljeSwKKwkJCWNwdV9kYnNfaW5mb1tjcHVd
LmN1cl9wb2xpY3ktPmN1ciAtIDEsIAorCQkJQ1BVRlJFUV9SRUxBVElPTl9IKTsKK30KKworc3Rh
dGljIHZvaWQgZG9fZGJzX3RpbWVyKHZvaWQgKmRhdGEpCit7IAorCWludCBpOworCWRvd24oJmRi
c19zZW0pOworCWZvciAoaSA9IDA7IGkgPCBOUl9DUFVTOyBpKyspCisJCWlmIChjcHVfb25saW5l
KGkpKQorCQkJZGJzX2NoZWNrX2NwdShpKTsKKwlzY2hlZHVsZV9kZWxheWVkX3dvcmsoJmRic193
b3JrLCBEQlNfUkFURSk7IAorCXVwKCZkYnNfc2VtKTsKK30gCisKK3N0YXRpYyBpbmxpbmUgaW50
IGRic190aW1lcl9pbml0KHZvaWQpCit7CisJc2NoZWR1bGVfd29yaygmZGJzX3dvcmspOworCXJl
dHVybiAwOworfQorCitzdGF0aWMgaW5saW5lIHZvaWQgZGJzX3RpbWVyX2V4aXQodm9pZCkKK3sK
KwljYW5jZWxfZGVsYXllZF93b3JrKCZkYnNfd29yayk7CisJcmV0dXJuOworfQorCisvKioqKioq
KioqKioqKioqKioqKioqKioqKiogc3lzZnMgaW50ZXJmYWNlICoqKioqKioqKioqKioqKioqKioq
KioqKi8KK3N0YXRpYyBzc2l6ZV90IHNob3dfc3BlZWQgKHN0cnVjdCBjcHVmcmVxX3BvbGljeSAq
cG9saWN5LCBjaGFyICpidWYpCit7CisJcmV0dXJuIHNwcmludGYgKGJ1ZiwgIiV1XG4iLCBwb2xp
Y3ktPmN1cik7Cit9CisKK3N0YXRpYyBzdHJ1Y3QgZnJlcV9hdHRyIGZyZXFfYXR0cl9zY2FsaW5n
X2dldHNwZWVkID0geworCS5hdHRyID0geyAubmFtZSA9ICJzY2FsaW5nX2dldHNwZWVkIiwgLm1v
ZGUgPSAwNDQ0IH0sCisJLnNob3cgPSBzaG93X3NwZWVkLAorfTsKKworc3RhdGljIGludCBjcHVm
cmVxX2dvdmVybm9yX2RicyhzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kgKnBvbGljeSwKKwkJCQkgICB1
bnNpZ25lZCBpbnQgZXZlbnQpCit7CisJdW5zaWduZWQgaW50IGNwdSA9IHBvbGljeS0+Y3B1Owor
CisJc3dpdGNoIChldmVudCkgeworCWNhc2UgQ1BVRlJFUV9HT1ZfU1RBUlQ6CisJCWlmICgoIWNw
dV9vbmxpbmUoY3B1KSkgfHwgKCF0cnlfbW9kdWxlX2dldChUSElTX01PRFVMRSkpIHx8CisJCSAg
ICAhcG9saWN5LT5jdXIpCisJCQlyZXR1cm4gLUVJTlZBTDsKKwkJaWYgKHBvbGljeS0+Y3B1aW5m
by50cmFuc2l0aW9uX2xhdGVuY3kgPiAKKwkJCQlMT1dfTEFURU5DWV9GUkVRVUVOQ1lfQ0hBTkdF
X0xJTUlUKQorCQkJcmV0dXJuIC1FSU5WQUw7CisJCWlmIChjcHVfZGJzX2luZm9bY3B1XS5lbmFi
bGUpIC8qIEFscmVhZHkgZW5hYmxlZCAqLworCQkJYnJlYWs7CisKKwkJcHJpbnRrKEtFUk5fREVC
VUcgIkRCUyBTVEFSVDogY3B1ICVkLCBtYXggJWQsIG1pbiAlZCwgY3VyICVkXG4iLAorCQkJCXBv
bGljeS0+Y3B1LCBwb2xpY3ktPm1heCwKKwkJCQlwb2xpY3ktPm1pbiwgcG9saWN5LT5jdXIpOwor
CQlkb3duKCZkYnNfc2VtKTsKKwkJY3B1X2Ric19pbmZvW2NwdV0uY3VyX3BvbGljeSA9IHBvbGlj
eTsKKwkJY3B1X2Ric19pbmZvW2NwdV0ucHJldl9jcHVfaWRsZSA9IGtzdGF0X2NwdShjcHUpLmNw
dXN0YXQuaWRsZTsKKwkJY3B1X2Ric19pbmZvW2NwdV0uZW5hYmxlID0gMTsKKwkJc3lzZnNfY3Jl
YXRlX2ZpbGUoJnBvbGljeS0+a29iaiwgCisJCQkJJmZyZXFfYXR0cl9zY2FsaW5nX2dldHNwZWVk
LmF0dHIpOworCQlkYnNfZW5hYmxlKys7CisJCS8qCisJCSAqIFN0YXJ0IHRoZSB0aW1lcnNjaGVk
dWxlIHdvcmssIHdoZW4gdGhpcyBnb3Zlcm5lcgorCQkgKiBpcyB1c2VkIGZvciBmaXJzdCB0aW1l
CisJCSAqLworCQlpZiAoZGJzX2VuYWJsZSA9PSAxKSAKKwkJCWRic190aW1lcl9pbml0KCk7CisJ
CQorCQl1cCgmZGJzX3NlbSk7CisJCWJyZWFrOworCisJY2FzZSBDUFVGUkVRX0dPVl9TVE9QOgor
CQlwcmludGsoS0VSTl9ERUJVRyAiREJTIFNUT1A6IGNwdSAlZCwgbWF4ICVkLCBtaW4gJWQsIGN1
ciAlZFxuIiwKKwkJCQlwb2xpY3ktPmNwdSwgcG9saWN5LT5tYXgsCisJCQkJcG9saWN5LT5taW4s
IHBvbGljeS0+Y3VyKTsKKwkJZG93bigmZGJzX3NlbSk7CisJCXN5c2ZzX3JlbW92ZV9maWxlKCZw
b2xpY3ktPmtvYmosIAorCQkJCSZmcmVxX2F0dHJfc2NhbGluZ19nZXRzcGVlZC5hdHRyKTsKKwkJ
Y3B1X2Ric19pbmZvW2NwdV0uZW5hYmxlID0gMDsKKwkJZGJzX2VuYWJsZS0tOworCQkvKgorCQkg
KiBTdGFydCB0aGUgdGltZXJzY2hlZHVsZSB3b3JrLCB3aGVuIHRoaXMgZ292ZXJuZXIKKwkJICog
aXMgdXNlZCBmb3IgZmlyc3QgdGltZQorCQkgKi8KKwkJaWYgKGRic19lbmFibGUgPT0gMCkgCisJ
CQlkYnNfdGltZXJfZXhpdCgpOworCQkKKwkJdXAoJmRic19zZW0pOworCQltb2R1bGVfcHV0KFRI
SVNfTU9EVUxFKTsKKwkJYnJlYWs7CisKKwljYXNlIENQVUZSRVFfR09WX0xJTUlUUzoKKwkJcHJp
bnRrKEtFUk5fREVCVUcgIkRCUyBMSU1JVDogY3B1ICVkLCBtYXggJWQsIG1pbiAlZCwgY3VyICVk
XG4iLAorCQkJCXBvbGljeS0+Y3B1LCBwb2xpY3ktPm1heCwKKwkJCQlwb2xpY3ktPm1pbiwgcG9s
aWN5LT5jdXIpOworCQlkb3duKCZkYnNfc2VtKTsKKwkJaWYgKHBvbGljeS0+bWF4IDwgY3B1X2Ri
c19pbmZvW2NwdV0uY3VyX3BvbGljeS0+Y3VyKQorCQkJX19jcHVmcmVxX2RyaXZlcl90YXJnZXQo
Y3B1X2Ric19pbmZvW2NwdV0uY3VyX3BvbGljeSwKKwkJCQkgICAgICAgCXBvbGljeS0+bWF4LCBD
UFVGUkVRX1JFTEFUSU9OX0gpOworCQllbHNlIGlmIChwb2xpY3ktPm1pbiA+IGNwdV9kYnNfaW5m
b1tjcHVdLmN1cl9wb2xpY3ktPmN1cikKKwkJCV9fY3B1ZnJlcV9kcml2ZXJfdGFyZ2V0KGNwdV9k
YnNfaW5mb1tjcHVdLmN1cl9wb2xpY3ksCisJCQkJICAgICAgIAlwb2xpY3ktPm1pbiwgQ1BVRlJF
UV9SRUxBVElPTl9MKTsKKwkJdXAoJmRic19zZW0pOworCQlicmVhazsKKwl9CisJcmV0dXJuIDA7
Cit9CisKK3N0cnVjdCBjcHVmcmVxX2dvdmVybm9yIGNwdWZyZXFfZ292X2RicyA9IHsKKwkubmFt
ZQkJPSAiZGVtYW5kYmFzZWQiLAorCS5nb3Zlcm5vcgk9IGNwdWZyZXFfZ292ZXJub3JfZGJzLAor
CS5vd25lcgkJPSBUSElTX01PRFVMRSwKK307CitFWFBPUlRfU1lNQk9MKGNwdWZyZXFfZ292X2Ri
cyk7CisKK3N0YXRpYyBpbnQgX19pbml0IGNwdWZyZXFfZ292X2Ric19pbml0KHZvaWQpCit7CisJ
cmV0dXJuIGNwdWZyZXFfcmVnaXN0ZXJfZ292ZXJub3IoJmNwdWZyZXFfZ292X2Ricyk7Cit9CisK
K3N0YXRpYyB2b2lkIF9fZXhpdCBjcHVmcmVxX2dvdl9kYnNfZXhpdCh2b2lkKQoreworCS8qIE1h
a2Ugc3VyZSB0aGF0IHRoZSBzY2hlZHVsZWQgd29yayBpcyBpbmRlZWQgbm90IHJ1bm5pbmcgKi8K
KwlmbHVzaF9zY2hlZHVsZWRfd29yaygpOworCWNwdWZyZXFfdW5yZWdpc3Rlcl9nb3Zlcm5vcigm
Y3B1ZnJlcV9nb3ZfZGJzKTsKK30KKworCitNT0RVTEVfQVVUSE9SICgiVmVua2F0ZXNoIFBhbGxp
cGFkaSA8dmVua2F0ZXNoLnBhbGxpcGFkaUBpbnRlbC5jb20+Iik7CitNT0RVTEVfREVTQ1JJUFRJ
T04gKCJEQlMoRGVtYW5kIEJhc2VkIFN3aXRjaGluZyktICIKKwkJIkEgZHluYW1pYyBwcm9jZXNz
b3IgZnJlcXVlbmN5IGdvdmVybm9yIGZvciAiCisJCSJMb3cgTGF0ZW5jeSBGcmVxdWVuY3kgVHJh
bnNpdGlvbiBjYXBhYmxlIHByb2Nlc3NvcnMiKTsKK01PRFVMRV9MSUNFTlNFICgiR1BMIik7CisK
K21vZHVsZV9pbml0KGNwdWZyZXFfZ292X2Ric19pbml0KTsKK21vZHVsZV9leGl0KGNwdWZyZXFf
Z292X2Ric19leGl0KTsKZGlmZiAtcHVyTiBsaW51eC0yLjYuMC10ZXN0Ny9kcml2ZXJzL2NwdWZy
ZXEvS2NvbmZpZyBsaW51eC0yLjYuMC10ZXN0Ny1kYnMvZHJpdmVycy9jcHVmcmVxL0tjb25maWcK
LS0tIGxpbnV4LTIuNi4wLXRlc3Q3L2RyaXZlcnMvY3B1ZnJlcS9LY29uZmlnCTIwMDMtMTAtMjAg
MDA6MjQ6MzMuMDAwMDAwMDAwIC0wNzAwCisrKyBsaW51eC0yLjYuMC10ZXN0Ny1kYnMvZHJpdmVy
cy9jcHVmcmVxL0tjb25maWcJMjAwMy0xMC0yMCAxNzoyNzo1Ny4wMDAwMDAwMDAgLTA3MDAKQEAg
LTM1LDYgKzM1LDE2IEBAIGNvbmZpZyBDUFVfRlJFUV9ERUZBVUxUX0dPVl9VU0VSU1BBQ0UKIAkg
IHByb2dyYW1tIHNoYWxsIGJlIGFibGUgdG8gc2V0IHRoZSBDUFUgZHluYW1pY2FsbHkgd2l0aG91
dCBoYXZpbmcKIAkgIHRvIGVuYWJsZSB0aGUgdXNlcnNwYWNlIGdvdmVybm9yIG1hbnVhbGx5Lgog
Citjb25maWcgQ1BVX0ZSRVFfREVGQVVMVF9HT1ZfREVNQU5EQkFTRUQKKwlib29sICJkZW1hbmRi
YXNlZCIKKwlzZWxlY3QgQ1BVX0ZSRVFfR09WX0RFTUFOREJBU0VECisJaGVscAorCSAgVXNlIHRo
ZSBDUFVGcmVxIGdvdmVybm9yICdkZW1hbmRiYXNlZCcgYXMgZGVmYXVsdC4gVGhpcyBlbmFibGVz
CisJICBrZXJuZWwgdG8gZHluYW1pY2FsbHkgbW90bml0b3IgdGhlIENQVSB1c2FnZSBhbmQgYWRq
dXN0IHRoZQorCSAgQ1BVIGZyZXF1ZW5jeSBhY2NvcmRpbmdseSwgd2l0aCBubyBtYW51YWwgaW50
ZXJ2ZW5hdGlvbi4KKwkgIFRoaXMgd2lsbCBiZSBlbmFibGVkIG9ubHkgaWYgQ1BVIHN1cHBvcnRz
ICdMb3cgTGF0ZW5jeQorCSAgRnJlcXVlbmN5IFRyYW5zaXRpb25zJworCiBlbmRjaG9pY2UKIAog
Y29uZmlnIENQVV9GUkVRX0dPVl9QRVJGT1JNQU5DRQpAQCAtNjgsNiArNzgsMjEgQEAgY29uZmln
IENQVV9GUkVRX0dPVl9VU0VSU1BBQ0UKIAogCSAgSWYgaW4gZG91YnQsIHNheSBZLgogCitjb25m
aWcgQ1BVX0ZSRVFfR09WX0RFTUFOREJBU0VECisJdHJpc3RhdGUgIkRlbWFuZCBCYXNlZCBTd2l0
Y2hpbmcgLSBEeW5hbWljIGNwdWZyZXEgcG9saWN5IGdvdmVybmVyIgorCWRlcGVuZHMgb24gQ1BV
X0ZSRVEKKwloZWxwCisJICBUaGlzIGRyaXZlciBhZGRzIGEgY3B1ZnJlcSBwb2xpY3kgZ292ZXJu
ZXIgY2FsbGVkIERlbWFuZCBCYXNlZAorCSAgU3dpdGNoaW5nLiAgVGhlIGRyaXZlciBkb2VzIGEg
cGVyaW9kaWMgcG9sbGluZyBhbmQgZHluYW1pY2FsbHkgCisJICBjaGFuZ2VzIGZyZXF1ZW5jeSBi
YXNlZCBvbiB0aGUgcHJvY2Vzc29yIHV0aWxpemF0aW9uLgorCSAgVGhlIHBvbGljeSBkZXBlbmRz
IG9uIHByb2Nlc3NvciBjYXBhYmlsaXR5IHRvCisJICBkbyBmYXN0IGZyZXF1ZW5jeSBzd2l0Y2hp
bmcgKGkuZSwgdmVyeSBsb3cgbGF0ZW5jeSBmcmVxdWVuY3kKKwkgIHRyYW5zaXRpb25zKS4gCisK
KwkgIEZvciBkZXRhaWxzLCB0YWtlIGEgbG9vayBhdCBsaW51eC9Eb2N1bWVudGF0aW9uL2NwdS1m
cmVxLgorCisJICBJZiBpbiBkb3VidCwgc2F5IE4uCisKIGNvbmZpZyBDUFVfRlJFUV8yNF9BUEkK
IAlib29sICIvcHJvYy9zeXMvY3B1LyBpbnRlcmZhY2UgKDIuNC4gLyBPTEQpIgogCWRlcGVuZHMg
b24gQ1BVX0ZSRVEgJiYgU1lTQ1RMICYmIENQVV9GUkVRX0dPVl9VU0VSU1BBQ0UKZGlmZiAtcHVy
TiBsaW51eC0yLjYuMC10ZXN0Ny9kcml2ZXJzL2NwdWZyZXEvTWFrZWZpbGUgbGludXgtMi42LjAt
dGVzdDctZGJzL2RyaXZlcnMvY3B1ZnJlcS9NYWtlZmlsZQotLS0gbGludXgtMi42LjAtdGVzdDcv
ZHJpdmVycy9jcHVmcmVxL01ha2VmaWxlCTIwMDMtMTAtMjAgMDA6MjQ6MzMuMDAwMDAwMDAwIC0w
NzAwCisrKyBsaW51eC0yLjYuMC10ZXN0Ny1kYnMvZHJpdmVycy9jcHVmcmVxL01ha2VmaWxlCTIw
MDMtMTAtMjAgMTc6MDY6MDUuMDAwMDAwMDAwIC0wNzAwCkBAIC01LDYgKzUsNyBAQCBvYmotJChD
T05GSUdfQ1BVX0ZSRVEpCQkJKz0gY3B1ZnJlcS5vCiBvYmotJChDT05GSUdfQ1BVX0ZSRVFfR09W
X1BFUkZPUk1BTkNFKQkrPSBjcHVmcmVxX3BlcmZvcm1hbmNlLm8KIG9iai0kKENPTkZJR19DUFVf
RlJFUV9HT1ZfUE9XRVJTQVZFKQkrPSBjcHVmcmVxX3Bvd2Vyc2F2ZS5vCiBvYmotJChDT05GSUdf
Q1BVX0ZSRVFfR09WX1VTRVJTUEFDRSkJKz0gY3B1ZnJlcV91c2Vyc3BhY2Uubworb2JqLSQoQ09O
RklHX0NQVV9GUkVRX0dPVl9ERU1BTkRCQVNFRCkJKz0gY3B1ZnJlcV9kYnMubwogCiAjIENQVWZy
ZXEgY3Jvc3MtYXJjaCBoZWxwZXJzCiBvYmotJChDT05GSUdfQ1BVX0ZSRVFfVEFCTEUpCQkrPSBm
cmVxX3RhYmxlLm8KZGlmZiAtcHVyTiBsaW51eC0yLjYuMC10ZXN0Ny9pbmNsdWRlL2xpbnV4L2Nw
dWZyZXEuaCBsaW51eC0yLjYuMC10ZXN0Ny1kYnMvaW5jbHVkZS9saW51eC9jcHVmcmVxLmgKLS0t
IGxpbnV4LTIuNi4wLXRlc3Q3L2luY2x1ZGUvbGludXgvY3B1ZnJlcS5oCTIwMDMtMTAtMDggMTI6
MjQ6MTYuMDAwMDAwMDAwIC0wNzAwCisrKyBsaW51eC0yLjYuMC10ZXN0Ny1kYnMvaW5jbHVkZS9s
aW51eC9jcHVmcmVxLmgJMjAwMy0xMC0yMCAxNzozNjozNC4wMDAwMDAwMDAgLTA3MDAKQEAgLTMw
Myw2ICszMDMsOSBAQCBleHRlcm4gc3RydWN0IGNwdWZyZXFfZ292ZXJub3IgY3B1ZnJlcV9nCiAj
ZWxpZiBkZWZpbmVkKENPTkZJR19DUFVfRlJFUV9ERUZBVUxUX0dPVl9VU0VSU1BBQ0UpCiBleHRl
cm4gc3RydWN0IGNwdWZyZXFfZ292ZXJub3IgY3B1ZnJlcV9nb3ZfdXNlcnNwYWNlOwogI2RlZmlu
ZSBDUFVGUkVRX0RFRkFVTFRfR09WRVJOT1IJJmNwdWZyZXFfZ292X3VzZXJzcGFjZQorI2VsaWYg
ZGVmaW5lZChDT05GSUdfQ1BVX0ZSRVFfREVGQVVMVF9HT1ZfREVNQU5EQkFTRUQpCitleHRlcm4g
c3RydWN0IGNwdWZyZXFfZ292ZXJub3IgY3B1ZnJlcV9nb3ZfZGJzOworI2RlZmluZSBDUFVGUkVR
X0RFRkFVTFRfR09WRVJOT1IJJmNwdWZyZXFfZ292X2RicwogI2VuZGlmCiAKIC8qKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioK

------_=_NextPart_001_01C3977E.F5DFAB08--
