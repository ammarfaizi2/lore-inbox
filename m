Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbTJYTzz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 15:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbTJYTzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 15:55:55 -0400
Received: from fmr06.intel.com ([134.134.136.7]:48791 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262817AbTJYTyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 15:54:47 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C39B31.D4801958"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: [PATCH] 2/3 A dynamic cpufreq governor
Date: Sat, 25 Oct 2003 12:54:41 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6007796C@scsmsx403.sc.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2/3 A dynamic cpufreq governor
Thread-Index: AcObMdNOZnMSoZV8TUaYlv6qZr345w==
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <linux-kernel@vger.kernel.org>, <cpufreq@www.linux.org.uk>,
       "Linus Torvalds" <torvalds@osdl.org>, <akpm@osdl.org>
Cc: "Pavel Machek" <pavel@ucw.cz>, "Dominik Brodowski" <linux@brodo.de>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
X-OriginalArrivalTime: 25 Oct 2003 19:54:42.0012 (UTC) FILETIME=[D4AA01C0:01C39B31]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C39B31.D4801958
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

ondemand2.patch - basic cpufreq_ondemand governor, with some changes=20
since the last time.

diffstat ondemand2.patch
 Kconfig            |   15 +++
 Makefile           |    1=20
 cpufreq_ondemand.c |  236
+++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 252 insertions(+)


diff -purN linux-2.6.0-test8/drivers/cpufreq/cpufreq_ondemand.c
linux-2.6.0-test8-dbs/drivers/cpufreq/cpufreq_ondemand.c
--- linux-2.6.0-test8/drivers/cpufreq/cpufreq_ondemand.c
1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.0-test8-dbs/drivers/cpufreq/cpufreq_ondemand.c
2003-10-25 13:38:27.000000000 -0700
@@ -0,0 +1,236 @@
+/*
+ *  drivers/cpufreq/cpufreq_ondemand.c
+ *
+ *  Copyright (C)  2001 Russell King
+ *            (C)  2003 Venkatesh Pallipadi
<venkatesh.pallipadi@intel.com>.
+ *                      Jun Nakajima <jun.nakajima@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
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
+/*
+ * dbs is used in this file as a shortform for demandbased switching
+ * It helps to keep variable names smaller, simpler
+ */
+
+#define DEF_SAMPLING_RATE			(HZ/4)	/* 250ms */
+#define MIN_SAMPLING_RATE			(HZ/10)
+#define MAX_SAMPLING_RATE			(10*HZ)
+
+#define DEF_FREQUENCY_UP_THRESHOLD		(80)
+#define MIN_FREQUENCY_UP_THRESHOLD		(0)
+#define MAX_FREQUENCY_UP_THRESHOLD		(100)
+
+#define DEF_FREQUENCY_DOWN_THRESHOLD		(20)
+#define MIN_FREQUENCY_DOWN_THRESHOLD		(0)
+#define MAX_FREQUENCY_DOWN_THRESHOLD		(100)
+
+#define LOW_LATENCY_FREQUENCY_CHANGE_LIMIT 	(100*1000) /* in nS */
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
+static unsigned int dbs_enable;	/* number of CPUs using this
policy */
+
+static DECLARE_MUTEX 	(dbs_sem);
+static DECLARE_WORK	(dbs_work, do_dbs_timer, NULL);
+
+struct dbs_tuners {
+	unsigned int 		sampling_rate;
+	unsigned int		up_threshold;
+	unsigned int		down_threshold;
+};
+
+struct dbs_tuners dbs_tuners_ins =3D {
+	.sampling_rate =3D DEF_SAMPLING_RATE,
+	.up_threshold =3D DEF_FREQUENCY_UP_THRESHOLD,
+	.down_threshold =3D DEF_FREQUENCY_DOWN_THRESHOLD,
+};
+
+static void dbs_check_cpu(int cpu)
+{
+	unsigned int idle_ticks, up_idle_ticks, down_idle_ticks;
+
+	if (!cpu_dbs_info[cpu].enable)
+		return;
+
+	idle_ticks =3D kstat_cpu(cpu).cpustat.idle -=20
+		cpu_dbs_info[cpu].prev_cpu_idle;
+	cpu_dbs_info[cpu].prev_cpu_idle =3D kstat_cpu(cpu).cpustat.idle;
+
+	/*=20
+	 * The default safe range is 20% to 80%=20
+	 * - If current idle time is less than 20%, then we try to=20
+	 * increase frequency
+	 * - If current idle time is more than 80%, then we try to
+	 * decrease frequency
+	 */
+	up_idle_ticks =3D (100 - dbs_tuners_ins.up_threshold) *
+			dbs_tuners_ins.sampling_rate / 100;
+
+	if (idle_ticks < up_idle_ticks) {
+		cpufreq_driver_target(cpu_dbs_info[cpu].cur_policy,
+			cpu_dbs_info[cpu].cur_policy->cur + 1,=20
+			CPUFREQ_RELATION_L);
+		return;
+	}
+
+	down_idle_ticks =3D (100 - dbs_tuners_ins.down_threshold) *
+			dbs_tuners_ins.sampling_rate / 100;
+
+	if (idle_ticks > down_idle_ticks ) {
+		cpufreq_driver_target(cpu_dbs_info[cpu].cur_policy,
+			cpu_dbs_info[cpu].cur_policy->cur - 1,=20
+			CPUFREQ_RELATION_H);
+		return;
+	}
+}
+
+static void do_dbs_timer(void *data)
+{=20
+	int i;
+	down(&dbs_sem);
+	for (i =3D 0; i < NR_CPUS; i++)
+		if (cpu_online(i))
+			dbs_check_cpu(i);
+	schedule_delayed_work(&dbs_work, dbs_tuners_ins.sampling_rate);=20
+	up(&dbs_sem);
+}=20
+
+
+static inline void dbs_timer_init(void)
+{
+	INIT_WORK(&dbs_work, do_dbs_timer, NULL);
+	schedule_work(&dbs_work);
+	return;
+}
+
+static inline void dbs_timer_exit(void)
+{
+	cancel_delayed_work(&dbs_work);
+	return;
+}
+
+static int cpufreq_governor_dbs(struct cpufreq_policy *policy,
+				   unsigned int event)
+{
+	unsigned int cpu =3D policy->cpu;
+
+	switch (event) {
+	case CPUFREQ_GOV_START:
+		if ((!cpu_online(cpu)) || !policy->cur)
+			return -EINVAL;
+		if (policy->cpuinfo.transition_latency >=20
+				LOW_LATENCY_FREQUENCY_CHANGE_LIMIT)
+			return -EINVAL;
+		if (cpu_dbs_info[cpu].enable) /* Already enabled */
+			break;
+
+		printk(KERN_DEBUG=20
+			"ONDEMAND START: cpu %d, max %d, min %d, cur
%d\n",
+			policy->cpu, policy->max, policy->min,
policy->cur);
+		down(&dbs_sem);
+		cpu_dbs_info[cpu].cur_policy =3D policy;
+		cpu_dbs_info[cpu].prev_cpu_idle =3D=20
+				kstat_cpu(cpu).cpustat.idle;
+		cpu_dbs_info[cpu].enable =3D 1;
+		dbs_enable++;
+		/*
+		 * Start the timerschedule work, when this governor
+		 * is used for first time
+		 */
+		if (dbs_enable =3D=3D 1)
+			dbs_timer_init();
+	=09
+		up(&dbs_sem);
+		break;
+
+	case CPUFREQ_GOV_STOP:
+		printk(KERN_DEBUG=20
+			"ONDEMAND STOP: cpu %d, max %d, min %d, cur
%d\n",
+			policy->cpu, policy->max, policy->min,
policy->cur);
+		down(&dbs_sem);
+		cpu_dbs_info[cpu].enable =3D 0;
+		dbs_enable--;
+		/*
+		 * Stop the timerschedule work, when this governor
+		 * is used for first time
+		 */
+		if (dbs_enable =3D=3D 0)=20
+			dbs_timer_exit();
+	=09
+		up(&dbs_sem);
+		break;
+
+	case CPUFREQ_GOV_LIMITS:
+		printk(KERN_DEBUG=20
+			"ONDEMAND LIMIT: cpu %d, max %d, min %d, cur
%d\n",
+			policy->cpu, policy->max, policy->min,
policy->cur);
+		down(&dbs_sem);
+		if (policy->max < cpu_dbs_info[cpu].cur_policy->cur)
+			__cpufreq_driver_target(
+					cpu_dbs_info[cpu].cur_policy,
+				       	policy->max,
CPUFREQ_RELATION_H);
+		else if (policy->min >
cpu_dbs_info[cpu].cur_policy->cur)
+			__cpufreq_driver_target(
+					cpu_dbs_info[cpu].cur_policy,
+				       	policy->min,
CPUFREQ_RELATION_L);
+		up(&dbs_sem);
+		break;
+	}
+	return 0;
+}
+
+struct cpufreq_governor cpufreq_gov_dbs =3D {
+	.name		=3D "ondemand",
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
+MODULE_DESCRIPTION ("'cpufreq_ondemand' - A dynamic cpufreq governor
for "
+		"Low Latency Frequency Transition capable processors");
+MODULE_LICENSE ("GPL");
+
+module_init(cpufreq_gov_dbs_init);
+module_exit(cpufreq_gov_dbs_exit);
diff -purN linux-2.6.0-test8/drivers/cpufreq/Kconfig
linux-2.6.0-test8-dbs/drivers/cpufreq/Kconfig
--- linux-2.6.0-test8/drivers/cpufreq/Kconfig	2003-10-17
14:43:29.000000000 -0700
+++ linux-2.6.0-test8-dbs/drivers/cpufreq/Kconfig	2003-10-25
13:34:09.000000000 -0700
@@ -68,6 +68,21 @@ config CPU_FREQ_GOV_USERSPACE
=20
 	  If in doubt, say Y.
=20
+config CPU_FREQ_GOV_ONDEMAND
+	tristate "'ondemand' cpufreq policy governor"
+	depends on CPU_FREQ
+	help
+	  'ondemand' - This driver adds a dynamic cpufreq policy
governor.
+	  The governor does a periodic polling and=20
+	  changes frequency based on the CPU utilization.
+	  The support for this governor depends on CPU capability to
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
diff -purN linux-2.6.0-test8/drivers/cpufreq/Makefile
linux-2.6.0-test8-dbs/drivers/cpufreq/Makefile
--- linux-2.6.0-test8/drivers/cpufreq/Makefile	2003-10-17
14:43:38.000000000 -0700
+++ linux-2.6.0-test8-dbs/drivers/cpufreq/Makefile	2003-10-25
13:34:09.000000000 -0700
@@ -5,6 +5,7 @@ obj-$(CONFIG_CPU_FREQ)			+=3D cpufreq.o
 obj-$(CONFIG_CPU_FREQ_GOV_PERFORMANCE)	+=3D cpufreq_performance.o
 obj-$(CONFIG_CPU_FREQ_GOV_POWERSAVE)	+=3D cpufreq_powersave.o
 obj-$(CONFIG_CPU_FREQ_GOV_USERSPACE)	+=3D cpufreq_userspace.o
+obj-$(CONFIG_CPU_FREQ_GOV_ONDEMAND)	+=3D cpufreq_ondemand.o
=20
 # CPUfreq cross-arch helpers
 obj-$(CONFIG_CPU_FREQ_TABLE)		+=3D freq_table.o

------_=_NextPart_001_01C39B31.D4801958
Content-Type: application/octet-stream;
	name="ondemand2.patch"
Content-Transfer-Encoding: base64
Content-Description: ondemand2.patch
Content-Disposition: attachment;
	filename="ondemand2.patch"

ZGlmZiAtcHVyTiBsaW51eC0yLjYuMC10ZXN0OC9kcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcV9vbmRl
bWFuZC5jIGxpbnV4LTIuNi4wLXRlc3Q4LWRicy9kcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcV9vbmRl
bWFuZC5jCi0tLSBsaW51eC0yLjYuMC10ZXN0OC9kcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcV9vbmRl
bWFuZC5jCTE5NjktMTItMzEgMTY6MDA6MDAuMDAwMDAwMDAwIC0wODAwCisrKyBsaW51eC0yLjYu
MC10ZXN0OC1kYnMvZHJpdmVycy9jcHVmcmVxL2NwdWZyZXFfb25kZW1hbmQuYwkyMDAzLTEwLTI1
IDEzOjM4OjI3LjAwMDAwMDAwMCAtMDcwMApAQCAtMCwwICsxLDIzNiBAQAorLyoKKyAqICBkcml2
ZXJzL2NwdWZyZXEvY3B1ZnJlcV9vbmRlbWFuZC5jCisgKgorICogIENvcHlyaWdodCAoQykgIDIw
MDEgUnVzc2VsbCBLaW5nCisgKiAgICAgICAgICAgIChDKSAgMjAwMyBWZW5rYXRlc2ggUGFsbGlw
YWRpIDx2ZW5rYXRlc2gucGFsbGlwYWRpQGludGVsLmNvbT4uCisgKiAgICAgICAgICAgICAgICAg
ICAgICBKdW4gTmFrYWppbWEgPGp1bi5uYWthamltYUBpbnRlbC5jb20+CisgKgorICogVGhpcyBw
cm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBt
b2RpZnkKKyAqIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExp
Y2Vuc2UgdmVyc2lvbiAyIGFzCisgKiBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91
bmRhdGlvbi4KKyAqLworCisjaW5jbHVkZSA8bGludXgva2VybmVsLmg+CisjaW5jbHVkZSA8bGlu
dXgvbW9kdWxlLmg+CisjaW5jbHVkZSA8bGludXgvc21wLmg+CisjaW5jbHVkZSA8bGludXgvaW5p
dC5oPgorI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPgorI2luY2x1ZGUgPGxpbnV4L2N0eXBl
Lmg+CisjaW5jbHVkZSA8bGludXgvY3B1ZnJlcS5oPgorI2luY2x1ZGUgPGxpbnV4L3N5c2N0bC5o
PgorI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+CisjaW5jbHVkZSA8bGludXgvZnMuaD4KKyNpbmNs
dWRlIDxsaW51eC9zeXNmcy5oPgorI2luY2x1ZGUgPGxpbnV4L3NjaGVkLmg+CisjaW5jbHVkZSA8
bGludXgva21vZC5oPgorI2luY2x1ZGUgPGxpbnV4L3dvcmtxdWV1ZS5oPgorI2luY2x1ZGUgPGxp
bnV4L2ppZmZpZXMuaD4KKyNpbmNsdWRlIDxsaW51eC9jb25maWcuaD4KKyNpbmNsdWRlIDxsaW51
eC9rZXJuZWxfc3RhdC5oPgorCisvKgorICogZGJzIGlzIHVzZWQgaW4gdGhpcyBmaWxlIGFzIGEg
c2hvcnRmb3JtIGZvciBkZW1hbmRiYXNlZCBzd2l0Y2hpbmcKKyAqIEl0IGhlbHBzIHRvIGtlZXAg
dmFyaWFibGUgbmFtZXMgc21hbGxlciwgc2ltcGxlcgorICovCisKKyNkZWZpbmUgREVGX1NBTVBM
SU5HX1JBVEUJCQkoSFovNCkJLyogMjUwbXMgKi8KKyNkZWZpbmUgTUlOX1NBTVBMSU5HX1JBVEUJ
CQkoSFovMTApCisjZGVmaW5lIE1BWF9TQU1QTElOR19SQVRFCQkJKDEwKkhaKQorCisjZGVmaW5l
IERFRl9GUkVRVUVOQ1lfVVBfVEhSRVNIT0xECQkoODApCisjZGVmaW5lIE1JTl9GUkVRVUVOQ1lf
VVBfVEhSRVNIT0xECQkoMCkKKyNkZWZpbmUgTUFYX0ZSRVFVRU5DWV9VUF9USFJFU0hPTEQJCSgx
MDApCisKKyNkZWZpbmUgREVGX0ZSRVFVRU5DWV9ET1dOX1RIUkVTSE9MRAkJKDIwKQorI2RlZmlu
ZSBNSU5fRlJFUVVFTkNZX0RPV05fVEhSRVNIT0xECQkoMCkKKyNkZWZpbmUgTUFYX0ZSRVFVRU5D
WV9ET1dOX1RIUkVTSE9MRAkJKDEwMCkKKworI2RlZmluZSBMT1dfTEFURU5DWV9GUkVRVUVOQ1lf
Q0hBTkdFX0xJTUlUIAkoMTAwKjEwMDApIC8qIGluIG5TICovCisKK3N0YXRpYyB2b2lkIGRvX2Ri
c190aW1lcih2b2lkICpkYXRhKTsKKwordHlwZWRlZiBzdHJ1Y3QgeworCXN0cnVjdCBjcHVmcmVx
X3BvbGljeSAJKmN1cl9wb2xpY3k7CisJdW5zaWduZWQgaW50IAkJcHJldl9jcHVfaWRsZTsKKwl1
bnNpZ25lZCBpbnQgCQllbmFibGU7Cit9IF9fX19jYWNoZWxpbmVfYWxpZ25lZCBjcHVfZGJzX2lu
Zm9fdDsKK3N0YXRpYyBjcHVfZGJzX2luZm9fdCBjcHVfZGJzX2luZm9bTlJfQ1BVU107CisKK3N0
YXRpYyB1bnNpZ25lZCBpbnQgZGJzX2VuYWJsZTsJLyogbnVtYmVyIG9mIENQVXMgdXNpbmcgdGhp
cyBwb2xpY3kgKi8KKworc3RhdGljIERFQ0xBUkVfTVVURVggCShkYnNfc2VtKTsKK3N0YXRpYyBE
RUNMQVJFX1dPUksJKGRic193b3JrLCBkb19kYnNfdGltZXIsIE5VTEwpOworCitzdHJ1Y3QgZGJz
X3R1bmVycyB7CisJdW5zaWduZWQgaW50IAkJc2FtcGxpbmdfcmF0ZTsKKwl1bnNpZ25lZCBpbnQJ
CXVwX3RocmVzaG9sZDsKKwl1bnNpZ25lZCBpbnQJCWRvd25fdGhyZXNob2xkOworfTsKKworc3Ry
dWN0IGRic190dW5lcnMgZGJzX3R1bmVyc19pbnMgPSB7CisJLnNhbXBsaW5nX3JhdGUgPSBERUZf
U0FNUExJTkdfUkFURSwKKwkudXBfdGhyZXNob2xkID0gREVGX0ZSRVFVRU5DWV9VUF9USFJFU0hP
TEQsCisJLmRvd25fdGhyZXNob2xkID0gREVGX0ZSRVFVRU5DWV9ET1dOX1RIUkVTSE9MRCwKK307
CisKK3N0YXRpYyB2b2lkIGRic19jaGVja19jcHUoaW50IGNwdSkKK3sKKwl1bnNpZ25lZCBpbnQg
aWRsZV90aWNrcywgdXBfaWRsZV90aWNrcywgZG93bl9pZGxlX3RpY2tzOworCisJaWYgKCFjcHVf
ZGJzX2luZm9bY3B1XS5lbmFibGUpCisJCXJldHVybjsKKworCWlkbGVfdGlja3MgPSBrc3RhdF9j
cHUoY3B1KS5jcHVzdGF0LmlkbGUgLSAKKwkJY3B1X2Ric19pbmZvW2NwdV0ucHJldl9jcHVfaWRs
ZTsKKwljcHVfZGJzX2luZm9bY3B1XS5wcmV2X2NwdV9pZGxlID0ga3N0YXRfY3B1KGNwdSkuY3B1
c3RhdC5pZGxlOworCisJLyogCisJICogVGhlIGRlZmF1bHQgc2FmZSByYW5nZSBpcyAyMCUgdG8g
ODAlIAorCSAqIC0gSWYgY3VycmVudCBpZGxlIHRpbWUgaXMgbGVzcyB0aGFuIDIwJSwgdGhlbiB3
ZSB0cnkgdG8gCisJICogaW5jcmVhc2UgZnJlcXVlbmN5CisJICogLSBJZiBjdXJyZW50IGlkbGUg
dGltZSBpcyBtb3JlIHRoYW4gODAlLCB0aGVuIHdlIHRyeSB0bworCSAqIGRlY3JlYXNlIGZyZXF1
ZW5jeQorCSAqLworCXVwX2lkbGVfdGlja3MgPSAoMTAwIC0gZGJzX3R1bmVyc19pbnMudXBfdGhy
ZXNob2xkKSAqCisJCQlkYnNfdHVuZXJzX2lucy5zYW1wbGluZ19yYXRlIC8gMTAwOworCisJaWYg
KGlkbGVfdGlja3MgPCB1cF9pZGxlX3RpY2tzKSB7CisJCWNwdWZyZXFfZHJpdmVyX3RhcmdldChj
cHVfZGJzX2luZm9bY3B1XS5jdXJfcG9saWN5LAorCQkJY3B1X2Ric19pbmZvW2NwdV0uY3VyX3Bv
bGljeS0+Y3VyICsgMSwgCisJCQlDUFVGUkVRX1JFTEFUSU9OX0wpOworCQlyZXR1cm47CisJfQor
CisJZG93bl9pZGxlX3RpY2tzID0gKDEwMCAtIGRic190dW5lcnNfaW5zLmRvd25fdGhyZXNob2xk
KSAqCisJCQlkYnNfdHVuZXJzX2lucy5zYW1wbGluZ19yYXRlIC8gMTAwOworCisJaWYgKGlkbGVf
dGlja3MgPiBkb3duX2lkbGVfdGlja3MgKSB7CisJCWNwdWZyZXFfZHJpdmVyX3RhcmdldChjcHVf
ZGJzX2luZm9bY3B1XS5jdXJfcG9saWN5LAorCQkJY3B1X2Ric19pbmZvW2NwdV0uY3VyX3BvbGlj
eS0+Y3VyIC0gMSwgCisJCQlDUFVGUkVRX1JFTEFUSU9OX0gpOworCQlyZXR1cm47CisJfQorfQor
CitzdGF0aWMgdm9pZCBkb19kYnNfdGltZXIodm9pZCAqZGF0YSkKK3sgCisJaW50IGk7CisJZG93
bigmZGJzX3NlbSk7CisJZm9yIChpID0gMDsgaSA8IE5SX0NQVVM7IGkrKykKKwkJaWYgKGNwdV9v
bmxpbmUoaSkpCisJCQlkYnNfY2hlY2tfY3B1KGkpOworCXNjaGVkdWxlX2RlbGF5ZWRfd29yaygm
ZGJzX3dvcmssIGRic190dW5lcnNfaW5zLnNhbXBsaW5nX3JhdGUpOyAKKwl1cCgmZGJzX3NlbSk7
Cit9IAorCisKK3N0YXRpYyBpbmxpbmUgdm9pZCBkYnNfdGltZXJfaW5pdCh2b2lkKQoreworCUlO
SVRfV09SSygmZGJzX3dvcmssIGRvX2Ric190aW1lciwgTlVMTCk7CisJc2NoZWR1bGVfd29yaygm
ZGJzX3dvcmspOworCXJldHVybjsKK30KKworc3RhdGljIGlubGluZSB2b2lkIGRic190aW1lcl9l
eGl0KHZvaWQpCit7CisJY2FuY2VsX2RlbGF5ZWRfd29yaygmZGJzX3dvcmspOworCXJldHVybjsK
K30KKworc3RhdGljIGludCBjcHVmcmVxX2dvdmVybm9yX2RicyhzdHJ1Y3QgY3B1ZnJlcV9wb2xp
Y3kgKnBvbGljeSwKKwkJCQkgICB1bnNpZ25lZCBpbnQgZXZlbnQpCit7CisJdW5zaWduZWQgaW50
IGNwdSA9IHBvbGljeS0+Y3B1OworCisJc3dpdGNoIChldmVudCkgeworCWNhc2UgQ1BVRlJFUV9H
T1ZfU1RBUlQ6CisJCWlmICgoIWNwdV9vbmxpbmUoY3B1KSkgfHwgIXBvbGljeS0+Y3VyKQorCQkJ
cmV0dXJuIC1FSU5WQUw7CisJCWlmIChwb2xpY3ktPmNwdWluZm8udHJhbnNpdGlvbl9sYXRlbmN5
ID4gCisJCQkJTE9XX0xBVEVOQ1lfRlJFUVVFTkNZX0NIQU5HRV9MSU1JVCkKKwkJCXJldHVybiAt
RUlOVkFMOworCQlpZiAoY3B1X2Ric19pbmZvW2NwdV0uZW5hYmxlKSAvKiBBbHJlYWR5IGVuYWJs
ZWQgKi8KKwkJCWJyZWFrOworCisJCXByaW50ayhLRVJOX0RFQlVHIAorCQkJIk9OREVNQU5EIFNU
QVJUOiBjcHUgJWQsIG1heCAlZCwgbWluICVkLCBjdXIgJWRcbiIsCisJCQlwb2xpY3ktPmNwdSwg
cG9saWN5LT5tYXgsIHBvbGljeS0+bWluLCBwb2xpY3ktPmN1cik7CisJCWRvd24oJmRic19zZW0p
OworCQljcHVfZGJzX2luZm9bY3B1XS5jdXJfcG9saWN5ID0gcG9saWN5OworCQljcHVfZGJzX2lu
Zm9bY3B1XS5wcmV2X2NwdV9pZGxlID0gCisJCQkJa3N0YXRfY3B1KGNwdSkuY3B1c3RhdC5pZGxl
OworCQljcHVfZGJzX2luZm9bY3B1XS5lbmFibGUgPSAxOworCQlkYnNfZW5hYmxlKys7CisJCS8q
CisJCSAqIFN0YXJ0IHRoZSB0aW1lcnNjaGVkdWxlIHdvcmssIHdoZW4gdGhpcyBnb3Zlcm5vcgor
CQkgKiBpcyB1c2VkIGZvciBmaXJzdCB0aW1lCisJCSAqLworCQlpZiAoZGJzX2VuYWJsZSA9PSAx
KQorCQkJZGJzX3RpbWVyX2luaXQoKTsKKwkJCisJCXVwKCZkYnNfc2VtKTsKKwkJYnJlYWs7CisK
KwljYXNlIENQVUZSRVFfR09WX1NUT1A6CisJCXByaW50ayhLRVJOX0RFQlVHIAorCQkJIk9OREVN
QU5EIFNUT1A6IGNwdSAlZCwgbWF4ICVkLCBtaW4gJWQsIGN1ciAlZFxuIiwKKwkJCXBvbGljeS0+
Y3B1LCBwb2xpY3ktPm1heCwgcG9saWN5LT5taW4sIHBvbGljeS0+Y3VyKTsKKwkJZG93bigmZGJz
X3NlbSk7CisJCWNwdV9kYnNfaW5mb1tjcHVdLmVuYWJsZSA9IDA7CisJCWRic19lbmFibGUtLTsK
KwkJLyoKKwkJICogU3RvcCB0aGUgdGltZXJzY2hlZHVsZSB3b3JrLCB3aGVuIHRoaXMgZ292ZXJu
b3IKKwkJICogaXMgdXNlZCBmb3IgZmlyc3QgdGltZQorCQkgKi8KKwkJaWYgKGRic19lbmFibGUg
PT0gMCkgCisJCQlkYnNfdGltZXJfZXhpdCgpOworCQkKKwkJdXAoJmRic19zZW0pOworCQlicmVh
azsKKworCWNhc2UgQ1BVRlJFUV9HT1ZfTElNSVRTOgorCQlwcmludGsoS0VSTl9ERUJVRyAKKwkJ
CSJPTkRFTUFORCBMSU1JVDogY3B1ICVkLCBtYXggJWQsIG1pbiAlZCwgY3VyICVkXG4iLAorCQkJ
cG9saWN5LT5jcHUsIHBvbGljeS0+bWF4LCBwb2xpY3ktPm1pbiwgcG9saWN5LT5jdXIpOworCQlk
b3duKCZkYnNfc2VtKTsKKwkJaWYgKHBvbGljeS0+bWF4IDwgY3B1X2Ric19pbmZvW2NwdV0uY3Vy
X3BvbGljeS0+Y3VyKQorCQkJX19jcHVmcmVxX2RyaXZlcl90YXJnZXQoCisJCQkJCWNwdV9kYnNf
aW5mb1tjcHVdLmN1cl9wb2xpY3ksCisJCQkJICAgICAgIAlwb2xpY3ktPm1heCwgQ1BVRlJFUV9S
RUxBVElPTl9IKTsKKwkJZWxzZSBpZiAocG9saWN5LT5taW4gPiBjcHVfZGJzX2luZm9bY3B1XS5j
dXJfcG9saWN5LT5jdXIpCisJCQlfX2NwdWZyZXFfZHJpdmVyX3RhcmdldCgKKwkJCQkJY3B1X2Ri
c19pbmZvW2NwdV0uY3VyX3BvbGljeSwKKwkJCQkgICAgICAgCXBvbGljeS0+bWluLCBDUFVGUkVR
X1JFTEFUSU9OX0wpOworCQl1cCgmZGJzX3NlbSk7CisJCWJyZWFrOworCX0KKwlyZXR1cm4gMDsK
K30KKworc3RydWN0IGNwdWZyZXFfZ292ZXJub3IgY3B1ZnJlcV9nb3ZfZGJzID0geworCS5uYW1l
CQk9ICJvbmRlbWFuZCIsCisJLmdvdmVybm9yCT0gY3B1ZnJlcV9nb3Zlcm5vcl9kYnMsCisJLm93
bmVyCQk9IFRISVNfTU9EVUxFLAorfTsKK0VYUE9SVF9TWU1CT0woY3B1ZnJlcV9nb3ZfZGJzKTsK
Kworc3RhdGljIGludCBfX2luaXQgY3B1ZnJlcV9nb3ZfZGJzX2luaXQodm9pZCkKK3sKKwlyZXR1
cm4gY3B1ZnJlcV9yZWdpc3Rlcl9nb3Zlcm5vcigmY3B1ZnJlcV9nb3ZfZGJzKTsKK30KKworc3Rh
dGljIHZvaWQgX19leGl0IGNwdWZyZXFfZ292X2Ric19leGl0KHZvaWQpCit7CisJLyogTWFrZSBz
dXJlIHRoYXQgdGhlIHNjaGVkdWxlZCB3b3JrIGlzIGluZGVlZCBub3QgcnVubmluZyAqLworCWZs
dXNoX3NjaGVkdWxlZF93b3JrKCk7CisJY3B1ZnJlcV91bnJlZ2lzdGVyX2dvdmVybm9yKCZjcHVm
cmVxX2dvdl9kYnMpOworfQorCisKK01PRFVMRV9BVVRIT1IgKCJWZW5rYXRlc2ggUGFsbGlwYWRp
IDx2ZW5rYXRlc2gucGFsbGlwYWRpQGludGVsLmNvbT4iKTsKK01PRFVMRV9ERVNDUklQVElPTiAo
IidjcHVmcmVxX29uZGVtYW5kJyAtIEEgZHluYW1pYyBjcHVmcmVxIGdvdmVybm9yIGZvciAiCisJ
CSJMb3cgTGF0ZW5jeSBGcmVxdWVuY3kgVHJhbnNpdGlvbiBjYXBhYmxlIHByb2Nlc3NvcnMiKTsK
K01PRFVMRV9MSUNFTlNFICgiR1BMIik7CisKK21vZHVsZV9pbml0KGNwdWZyZXFfZ292X2Ric19p
bml0KTsKK21vZHVsZV9leGl0KGNwdWZyZXFfZ292X2Ric19leGl0KTsKZGlmZiAtcHVyTiBsaW51
eC0yLjYuMC10ZXN0OC9kcml2ZXJzL2NwdWZyZXEvS2NvbmZpZyBsaW51eC0yLjYuMC10ZXN0OC1k
YnMvZHJpdmVycy9jcHVmcmVxL0tjb25maWcKLS0tIGxpbnV4LTIuNi4wLXRlc3Q4L2RyaXZlcnMv
Y3B1ZnJlcS9LY29uZmlnCTIwMDMtMTAtMTcgMTQ6NDM6MjkuMDAwMDAwMDAwIC0wNzAwCisrKyBs
aW51eC0yLjYuMC10ZXN0OC1kYnMvZHJpdmVycy9jcHVmcmVxL0tjb25maWcJMjAwMy0xMC0yNSAx
MzozNDowOS4wMDAwMDAwMDAgLTA3MDAKQEAgLTY4LDYgKzY4LDIxIEBAIGNvbmZpZyBDUFVfRlJF
UV9HT1ZfVVNFUlNQQUNFCiAKIAkgIElmIGluIGRvdWJ0LCBzYXkgWS4KIAorY29uZmlnIENQVV9G
UkVRX0dPVl9PTkRFTUFORAorCXRyaXN0YXRlICInb25kZW1hbmQnIGNwdWZyZXEgcG9saWN5IGdv
dmVybm9yIgorCWRlcGVuZHMgb24gQ1BVX0ZSRVEKKwloZWxwCisJICAnb25kZW1hbmQnIC0gVGhp
cyBkcml2ZXIgYWRkcyBhIGR5bmFtaWMgY3B1ZnJlcSBwb2xpY3kgZ292ZXJub3IuCisJICBUaGUg
Z292ZXJub3IgZG9lcyBhIHBlcmlvZGljIHBvbGxpbmcgYW5kIAorCSAgY2hhbmdlcyBmcmVxdWVu
Y3kgYmFzZWQgb24gdGhlIENQVSB1dGlsaXphdGlvbi4KKwkgIFRoZSBzdXBwb3J0IGZvciB0aGlz
IGdvdmVybm9yIGRlcGVuZHMgb24gQ1BVIGNhcGFiaWxpdHkgdG8KKwkgIGRvIGZhc3QgZnJlcXVl
bmN5IHN3aXRjaGluZyAoaS5lLCB2ZXJ5IGxvdyBsYXRlbmN5IGZyZXF1ZW5jeQorCSAgdHJhbnNp
dGlvbnMpLiAKKworCSAgRm9yIGRldGFpbHMsIHRha2UgYSBsb29rIGF0IGxpbnV4L0RvY3VtZW50
YXRpb24vY3B1LWZyZXEuCisKKwkgIElmIGluIGRvdWJ0LCBzYXkgTi4KKwogY29uZmlnIENQVV9G
UkVRXzI0X0FQSQogCWJvb2wgIi9wcm9jL3N5cy9jcHUvIGludGVyZmFjZSAoMi40LiAvIE9MRCki
CiAJZGVwZW5kcyBvbiBDUFVfRlJFUSAmJiBTWVNDVEwgJiYgQ1BVX0ZSRVFfR09WX1VTRVJTUEFD
RQpkaWZmIC1wdXJOIGxpbnV4LTIuNi4wLXRlc3Q4L2RyaXZlcnMvY3B1ZnJlcS9NYWtlZmlsZSBs
aW51eC0yLjYuMC10ZXN0OC1kYnMvZHJpdmVycy9jcHVmcmVxL01ha2VmaWxlCi0tLSBsaW51eC0y
LjYuMC10ZXN0OC9kcml2ZXJzL2NwdWZyZXEvTWFrZWZpbGUJMjAwMy0xMC0xNyAxNDo0MzozOC4w
MDAwMDAwMDAgLTA3MDAKKysrIGxpbnV4LTIuNi4wLXRlc3Q4LWRicy9kcml2ZXJzL2NwdWZyZXEv
TWFrZWZpbGUJMjAwMy0xMC0yNSAxMzozNDowOS4wMDAwMDAwMDAgLTA3MDAKQEAgLTUsNiArNSw3
IEBAIG9iai0kKENPTkZJR19DUFVfRlJFUSkJCQkrPSBjcHVmcmVxLm8KIG9iai0kKENPTkZJR19D
UFVfRlJFUV9HT1ZfUEVSRk9STUFOQ0UpCSs9IGNwdWZyZXFfcGVyZm9ybWFuY2Uubwogb2JqLSQo
Q09ORklHX0NQVV9GUkVRX0dPVl9QT1dFUlNBVkUpCSs9IGNwdWZyZXFfcG93ZXJzYXZlLm8KIG9i
ai0kKENPTkZJR19DUFVfRlJFUV9HT1ZfVVNFUlNQQUNFKQkrPSBjcHVmcmVxX3VzZXJzcGFjZS5v
CitvYmotJChDT05GSUdfQ1BVX0ZSRVFfR09WX09OREVNQU5EKQkrPSBjcHVmcmVxX29uZGVtYW5k
Lm8KIAogIyBDUFVmcmVxIGNyb3NzLWFyY2ggaGVscGVycwogb2JqLSQoQ09ORklHX0NQVV9GUkVR
X1RBQkxFKQkJKz0gZnJlcV90YWJsZS5vCg==

------_=_NextPart_001_01C39B31.D4801958--
