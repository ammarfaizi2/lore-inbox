Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbTJYTyn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 15:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbTJYTyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 15:54:43 -0400
Received: from fmr05.intel.com ([134.134.136.6]:54240 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262795AbTJYTy2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 15:54:28 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C39B31.C5A7C168"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: [PATCH] 1/3 A dynamic cpufreq governor
Date: Sat, 25 Oct 2003 12:54:16 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6007796B@scsmsx403.sc.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 1/3 A dynamic cpufreq governor
Thread-Index: AcObMcEoZr1HyGn9RSSEAp/drz/zJg==
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <linux-kernel@vger.kernel.org>, <cpufreq@www.linux.org.uk>,
       "Linus Torvalds" <torvalds@osdl.org>, <akpm@osdl.org>
Cc: "Pavel Machek" <pavel@ucw.cz>, "Dominik Brodowski" <linux@brodo.de>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
X-OriginalArrivalTime: 25 Oct 2003 19:54:17.0102 (UTC) FILETIME=[C5D10AE0:01C39B31]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C39B31.C5A7C168
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

ondemand1.patch - 'unit' related bugfixes in drivers.=20

diffstat ondemand1.patch
 acpi.c               |   10 ++++++++--
 powernow-k7.c        |    3 ++-
 speedstep-centrino.c |    3 ++-
 3 files changed, 12 insertions(+), 4 deletions(-)


diff -purN linux-2.6.0-test8/arch/i386/kernel/cpu/cpufreq/acpi.c
linux-2.6.0-test8-dbs/arch/i386/kernel/cpu/cpufreq/acpi.c
--- linux-2.6.0-test8/arch/i386/kernel/cpu/cpufreq/acpi.c
2003-10-17 14:42:54.000000000 -0700
+++ linux-2.6.0-test8-dbs/arch/i386/kernel/cpu/cpufreq/acpi.c
2003-10-25 13:19:03.000000000 -0700
@@ -267,8 +267,12 @@ acpi_processor_set_performance (
=20
 	/* cpufreq frequency struct */
 	cpufreq_freqs.cpu =3D perf->pr->id;
-	cpufreq_freqs.old =3D perf->states[perf->state].core_frequency;
-	cpufreq_freqs.new =3D perf->states[state].core_frequency;
+	/*
+	 * cpufreq_notifier needs to send the freq in KHz. But acpi
+	 * data we have is in MHz
+	 */
+	cpufreq_freqs.old =3D perf->states[perf->state].core_frequency *
1000;
+	cpufreq_freqs.new =3D perf->states[state].core_frequency * 1000;
=20
 	/* notify cpufreq */
 	cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_PRECHANGE);
@@ -581,6 +585,8 @@ acpi_cpufreq_cpu_init (
 		if (perf->states[i].transition_latency >
policy->cpuinfo.transition_latency)
 			policy->cpuinfo.transition_latency =3D
perf->states[i].transition_latency;
 	}
+	/* policy transition latency is in terms of nS */
+	policy->cpuinfo.transition_latency *=3D 1000;
 	policy->governor =3D CPUFREQ_DEFAULT_GOVERNOR;
 	policy->cur =3D perf->states[pr->limit.state.px].core_frequency *
1000;
=20
diff -purN linux-2.6.0-test8/arch/i386/kernel/cpu/cpufreq/powernow-k7.c
linux-2.6.0-test8-dbs/arch/i386/kernel/cpu/cpufreq/powernow-k7.c
--- linux-2.6.0-test8/arch/i386/kernel/cpu/cpufreq/powernow-k7.c
2003-10-17 14:42:53.000000000 -0700
+++ linux-2.6.0-test8-dbs/arch/i386/kernel/cpu/cpufreq/powernow-k7.c
2003-10-25 13:19:03.000000000 -0700
@@ -386,7 +386,8 @@ static int __init powernow_cpu_init (str
 				minimum_speed, maximum_speed);
=20
 	policy->governor =3D CPUFREQ_DEFAULT_GOVERNOR;
-	policy->cpuinfo.transition_latency =3D latency;
+	/* 'latency' is in terms of 10nS and policy latency in terms of
nS */
+	policy->cpuinfo.transition_latency =3D 10 * latency;
 	policy->cur =3D maximum_speed;
=20
 	return cpufreq_frequency_table_cpuinfo(policy, powernow_table);
diff -purN
linux-2.6.0-test8/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
linux-2.6.0-test8-dbs/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
--- linux-2.6.0-test8/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
2003-10-17 14:43:03.000000000 -0700
+++
linux-2.6.0-test8-dbs/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
2003-10-25 13:19:03.000000000 -0700
@@ -202,7 +202,8 @@ static int centrino_cpu_init(struct cpuf
 	freq =3D get_cur_freq();
=20
 	policy->governor =3D CPUFREQ_DEFAULT_GOVERNOR;
-	policy->cpuinfo.transition_latency =3D 10; /* 10uS transition
latency */
+	/* 10uS - policy transition latency is in terms of nS */
+	policy->cpuinfo.transition_latency =3D 1000 * 10;
 	policy->cur =3D freq;
=20
 	dprintk(KERN_INFO PFX "centrino_cpu_init: policy=3D%d
cur=3D%dkHz\n",

------_=_NextPart_001_01C39B31.C5A7C168
Content-Type: application/octet-stream;
	name="ondemand1.patch"
Content-Transfer-Encoding: base64
Content-Description: ondemand1.patch
Content-Disposition: attachment;
	filename="ondemand1.patch"

ZGlmZiAtcHVyTiBsaW51eC0yLjYuMC10ZXN0OC9hcmNoL2kzODYva2VybmVsL2NwdS9jcHVmcmVx
L2FjcGkuYyBsaW51eC0yLjYuMC10ZXN0OC1kYnMvYXJjaC9pMzg2L2tlcm5lbC9jcHUvY3B1ZnJl
cS9hY3BpLmMKLS0tIGxpbnV4LTIuNi4wLXRlc3Q4L2FyY2gvaTM4Ni9rZXJuZWwvY3B1L2NwdWZy
ZXEvYWNwaS5jCTIwMDMtMTAtMTcgMTQ6NDI6NTQuMDAwMDAwMDAwIC0wNzAwCisrKyBsaW51eC0y
LjYuMC10ZXN0OC1kYnMvYXJjaC9pMzg2L2tlcm5lbC9jcHUvY3B1ZnJlcS9hY3BpLmMJMjAwMy0x
MC0yNSAxMzoxOTowMy4wMDAwMDAwMDAgLTA3MDAKQEAgLTI2Nyw4ICsyNjcsMTIgQEAgYWNwaV9w
cm9jZXNzb3Jfc2V0X3BlcmZvcm1hbmNlICgKIAogCS8qIGNwdWZyZXEgZnJlcXVlbmN5IHN0cnVj
dCAqLwogCWNwdWZyZXFfZnJlcXMuY3B1ID0gcGVyZi0+cHItPmlkOwotCWNwdWZyZXFfZnJlcXMu
b2xkID0gcGVyZi0+c3RhdGVzW3BlcmYtPnN0YXRlXS5jb3JlX2ZyZXF1ZW5jeTsKLQljcHVmcmVx
X2ZyZXFzLm5ldyA9IHBlcmYtPnN0YXRlc1tzdGF0ZV0uY29yZV9mcmVxdWVuY3k7CisJLyoKKwkg
KiBjcHVmcmVxX25vdGlmaWVyIG5lZWRzIHRvIHNlbmQgdGhlIGZyZXEgaW4gS0h6LiBCdXQgYWNw
aQorCSAqIGRhdGEgd2UgaGF2ZSBpcyBpbiBNSHoKKwkgKi8KKwljcHVmcmVxX2ZyZXFzLm9sZCA9
IHBlcmYtPnN0YXRlc1twZXJmLT5zdGF0ZV0uY29yZV9mcmVxdWVuY3kgKiAxMDAwOworCWNwdWZy
ZXFfZnJlcXMubmV3ID0gcGVyZi0+c3RhdGVzW3N0YXRlXS5jb3JlX2ZyZXF1ZW5jeSAqIDEwMDA7
CiAKIAkvKiBub3RpZnkgY3B1ZnJlcSAqLwogCWNwdWZyZXFfbm90aWZ5X3RyYW5zaXRpb24oJmNw
dWZyZXFfZnJlcXMsIENQVUZSRVFfUFJFQ0hBTkdFKTsKQEAgLTU4MSw2ICs1ODUsOCBAQCBhY3Bp
X2NwdWZyZXFfY3B1X2luaXQgKAogCQlpZiAocGVyZi0+c3RhdGVzW2ldLnRyYW5zaXRpb25fbGF0
ZW5jeSA+IHBvbGljeS0+Y3B1aW5mby50cmFuc2l0aW9uX2xhdGVuY3kpCiAJCQlwb2xpY3ktPmNw
dWluZm8udHJhbnNpdGlvbl9sYXRlbmN5ID0gcGVyZi0+c3RhdGVzW2ldLnRyYW5zaXRpb25fbGF0
ZW5jeTsKIAl9CisJLyogcG9saWN5IHRyYW5zaXRpb24gbGF0ZW5jeSBpcyBpbiB0ZXJtcyBvZiBu
UyAqLworCXBvbGljeS0+Y3B1aW5mby50cmFuc2l0aW9uX2xhdGVuY3kgKj0gMTAwMDsKIAlwb2xp
Y3ktPmdvdmVybm9yID0gQ1BVRlJFUV9ERUZBVUxUX0dPVkVSTk9SOwogCXBvbGljeS0+Y3VyID0g
cGVyZi0+c3RhdGVzW3ByLT5saW1pdC5zdGF0ZS5weF0uY29yZV9mcmVxdWVuY3kgKiAxMDAwOwog
CmRpZmYgLXB1ck4gbGludXgtMi42LjAtdGVzdDgvYXJjaC9pMzg2L2tlcm5lbC9jcHUvY3B1ZnJl
cS9wb3dlcm5vdy1rNy5jIGxpbnV4LTIuNi4wLXRlc3Q4LWRicy9hcmNoL2kzODYva2VybmVsL2Nw
dS9jcHVmcmVxL3Bvd2Vybm93LWs3LmMKLS0tIGxpbnV4LTIuNi4wLXRlc3Q4L2FyY2gvaTM4Ni9r
ZXJuZWwvY3B1L2NwdWZyZXEvcG93ZXJub3ctazcuYwkyMDAzLTEwLTE3IDE0OjQyOjUzLjAwMDAw
MDAwMCAtMDcwMAorKysgbGludXgtMi42LjAtdGVzdDgtZGJzL2FyY2gvaTM4Ni9rZXJuZWwvY3B1
L2NwdWZyZXEvcG93ZXJub3ctazcuYwkyMDAzLTEwLTI1IDEzOjE5OjAzLjAwMDAwMDAwMCAtMDcw
MApAQCAtMzg2LDcgKzM4Niw4IEBAIHN0YXRpYyBpbnQgX19pbml0IHBvd2Vybm93X2NwdV9pbml0
IChzdHIKIAkJCQltaW5pbXVtX3NwZWVkLCBtYXhpbXVtX3NwZWVkKTsKIAogCXBvbGljeS0+Z292
ZXJub3IgPSBDUFVGUkVRX0RFRkFVTFRfR09WRVJOT1I7Ci0JcG9saWN5LT5jcHVpbmZvLnRyYW5z
aXRpb25fbGF0ZW5jeSA9IGxhdGVuY3k7CisJLyogJ2xhdGVuY3knIGlzIGluIHRlcm1zIG9mIDEw
blMgYW5kIHBvbGljeSBsYXRlbmN5IGluIHRlcm1zIG9mIG5TICovCisJcG9saWN5LT5jcHVpbmZv
LnRyYW5zaXRpb25fbGF0ZW5jeSA9IDEwICogbGF0ZW5jeTsKIAlwb2xpY3ktPmN1ciA9IG1heGlt
dW1fc3BlZWQ7CiAKIAlyZXR1cm4gY3B1ZnJlcV9mcmVxdWVuY3lfdGFibGVfY3B1aW5mbyhwb2xp
Y3ksIHBvd2Vybm93X3RhYmxlKTsKZGlmZiAtcHVyTiBsaW51eC0yLjYuMC10ZXN0OC9hcmNoL2kz
ODYva2VybmVsL2NwdS9jcHVmcmVxL3NwZWVkc3RlcC1jZW50cmluby5jIGxpbnV4LTIuNi4wLXRl
c3Q4LWRicy9hcmNoL2kzODYva2VybmVsL2NwdS9jcHVmcmVxL3NwZWVkc3RlcC1jZW50cmluby5j
Ci0tLSBsaW51eC0yLjYuMC10ZXN0OC9hcmNoL2kzODYva2VybmVsL2NwdS9jcHVmcmVxL3NwZWVk
c3RlcC1jZW50cmluby5jCTIwMDMtMTAtMTcgMTQ6NDM6MDMuMDAwMDAwMDAwIC0wNzAwCisrKyBs
aW51eC0yLjYuMC10ZXN0OC1kYnMvYXJjaC9pMzg2L2tlcm5lbC9jcHUvY3B1ZnJlcS9zcGVlZHN0
ZXAtY2VudHJpbm8uYwkyMDAzLTEwLTI1IDEzOjE5OjAzLjAwMDAwMDAwMCAtMDcwMApAQCAtMjAy
LDcgKzIwMiw4IEBAIHN0YXRpYyBpbnQgY2VudHJpbm9fY3B1X2luaXQoc3RydWN0IGNwdWYKIAlm
cmVxID0gZ2V0X2N1cl9mcmVxKCk7CiAKIAlwb2xpY3ktPmdvdmVybm9yID0gQ1BVRlJFUV9ERUZB
VUxUX0dPVkVSTk9SOwotCXBvbGljeS0+Y3B1aW5mby50cmFuc2l0aW9uX2xhdGVuY3kgPSAxMDsg
LyogMTB1UyB0cmFuc2l0aW9uIGxhdGVuY3kgKi8KKwkvKiAxMHVTIC0gcG9saWN5IHRyYW5zaXRp
b24gbGF0ZW5jeSBpcyBpbiB0ZXJtcyBvZiBuUyAqLworCXBvbGljeS0+Y3B1aW5mby50cmFuc2l0
aW9uX2xhdGVuY3kgPSAxMDAwICogMTA7CiAJcG9saWN5LT5jdXIgPSBmcmVxOwogCiAJZHByaW50
ayhLRVJOX0lORk8gUEZYICJjZW50cmlub19jcHVfaW5pdDogcG9saWN5PSVkIGN1cj0lZGtIelxu
IiwK

------_=_NextPart_001_01C39B31.C5A7C168--
