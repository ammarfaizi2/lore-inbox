Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264838AbSLVGwG>; Sun, 22 Dec 2002 01:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264857AbSLVGwG>; Sun, 22 Dec 2002 01:52:06 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:61352 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S264838AbSLVGvL>; Sun, 22 Dec 2002 01:51:11 -0500
content-class: urn:content-classes:message
Subject: [PATCH][2.4]  generic support for systems with more than 8 CPUs (2/2)
Date: Sat, 21 Dec 2002 22:59:10 -0800
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1912E1B3@fmsmsx405.fm.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C2A987.A123E52E"
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.4]  generic cluster APIC support for systems with more than 8 CPUs
Thread-Index: AcKoq5AZeN8SXBSdEdewVABQi2jYqAA2d3Dg
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
X-OriginalArrivalTime: 22 Dec 2002 06:59:11.0367 (UTC) FILETIME=[A16BC970:01C2A987]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C2A987.A123E52E
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

2/2 : switching to physical mode APIC setup in case of more than 8 CPU =
system

Thanks,
-Venkatesh

diff -urN linux-2.4.21-pre2.org/Documentation/Configure.help =
linux-2.4.21-pre2/Documentation/Configure.help
--- linux-2.4.21-pre2.org/Documentation/Configure.help	2002-12-17 =
20:05:15.000000000 -0800
+++ linux-2.4.21-pre2/Documentation/Configure.help	2002-12-17 =
20:11:23.000000000 -0800
@@ -262,6 +262,13 @@
=20
   If you don't have this computer, you may safely say N.
=20
+Other more than 8 logical CPU system support
+CONFIG_X86_MANY_CPU
+  This option is required to support systems with more than 8 logical =
CPUs.
+
+  If you don't have such a computer, you may safely say N.
+  You dont have to choose this for IBM Summit/x440 systems.
+
 IO-APIC support on uniprocessors
 CONFIG_X86_UP_IOAPIC
   An IO-APIC (I/O Advanced Programmable Interrupt Controller) is an
diff -urN linux-2.4.21-pre2.org/arch/i386/config.in =
linux-2.4.21-pre2/arch/i386/config.in
--- linux-2.4.21-pre2.org/arch/i386/config.in	2002-12-17 =
20:05:15.000000000 -0800
+++ linux-2.4.21-pre2/arch/i386/config.in	2002-12-17 20:11:23.000000000 =
-0800
@@ -229,6 +229,10 @@
          define_bool CONFIG_X86_CLUSTERED_APIC y
       fi
    fi
+   bool 'Other more than 8 logical CPU system support' =
CONFIG_X86_MANY_CPU
+   if [ "$CONFIG_X86_MANY_CPU" =3D "y" ]; then
+      define_bool CONFIG_X86_CLUSTERED_APIC y
+   fi
 fi
=20
 if [ "$CONFIG_X86_NUMA" !=3D "y" ]; then
diff -urN linux-2.4.21-pre2.org/arch/i386/kernel/mpparse.c =
linux-2.4.21-pre2/arch/i386/kernel/mpparse.c
--- linux-2.4.21-pre2.org/arch/i386/kernel/mpparse.c	2002-12-17 =
20:12:21.000000000 -0800
+++ linux-2.4.21-pre2/arch/i386/kernel/mpparse.c	2002-12-17 =
20:11:23.000000000 -0800
@@ -590,15 +590,6 @@
 	}
=20
=20
-	printk("Enabling APIC mode: ");
-	if(clustered_apic_mode =3D=3D CLUSTERED_APIC_NUMAQ)
-		printk("Clustered Logical.	");
-	else if(clustered_apic_mode =3D=3D CLUSTERED_APIC_XAPIC)
-		printk("Physical.	");
-	else
-		printk("Flat.	");
-	printk("Using %d I/O APICs\n",nr_ioapics);
-
 	if (!num_processors)
 		printk(KERN_ERR "SMP mptable: no processors registered!\n");
 	return num_processors;
