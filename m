Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWGYOpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWGYOpT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 10:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWGYOpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 10:45:15 -0400
Received: from mail0.lsil.com ([147.145.40.20]:14227 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S932366AbWGYOpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 10:45:12 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C6AFF8.EB934905"
Subject: [PATCH 3/3] scsi : megaraid_{mm,mbox}: a fix on "kernel unaligned access address" issue
Date: Tue, 25 Jul 2006 08:45:06 -0600
Message-ID: <890BF3111FB9484E9526987D912B261932E2D1@NAMAIL3.ad.lsil.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 3/3] scsi : megaraid_{mm,mbox}: a fix on "kernel unaligned access address" issue
Thread-Index: Acav+OtFYaNMVKNmQry+OjTSY1p2+g==
From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
To: <sakurai_hiro@soft.fujitsu.com>, <James.Bottomley@SteelEye.com>,
       <akpm@osdl.org>
Cc: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       "Patro, Sumant" <Sumant.Patro@engenio.com>,
       "Yang, Bo" <Bo.Yang@engenio.com>
X-OriginalArrivalTime: 25 Jul 2006 14:45:07.0269 (UTC) FILETIME=[EBFE2750:01C6AFF8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6AFF8.EB934905
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

This is a third patch which follows prevous two patches ([PATCH 1/3] and
[PATCH 2/3]).

There was an issue in the data structure defined by megaraid driver
casuing "kernel unaligned access.." messages to be displayed during
IOCTL on IA64 platform.

The issue has been reported/fixed by Sakurai Hiroomi
[sakurai_hiro@soft.fujitsu.com].

Thank you Sakurai for you help.

Thank you,

Seokmann

Signed-Off By: Seokmann Ju <seokmann.ju@lsil.com>
---
diff -Naur inqwithevpd/Documentation/scsi/ChangeLog.megaraid
unaligned/Documentation/scsi/ChangeLog.megaraid
--- inqwithevpd/Documentation/scsi/ChangeLog.megaraid	2006-07-24
15:35:02.000000000 -0400
+++ unaligned/Documentation/scsi/ChangeLog.megaraid	2006-07-24
15:41:49.000000000 -0400
@@ -66,6 +66,61 @@
 	Fix: MegaRAID F/W has fixed the problem and being process of
release,
 	soon. Meanwhile, driver will filter out the request.
=20
+3.	One of member in the data structure of the driver leads unaligne
+	issue on 64-bit platform.
+	Customer reporeted "kernel unaligned access addrss" issue when
+	application communicates with MegaRAID HBA driver.
+	Root Cause: in uioc_t structure, one of member had misaligned
and it
+	led system to display the error message.
+	Fix: A patch submitted to community from following folk.
+
+	> -----Original Message-----
+	> From: linux-scsi-owner@vger.kernel.org=20
+	> [mailto:linux-scsi-owner@vger.kernel.org] On Behalf Of Sakurai
Hiroomi
+	> Sent: Wednesday, July 12, 2006 4:20 AM
+	> To: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org
+	> Subject: Re: Help: strange messages from kernel on IA64
platform
+	>=20
+	> Hi,
+	>=20
+	> I saw same message.
+	>=20
+	> When GAM(Global Array Manager) is started, The following=20
+	> message output.
+	> kernel: kernel unaligned access to 0xe0000001fe1080d4,=20
+	> ip=3D0xa000000200053371
+	>=20
+	> The uioc structure used by ioctl is defined by packed,
+	> the allignment of each member are disturbed.
+	> In a 64 bit structure, the allignment of member doesn't fit 64
bit
+	> boundary. this causes this messages.
+	> In a 32 bit structure, we don't see the message because the
allinment
+	> of member fit 32 bit boundary even if packed is specified.=20
+	>=20
+	> patch
+	> I Add 32 bit dummy member to fit 64 bit boundary. I tested.
+	> We confirmed this patch fix the problem by IA64 server.
+	>=20
+	> **************************************************************
+	> ****************
+	> --- linux-2.6.9/drivers/scsi/megaraid/megaraid_ioctl.h.orig=09
+	> 2006-04-03 17:13:03.000000000 +0900
+	> +++ linux-2.6.9/drivers/scsi/megaraid/megaraid_ioctl.h=09
+	> 2006-04-03 17:14:09.000000000 +0900
+	> @@ -132,6 +132,10 @@
+	>  /* Driver Data: */
+	>          void __user *           user_data;
+	>          uint32_t                user_data_len;
+	> +
+	> +        /* 64bit alignment */
+	> +        uint32_t                pad_0xBC;
+	> +
+	>          mraid_passthru_t        __user *user_pthru;
+	> =20
+	>          mraid_passthru_t        *pthru32;
+	> **************************************************************
+	> ****************
+
 Release Date	: Mon Apr 11 12:27:22 EST 2006 - Seokmann Ju
<sju@lsil.com>
 Current Version : 2.20.4.8 (scsi module), 2.20.2.6 (cmm module)
 Older Version	: 2.20.4.7 (scsi module), 2.20.2.6 (cmm module)
diff -Naur inqwithevpd/drivers/scsi/megaraid/megaraid_ioctl.h
unaligned/drivers/scsi/megaraid/megaraid_ioctl.h
--- inqwithevpd/drivers/scsi/megaraid/megaraid_ioctl.h	2006-07-24
15:32:27.000000000 -0400
+++ unaligned/drivers/scsi/megaraid/megaraid_ioctl.h	2006-07-24
16:40:56.000000000 -0400
@@ -132,6 +132,10 @@
 /* Driver Data: */
 	void __user *		user_data;
 	uint32_t		user_data_len;
+
+	/* 64bit alignment */
+	uint32_t                pad_for_64bit_align;
+
 	mraid_passthru_t	__user *user_pthru;
=20
 	mraid_passthru_t	*pthru32;
diff -Naur inqwithevpd/drivers/scsi/megaraid/megaraid_mm.c
unaligned/drivers/scsi/megaraid/megaraid_mm.c
--- inqwithevpd/drivers/scsi/megaraid/megaraid_mm.c	2006-07-24
15:32:27.000000000 -0400
+++ unaligned/drivers/scsi/megaraid/megaraid_mm.c	2006-07-24
15:44:14.000000000 -0400
@@ -10,7 +10,7 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_mm.c
- * Version	: v2.20.2.6 (Mar 7 2005)
+ * Version	: v2.20.2.7 (Jul 16 2006)
  *
  * Common management module
  */
diff -Naur inqwithevpd/drivers/scsi/megaraid/megaraid_mm.h
unaligned/drivers/scsi/megaraid/megaraid_mm.h
--- inqwithevpd/drivers/scsi/megaraid/megaraid_mm.h	2006-07-24
15:32:27.000000000 -0400
+++ unaligned/drivers/scsi/megaraid/megaraid_mm.h	2006-07-24
15:44:44.000000000 -0400
@@ -27,9 +27,9 @@
 #include "megaraid_ioctl.h"
=20
=20
-#define LSI_COMMON_MOD_VERSION	"2.20.2.6"
+#define LSI_COMMON_MOD_VERSION	"2.20.2.7"
 #define LSI_COMMON_MOD_EXT_VERSION	\
-		"(Release Date: Mon Mar 7 00:01:03 EST 2005)"
+		"(Release Date: Sun Jul 16 00:01:03 EST 2006)"
=20
=20
 #define LSI_DBGLVL			dbglevel
---

------_=_NextPart_001_01C6AFF8.EB934905
Content-Type: application/octet-stream;
	name="megaraid_unaligned.patch"
Content-Transfer-Encoding: base64
Content-Description: megaraid_unaligned.patch
Content-Disposition: attachment;
	filename="megaraid_unaligned.patch"

ZGlmZiAtTmF1ciBpbnF3aXRoZXZwZC9Eb2N1bWVudGF0aW9uL3Njc2kvQ2hhbmdlTG9nLm1lZ2Fy
YWlkIHVuYWxpZ25lZC9Eb2N1bWVudGF0aW9uL3Njc2kvQ2hhbmdlTG9nLm1lZ2FyYWlkCi0tLSBp
bnF3aXRoZXZwZC9Eb2N1bWVudGF0aW9uL3Njc2kvQ2hhbmdlTG9nLm1lZ2FyYWlkCTIwMDYtMDct
MjQgMTU6MzU6MDIuMDAwMDAwMDAwIC0wNDAwCisrKyB1bmFsaWduZWQvRG9jdW1lbnRhdGlvbi9z
Y3NpL0NoYW5nZUxvZy5tZWdhcmFpZAkyMDA2LTA3LTI0IDE1OjQxOjQ5LjAwMDAwMDAwMCAtMDQw
MApAQCAtNjYsNiArNjYsNjEgQEAKIAlGaXg6IE1lZ2FSQUlEIEYvVyBoYXMgZml4ZWQgdGhlIHBy
b2JsZW0gYW5kIGJlaW5nIHByb2Nlc3Mgb2YgcmVsZWFzZSwKIAlzb29uLiBNZWFud2hpbGUsIGRy
aXZlciB3aWxsIGZpbHRlciBvdXQgdGhlIHJlcXVlc3QuCiAKKzMuCU9uZSBvZiBtZW1iZXIgaW4g
dGhlIGRhdGEgc3RydWN0dXJlIG9mIHRoZSBkcml2ZXIgbGVhZHMgdW5hbGlnbmUKKwlpc3N1ZSBv
biA2NC1iaXQgcGxhdGZvcm0uCisJQ3VzdG9tZXIgcmVwb3JldGVkICJrZXJuZWwgdW5hbGlnbmVk
IGFjY2VzcyBhZGRyc3MiIGlzc3VlIHdoZW4KKwlhcHBsaWNhdGlvbiBjb21tdW5pY2F0ZXMgd2l0
aCBNZWdhUkFJRCBIQkEgZHJpdmVyLgorCVJvb3QgQ2F1c2U6IGluIHVpb2NfdCBzdHJ1Y3R1cmUs
IG9uZSBvZiBtZW1iZXIgaGFkIG1pc2FsaWduZWQgYW5kIGl0CisJbGVkIHN5c3RlbSB0byBkaXNw
bGF5IHRoZSBlcnJvciBtZXNzYWdlLgorCUZpeDogQSBwYXRjaCBzdWJtaXR0ZWQgdG8gY29tbXVu
aXR5IGZyb20gZm9sbG93aW5nIGZvbGsuCisKKwk+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
CisJPiBGcm9tOiBsaW51eC1zY3NpLW93bmVyQHZnZXIua2VybmVsLm9yZyAKKwk+IFttYWlsdG86
bGludXgtc2NzaS1vd25lckB2Z2VyLmtlcm5lbC5vcmddIE9uIEJlaGFsZiBPZiBTYWt1cmFpIEhp
cm9vbWkKKwk+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAxMiwgMjAwNiA0OjIwIEFNCisJPiBUbzog
bGludXgtc2NzaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcK
Kwk+IFN1YmplY3Q6IFJlOiBIZWxwOiBzdHJhbmdlIG1lc3NhZ2VzIGZyb20ga2VybmVsIG9uIElB
NjQgcGxhdGZvcm0KKwk+IAorCT4gSGksCisJPiAKKwk+IEkgc2F3IHNhbWUgbWVzc2FnZS4KKwk+
IAorCT4gV2hlbiBHQU0oR2xvYmFsIEFycmF5IE1hbmFnZXIpIGlzIHN0YXJ0ZWQsIFRoZSBmb2xs
b3dpbmcgCisJPiBtZXNzYWdlIG91dHB1dC4KKwk+IGtlcm5lbDoga2VybmVsIHVuYWxpZ25lZCBh
Y2Nlc3MgdG8gMHhlMDAwMDAwMWZlMTA4MGQ0LCAKKwk+IGlwPTB4YTAwMDAwMDIwMDA1MzM3MQor
CT4gCisJPiBUaGUgdWlvYyBzdHJ1Y3R1cmUgdXNlZCBieSBpb2N0bCBpcyBkZWZpbmVkIGJ5IHBh
Y2tlZCwKKwk+IHRoZSBhbGxpZ25tZW50IG9mIGVhY2ggbWVtYmVyIGFyZSBkaXN0dXJiZWQuCisJ
PiBJbiBhIDY0IGJpdCBzdHJ1Y3R1cmUsIHRoZSBhbGxpZ25tZW50IG9mIG1lbWJlciBkb2Vzbid0
IGZpdCA2NCBiaXQKKwk+IGJvdW5kYXJ5LiB0aGlzIGNhdXNlcyB0aGlzIG1lc3NhZ2VzLgorCT4g
SW4gYSAzMiBiaXQgc3RydWN0dXJlLCB3ZSBkb24ndCBzZWUgdGhlIG1lc3NhZ2UgYmVjYXVzZSB0
aGUgYWxsaW5tZW50CisJPiBvZiBtZW1iZXIgZml0IDMyIGJpdCBib3VuZGFyeSBldmVuIGlmIHBh
Y2tlZCBpcyBzcGVjaWZpZWQuIAorCT4gCisJPiBwYXRjaAorCT4gSSBBZGQgMzIgYml0IGR1bW15
IG1lbWJlciB0byBmaXQgNjQgYml0IGJvdW5kYXJ5LiBJIHRlc3RlZC4KKwk+IFdlIGNvbmZpcm1l
ZCB0aGlzIHBhdGNoIGZpeCB0aGUgcHJvYmxlbSBieSBJQTY0IHNlcnZlci4KKwk+IAorCT4gKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioKKwk+ICoqKioqKioqKioqKioqKioKKwk+IC0tLSBsaW51eC0yLjYuOS9kcml2ZXJzL3Njc2kv
bWVnYXJhaWQvbWVnYXJhaWRfaW9jdGwuaC5vcmlnCQorCT4gMjAwNi0wNC0wMyAxNzoxMzowMy4w
MDAwMDAwMDAgKzA5MDAKKwk+ICsrKyBsaW51eC0yLjYuOS9kcml2ZXJzL3Njc2kvbWVnYXJhaWQv
bWVnYXJhaWRfaW9jdGwuaAkKKwk+IDIwMDYtMDQtMDMgMTc6MTQ6MDkuMDAwMDAwMDAwICswOTAw
CisJPiBAQCAtMTMyLDYgKzEzMiwxMCBAQAorCT4gIC8qIERyaXZlciBEYXRhOiAqLworCT4gICAg
ICAgICAgdm9pZCBfX3VzZXIgKiAgICAgICAgICAgdXNlcl9kYXRhOworCT4gICAgICAgICAgdWlu
dDMyX3QgICAgICAgICAgICAgICAgdXNlcl9kYXRhX2xlbjsKKwk+ICsKKwk+ICsgICAgICAgIC8q
IDY0Yml0IGFsaWdubWVudCAqLworCT4gKyAgICAgICAgdWludDMyX3QgICAgICAgICAgICAgICAg
cGFkXzB4QkM7CisJPiArCisJPiAgICAgICAgICBtcmFpZF9wYXNzdGhydV90ICAgICAgICBfX3Vz
ZXIgKnVzZXJfcHRocnU7CisJPiAgCisJPiAgICAgICAgICBtcmFpZF9wYXNzdGhydV90ICAgICAg
ICAqcHRocnUzMjsKKwk+ICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqCisJPiAqKioqKioqKioqKioqKioqCisKIFJlbGVhc2UgRGF0
ZQk6IE1vbiBBcHIgMTEgMTI6Mjc6MjIgRVNUIDIwMDYgLSBTZW9rbWFubiBKdSA8c2p1QGxzaWwu
Y29tPgogQ3VycmVudCBWZXJzaW9uIDogMi4yMC40LjggKHNjc2kgbW9kdWxlKSwgMi4yMC4yLjYg
KGNtbSBtb2R1bGUpCiBPbGRlciBWZXJzaW9uCTogMi4yMC40LjcgKHNjc2kgbW9kdWxlKSwgMi4y
MC4yLjYgKGNtbSBtb2R1bGUpCmRpZmYgLU5hdXIgaW5xd2l0aGV2cGQvZHJpdmVycy9zY3NpL21l
Z2FyYWlkL21lZ2FyYWlkX2lvY3RsLmggdW5hbGlnbmVkL2RyaXZlcnMvc2NzaS9tZWdhcmFpZC9t
ZWdhcmFpZF9pb2N0bC5oCi0tLSBpbnF3aXRoZXZwZC9kcml2ZXJzL3Njc2kvbWVnYXJhaWQvbWVn
YXJhaWRfaW9jdGwuaAkyMDA2LTA3LTI0IDE1OjMyOjI3LjAwMDAwMDAwMCAtMDQwMAorKysgdW5h
bGlnbmVkL2RyaXZlcnMvc2NzaS9tZWdhcmFpZC9tZWdhcmFpZF9pb2N0bC5oCTIwMDYtMDctMjQg
MTY6NDA6NTYuMDAwMDAwMDAwIC0wNDAwCkBAIC0xMzIsNiArMTMyLDEwIEBACiAvKiBEcml2ZXIg
RGF0YTogKi8KIAl2b2lkIF9fdXNlciAqCQl1c2VyX2RhdGE7CiAJdWludDMyX3QJCXVzZXJfZGF0
YV9sZW47CisKKwkvKiA2NGJpdCBhbGlnbm1lbnQgKi8KKwl1aW50MzJfdCAgICAgICAgICAgICAg
ICBwYWRfZm9yXzY0Yml0X2FsaWduOworCiAJbXJhaWRfcGFzc3RocnVfdAlfX3VzZXIgKnVzZXJf
cHRocnU7CiAKIAltcmFpZF9wYXNzdGhydV90CSpwdGhydTMyOwpkaWZmIC1OYXVyIGlucXdpdGhl
dnBkL2RyaXZlcnMvc2NzaS9tZWdhcmFpZC9tZWdhcmFpZF9tbS5jIHVuYWxpZ25lZC9kcml2ZXJz
L3Njc2kvbWVnYXJhaWQvbWVnYXJhaWRfbW0uYwotLS0gaW5xd2l0aGV2cGQvZHJpdmVycy9zY3Np
L21lZ2FyYWlkL21lZ2FyYWlkX21tLmMJMjAwNi0wNy0yNCAxNTozMjoyNy4wMDAwMDAwMDAgLTA0
MDAKKysrIHVuYWxpZ25lZC9kcml2ZXJzL3Njc2kvbWVnYXJhaWQvbWVnYXJhaWRfbW0uYwkyMDA2
LTA3LTI0IDE1OjQ0OjE0LjAwMDAwMDAwMCAtMDQwMApAQCAtMTAsNyArMTAsNyBAQAogICoJICAg
MiBvZiB0aGUgTGljZW5zZSwgb3IgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4K
ICAqCiAgKiBGSUxFCQk6IG1lZ2FyYWlkX21tLmMKLSAqIFZlcnNpb24JOiB2Mi4yMC4yLjYgKE1h
ciA3IDIwMDUpCisgKiBWZXJzaW9uCTogdjIuMjAuMi43IChKdWwgMTYgMjAwNikKICAqCiAgKiBD
b21tb24gbWFuYWdlbWVudCBtb2R1bGUKICAqLwpkaWZmIC1OYXVyIGlucXdpdGhldnBkL2RyaXZl
cnMvc2NzaS9tZWdhcmFpZC9tZWdhcmFpZF9tbS5oIHVuYWxpZ25lZC9kcml2ZXJzL3Njc2kvbWVn
YXJhaWQvbWVnYXJhaWRfbW0uaAotLS0gaW5xd2l0aGV2cGQvZHJpdmVycy9zY3NpL21lZ2FyYWlk
L21lZ2FyYWlkX21tLmgJMjAwNi0wNy0yNCAxNTozMjoyNy4wMDAwMDAwMDAgLTA0MDAKKysrIHVu
YWxpZ25lZC9kcml2ZXJzL3Njc2kvbWVnYXJhaWQvbWVnYXJhaWRfbW0uaAkyMDA2LTA3LTI0IDE1
OjQ0OjQ0LjAwMDAwMDAwMCAtMDQwMApAQCAtMjcsOSArMjcsOSBAQAogI2luY2x1ZGUgIm1lZ2Fy
YWlkX2lvY3RsLmgiCiAKIAotI2RlZmluZSBMU0lfQ09NTU9OX01PRF9WRVJTSU9OCSIyLjIwLjIu
NiIKKyNkZWZpbmUgTFNJX0NPTU1PTl9NT0RfVkVSU0lPTgkiMi4yMC4yLjciCiAjZGVmaW5lIExT
SV9DT01NT05fTU9EX0VYVF9WRVJTSU9OCVwKLQkJIihSZWxlYXNlIERhdGU6IE1vbiBNYXIgNyAw
MDowMTowMyBFU1QgMjAwNSkiCisJCSIoUmVsZWFzZSBEYXRlOiBTdW4gSnVsIDE2IDAwOjAxOjAz
IEVTVCAyMDA2KSIKIAogCiAjZGVmaW5lIExTSV9EQkdMVkwJCQlkYmdsZXZlbAo=

------_=_NextPart_001_01C6AFF8.EB934905--
