Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbTIECUP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 22:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbTIECUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 22:20:15 -0400
Received: from fmr09.intel.com ([192.52.57.35]:4339 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261737AbTIECTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 22:19:49 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C37354.2C91D90E"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: [PATCH] idle using PNI monitor/mwait (take 2)
Date: Thu, 4 Sep 2003 19:19:45 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304A727@scsmsx402.sc.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] idle using PNI monitor/mwait (take 2)
Thread-Index: AcNzVCvwqsBiSQwIR2Opgt70/SxEFQ==
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
X-OriginalArrivalTime: 05 Sep 2003 02:19:46.0795 (UTC) FILETIME=[2D1EDBB0:01C37354]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C37354.2C91D90E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Attached is a patch that enables PNI (Prescott New Instructions)
monitor/mwait in the kernel idle. It is for mm4, but it should apply to
mm5.=20

Thanks,
Jun

-------
diff -purN linux-2.6.0-test4-mm4/arch/i386/kernel/cpu/intel.c
linux-2.6.0-test4-mm4-mwait/arch/i386/kernel/cpu/intel.c
--- linux-2.6.0-test4-mm4/arch/i386/kernel/cpu/intel.c	2003-09-02
17:56:48.000000000 -0700
+++ linux-2.6.0-test4-mm4-mwait/arch/i386/kernel/cpu/intel.c
2003-09-03 12:12:56.000000000 -0700
@@ -12,6 +12,8 @@
=20
 #include "cpu.h"
=20
+extern void select_idle_routine(const struct cpuinfo_x86 *c);
+
 #ifdef CONFIG_X86_INTEL_USERCOPY
 /*
  * Alignment at which movsl is preferred for bulk memory copies.
@@ -163,7 +165,7 @@ static void __init init_intel(struct cpu
 	}
 #endif
=20
-
+	select_idle_routine(c);
 	if (c->cpuid_level > 1) {
 		/* supports eax=3D2  call */
 		int i, j, n;
diff -purN linux-2.6.0-test4-mm4/arch/i386/kernel/process.c
linux-2.6.0-test4-mm4-mwait/arch/i386/kernel/process.c
--- linux-2.6.0-test4-mm4/arch/i386/kernel/process.c	2003-09-02
17:56:48.000000000 -0700
+++ linux-2.6.0-test4-mm4-mwait/arch/i386/kernel/process.c
2003-09-02 20:18:47.000000000 -0700
@@ -152,11 +152,56 @@ void cpu_idle (void)
 	}
 }
