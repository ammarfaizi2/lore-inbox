Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267566AbUBSUqZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 15:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267567AbUBSUqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 15:46:25 -0500
Received: from fmr05.intel.com ([134.134.136.6]:42661 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S267566AbUBSUqA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 15:46:00 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C3F729.4948D2D8"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Intel x86-64 support patch breaks amd64
Date: Thu, 19 Feb 2004 12:45:19 -0800
Message-ID: <9AB83E4717F13F419BD880F5254709E5011EB8BD@scsmsx402.sc.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Intel x86-64 support patch breaks amd64
Thread-Index: AcP3H9Pte5AuYtmNQgy8DK4hV7VqkAACQpzg
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: "Andi Kleen" <ak@suse.de>, "Tony Lindgren" <tony@atomide.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Feb 2004 20:45:19.0771 (UTC) FILETIME=[49A3FEB0:01C3F729]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C3F729.4948D2D8
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> > After #if 0 out some parts to make it compile, it fails to=20
> boot with no
> > output at all. Sorry, don't have low level debugging or=20
> serial console on=20
> > this machine configured, let me know if you need further=20
> information.
>=20
> It works for me with this patch both UP and SMP. Maybe you=20
> commented out=20
> too much?=20
>=20
> -Andi

Andi, Appended patch should fix the problem reported by Tony.

thanks,
suresh

diff -Nru linux/arch/x86_64/kernel/head.S =
linux~/arch/x86_64/kernel/head.S
--- linux/arch/x86_64/kernel/head.S	2004-02-19 03:10:55.000000000 -0800
+++ linux~/arch/x86_64/kernel/head.S	2004-02-19 04:21:51.000000000 -0800
@@ -358,7 +358,7 @@
 	/* asm/segment.h:GDT_ENTRIES must match this */=09
 	/* This should be a multiple of the cache line size */
 	/* GDTs of other CPUs: */=09
-	.fill (L1_CACHE_BYTES * NR_CPUS) - (gdt_end - cpu_gdt_table)=20
+	.fill (GDT_SIZE * NR_CPUS) - (gdt_end - cpu_gdt_table)=20
=20
 	.align  L1_CACHE_BYTES
 ENTRY(idt_table)=09
diff -Nru linux/arch/x86_64/kernel/setup.c =
linux~/arch/x86_64/kernel/setup.c
--- linux/arch/x86_64/kernel/setup.c	2004-02-19 03:10:55.000000000 -0800
+++ linux~/arch/x86_64/kernel/setup.c	2004-02-19 03:18:58.000000000 =
-0800
@@ -586,6 +586,7 @@
 	return r;
 }
=20
+#ifdef CONFIG_X86_HT
 static void __init detect_ht(void)
 {
 	extern	int phys_proc_id[NR_CPUS];
@@ -632,6 +633,7 @@
 		       phys_proc_id[cpu]);
 	}
 }
+#endif
 =09
 #define LVL_1_INST	1
 #define LVL_1_DATA	2
@@ -761,8 +763,10 @@
 		c->x86_cache_size =3D l2 ? l2 : (l1i+l1d);
 	}
=20
+#ifdef CONFIG_X86_HT
 	if (cpu_has(c, X86_FEATURE_HT))
 		detect_ht();=20
