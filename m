Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262860AbTJYT47 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 15:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbTJYT4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 15:56:43 -0400
Received: from fmr06.intel.com ([134.134.136.7]:9880 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262792AbTJYTzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 15:55:16 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C39B31.E5AEDD90"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: [PATCH] 3/3 A dynamic cpufreq governor
Date: Sat, 25 Oct 2003 12:55:10 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6007796D@scsmsx403.sc.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 3/3 A dynamic cpufreq governor
Thread-Index: AcObMeSlQYY54wX1TQCt7k+Pomp5Pg==
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <linux-kernel@vger.kernel.org>, <cpufreq@www.linux.org.uk>,
       "Linus Torvalds" <torvalds@osdl.org>, <akpm@osdl.org>
Cc: "Pavel Machek" <pavel@ucw.cz>, "Dominik Brodowski" <linux@brodo.de>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
X-OriginalArrivalTime: 25 Oct 2003 19:55:10.0930 (UTC) FILETIME=[E5E68B20:01C39B31]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C39B31.E5AEDD90
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

ondemand3.patch - Adding sysfs interface for cpufreq_ondemand=20
tunables and making sysfs access by cpufreq governors safe against=20
removal of the underlying module (from Dominik).=20

diffstat ondemand3.patch
 cpufreq.c          |   24 ++++++++++++
 cpufreq_ondemand.c |  102
+++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+)



diff -purN linux-2.6.0-test8/drivers/cpufreq/cpufreq.c
linux-2.6.0-test8-dbs/drivers/cpufreq/cpufreq.c
--- linux-2.6.0-test8/drivers/cpufreq/cpufreq.c	2003-10-17
14:42:56.000000000 -0700
+++ linux-2.6.0-test8-dbs/drivers/cpufreq/cpufreq.c	2003-10-25
13:40:19.000000000 -0700
@@ -98,6 +98,24 @@ static void cpufreq_cpu_put(struct cpufr
 	module_put(cpufreq_driver->owner);
 }
=20
+
+static unsigned int governor_get(struct cpufreq_policy *data)
+{
+	if (cpufreq_driver->setpolicy)
+		return 1;
+	if (try_module_get(data->governor->owner))
+		return 1;
+	return 0;
+}
+
+
+static void governor_put(struct cpufreq_policy *data)
+{
+	if (cpufreq_driver->target)
+		module_put(data->governor->owner);
+}
+
+
 /*********************************************************************
  *                          SYSFS INTERFACE                          *
  *********************************************************************/
@@ -305,7 +323,10 @@ static ssize_t show(struct kobject * kob
 	policy =3D cpufreq_cpu_get(policy->cpu);
 	if (!policy)
 		return -EINVAL;
+	if (!governor_get(policy))
+		return -EINVAL;
 	ret =3D fattr->show ? fattr->show(policy,buf) : 0;
+	governor_put(policy);
 	cpufreq_cpu_put(policy);
 	return ret;
 }
@@ -319,7 +340,10 @@ static ssize_t store(struct kobject * ko
 	policy =3D cpufreq_cpu_get(policy->cpu);
 	if (!policy)
 		return -EINVAL;
+	if (!governor_get(policy))
+		return -EINVAL;
 	ret =3D fattr->store ? fattr->store(policy,buf,count) : 0;
+	governor_put(policy);
 	cpufreq_cpu_put(policy);
 	return ret;
 }
diff -purN linux-2.6.0-test8/drivers/cpufreq/cpufreq_ondemand.c
linux-2.6.0-test8-dbs/drivers/cpufreq/cpufreq_ondemand.c
--- linux-2.6.0-test8/drivers/cpufreq/cpufreq_ondemand.c
2003-10-25 13:45:59.000000000 -0700
+++ linux-2.6.0-test8-dbs/drivers/cpufreq/cpufreq_ondemand.c
2003-10-25 13:44:40.000000000 -0700
@@ -73,6 +73,106 @@ struct dbs_tuners dbs_tuners_ins =3D {
 	.down_threshold =3D DEF_FREQUENCY_DOWN_THRESHOLD,
 };
