Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbTJUC6M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 22:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbTJUC6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 22:58:12 -0400
Received: from fmr05.intel.com ([134.134.136.6]:8883 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S262775AbTJUC4j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 22:56:39 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C3977E.EF61E970"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: [PATCH] 2/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Date: Mon, 20 Oct 2003 19:56:33 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB60077913@scsmsx403.sc.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Thread-Index: AcOXfu4liQufStvtSCaOrp2aomGg9Q==
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <cpufreq@www.linux.org.uk>, <linux-kernel@vger.kernel.org>,
       "linux-acpi" <linux-acpi@intel.com>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Dominik Brodowski" <linux@brodo.de>
X-OriginalArrivalTime: 21 Oct 2003 02:56:33.0840 (UTC) FILETIME=[EF9FB300:01C3977E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C3977E.EF61E970
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Patch 2/3: Introduce HT-synchronization in the ACPI P-state=20
Driver, to take care of shared CPU frequency between HT siblings.

diffstat dbs2.patch=20
arch/i386/kernel/cpu/cpufreq/acpi.c |  169
++++++++++++++++++++++++++++++++++--
include/acpi/processor.h            |   15 +++
2 files changed, 178 insertions(+), 6 deletions(-)


diff -purN linux-2.6.0-test7/arch/i386/kernel/cpu/cpufreq/acpi.c
linux-2.6.0-test7-dbs/arch/i386/kernel/cpu/cpufreq/acpi.c
--- linux-2.6.0-test7/arch/i386/kernel/cpu/cpufreq/acpi.c
2003-10-20 13:31:10.000000000 -0700
+++ linux-2.6.0-test7-dbs/arch/i386/kernel/cpu/cpufreq/acpi.c
2003-10-20 13:29:41.000000000 -0700
@@ -34,6 +34,7 @@
 #include <asm/io.h>
 #include <asm/delay.h>
 #include <asm/uaccess.h>
+#include <linux/sem.h>
=20
 #include <linux/acpi.h>
 #include <acpi/processor.h>
@@ -362,7 +363,8 @@ acpi_processor_set_performance (
 	cpufreq_freqs.new =3D perf->states[state].core_frequency * 1000;
=20
 	/* notify cpufreq */
-	cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_PRECHANGE);
+	perf->domainp->cpufreq_notify_transition_ptr(
+			&cpufreq_freqs, CPUFREQ_PRECHANGE);
=20
 	/*
 	 * First we write the target state's 'control' value to the
@@ -390,14 +392,17 @@ acpi_processor_set_performance (
 	value =3D param.retval;
=20
 	/* notify cpufreq */
-	cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_POSTCHANGE);
+	perf->domainp->cpufreq_notify_transition_ptr(
+			&cpufreq_freqs, CPUFREQ_POSTCHANGE);
=20
 	if (value !=3D (u16) perf->states[state].status) {
 		unsigned int tmp =3D cpufreq_freqs.new;
 		cpufreq_freqs.new =3D cpufreq_freqs.old;
 		cpufreq_freqs.old =3D tmp;
-		cpufreq_notify_transition(&cpufreq_freqs,
CPUFREQ_PRECHANGE);
-		cpufreq_notify_transition(&cpufreq_freqs,
CPUFREQ_POSTCHANGE);
+		perf->domainp->cpufreq_notify_transition_ptr(
+				&cpufreq_freqs, CPUFREQ_PRECHANGE);
+		perf->domainp->cpufreq_notify_transition_ptr(
+				&cpufreq_freqs, CPUFREQ_POSTCHANGE);
 		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Transition failed\n"));
 		return_VALUE(-ENODEV);
 	}
@@ -568,7 +573,8 @@ acpi_cpufreq_target (
 	if (result)
 		return_VALUE(result);
=20
-	result =3D acpi_processor_set_performance (perf, next_state);
+	result =3D perf->domainp->acpi_processor_set_performance_ptr(
+			perf, next_state);
=20
 	return_VALUE(result);
 }
@@ -630,6 +636,144 @@ acpi_processor_get_performance_info (
 	return_VALUE(0);
 }
=20
+static struct acpi_processor_domain acpi_processor_domain_def =3D {
+	.sem =3D __MUTEX_INITIALIZER(acpi_processor_domain_def.sem),
+	.ref_cnt =3D 0,
+	.acpi_processor_set_performance_ptr =3D
acpi_processor_set_performance,
+	.cpufreq_notify_transition_ptr =3D cpufreq_notify_transition,
+};
+
+#ifdef CONFIG_X86_HT
+static void cpufreq_notify_transition_ht(struct cpufreq_freqs
*cpufreq_freqs, unsigned int state)
+{
+	unsigned int cpu =3D cpufreq_freqs->cpu;
+	ACPI_FUNCTION_TRACE("cpufreq_notify_transition_ht");
+	cpufreq_notify_transition(cpufreq_freqs, state);
+	cpufreq_freqs->cpu =3D cpu_sibling_map[cpu];
+	cpufreq_notify_transition(cpufreq_freqs, state);
+	cpufreq_freqs->cpu =3D cpu;
+	return_VOID;
+}
+
+static int acpi_processor_set_performance_ht(struct
acpi_processor_performance *perf, int state)
+{
+	struct acpi_processor_domain 	*domainp =3D perf->domainp;
+	int		result =3D 0;
+	int 		i;
+	int 		lo_state; /* highest freq */
+
+	ACPI_FUNCTION_TRACE("acpi_processor_set_performance_ht");
+	down(&(domainp->sem));
+	/*
+	 * Transition into new state, only if it is the lowest among
+	 * all sibling requested states.
+	 * semaphore below should be held across the package.
+	 */
+	perf->requested_state =3D state;
+	lo_state =3D state;
+	for (i =3D 0; i < domainp->ref_cnt; i++) {
+		if (performance[domainp->members[i]].requested_state <
lo_state)
+			lo_state =3D=20
+
performance[domainp->members[i]].requested_state;
+	}
+
+	if (lo_state =3D=3D domainp->cur_state) {
+		up(&(domainp->sem));
+		return_VALUE(0);
+	}
+
+	result =3D acpi_processor_set_performance(perf, lo_state);
+	if (result =3D=3D 0) {
+		domainp->cur_state =3D lo_state;
+		for (i =3D 0; i < domainp->ref_cnt; i++)
+			performance[domainp->members[i]].state =3D
lo_state;
+	}
+
+	up(&(domainp->sem));
+	return_VALUE(result);
+}
+
+static int
+acpi_processor_domain_ht_init(
+		struct acpi_processor_performance *perf, int cpu)
+{
+	int sibling_cpu =3D cpu_sibling_map[cpu];
+	struct acpi_processor_domain *domainp;
+
+	ACPI_FUNCTION_TRACE("acpi_processor_domain_ht_init");
+	if (cpu < sibling_cpu) {
+		domainp =3D kmalloc(sizeof(struct acpi_processor_domain),
+				GFP_KERNEL);
+		if (domainp =3D=3D NULL)
+			return_VALUE(-ENOMEM);
+
+		init_MUTEX(&(domainp->sem));
+		domainp->acpi_processor_set_performance_ptr =3D=20
+				acpi_processor_set_performance_ht;
+		domainp->cpufreq_notify_transition_ptr =3D=20
+				cpufreq_notify_transition_ht;
+		domainp->cur_state =3D 0;
+		domainp->ref_cnt =3D 0;
+		domainp->members[domainp->ref_cnt] =3D cpu;
+		domainp->ref_cnt++;
+		perf[cpu].domainp =3D domainp;
+	} else {
+		perf[cpu].domainp =3D perf[sibling_cpu].domainp;
+		domainp =3D perf[cpu].domainp;
+		if (domainp->ref_cnt =3D=3D ACPI_MAX_CPUS_PER_DOMAIN) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				"Only %d CPUS per domain is
supported\n",
+				ACPI_MAX_CPUS_PER_DOMAIN));
+			return_VALUE(-1);
+		}
+		domainp->members[domainp->ref_cnt] =3D cpu;
+		domainp->ref_cnt++;
+	}
+	return_VALUE(0);
+}
+#endif /* CONFIG_X86_HT */
+
+static int
+acpi_processor_domain_init(struct acpi_processor_performance *perf, int
cpu)
+{
+
+#ifdef CONFIG_X86_HT
+	int ht_present =3D ((cpu_has_ht) && (smp_num_siblings =3D=3D 2));
+#endif
+
+	ACPI_FUNCTION_TRACE("acpi_processor_domain_init");
+
+#ifdef CONFIG_X86_HT
+	if (ht_present) {
+		int retval;
+		retval =3D acpi_processor_domain_ht_init(perf, cpu);
+		return_VALUE(retval);
+	}
+	/* FALLTHRU and use default domain structure */
+#endif
+	perf[cpu].domainp =3D &acpi_processor_domain_def;
+	return_VALUE(0);
+}
+
+static void
+acpi_processor_domain_exit(struct acpi_processor_performance *perf, int
cpu)
+{
+	ACPI_FUNCTION_TRACE("acpi_processor_domain_exit");
+#ifdef CONFIG_X86_HT
+	if (!perf[cpu].domainp)
+		return_VOID;
+
+	if (perf[cpu].domainp =3D=3D &acpi_processor_domain_def)
+		return_VOID;
+
+	perf[cpu].domainp->ref_cnt--;
+	if (perf[cpu].domainp->ref_cnt =3D=3D 0) {
+		kfree(perf[cpu].domainp);
+		perf[cpu].domainp =3D NULL;
+	}
+#endif /* CONFIG_X86_HT */
+	return_VOID;
+}
=20
 static int
 acpi_cpufreq_cpu_init (
@@ -742,8 +886,13 @@ acpi_cpufreq_init (void)
=20
 	/* register struct acpi_processor_performance performance */
 	for (i=3D0; i<NR_CPUS; i++) {
-		if (cpu_online(i))
+		if (cpu_online(i)) {
=20
acpi_processor_register_performance(&performance[i], &pr, i);
+			if (acpi_processor_domain_init(performance, i) <
0) {
+				result =3D -ENOMEM;
+				goto err0;
+			}
+		}
 	}
=20
 	/* initialize  */
@@ -804,6 +953,10 @@ acpi_cpufreq_init (void)
 	cpufreq_unregister_driver(&acpi_cpufreq_driver);
 =09
  err0:
+	for (i =3D 0; i < NR_CPUS; i++)
+		if (cpu_online(i))
+			acpi_processor_domain_exit(performance, i);
+
 	/* unregister struct acpi_processor_performance performance */
 	for (i=3D0; i<NR_CPUS; i++) {
 		if (performance[i].pr) {
@@ -842,6 +995,10 @@ acpi_cpufreq_exit (void)
 		}
 	}
=20
+	for (i =3D 0; i < NR_CPUS; i++)
+		if (cpu_online(i))
+			acpi_processor_domain_exit(performance, i);
+
 	kfree(performance);
=20
 	return_VOID;
diff -purN linux-2.6.0-test7/include/acpi/processor.h
linux-2.6.0-test7-dbs/include/acpi/processor.h
--- linux-2.6.0-test7/include/acpi/processor.h	2003-10-20
13:31:10.000000000 -0700
+++ linux-2.6.0-test7-dbs/include/acpi/processor.h	2003-10-20
13:08:11.000000000 -0700
@@ -2,6 +2,7 @@
 #define __ACPI_PROCESSOR_H
=20
 #include <linux/kernel.h>
+#include <linux/sem.h>
=20
 #define ACPI_PROCESSOR_BUSY_METRIC	10
=20
@@ -74,6 +75,8 @@ struct acpi_processor_performance {
 	u16			status_register;
 	int			state_count;
 	int			space_id;
+	int			requested_state;
+	struct acpi_processor_domain *domainp;
 	struct acpi_processor_px states[ACPI_PROCESSOR_MAX_PERFORMANCE];
 	struct cpufreq_frequency_table
freq_table[ACPI_PROCESSOR_MAX_PERFORMANCE];
 	struct acpi_processor   *pr;
@@ -132,6 +135,18 @@ struct acpi_processor {
 	struct acpi_processor_limit limit;
 };
=20
+#define ACPI_MAX_CPUS_PER_DOMAIN 	2
+struct acpi_processor_domain {
+	/* Domain wide data */
+	struct semaphore	sem;
+	int 			cur_state;
+	int			ref_cnt;
+	int 			members[ACPI_MAX_CPUS_PER_DOMAIN];
+	/* Domain wide function pointers */
+	int (*acpi_processor_set_performance_ptr)(struct
acpi_processor_performance *perf, int state);
+	void (*cpufreq_notify_transition_ptr)(struct cpufreq_freqs
*cpufreq_freqs, unsigned int state);
+};
+
 extern int acpi_processor_get_platform_limit (
 	struct acpi_processor*	pr);
 extern int acpi_processor_register_performance (

------_=_NextPart_001_01C3977E.EF61E970
Content-Type: application/octet-stream;
	name="dbs2.patch"
Content-Transfer-Encoding: base64
Content-Description: dbs2.patch
Content-Disposition: attachment;
	filename="dbs2.patch"

ZGlmZiAtcHVyTiBsaW51eC0yLjYuMC10ZXN0Ny9hcmNoL2kzODYva2VybmVsL2NwdS9jcHVmcmVx
L2FjcGkuYyBsaW51eC0yLjYuMC10ZXN0Ny1kYnMvYXJjaC9pMzg2L2tlcm5lbC9jcHUvY3B1ZnJl
cS9hY3BpLmMKLS0tIGxpbnV4LTIuNi4wLXRlc3Q3L2FyY2gvaTM4Ni9rZXJuZWwvY3B1L2NwdWZy
ZXEvYWNwaS5jCTIwMDMtMTAtMjAgMTM6MzE6MTAuMDAwMDAwMDAwIC0wNzAwCisrKyBsaW51eC0y
LjYuMC10ZXN0Ny1kYnMvYXJjaC9pMzg2L2tlcm5lbC9jcHUvY3B1ZnJlcS9hY3BpLmMJMjAwMy0x
MC0yMCAxMzoyOTo0MS4wMDAwMDAwMDAgLTA3MDAKQEAgLTM0LDYgKzM0LDcgQEAKICNpbmNsdWRl
IDxhc20vaW8uaD4KICNpbmNsdWRlIDxhc20vZGVsYXkuaD4KICNpbmNsdWRlIDxhc20vdWFjY2Vz
cy5oPgorI2luY2x1ZGUgPGxpbnV4L3NlbS5oPgogCiAjaW5jbHVkZSA8bGludXgvYWNwaS5oPgog
I2luY2x1ZGUgPGFjcGkvcHJvY2Vzc29yLmg+CkBAIC0zNjIsNyArMzYzLDggQEAgYWNwaV9wcm9j
ZXNzb3Jfc2V0X3BlcmZvcm1hbmNlICgKIAljcHVmcmVxX2ZyZXFzLm5ldyA9IHBlcmYtPnN0YXRl
c1tzdGF0ZV0uY29yZV9mcmVxdWVuY3kgKiAxMDAwOwogCiAJLyogbm90aWZ5IGNwdWZyZXEgKi8K
LQljcHVmcmVxX25vdGlmeV90cmFuc2l0aW9uKCZjcHVmcmVxX2ZyZXFzLCBDUFVGUkVRX1BSRUNI
QU5HRSk7CisJcGVyZi0+ZG9tYWlucC0+Y3B1ZnJlcV9ub3RpZnlfdHJhbnNpdGlvbl9wdHIoCisJ
CQkmY3B1ZnJlcV9mcmVxcywgQ1BVRlJFUV9QUkVDSEFOR0UpOwogCiAJLyoKIAkgKiBGaXJzdCB3
ZSB3cml0ZSB0aGUgdGFyZ2V0IHN0YXRlJ3MgJ2NvbnRyb2wnIHZhbHVlIHRvIHRoZQpAQCAtMzkw
LDE0ICszOTIsMTcgQEAgYWNwaV9wcm9jZXNzb3Jfc2V0X3BlcmZvcm1hbmNlICgKIAl2YWx1ZSA9
IHBhcmFtLnJldHZhbDsKIAogCS8qIG5vdGlmeSBjcHVmcmVxICovCi0JY3B1ZnJlcV9ub3RpZnlf
dHJhbnNpdGlvbigmY3B1ZnJlcV9mcmVxcywgQ1BVRlJFUV9QT1NUQ0hBTkdFKTsKKwlwZXJmLT5k
b21haW5wLT5jcHVmcmVxX25vdGlmeV90cmFuc2l0aW9uX3B0cigKKwkJCSZjcHVmcmVxX2ZyZXFz
LCBDUFVGUkVRX1BPU1RDSEFOR0UpOwogCiAJaWYgKHZhbHVlICE9ICh1MTYpIHBlcmYtPnN0YXRl
c1tzdGF0ZV0uc3RhdHVzKSB7CiAJCXVuc2lnbmVkIGludCB0bXAgPSBjcHVmcmVxX2ZyZXFzLm5l
dzsKIAkJY3B1ZnJlcV9mcmVxcy5uZXcgPSBjcHVmcmVxX2ZyZXFzLm9sZDsKIAkJY3B1ZnJlcV9m
cmVxcy5vbGQgPSB0bXA7Ci0JCWNwdWZyZXFfbm90aWZ5X3RyYW5zaXRpb24oJmNwdWZyZXFfZnJl
cXMsIENQVUZSRVFfUFJFQ0hBTkdFKTsKLQkJY3B1ZnJlcV9ub3RpZnlfdHJhbnNpdGlvbigmY3B1
ZnJlcV9mcmVxcywgQ1BVRlJFUV9QT1NUQ0hBTkdFKTsKKwkJcGVyZi0+ZG9tYWlucC0+Y3B1ZnJl
cV9ub3RpZnlfdHJhbnNpdGlvbl9wdHIoCisJCQkJJmNwdWZyZXFfZnJlcXMsIENQVUZSRVFfUFJF
Q0hBTkdFKTsKKwkJcGVyZi0+ZG9tYWlucC0+Y3B1ZnJlcV9ub3RpZnlfdHJhbnNpdGlvbl9wdHIo
CisJCQkJJmNwdWZyZXFfZnJlcXMsIENQVUZSRVFfUE9TVENIQU5HRSk7CiAJCUFDUElfREVCVUdf
UFJJTlQoKEFDUElfREJfV0FSTiwgIlRyYW5zaXRpb24gZmFpbGVkXG4iKSk7CiAJCXJldHVybl9W
QUxVRSgtRU5PREVWKTsKIAl9CkBAIC01NjgsNyArNTczLDggQEAgYWNwaV9jcHVmcmVxX3Rhcmdl
dCAoCiAJaWYgKHJlc3VsdCkKIAkJcmV0dXJuX1ZBTFVFKHJlc3VsdCk7CiAKLQlyZXN1bHQgPSBh
Y3BpX3Byb2Nlc3Nvcl9zZXRfcGVyZm9ybWFuY2UgKHBlcmYsIG5leHRfc3RhdGUpOworCXJlc3Vs
dCA9IHBlcmYtPmRvbWFpbnAtPmFjcGlfcHJvY2Vzc29yX3NldF9wZXJmb3JtYW5jZV9wdHIoCisJ
CQlwZXJmLCBuZXh0X3N0YXRlKTsKIAogCXJldHVybl9WQUxVRShyZXN1bHQpOwogfQpAQCAtNjMw
LDYgKzYzNiwxNDQgQEAgYWNwaV9wcm9jZXNzb3JfZ2V0X3BlcmZvcm1hbmNlX2luZm8gKAogCXJl
dHVybl9WQUxVRSgwKTsKIH0KIAorc3RhdGljIHN0cnVjdCBhY3BpX3Byb2Nlc3Nvcl9kb21haW4g
YWNwaV9wcm9jZXNzb3JfZG9tYWluX2RlZiA9IHsKKwkuc2VtID0gX19NVVRFWF9JTklUSUFMSVpF
UihhY3BpX3Byb2Nlc3Nvcl9kb21haW5fZGVmLnNlbSksCisJLnJlZl9jbnQgPSAwLAorCS5hY3Bp
X3Byb2Nlc3Nvcl9zZXRfcGVyZm9ybWFuY2VfcHRyID0gYWNwaV9wcm9jZXNzb3Jfc2V0X3BlcmZv
cm1hbmNlLAorCS5jcHVmcmVxX25vdGlmeV90cmFuc2l0aW9uX3B0ciA9IGNwdWZyZXFfbm90aWZ5
X3RyYW5zaXRpb24sCit9OworCisjaWZkZWYgQ09ORklHX1g4Nl9IVAorc3RhdGljIHZvaWQgY3B1
ZnJlcV9ub3RpZnlfdHJhbnNpdGlvbl9odChzdHJ1Y3QgY3B1ZnJlcV9mcmVxcyAqY3B1ZnJlcV9m
cmVxcywgdW5zaWduZWQgaW50IHN0YXRlKQoreworCXVuc2lnbmVkIGludCBjcHUgPSBjcHVmcmVx
X2ZyZXFzLT5jcHU7CisJQUNQSV9GVU5DVElPTl9UUkFDRSgiY3B1ZnJlcV9ub3RpZnlfdHJhbnNp
dGlvbl9odCIpOworCWNwdWZyZXFfbm90aWZ5X3RyYW5zaXRpb24oY3B1ZnJlcV9mcmVxcywgc3Rh
dGUpOworCWNwdWZyZXFfZnJlcXMtPmNwdSA9IGNwdV9zaWJsaW5nX21hcFtjcHVdOworCWNwdWZy
ZXFfbm90aWZ5X3RyYW5zaXRpb24oY3B1ZnJlcV9mcmVxcywgc3RhdGUpOworCWNwdWZyZXFfZnJl
cXMtPmNwdSA9IGNwdTsKKwlyZXR1cm5fVk9JRDsKK30KKworc3RhdGljIGludCBhY3BpX3Byb2Nl
c3Nvcl9zZXRfcGVyZm9ybWFuY2VfaHQoc3RydWN0IGFjcGlfcHJvY2Vzc29yX3BlcmZvcm1hbmNl
ICpwZXJmLCBpbnQgc3RhdGUpCit7CisJc3RydWN0IGFjcGlfcHJvY2Vzc29yX2RvbWFpbiAJKmRv
bWFpbnAgPSBwZXJmLT5kb21haW5wOworCWludAkJcmVzdWx0ID0gMDsKKwlpbnQgCQlpOworCWlu
dCAJCWxvX3N0YXRlOyAvKiBoaWdoZXN0IGZyZXEgKi8KKworCUFDUElfRlVOQ1RJT05fVFJBQ0Uo
ImFjcGlfcHJvY2Vzc29yX3NldF9wZXJmb3JtYW5jZV9odCIpOworCWRvd24oJihkb21haW5wLT5z
ZW0pKTsKKwkvKgorCSAqIFRyYW5zaXRpb24gaW50byBuZXcgc3RhdGUsIG9ubHkgaWYgaXQgaXMg
dGhlIGxvd2VzdCBhbW9uZworCSAqIGFsbCBzaWJsaW5nIHJlcXVlc3RlZCBzdGF0ZXMuCisJICog
c2VtYXBob3JlIGJlbG93IHNob3VsZCBiZSBoZWxkIGFjcm9zcyB0aGUgcGFja2FnZS4KKwkgKi8K
KwlwZXJmLT5yZXF1ZXN0ZWRfc3RhdGUgPSBzdGF0ZTsKKwlsb19zdGF0ZSA9IHN0YXRlOworCWZv
ciAoaSA9IDA7IGkgPCBkb21haW5wLT5yZWZfY250OyBpKyspIHsKKwkJaWYgKHBlcmZvcm1hbmNl
W2RvbWFpbnAtPm1lbWJlcnNbaV1dLnJlcXVlc3RlZF9zdGF0ZSA8IGxvX3N0YXRlKQorCQkJbG9f
c3RhdGUgPSAKKwkJCSAgICBwZXJmb3JtYW5jZVtkb21haW5wLT5tZW1iZXJzW2ldXS5yZXF1ZXN0
ZWRfc3RhdGU7CisJfQorCisJaWYgKGxvX3N0YXRlID09IGRvbWFpbnAtPmN1cl9zdGF0ZSkgewor
CQl1cCgmKGRvbWFpbnAtPnNlbSkpOworCQlyZXR1cm5fVkFMVUUoMCk7CisJfQorCisJcmVzdWx0
ID0gYWNwaV9wcm9jZXNzb3Jfc2V0X3BlcmZvcm1hbmNlKHBlcmYsIGxvX3N0YXRlKTsKKwlpZiAo
cmVzdWx0ID09IDApIHsKKwkJZG9tYWlucC0+Y3VyX3N0YXRlID0gbG9fc3RhdGU7CisJCWZvciAo
aSA9IDA7IGkgPCBkb21haW5wLT5yZWZfY250OyBpKyspCisJCQlwZXJmb3JtYW5jZVtkb21haW5w
LT5tZW1iZXJzW2ldXS5zdGF0ZSA9IGxvX3N0YXRlOworCX0KKworCXVwKCYoZG9tYWlucC0+c2Vt
KSk7CisJcmV0dXJuX1ZBTFVFKHJlc3VsdCk7Cit9CisKK3N0YXRpYyBpbnQKK2FjcGlfcHJvY2Vz
c29yX2RvbWFpbl9odF9pbml0KAorCQlzdHJ1Y3QgYWNwaV9wcm9jZXNzb3JfcGVyZm9ybWFuY2Ug
KnBlcmYsIGludCBjcHUpCit7CisJaW50IHNpYmxpbmdfY3B1ID0gY3B1X3NpYmxpbmdfbWFwW2Nw
dV07CisJc3RydWN0IGFjcGlfcHJvY2Vzc29yX2RvbWFpbiAqZG9tYWlucDsKKworCUFDUElfRlVO
Q1RJT05fVFJBQ0UoImFjcGlfcHJvY2Vzc29yX2RvbWFpbl9odF9pbml0Iik7CisJaWYgKGNwdSA8
IHNpYmxpbmdfY3B1KSB7CisJCWRvbWFpbnAgPSBrbWFsbG9jKHNpemVvZihzdHJ1Y3QgYWNwaV9w
cm9jZXNzb3JfZG9tYWluKSwKKwkJCQlHRlBfS0VSTkVMKTsKKwkJaWYgKGRvbWFpbnAgPT0gTlVM
TCkKKwkJCXJldHVybl9WQUxVRSgtRU5PTUVNKTsKKworCQlpbml0X01VVEVYKCYoZG9tYWlucC0+
c2VtKSk7CisJCWRvbWFpbnAtPmFjcGlfcHJvY2Vzc29yX3NldF9wZXJmb3JtYW5jZV9wdHIgPSAK
KwkJCQlhY3BpX3Byb2Nlc3Nvcl9zZXRfcGVyZm9ybWFuY2VfaHQ7CisJCWRvbWFpbnAtPmNwdWZy
ZXFfbm90aWZ5X3RyYW5zaXRpb25fcHRyID0gCisJCQkJY3B1ZnJlcV9ub3RpZnlfdHJhbnNpdGlv
bl9odDsKKwkJZG9tYWlucC0+Y3VyX3N0YXRlID0gMDsKKwkJZG9tYWlucC0+cmVmX2NudCA9IDA7
CisJCWRvbWFpbnAtPm1lbWJlcnNbZG9tYWlucC0+cmVmX2NudF0gPSBjcHU7CisJCWRvbWFpbnAt
PnJlZl9jbnQrKzsKKwkJcGVyZltjcHVdLmRvbWFpbnAgPSBkb21haW5wOworCX0gZWxzZSB7CisJ
CXBlcmZbY3B1XS5kb21haW5wID0gcGVyZltzaWJsaW5nX2NwdV0uZG9tYWlucDsKKwkJZG9tYWlu
cCA9IHBlcmZbY3B1XS5kb21haW5wOworCQlpZiAoZG9tYWlucC0+cmVmX2NudCA9PSBBQ1BJX01B
WF9DUFVTX1BFUl9ET01BSU4pIHsKKwkJCUFDUElfREVCVUdfUFJJTlQoKEFDUElfREJfRVJST1Is
CisJCQkJIk9ubHkgJWQgQ1BVUyBwZXIgZG9tYWluIGlzIHN1cHBvcnRlZFxuIiwKKwkJCQlBQ1BJ
X01BWF9DUFVTX1BFUl9ET01BSU4pKTsKKwkJCXJldHVybl9WQUxVRSgtMSk7CisJCX0KKwkJZG9t
YWlucC0+bWVtYmVyc1tkb21haW5wLT5yZWZfY250XSA9IGNwdTsKKwkJZG9tYWlucC0+cmVmX2Nu
dCsrOworCX0KKwlyZXR1cm5fVkFMVUUoMCk7Cit9CisjZW5kaWYgLyogQ09ORklHX1g4Nl9IVCAq
LworCitzdGF0aWMgaW50CithY3BpX3Byb2Nlc3Nvcl9kb21haW5faW5pdChzdHJ1Y3QgYWNwaV9w
cm9jZXNzb3JfcGVyZm9ybWFuY2UgKnBlcmYsIGludCBjcHUpCit7CisKKyNpZmRlZiBDT05GSUdf
WDg2X0hUCisJaW50IGh0X3ByZXNlbnQgPSAoKGNwdV9oYXNfaHQpICYmIChzbXBfbnVtX3NpYmxp
bmdzID09IDIpKTsKKyNlbmRpZgorCisJQUNQSV9GVU5DVElPTl9UUkFDRSgiYWNwaV9wcm9jZXNz
b3JfZG9tYWluX2luaXQiKTsKKworI2lmZGVmIENPTkZJR19YODZfSFQKKwlpZiAoaHRfcHJlc2Vu
dCkgeworCQlpbnQgcmV0dmFsOworCQlyZXR2YWwgPSBhY3BpX3Byb2Nlc3Nvcl9kb21haW5faHRf
aW5pdChwZXJmLCBjcHUpOworCQlyZXR1cm5fVkFMVUUocmV0dmFsKTsKKwl9CisJLyogRkFMTFRI
UlUgYW5kIHVzZSBkZWZhdWx0IGRvbWFpbiBzdHJ1Y3R1cmUgKi8KKyNlbmRpZgorCXBlcmZbY3B1
XS5kb21haW5wID0gJmFjcGlfcHJvY2Vzc29yX2RvbWFpbl9kZWY7CisJcmV0dXJuX1ZBTFVFKDAp
OworfQorCitzdGF0aWMgdm9pZAorYWNwaV9wcm9jZXNzb3JfZG9tYWluX2V4aXQoc3RydWN0IGFj
cGlfcHJvY2Vzc29yX3BlcmZvcm1hbmNlICpwZXJmLCBpbnQgY3B1KQoreworCUFDUElfRlVOQ1RJ
T05fVFJBQ0UoImFjcGlfcHJvY2Vzc29yX2RvbWFpbl9leGl0Iik7CisjaWZkZWYgQ09ORklHX1g4
Nl9IVAorCWlmICghcGVyZltjcHVdLmRvbWFpbnApCisJCXJldHVybl9WT0lEOworCisJaWYgKHBl
cmZbY3B1XS5kb21haW5wID09ICZhY3BpX3Byb2Nlc3Nvcl9kb21haW5fZGVmKQorCQlyZXR1cm5f
Vk9JRDsKKworCXBlcmZbY3B1XS5kb21haW5wLT5yZWZfY250LS07CisJaWYgKHBlcmZbY3B1XS5k
b21haW5wLT5yZWZfY250ID09IDApIHsKKwkJa2ZyZWUocGVyZltjcHVdLmRvbWFpbnApOworCQlw
ZXJmW2NwdV0uZG9tYWlucCA9IE5VTEw7CisJfQorI2VuZGlmIC8qIENPTkZJR19YODZfSFQgKi8K
KwlyZXR1cm5fVk9JRDsKK30KIAogc3RhdGljIGludAogYWNwaV9jcHVmcmVxX2NwdV9pbml0ICgK
QEAgLTc0Miw4ICs4ODYsMTMgQEAgYWNwaV9jcHVmcmVxX2luaXQgKHZvaWQpCiAKIAkvKiByZWdp
c3RlciBzdHJ1Y3QgYWNwaV9wcm9jZXNzb3JfcGVyZm9ybWFuY2UgcGVyZm9ybWFuY2UgKi8KIAlm
b3IgKGk9MDsgaTxOUl9DUFVTOyBpKyspIHsKLQkJaWYgKGNwdV9vbmxpbmUoaSkpCisJCWlmIChj
cHVfb25saW5lKGkpKSB7CiAJCQlhY3BpX3Byb2Nlc3Nvcl9yZWdpc3Rlcl9wZXJmb3JtYW5jZSgm
cGVyZm9ybWFuY2VbaV0sICZwciwgaSk7CisJCQlpZiAoYWNwaV9wcm9jZXNzb3JfZG9tYWluX2lu
aXQocGVyZm9ybWFuY2UsIGkpIDwgMCkgeworCQkJCXJlc3VsdCA9IC1FTk9NRU07CisJCQkJZ290
byBlcnIwOworCQkJfQorCQl9CiAJfQogCiAJLyogaW5pdGlhbGl6ZSAgKi8KQEAgLTgwNCw2ICs5
NTMsMTAgQEAgYWNwaV9jcHVmcmVxX2luaXQgKHZvaWQpCiAJY3B1ZnJlcV91bnJlZ2lzdGVyX2Ry
aXZlcigmYWNwaV9jcHVmcmVxX2RyaXZlcik7CiAJCiAgZXJyMDoKKwlmb3IgKGkgPSAwOyBpIDwg
TlJfQ1BVUzsgaSsrKQorCQlpZiAoY3B1X29ubGluZShpKSkKKwkJCWFjcGlfcHJvY2Vzc29yX2Rv
bWFpbl9leGl0KHBlcmZvcm1hbmNlLCBpKTsKKwogCS8qIHVucmVnaXN0ZXIgc3RydWN0IGFjcGlf
cHJvY2Vzc29yX3BlcmZvcm1hbmNlIHBlcmZvcm1hbmNlICovCiAJZm9yIChpPTA7IGk8TlJfQ1BV
UzsgaSsrKSB7CiAJCWlmIChwZXJmb3JtYW5jZVtpXS5wcikgewpAQCAtODQyLDYgKzk5NSwxMCBA
QCBhY3BpX2NwdWZyZXFfZXhpdCAodm9pZCkKIAkJfQogCX0KIAorCWZvciAoaSA9IDA7IGkgPCBO
Ul9DUFVTOyBpKyspCisJCWlmIChjcHVfb25saW5lKGkpKQorCQkJYWNwaV9wcm9jZXNzb3JfZG9t
YWluX2V4aXQocGVyZm9ybWFuY2UsIGkpOworCiAJa2ZyZWUocGVyZm9ybWFuY2UpOwogCiAJcmV0
dXJuX1ZPSUQ7CmRpZmYgLXB1ck4gbGludXgtMi42LjAtdGVzdDcvaW5jbHVkZS9hY3BpL3Byb2Nl
c3Nvci5oIGxpbnV4LTIuNi4wLXRlc3Q3LWRicy9pbmNsdWRlL2FjcGkvcHJvY2Vzc29yLmgKLS0t
IGxpbnV4LTIuNi4wLXRlc3Q3L2luY2x1ZGUvYWNwaS9wcm9jZXNzb3IuaAkyMDAzLTEwLTIwIDEz
OjMxOjEwLjAwMDAwMDAwMCAtMDcwMAorKysgbGludXgtMi42LjAtdGVzdDctZGJzL2luY2x1ZGUv
YWNwaS9wcm9jZXNzb3IuaAkyMDAzLTEwLTIwIDEzOjA4OjExLjAwMDAwMDAwMCAtMDcwMApAQCAt
Miw2ICsyLDcgQEAKICNkZWZpbmUgX19BQ1BJX1BST0NFU1NPUl9ICiAKICNpbmNsdWRlIDxsaW51
eC9rZXJuZWwuaD4KKyNpbmNsdWRlIDxsaW51eC9zZW0uaD4KIAogI2RlZmluZSBBQ1BJX1BST0NF
U1NPUl9CVVNZX01FVFJJQwkxMAogCkBAIC03NCw2ICs3NSw4IEBAIHN0cnVjdCBhY3BpX3Byb2Nl
c3Nvcl9wZXJmb3JtYW5jZSB7CiAJdTE2CQkJc3RhdHVzX3JlZ2lzdGVyOwogCWludAkJCXN0YXRl
X2NvdW50OwogCWludAkJCXNwYWNlX2lkOworCWludAkJCXJlcXVlc3RlZF9zdGF0ZTsKKwlzdHJ1
Y3QgYWNwaV9wcm9jZXNzb3JfZG9tYWluICpkb21haW5wOwogCXN0cnVjdCBhY3BpX3Byb2Nlc3Nv
cl9weCBzdGF0ZXNbQUNQSV9QUk9DRVNTT1JfTUFYX1BFUkZPUk1BTkNFXTsKIAlzdHJ1Y3QgY3B1
ZnJlcV9mcmVxdWVuY3lfdGFibGUgZnJlcV90YWJsZVtBQ1BJX1BST0NFU1NPUl9NQVhfUEVSRk9S
TUFOQ0VdOwogCXN0cnVjdCBhY3BpX3Byb2Nlc3NvciAgICpwcjsKQEAgLTEzMiw2ICsxMzUsMTgg
QEAgc3RydWN0IGFjcGlfcHJvY2Vzc29yIHsKIAlzdHJ1Y3QgYWNwaV9wcm9jZXNzb3JfbGltaXQg
bGltaXQ7CiB9OwogCisjZGVmaW5lIEFDUElfTUFYX0NQVVNfUEVSX0RPTUFJTiAJMgorc3RydWN0
IGFjcGlfcHJvY2Vzc29yX2RvbWFpbiB7CisJLyogRG9tYWluIHdpZGUgZGF0YSAqLworCXN0cnVj
dCBzZW1hcGhvcmUJc2VtOworCWludCAJCQljdXJfc3RhdGU7CisJaW50CQkJcmVmX2NudDsKKwlp
bnQgCQkJbWVtYmVyc1tBQ1BJX01BWF9DUFVTX1BFUl9ET01BSU5dOworCS8qIERvbWFpbiB3aWRl
IGZ1bmN0aW9uIHBvaW50ZXJzICovCisJaW50ICgqYWNwaV9wcm9jZXNzb3Jfc2V0X3BlcmZvcm1h
bmNlX3B0cikoc3RydWN0IGFjcGlfcHJvY2Vzc29yX3BlcmZvcm1hbmNlICpwZXJmLCBpbnQgc3Rh
dGUpOworCXZvaWQgKCpjcHVmcmVxX25vdGlmeV90cmFuc2l0aW9uX3B0cikoc3RydWN0IGNwdWZy
ZXFfZnJlcXMgKmNwdWZyZXFfZnJlcXMsIHVuc2lnbmVkIGludCBzdGF0ZSk7Cit9OworCiBleHRl
cm4gaW50IGFjcGlfcHJvY2Vzc29yX2dldF9wbGF0Zm9ybV9saW1pdCAoCiAJc3RydWN0IGFjcGlf
cHJvY2Vzc29yKglwcik7CiBleHRlcm4gaW50IGFjcGlfcHJvY2Vzc29yX3JlZ2lzdGVyX3BlcmZv
cm1hbmNlICgK

------_=_NextPart_001_01C3977E.EF61E970--
