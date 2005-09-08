Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932680AbVIHPRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932680AbVIHPRB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbVIHPRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:17:01 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:62819
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932680AbVIHPQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:16:59 -0400
Message-Id: <4320724C020000780002447D@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 17:18:04 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] move i386's enabling of fxsr and xmmxcpt
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part61430F3C.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part61430F3C.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Move some code unrelated to any dealing with hardware bugs from i386's
bugs.h to a more logical place.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/arch/i386/kernel/traps.c
2.6.13-i386-fxsr/arch/i386/kernel/traps.c
--- 2.6.13/arch/i386/kernel/traps.c	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-i386-fxsr/arch/i386/kernel/traps.c	2005-09-07
11:46:35.000000000 +0200
@@ -1098,6 +1098,24 @@ void __init trap_init(void)
 #endif
 	set_trap_gate(19,&simd_coprocessor_error);
 
+	if (cpu_has_fxsr) {
+		/*
+		 * Verify that the FXSAVE/FXRSTOR data will be 16-byte
aligned.
+		 */
+		struct fxsrAlignAssert {
+			int _:!(offsetof(struct task_struct,
thread.i387.fxsave) & 15);
+		};
+
+		printk(KERN_INFO "Enabling fast FPU save and restore...
");
+		set_in_cr4(X86_CR4_OSFXSR);
+		printk("done.\n");
+	}
+	if (cpu_has_xmm) {
+		printk(KERN_INFO "Enabling unmasked SIMD FPU exception
support... ");
+		set_in_cr4(X86_CR4_OSXMMEXCPT);
+		printk("done.\n");
+	}
+
 	set_system_gate(SYSCALL_VECTOR,&system_call);
 
 	/*
diff -Npru 2.6.13/include/asm-i386/bugs.h
2.6.13-i386-fxsr/include/asm-i386/bugs.h
--- 2.6.13/include/asm-i386/bugs.h	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-i386-fxsr/include/asm-i386/bugs.h	2005-09-01
11:32:11.000000000 +0200
@@ -8,9 +8,6 @@
  *        <rreilova@ececs.uc.edu>
  *	- Channing Corn (tests & fixes),
  *	- Andrew D. Balsa (code cleanup).
- *
- *  Pentium III FXSR, SSE support
- *	Gareth Hughes <gareth@valinux.com>, May 2000
  */
 
 /*
@@ -76,25 +73,7 @@ static void __init check_fpu(void)
 		return;
 	}
 
-/* Enable FXSR and company _before_ testing for FP problems. */
-	/*
-	 * Verify that the FXSAVE/FXRSTOR data will be 16-byte aligned.
-	 */
-	if (offsetof(struct task_struct, thread.i387.fxsave) & 15) {
-		extern void __buggy_fxsr_alignment(void);
-		__buggy_fxsr_alignment();
-	}
-	if (cpu_has_fxsr) {
-		printk(KERN_INFO "Enabling fast FPU save and restore...
");
-		set_in_cr4(X86_CR4_OSFXSR);
-		printk("done.\n");
-	}
-	if (cpu_has_xmm) {
-		printk(KERN_INFO "Enabling unmasked SIMD FPU exception
support... ");
-		set_in_cr4(X86_CR4_OSXMMEXCPT);
-		printk("done.\n");
-	}
-
+/* trap_init() enabled FXSR and company _before_ testing for FP
problems here. */
 	/* Test for the divl bug.. */
 	__asm__("fninit\n\t"
 		"fldl %1\n\t"


--=__Part61430F3C.0__=
Content-Type: application/octet-stream; name="linux-2.6.13-i386-fxsr.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-i386-fxsr.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKCk1vdmUgc29tZSBjb2RlIHVucmVsYXRlZCB0
byBhbnkgZGVhbGluZyB3aXRoIGhhcmR3YXJlIGJ1Z3MgZnJvbSBpMzg2J3MKYnVncy5oIHRvIGEg
bW9yZSBsb2dpY2FsIHBsYWNlLgoKU2lnbmVkLW9mZi1ieTogSmFuIEJldWxpY2ggPGpiZXVsaWNo
QG5vdmVsbC5jb20+CgpkaWZmIC1OcHJ1IDIuNi4xMy9hcmNoL2kzODYva2VybmVsL3RyYXBzLmMg
Mi42LjEzLWkzODYtZnhzci9hcmNoL2kzODYva2VybmVsL3RyYXBzLmMKLS0tIDIuNi4xMy9hcmNo
L2kzODYva2VybmVsL3RyYXBzLmMJMjAwNS0wOC0yOSAwMTo0MTowMS4wMDAwMDAwMDAgKzAyMDAK
KysrIDIuNi4xMy1pMzg2LWZ4c3IvYXJjaC9pMzg2L2tlcm5lbC90cmFwcy5jCTIwMDUtMDktMDcg
MTE6NDY6MzUuMDAwMDAwMDAwICswMjAwCkBAIC0xMDk4LDYgKzEwOTgsMjQgQEAgdm9pZCBfX2lu
aXQgdHJhcF9pbml0KHZvaWQpCiAjZW5kaWYKIAlzZXRfdHJhcF9nYXRlKDE5LCZzaW1kX2NvcHJv
Y2Vzc29yX2Vycm9yKTsKIAorCWlmIChjcHVfaGFzX2Z4c3IpIHsKKwkJLyoKKwkJICogVmVyaWZ5
IHRoYXQgdGhlIEZYU0FWRS9GWFJTVE9SIGRhdGEgd2lsbCBiZSAxNi1ieXRlIGFsaWduZWQuCisJ
CSAqLworCQlzdHJ1Y3QgZnhzckFsaWduQXNzZXJ0IHsKKwkJCWludCBfOiEob2Zmc2V0b2Yoc3Ry
dWN0IHRhc2tfc3RydWN0LCB0aHJlYWQuaTM4Ny5meHNhdmUpICYgMTUpOworCQl9OworCisJCXBy
aW50ayhLRVJOX0lORk8gIkVuYWJsaW5nIGZhc3QgRlBVIHNhdmUgYW5kIHJlc3RvcmUuLi4gIik7
CisJCXNldF9pbl9jcjQoWDg2X0NSNF9PU0ZYU1IpOworCQlwcmludGsoImRvbmUuXG4iKTsKKwl9
CisJaWYgKGNwdV9oYXNfeG1tKSB7CisJCXByaW50ayhLRVJOX0lORk8gIkVuYWJsaW5nIHVubWFz
a2VkIFNJTUQgRlBVIGV4Y2VwdGlvbiBzdXBwb3J0Li4uICIpOworCQlzZXRfaW5fY3I0KFg4Nl9D
UjRfT1NYTU1FWENQVCk7CisJCXByaW50aygiZG9uZS5cbiIpOworCX0KKwogCXNldF9zeXN0ZW1f
Z2F0ZShTWVNDQUxMX1ZFQ1RPUiwmc3lzdGVtX2NhbGwpOwogCiAJLyoKZGlmZiAtTnBydSAyLjYu
MTMvaW5jbHVkZS9hc20taTM4Ni9idWdzLmggMi42LjEzLWkzODYtZnhzci9pbmNsdWRlL2FzbS1p
Mzg2L2J1Z3MuaAotLS0gMi42LjEzL2luY2x1ZGUvYXNtLWkzODYvYnVncy5oCTIwMDUtMDgtMjkg
MDE6NDE6MDEuMDAwMDAwMDAwICswMjAwCisrKyAyLjYuMTMtaTM4Ni1meHNyL2luY2x1ZGUvYXNt
LWkzODYvYnVncy5oCTIwMDUtMDktMDEgMTE6MzI6MTEuMDAwMDAwMDAwICswMjAwCkBAIC04LDkg
KzgsNiBAQAogICogICAgICAgIDxycmVpbG92YUBlY2Vjcy51Yy5lZHU+CiAgKgktIENoYW5uaW5n
IENvcm4gKHRlc3RzICYgZml4ZXMpLAogICoJLSBBbmRyZXcgRC4gQmFsc2EgKGNvZGUgY2xlYW51
cCkuCi0gKgotICogIFBlbnRpdW0gSUlJIEZYU1IsIFNTRSBzdXBwb3J0Ci0gKglHYXJldGggSHVn
aGVzIDxnYXJldGhAdmFsaW51eC5jb20+LCBNYXkgMjAwMAogICovCiAKIC8qCkBAIC03NiwyNSAr
NzMsNyBAQCBzdGF0aWMgdm9pZCBfX2luaXQgY2hlY2tfZnB1KHZvaWQpCiAJCXJldHVybjsKIAl9
CiAKLS8qIEVuYWJsZSBGWFNSIGFuZCBjb21wYW55IF9iZWZvcmVfIHRlc3RpbmcgZm9yIEZQIHBy
b2JsZW1zLiAqLwotCS8qCi0JICogVmVyaWZ5IHRoYXQgdGhlIEZYU0FWRS9GWFJTVE9SIGRhdGEg
d2lsbCBiZSAxNi1ieXRlIGFsaWduZWQuCi0JICovCi0JaWYgKG9mZnNldG9mKHN0cnVjdCB0YXNr
X3N0cnVjdCwgdGhyZWFkLmkzODcuZnhzYXZlKSAmIDE1KSB7Ci0JCWV4dGVybiB2b2lkIF9fYnVn
Z3lfZnhzcl9hbGlnbm1lbnQodm9pZCk7Ci0JCV9fYnVnZ3lfZnhzcl9hbGlnbm1lbnQoKTsKLQl9
Ci0JaWYgKGNwdV9oYXNfZnhzcikgewotCQlwcmludGsoS0VSTl9JTkZPICJFbmFibGluZyBmYXN0
IEZQVSBzYXZlIGFuZCByZXN0b3JlLi4uICIpOwotCQlzZXRfaW5fY3I0KFg4Nl9DUjRfT1NGWFNS
KTsKLQkJcHJpbnRrKCJkb25lLlxuIik7Ci0JfQotCWlmIChjcHVfaGFzX3htbSkgewotCQlwcmlu
dGsoS0VSTl9JTkZPICJFbmFibGluZyB1bm1hc2tlZCBTSU1EIEZQVSBleGNlcHRpb24gc3VwcG9y
dC4uLiAiKTsKLQkJc2V0X2luX2NyNChYODZfQ1I0X09TWE1NRVhDUFQpOwotCQlwcmludGsoImRv
bmUuXG4iKTsKLQl9Ci0KKy8qIHRyYXBfaW5pdCgpIGVuYWJsZWQgRlhTUiBhbmQgY29tcGFueSBf
YmVmb3JlXyB0ZXN0aW5nIGZvciBGUCBwcm9ibGVtcyBoZXJlLiAqLwogCS8qIFRlc3QgZm9yIHRo
ZSBkaXZsIGJ1Zy4uICovCiAJX19hc21fXygiZm5pbml0XG5cdCIKIAkJImZsZGwgJTFcblx0Igo=

--=__Part61430F3C.0__=--