=20
+/************************** sysfs interface ************************/
+static ssize_t show_current_freq(struct cpufreq_policy *policy, char
*buf)
+{
+	return sprintf (buf, "%u\n", policy->cur);
+}
+
+static struct freq_attr current_freq =3D {
+	.attr =3D { .name =3D "current_freq", .mode =3D 0444 },
+	.show =3D show_current_freq,
+};
+
+/* cpufreq_ondemand Governor Tunables */
+#define show_one(file_name, object)
\
+static ssize_t show_##file_name
\
+(struct cpufreq_policy *unused, char *buf)
\
+{
\
+	return sprintf(buf, "%u\n", dbs_tuners_ins.object);
\
+}
+show_one(sampling_rate, sampling_rate);
+show_one(up_threshold, up_threshold);
+show_one(down_threshold, down_threshold);
+
+static ssize_t store_sampling_rate(struct cpufreq_policy *unused,=20
+		const char *buf, size_t count)
+{
+	unsigned int input;
+	int ret;
+	ret =3D sscanf (buf, "%u", &input);
+	down(&dbs_sem);
+	if (ret !=3D 1 || input > MAX_SAMPLING_RATE || input <
MIN_SAMPLING_RATE)
+		goto out;
+
+	dbs_tuners_ins.sampling_rate =3D input;
+out:
+	up(&dbs_sem);
+	return count;
+}
+
+static ssize_t store_up_threshold(struct cpufreq_policy *unused,=20
+		const char *buf, size_t count)
+{
+	unsigned int input;
+	int ret;
+	ret =3D sscanf (buf, "%u", &input);
+	down(&dbs_sem);
+	if (ret !=3D 1 || input > MAX_FREQUENCY_UP_THRESHOLD ||=20
+			input < MIN_FREQUENCY_UP_THRESHOLD ||
+			input <=3D dbs_tuners_ins.down_threshold)
+		goto out;
+
+	dbs_tuners_ins.up_threshold =3D input;
+out:
+	up(&dbs_sem);
+	return count;
+}
+
+static ssize_t store_down_threshold(struct cpufreq_policy *unused,=20
+		const char *buf, size_t count)
+{
+	unsigned int input;
+	int ret;
+	ret =3D sscanf (buf, "%u", &input);
+	down(&dbs_sem);
+	if (ret !=3D 1 || input > MAX_FREQUENCY_DOWN_THRESHOLD ||=20
+			input < MIN_FREQUENCY_DOWN_THRESHOLD ||
+			input >=3D dbs_tuners_ins.up_threshold)
+		goto out;
+
+	dbs_tuners_ins.down_threshold =3D input;
+out:
+	up(&dbs_sem);
+	return count;
+}
+
+#define define_one_rw(_name) 					\
+static struct freq_attr _name =3D {
\
+	.attr =3D { .name =3D __stringify(_name), .mode =3D 0644 }, 	\
+	.show =3D show_##_name, 					\
+	.store =3D store_##_name, 				\
+}
+
+define_one_rw(sampling_rate);
+define_one_rw(up_threshold);
+define_one_rw(down_threshold);
+
+static struct attribute * dbs_attributes[] =3D {
+	&current_freq.attr,
+	&sampling_rate.attr,
+	&up_threshold.attr,
+	&down_threshold.attr,
+	NULL
+};
+
+static struct attribute_group dbs_attr_group =3D {
+	.attrs =3D dbs_attributes,
+	.name =3D "ondemand",
+};
+
+/************************** sysfs end ************************/
+
 static void dbs_check_cpu(int cpu)
 {
 	unsigned int idle_ticks, up_idle_ticks, down_idle_ticks;
@@ -160,6 +260,7 @@ static int cpufreq_governor_dbs(struct c
 		cpu_dbs_info[cpu].prev_cpu_idle =3D=20
 				kstat_cpu(cpu).cpustat.idle;
 		cpu_dbs_info[cpu].enable =3D 1;
+		sysfs_create_group(&policy->kobj, &dbs_attr_group);
 		dbs_enable++;
 		/*
 		 * Start the timerschedule work, when this governor
@@ -177,6 +278,7 @@ static int cpufreq_governor_dbs(struct c
 			policy->cpu, policy->max, policy->min,
policy->cur);
 		down(&dbs_sem);
 		cpu_dbs_info[cpu].enable =3D 0;
+		sysfs_remove_group(&policy->kobj, &dbs_attr_group);
 		dbs_enable--;
 		/*
 		 * Stop the timerschedule work, when this governor

------_=_NextPart_001_01C39B31.E5AEDD90
Content-Type: application/octet-stream;
	name="ondemand3.patch"
Content-Transfer-Encoding: base64
Content-Description: ondemand3.patch
Content-Disposition: attachment;
	filename="ondemand3.patch"

ZGlmZiAtcHVyTiBsaW51eC0yLjYuMC10ZXN0OC9kcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcS5jIGxp
bnV4LTIuNi4wLXRlc3Q4LWRicy9kcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcS5jCi0tLSBsaW51eC0y
LjYuMC10ZXN0OC9kcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcS5jCTIwMDMtMTAtMTcgMTQ6NDI6NTYu
MDAwMDAwMDAwIC0wNzAwCisrKyBsaW51eC0yLjYuMC10ZXN0OC1kYnMvZHJpdmVycy9jcHVmcmVx
L2NwdWZyZXEuYwkyMDAzLTEwLTI1IDEzOjQwOjE5LjAwMDAwMDAwMCAtMDcwMApAQCAtOTgsNiAr
OTgsMjQgQEAgc3RhdGljIHZvaWQgY3B1ZnJlcV9jcHVfcHV0KHN0cnVjdCBjcHVmcgogCW1vZHVs
ZV9wdXQoY3B1ZnJlcV9kcml2ZXItPm93bmVyKTsKIH0KIAorCitzdGF0aWMgdW5zaWduZWQgaW50
IGdvdmVybm9yX2dldChzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kgKmRhdGEpCit7CisJaWYgKGNwdWZy
ZXFfZHJpdmVyLT5zZXRwb2xpY3kpCisJCXJldHVybiAxOworCWlmICh0cnlfbW9kdWxlX2dldChk
YXRhLT5nb3Zlcm5vci0+b3duZXIpKQorCQlyZXR1cm4gMTsKKwlyZXR1cm4gMDsKK30KKworCitz
dGF0aWMgdm9pZCBnb3Zlcm5vcl9wdXQoc3RydWN0IGNwdWZyZXFfcG9saWN5ICpkYXRhKQorewor
CWlmIChjcHVmcmVxX2RyaXZlci0+dGFyZ2V0KQorCQltb2R1bGVfcHV0KGRhdGEtPmdvdmVybm9y
LT5vd25lcik7Cit9CisKKwogLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgogICogICAgICAgICAgICAgICAgICAgICAg
ICAgIFNZU0ZTIElOVEVSRkFDRSAgICAgICAgICAgICAgICAgICAgICAgICAgKgogICoqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKi8KQEAgLTMwNSw3ICszMjMsMTAgQEAgc3RhdGljIHNzaXplX3Qgc2hvdyhzdHJ1Y3Qga29i
amVjdCAqIGtvYgogCXBvbGljeSA9IGNwdWZyZXFfY3B1X2dldChwb2xpY3ktPmNwdSk7CiAJaWYg
KCFwb2xpY3kpCiAJCXJldHVybiAtRUlOVkFMOworCWlmICghZ292ZXJub3JfZ2V0KHBvbGljeSkp
CisJCXJldHVybiAtRUlOVkFMOwogCXJldCA9IGZhdHRyLT5zaG93ID8gZmF0dHItPnNob3cocG9s
aWN5LGJ1ZikgOiAwOworCWdvdmVybm9yX3B1dChwb2xpY3kpOwogCWNwdWZyZXFfY3B1X3B1dChw
b2xpY3kpOwogCXJldHVybiByZXQ7CiB9CkBAIC0zMTksNyArMzQwLDEwIEBAIHN0YXRpYyBzc2l6
ZV90IHN0b3JlKHN0cnVjdCBrb2JqZWN0ICoga28KIAlwb2xpY3kgPSBjcHVmcmVxX2NwdV9nZXQo
cG9saWN5LT5jcHUpOwogCWlmICghcG9saWN5KQogCQlyZXR1cm4gLUVJTlZBTDsKKwlpZiAoIWdv
dmVybm9yX2dldChwb2xpY3kpKQorCQlyZXR1cm4gLUVJTlZBTDsKIAlyZXQgPSBmYXR0ci0+c3Rv
cmUgPyBmYXR0ci0+c3RvcmUocG9saWN5LGJ1Zixjb3VudCkgOiAwOworCWdvdmVybm9yX3B1dChw
b2xpY3kpOwogCWNwdWZyZXFfY3B1X3B1dChwb2xpY3kpOwogCXJldHVybiByZXQ7CiB9CmRpZmYg
LXB1ck4gbGludXgtMi42LjAtdGVzdDgvZHJpdmVycy9jcHVmcmVxL2NwdWZyZXFfb25kZW1hbmQu
YyBsaW51eC0yLjYuMC10ZXN0OC1kYnMvZHJpdmVycy9jcHVmcmVxL2NwdWZyZXFfb25kZW1hbmQu
YwotLS0gbGludXgtMi42LjAtdGVzdDgvZHJpdmVycy9jcHVmcmVxL2NwdWZyZXFfb25kZW1hbmQu
YwkyMDAzLTEwLTI1IDEzOjQ1OjU5LjAwMDAwMDAwMCAtMDcwMAorKysgbGludXgtMi42LjAtdGVz
dDgtZGJzL2RyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxX29uZGVtYW5kLmMJMjAwMy0xMC0yNSAxMzo0
NDo0MC4wMDAwMDAwMDAgLTA3MDAKQEAgLTczLDYgKzczLDEwNiBAQCBzdHJ1Y3QgZGJzX3R1bmVy
cyBkYnNfdHVuZXJzX2lucyA9IHsKIAkuZG93bl90aHJlc2hvbGQgPSBERUZfRlJFUVVFTkNZX0RP
V05fVEhSRVNIT0xELAogfTsKIAorLyoqKioqKioqKioqKioqKioqKioqKioqKioqIHN5c2ZzIGlu
dGVyZmFjZSAqKioqKioqKioqKioqKioqKioqKioqKiovCitzdGF0aWMgc3NpemVfdCBzaG93X2N1
cnJlbnRfZnJlcShzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kgKnBvbGljeSwgY2hhciAqYnVmKQorewor
CXJldHVybiBzcHJpbnRmIChidWYsICIldVxuIiwgcG9saWN5LT5jdXIpOworfQorCitzdGF0aWMg
c3RydWN0IGZyZXFfYXR0ciBjdXJyZW50X2ZyZXEgPSB7CisJLmF0dHIgPSB7IC5uYW1lID0gImN1
cnJlbnRfZnJlcSIsIC5tb2RlID0gMDQ0NCB9LAorCS5zaG93ID0gc2hvd19jdXJyZW50X2ZyZXEs
Cit9OworCisvKiBjcHVmcmVxX29uZGVtYW5kIEdvdmVybm9yIFR1bmFibGVzICovCisjZGVmaW5l
IHNob3dfb25lKGZpbGVfbmFtZSwgb2JqZWN0KQkJCQkJXAorc3RhdGljIHNzaXplX3Qgc2hvd18j
I2ZpbGVfbmFtZQkJCQkJCVwKKyhzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kgKnVudXNlZCwgY2hhciAq
YnVmKQkJCQlcCit7CQkJCQkJCQkJXAorCXJldHVybiBzcHJpbnRmKGJ1ZiwgIiV1XG4iLCBkYnNf
dHVuZXJzX2lucy5vYmplY3QpOwkJXAorfQorc2hvd19vbmUoc2FtcGxpbmdfcmF0ZSwgc2FtcGxp
bmdfcmF0ZSk7CitzaG93X29uZSh1cF90aHJlc2hvbGQsIHVwX3RocmVzaG9sZCk7CitzaG93X29u
ZShkb3duX3RocmVzaG9sZCwgZG93bl90aHJlc2hvbGQpOworCitzdGF0aWMgc3NpemVfdCBzdG9y
ZV9zYW1wbGluZ19yYXRlKHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqdW51c2VkLCAKKwkJY29uc3Qg
Y2hhciAqYnVmLCBzaXplX3QgY291bnQpCit7CisJdW5zaWduZWQgaW50IGlucHV0OworCWludCBy
ZXQ7CisJcmV0ID0gc3NjYW5mIChidWYsICIldSIsICZpbnB1dCk7CisJZG93bigmZGJzX3NlbSk7
CisJaWYgKHJldCAhPSAxIHx8IGlucHV0ID4gTUFYX1NBTVBMSU5HX1JBVEUgfHwgaW5wdXQgPCBN
SU5fU0FNUExJTkdfUkFURSkKKwkJZ290byBvdXQ7CisKKwlkYnNfdHVuZXJzX2lucy5zYW1wbGlu
Z19yYXRlID0gaW5wdXQ7CitvdXQ6CisJdXAoJmRic19zZW0pOworCXJldHVybiBjb3VudDsKK30K
Kworc3RhdGljIHNzaXplX3Qgc3RvcmVfdXBfdGhyZXNob2xkKHN0cnVjdCBjcHVmcmVxX3BvbGlj
eSAqdW51c2VkLCAKKwkJY29uc3QgY2hhciAqYnVmLCBzaXplX3QgY291bnQpCit7CisJdW5zaWdu
ZWQgaW50IGlucHV0OworCWludCByZXQ7CisJcmV0ID0gc3NjYW5mIChidWYsICIldSIsICZpbnB1
dCk7CisJZG93bigmZGJzX3NlbSk7CisJaWYgKHJldCAhPSAxIHx8IGlucHV0ID4gTUFYX0ZSRVFV
RU5DWV9VUF9USFJFU0hPTEQgfHwgCisJCQlpbnB1dCA8IE1JTl9GUkVRVUVOQ1lfVVBfVEhSRVNI
T0xEIHx8CisJCQlpbnB1dCA8PSBkYnNfdHVuZXJzX2lucy5kb3duX3RocmVzaG9sZCkKKwkJZ290
byBvdXQ7CisKKwlkYnNfdHVuZXJzX2lucy51cF90aHJlc2hvbGQgPSBpbnB1dDsKK291dDoKKwl1
cCgmZGJzX3NlbSk7CisJcmV0dXJuIGNvdW50OworfQorCitzdGF0aWMgc3NpemVfdCBzdG9yZV9k
b3duX3RocmVzaG9sZChzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kgKnVudXNlZCwgCisJCWNvbnN0IGNo
YXIgKmJ1Ziwgc2l6ZV90IGNvdW50KQoreworCXVuc2lnbmVkIGludCBpbnB1dDsKKwlpbnQgcmV0
OworCXJldCA9IHNzY2FuZiAoYnVmLCAiJXUiLCAmaW5wdXQpOworCWRvd24oJmRic19zZW0pOwor
CWlmIChyZXQgIT0gMSB8fCBpbnB1dCA+IE1BWF9GUkVRVUVOQ1lfRE9XTl9USFJFU0hPTEQgfHwg
CisJCQlpbnB1dCA8IE1JTl9GUkVRVUVOQ1lfRE9XTl9USFJFU0hPTEQgfHwKKwkJCWlucHV0ID49
IGRic190dW5lcnNfaW5zLnVwX3RocmVzaG9sZCkKKwkJZ290byBvdXQ7CisKKwlkYnNfdHVuZXJz
X2lucy5kb3duX3RocmVzaG9sZCA9IGlucHV0Oworb3V0OgorCXVwKCZkYnNfc2VtKTsKKwlyZXR1
cm4gY291bnQ7Cit9CisKKyNkZWZpbmUgZGVmaW5lX29uZV9ydyhfbmFtZSkgCQkJCQlcCitzdGF0
aWMgc3RydWN0IGZyZXFfYXR0ciBfbmFtZSA9IHsgCQkJCQlcCisJLmF0dHIgPSB7IC5uYW1lID0g
X19zdHJpbmdpZnkoX25hbWUpLCAubW9kZSA9IDA2NDQgfSwgCVwKKwkuc2hvdyA9IHNob3dfIyNf
bmFtZSwgCQkJCQlcCisJLnN0b3JlID0gc3RvcmVfIyNfbmFtZSwgCQkJCVwKK30KKworZGVmaW5l
X29uZV9ydyhzYW1wbGluZ19yYXRlKTsKK2RlZmluZV9vbmVfcncodXBfdGhyZXNob2xkKTsKK2Rl
ZmluZV9vbmVfcncoZG93bl90aHJlc2hvbGQpOworCitzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAq
IGRic19hdHRyaWJ1dGVzW10gPSB7CisJJmN1cnJlbnRfZnJlcS5hdHRyLAorCSZzYW1wbGluZ19y
YXRlLmF0dHIsCisJJnVwX3RocmVzaG9sZC5hdHRyLAorCSZkb3duX3RocmVzaG9sZC5hdHRyLAor
CU5VTEwKK307CisKK3N0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlX2dyb3VwIGRic19hdHRyX2dyb3Vw
ID0geworCS5hdHRycyA9IGRic19hdHRyaWJ1dGVzLAorCS5uYW1lID0gIm9uZGVtYW5kIiwKK307
CisKKy8qKioqKioqKioqKioqKioqKioqKioqKioqKiBzeXNmcyBlbmQgKioqKioqKioqKioqKioq
KioqKioqKioqLworCiBzdGF0aWMgdm9pZCBkYnNfY2hlY2tfY3B1KGludCBjcHUpCiB7CiAJdW5z
aWduZWQgaW50IGlkbGVfdGlja3MsIHVwX2lkbGVfdGlja3MsIGRvd25faWRsZV90aWNrczsKQEAg
LTE2MCw2ICsyNjAsNyBAQCBzdGF0aWMgaW50IGNwdWZyZXFfZ292ZXJub3JfZGJzKHN0cnVjdCBj
CiAJCWNwdV9kYnNfaW5mb1tjcHVdLnByZXZfY3B1X2lkbGUgPSAKIAkJCQlrc3RhdF9jcHUoY3B1
KS5jcHVzdGF0LmlkbGU7CiAJCWNwdV9kYnNfaW5mb1tjcHVdLmVuYWJsZSA9IDE7CisJCXN5c2Zz
X2NyZWF0ZV9ncm91cCgmcG9saWN5LT5rb2JqLCAmZGJzX2F0dHJfZ3JvdXApOwogCQlkYnNfZW5h
YmxlKys7CiAJCS8qCiAJCSAqIFN0YXJ0IHRoZSB0aW1lcnNjaGVkdWxlIHdvcmssIHdoZW4gdGhp
cyBnb3Zlcm5vcgpAQCAtMTc3LDYgKzI3OCw3IEBAIHN0YXRpYyBpbnQgY3B1ZnJlcV9nb3Zlcm5v
cl9kYnMoc3RydWN0IGMKIAkJCXBvbGljeS0+Y3B1LCBwb2xpY3ktPm1heCwgcG9saWN5LT5taW4s
IHBvbGljeS0+Y3VyKTsKIAkJZG93bigmZGJzX3NlbSk7CiAJCWNwdV9kYnNfaW5mb1tjcHVdLmVu
YWJsZSA9IDA7CisJCXN5c2ZzX3JlbW92ZV9ncm91cCgmcG9saWN5LT5rb2JqLCAmZGJzX2F0dHJf
Z3JvdXApOwogCQlkYnNfZW5hYmxlLS07CiAJCS8qCiAJCSAqIFN0b3AgdGhlIHRpbWVyc2NoZWR1
bGUgd29yaywgd2hlbiB0aGlzIGdvdmVybm9yCg==

------_=_NextPart_001_01C39B31.E5AEDD90--
