Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbTIFCsX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 22:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbTIFCsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 22:48:23 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:12787 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S262591AbTIFCsQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 22:48:16 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C37421.49557B2C"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: [PATCH] idle using PNI monitor/mwait (take 3)
Date: Fri, 5 Sep 2003 19:48:00 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304A72F@scsmsx402.sc.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] idle using PNI monitor/mwait (take 3)
Thread-Index: AcN0IUkD1Nv9s1tyRPmqw68qyuZ0Zg==
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
X-OriginalArrivalTime: 06 Sep 2003 02:48:06.0196 (UTC) FILETIME=[4C749F40:01C37421]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C37421.49557B2C
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Remade the patch for -mm6. We tested it by removing local_irq_enable()
completely=20
(and it worked as far as we tested), but I think it would be a cheap
"defensive" code.=20
Instead of removing it, I moved it to right before __mwait().

Thanks,
Jun
---
diff -ur /build/orig/linux-2.6.0-test4-mm6/arch/i386/kernel/cpu/intel.c
linux-2.6.0-test4-mm6/arch/i386/kernel/cpu/intel.c
--- /build/orig/linux-2.6.0-test4-mm6/arch/i386/kernel/cpu/intel.c
2003-09-05 19:16:26.000000000 -0700
+++ linux-2.6.0-test4-mm6/arch/i386/kernel/cpu/intel.c	2003-09-05
19:22:05.000000000 -0700
@@ -12,6 +12,8 @@
=20
 #include "cpu.h"
=20
+extern void select_idle_routine(const struct cpuinfo_x86 *c);
+
 #ifdef CONFIG_X86_INTEL_USERCOPY
 /*
  * Alignment at which movsl is preferred for bulk memory copies.
@@ -163,7 +165,7 @@
 	}
 #endif
=20
-
+	select_idle_routine(c);
 	if (c->cpuid_level > 1) {
 		/* supports eax=3D2  call */
 		int i, j, n;
