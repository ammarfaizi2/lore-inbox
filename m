Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269339AbUIIDVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269339AbUIIDVY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 23:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269301AbUIIDVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 23:21:17 -0400
Received: from fmr05.intel.com ([134.134.136.6]:59815 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S269262AbUIIDSp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 23:18:45 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4961B.AE303E83"
Subject: RE: [ACPI] Re: [PATCH] Oops and panic while unloading holder of pm_idle
Date: Thu, 9 Sep 2004 11:18:28 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD30575168C7A@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] Re: [PATCH] Oops and panic while unloading holder of pm_idle
Thread-Index: AcSWCekEs2ePwPUFSqqryGE0IydYXAAEN2oQ
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Zwane Mwaikambo" <zwane@linuxpower.ca>
Cc: "BlaisorBlade" <blaisorblade_spam@yahoo.it>,
       <acpi-devel@lists.sourceforge.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>
X-OriginalArrivalTime: 09 Sep 2004 03:18:30.0953 (UTC) FILETIME=[AE863190:01C4961B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4961B.AE303E83
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

On Thursday, September 09, 2004, Zwane Mwaikambo wrote:
>Hello Shaohua,
>
>> +		/* Wait the idle thread to read the new value,
>> +		 * otherwise we Oops.
>> +		 */
>
>I should have mentioned this earlier, but the comment needs work,
>something like this;
>
>"We are about to unload the current idle thread pm callback (pm_idle),
> Wait for all processors to update cached/local copies of pm_idle
before
> proceeding."
>
>> +			/* If pm_idle is in a module and is preempted,
>> +			 * oops occurs. Disable preempt.
>> +			 */
>
>"Mark this as an RCU critical section so that synchronize_kernel() in
the
> unload path waits for our completion."
>
>Then resend the patch, i swear it'll be the last time ;)
Zwane,
It's fine. Here is the updated patch.

Thanks,
Shaohua

Signed-off-by: Li Shaohua <shaohua.li@intel.com>
=3D=3D=3D=3D=3D arch/i386/kernel/apm.c 1.67 vs edited =3D=3D=3D=3D=3D
--- 1.67/arch/i386/kernel/apm.c	2004-08-24 17:08:47 +08:00
+++ edited/arch/i386/kernel/apm.c	2004-09-09 10:57:16 +08:00
@@ -2362,8 +2362,15 @@ static void __exit apm_exit(void)
 {
 	int	error;
=20
-	if (set_pm_idle)
+	if (set_pm_idle) {
 		pm_idle =3D original_pm_idle;
+		/*
+		 * We are about to unload the current idle thread pm
callback=20
+		 * (pm_idle), Wait for all processors to update
cached/local=20
+		 * copies of pm_idle before proceeding.
+		 */
+		synchronize_kernel();
+	}
 	if (((apm_info.bios.flags & APM_BIOS_DISENGAGED) =3D=3D 0)
 	    && (apm_info.connection_version > 0x0100)) {
 		error =3D apm_engage_power_management(APM_DEVICE_ALL, 0);
=3D=3D=3D=3D=3D arch/i386/kernel/process.c 1.75 vs edited =
=3D=3D=3D=3D=3D
--- 1.75/arch/i386/kernel/process.c	2004-08-24 17:08:44 +08:00
+++ edited/arch/i386/kernel/process.c	2004-09-09 10:59:47 +08:00
@@ -142,6 +142,12 @@ void cpu_idle (void)
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched()) {
+			/*
+			 * Mark this as an RCU critical section so that
+			 * synchronize_kernel() in the unload path waits
+			 * for our completion.
+			 */
+			rcu_read_lock();
 			void (*idle)(void) =3D pm_idle;
=20
 			if (!idle)
@@ -149,6 +155,7 @@ void cpu_idle (void)
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
+++ edited/arch/ia64/kernel/process.c	2004-09-09 11:01:12 +08:00
@@ -228,18 +228,26 @@ cpu_idle (void *unused)
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
+			/*
+			 * Mark this as an RCU critical section so that
+			 * synchronize_kernel() in the unload path waits
+			 * for our completion.
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
+++ edited/arch/x86_64/kernel/process.c	2004-09-09 11:01:57 +08:00
@@ -130,11 +130,20 @@ void cpu_idle (void)
 {
 	/* endless idle loop with no priority at all */
 	while (1) {
-		void (*idle)(void) =3D pm_idle;
-		if (!idle)
-			idle =3D default_idle;
-		while (!need_resched())
+		while (!need_resched()) {
+			void (*idle)(void);
+			/*
+			 * Mark this as an RCU critical section so that
+			 * synchronize_kernel() in the unload path waits
+			 * for our completion.
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
+++ edited/drivers/acpi/processor.c	2004-09-09 11:02:56 +08:00
@@ -2419,6 +2419,11 @@ acpi_processor_remove (
 	/* Unregister the idle handler when processor #0 is removed. */
 	if (pr->id =3D=3D 0) {
 		pm_idle =3D pm_idle_save;
+		/*
+		 * We are about to unload the current idle thread pm
callback
+		 * (pm_idle), Wait for all processors to update
cached/local
+		 * copies of pm_idle before proceeding.
+		 */
 		synchronize_kernel();
 	}

 <<idle.patch>>=20

------_=_NextPart_001_01C4961B.AE303E83
Content-Type: application/octet-stream;
	name="idle.patch"
Content-Transfer-Encoding: base64
Content-Description: idle.patch
Content-Disposition: attachment;
	filename="idle.patch"

PT09PT0gYXJjaC9pMzg2L2tlcm5lbC9hcG0uYyAxLjY3IHZzIGVkaXRlZCA9PT09PQotLS0gMS42
Ny9hcmNoL2kzODYva2VybmVsL2FwbS5jCTIwMDQtMDgtMjQgMTc6MDg6NDcgKzA4OjAwCisrKyBl
ZGl0ZWQvYXJjaC9pMzg2L2tlcm5lbC9hcG0uYwkyMDA0LTA5LTA5IDEwOjU3OjE2ICswODowMApA
QCAtMjM2Miw4ICsyMzYyLDE1IEBAIHN0YXRpYyB2b2lkIF9fZXhpdCBhcG1fZXhpdCh2b2lkKQog
ewogCWludAllcnJvcjsKIAotCWlmIChzZXRfcG1faWRsZSkKKwlpZiAoc2V0X3BtX2lkbGUpIHsK
IAkJcG1faWRsZSA9IG9yaWdpbmFsX3BtX2lkbGU7CisJCS8qCisJCSAqIFdlIGFyZSBhYm91dCB0
byB1bmxvYWQgdGhlIGN1cnJlbnQgaWRsZSB0aHJlYWQgcG0gY2FsbGJhY2sgCisJCSAqIChwbV9p
ZGxlKSwgV2FpdCBmb3IgYWxsIHByb2Nlc3NvcnMgdG8gdXBkYXRlIGNhY2hlZC9sb2NhbCAKKwkJ
ICogY29waWVzIG9mIHBtX2lkbGUgYmVmb3JlIHByb2NlZWRpbmcuCisJCSAqLworCQlzeW5jaHJv
bml6ZV9rZXJuZWwoKTsKKwl9CiAJaWYgKCgoYXBtX2luZm8uYmlvcy5mbGFncyAmIEFQTV9CSU9T
X0RJU0VOR0FHRUQpID09IDApCiAJICAgICYmIChhcG1faW5mby5jb25uZWN0aW9uX3ZlcnNpb24g
PiAweDAxMDApKSB7CiAJCWVycm9yID0gYXBtX2VuZ2FnZV9wb3dlcl9tYW5hZ2VtZW50KEFQTV9E
RVZJQ0VfQUxMLCAwKTsKPT09PT0gYXJjaC9pMzg2L2tlcm5lbC9wcm9jZXNzLmMgMS43NSB2cyBl
ZGl0ZWQgPT09PT0KLS0tIDEuNzUvYXJjaC9pMzg2L2tlcm5lbC9wcm9jZXNzLmMJMjAwNC0wOC0y
NCAxNzowODo0NCArMDg6MDAKKysrIGVkaXRlZC9hcmNoL2kzODYva2VybmVsL3Byb2Nlc3MuYwky
MDA0LTA5LTA5IDEwOjU5OjQ3ICswODowMApAQCAtMTQyLDYgKzE0MiwxMiBAQCB2b2lkIGNwdV9p
ZGxlICh2b2lkKQogCS8qIGVuZGxlc3MgaWRsZSBsb29wIHdpdGggbm8gcHJpb3JpdHkgYXQgYWxs
ICovCiAJd2hpbGUgKDEpIHsKIAkJd2hpbGUgKCFuZWVkX3Jlc2NoZWQoKSkgeworCQkJLyoKKwkJ
CSAqIE1hcmsgdGhpcyBhcyBhbiBSQ1UgY3JpdGljYWwgc2VjdGlvbiBzbyB0aGF0CisJCQkgKiBz
eW5jaHJvbml6ZV9rZXJuZWwoKSBpbiB0aGUgdW5sb2FkIHBhdGggd2FpdHMKKwkJCSAqIGZvciBv
dXIgY29tcGxldGlvbi4KKwkJCSAqLworCQkJcmN1X3JlYWRfbG9jaygpOwogCQkJdm9pZCAoKmlk
bGUpKHZvaWQpID0gcG1faWRsZTsKIAogCQkJaWYgKCFpZGxlKQpAQCAtMTQ5LDYgKzE1NSw3IEBA
IHZvaWQgY3B1X2lkbGUgKHZvaWQpCiAKIAkJCWlycV9zdGF0W3NtcF9wcm9jZXNzb3JfaWQoKV0u
aWRsZV90aW1lc3RhbXAgPSBqaWZmaWVzOwogCQkJaWRsZSgpOworCQkJcmN1X3JlYWRfdW5sb2Nr
KCk7CiAJCX0KIAkJc2NoZWR1bGUoKTsKIAl9Cj09PT09IGFyY2gvaWE2NC9rZXJuZWwvcHJvY2Vz
cy5jIDEuNjIgdnMgZWRpdGVkID09PT09Ci0tLSAxLjYyL2FyY2gvaWE2NC9rZXJuZWwvcHJvY2Vz
cy5jCTIwMDQtMDctMjcgMTM6MjY6NTAgKzA4OjAwCisrKyBlZGl0ZWQvYXJjaC9pYTY0L2tlcm5l
bC9wcm9jZXNzLmMJMjAwNC0wOS0wOSAxMTowMToxMiArMDg6MDAKQEAgLTIyOCwxOCArMjI4LDI2
IEBAIGNwdV9pZGxlICh2b2lkICp1bnVzZWQpCiAKIAkvKiBlbmRsZXNzIGlkbGUgbG9vcCB3aXRo
IG5vIHByaW9yaXR5IGF0IGFsbCAqLwogCXdoaWxlICgxKSB7Ci0JCXZvaWQgKCppZGxlKSh2b2lk
KSA9IHBtX2lkbGU7Ci0JCWlmICghaWRsZSkKLQkJCWlkbGUgPSBkZWZhdWx0X2lkbGU7Ci0KICNp
ZmRlZiBDT05GSUdfU01QCiAJCWlmICghbmVlZF9yZXNjaGVkKCkpCiAJCQltaW5feHRwKCk7CiAj
ZW5kaWYKIAkJd2hpbGUgKCFuZWVkX3Jlc2NoZWQoKSkgeworCQkJdm9pZCAoKmlkbGUpKHZvaWQp
OworCQkJCiAJCQlpZiAobWFya19pZGxlKQogCQkJCSgqbWFya19pZGxlKSgxKTsKKwkJCS8qCisJ
CQkgKiBNYXJrIHRoaXMgYXMgYW4gUkNVIGNyaXRpY2FsIHNlY3Rpb24gc28gdGhhdAorCQkJICog
c3luY2hyb25pemVfa2VybmVsKCkgaW4gdGhlIHVubG9hZCBwYXRoIHdhaXRzCisJCQkgKiBmb3Ig
b3VyIGNvbXBsZXRpb24uCisJCQkgKi8KKwkJCXJjdV9yZWFkX2xvY2soKTsKKwkJCWlkbGU9IHBt
X2lkbGU7CisJCQlpZiAoIWlkbGUpCisJCQkJaWRsZSA9IGRlZmF1bHRfaWRsZTsKIAkJCSgqaWRs
ZSkoKTsKKwkJCXJjdV9yZWFkX3VubG9jaygpOwogCQl9CiAKIAkJaWYgKG1hcmtfaWRsZSkKPT09
PT0gYXJjaC94ODZfNjQva2VybmVsL3Byb2Nlc3MuYyAxLjM1IHZzIGVkaXRlZCA9PT09PQotLS0g
MS4zNS9hcmNoL3g4Nl82NC9rZXJuZWwvcHJvY2Vzcy5jCTIwMDQtMDgtMjQgMTc6MDg6NDQgKzA4
OjAwCisrKyBlZGl0ZWQvYXJjaC94ODZfNjQva2VybmVsL3Byb2Nlc3MuYwkyMDA0LTA5LTA5IDEx
OjAxOjU3ICswODowMApAQCAtMTMwLDExICsxMzAsMjAgQEAgdm9pZCBjcHVfaWRsZSAodm9pZCkK
IHsKIAkvKiBlbmRsZXNzIGlkbGUgbG9vcCB3aXRoIG5vIHByaW9yaXR5IGF0IGFsbCAqLwogCXdo
aWxlICgxKSB7Ci0JCXZvaWQgKCppZGxlKSh2b2lkKSA9IHBtX2lkbGU7Ci0JCWlmICghaWRsZSkK
LQkJCWlkbGUgPSBkZWZhdWx0X2lkbGU7Ci0JCXdoaWxlICghbmVlZF9yZXNjaGVkKCkpCisJCXdo
aWxlICghbmVlZF9yZXNjaGVkKCkpIHsKKwkJCXZvaWQgKCppZGxlKSh2b2lkKTsKKwkJCS8qCisJ
CQkgKiBNYXJrIHRoaXMgYXMgYW4gUkNVIGNyaXRpY2FsIHNlY3Rpb24gc28gdGhhdAorCQkJICog
c3luY2hyb25pemVfa2VybmVsKCkgaW4gdGhlIHVubG9hZCBwYXRoIHdhaXRzCisJCQkgKiBmb3Ig
b3VyIGNvbXBsZXRpb24uCisJCQkgKi8KKwkJCXJjdV9yZWFkX2xvY2soKTsKKwkJCWlkbGUgPSBw
bV9pZGxlOworCQkJaWYgKCFpZGxlKQorCQkJCWlkbGUgPSBkZWZhdWx0X2lkbGU7CiAJCQlpZGxl
KCk7CisJCQlyY3VfcmVhZF91bmxvY2soKTsKKwkJfQogCQlzY2hlZHVsZSgpOwogCX0KIH0KPT09
PT0gZHJpdmVycy9hY3BpL3Byb2Nlc3Nvci5jIDEuNjEgdnMgZWRpdGVkID09PT09Ci0tLSAxLjYx
L2RyaXZlcnMvYWNwaS9wcm9jZXNzb3IuYwkyMDA0LTA4LTMxIDIzOjI3OjI5ICswODowMAorKysg
ZWRpdGVkL2RyaXZlcnMvYWNwaS9wcm9jZXNzb3IuYwkyMDA0LTA5LTA5IDExOjAyOjU2ICswODow
MApAQCAtMjQxOSw2ICsyNDE5LDExIEBAIGFjcGlfcHJvY2Vzc29yX3JlbW92ZSAoCiAJLyogVW5y
ZWdpc3RlciB0aGUgaWRsZSBoYW5kbGVyIHdoZW4gcHJvY2Vzc29yICMwIGlzIHJlbW92ZWQuICov
CiAJaWYgKHByLT5pZCA9PSAwKSB7CiAJCXBtX2lkbGUgPSBwbV9pZGxlX3NhdmU7CisJCS8qCisJ
CSAqIFdlIGFyZSBhYm91dCB0byB1bmxvYWQgdGhlIGN1cnJlbnQgaWRsZSB0aHJlYWQgcG0gY2Fs
bGJhY2sKKwkJICogKHBtX2lkbGUpLCBXYWl0IGZvciBhbGwgcHJvY2Vzc29ycyB0byB1cGRhdGUg
Y2FjaGVkL2xvY2FsCisJCSAqIGNvcGllcyBvZiBwbV9pZGxlIGJlZm9yZSBwcm9jZWVkaW5nLgor
CQkgKi8KIAkJc3luY2hyb25pemVfa2VybmVsKCk7CiAJfQogCg==

------_=_NextPart_001_01C4961B.AE303E83--
