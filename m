Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267770AbTGHWay (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 18:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267771AbTGHWay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 18:30:54 -0400
Received: from fmr01.intel.com ([192.55.52.18]:38382 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S267770AbTGHWak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 18:30:40 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C34597.2464B138"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: [PATCH] idle using PNI monitor/mwait
Date: Tue, 8 Jul 2003 14:23:14 -0700
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB5640201719C@fmsmsx407.fm.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] idle using PNI monitor/mwait
Thread-Index: AcNFlyL7p91F0SgJRRqQfUEtYB/TMg==
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
X-OriginalArrivalTime: 08 Jul 2003 21:23:17.0925 (UTC) FILETIME=[262B3550:01C34597]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C34597.2464B138
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Attached is a patch that enables PNI (Prescott New Instructions)
monitor/mwait in kernel idle (opcodes are now public). Basically MWAIT
is similar to hlt, but you can avoid IPI to wake up the processor
waiting. A write (by another processor) to the address range specified
by MONITOR would wake up the processor waiting on MWAIT.

Please apply.

Thanks,
Jun

----------------
diff -ur /build/orig/linux-2.5.74/arch/i386/kernel/cpu/intel.c
linux-2.5.74/arch/i386/kernel/cpu/intel.c
--- /build/orig/linux-2.5.74/arch/i386/kernel/cpu/intel.c
2003-07-02 13:43:55.000000000 -0700
+++ linux-2.5.74/arch/i386/kernel/cpu/intel.c	2003-07-08
09:18:28.000000000 -0700
@@ -13,6 +13,7 @@
=20
 static int disable_P4_HT __initdata =3D 0;
 extern int trap_init_f00f_bug(void);
+extern void select_idle_routine(const struct cpuinfo_x86 *c);
=20
 #ifdef CONFIG_X86_INTEL_USERCOPY
 /*
@@ -172,7 +173,7 @@
 	}
 #endif
=20
-
+	select_idle_routine(c);
 	if (c->cpuid_level > 1) {
 		/* supports eax=3D2  call */
 		int i, j, n;
diff -ur /build/orig/linux-2.5.74/arch/i386/kernel/process.c
linux-2.5.74/arch/i386/kernel/process.c
--- /build/orig/linux-2.5.74/arch/i386/kernel/process.c	2003-07-02
13:38:40.000000000 -0700
+++ linux-2.5.74/arch/i386/kernel/process.c	2003-07-08
11:52:42.000000000 -0700
@@ -148,11 +148,56 @@
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
diff -ur /build/orig/linux-2.5.74/include/asm-i386/cpufeature.h
linux-2.5.74/include/asm-i386/cpufeature.h
--- /build/orig/linux-2.5.74/include/asm-i386/cpufeature.h
2003-07-02 13:51:50.000000000 -0700
+++ linux-2.5.74/include/asm-i386/cpufeature.h	2003-07-08
09:18:28.000000000 -0700
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
diff -ur /build/orig/linux-2.5.74/include/asm-i386/processor.h
linux-2.5.74/include/asm-i386/processor.h
--- /build/orig/linux-2.5.74/include/asm-i386/processor.h
2003-07-02 13:40:24.000000000 -0700
+++ linux-2.5.74/include/asm-i386/processor.h	2003-07-08
09:18:28.000000000 -0700
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



------_=_NextPart_001_01C34597.2464B138
Content-Type: application/octet-stream;
	name="mwait-2.5.74.patch"
Content-Transfer-Encoding: base64
Content-Description: mwait-2.5.74.patch
Content-Disposition: attachment;
	filename="mwait-2.5.74.patch"

ZGlmZiAtdXIgL2J1aWxkL29yaWcvbGludXgtMi41Ljc0L2FyY2gvaTM4Ni9rZXJuZWwvY3B1L2lu
dGVsLmMgbGludXgtMi41Ljc0L2FyY2gvaTM4Ni9rZXJuZWwvY3B1L2ludGVsLmMKLS0tIC9idWls
ZC9vcmlnL2xpbnV4LTIuNS43NC9hcmNoL2kzODYva2VybmVsL2NwdS9pbnRlbC5jCTIwMDMtMDct
MDIgMTM6NDM6NTUuMDAwMDAwMDAwIC0wNzAwCisrKyBsaW51eC0yLjUuNzQvYXJjaC9pMzg2L2tl
cm5lbC9jcHUvaW50ZWwuYwkyMDAzLTA3LTA4IDA5OjE4OjI4LjAwMDAwMDAwMCAtMDcwMApAQCAt
MTMsNiArMTMsNyBAQAogCiBzdGF0aWMgaW50IGRpc2FibGVfUDRfSFQgX19pbml0ZGF0YSA9IDA7
CiBleHRlcm4gaW50IHRyYXBfaW5pdF9mMDBmX2J1Zyh2b2lkKTsKK2V4dGVybiB2b2lkIHNlbGVj
dF9pZGxlX3JvdXRpbmUoY29uc3Qgc3RydWN0IGNwdWluZm9feDg2ICpjKTsKIAogI2lmZGVmIENP
TkZJR19YODZfSU5URUxfVVNFUkNPUFkKIC8qCkBAIC0xNzIsNyArMTczLDcgQEAKIAl9CiAjZW5k
aWYKIAotCisJc2VsZWN0X2lkbGVfcm91dGluZShjKTsKIAlpZiAoYy0+Y3B1aWRfbGV2ZWwgPiAx
KSB7CiAJCS8qIHN1cHBvcnRzIGVheD0yICBjYWxsICovCiAJCWludCBpLCBqLCBuOwpkaWZmIC11
ciAvYnVpbGQvb3JpZy9saW51eC0yLjUuNzQvYXJjaC9pMzg2L2tlcm5lbC9wcm9jZXNzLmMgbGlu
dXgtMi41Ljc0L2FyY2gvaTM4Ni9rZXJuZWwvcHJvY2Vzcy5jCi0tLSAvYnVpbGQvb3JpZy9saW51
eC0yLjUuNzQvYXJjaC9pMzg2L2tlcm5lbC9wcm9jZXNzLmMJMjAwMy0wNy0wMiAxMzozODo0MC4w
MDAwMDAwMDAgLTA3MDAKKysrIGxpbnV4LTIuNS43NC9hcmNoL2kzODYva2VybmVsL3Byb2Nlc3Mu
YwkyMDAzLTA3LTA4IDExOjUyOjQyLjAwMDAwMDAwMCAtMDcwMApAQCAtMTQ4LDExICsxNDgsNTYg
QEAKIAl9CiB9CiAKKy8qCisgKiBUaGlzIHVzZXMgbmV3IE1PTklUT1IvTVdBSVQgaW5zdHJ1Y3Rp
b25zIG9uIFA0IHByb2Nlc3NvcnMgd2l0aCBQTkksIAorICogd2hpY2ggY2FuIG9idmlhdGUgSVBJ
IHRvIHRyaWdnZXIgY2hlY2tpbmcgb2YgbmVlZF9yZXNjaGVkLgorICogV2UgZXhlY3V0ZSBNT05J
VE9SIGFnYWluc3QgbmVlZF9yZXNjaGVkIGFuZCBlbnRlciBvcHRpbWl6ZWQgd2FpdCBzdGF0ZSAK
KyAqIHRocm91Z2ggTVdBSVQuIFdoZW5ldmVyIHNvbWVvbmUgY2hhbmdlcyBuZWVkX3Jlc2NoZWQs
IHdlIHdvdWxkIGJlIHdva2VuIAorICogdXAgZnJvbSBNV0FJVCAod2l0aG91dCBhbiBJUEkpLgor
ICovCitzdGF0aWMgdm9pZCBtd2FpdF9pZGxlICh2b2lkKQoreworCWxvY2FsX2lycV9lbmFibGUo
KTsKKworCWlmICghbmVlZF9yZXNjaGVkKCkpIHsKKwkJc2V0X3RocmVhZF9mbGFnKFRJRl9QT0xM
SU5HX05SRkxBRyk7CisJCWRvIHsKKwkJCV9fbW9uaXRvcigodm9pZCAqKSZjdXJyZW50X3RocmVh
ZF9pbmZvKCktPmZsYWdzLCAwLCAwKTsKKwkJCWlmIChuZWVkX3Jlc2NoZWQoKSkKKwkJCQlicmVh
azsKKwkJCV9fbXdhaXQoMCwgMCk7CisJCX0gd2hpbGUgKCFuZWVkX3Jlc2NoZWQoKSk7CisJCWNs
ZWFyX3RocmVhZF9mbGFnKFRJRl9QT0xMSU5HX05SRkxBRyk7CisJfQorfQorCit2b2lkIF9faW5p
dCBzZWxlY3RfaWRsZV9yb3V0aW5lKGNvbnN0IHN0cnVjdCBjcHVpbmZvX3g4NiAqYykKK3sKKwlp
ZiAoY3B1X2hhcyhjLCBYODZfRkVBVFVSRV9NV0FJVCkpIHsKKwkJcHJpbnRrKCJNb25pdG9yL013
YWl0IGZlYXR1cmUgcHJlc2VudC5cbiIpOworCQkvKiAKKwkJICogU2tpcCwgaWYgc2V0dXAgaGFz
IG92ZXJyaWRkZW4gaWRsZS4KKwkJICogQWxzbywgdGFrZSBjYXJlIG9mIHN5c3RlbSB3aXRoIGFz
eW1tZXRyaWMgQ1BVcy4KKwkJICogVXNlLCBtd2FpdF9pZGxlIG9ubHkgaWYgYWxsIGNwdXMgc3Vw
cG9ydCBpdC4KKwkJICogSWYgbm90LCB3ZSBmYWxsYmFjayB0byBkZWZhdWx0X2lkbGUoKQorCQkg
Ki8KKwkJaWYgKCFwbV9pZGxlKSB7CisJCQlwbV9pZGxlID0gbXdhaXRfaWRsZTsKKwkJfQorCQly
ZXR1cm47CisJfQorCXBtX2lkbGUgPSBkZWZhdWx0X2lkbGU7CisJcmV0dXJuOworfQorCiBzdGF0
aWMgaW50IF9faW5pdCBpZGxlX3NldHVwIChjaGFyICpzdHIpCiB7CiAJaWYgKCFzdHJuY21wKHN0
ciwgInBvbGwiLCA0KSkgewogCQlwcmludGsoInVzaW5nIHBvbGxpbmcgaWRsZSB0aHJlYWRzLlxu
Iik7CiAJCXBtX2lkbGUgPSBwb2xsX2lkbGU7CisJfSBlbHNlIGlmICghc3RybmNtcChzdHIsICJo
YWx0IiwgNCkpIHsKKwkJcHJpbnRrKCJ1c2luZyBoYWx0IGluIGlkbGUgdGhyZWFkcy5cbiIpOwor
CQlwbV9pZGxlID0gZGVmYXVsdF9pZGxlOwogCX0KIAogCXJldHVybiAxOwpkaWZmIC11ciAvYnVp
bGQvb3JpZy9saW51eC0yLjUuNzQvaW5jbHVkZS9hc20taTM4Ni9jcHVmZWF0dXJlLmggbGludXgt
Mi41Ljc0L2luY2x1ZGUvYXNtLWkzODYvY3B1ZmVhdHVyZS5oCi0tLSAvYnVpbGQvb3JpZy9saW51
eC0yLjUuNzQvaW5jbHVkZS9hc20taTM4Ni9jcHVmZWF0dXJlLmgJMjAwMy0wNy0wMiAxMzo1MTo1
MC4wMDAwMDAwMDAgLTA3MDAKKysrIGxpbnV4LTIuNS43NC9pbmNsdWRlL2FzbS1pMzg2L2NwdWZl
YXR1cmUuaAkyMDAzLTA3LTA4IDA5OjE4OjI4LjAwMDAwMDAwMCAtMDcwMApAQCAtNzEsNiArNzEs
OCBAQAogCiAvKiBJbnRlbC1kZWZpbmVkIENQVSBmZWF0dXJlcywgQ1BVSUQgbGV2ZWwgMHgwMDAw
MDAwMSAoZWN4KSwgd29yZCA0ICovCiAjZGVmaW5lIFg4Nl9GRUFUVVJFX0VTVAkJKDQqMzIrIDcp
IC8qIEVuaGFuY2VkIFNwZWVkU3RlcCAqLworI2RlZmluZSBYODZfRkVBVFVSRV9NV0FJVAkoNCoz
MisgMykgLyogTW9uaXRvci9Nd2FpdCBzdXBwb3J0ICovCisKIAogLyogVklBL0N5cml4L0NlbnRh
dXItZGVmaW5lZCBDUFUgZmVhdHVyZXMsIENQVUlEIGxldmVsIDB4QzAwMDAwMDEsIHdvcmQgNSAq
LwogI2RlZmluZSBYODZfRkVBVFVSRV9YU1RPUkUJKDUqMzIrIDIpIC8qIG9uLUNQVSBSTkcgcHJl
c2VudCAoeHN0b3JlIGluc24pICovCmRpZmYgLXVyIC9idWlsZC9vcmlnL2xpbnV4LTIuNS43NC9p
bmNsdWRlL2FzbS1pMzg2L3Byb2Nlc3Nvci5oIGxpbnV4LTIuNS43NC9pbmNsdWRlL2FzbS1pMzg2
L3Byb2Nlc3Nvci5oCi0tLSAvYnVpbGQvb3JpZy9saW51eC0yLjUuNzQvaW5jbHVkZS9hc20taTM4
Ni9wcm9jZXNzb3IuaAkyMDAzLTA3LTAyIDEzOjQwOjI0LjAwMDAwMDAwMCAtMDcwMAorKysgbGlu
dXgtMi41Ljc0L2luY2x1ZGUvYXNtLWkzODYvcHJvY2Vzc29yLmgJMjAwMy0wNy0wOCAwOToxODoy
OC4wMDAwMDAwMDAgLTA3MDAKQEAgLTI3Miw2ICsyNzIsMjIgQEAKICNkZWZpbmUgcGM5OCAwCiAj
ZW5kaWYKIAorc3RhdGljIF9faW5saW5lX18gdm9pZCBfX21vbml0b3IoY29uc3Qgdm9pZCAqZWF4
LCB1bnNpZ25lZCBsb25nIGVjeCwgCisJCXVuc2lnbmVkIGxvbmcgZWR4KQoreworCS8qICJtb25p
dG9yICVlYXgsJWVjeCwlZWR4OyIgKi8KKwlhc20gdm9sYXRpbGUoCisJCSIuYnl0ZSAweDBmLDB4
MDEsMHhjODsiCisJCTogOiJhIiAoZWF4KSwgImMiIChlY3gpLCAiZCIoZWR4KSk7Cit9CisKK3N0
YXRpYyBfX2lubGluZV9fIHZvaWQgX19td2FpdCh1bnNpZ25lZCBsb25nIGVheCwgdW5zaWduZWQg
bG9uZyBlY3gpCit7CisJLyogIm13YWl0ICVlYXgsJWVjeDsiICovCisJYXNtIHZvbGF0aWxlKAor
CQkiLmJ5dGUgMHgwZiwweDAxLDB4Yzk7IgorCQk6IDoiYSIgKGVheCksICJjIiAoZWN4KSk7Cit9
CiAKIC8qIGZyb20gc3lzdGVtIGRlc2NyaXB0aW9uIHRhYmxlIGluIEJJT1MuICBNb3N0bHkgZm9y
IE1DQSB1c2UsIGJ1dAogb3RoZXJzIG1heSBmaW5kIGl0IHVzZWZ1bC4gKi8K

------_=_NextPart_001_01C34597.2464B138--
