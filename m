Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264822AbSLVGvJ>; Sun, 22 Dec 2002 01:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264838AbSLVGvJ>; Sun, 22 Dec 2002 01:51:09 -0500
Received: from fmr01.intel.com ([192.55.52.18]:56266 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S264822AbSLVGvC>;
	Sun, 22 Dec 2002 01:51:02 -0500
content-class: urn:content-classes:message
Subject: [PATCH][2.4]  generic support for systems with more than 8 CPUs (1/2)
Date: Sat, 21 Dec 2002 22:59:06 -0800
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1912E1B2@fmsmsx405.fm.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C2A987.9E66EE60"
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.4]  generic cluster APIC support for systems with more than 8 CPUs
Thread-Index: AcKoq5AZeN8SXBSdEdewVABQi2jYqAA2SZ4g
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@unisys.com>,
       "William Lee Irwin III" <wli@holomorphy.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "James Cleverdon" <jamesclv@us.ibm.com>,
       "John Stultz" <johnstul@us.ibm.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
Cc: "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>
X-OriginalArrivalTime: 22 Dec 2002 06:59:06.0773 (UTC) FILETIME=[9EAECC50:01C2A987]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C2A987.9E66EE60
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

1/2 : checking for xAPIC support in the system
Thanks,
-Venkatesh
diff -urN linux-2.4.21-pre2.org/arch/i386/kernel/acpitable.c =
linux-2.4.21-pre2/arch/i386/kernel/acpitable.c
--- linux-2.4.21-pre2.org/arch/i386/kernel/acpitable.c	2002-08-02 =
17:39:42.000000000 -0700
+++ linux-2.4.21-pre2/arch/i386/kernel/acpitable.c	2002-12-17 =
20:09:45.000000000 -0800
@@ -314,12 +314,15 @@
 int have_acpi_tables;
=20
 extern void __init MP_processor_info(struct mpc_config_processor *);