@@ -834,6 +825,33 @@
=20
 	printk("Processors: %d\n", num_processors);
 	printk("xAPIC support %s present\n", (xapic_support?"is":"is not"));
+
+#ifdef CONFIG_X86_CLUSTERED_APIC
+	/*
+	 * Switch to Physical destination mode in case of generic
+	 * more than 8 CPU system, which has xAPIC support
+	 */
+#define FLAT_APIC_CPU_MAX	8
+	if ((clustered_apic_mode =3D=3D CLUSTERED_APIC_NONE) &&
+	    (xapic_support) &&
+	    (num_processors > FLAT_APIC_CPU_MAX)) {
+		clustered_apic_mode =3D CLUSTERED_APIC_XAPIC;
+		apic_broadcast_id =3D APIC_BROADCAST_ID_XAPIC;
+		int_dest_addr_mode =3D APIC_DEST_PHYSICAL;
+		int_delivery_mode =3D dest_Fixed;
+		esr_disable =3D 1;
+	}
+#endif
+
+	printk("Enabling APIC mode: ");
+	if (clustered_apic_mode =3D=3D CLUSTERED_APIC_NUMAQ)
+		printk("Clustered Logical.	");
+	else if (clustered_apic_mode =3D=3D CLUSTERED_APIC_XAPIC)
+		printk("Physical.	");
+	else
+		printk("Flat.	");
+	printk("Using %d I/O APICs\n",nr_ioapics);
+
 	/*
 	 * Only use the first configuration found.
 	 */




------_=_NextPart_001_01C2A987.A123E52E
Content-Type: application/octet-stream;
	name="physapic_2.4.21-pre2.patch"
Content-Transfer-Encoding: base64
Content-Description: physapic_2.4.21-pre2.patch
Content-Disposition: attachment;
	filename="physapic_2.4.21-pre2.patch"

