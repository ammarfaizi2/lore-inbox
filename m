Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWGYOpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWGYOpH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 10:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWGYOpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 10:45:06 -0400
Received: from mail0.lsil.com ([147.145.40.20]:10131 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S932365AbWGYOpD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 10:45:03 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C6AFF8.E684B27C"
Subject: [PATCH 2/3] scsi : megaraid_{mm,mbox}: a fix on INQUIRY with EVPD
Date: Tue, 25 Jul 2006 08:44:58 -0600
Message-ID: <890BF3111FB9484E9526987D912B261932E2D0@NAMAIL3.ad.lsil.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/3] scsi : megaraid_{mm,mbox}: a fix on INQUIRY with EVPD
Thread-Index: Acav+OYunB6tP6RwRkWURcVg4BgWPw==
From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
To: <James.Bottomley@SteelEye.com>, <akpm@osdl.org>
Cc: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       "Patro, Sumant" <Sumant.Patro@engenio.com>,
       "Yang, Bo" <Bo.Yang@engenio.com>
X-OriginalArrivalTime: 25 Jul 2006 14:44:58.0738 (UTC) FILETIME=[E6E86D20:01C6AFF8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6AFF8.E684B27C
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

This is a second patch which should be applied after the previous one
([PATCH 1/3]).

With this patch, driver will protect data corruption created by INQUIRY
with EVPD request
to megaraid controllers.
As specified in the changelog, megaraid F/W already has fixed the issue
and being under=20
process of release. Meanwhile, driver will protect the system with this
patch.

Thank you,

Seokmann

Signed-Off By: Seokmann Ju <seokmann.ju@lsil.com>
---
diff -Naur 64bitdma/Documentation/scsi/ChangeLog.megaraid
inqwithevpd/Documentation/scsi/ChangeLog.megaraid
--- 64bitdma/Documentation/scsi/ChangeLog.megaraid	2006-07-17
18:01:21.000000000 -0400
+++ inqwithevpd/Documentation/scsi/ChangeLog.megaraid	2006-07-24
15:35:02.000000000 -0400
@@ -59,6 +59,13 @@
 	> Buffer I/O error on device sda6, logical block 522067228
 	> attempt to access beyond end of device
=20
+2.	When INQUIRY with EVPD bit set issued to the MegaRAID
controller,
+	system memory gets corrupted.
+	Root Cause: MegaRAID F/W handle the INQUIRY with EVPD bit set
+	incorrectly.
+	Fix: MegaRAID F/W has fixed the problem and being process of
release,
+	soon. Meanwhile, driver will filter out the request.
+
 Release Date	: Mon Apr 11 12:27:22 EST 2006 - Seokmann Ju
<sju@lsil.com>
 Current Version : 2.20.4.8 (scsi module), 2.20.2.6 (cmm module)
 Older Version	: 2.20.4.7 (scsi module), 2.20.2.6 (cmm module)
diff -Naur 64bitdma/drivers/scsi/megaraid/mega_common.h
inqwithevpd/drivers/scsi/megaraid/mega_common.h
--- 64bitdma/drivers/scsi/megaraid/mega_common.h	2006-07-24
15:30:45.000000000 -0400
+++ inqwithevpd/drivers/scsi/megaraid/mega_common.h	2006-07-24
15:35:46.000000000 -0400
@@ -40,6 +40,9 @@
 #define HBA_SIGNATURE_64_BIT		0x299
 #define PCI_CONF_AMISIG64		0xa4
=20
+#define MEGA_SCSI_INQ_EVPD		1
+#define MEGA_INVALID_FIELD_IN_CDB	0x24
+
=20
 /**
  * scb_t - scsi command control block
diff -Naur 64bitdma/drivers/scsi/megaraid/megaraid_mbox.c
inqwithevpd/drivers/scsi/megaraid/megaraid_mbox.c
--- 64bitdma/drivers/scsi/megaraid/megaraid_mbox.c	2006-07-25
09:50:26.000000000 -0400
+++ inqwithevpd/drivers/scsi/megaraid/megaraid_mbox.c	2006-07-25
09:47:55.000000000 -0400
@@ -1644,6 +1644,14 @@
 				rdev->last_disp |=3D (1L <<
SCP2CHANNEL(scp));
 			}
=20
+			if (scp->cmnd[1] & MEGA_SCSI_INQ_EVPD) {
+				scp->sense_buffer[0] =3D 0x70;
+				scp->sense_buffer[2] =3D ILLEGAL_REQUEST;
+				scp->sense_buffer[12] =3D
MEGA_INVALID_FIELD_IN_CDB;
+				scp->result =3D CHECK_CONDITION << 1;
+				return NULL;
+			}
+
 			/* Fall through */
=20
 		case READ_CAPACITY:
---

------_=_NextPart_001_01C6AFF8.E684B27C
Content-Type: application/octet-stream;
	name="megaraid_inqwithevpd.patch"
Content-Transfer-Encoding: base64
Content-Description: megaraid_inqwithevpd.patch
Content-Disposition: attachment;
	filename="megaraid_inqwithevpd.patch"

ZGlmZiAtTmF1ciA2NGJpdGRtYS9Eb2N1bWVudGF0aW9uL3Njc2kvQ2hhbmdlTG9nLm1lZ2FyYWlk
IGlucXdpdGhldnBkL0RvY3VtZW50YXRpb24vc2NzaS9DaGFuZ2VMb2cubWVnYXJhaWQKLS0tIDY0
Yml0ZG1hL0RvY3VtZW50YXRpb24vc2NzaS9DaGFuZ2VMb2cubWVnYXJhaWQJMjAwNi0wNy0xNyAx
ODowMToyMS4wMDAwMDAwMDAgLTA0MDAKKysrIGlucXdpdGhldnBkL0RvY3VtZW50YXRpb24vc2Nz
aS9DaGFuZ2VMb2cubWVnYXJhaWQJMjAwNi0wNy0yNCAxNTozNTowMi4wMDAwMDAwMDAgLTA0MDAK
QEAgLTU5LDYgKzU5LDEzIEBACiAJPiBCdWZmZXIgSS9PIGVycm9yIG9uIGRldmljZSBzZGE2LCBs
b2dpY2FsIGJsb2NrIDUyMjA2NzIyOAogCT4gYXR0ZW1wdCB0byBhY2Nlc3MgYmV5b25kIGVuZCBv
ZiBkZXZpY2UKIAorMi4JV2hlbiBJTlFVSVJZIHdpdGggRVZQRCBiaXQgc2V0IGlzc3VlZCB0byB0
aGUgTWVnYVJBSUQgY29udHJvbGxlciwKKwlzeXN0ZW0gbWVtb3J5IGdldHMgY29ycnVwdGVkLgor
CVJvb3QgQ2F1c2U6IE1lZ2FSQUlEIEYvVyBoYW5kbGUgdGhlIElOUVVJUlkgd2l0aCBFVlBEIGJp
dCBzZXQKKwlpbmNvcnJlY3RseS4KKwlGaXg6IE1lZ2FSQUlEIEYvVyBoYXMgZml4ZWQgdGhlIHBy
b2JsZW0gYW5kIGJlaW5nIHByb2Nlc3Mgb2YgcmVsZWFzZSwKKwlzb29uLiBNZWFud2hpbGUsIGRy
aXZlciB3aWxsIGZpbHRlciBvdXQgdGhlIHJlcXVlc3QuCisKIFJlbGVhc2UgRGF0ZQk6IE1vbiBB
cHIgMTEgMTI6Mjc6MjIgRVNUIDIwMDYgLSBTZW9rbWFubiBKdSA8c2p1QGxzaWwuY29tPgogQ3Vy
cmVudCBWZXJzaW9uIDogMi4yMC40LjggKHNjc2kgbW9kdWxlKSwgMi4yMC4yLjYgKGNtbSBtb2R1
bGUpCiBPbGRlciBWZXJzaW9uCTogMi4yMC40LjcgKHNjc2kgbW9kdWxlKSwgMi4yMC4yLjYgKGNt
bSBtb2R1bGUpCmRpZmYgLU5hdXIgNjRiaXRkbWEvZHJpdmVycy9zY3NpL21lZ2FyYWlkL21lZ2Ff
Y29tbW9uLmggaW5xd2l0aGV2cGQvZHJpdmVycy9zY3NpL21lZ2FyYWlkL21lZ2FfY29tbW9uLmgK
LS0tIDY0Yml0ZG1hL2RyaXZlcnMvc2NzaS9tZWdhcmFpZC9tZWdhX2NvbW1vbi5oCTIwMDYtMDct
MjQgMTU6MzA6NDUuMDAwMDAwMDAwIC0wNDAwCisrKyBpbnF3aXRoZXZwZC9kcml2ZXJzL3Njc2kv
bWVnYXJhaWQvbWVnYV9jb21tb24uaAkyMDA2LTA3LTI0IDE1OjM1OjQ2LjAwMDAwMDAwMCAtMDQw
MApAQCAtNDAsNiArNDAsOSBAQAogI2RlZmluZSBIQkFfU0lHTkFUVVJFXzY0X0JJVAkJMHgyOTkK
ICNkZWZpbmUgUENJX0NPTkZfQU1JU0lHNjQJCTB4YTQKIAorI2RlZmluZSBNRUdBX1NDU0lfSU5R
X0VWUEQJCTEKKyNkZWZpbmUgTUVHQV9JTlZBTElEX0ZJRUxEX0lOX0NEQgkweDI0CisKIAogLyoq
CiAgKiBzY2JfdCAtIHNjc2kgY29tbWFuZCBjb250cm9sIGJsb2NrCmRpZmYgLU5hdXIgNjRiaXRk
bWEvZHJpdmVycy9zY3NpL21lZ2FyYWlkL21lZ2FyYWlkX21ib3guYyBpbnF3aXRoZXZwZC9kcml2
ZXJzL3Njc2kvbWVnYXJhaWQvbWVnYXJhaWRfbWJveC5jCi0tLSA2NGJpdGRtYS9kcml2ZXJzL3Nj
c2kvbWVnYXJhaWQvbWVnYXJhaWRfbWJveC5jCTIwMDYtMDctMjUgMDk6NTA6MjYuMDAwMDAwMDAw
IC0wNDAwCisrKyBpbnF3aXRoZXZwZC9kcml2ZXJzL3Njc2kvbWVnYXJhaWQvbWVnYXJhaWRfbWJv
eC5jCTIwMDYtMDctMjUgMDk6NDc6NTUuMDAwMDAwMDAwIC0wNDAwCkBAIC0xNjQ0LDYgKzE2NDQs
MTQgQEAKIAkJCQlyZGV2LT5sYXN0X2Rpc3AgfD0gKDFMIDw8IFNDUDJDSEFOTkVMKHNjcCkpOwog
CQkJfQogCisJCQlpZiAoc2NwLT5jbW5kWzFdICYgTUVHQV9TQ1NJX0lOUV9FVlBEKSB7CisJCQkJ
c2NwLT5zZW5zZV9idWZmZXJbMF0gPSAweDcwOworCQkJCXNjcC0+c2Vuc2VfYnVmZmVyWzJdID0g
SUxMRUdBTF9SRVFVRVNUOworCQkJCXNjcC0+c2Vuc2VfYnVmZmVyWzEyXSA9IE1FR0FfSU5WQUxJ
RF9GSUVMRF9JTl9DREI7CisJCQkJc2NwLT5yZXN1bHQgPSBDSEVDS19DT05ESVRJT04gPDwgMTsK
KwkJCQlyZXR1cm4gTlVMTDsKKwkJCX0KKwogCQkJLyogRmFsbCB0aHJvdWdoICovCiAKIAkJY2Fz
ZSBSRUFEX0NBUEFDSVRZOgo=

------_=_NextPart_001_01C6AFF8.E684B27C--