+#endif
=20
 	n =3D cpuid_eax(0x80000000);
 	if (n >=3D 0x80000008) {
diff -Nru linux/arch/x86_64/kernel/x8664_ksyms.c =
linux~/arch/x86_64/kernel/x8664_ksyms.c
--- linux/arch/x86_64/kernel/x8664_ksyms.c	2004-02-19 03:10:55.000000000 =
-0800
+++ linux~/arch/x86_64/kernel/x8664_ksyms.c	2004-02-19 =
03:20:04.000000000 -0800
@@ -194,7 +194,10 @@
=20
 EXPORT_SYMBOL(die_chain);
=20
+#ifdef CONFIG_X86_HT
+EXPORT_SYMBOL(smp_num_siblings);
 EXPORT_SYMBOL(cpu_sibling_map);
+#endif
=20
 extern void do_softirq_thunk(void);
 EXPORT_SYMBOL_NOVERS(do_softirq_thunk);
diff -Nru linux/include/asm-x86_64/segment.h =
linux~/include/asm-x86_64/segment.h
--- linux/include/asm-x86_64/segment.h	2004-02-19 03:11:05.000000000 =
-0800
+++ linux~/include/asm-x86_64/segment.h	2004-02-19 04:21:17.000000000 =
-0800
@@ -40,7 +40,7 @@
 #define FS_TLS_SEL ((GDT_ENTRY_TLS_MIN+FS_TLS)*8 + 3)
=20
 #define IDT_ENTRIES 256
-#define GDT_ENTRIES (L1_CACHE_BYTES / 8)=20
+#define GDT_ENTRIES 16
 #define GDT_SIZE (GDT_ENTRIES * 8)
 #define TLS_SIZE (GDT_ENTRY_TLS_ENTRIES * 8)=20
=20

------_=_NextPart_001_01C3F729.4948D2D8
Content-Type: application/octet-stream;
	name="gdt+ht-fix.patch"
Content-Transfer-Encoding: base64
Content-Description: gdt+ht-fix.patch
Content-Disposition: attachment;
	filename="gdt+ht-fix.patch"

ZGlmZiAtTnJ1IGxpbnV4L2FyY2gveDg2XzY0L2tlcm5lbC9oZWFkLlMgbGludXh+L2FyY2gveDg2
XzY0L2tlcm5lbC9oZWFkLlMKLS0tIGxpbnV4L2FyY2gveDg2XzY0L2tlcm5lbC9oZWFkLlMJMjAw
NC0wMi0xOSAwMzoxMDo1NS4wMDAwMDAwMDAgLTA4MDAKKysrIGxpbnV4fi9hcmNoL3g4Nl82NC9r
ZXJuZWwvaGVhZC5TCTIwMDQtMDItMTkgMDQ6MjE6NTEuMDAwMDAwMDAwIC0wODAwCkBAIC0zNTgs
NyArMzU4LDcgQEAKIAkvKiBhc20vc2VnbWVudC5oOkdEVF9FTlRSSUVTIG11c3QgbWF0Y2ggdGhp
cyAqLwkKIAkvKiBUaGlzIHNob3VsZCBiZSBhIG11bHRpcGxlIG9mIHRoZSBjYWNoZSBsaW5lIHNp
emUgKi8KIAkvKiBHRFRzIG9mIG90aGVyIENQVXM6ICovCQotCS5maWxsIChMMV9DQUNIRV9CWVRF
UyAqIE5SX0NQVVMpIC0gKGdkdF9lbmQgLSBjcHVfZ2R0X3RhYmxlKSAKKwkuZmlsbCAoR0RUX1NJ
WkUgKiBOUl9DUFVTKSAtIChnZHRfZW5kIC0gY3B1X2dkdF90YWJsZSkgCiAKIAkuYWxpZ24gIEwx
X0NBQ0hFX0JZVEVTCiBFTlRSWShpZHRfdGFibGUpCQpkaWZmIC1OcnUgbGludXgvYXJjaC94ODZf
NjQva2VybmVsL3NldHVwLmMgbGludXh+L2FyY2gveDg2XzY0L2tlcm5lbC9zZXR1cC5jCi0tLSBs
aW51eC9hcmNoL3g4Nl82NC9rZXJuZWwvc2V0dXAuYwkyMDA0LTAyLTE5IDAzOjEwOjU1LjAwMDAw
MDAwMCAtMDgwMAorKysgbGludXh+L2FyY2gveDg2XzY0L2tlcm5lbC9zZXR1cC5jCTIwMDQtMDIt
MTkgMDM6MTg6NTguMDAwMDAwMDAwIC0wODAwCkBAIC01ODYsNiArNTg2LDcgQEAKIAlyZXR1cm4g
cjsKIH0KIAorI2lmZGVmIENPTkZJR19YODZfSFQKIHN0YXRpYyB2b2lkIF9faW5pdCBkZXRlY3Rf
aHQodm9pZCkKIHsKIAlleHRlcm4JaW50IHBoeXNfcHJvY19pZFtOUl9DUFVTXTsKQEAgLTYzMiw2
ICs2MzMsNyBAQAogCQkgICAgICAgcGh5c19wcm9jX2lkW2NwdV0pOwogCX0KIH0KKyNlbmRpZgog
CQogI2RlZmluZSBMVkxfMV9JTlNUCTEKICNkZWZpbmUgTFZMXzFfREFUQQkyCkBAIC03NjEsOCAr
NzYzLDEwIEBACiAJCWMtPng4Nl9jYWNoZV9zaXplID0gbDIgPyBsMiA6IChsMWkrbDFkKTsKIAl9
CiAKKyNpZmRlZiBDT05GSUdfWDg2X0hUCiAJaWYgKGNwdV9oYXMoYywgWDg2X0ZFQVRVUkVfSFQp
KQogCQlkZXRlY3RfaHQoKTsgCisjZW5kaWYKIAogCW4gPSBjcHVpZF9lYXgoMHg4MDAwMDAwMCk7
CiAJaWYgKG4gPj0gMHg4MDAwMDAwOCkgewpkaWZmIC1OcnUgbGludXgvYXJjaC94ODZfNjQva2Vy
bmVsL3g4NjY0X2tzeW1zLmMgbGludXh+L2FyY2gveDg2XzY0L2tlcm5lbC94ODY2NF9rc3ltcy5j
Ci0tLSBsaW51eC9hcmNoL3g4Nl82NC9rZXJuZWwveDg2NjRfa3N5bXMuYwkyMDA0LTAyLTE5IDAz
OjEwOjU1LjAwMDAwMDAwMCAtMDgwMAorKysgbGludXh+L2FyY2gveDg2XzY0L2tlcm5lbC94ODY2
NF9rc3ltcy5jCTIwMDQtMDItMTkgMDM6MjA6MDQuMDAwMDAwMDAwIC0wODAwCkBAIC0xOTQsNyAr
MTk0LDEwIEBACiAKIEVYUE9SVF9TWU1CT0woZGllX2NoYWluKTsKIAorI2lmZGVmIENPTkZJR19Y
ODZfSFQKK0VYUE9SVF9TWU1CT0woc21wX251bV9zaWJsaW5ncyk7CiBFWFBPUlRfU1lNQk9MKGNw
dV9zaWJsaW5nX21hcCk7CisjZW5kaWYKIAogZXh0ZXJuIHZvaWQgZG9fc29mdGlycV90aHVuayh2
b2lkKTsKIEVYUE9SVF9TWU1CT0xfTk9WRVJTKGRvX3NvZnRpcnFfdGh1bmspOwpkaWZmIC1OcnUg
bGludXgvaW5jbHVkZS9hc20teDg2XzY0L3NlZ21lbnQuaCBsaW51eH4vaW5jbHVkZS9hc20teDg2
XzY0L3NlZ21lbnQuaAotLS0gbGludXgvaW5jbHVkZS9hc20teDg2XzY0L3NlZ21lbnQuaAkyMDA0
LTAyLTE5IDAzOjExOjA1LjAwMDAwMDAwMCAtMDgwMAorKysgbGludXh+L2luY2x1ZGUvYXNtLXg4
Nl82NC9zZWdtZW50LmgJMjAwNC0wMi0xOSAwNDoyMToxNy4wMDAwMDAwMDAgLTA4MDAKQEAgLTQw
LDcgKzQwLDcgQEAKICNkZWZpbmUgRlNfVExTX1NFTCAoKEdEVF9FTlRSWV9UTFNfTUlOK0ZTX1RM
UykqOCArIDMpCiAKICNkZWZpbmUgSURUX0VOVFJJRVMgMjU2Ci0jZGVmaW5lIEdEVF9FTlRSSUVT
IChMMV9DQUNIRV9CWVRFUyAvIDgpIAorI2RlZmluZSBHRFRfRU5UUklFUyAxNgogI2RlZmluZSBH
RFRfU0laRSAoR0RUX0VOVFJJRVMgKiA4KQogI2RlZmluZSBUTFNfU0laRSAoR0RUX0VOVFJZX1RM
U19FTlRSSUVTICogOCkgCiAK

------_=_NextPart_001_01C3F729.4948D2D8--