=20
+/*
+ * This uses new MONITOR/MWAIT instructions on P4 processors with PNI,=20
+ * which can obviate IPI to trigger checking of need_resched.
+ * We execute MONITOR against need_resched and enter optimized wait
state=20
+ * through MWAIT. Whenever someone changes need_resched, we would be
woken=20
+ * up from MWAIT (without an IPI).
+ */
+static void mwait_idle (void)
+{
+	local_irq_enable();
+
+	if (!need_resched()) {
+		set_thread_flag(TIF_POLLING_NRFLAG);
+		do {
+			__monitor((void *)&current_thread_info()->flags,
0, 0);
+			if (need_resched())
+				break;
+			__mwait(0, 0);
+		} while (!need_resched());
+		clear_thread_flag(TIF_POLLING_NRFLAG);
+	}
+}
+
+void __init select_idle_routine(const struct cpuinfo_x86 *c)
+{
+	if (cpu_has(c, X86_FEATURE_MWAIT)) {
+		printk("Monitor/Mwait feature present.\n");
+		/*=20
+		 * Skip, if setup has overridden idle.
+		 * Also, take care of system with asymmetric CPUs.
+		 * Use, mwait_idle only if all cpus support it.
+		 * If not, we fallback to default_idle()
+		 */
+		if (!pm_idle) {
+			pm_idle =3D mwait_idle;
+		}
+		return;
+	}
+	pm_idle =3D default_idle;
+	return;
+}
+
 static int __init idle_setup (char *str)
 {
 	if (!strncmp(str, "poll", 4)) {
 		printk("using polling idle threads.\n");
 		pm_idle =3D poll_idle;
+	} else if (!strncmp(str, "halt", 4)) {
+		printk("using halt in idle threads.\n");
+		pm_idle =3D default_idle;
 	}
=20
 	return 1;
diff -purN linux-2.6.0-test4-mm4/include/asm-i386/cpufeature.h
linux-2.6.0-test4-mm4-mwait/include/asm-i386/cpufeature.h
--- linux-2.6.0-test4-mm4/include/asm-i386/cpufeature.h	2003-08-22
16:58:04.000000000 -0700
+++ linux-2.6.0-test4-mm4-mwait/include/asm-i386/cpufeature.h
2003-09-02 20:18:47.000000000 -0700
@@ -71,6 +71,8 @@
=20
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
 #define X86_FEATURE_EST		(4*32+ 7) /* Enhanced SpeedStep
*/
+#define X86_FEATURE_MWAIT	(4*32+ 3) /* Monitor/Mwait support */
+
=20
 /* VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, word
5 */
 #define X86_FEATURE_XSTORE	(5*32+ 2) /* on-CPU RNG present (xstore
insn) */
diff -purN linux-2.6.0-test4-mm4/include/asm-i386/processor.h
linux-2.6.0-test4-mm4-mwait/include/asm-i386/processor.h
--- linux-2.6.0-test4-mm4/include/asm-i386/processor.h	2003-09-02
17:56:48.000000000 -0700
+++ linux-2.6.0-test4-mm4-mwait/include/asm-i386/processor.h
2003-09-02 20:18:47.000000000 -0700
@@ -272,6 +272,22 @@ extern int MCA_bus;
 #define pc98 0
 #endif
=20
+static __inline__ void __monitor(const void *eax, unsigned long ecx,=20
+		unsigned long edx)
+{
+	/* "monitor %eax,%ecx,%edx;" */
+	asm volatile(
+		".byte 0x0f,0x01,0xc8;"
+		: :"a" (eax), "c" (ecx), "d"(edx));
+}
+
+static __inline__ void __mwait(unsigned long eax, unsigned long ecx)
+{
+	/* "mwait %eax,%ecx;" */
+	asm volatile(
+		".byte 0x0f,0x01,0xc9;"
+		: :"a" (eax), "c" (ecx));
+}
=20
 /* from system description table in BIOS.  Mostly for MCA use, but
 others may find it useful. */




------_=_NextPart_001_01C37354.2C91D90E
Content-Type: application/octet-stream;
	name="mm4-mwait.patch"
Content-Transfer-Encoding: base64
Content-Description: mm4-mwait.patch
Content-Disposition: attachment;
	filename="mm4-mwait.patch"

