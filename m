Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269255AbUIIAxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269255AbUIIAxe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 20:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269252AbUIIAxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 20:53:34 -0400
Received: from fmr01.intel.com ([192.55.52.18]:32992 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S269255AbUIIAxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 20:53:24 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C49607.5AA37C24"
Subject: RE: [ACPI] Re: [PATCH] Oops and panic while unloading holder of pm_idle
Date: Thu, 9 Sep 2004 08:52:58 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD305751210A8@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] Re: [PATCH] Oops and panic while unloading holder of pm_idle
Thread-Index: AcSVrfbN+8CmUoQ9TWmKFoI3u/P52QAWHi9g
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Zwane Mwaikambo" <zwane@linuxpower.ca>
Cc: "BlaisorBlade" <blaisorblade_spam@yahoo.it>,
       <acpi-devel@lists.sourceforge.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>
X-OriginalArrivalTime: 09 Sep 2004 00:53:01.0889 (UTC) FILETIME=[5B98BB10:01C49607]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C49607.5AA37C24
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

On Wednesday, September 08, 2004, Zwane Mwaikambo wrote:

>Please try and inline your patches in future, i know it may be hard
with
>your mail client but it makes commenting on patches easier.
>
>		while (!need_resched()) {
>+			void (*idle)(void) =3D NULL;
>+
>
>You don't need to initialise variable `idle` here. Otherwise the rest
>looks fine with me.
Thanks Zwane. I updated the patch as you suggested. I'm sorry if the
line wrapped in below patch.

Thanks,
Shaohua


=3D=3D=3D=3D=3D arch/i386/kernel/apm.c 1.67 vs edited =3D=3D=3D=3D=3D
--- 1.67/arch/i386/kernel/apm.c	2004-08-24 17:08:47 +08:00
+++ edited/arch/i386/kernel/apm.c	2004-09-08 08:48:12 +08:00
@@ -2362,8 +2362,13 @@ static void __exit apm_exit(void)
 {
 	int	error;
=20
-	if (set_pm_idle)
+	if (set_pm_idle) {
 		pm_idle =3D original_pm_idle;
+		/* Wait the idle thread to read the new value,=20
+		 * otherwise we Oops.
+		 */
+		synchronize_kernel();
+	}
 	if (((apm_info.bios.flags & APM_BIOS_DISENGAGED) =3D=3D 0)
 	    && (apm_info.connection_version > 0x0100)) {
 		error =3D apm_engage_power_management(APM_DEVICE_ALL, 0);
=3D=3D=3D=3D=3D arch/i386/kernel/process.c 1.75 vs edited =
=3D=3D=3D=3D=3D
--- 1.75/arch/i386/kernel/process.c	2004-08-24 17:08:44 +08:00
+++ edited/arch/i386/kernel/process.c	2004-09-08 09:00:06 +08:00
@@ -142,6 +142,10 @@ void cpu_idle (void)
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched()) {
+			/* If pm_idle is in a module and is preempted,
+			 * oops occurs. Disable preempt.
+			 */
+			rcu_read_lock();
 			void (*idle)(void) =3D pm_idle;
=20
 			if (!idle)
@@ -149,6 +153,7 @@ void cpu_idle (void)
=20
 			irq_stat[smp_processor_id()].idle_timestamp =3D
jiffies;
 			idle();
+			rcu_read_unlock();
 		}
 		schedule();
 	}
=3D=3D=3D=3D=3D arch/ia64/kernel/process.c 1.62 vs edited =
=3D=3D=3D=3D=3D
--- 1.62/arch/ia64/kernel/process.c	2004-07-27 13:26:50 +08:00
+++ edited/arch/ia64/kernel/process.c	2004-09-08 09:04:58 +08:00
@@ -228,18 +228,24 @@ cpu_idle (void *unused)
=20
 	/* endless idle loop with no priority at all */
 	while (1) {
-		void (*idle)(void) =3D pm_idle;
-		if (!idle)
-			idle =3D default_idle;
-
 #ifdef CONFIG_SMP
 		if (!need_resched())
 			min_xtp();
 #endif
 		while (!need_resched()) {
+			void (*idle)(void);
+		=09
 			if (mark_idle)
 				(*mark_idle)(1);
+			/* If pm_idle is in a module and is preempted,
+			 * oops occurs. Disable preempt.
+			 */
+			rcu_read_lock();
+			idle=3D pm_idle;
+			if (!idle)
+				idle =3D default_idle;
 			(*idle)();
+			rcu_read_unlock();
 		}
=20
 		if (mark_idle)
=3D=3D=3D=3D=3D arch/x86_64/kernel/process.c 1.35 vs edited =
=3D=3D=3D=3D=3D
--- 1.35/arch/x86_64/kernel/process.c	2004-08-24 17:08:44 +08:00
+++ edited/arch/x86_64/kernel/process.c	2004-09-08 09:04:31 +08:00
@@ -130,11 +130,18 @@ void cpu_idle (void)
 {
 	/* endless idle loop with no priority at all */
 	while (1) {
-		void (*idle)(void) =3D pm_idle;
-		if (!idle)
-			idle =3D default_idle;
-		while (!need_resched())
+		while (!need_resched()) {
+			void (*idle)(void);
+			/* If pm_idle is in a module and is preempted,
+			 * oops occurs. Disable preempt.
+			 */
+			rcu_read_lock();
+			idle =3D pm_idle;
+			if (!idle)
+				idle =3D default_idle;
 			idle();
+			rcu_read_unlock();
+		}
 		schedule();
 	}
 }
=3D=3D=3D=3D=3D drivers/acpi/processor.c 1.61 vs edited =3D=3D=3D=3D=3D
--- 1.61/drivers/acpi/processor.c	2004-08-31 23:27:29 +08:00
+++ edited/drivers/acpi/processor.c	2004-09-08 09:12:34 +08:00
@@ -2419,6 +2419,9 @@ acpi_processor_remove (
 	/* Unregister the idle handler when processor #0 is removed. */
 	if (pr->id =3D=3D 0) {
 		pm_idle =3D pm_idle_save;
+		/* Wait the idle thread to read the new value,
+		 * otherwise we Oops.
+		 */
 		synchronize_kernel();
 	}

 <<idle.patch>>=20

------_=_NextPart_001_01C49607.5AA37C24
Content-Type: application/octet-stream;
	name="idle.patch"
Content-Transfer-Encoding: base64
Content-Description: idle.patch
Content-Disposition: attachment;
	filename="idle.patch"

PT09PT0gYXJjaC9pMzg2L2tlcm5lbC9hcG0uYyAxLjY3IHZzIGVkaXRlZCA9PT09PQotLS0gMS42
Ny9hcmNoL2kzODYva2VybmVsL2FwbS5jCTIwMDQtMDgtMjQgMTc6MDg6NDcgKzA4OjAwCisrKyBl
ZGl0ZWQvYXJjaC9pMzg2L2tlcm5lbC9hcG0uYwkyMDA0LTA5LTA4IDA4OjQ4OjEyICswODowMApA
QCAtMjM2Miw4ICsyMzYyLDEzIEBAIHN0YXRpYyB2b2lkIF9fZXhpdCBhcG1fZXhpdCh2b2lkKQog
ewogCWludAllcnJvcjsKIAotCWlmIChzZXRfcG1faWRsZSkKKwlpZiAoc2V0X3BtX2lkbGUpIHsK
IAkJcG1faWRsZSA9IG9yaWdpbmFsX3BtX2lkbGU7CisJCS8qIFdhaXQgdGhlIGlkbGUgdGhyZWFk
IHRvIHJlYWQgdGhlIG5ldyB2YWx1ZSwgCisJCSAqIG90aGVyd2lzZSB3ZSBPb3BzLgorCQkgKi8K
KwkJc3luY2hyb25pemVfa2VybmVsKCk7CisJfQogCWlmICgoKGFwbV9pbmZvLmJpb3MuZmxhZ3Mg
JiBBUE1fQklPU19ESVNFTkdBR0VEKSA9PSAwKQogCSAgICAmJiAoYXBtX2luZm8uY29ubmVjdGlv
bl92ZXJzaW9uID4gMHgwMTAwKSkgewogCQllcnJvciA9IGFwbV9lbmdhZ2VfcG93ZXJfbWFuYWdl
bWVudChBUE1fREVWSUNFX0FMTCwgMCk7Cj09PT09IGFyY2gvaTM4Ni9rZXJuZWwvcHJvY2Vzcy5j
IDEuNzUgdnMgZWRpdGVkID09PT09Ci0tLSAxLjc1L2FyY2gvaTM4Ni9rZXJuZWwvcHJvY2Vzcy5j
CTIwMDQtMDgtMjQgMTc6MDg6NDQgKzA4OjAwCisrKyBlZGl0ZWQvYXJjaC9pMzg2L2tlcm5lbC9w
cm9jZXNzLmMJMjAwNC0wOS0wOCAwOTowMDowNiArMDg6MDAKQEAgLTE0Miw2ICsxNDIsMTAgQEAg
dm9pZCBjcHVfaWRsZSAodm9pZCkKIAkvKiBlbmRsZXNzIGlkbGUgbG9vcCB3aXRoIG5vIHByaW9y
aXR5IGF0IGFsbCAqLwogCXdoaWxlICgxKSB7CiAJCXdoaWxlICghbmVlZF9yZXNjaGVkKCkpIHsK
KwkJCS8qIElmIHBtX2lkbGUgaXMgaW4gYSBtb2R1bGUgYW5kIGlzIHByZWVtcHRlZCwKKwkJCSAq
IG9vcHMgb2NjdXJzLiBEaXNhYmxlIHByZWVtcHQuCisJCQkgKi8KKwkJCXJjdV9yZWFkX2xvY2so
KTsKIAkJCXZvaWQgKCppZGxlKSh2b2lkKSA9IHBtX2lkbGU7CiAKIAkJCWlmICghaWRsZSkKQEAg
LTE0OSw2ICsxNTMsNyBAQCB2b2lkIGNwdV9pZGxlICh2b2lkKQogCiAJCQlpcnFfc3RhdFtzbXBf
cHJvY2Vzc29yX2lkKCldLmlkbGVfdGltZXN0YW1wID0gamlmZmllczsKIAkJCWlkbGUoKTsKKwkJ
CXJjdV9yZWFkX3VubG9jaygpOwogCQl9CiAJCXNjaGVkdWxlKCk7CiAJfQo9PT09PSBhcmNoL2lh
NjQva2VybmVsL3Byb2Nlc3MuYyAxLjYyIHZzIGVkaXRlZCA9PT09PQotLS0gMS42Mi9hcmNoL2lh
NjQva2VybmVsL3Byb2Nlc3MuYwkyMDA0LTA3LTI3IDEzOjI2OjUwICswODowMAorKysgZWRpdGVk
L2FyY2gvaWE2NC9rZXJuZWwvcHJvY2Vzcy5jCTIwMDQtMDktMDggMDk6MDQ6NTggKzA4OjAwCkBA
IC0yMjgsMTggKzIyOCwyNCBAQCBjcHVfaWRsZSAodm9pZCAqdW51c2VkKQogCiAJLyogZW5kbGVz
cyBpZGxlIGxvb3Agd2l0aCBubyBwcmlvcml0eSBhdCBhbGwgKi8KIAl3aGlsZSAoMSkgewotCQl2
b2lkICgqaWRsZSkodm9pZCkgPSBwbV9pZGxlOwotCQlpZiAoIWlkbGUpCi0JCQlpZGxlID0gZGVm
YXVsdF9pZGxlOwotCiAjaWZkZWYgQ09ORklHX1NNUAogCQlpZiAoIW5lZWRfcmVzY2hlZCgpKQog
CQkJbWluX3h0cCgpOwogI2VuZGlmCiAJCXdoaWxlICghbmVlZF9yZXNjaGVkKCkpIHsKKwkJCXZv
aWQgKCppZGxlKSh2b2lkKTsKKwkJCQogCQkJaWYgKG1hcmtfaWRsZSkKIAkJCQkoKm1hcmtfaWRs
ZSkoMSk7CisJCQkvKiBJZiBwbV9pZGxlIGlzIGluIGEgbW9kdWxlIGFuZCBpcyBwcmVlbXB0ZWQs
CisJCQkgKiBvb3BzIG9jY3Vycy4gRGlzYWJsZSBwcmVlbXB0LgorCQkJICovCisJCQlyY3VfcmVh
ZF9sb2NrKCk7CisJCQlpZGxlPSBwbV9pZGxlOworCQkJaWYgKCFpZGxlKQorCQkJCWlkbGUgPSBk
ZWZhdWx0X2lkbGU7CiAJCQkoKmlkbGUpKCk7CisJCQlyY3VfcmVhZF91bmxvY2soKTsKIAkJfQog
CiAJCWlmIChtYXJrX2lkbGUpCj09PT09IGFyY2gveDg2XzY0L2tlcm5lbC9wcm9jZXNzLmMgMS4z
NSB2cyBlZGl0ZWQgPT09PT0KLS0tIDEuMzUvYXJjaC94ODZfNjQva2VybmVsL3Byb2Nlc3MuYwky
MDA0LTA4LTI0IDE3OjA4OjQ0ICswODowMAorKysgZWRpdGVkL2FyY2gveDg2XzY0L2tlcm5lbC9w
cm9jZXNzLmMJMjAwNC0wOS0wOCAwOTowNDozMSArMDg6MDAKQEAgLTEzMCwxMSArMTMwLDE4IEBA
IHZvaWQgY3B1X2lkbGUgKHZvaWQpCiB7CiAJLyogZW5kbGVzcyBpZGxlIGxvb3Agd2l0aCBubyBw
cmlvcml0eSBhdCBhbGwgKi8KIAl3aGlsZSAoMSkgewotCQl2b2lkICgqaWRsZSkodm9pZCkgPSBw
bV9pZGxlOwotCQlpZiAoIWlkbGUpCi0JCQlpZGxlID0gZGVmYXVsdF9pZGxlOwotCQl3aGlsZSAo
IW5lZWRfcmVzY2hlZCgpKQorCQl3aGlsZSAoIW5lZWRfcmVzY2hlZCgpKSB7CisJCQl2b2lkICgq
aWRsZSkodm9pZCk7CisJCQkvKiBJZiBwbV9pZGxlIGlzIGluIGEgbW9kdWxlIGFuZCBpcyBwcmVl
bXB0ZWQsCisJCQkgKiBvb3BzIG9jY3Vycy4gRGlzYWJsZSBwcmVlbXB0LgorCQkJICovCisJCQly
Y3VfcmVhZF9sb2NrKCk7CisJCQlpZGxlID0gcG1faWRsZTsKKwkJCWlmICghaWRsZSkKKwkJCQlp
ZGxlID0gZGVmYXVsdF9pZGxlOwogCQkJaWRsZSgpOworCQkJcmN1X3JlYWRfdW5sb2NrKCk7CisJ
CX0KIAkJc2NoZWR1bGUoKTsKIAl9CiB9Cj09PT09IGRyaXZlcnMvYWNwaS9wcm9jZXNzb3IuYyAx
LjYxIHZzIGVkaXRlZCA9PT09PQotLS0gMS42MS9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yLmMJMjAw
NC0wOC0zMSAyMzoyNzoyOSArMDg6MDAKKysrIGVkaXRlZC9kcml2ZXJzL2FjcGkvcHJvY2Vzc29y
LmMJMjAwNC0wOS0wOCAwOToxMjozNCArMDg6MDAKQEAgLTI0MTksNiArMjQxOSw5IEBAIGFjcGlf
cHJvY2Vzc29yX3JlbW92ZSAoCiAJLyogVW5yZWdpc3RlciB0aGUgaWRsZSBoYW5kbGVyIHdoZW4g
cHJvY2Vzc29yICMwIGlzIHJlbW92ZWQuICovCiAJaWYgKHByLT5pZCA9PSAwKSB7CiAJCXBtX2lk
bGUgPSBwbV9pZGxlX3NhdmU7CisJCS8qIFdhaXQgdGhlIGlkbGUgdGhyZWFkIHRvIHJlYWQgdGhl
IG5ldyB2YWx1ZSwKKwkJICogb3RoZXJ3aXNlIHdlIE9vcHMuCisJCSAqLwogCQlzeW5jaHJvbml6
ZV9rZXJuZWwoKTsKIAl9CiAK

------_=_NextPart_001_01C49607.5AA37C24--