ZGlmZiAtdXJOIGxpbnV4LTIuNC4yMS1wcmUyLm9yZy9Eb2N1bWVudGF0aW9uL0NvbmZpZ3VyZS5o
ZWxwIGxpbnV4LTIuNC4yMS1wcmUyL0RvY3VtZW50YXRpb24vQ29uZmlndXJlLmhlbHAKLS0tIGxp
bnV4LTIuNC4yMS1wcmUyLm9yZy9Eb2N1bWVudGF0aW9uL0NvbmZpZ3VyZS5oZWxwCTIwMDItMTIt
MTcgMjA6MDU6MTUuMDAwMDAwMDAwIC0wODAwCisrKyBsaW51eC0yLjQuMjEtcHJlMi9Eb2N1bWVu
dGF0aW9uL0NvbmZpZ3VyZS5oZWxwCTIwMDItMTItMTcgMjA6MTE6MjMuMDAwMDAwMDAwIC0wODAw
CkBAIC0yNjIsNiArMjYyLDEzIEBACiAKICAgSWYgeW91IGRvbid0IGhhdmUgdGhpcyBjb21wdXRl
ciwgeW91IG1heSBzYWZlbHkgc2F5IE4uCiAKK090aGVyIG1vcmUgdGhhbiA4IGxvZ2ljYWwgQ1BV
IHN5c3RlbSBzdXBwb3J0CitDT05GSUdfWDg2X01BTllfQ1BVCisgIFRoaXMgb3B0aW9uIGlzIHJl
cXVpcmVkIHRvIHN1cHBvcnQgc3lzdGVtcyB3aXRoIG1vcmUgdGhhbiA4IGxvZ2ljYWwgQ1BVcy4K
KworICBJZiB5b3UgZG9uJ3QgaGF2ZSBzdWNoIGEgY29tcHV0ZXIsIHlvdSBtYXkgc2FmZWx5IHNh
eSBOLgorICBZb3UgZG9udCBoYXZlIHRvIGNob29zZSB0aGlzIGZvciBJQk0gU3VtbWl0L3g0NDAg
c3lzdGVtcy4KKwogSU8tQVBJQyBzdXBwb3J0IG9uIHVuaXByb2Nlc3NvcnMKIENPTkZJR19YODZf
VVBfSU9BUElDCiAgIEFuIElPLUFQSUMgKEkvTyBBZHZhbmNlZCBQcm9ncmFtbWFibGUgSW50ZXJy
dXB0IENvbnRyb2xsZXIpIGlzIGFuCmRpZmYgLXVyTiBsaW51eC0yLjQuMjEtcHJlMi5vcmcvYXJj
aC9pMzg2L2NvbmZpZy5pbiBsaW51eC0yLjQuMjEtcHJlMi9hcmNoL2kzODYvY29uZmlnLmluCi0t
LSBsaW51eC0yLjQuMjEtcHJlMi5vcmcvYXJjaC9pMzg2L2NvbmZpZy5pbgkyMDAyLTEyLTE3IDIw
OjA1OjE1LjAwMDAwMDAwMCAtMDgwMAorKysgbGludXgtMi40LjIxLXByZTIvYXJjaC9pMzg2L2Nv
bmZpZy5pbgkyMDAyLTEyLTE3IDIwOjExOjIzLjAwMDAwMDAwMCAtMDgwMApAQCAtMjI5LDYgKzIy
OSwxMCBAQAogICAgICAgICAgZGVmaW5lX2Jvb2wgQ09ORklHX1g4Nl9DTFVTVEVSRURfQVBJQyB5
CiAgICAgICBmaQogICAgZmkKKyAgIGJvb2wgJ090aGVyIG1vcmUgdGhhbiA4IGxvZ2ljYWwgQ1BV
IHN5c3RlbSBzdXBwb3J0JyBDT05GSUdfWDg2X01BTllfQ1BVCisgICBpZiBbICIkQ09ORklHX1g4
Nl9NQU5ZX0NQVSIgPSAieSIgXTsgdGhlbgorICAgICAgZGVmaW5lX2Jvb2wgQ09ORklHX1g4Nl9D
TFVTVEVSRURfQVBJQyB5CisgICBmaQogZmkKIAogaWYgWyAiJENPTkZJR19YODZfTlVNQSIgIT0g
InkiIF07IHRoZW4KZGlmZiAtdXJOIGxpbnV4LTIuNC4yMS1wcmUyLm9yZy9hcmNoL2kzODYva2Vy
bmVsL21wcGFyc2UuYyBsaW51eC0yLjQuMjEtcHJlMi9hcmNoL2kzODYva2VybmVsL21wcGFyc2Uu
YwotLS0gbGludXgtMi40LjIxLXByZTIub3JnL2FyY2gvaTM4Ni9rZXJuZWwvbXBwYXJzZS5jCTIw
MDItMTItMTcgMjA6MTI6MjEuMDAwMDAwMDAwIC0wODAwCisrKyBsaW51eC0yLjQuMjEtcHJlMi9h
cmNoL2kzODYva2VybmVsL21wcGFyc2UuYwkyMDAyLTEyLTE3IDIwOjExOjIzLjAwMDAwMDAwMCAt
MDgwMApAQCAtNTkwLDE1ICs1OTAsNiBAQAogCX0KIAogCi0JcHJpbnRrKCJFbmFibGluZyBBUElD
IG1vZGU6ICIpOwotCWlmKGNsdXN0ZXJlZF9hcGljX21vZGUgPT0gQ0xVU1RFUkVEX0FQSUNfTlVN
QVEpCi0JCXByaW50aygiQ2x1c3RlcmVkIExvZ2ljYWwuCSIpOwotCWVsc2UgaWYoY2x1c3RlcmVk
X2FwaWNfbW9kZSA9PSBDTFVTVEVSRURfQVBJQ19YQVBJQykKLQkJcHJpbnRrKCJQaHlzaWNhbC4J
Iik7Ci0JZWxzZQotCQlwcmludGsoIkZsYXQuCSIpOwotCXByaW50aygiVXNpbmcgJWQgSS9PIEFQ
SUNzXG4iLG5yX2lvYXBpY3MpOwotCiAJaWYgKCFudW1fcHJvY2Vzc29ycykKIAkJcHJpbnRrKEtF
Uk5fRVJSICJTTVAgbXB0YWJsZTogbm8gcHJvY2Vzc29ycyByZWdpc3RlcmVkIVxuIik7CiAJcmV0
dXJuIG51bV9wcm9jZXNzb3JzOwpAQCAtODM0LDYgKzgyNSwzMyBAQAogCiAJcHJpbnRrKCJQcm9j
ZXNzb3JzOiAlZFxuIiwgbnVtX3Byb2Nlc3NvcnMpOwogCXByaW50aygieEFQSUMgc3VwcG9ydCAl
cyBwcmVzZW50XG4iLCAoeGFwaWNfc3VwcG9ydD8iaXMiOiJpcyBub3QiKSk7CisKKyNpZmRlZiBD
T05GSUdfWDg2X0NMVVNURVJFRF9BUElDCisJLyoKKwkgKiBTd2l0Y2ggdG8gUGh5c2ljYWwgZGVz
dGluYXRpb24gbW9kZSBpbiBjYXNlIG9mIGdlbmVyaWMKKwkgKiBtb3JlIHRoYW4gOCBDUFUgc3lz
dGVtLCB3aGljaCBoYXMgeEFQSUMgc3VwcG9ydAorCSAqLworI2RlZmluZSBGTEFUX0FQSUNfQ1BV
X01BWAk4CisJaWYgKChjbHVzdGVyZWRfYXBpY19tb2RlID09IENMVVNURVJFRF9BUElDX05PTkUp
ICYmCisJICAgICh4YXBpY19zdXBwb3J0KSAmJgorCSAgICAobnVtX3Byb2Nlc3NvcnMgPiBGTEFU
X0FQSUNfQ1BVX01BWCkpIHsKKwkJY2x1c3RlcmVkX2FwaWNfbW9kZSA9IENMVVNURVJFRF9BUElD
X1hBUElDOworCQlhcGljX2Jyb2FkY2FzdF9pZCA9IEFQSUNfQlJPQURDQVNUX0lEX1hBUElDOwor
CQlpbnRfZGVzdF9hZGRyX21vZGUgPSBBUElDX0RFU1RfUEhZU0lDQUw7CisJCWludF9kZWxpdmVy
eV9tb2RlID0gZGVzdF9GaXhlZDsKKwkJZXNyX2Rpc2FibGUgPSAxOworCX0KKyNlbmRpZgorCisJ
cHJpbnRrKCJFbmFibGluZyBBUElDIG1vZGU6ICIpOworCWlmIChjbHVzdGVyZWRfYXBpY19tb2Rl
ID09IENMVVNURVJFRF9BUElDX05VTUFRKQorCQlwcmludGsoIkNsdXN0ZXJlZCBMb2dpY2FsLgki
KTsKKwllbHNlIGlmIChjbHVzdGVyZWRfYXBpY19tb2RlID09IENMVVNURVJFRF9BUElDX1hBUElD
KQorCQlwcmludGsoIlBoeXNpY2FsLgkiKTsKKwllbHNlCisJCXByaW50aygiRmxhdC4JIik7CisJ
cHJpbnRrKCJVc2luZyAlZCBJL08gQVBJQ3NcbiIsbnJfaW9hcGljcyk7CisKIAkvKgogCSAqIE9u
bHkgdXNlIHRoZSBmaXJzdCBjb25maWd1cmF0aW9uIGZvdW5kLgogCSAqLwo=

------_=_NextPart_001_01C2A987.A123E52E--
