Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbTJUC45 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 22:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbTJUC45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 22:56:57 -0400
Received: from fmr05.intel.com ([134.134.136.6]:4019 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S262770AbTJUC4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 22:56:33 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C3977E.E9BD1D20"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: [PATCH] 1/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Date: Mon, 20 Oct 2003 19:56:23 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB60077912@scsmsx403.sc.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 1/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Thread-Index: AcOXfuZsC2ScyxWISHibIHynWcgyYA==
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <cpufreq@www.linux.org.uk>, <linux-kernel@vger.kernel.org>,
       "linux-acpi" <linux-acpi@intel.com>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Dominik Brodowski" <linux@brodo.de>
X-OriginalArrivalTime: 21 Oct 2003 02:56:24.0302 (UTC) FILETIME=[E9F050E0:01C3977E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C3977E.E9BD1D20
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Patch 1/3: Changes to ACPI P-state driver, to handle MSR=20
based transitions frequency transitions and make the driver=20
SMP aware.


diffstat dbs1.patch=20
arch/i386/kernel/cpu/cpufreq/Kconfig |    4=20
arch/i386/kernel/cpu/cpufreq/acpi.c  |  141
+++++++++++++++++++++++++++--------
include/acpi/processor.h             |    1=20
3 files changed, 116 insertions(+), 30 deletions(-)



diff -purN linux-2.6.0-test7/arch/i386/kernel/cpu/cpufreq/acpi.c
linux-2.6.0-test7-dbs/arch/i386/kernel/cpu/cpufreq/acpi.c
--- linux-2.6.0-test7/arch/i386/kernel/cpu/cpufreq/acpi.c
2003-10-20 00:24:43.000000000 -0700
+++ linux-2.6.0-test7-dbs/arch/i386/kernel/cpu/cpufreq/acpi.c
2003-10-20 02:11:01.000000000 -0700
@@ -99,7 +99,9 @@ acpi_processor_get_performance_control (
=20
 	reg =3D (struct acpi_pct_register *) (obj.buffer.pointer);
=20
-	if (reg->space_id !=3D ACPI_ADR_SPACE_SYSTEM_IO) {
+	perf->space_id =3D (int) reg->space_id;
+	if (reg->space_id !=3D ACPI_ADR_SPACE_SYSTEM_IO &&=20
+			reg->space_id !=3D ACPI_ADR_SPACE_FIXED_HARDWARE)
{
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 			"Unsupported address space [%d]
(control_register)\n",
 			(u32) reg->space_id));
@@ -126,7 +128,8 @@ acpi_processor_get_performance_control (
=20
 	reg =3D (struct acpi_pct_register *) (obj.buffer.pointer);
=20
-	if (reg->space_id !=3D ACPI_ADR_SPACE_SYSTEM_IO) {
+	if (reg->space_id !=3D ACPI_ADR_SPACE_SYSTEM_IO &&=20
+			reg->space_id !=3D ACPI_ADR_SPACE_FIXED_HARDWARE)
{
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 			"Unsupported address space [%d]
(status_register)\n",
 			(u32) reg->space_id));
@@ -224,16 +227,100 @@ end:
 	return_VALUE(result);
 }
=20
+struct set_performance_param {
+	int 					cpu;
+	struct acpi_processor_performance	*perf;
+	unsigned int 				state;
+	unsigned int 				async;
+	unsigned int 				retval;
+};
+
+static void
+target_cpu_set_performance(struct set_performance_param	*param)
+{
+	struct acpi_processor_performance	*perf =3D param->perf;
+	u16		port =3D 0;
+	int		state =3D param->state;
+	unsigned int	value =3D perf->states[state].control;
+	int		i =3D 0;
+
+	ACPI_FUNCTION_TRACE("target_cpu_set_performance");
+	if (perf->space_id =3D=3D ACPI_ADR_SPACE_FIXED_HARDWARE) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Writing 0x%x to MSR
0x%x\n",=20
+					value, perf->control_register));
+		wrmsr(perf->control_register, value, 0);
+	} else {
+		port =3D perf->control_register;
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,=20
+			"Writing 0x%04x to port 0x%04x\n", value,
port));
+
+		outl(value, port);=20
+	}
+
+	if (param->async) {
+		/* We don't want to wait for the status change here, as=20
+		 * that will affect performance, especially with
frequent=20
+		 * frequency switches. We assume the tranisition=20
+		 * gone through and continue.
+		 */
+		param->retval =3D perf->states[state].status;
+		return_VOID;
+	}
+
+	if (perf->space_id =3D=3D ACPI_ADR_SPACE_FIXED_HARDWARE) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,=20
+			"Looking for 0x%02x from MSR 0x%04x\n",
+			(u16) perf->states[state].status,=20
+			perf->status_register));
+
+		for (i =3D 0; i < 100; i++) {
+			unsigned long unused_hi;
+			rdmsr(perf->status_register, value, unused_hi);
+			if (value =3D=3D perf->states[state].status)
+				break;
+			udelay(10);
+		}
+	} else {
+		port =3D perf->status_register;
+
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,=20
+			"Looking for 0x%04x from port 0x%04x\n",
+			(u16) perf->states[state].status, port));
+
+		for (i =3D 0; i < 100; i++) {
+			value =3D inl(port);
+			if (value =3D=3D perf->states[state].status)
+				break;
+			udelay(10);
+		}
+	}
+	param->retval =3D value;
+	return_VOID;
+}
+
+#ifdef CONFIG_SMP
+static void
+target_cpu_set_performance_ipi(void *data)
+{
+	struct set_performance_param	*param;
+
+	param =3D (struct set_performance_param *) data;
+	if (param->cpu !=3D smp_processor_id())
+		return;
+
+	target_cpu_set_performance(param);
+}
+#endif
=20
 static int
 acpi_processor_set_performance (
 	struct acpi_processor_performance	*perf,
 	int			state)
 {
-	u16			port =3D 0;
-	u16			value =3D 0;
+	unsigned int		value =3D 0;
 	int			i =3D 0;
 	struct cpufreq_freqs    cpufreq_freqs;
+	struct set_performance_param param;
=20
 	ACPI_FUNCTION_TRACE("acpi_processor_set_performance");
=20
@@ -267,8 +354,12 @@ acpi_processor_set_performance (
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
@@ -276,35 +367,27 @@ acpi_processor_set_performance (
 	/*
 	 * First we write the target state's 'control' value to the
 	 * control_register.
-	 */
-
-	port =3D perf->control_register;
-	value =3D (u16) perf->states[state].control;
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,=20
-		"Writing 0x%04x to port 0x%04x\n", value, port));
-
-	outw(value, port);=20
-
-	/*
 	 * Then we read the 'status_register' and compare the value with
the
 	 * target state's 'status' to make sure the transition was
successful.
 	 * Note that we'll poll for up to 1ms (100 cycles of 10us)
before
 	 * giving up.
 	 */
=20
-	port =3D perf->status_register;
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,=20
-		"Looking for 0x%04x from port 0x%04x\n",
-		(u16) perf->states[state].status, port));
-
-	for (i=3D0; i<100; i++) {
-		value =3D inw(port);
-		if (value =3D=3D (u16) perf->states[state].status)
-			break;
-		udelay(10);
-	}
+	param.cpu =3D perf - performance;
+	param.perf =3D perf;
+	param.state =3D state;
+#ifdef CONFIG_SMP
+	param.async =3D 1; /* We don't want to wait in IPI context */
+	if (param.cpu !=3D smp_processor_id())
+		smp_call_function(target_cpu_set_performance_ipi,
+				(void *)&param, 1, 1);
+	else
+		target_cpu_set_performance(&param);
+#else
+	param.async =3D 0;
+	target_cpu_set_performance(&param);
+#endif
+	value =3D param.retval;
=20
 	/* notify cpufreq */
 	cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_POSTCHANGE);