diff -ur /build/orig/linux-2.6.0-test4-mm6/arch/i386/kernel/process.c
linux-2.6.0-test4-mm6/arch/i386/kernel/process.c
--- /build/orig/linux-2.6.0-test4-mm6/arch/i386/kernel/process.c
2003-09-05 19:16:26.000000000 -0700
+++ linux-2.6.0-test4-mm6/arch/i386/kernel/process.c	2003-09-05
19:23:01.000000000 -0700
@@ -152,11 +152,56 @@
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
+	if (!need_resched()) {
+		set_thread_flag(TIF_POLLING_NRFLAG);
+		do {
+			__monitor((void *)&current_thread_info()->flags,
0, 0);
+			if (need_resched())
+				break;
+
+			local_irq_enable();
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
diff -ur /build/orig/linux-2.6.0-test4-mm6/include/asm-i386/cpufeature.h
linux-2.6.0-test4-mm6/include/asm-i386/cpufeature.h
--- /build/orig/linux-2.6.0-test4-mm6/include/asm-i386/cpufeature.h
2003-08-22 16:58:04.000000000 -0700
+++ linux-2.6.0-test4-mm6/include/asm-i386/cpufeature.h	2003-09-05
19:22:05.000000000 -0700
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
diff -ur /build/orig/linux-2.6.0-test4-mm6/include/asm-i386/processor.h
linux-2.6.0-test4-mm6/include/asm-i386/processor.h
--- /build/orig/linux-2.6.0-test4-mm6/include/asm-i386/processor.h
2003-09-05 19:17:03.000000000 -0700
+++ linux-2.6.0-test4-mm6/include/asm-i386/processor.h	2003-09-05
19:22:05.000000000 -0700
@@ -272,6 +272,22 @@
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







------_=_NextPart_001_01C37421.49557B2C
Content-Type: application/octet-stream;
	name="mwait_mm6.patch"
Content-Transfer-Encoding: base64
Content-Description: mwait_mm6.patch
Content-Disposition: attachment;
	filename="mwait_mm6.patch"

ZGlmZiAtdXIgL2J1aWxkL29yaWcvbGludXgtMi42LjAtdGVzdDQtbW02L2FyY2gvaTM4Ni9rZXJu
ZWwvY3B1L2ludGVsLmMgbGludXgtMi42LjAtdGVzdDQtbW02L2FyY2gvaTM4Ni9rZXJuZWwvY3B1
L2ludGVsLmMKLS0tIC9idWlsZC9vcmlnL2xpbnV4LTIuNi4wLXRlc3Q0LW1tNi9hcmNoL2kzODYv
a2VybmVsL2NwdS9pbnRlbC5jCTIwMDMtMDktMDUgMTk6MTY6MjYuMDAwMDAwMDAwIC0wNzAwCisr
KyBsaW51eC0yLjYuMC10ZXN0NC1tbTYvYXJjaC9pMzg2L2tlcm5lbC9jcHUvaW50ZWwuYwkyMDAz
LTA5LTA1IDE5OjIyOjA1LjAwMDAwMDAwMCAtMDcwMApAQCAtMTIsNiArMTIsOCBAQAogCiAjaW5j
bHVkZSAiY3B1LmgiCiAKK2V4dGVybiB2b2lkIHNlbGVjdF9pZGxlX3JvdXRpbmUoY29uc3Qgc3Ry
dWN0IGNwdWluZm9feDg2ICpjKTsKKwogI2lmZGVmIENPTkZJR19YODZfSU5URUxfVVNFUkNPUFkK
IC8qCiAgKiBBbGlnbm1lbnQgYXQgd2hpY2ggbW92c2wgaXMgcHJlZmVycmVkIGZvciBidWxrIG1l
bW9yeSBjb3BpZXMuCkBAIC0xNjMsNyArMTY1LDcgQEAKIAl9CiAjZW5kaWYKIAotCisJc2VsZWN0
X2lkbGVfcm91dGluZShjKTsKIAlpZiAoYy0+Y3B1aWRfbGV2ZWwgPiAxKSB7CiAJCS8qIHN1cHBv
cnRzIGVheD0yICBjYWxsICovCiAJCWludCBpLCBqLCBuOwpkaWZmIC11ciAvYnVpbGQvb3JpZy9s
aW51eC0yLjYuMC10ZXN0NC1tbTYvYXJjaC9pMzg2L2tlcm5lbC9wcm9jZXNzLmMgbGludXgtMi42
LjAtdGVzdDQtbW02L2FyY2gvaTM4Ni9rZXJuZWwvcHJvY2Vzcy5jCi0tLSAvYnVpbGQvb3JpZy9s
aW51eC0yLjYuMC10ZXN0NC1tbTYvYXJjaC9pMzg2L2tlcm5lbC9wcm9jZXNzLmMJMjAwMy0wOS0w
NSAxOToxNjoyNi4wMDAwMDAwMDAgLTA3MDAKKysrIGxpbnV4LTIuNi4wLXRlc3Q0LW1tNi9hcmNo
L2kzODYva2VybmVsL3Byb2Nlc3MuYwkyMDAzLTA5LTA1IDE5OjIzOjAxLjAwMDAwMDAwMCAtMDcw
MApAQCAtMTUyLDExICsxNTIsNTYgQEAKIAl9CiB9CiAKKy8qCisgKiBUaGlzIHVzZXMgbmV3IE1P
TklUT1IvTVdBSVQgaW5zdHJ1Y3Rpb25zIG9uIFA0IHByb2Nlc3NvcnMgd2l0aCBQTkksIAorICog
d2hpY2ggY2FuIG9idmlhdGUgSVBJIHRvIHRyaWdnZXIgY2hlY2tpbmcgb2YgbmVlZF9yZXNjaGVk
LgorICogV2UgZXhlY3V0ZSBNT05JVE9SIGFnYWluc3QgbmVlZF9yZXNjaGVkIGFuZCBlbnRlciBv
cHRpbWl6ZWQgd2FpdCBzdGF0ZSAKKyAqIHRocm91Z2ggTVdBSVQuIFdoZW5ldmVyIHNvbWVvbmUg
Y2hhbmdlcyBuZWVkX3Jlc2NoZWQsIHdlIHdvdWxkIGJlIHdva2VuIAorICogdXAgZnJvbSBNV0FJ
VCAod2l0aG91dCBhbiBJUEkpLgorICovCitzdGF0aWMgdm9pZCBtd2FpdF9pZGxlICh2b2lkKQor
eworCWlmICghbmVlZF9yZXNjaGVkKCkpIHsKKwkJc2V0X3RocmVhZF9mbGFnKFRJRl9QT0xMSU5H
X05SRkxBRyk7CisJCWRvIHsKKwkJCV9fbW9uaXRvcigodm9pZCAqKSZjdXJyZW50X3RocmVhZF9p
bmZvKCktPmZsYWdzLCAwLCAwKTsKKwkJCWlmIChuZWVkX3Jlc2NoZWQoKSkKKwkJCQlicmVhazsK
KworCQkJbG9jYWxfaXJxX2VuYWJsZSgpOworCQkJX19td2FpdCgwLCAwKTsKKwkJfSB3aGlsZSAo
IW5lZWRfcmVzY2hlZCgpKTsKKwkJY2xlYXJfdGhyZWFkX2ZsYWcoVElGX1BPTExJTkdfTlJGTEFH
KTsKKwl9Cit9CisKK3ZvaWQgX19pbml0IHNlbGVjdF9pZGxlX3JvdXRpbmUoY29uc3Qgc3RydWN0
IGNwdWluZm9feDg2ICpjKQoreworCWlmIChjcHVfaGFzKGMsIFg4Nl9GRUFUVVJFX01XQUlUKSkg
eworCQlwcmludGsoIk1vbml0b3IvTXdhaXQgZmVhdHVyZSBwcmVzZW50LlxuIik7CisJCS8qIAor
CQkgKiBTa2lwLCBpZiBzZXR1cCBoYXMgb3ZlcnJpZGRlbiBpZGxlLgorCQkgKiBBbHNvLCB0YWtl
IGNhcmUgb2Ygc3lzdGVtIHdpdGggYXN5bW1ldHJpYyBDUFVzLgorCQkgKiBVc2UsIG13YWl0X2lk
bGUgb25seSBpZiBhbGwgY3B1cyBzdXBwb3J0IGl0LgorCQkgKiBJZiBub3QsIHdlIGZhbGxiYWNr
IHRvIGRlZmF1bHRfaWRsZSgpCisJCSAqLworCQlpZiAoIXBtX2lkbGUpIHsKKwkJCXBtX2lkbGUg
PSBtd2FpdF9pZGxlOworCQl9CisJCXJldHVybjsKKwl9CisJcG1faWRsZSA9IGRlZmF1bHRfaWRs
ZTsKKwlyZXR1cm47Cit9CisKIHN0YXRpYyBpbnQgX19pbml0IGlkbGVfc2V0dXAgKGNoYXIgKnN0
cikKIHsKIAlpZiAoIXN0cm5jbXAoc3RyLCAicG9sbCIsIDQpKSB7CiAJCXByaW50aygidXNpbmcg
cG9sbGluZyBpZGxlIHRocmVhZHMuXG4iKTsKIAkJcG1faWRsZSA9IHBvbGxfaWRsZTsKKwl9IGVs
c2UgaWYgKCFzdHJuY21wKHN0ciwgImhhbHQiLCA0KSkgeworCQlwcmludGsoInVzaW5nIGhhbHQg
aW4gaWRsZSB0aHJlYWRzLlxuIik7CisJCXBtX2lkbGUgPSBkZWZhdWx0X2lkbGU7CiAJfQogCiAJ
cmV0dXJuIDE7CmRpZmYgLXVyIC9idWlsZC9vcmlnL2xpbnV4LTIuNi4wLXRlc3Q0LW1tNi9pbmNs
dWRlL2FzbS1pMzg2L2NwdWZlYXR1cmUuaCBsaW51eC0yLjYuMC10ZXN0NC1tbTYvaW5jbHVkZS9h
c20taTM4Ni9jcHVmZWF0dXJlLmgKLS0tIC9idWlsZC9vcmlnL2xpbnV4LTIuNi4wLXRlc3Q0LW1t
Ni9pbmNsdWRlL2FzbS1pMzg2L2NwdWZlYXR1cmUuaAkyMDAzLTA4LTIyIDE2OjU4OjA0LjAwMDAw
MDAwMCAtMDcwMAorKysgbGludXgtMi42LjAtdGVzdDQtbW02L2luY2x1ZGUvYXNtLWkzODYvY3B1
ZmVhdHVyZS5oCTIwMDMtMDktMDUgMTk6MjI6MDUuMDAwMDAwMDAwIC0wNzAwCkBAIC03MSw2ICs3
MSw4IEBACiAKIC8qIEludGVsLWRlZmluZWQgQ1BVIGZlYXR1cmVzLCBDUFVJRCBsZXZlbCAweDAw
MDAwMDAxIChlY3gpLCB3b3JkIDQgKi8KICNkZWZpbmUgWDg2X0ZFQVRVUkVfRVNUCQkoNCozMisg
NykgLyogRW5oYW5jZWQgU3BlZWRTdGVwICovCisjZGVmaW5lIFg4Nl9GRUFUVVJFX01XQUlUCSg0
KjMyKyAzKSAvKiBNb25pdG9yL013YWl0IHN1cHBvcnQgKi8KKwogCiAvKiBWSUEvQ3lyaXgvQ2Vu
dGF1ci1kZWZpbmVkIENQVSBmZWF0dXJlcywgQ1BVSUQgbGV2ZWwgMHhDMDAwMDAwMSwgd29yZCA1
ICovCiAjZGVmaW5lIFg4Nl9GRUFUVVJFX1hTVE9SRQkoNSozMisgMikgLyogb24tQ1BVIFJORyBw
cmVzZW50ICh4c3RvcmUgaW5zbikgKi8KZGlmZiAtdXIgL2J1aWxkL29yaWcvbGludXgtMi42LjAt
dGVzdDQtbW02L2luY2x1ZGUvYXNtLWkzODYvcHJvY2Vzc29yLmggbGludXgtMi42LjAtdGVzdDQt
bW02L2luY2x1ZGUvYXNtLWkzODYvcHJvY2Vzc29yLmgKLS0tIC9idWlsZC9vcmlnL2xpbnV4LTIu
Ni4wLXRlc3Q0LW1tNi9pbmNsdWRlL2FzbS1pMzg2L3Byb2Nlc3Nvci5oCTIwMDMtMDktMDUgMTk6
MTc6MDMuMDAwMDAwMDAwIC0wNzAwCisrKyBsaW51eC0yLjYuMC10ZXN0NC1tbTYvaW5jbHVkZS9h
c20taTM4Ni9wcm9jZXNzb3IuaAkyMDAzLTA5LTA1IDE5OjIyOjA1LjAwMDAwMDAwMCAtMDcwMApA
QCAtMjcyLDYgKzI3MiwyMiBAQAogI2RlZmluZSBwYzk4IDAKICNlbmRpZgogCitzdGF0aWMgX19p
bmxpbmVfXyB2b2lkIF9fbW9uaXRvcihjb25zdCB2b2lkICplYXgsIHVuc2lnbmVkIGxvbmcgZWN4
LCAKKwkJdW5zaWduZWQgbG9uZyBlZHgpCit7CisJLyogIm1vbml0b3IgJWVheCwlZWN4LCVlZHg7
IiAqLworCWFzbSB2b2xhdGlsZSgKKwkJIi5ieXRlIDB4MGYsMHgwMSwweGM4OyIKKwkJOiA6ImEi
IChlYXgpLCAiYyIgKGVjeCksICJkIihlZHgpKTsKK30KKworc3RhdGljIF9faW5saW5lX18gdm9p
ZCBfX213YWl0KHVuc2lnbmVkIGxvbmcgZWF4LCB1bnNpZ25lZCBsb25nIGVjeCkKK3sKKwkvKiAi
bXdhaXQgJWVheCwlZWN4OyIgKi8KKwlhc20gdm9sYXRpbGUoCisJCSIuYnl0ZSAweDBmLDB4MDEs
MHhjOTsiCisJCTogOiJhIiAoZWF4KSwgImMiIChlY3gpKTsKK30KIAogLyogZnJvbSBzeXN0ZW0g
ZGVzY3JpcHRpb24gdGFibGUgaW4gQklPUy4gIE1vc3RseSBmb3IgTUNBIHVzZSwgYnV0CiBvdGhl
cnMgbWF5IGZpbmQgaXQgdXNlZnVsLiAqLwo=

------_=_NextPart_001_01C37421.49557B2C--