ZGlmZiAtcHVyTiBsaW51eC0yLjYuMC10ZXN0NC1tbTQvYXJjaC9pMzg2L2tlcm5lbC9jcHUvaW50
ZWwuYyBsaW51eC0yLjYuMC10ZXN0NC1tbTQtbXdhaXQvYXJjaC9pMzg2L2tlcm5lbC9jcHUvaW50
ZWwuYwotLS0gbGludXgtMi42LjAtdGVzdDQtbW00L2FyY2gvaTM4Ni9rZXJuZWwvY3B1L2ludGVs
LmMJMjAwMy0wOS0wMiAxNzo1Njo0OC4wMDAwMDAwMDAgLTA3MDAKKysrIGxpbnV4LTIuNi4wLXRl
c3Q0LW1tNC1td2FpdC9hcmNoL2kzODYva2VybmVsL2NwdS9pbnRlbC5jCTIwMDMtMDktMDMgMTI6
MTI6NTYuMDAwMDAwMDAwIC0wNzAwCkBAIC0xMiw2ICsxMiw4IEBACiAKICNpbmNsdWRlICJjcHUu
aCIKIAorZXh0ZXJuIHZvaWQgc2VsZWN0X2lkbGVfcm91dGluZShjb25zdCBzdHJ1Y3QgY3B1aW5m
b194ODYgKmMpOworCiAjaWZkZWYgQ09ORklHX1g4Nl9JTlRFTF9VU0VSQ09QWQogLyoKICAqIEFs
aWdubWVudCBhdCB3aGljaCBtb3ZzbCBpcyBwcmVmZXJyZWQgZm9yIGJ1bGsgbWVtb3J5IGNvcGll
cy4KQEAgLTE2Myw3ICsxNjUsNyBAQCBzdGF0aWMgdm9pZCBfX2luaXQgaW5pdF9pbnRlbChzdHJ1
Y3QgY3B1CiAJfQogI2VuZGlmCiAKLQorCXNlbGVjdF9pZGxlX3JvdXRpbmUoYyk7CiAJaWYgKGMt
PmNwdWlkX2xldmVsID4gMSkgewogCQkvKiBzdXBwb3J0cyBlYXg9MiAgY2FsbCAqLwogCQlpbnQg
aSwgaiwgbjsKZGlmZiAtcHVyTiBsaW51eC0yLjYuMC10ZXN0NC1tbTQvYXJjaC9pMzg2L2tlcm5l
bC9wcm9jZXNzLmMgbGludXgtMi42LjAtdGVzdDQtbW00LW13YWl0L2FyY2gvaTM4Ni9rZXJuZWwv
cHJvY2Vzcy5jCi0tLSBsaW51eC0yLjYuMC10ZXN0NC1tbTQvYXJjaC9pMzg2L2tlcm5lbC9wcm9j
ZXNzLmMJMjAwMy0wOS0wMiAxNzo1Njo0OC4wMDAwMDAwMDAgLTA3MDAKKysrIGxpbnV4LTIuNi4w
LXRlc3Q0LW1tNC1td2FpdC9hcmNoL2kzODYva2VybmVsL3Byb2Nlc3MuYwkyMDAzLTA5LTAyIDIw
OjE4OjQ3LjAwMDAwMDAwMCAtMDcwMApAQCAtMTUyLDExICsxNTIsNTYgQEAgdm9pZCBjcHVfaWRs
ZSAodm9pZCkKIAl9CiB9CiAKKy8qCisgKiBUaGlzIHVzZXMgbmV3IE1PTklUT1IvTVdBSVQgaW5z
dHJ1Y3Rpb25zIG9uIFA0IHByb2Nlc3NvcnMgd2l0aCBQTkksIAorICogd2hpY2ggY2FuIG9idmlh
dGUgSVBJIHRvIHRyaWdnZXIgY2hlY2tpbmcgb2YgbmVlZF9yZXNjaGVkLgorICogV2UgZXhlY3V0
ZSBNT05JVE9SIGFnYWluc3QgbmVlZF9yZXNjaGVkIGFuZCBlbnRlciBvcHRpbWl6ZWQgd2FpdCBz
dGF0ZSAKKyAqIHRocm91Z2ggTVdBSVQuIFdoZW5ldmVyIHNvbWVvbmUgY2hhbmdlcyBuZWVkX3Jl
c2NoZWQsIHdlIHdvdWxkIGJlIHdva2VuIAorICogdXAgZnJvbSBNV0FJVCAod2l0aG91dCBhbiBJ
UEkpLgorICovCitzdGF0aWMgdm9pZCBtd2FpdF9pZGxlICh2b2lkKQoreworCWxvY2FsX2lycV9l
bmFibGUoKTsKKworCWlmICghbmVlZF9yZXNjaGVkKCkpIHsKKwkJc2V0X3RocmVhZF9mbGFnKFRJ
Rl9QT0xMSU5HX05SRkxBRyk7CisJCWRvIHsKKwkJCV9fbW9uaXRvcigodm9pZCAqKSZjdXJyZW50
X3RocmVhZF9pbmZvKCktPmZsYWdzLCAwLCAwKTsKKwkJCWlmIChuZWVkX3Jlc2NoZWQoKSkKKwkJ
CQlicmVhazsKKwkJCV9fbXdhaXQoMCwgMCk7CisJCX0gd2hpbGUgKCFuZWVkX3Jlc2NoZWQoKSk7
CisJCWNsZWFyX3RocmVhZF9mbGFnKFRJRl9QT0xMSU5HX05SRkxBRyk7CisJfQorfQorCit2b2lk
IF9faW5pdCBzZWxlY3RfaWRsZV9yb3V0aW5lKGNvbnN0IHN0cnVjdCBjcHVpbmZvX3g4NiAqYykK
K3sKKwlpZiAoY3B1X2hhcyhjLCBYODZfRkVBVFVSRV9NV0FJVCkpIHsKKwkJcHJpbnRrKCJNb25p
dG9yL013YWl0IGZlYXR1cmUgcHJlc2VudC5cbiIpOworCQkvKiAKKwkJICogU2tpcCwgaWYgc2V0
dXAgaGFzIG92ZXJyaWRkZW4gaWRsZS4KKwkJICogQWxzbywgdGFrZSBjYXJlIG9mIHN5c3RlbSB3
aXRoIGFzeW1tZXRyaWMgQ1BVcy4KKwkJICogVXNlLCBtd2FpdF9pZGxlIG9ubHkgaWYgYWxsIGNw
dXMgc3VwcG9ydCBpdC4KKwkJICogSWYgbm90LCB3ZSBmYWxsYmFjayB0byBkZWZhdWx0X2lkbGUo
KQorCQkgKi8KKwkJaWYgKCFwbV9pZGxlKSB7CisJCQlwbV9pZGxlID0gbXdhaXRfaWRsZTsKKwkJ
fQorCQlyZXR1cm47CisJfQorCXBtX2lkbGUgPSBkZWZhdWx0X2lkbGU7CisJcmV0dXJuOworfQor
CiBzdGF0aWMgaW50IF9faW5pdCBpZGxlX3NldHVwIChjaGFyICpzdHIpCiB7CiAJaWYgKCFzdHJu
Y21wKHN0ciwgInBvbGwiLCA0KSkgewogCQlwcmludGsoInVzaW5nIHBvbGxpbmcgaWRsZSB0aHJl
YWRzLlxuIik7CiAJCXBtX2lkbGUgPSBwb2xsX2lkbGU7CisJfSBlbHNlIGlmICghc3RybmNtcChz
dHIsICJoYWx0IiwgNCkpIHsKKwkJcHJpbnRrKCJ1c2luZyBoYWx0IGluIGlkbGUgdGhyZWFkcy5c
biIpOworCQlwbV9pZGxlID0gZGVmYXVsdF9pZGxlOwogCX0KIAogCXJldHVybiAxOwpkaWZmIC1w
dXJOIGxpbnV4LTIuNi4wLXRlc3Q0LW1tNC9pbmNsdWRlL2FzbS1pMzg2L2NwdWZlYXR1cmUuaCBs
aW51eC0yLjYuMC10ZXN0NC1tbTQtbXdhaXQvaW5jbHVkZS9hc20taTM4Ni9jcHVmZWF0dXJlLmgK
LS0tIGxpbnV4LTIuNi4wLXRlc3Q0LW1tNC9pbmNsdWRlL2FzbS1pMzg2L2NwdWZlYXR1cmUuaAky
MDAzLTA4LTIyIDE2OjU4OjA0LjAwMDAwMDAwMCAtMDcwMAorKysgbGludXgtMi42LjAtdGVzdDQt
bW00LW13YWl0L2luY2x1ZGUvYXNtLWkzODYvY3B1ZmVhdHVyZS5oCTIwMDMtMDktMDIgMjA6MTg6
NDcuMDAwMDAwMDAwIC0wNzAwCkBAIC03MSw2ICs3MSw4IEBACiAKIC8qIEludGVsLWRlZmluZWQg
Q1BVIGZlYXR1cmVzLCBDUFVJRCBsZXZlbCAweDAwMDAwMDAxIChlY3gpLCB3b3JkIDQgKi8KICNk
ZWZpbmUgWDg2X0ZFQVRVUkVfRVNUCQkoNCozMisgNykgLyogRW5oYW5jZWQgU3BlZWRTdGVwICov
CisjZGVmaW5lIFg4Nl9GRUFUVVJFX01XQUlUCSg0KjMyKyAzKSAvKiBNb25pdG9yL013YWl0IHN1
cHBvcnQgKi8KKwogCiAvKiBWSUEvQ3lyaXgvQ2VudGF1ci1kZWZpbmVkIENQVSBmZWF0dXJlcywg
Q1BVSUQgbGV2ZWwgMHhDMDAwMDAwMSwgd29yZCA1ICovCiAjZGVmaW5lIFg4Nl9GRUFUVVJFX1hT
VE9SRQkoNSozMisgMikgLyogb24tQ1BVIFJORyBwcmVzZW50ICh4c3RvcmUgaW5zbikgKi8KZGlm
ZiAtcHVyTiBsaW51eC0yLjYuMC10ZXN0NC1tbTQvaW5jbHVkZS9hc20taTM4Ni9wcm9jZXNzb3Iu
aCBsaW51eC0yLjYuMC10ZXN0NC1tbTQtbXdhaXQvaW5jbHVkZS9hc20taTM4Ni9wcm9jZXNzb3Iu
aAotLS0gbGludXgtMi42LjAtdGVzdDQtbW00L2luY2x1ZGUvYXNtLWkzODYvcHJvY2Vzc29yLmgJ
MjAwMy0wOS0wMiAxNzo1Njo0OC4wMDAwMDAwMDAgLTA3MDAKKysrIGxpbnV4LTIuNi4wLXRlc3Q0
LW1tNC1td2FpdC9pbmNsdWRlL2FzbS1pMzg2L3Byb2Nlc3Nvci5oCTIwMDMtMDktMDIgMjA6MTg6
NDcuMDAwMDAwMDAwIC0wNzAwCkBAIC0yNzIsNiArMjcyLDIyIEBAIGV4dGVybiBpbnQgTUNBX2J1
czsKICNkZWZpbmUgcGM5OCAwCiAjZW5kaWYKIAorc3RhdGljIF9faW5saW5lX18gdm9pZCBfX21v
bml0b3IoY29uc3Qgdm9pZCAqZWF4LCB1bnNpZ25lZCBsb25nIGVjeCwgCisJCXVuc2lnbmVkIGxv
bmcgZWR4KQoreworCS8qICJtb25pdG9yICVlYXgsJWVjeCwlZWR4OyIgKi8KKwlhc20gdm9sYXRp
bGUoCisJCSIuYnl0ZSAweDBmLDB4MDEsMHhjODsiCisJCTogOiJhIiAoZWF4KSwgImMiIChlY3gp
LCAiZCIoZWR4KSk7Cit9CisKK3N0YXRpYyBfX2lubGluZV9fIHZvaWQgX19td2FpdCh1bnNpZ25l
ZCBsb25nIGVheCwgdW5zaWduZWQgbG9uZyBlY3gpCit7CisJLyogIm13YWl0ICVlYXgsJWVjeDsi
ICovCisJYXNtIHZvbGF0aWxlKAorCQkiLmJ5dGUgMHgwZiwweDAxLDB4Yzk7IgorCQk6IDoiYSIg
KGVheCksICJjIiAoZWN4KSk7Cit9CiAKIC8qIGZyb20gc3lzdGVtIGRlc2NyaXB0aW9uIHRhYmxl
IGluIEJJT1MuICBNb3N0bHkgZm9yIE1DQSB1c2UsIGJ1dAogb3RoZXJzIG1heSBmaW5kIGl0IHVz
ZWZ1bC4gKi8K

------_=_NextPart_001_01C37354.2C91D90E--
