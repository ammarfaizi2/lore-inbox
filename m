Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264360AbTKMSMz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 13:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264364AbTKMSMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 13:12:55 -0500
Received: from fmr06.intel.com ([134.134.136.7]:34760 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S264360AbTKMSMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 13:12:53 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C3AA11.BC4ABDC8"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: [PATCH][BUGFIX] Improper mapping of ACPI-HPET table
Date: Thu, 13 Nov 2003 10:12:44 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB60077A3B@scsmsx403.sc.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][BUGFIX] Improper mapping of ACPI-HPET table
Thread-Index: AcOqEbw0+37O7kAuRom91bDmOON/8Q==
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, <torvalds@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "Nakajima, Jun" <jun.nakajima@intel.com>
X-OriginalArrivalTime: 13 Nov 2003 18:12:45.0541 (UTC) FILETIME=[BCCFD950:01C3AA11]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C3AA11.BC4ABDC8
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi,

Early ACPI table parse for HPET tables has a bug, where in it=20
does not do proper set_fixmap for ACPI-HPET table.=20
This bug was lost in oversight, and was not noticed during=20
my testing too, as the ACPI-HPET table on all my test=20
systems happened to be in 1st Gig of memory (where __va()=20
will do the job).=20

Attached patch fixes the bug. Please apply.

Thanks,
-Venkatesh

--- linux-2.6.0-test9-bk17/arch/i386/kernel/acpi/boot.c.org	2003-11-13 =
12:10:18.000000000 -0800
+++ linux-2.6.0-test9-bk17/arch/i386/kernel/acpi/boot.c	2003-11-13 =
12:11:27.000000000 -0800
@@ -304,7 +304,14 @@ static int __init acpi_parse_hpet(unsign
 {
 	struct acpi_table_hpet *hpet_tbl;
=20
-	hpet_tbl =3D __va(phys);
+	if (!phys || !size)
+		return -EINVAL;
+
+	hpet_tbl =3D (struct acpi_table_hpet *) __acpi_map_table(phys, size);
+	if (!hpet_tbl) {
+		printk(KERN_WARNING PREFIX "Unable to map HPET\n");
+		return -ENODEV;
+	}
=20
 	if (hpet_tbl->addr.space_id !=3D ACPI_SPACE_MEM) {
 		printk(KERN_WARNING PREFIX "HPET timers must be located in "

=20

------_=_NextPart_001_01C3AA11.BC4ABDC8
Content-Type: application/octet-stream;
	name="hpet_va_bug_test9.patch"
Content-Transfer-Encoding: base64
Content-Description: hpet_va_bug_test9.patch
Content-Disposition: attachment;
	filename="hpet_va_bug_test9.patch"

LS0tIGxpbnV4LTIuNi4wLXRlc3Q5LWJrMTcvYXJjaC9pMzg2L2tlcm5lbC9hY3BpL2Jvb3QuYy5v
cmcJMjAwMy0xMS0xMyAxMjoxMDoxOC4wMDAwMDAwMDAgLTA4MDAKKysrIGxpbnV4LTIuNi4wLXRl
c3Q5LWJrMTcvYXJjaC9pMzg2L2tlcm5lbC9hY3BpL2Jvb3QuYwkyMDAzLTExLTEzIDEyOjExOjI3
LjAwMDAwMDAwMCAtMDgwMApAQCAtMzA0LDcgKzMwNCwxNCBAQCBzdGF0aWMgaW50IF9faW5pdCBh
Y3BpX3BhcnNlX2hwZXQodW5zaWduCiB7CiAJc3RydWN0IGFjcGlfdGFibGVfaHBldCAqaHBldF90
Ymw7CiAKLQlocGV0X3RibCA9IF9fdmEocGh5cyk7CisJaWYgKCFwaHlzIHx8ICFzaXplKQorCQly
ZXR1cm4gLUVJTlZBTDsKKworCWhwZXRfdGJsID0gKHN0cnVjdCBhY3BpX3RhYmxlX2hwZXQgKikg
X19hY3BpX21hcF90YWJsZShwaHlzLCBzaXplKTsKKwlpZiAoIWhwZXRfdGJsKSB7CisJCXByaW50
ayhLRVJOX1dBUk5JTkcgUFJFRklYICJVbmFibGUgdG8gbWFwIEhQRVRcbiIpOworCQlyZXR1cm4g
LUVOT0RFVjsKKwl9CiAKIAlpZiAoaHBldF90YmwtPmFkZHIuc3BhY2VfaWQgIT0gQUNQSV9TUEFD
RV9NRU0pIHsKIAkJcHJpbnRrKEtFUk5fV0FSTklORyBQUkVGSVggIkhQRVQgdGltZXJzIG11c3Qg
YmUgbG9jYXRlZCBpbiAiCg==

------_=_NextPart_001_01C3AA11.BC4ABDC8--
