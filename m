Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265402AbTGHVhz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 17:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267702AbTGHVhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 17:37:55 -0400
Received: from fmr04.intel.com ([143.183.121.6]:49655 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S265402AbTGHVhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 17:37:53 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C3459B.39CB0F94"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: Race condition between aio_complete and aio_read_evt
Date: Tue, 8 Jul 2003 14:52:28 -0700
Message-ID: <41F331DBE1178346A6F30D7CF124B24B2A4886@fmsmsx409.fm.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Race condition between aio_complete and aio_read_evt
Thread-Index: AcNFmzmuP/bt5R+bTZiz+5smU0flWQ==
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: <linux-aio@kvack.org>
X-OriginalArrivalTime: 08 Jul 2003 21:52:29.0347 (UTC) FILETIME=[3A18FF30:01C3459B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C3459B.39CB0F94
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

We hit a memory ordering race condition on AIO ring buffer tail pointer
between function aio_complete() and aio_read_evt().

What happens is that on an architecture that has a relaxed memory
ordering model like IPF(ia64), explicit memory barrier is required in a
SMP execution environment.  Considering the following case:

1 CPU is executing a tight loop of aio_read_evt.  It is pulling event
off the ring buffer.  During that loop, another CPU is executing
aio_complete() where it is putting event into the ring buffer and then
update the tail pointer.  However, due to relaxed memory ordering model,
the tail pointer can be visible before the actual event is being
updated.  So the other CPU sees the updated tail pointer but picks up a
staled event data.

A memory barrier is required in this case between the event data and
tail pointer update.  Same is true for the head pointer but the window
of the race condition is nil.  For function correctness, it is fixed
here as well.

By the way, this bug is fixed in the major distributor's kernel on 2.4.x
kernel series for a while, but somehow hasn't been propagated to 2.5
kernel yet.

The patch is relative to 2.5.74.

- Ken

------_=_NextPart_001_01C3459B.39CB0F94
Content-Type: application/octet-stream;
	name="aio.memorder.patch"
Content-Transfer-Encoding: base64
Content-Description: aio.memorder.patch
Content-Disposition: attachment;
	filename="aio.memorder.patch"

ZGlmZiAtTnVyIGxpbnV4LTIuNS43NC9mcy9haW8uYyBsaW51eC0yLjUuNzQuYWlvL2ZzL2Fpby5j
DQotLS0gbGludXgtMi41Ljc0L2ZzL2Fpby5jCVN1biBKdW4gMjIgMTE6MzI6NDMgMjAwMw0KKysr
IGxpbnV4LTIuNS43NC5haW8vZnMvYWlvLmMJVHVlIEp1bCAgOCAxNDo0OToyNyAyMDAzDQpAQCAt
Njc5LDEyICs2NzksMTEgQEANCiAJLyogYWZ0ZXIgZmxhZ2dpbmcgdGhlIHJlcXVlc3QgYXMgZG9u
ZSwgd2UNCiAJICogbXVzdCBuZXZlciBldmVuIGxvb2sgYXQgaXQgYWdhaW4NCiAJICovDQotCWJh
cnJpZXIoKTsNCisJd21iKCk7CS8qIG1ha2UgZXZlbnQgdmlzaWJsZSBiZWZvcmUgdXBkYXRpbmcg
dGFpbCAqLw0KIA0KIAlpbmZvLT50YWlsID0gdGFpbDsNCiAJcmluZy0+dGFpbCA9IHRhaWw7DQog
DQotCXdtYigpOw0KIAlwdXRfYWlvX3JpbmdfZXZlbnQoZXZlbnQsIEtNX0lSUTApOw0KIAlrdW5t
YXBfYXRvbWljKHJpbmcsIEtNX0lSUTEpOw0KIA0KQEAgLTcyMSw3ICs3MjAsNyBAQA0KIAlkcHJp
bnRrKCJpbiBhaW9fcmVhZF9ldnQgaCVsdSB0JWx1IG0lbHVcbiIsDQogCQkgKHVuc2lnbmVkIGxv
bmcpcmluZy0+aGVhZCwgKHVuc2lnbmVkIGxvbmcpcmluZy0+dGFpbCwNCiAJCSAodW5zaWduZWQg
bG9uZylyaW5nLT5ucik7DQotCWJhcnJpZXIoKTsNCisNCiAJaWYgKHJpbmctPmhlYWQgPT0gcmlu
Zy0+dGFpbCkNCiAJCWdvdG8gb3V0Ow0KIA0KQEAgLTczMiw3ICs3MzEsNyBAQA0KIAkJc3RydWN0
IGlvX2V2ZW50ICpldnAgPSBhaW9fcmluZ19ldmVudChpbmZvLCBoZWFkLCBLTV9VU0VSMSk7DQog
CQkqZW50ID0gKmV2cDsNCiAJCWhlYWQgPSAoaGVhZCArIDEpICUgaW5mby0+bnI7DQotCQliYXJy
aWVyKCk7DQorCQltYigpOwkvKiBmaW5pc2ggcmVhZGluZyB0aGUgZXZlbnQgYmVmb3JlIHVwZGF0
bmcgdGhlIGhlYWQgKi8NCiAJCXJpbmctPmhlYWQgPSBoZWFkOw0KIAkJcmV0ID0gMTsNCiAJCXB1
dF9haW9fcmluZ19ldmVudChldnAsIEtNX1VTRVIxKTsNCg==

------_=_NextPart_001_01C3459B.39CB0F94--
