Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265951AbTGBXpI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 19:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265949AbTGBXpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 19:45:07 -0400
Received: from fmr02.intel.com ([192.55.52.25]:25576 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S265952AbTGBXnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 19:43:13 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C340F5.B50F7650"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: [PATCH 2.4-ac] Proper APIC version identification
Date: Wed, 2 Jul 2003 16:57:34 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D0AC@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.4-ac] Proper APIC version identification
Thread-Index: AcM//G1rIx75pOoSTWukJkPyNDmfegA9vv+A
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>, "Bruno Cornec" <Bruno.Cornec@hp.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
X-OriginalArrivalTime: 02 Jul 2003 23:57:35.0062 (UTC) FILETIME=[B55FB760:01C340F5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C340F5.B50F7650
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi,

  The boot issue with DL760 G2 issue with Hyper-Threading (16-way
logical) was root-caused to be coming from hardcoding of apic-version
during the acpi boot-up code. The attached patch fixes the issue, by
reading in the actual apic version. This apic-version is used later in
the boot process, to identify whether the processor supports xAPIC or
not. And that in turn was resulting in boot failure.

Please include in the ac-patchset.

Refer following lkml threads for detailed the problem description:
Subject: SUMMARY: DL760 G2 issue with Hyper-Threading:
Subject: PROBLEM: DL760 G2 issue on 2.4.21 with Hyper-Threading

Thanks,
-Venkatesh

--- linux-2.4.21-ac2/arch/i386/kernel/mpparse.c.org	2003-06-30
12:52:21.000000000 -0700
+++ linux-2.4.21-ac2/arch/i386/kernel/mpparse.c	2003-07-01
16:07:40.000000000 -0700
@@ -999,7 +999,14 @@
=20
 	processor.mpc_type =3D MP_PROCESSOR;
 	processor.mpc_apicid =3D id;
-	processor.mpc_apicver =3D 0x10; /* TBD: lapic version */
+
+	/*
+	 * mp_register_lapic_address() which is called before the
+	 * current function does the fixmap of FIX_APIC_BASE.
+	 * Read in the correct APIC version from there
+	 */
+	processor.mpc_apicver =3D apic_read(APIC_LVR);
+=09
 	processor.mpc_cpuflag =3D (enabled ? CPU_ENABLED : 0);
 	processor.mpc_cpuflag |=3D (boot_cpu ? CPU_BOOTPROCESSOR : 0);
 	processor.mpc_cpufeature =3D (boot_cpu_data.x86 << 8) |=20

------_=_NextPart_001_01C340F5.B50F7650
Content-Type: application/octet-stream;
	name="acpi_apicversion.patch"
Content-Transfer-Encoding: base64
Content-Description: acpi_apicversion.patch
Content-Disposition: attachment;
	filename="acpi_apicversion.patch"

LS0tIGxpbnV4LTIuNC4yMS1hYzIvYXJjaC9pMzg2L2tlcm5lbC9tcHBhcnNlLmMub3JnCTIwMDMt
MDYtMzAgMTI6NTI6MjEuMDAwMDAwMDAwIC0wNzAwCisrKyBsaW51eC0yLjQuMjEtYWMyL2FyY2gv
aTM4Ni9rZXJuZWwvbXBwYXJzZS5jCTIwMDMtMDctMDEgMTY6MDc6NDAuMDAwMDAwMDAwIC0wNzAw
CkBAIC05OTksNyArOTk5LDE0IEBACiAKIAlwcm9jZXNzb3IubXBjX3R5cGUgPSBNUF9QUk9DRVNT
T1I7CiAJcHJvY2Vzc29yLm1wY19hcGljaWQgPSBpZDsKLQlwcm9jZXNzb3IubXBjX2FwaWN2ZXIg
PSAweDEwOyAvKiBUQkQ6IGxhcGljIHZlcnNpb24gKi8KKworCS8qCisJICogbXBfcmVnaXN0ZXJf
bGFwaWNfYWRkcmVzcygpIHdoaWNoIGlzIGNhbGxlZCBiZWZvcmUgdGhlCisJICogY3VycmVudCBm
dW5jdGlvbiBkb2VzIHRoZSBmaXhtYXAgb2YgRklYX0FQSUNfQkFTRS4KKwkgKiBSZWFkIGluIHRo
ZSBjb3JyZWN0IEFQSUMgdmVyc2lvbiBmcm9tIHRoZXJlCisJICovCisJcHJvY2Vzc29yLm1wY19h
cGljdmVyID0gYXBpY19yZWFkKEFQSUNfTFZSKTsKKwkKIAlwcm9jZXNzb3IubXBjX2NwdWZsYWcg
PSAoZW5hYmxlZCA/IENQVV9FTkFCTEVEIDogMCk7CiAJcHJvY2Vzc29yLm1wY19jcHVmbGFnIHw9
IChib290X2NwdSA/IENQVV9CT09UUFJPQ0VTU09SIDogMCk7CiAJcHJvY2Vzc29yLm1wY19jcHVm
ZWF0dXJlID0gKGJvb3RfY3B1X2RhdGEueDg2IDw8IDgpIHwgCg==

------_=_NextPart_001_01C340F5.B50F7650--