+extern unsigned int xapic_support;
=20
 static void __init
 acpi_parse_lapic(struct acpi_table_lapic *local_apic)
 {
 	struct mpc_config_processor proc_entry;
 	int ix =3D 0;
+	static unsigned long apic_ver;
+	static int first_time =3D 1;
=20
 	if (!local_apic)
 		return;
@@ -357,7 +360,16 @@
 		proc_entry.mpc_featureflag =3D boot_cpu_data.x86_capability[0];
 		proc_entry.mpc_reserved[0] =3D 0;
 		proc_entry.mpc_reserved[1] =3D 0;
-		proc_entry.mpc_apicver =3D 0x10;	/* integrated APIC */
+		if (first_time) {
+			first_time =3D 0;
+			set_fixmap(FIX_APIC_BASE, APIC_DEFAULT_PHYS_BASE);
+			Dprintk("Local APIC ID %lx\n", apic_read(APIC_ID));
+			apic_ver =3D apic_read(APIC_LVR);
+			Dprintk("Local APIC Version %lx\n", apic_ver);
+			if (APIC_XAPIC_SUPPORT(apic_ver))
+				xapic_support =3D 1;
+		}
+		proc_entry.mpc_apicver =3D apic_ver;
 		MP_processor_info(&proc_entry);
 	} else {
 		printk(" disabled");
diff -urN linux-2.4.21-pre2.org/arch/i386/kernel/io_apic.c =
linux-2.4.21-pre2/arch/i386/kernel/io_apic.c
--- linux-2.4.21-pre2.org/arch/i386/kernel/io_apic.c	2002-12-17 =
20:05:15.000000000 -0800
+++ linux-2.4.21-pre2/arch/i386/kernel/io_apic.c	2002-12-17 =
20:09:45.000000000 -0800
@@ -42,7 +42,7 @@
=20
 unsigned int int_dest_addr_mode =3D APIC_DEST_LOGICAL;
 unsigned char int_delivery_mode =3D dest_LowestPrio;
-
+extern unsigned int xapic_support;
=20
 /*
  * # of IRQ routing registers
@@ -1067,7 +1067,8 @@
 	=09
 		old_id =3D mp_ioapics[apic].mpc_apicid;
=20
-		if (mp_ioapics[apic].mpc_apicid >=3D apic_broadcast_id) {
+		if (!xapic_support &&=20
+		    (mp_ioapics[apic].mpc_apicid >=3D apic_broadcast_id)) {
 			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID is %d in the MPC =
table!...\n",
 				apic, mp_ioapics[apic].mpc_apicid);
 			printk(KERN_ERR "... fixing up to %d. (tell your hw vendor)\n",
@@ -1081,7 +1082,8 @@
 		 * 'stuck on smp_invalidate_needed IPI wait' messages.
 		 * I/O APIC IDs no longer have any meaning for xAPICs and SAPICs.
 		 */
-		if ((clustered_apic_mode !=3D CLUSTERED_APIC_XAPIC) &&
+		if (!xapic_support &&
+		    (clustered_apic_mode !=3D CLUSTERED_APIC_XAPIC) &&
 		    (phys_id_present_map & (1 << mp_ioapics[apic].mpc_apicid))) {
 			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID %d is already used!...\n",
 				apic, mp_ioapics[apic].mpc_apicid);
diff -urN linux-2.4.21-pre2.org/arch/i386/kernel/mpparse.c =
linux-2.4.21-pre2/arch/i386/kernel/mpparse.c
--- linux-2.4.21-pre2.org/arch/i386/kernel/mpparse.c	2002-12-17 =
20:05:15.000000000 -0800
+++ linux-2.4.21-pre2/arch/i386/kernel/mpparse.c	2002-12-17 =
20:09:45.000000000 -0800
@@ -74,6 +74,7 @@
 unsigned char clustered_apic_mode =3D CLUSTERED_APIC_NONE;
 unsigned int apic_broadcast_id =3D APIC_BROADCAST_ID_APIC;
 #endif
+unsigned int xapic_support =3D 0;
 unsigned char raw_phys_apicid[NR_CPUS] =3D { [0 ... NR_CPUS-1] =3D =
BAD_APICID };
=20
 /*
@@ -238,6 +239,8 @@
 		return;
 	}
 	ver =3D m->mpc_apicver;
+	if (APIC_XAPIC_SUPPORT(ver))
+		xapic_support =3D 1;
=20
 	logical_cpu_present_map |=3D 1 << (num_processors-1);
  	phys_cpu_present_map |=3D apicid_to_phys_cpu_present(m->mpc_apicid);
@@ -830,6 +833,7 @@
 		BUG();
=20
 	printk("Processors: %d\n", num_processors);
+	printk("xAPIC support %s present\n", (xapic_support?"is":"is not"));
 	/*
 	 * Only use the first configuration found.
 	 */
diff -urN linux-2.4.21-pre2.org/include/asm-i386/apicdef.h =
linux-2.4.21-pre2/include/asm-i386/apicdef.h
--- linux-2.4.21-pre2.org/include/asm-i386/apicdef.h	2002-12-17 =
20:05:16.000000000 -0800
+++ linux-2.4.21-pre2/include/asm-i386/apicdef.h	2002-12-17 =
20:09:45.000000000 -0800
@@ -18,6 +18,7 @@
 #define			GET_APIC_VERSION(x)	((x)&0xFF)
 #define			GET_APIC_MAXLVT(x)	(((x)>>16)&0xFF)
 #define			APIC_INTEGRATED(x)	((x)&0xF0)
+#define			APIC_XAPIC_SUPPORT(x)	((x)>=3D0x14)
 #define		APIC_TASKPRI	0x80
 #define			APIC_TPRI_MASK		0xFF
 #define		APIC_ARBPRI	0x90



------_=_NextPart_001_01C2A987.9E66EE60
Content-Type: application/octet-stream;
	name="xapic_2.4.21-pre2.patch"
Content-Transfer-Encoding: base64
Content-Description: xapic_2.4.21-pre2.patch
Content-Disposition: attachment;
	filename="xapic_2.4.21-pre2.patch"

ZGlmZiAtdXJOIGxpbnV4LTIuNC4yMS1wcmUyLm9yZy9hcmNoL2kzODYva2VybmVsL2FjcGl0YWJs
ZS5jIGxpbnV4LTIuNC4yMS1wcmUyL2FyY2gvaTM4Ni9rZXJuZWwvYWNwaXRhYmxlLmMKLS0tIGxp
bnV4LTIuNC4yMS1wcmUyLm9yZy9hcmNoL2kzODYva2VybmVsL2FjcGl0YWJsZS5jCTIwMDItMDgt
MDIgMTc6Mzk6NDIuMDAwMDAwMDAwIC0wNzAwCisrKyBsaW51eC0yLjQuMjEtcHJlMi9hcmNoL2kz
ODYva2VybmVsL2FjcGl0YWJsZS5jCTIwMDItMTItMTcgMjA6MDk6NDUuMDAwMDAwMDAwIC0wODAw
CkBAIC0zMTQsMTIgKzMxNCwxNSBAQAogaW50IGhhdmVfYWNwaV90YWJsZXM7CiAKIGV4dGVybiB2
b2lkIF9faW5pdCBNUF9wcm9jZXNzb3JfaW5mbyhzdHJ1Y3QgbXBjX2NvbmZpZ19wcm9jZXNzb3Ig
Kik7CitleHRlcm4gdW5zaWduZWQgaW50IHhhcGljX3N1cHBvcnQ7CiAKIHN0YXRpYyB2b2lkIF9f
aW5pdAogYWNwaV9wYXJzZV9sYXBpYyhzdHJ1Y3QgYWNwaV90YWJsZV9sYXBpYyAqbG9jYWxfYXBp
YykKIHsKIAlzdHJ1Y3QgbXBjX2NvbmZpZ19wcm9jZXNzb3IgcHJvY19lbnRyeTsKIAlpbnQgaXgg
PSAwOworCXN0YXRpYyB1bnNpZ25lZCBsb25nIGFwaWNfdmVyOworCXN0YXRpYyBpbnQgZmlyc3Rf
dGltZSA9IDE7CiAKIAlpZiAoIWxvY2FsX2FwaWMpCiAJCXJldHVybjsKQEAgLTM1Nyw3ICszNjAs
MTYgQEAKIAkJcHJvY19lbnRyeS5tcGNfZmVhdHVyZWZsYWcgPSBib290X2NwdV9kYXRhLng4Nl9j
YXBhYmlsaXR5WzBdOwogCQlwcm9jX2VudHJ5Lm1wY19yZXNlcnZlZFswXSA9IDA7CiAJCXByb2Nf
ZW50cnkubXBjX3Jlc2VydmVkWzFdID0gMDsKLQkJcHJvY19lbnRyeS5tcGNfYXBpY3ZlciA9IDB4
MTA7CS8qIGludGVncmF0ZWQgQVBJQyAqLworCQlpZiAoZmlyc3RfdGltZSkgeworCQkJZmlyc3Rf
dGltZSA9IDA7CisJCQlzZXRfZml4bWFwKEZJWF9BUElDX0JBU0UsIEFQSUNfREVGQVVMVF9QSFlT
X0JBU0UpOworCQkJRHByaW50aygiTG9jYWwgQVBJQyBJRCAlbHhcbiIsIGFwaWNfcmVhZChBUElD
X0lEKSk7CisJCQlhcGljX3ZlciA9IGFwaWNfcmVhZChBUElDX0xWUik7CisJCQlEcHJpbnRrKCJM
b2NhbCBBUElDIFZlcnNpb24gJWx4XG4iLCBhcGljX3Zlcik7CisJCQlpZiAoQVBJQ19YQVBJQ19T
VVBQT1JUKGFwaWNfdmVyKSkKKwkJCQl4YXBpY19zdXBwb3J0ID0gMTsKKwkJfQorCQlwcm9jX2Vu
dHJ5Lm1wY19hcGljdmVyID0gYXBpY192ZXI7CiAJCU1QX3Byb2Nlc3Nvcl9pbmZvKCZwcm9jX2Vu
dHJ5KTsKIAl9IGVsc2UgewogCQlwcmludGsoIiBkaXNhYmxlZCIpOwpkaWZmIC11ck4gbGludXgt
Mi40LjIxLXByZTIub3JnL2FyY2gvaTM4Ni9rZXJuZWwvaW9fYXBpYy5jIGxpbnV4LTIuNC4yMS1w
cmUyL2FyY2gvaTM4Ni9rZXJuZWwvaW9fYXBpYy5jCi0tLSBsaW51eC0yLjQuMjEtcHJlMi5vcmcv
YXJjaC9pMzg2L2tlcm5lbC9pb19hcGljLmMJMjAwMi0xMi0xNyAyMDowNToxNS4wMDAwMDAwMDAg
LTA4MDAKKysrIGxpbnV4LTIuNC4yMS1wcmUyL2FyY2gvaTM4Ni9rZXJuZWwvaW9fYXBpYy5jCTIw
MDItMTItMTcgMjA6MDk6NDUuMDAwMDAwMDAwIC0wODAwCkBAIC00Miw3ICs0Miw3IEBACiAKIHVu
c2lnbmVkIGludCBpbnRfZGVzdF9hZGRyX21vZGUgPSBBUElDX0RFU1RfTE9HSUNBTDsKIHVuc2ln
bmVkIGNoYXIgaW50X2RlbGl2ZXJ5X21vZGUgPSBkZXN0X0xvd2VzdFByaW87Ci0KK2V4dGVybiB1
bnNpZ25lZCBpbnQgeGFwaWNfc3VwcG9ydDsKIAogLyoKICAqICMgb2YgSVJRIHJvdXRpbmcgcmVn
aXN0ZXJzCkBAIC0xMDY3LDcgKzEwNjcsOCBAQAogCQkKIAkJb2xkX2lkID0gbXBfaW9hcGljc1th
cGljXS5tcGNfYXBpY2lkOwogCi0JCWlmIChtcF9pb2FwaWNzW2FwaWNdLm1wY19hcGljaWQgPj0g
YXBpY19icm9hZGNhc3RfaWQpIHsKKwkJaWYgKCF4YXBpY19zdXBwb3J0ICYmIAorCQkgICAgKG1w
X2lvYXBpY3NbYXBpY10ubXBjX2FwaWNpZCA+PSBhcGljX2Jyb2FkY2FzdF9pZCkpIHsKIAkJCXBy
aW50ayhLRVJOX0VSUiAiQklPUyBidWcsIElPLUFQSUMjJWQgSUQgaXMgJWQgaW4gdGhlIE1QQyB0
YWJsZSEuLi5cbiIsCiAJCQkJYXBpYywgbXBfaW9hcGljc1thcGljXS5tcGNfYXBpY2lkKTsKIAkJ
CXByaW50ayhLRVJOX0VSUiAiLi4uIGZpeGluZyB1cCB0byAlZC4gKHRlbGwgeW91ciBodyB2ZW5k
b3IpXG4iLApAQCAtMTA4MSw3ICsxMDgyLDggQEAKIAkJICogJ3N0dWNrIG9uIHNtcF9pbnZhbGlk
YXRlX25lZWRlZCBJUEkgd2FpdCcgbWVzc2FnZXMuCiAJCSAqIEkvTyBBUElDIElEcyBubyBsb25n
ZXIgaGF2ZSBhbnkgbWVhbmluZyBmb3IgeEFQSUNzIGFuZCBTQVBJQ3MuCiAJCSAqLwotCQlpZiAo
KGNsdXN0ZXJlZF9hcGljX21vZGUgIT0gQ0xVU1RFUkVEX0FQSUNfWEFQSUMpICYmCisJCWlmICgh
eGFwaWNfc3VwcG9ydCAmJgorCQkgICAgKGNsdXN0ZXJlZF9hcGljX21vZGUgIT0gQ0xVU1RFUkVE
X0FQSUNfWEFQSUMpICYmCiAJCSAgICAocGh5c19pZF9wcmVzZW50X21hcCAmICgxIDw8IG1wX2lv
YXBpY3NbYXBpY10ubXBjX2FwaWNpZCkpKSB7CiAJCQlwcmludGsoS0VSTl9FUlIgIkJJT1MgYnVn
LCBJTy1BUElDIyVkIElEICVkIGlzIGFscmVhZHkgdXNlZCEuLi5cbiIsCiAJCQkJYXBpYywgbXBf
aW9hcGljc1thcGljXS5tcGNfYXBpY2lkKTsKZGlmZiAtdXJOIGxpbnV4LTIuNC4yMS1wcmUyLm9y
Zy9hcmNoL2kzODYva2VybmVsL21wcGFyc2UuYyBsaW51eC0yLjQuMjEtcHJlMi9hcmNoL2kzODYv
a2VybmVsL21wcGFyc2UuYwotLS0gbGludXgtMi40LjIxLXByZTIub3JnL2FyY2gvaTM4Ni9rZXJu
ZWwvbXBwYXJzZS5jCTIwMDItMTItMTcgMjA6MDU6MTUuMDAwMDAwMDAwIC0wODAwCisrKyBsaW51
eC0yLjQuMjEtcHJlMi9hcmNoL2kzODYva2VybmVsL21wcGFyc2UuYwkyMDAyLTEyLTE3IDIwOjA5
OjQ1LjAwMDAwMDAwMCAtMDgwMApAQCAtNzQsNiArNzQsNyBAQAogdW5zaWduZWQgY2hhciBjbHVz
dGVyZWRfYXBpY19tb2RlID0gQ0xVU1RFUkVEX0FQSUNfTk9ORTsKIHVuc2lnbmVkIGludCBhcGlj
X2Jyb2FkY2FzdF9pZCA9IEFQSUNfQlJPQURDQVNUX0lEX0FQSUM7CiAjZW5kaWYKK3Vuc2lnbmVk
IGludCB4YXBpY19zdXBwb3J0ID0gMDsKIHVuc2lnbmVkIGNoYXIgcmF3X3BoeXNfYXBpY2lkW05S
X0NQVVNdID0geyBbMCAuLi4gTlJfQ1BVUy0xXSA9IEJBRF9BUElDSUQgfTsKIAogLyoKQEAgLTIz
OCw2ICsyMzksOCBAQAogCQlyZXR1cm47CiAJfQogCXZlciA9IG0tPm1wY19hcGljdmVyOworCWlm
IChBUElDX1hBUElDX1NVUFBPUlQodmVyKSkKKwkJeGFwaWNfc3VwcG9ydCA9IDE7CiAKIAlsb2dp
Y2FsX2NwdV9wcmVzZW50X21hcCB8PSAxIDw8IChudW1fcHJvY2Vzc29ycy0xKTsKICAJcGh5c19j
cHVfcHJlc2VudF9tYXAgfD0gYXBpY2lkX3RvX3BoeXNfY3B1X3ByZXNlbnQobS0+bXBjX2FwaWNp
ZCk7CkBAIC04MzAsNiArODMzLDcgQEAKIAkJQlVHKCk7CiAKIAlwcmludGsoIlByb2Nlc3NvcnM6
ICVkXG4iLCBudW1fcHJvY2Vzc29ycyk7CisJcHJpbnRrKCJ4QVBJQyBzdXBwb3J0ICVzIHByZXNl
bnRcbiIsICh4YXBpY19zdXBwb3J0PyJpcyI6ImlzIG5vdCIpKTsKIAkvKgogCSAqIE9ubHkgdXNl
IHRoZSBmaXJzdCBjb25maWd1cmF0aW9uIGZvdW5kLgogCSAqLwpkaWZmIC11ck4gbGludXgtMi40
LjIxLXByZTIub3JnL2luY2x1ZGUvYXNtLWkzODYvYXBpY2RlZi5oIGxpbnV4LTIuNC4yMS1wcmUy
L2luY2x1ZGUvYXNtLWkzODYvYXBpY2RlZi5oCi0tLSBsaW51eC0yLjQuMjEtcHJlMi5vcmcvaW5j
bHVkZS9hc20taTM4Ni9hcGljZGVmLmgJMjAwMi0xMi0xNyAyMDowNToxNi4wMDAwMDAwMDAgLTA4
MDAKKysrIGxpbnV4LTIuNC4yMS1wcmUyL2luY2x1ZGUvYXNtLWkzODYvYXBpY2RlZi5oCTIwMDIt
MTItMTcgMjA6MDk6NDUuMDAwMDAwMDAwIC0wODAwCkBAIC0xOCw2ICsxOCw3IEBACiAjZGVmaW5l
CQkJR0VUX0FQSUNfVkVSU0lPTih4KQkoKHgpJjB4RkYpCiAjZGVmaW5lCQkJR0VUX0FQSUNfTUFY
TFZUKHgpCSgoKHgpPj4xNikmMHhGRikKICNkZWZpbmUJCQlBUElDX0lOVEVHUkFURUQoeCkJKCh4
KSYweEYwKQorI2RlZmluZQkJCUFQSUNfWEFQSUNfU1VQUE9SVCh4KQkoKHgpPj0weDE0KQogI2Rl
ZmluZQkJQVBJQ19UQVNLUFJJCTB4ODAKICNkZWZpbmUJCQlBUElDX1RQUklfTUFTSwkJMHhGRgog
I2RlZmluZQkJQVBJQ19BUkJQUkkJMHg5MAo=

------_=_NextPart_001_01C2A987.9E66EE60--