diff -purN linux-2.6.0-test7/arch/i386/kernel/cpu/cpufreq/Kconfig
linux-2.6.0-test7-dbs/arch/i386/kernel/cpu/cpufreq/Kconfig
--- linux-2.6.0-test7/arch/i386/kernel/cpu/cpufreq/Kconfig
2003-10-14 16:28:32.000000000 -0700
+++ linux-2.6.0-test7-dbs/arch/i386/kernel/cpu/cpufreq/Kconfig
2003-10-20 02:27:39.000000000 -0700
@@ -36,7 +36,9 @@ config X86_ACPI_CPUFREQ
 	depends on CPU_FREQ_TABLE && ACPI_PROCESSOR
 	help
 	  This driver adds a CPUFreq driver which utilizes the ACPI
-	  Processor Performance States.
+	  Processor Performance States. This can work with variety
+	  of platforms and support both Intel Speedstep and Intel
Enhanced=20
+	  Speedstep, as long as BIOS-ACPI provides the P-state
information.
=20
 	  For details, take a look at linux/Documentation/cpu-freq.=20
=20
diff -purN linux-2.6.0-test7/include/acpi/processor.h
linux-2.6.0-test7-dbs/include/acpi/processor.h
--- linux-2.6.0-test7/include/acpi/processor.h	2003-10-20
00:24:43.000000000 -0700
+++ linux-2.6.0-test7-dbs/include/acpi/processor.h	2003-10-20
02:11:08.000000000 -0700
@@ -73,6 +73,7 @@ struct acpi_processor_performance {
 	u16			control_register;
 	u16			status_register;
 	int			state_count;
+	int			space_id;
 	struct acpi_processor_px states[ACPI_PROCESSOR_MAX_PERFORMANCE];
 	struct cpufreq_frequency_table
freq_table[ACPI_PROCESSOR_MAX_PERFORMANCE];
 	struct acpi_processor   *pr;

------_=_NextPart_001_01C3977E.E9BD1D20
Content-Type: application/octet-stream;
	name="dbs1.patch"
Content-Transfer-Encoding: base64
Content-Description: dbs1.patch
Content-Disposition: attachment;
	filename="dbs1.patch"

ZGlmZiAtcHVyTiBsaW51eC0yLjYuMC10ZXN0Ny9hcmNoL2kzODYva2VybmVsL2NwdS9jcHVmcmVx
L2FjcGkuYyBsaW51eC0yLjYuMC10ZXN0Ny1kYnMvYXJjaC9pMzg2L2tlcm5lbC9jcHUvY3B1ZnJl
cS9hY3BpLmMKLS0tIGxpbnV4LTIuNi4wLXRlc3Q3L2FyY2gvaTM4Ni9rZXJuZWwvY3B1L2NwdWZy
ZXEvYWNwaS5jCTIwMDMtMTAtMjAgMDA6MjQ6NDMuMDAwMDAwMDAwIC0wNzAwCisrKyBsaW51eC0y
LjYuMC10ZXN0Ny1kYnMvYXJjaC9pMzg2L2tlcm5lbC9jcHUvY3B1ZnJlcS9hY3BpLmMJMjAwMy0x
MC0yMCAwMjoxMTowMS4wMDAwMDAwMDAgLTA3MDAKQEAgLTk5LDcgKzk5LDkgQEAgYWNwaV9wcm9j
ZXNzb3JfZ2V0X3BlcmZvcm1hbmNlX2NvbnRyb2wgKAogCiAJcmVnID0gKHN0cnVjdCBhY3BpX3Bj
dF9yZWdpc3RlciAqKSAob2JqLmJ1ZmZlci5wb2ludGVyKTsKIAotCWlmIChyZWctPnNwYWNlX2lk
ICE9IEFDUElfQURSX1NQQUNFX1NZU1RFTV9JTykgeworCXBlcmYtPnNwYWNlX2lkID0gKGludCkg
cmVnLT5zcGFjZV9pZDsKKwlpZiAocmVnLT5zcGFjZV9pZCAhPSBBQ1BJX0FEUl9TUEFDRV9TWVNU
RU1fSU8gJiYgCisJCQlyZWctPnNwYWNlX2lkICE9IEFDUElfQURSX1NQQUNFX0ZJWEVEX0hBUkRX
QVJFKSB7CiAJCUFDUElfREVCVUdfUFJJTlQoKEFDUElfREJfRVJST1IsCiAJCQkiVW5zdXBwb3J0
ZWQgYWRkcmVzcyBzcGFjZSBbJWRdIChjb250cm9sX3JlZ2lzdGVyKVxuIiwKIAkJCSh1MzIpIHJl
Zy0+c3BhY2VfaWQpKTsKQEAgLTEyNiw3ICsxMjgsOCBAQCBhY3BpX3Byb2Nlc3Nvcl9nZXRfcGVy
Zm9ybWFuY2VfY29udHJvbCAoCiAKIAlyZWcgPSAoc3RydWN0IGFjcGlfcGN0X3JlZ2lzdGVyICop
IChvYmouYnVmZmVyLnBvaW50ZXIpOwogCi0JaWYgKHJlZy0+c3BhY2VfaWQgIT0gQUNQSV9BRFJf
U1BBQ0VfU1lTVEVNX0lPKSB7CisJaWYgKHJlZy0+c3BhY2VfaWQgIT0gQUNQSV9BRFJfU1BBQ0Vf
U1lTVEVNX0lPICYmIAorCQkJcmVnLT5zcGFjZV9pZCAhPSBBQ1BJX0FEUl9TUEFDRV9GSVhFRF9I
QVJEV0FSRSkgewogCQlBQ1BJX0RFQlVHX1BSSU5UKChBQ1BJX0RCX0VSUk9SLAogCQkJIlVuc3Vw
cG9ydGVkIGFkZHJlc3Mgc3BhY2UgWyVkXSAoc3RhdHVzX3JlZ2lzdGVyKVxuIiwKIAkJCSh1MzIp
IHJlZy0+c3BhY2VfaWQpKTsKQEAgLTIyNCwxNiArMjI3LDEwMCBAQCBlbmQ6CiAJcmV0dXJuX1ZB
TFVFKHJlc3VsdCk7CiB9CiAKK3N0cnVjdCBzZXRfcGVyZm9ybWFuY2VfcGFyYW0geworCWludCAJ
CQkJCWNwdTsKKwlzdHJ1Y3QgYWNwaV9wcm9jZXNzb3JfcGVyZm9ybWFuY2UJKnBlcmY7CisJdW5z
aWduZWQgaW50IAkJCQlzdGF0ZTsKKwl1bnNpZ25lZCBpbnQgCQkJCWFzeW5jOworCXVuc2lnbmVk
IGludCAJCQkJcmV0dmFsOworfTsKKworc3RhdGljIHZvaWQKK3RhcmdldF9jcHVfc2V0X3BlcmZv
cm1hbmNlKHN0cnVjdCBzZXRfcGVyZm9ybWFuY2VfcGFyYW0JKnBhcmFtKQoreworCXN0cnVjdCBh
Y3BpX3Byb2Nlc3Nvcl9wZXJmb3JtYW5jZQkqcGVyZiA9IHBhcmFtLT5wZXJmOworCXUxNgkJcG9y
dCA9IDA7CisJaW50CQlzdGF0ZSA9IHBhcmFtLT5zdGF0ZTsKKwl1bnNpZ25lZCBpbnQJdmFsdWUg
PSBwZXJmLT5zdGF0ZXNbc3RhdGVdLmNvbnRyb2w7CisJaW50CQlpID0gMDsKKworCUFDUElfRlVO
Q1RJT05fVFJBQ0UoInRhcmdldF9jcHVfc2V0X3BlcmZvcm1hbmNlIik7CisJaWYgKHBlcmYtPnNw
YWNlX2lkID09IEFDUElfQURSX1NQQUNFX0ZJWEVEX0hBUkRXQVJFKSB7CisJCUFDUElfREVCVUdf
UFJJTlQoKEFDUElfREJfSU5GTywgIldyaXRpbmcgMHgleCB0byBNU1IgMHgleFxuIiwgCisJCQkJ
CXZhbHVlLCBwZXJmLT5jb250cm9sX3JlZ2lzdGVyKSk7CisJCXdybXNyKHBlcmYtPmNvbnRyb2xf
cmVnaXN0ZXIsIHZhbHVlLCAwKTsKKwl9IGVsc2UgeworCQlwb3J0ID0gcGVyZi0+Y29udHJvbF9y
ZWdpc3RlcjsKKwkJQUNQSV9ERUJVR19QUklOVCgoQUNQSV9EQl9JTkZPLCAKKwkJCSJXcml0aW5n
IDB4JTA0eCB0byBwb3J0IDB4JTA0eFxuIiwgdmFsdWUsIHBvcnQpKTsKKworCQlvdXRsKHZhbHVl
LCBwb3J0KTsgCisJfQorCisJaWYgKHBhcmFtLT5hc3luYykgeworCQkvKiBXZSBkb24ndCB3YW50
IHRvIHdhaXQgZm9yIHRoZSBzdGF0dXMgY2hhbmdlIGhlcmUsIGFzIAorCQkgKiB0aGF0IHdpbGwg
YWZmZWN0IHBlcmZvcm1hbmNlLCBlc3BlY2lhbGx5IHdpdGggZnJlcXVlbnQgCisJCSAqIGZyZXF1
ZW5jeSBzd2l0Y2hlcy4gV2UgYXNzdW1lIHRoZSB0cmFuaXNpdGlvbiAKKwkJICogZ29uZSB0aHJv
dWdoIGFuZCBjb250aW51ZS4KKwkJICovCisJCXBhcmFtLT5yZXR2YWwgPSBwZXJmLT5zdGF0ZXNb
c3RhdGVdLnN0YXR1czsKKwkJcmV0dXJuX1ZPSUQ7CisJfQorCisJaWYgKHBlcmYtPnNwYWNlX2lk
ID09IEFDUElfQURSX1NQQUNFX0ZJWEVEX0hBUkRXQVJFKSB7CisJCUFDUElfREVCVUdfUFJJTlQo
KEFDUElfREJfSU5GTywgCisJCQkiTG9va2luZyBmb3IgMHglMDJ4IGZyb20gTVNSIDB4JTA0eFxu
IiwKKwkJCSh1MTYpIHBlcmYtPnN0YXRlc1tzdGF0ZV0uc3RhdHVzLCAKKwkJCXBlcmYtPnN0YXR1
c19yZWdpc3RlcikpOworCisJCWZvciAoaSA9IDA7IGkgPCAxMDA7IGkrKykgeworCQkJdW5zaWdu
ZWQgbG9uZyB1bnVzZWRfaGk7CisJCQlyZG1zcihwZXJmLT5zdGF0dXNfcmVnaXN0ZXIsIHZhbHVl
LCB1bnVzZWRfaGkpOworCQkJaWYgKHZhbHVlID09IHBlcmYtPnN0YXRlc1tzdGF0ZV0uc3RhdHVz
KQorCQkJCWJyZWFrOworCQkJdWRlbGF5KDEwKTsKKwkJfQorCX0gZWxzZSB7CisJCXBvcnQgPSBw
ZXJmLT5zdGF0dXNfcmVnaXN0ZXI7CisKKwkJQUNQSV9ERUJVR19QUklOVCgoQUNQSV9EQl9JTkZP
LCAKKwkJCSJMb29raW5nIGZvciAweCUwNHggZnJvbSBwb3J0IDB4JTA0eFxuIiwKKwkJCSh1MTYp
IHBlcmYtPnN0YXRlc1tzdGF0ZV0uc3RhdHVzLCBwb3J0KSk7CisKKwkJZm9yIChpID0gMDsgaSA8
IDEwMDsgaSsrKSB7CisJCQl2YWx1ZSA9IGlubChwb3J0KTsKKwkJCWlmICh2YWx1ZSA9PSBwZXJm
LT5zdGF0ZXNbc3RhdGVdLnN0YXR1cykKKwkJCQlicmVhazsKKwkJCXVkZWxheSgxMCk7CisJCX0K
Kwl9CisJcGFyYW0tPnJldHZhbCA9IHZhbHVlOworCXJldHVybl9WT0lEOworfQorCisjaWZkZWYg
Q09ORklHX1NNUAorc3RhdGljIHZvaWQKK3RhcmdldF9jcHVfc2V0X3BlcmZvcm1hbmNlX2lwaSh2
b2lkICpkYXRhKQoreworCXN0cnVjdCBzZXRfcGVyZm9ybWFuY2VfcGFyYW0JKnBhcmFtOworCisJ
cGFyYW0gPSAoc3RydWN0IHNldF9wZXJmb3JtYW5jZV9wYXJhbSAqKSBkYXRhOworCWlmIChwYXJh
bS0+Y3B1ICE9IHNtcF9wcm9jZXNzb3JfaWQoKSkKKwkJcmV0dXJuOworCisJdGFyZ2V0X2NwdV9z
ZXRfcGVyZm9ybWFuY2UocGFyYW0pOworfQorI2VuZGlmCiAKIHN0YXRpYyBpbnQKIGFjcGlfcHJv
Y2Vzc29yX3NldF9wZXJmb3JtYW5jZSAoCiAJc3RydWN0IGFjcGlfcHJvY2Vzc29yX3BlcmZvcm1h
bmNlCSpwZXJmLAogCWludAkJCXN0YXRlKQogewotCXUxNgkJCXBvcnQgPSAwOwotCXUxNgkJCXZh
bHVlID0gMDsKKwl1bnNpZ25lZCBpbnQJCXZhbHVlID0gMDsKIAlpbnQJCQlpID0gMDsKIAlzdHJ1
Y3QgY3B1ZnJlcV9mcmVxcyAgICBjcHVmcmVxX2ZyZXFzOworCXN0cnVjdCBzZXRfcGVyZm9ybWFu
Y2VfcGFyYW0gcGFyYW07CiAKIAlBQ1BJX0ZVTkNUSU9OX1RSQUNFKCJhY3BpX3Byb2Nlc3Nvcl9z
ZXRfcGVyZm9ybWFuY2UiKTsKIApAQCAtMjY3LDggKzM1NCwxMiBAQCBhY3BpX3Byb2Nlc3Nvcl9z
ZXRfcGVyZm9ybWFuY2UgKAogCiAJLyogY3B1ZnJlcSBmcmVxdWVuY3kgc3RydWN0ICovCiAJY3B1
ZnJlcV9mcmVxcy5jcHUgPSBwZXJmLT5wci0+aWQ7Ci0JY3B1ZnJlcV9mcmVxcy5vbGQgPSBwZXJm
LT5zdGF0ZXNbcGVyZi0+c3RhdGVdLmNvcmVfZnJlcXVlbmN5OwotCWNwdWZyZXFfZnJlcXMubmV3
ID0gcGVyZi0+c3RhdGVzW3N0YXRlXS5jb3JlX2ZyZXF1ZW5jeTsKKwkvKgorCSAqIGNwdWZyZXFf
bm90aWZpZXIgbmVlZHMgdG8gc2VuZCB0aGUgZnJlcSBpbiBLSHouIEJ1dCBhY3BpCisJICogZGF0
YSB3ZSBoYXZlIGlzIGluIE1IegorCSAqLworCWNwdWZyZXFfZnJlcXMub2xkID0gcGVyZi0+c3Rh
dGVzW3BlcmYtPnN0YXRlXS5jb3JlX2ZyZXF1ZW5jeSAqIDEwMDA7CisJY3B1ZnJlcV9mcmVxcy5u
ZXcgPSBwZXJmLT5zdGF0ZXNbc3RhdGVdLmNvcmVfZnJlcXVlbmN5ICogMTAwMDsKIAogCS8qIG5v
dGlmeSBjcHVmcmVxICovCiAJY3B1ZnJlcV9ub3RpZnlfdHJhbnNpdGlvbigmY3B1ZnJlcV9mcmVx
cywgQ1BVRlJFUV9QUkVDSEFOR0UpOwpAQCAtMjc2LDM1ICszNjcsMjcgQEAgYWNwaV9wcm9jZXNz
b3Jfc2V0X3BlcmZvcm1hbmNlICgKIAkvKgogCSAqIEZpcnN0IHdlIHdyaXRlIHRoZSB0YXJnZXQg
c3RhdGUncyAnY29udHJvbCcgdmFsdWUgdG8gdGhlCiAJICogY29udHJvbF9yZWdpc3Rlci4KLQkg
Ki8KLQotCXBvcnQgPSBwZXJmLT5jb250cm9sX3JlZ2lzdGVyOwotCXZhbHVlID0gKHUxNikgcGVy
Zi0+c3RhdGVzW3N0YXRlXS5jb250cm9sOwotCi0JQUNQSV9ERUJVR19QUklOVCgoQUNQSV9EQl9J
TkZPLCAKLQkJIldyaXRpbmcgMHglMDR4IHRvIHBvcnQgMHglMDR4XG4iLCB2YWx1ZSwgcG9ydCkp
OwotCi0Jb3V0dyh2YWx1ZSwgcG9ydCk7IAotCi0JLyoKIAkgKiBUaGVuIHdlIHJlYWQgdGhlICdz
dGF0dXNfcmVnaXN0ZXInIGFuZCBjb21wYXJlIHRoZSB2YWx1ZSB3aXRoIHRoZQogCSAqIHRhcmdl
dCBzdGF0ZSdzICdzdGF0dXMnIHRvIG1ha2Ugc3VyZSB0aGUgdHJhbnNpdGlvbiB3YXMgc3VjY2Vz
c2Z1bC4KIAkgKiBOb3RlIHRoYXQgd2UnbGwgcG9sbCBmb3IgdXAgdG8gMW1zICgxMDAgY3ljbGVz
IG9mIDEwdXMpIGJlZm9yZQogCSAqIGdpdmluZyB1cC4KIAkgKi8KIAotCXBvcnQgPSBwZXJmLT5z
dGF0dXNfcmVnaXN0ZXI7Ci0KLQlBQ1BJX0RFQlVHX1BSSU5UKChBQ1BJX0RCX0lORk8sIAotCQki
TG9va2luZyBmb3IgMHglMDR4IGZyb20gcG9ydCAweCUwNHhcbiIsCi0JCSh1MTYpIHBlcmYtPnN0
YXRlc1tzdGF0ZV0uc3RhdHVzLCBwb3J0KSk7Ci0KLQlmb3IgKGk9MDsgaTwxMDA7IGkrKykgewot
CQl2YWx1ZSA9IGludyhwb3J0KTsKLQkJaWYgKHZhbHVlID09ICh1MTYpIHBlcmYtPnN0YXRlc1tz
dGF0ZV0uc3RhdHVzKQotCQkJYnJlYWs7Ci0JCXVkZWxheSgxMCk7Ci0JfQorCXBhcmFtLmNwdSA9
IHBlcmYgLSBwZXJmb3JtYW5jZTsKKwlwYXJhbS5wZXJmID0gcGVyZjsKKwlwYXJhbS5zdGF0ZSA9
IHN0YXRlOworI2lmZGVmIENPTkZJR19TTVAKKwlwYXJhbS5hc3luYyA9IDE7IC8qIFdlIGRvbid0
IHdhbnQgdG8gd2FpdCBpbiBJUEkgY29udGV4dCAqLworCWlmIChwYXJhbS5jcHUgIT0gc21wX3By
b2Nlc3Nvcl9pZCgpKQorCQlzbXBfY2FsbF9mdW5jdGlvbih0YXJnZXRfY3B1X3NldF9wZXJmb3Jt
YW5jZV9pcGksCisJCQkJKHZvaWQgKikmcGFyYW0sIDEsIDEpOworCWVsc2UKKwkJdGFyZ2V0X2Nw
dV9zZXRfcGVyZm9ybWFuY2UoJnBhcmFtKTsKKyNlbHNlCisJcGFyYW0uYXN5bmMgPSAwOworCXRh
cmdldF9jcHVfc2V0X3BlcmZvcm1hbmNlKCZwYXJhbSk7CisjZW5kaWYKKwl2YWx1ZSA9IHBhcmFt
LnJldHZhbDsKIAogCS8qIG5vdGlmeSBjcHVmcmVxICovCiAJY3B1ZnJlcV9ub3RpZnlfdHJhbnNp
dGlvbigmY3B1ZnJlcV9mcmVxcywgQ1BVRlJFUV9QT1NUQ0hBTkdFKTsKZGlmZiAtcHVyTiBsaW51
eC0yLjYuMC10ZXN0Ny9hcmNoL2kzODYva2VybmVsL2NwdS9jcHVmcmVxL0tjb25maWcgbGludXgt
Mi42LjAtdGVzdDctZGJzL2FyY2gvaTM4Ni9rZXJuZWwvY3B1L2NwdWZyZXEvS2NvbmZpZwotLS0g
bGludXgtMi42LjAtdGVzdDcvYXJjaC9pMzg2L2tlcm5lbC9jcHUvY3B1ZnJlcS9LY29uZmlnCTIw
MDMtMTAtMTQgMTY6Mjg6MzIuMDAwMDAwMDAwIC0wNzAwCisrKyBsaW51eC0yLjYuMC10ZXN0Ny1k
YnMvYXJjaC9pMzg2L2tlcm5lbC9jcHUvY3B1ZnJlcS9LY29uZmlnCTIwMDMtMTAtMjAgMDI6Mjc6
MzkuMDAwMDAwMDAwIC0wNzAwCkBAIC0zNiw3ICszNiw5IEBAIGNvbmZpZyBYODZfQUNQSV9DUFVG
UkVRCiAJZGVwZW5kcyBvbiBDUFVfRlJFUV9UQUJMRSAmJiBBQ1BJX1BST0NFU1NPUgogCWhlbHAK
IAkgIFRoaXMgZHJpdmVyIGFkZHMgYSBDUFVGcmVxIGRyaXZlciB3aGljaCB1dGlsaXplcyB0aGUg
QUNQSQotCSAgUHJvY2Vzc29yIFBlcmZvcm1hbmNlIFN0YXRlcy4KKwkgIFByb2Nlc3NvciBQZXJm
b3JtYW5jZSBTdGF0ZXMuIFRoaXMgY2FuIHdvcmsgd2l0aCB2YXJpZXR5CisJICBvZiBwbGF0Zm9y
bXMgYW5kIHN1cHBvcnQgYm90aCBJbnRlbCBTcGVlZHN0ZXAgYW5kIEludGVsIEVuaGFuY2VkIAor
CSAgU3BlZWRzdGVwLCBhcyBsb25nIGFzIEJJT1MtQUNQSSBwcm92aWRlcyB0aGUgUC1zdGF0ZSBp
bmZvcm1hdGlvbi4KIAogCSAgRm9yIGRldGFpbHMsIHRha2UgYSBsb29rIGF0IGxpbnV4L0RvY3Vt
ZW50YXRpb24vY3B1LWZyZXEuIAogCmRpZmYgLXB1ck4gbGludXgtMi42LjAtdGVzdDcvaW5jbHVk
ZS9hY3BpL3Byb2Nlc3Nvci5oIGxpbnV4LTIuNi4wLXRlc3Q3LWRicy9pbmNsdWRlL2FjcGkvcHJv
Y2Vzc29yLmgKLS0tIGxpbnV4LTIuNi4wLXRlc3Q3L2luY2x1ZGUvYWNwaS9wcm9jZXNzb3IuaAky
MDAzLTEwLTIwIDAwOjI0OjQzLjAwMDAwMDAwMCAtMDcwMAorKysgbGludXgtMi42LjAtdGVzdDct
ZGJzL2luY2x1ZGUvYWNwaS9wcm9jZXNzb3IuaAkyMDAzLTEwLTIwIDAyOjExOjA4LjAwMDAwMDAw
MCAtMDcwMApAQCAtNzMsNiArNzMsNyBAQCBzdHJ1Y3QgYWNwaV9wcm9jZXNzb3JfcGVyZm9ybWFu
Y2UgewogCXUxNgkJCWNvbnRyb2xfcmVnaXN0ZXI7CiAJdTE2CQkJc3RhdHVzX3JlZ2lzdGVyOwog
CWludAkJCXN0YXRlX2NvdW50OworCWludAkJCXNwYWNlX2lkOwogCXN0cnVjdCBhY3BpX3Byb2Nl
c3Nvcl9weCBzdGF0ZXNbQUNQSV9QUk9DRVNTT1JfTUFYX1BFUkZPUk1BTkNFXTsKIAlzdHJ1Y3Qg
Y3B1ZnJlcV9mcmVxdWVuY3lfdGFibGUgZnJlcV90YWJsZVtBQ1BJX1BST0NFU1NPUl9NQVhfUEVS
Rk9STUFOQ0VdOwogCXN0cnVjdCBhY3BpX3Byb2Nlc3NvciAgICpwcjsK

------_=_NextPart_001_01C3977E.E9BD1D20--
