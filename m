Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129216AbRBRULU>; Sun, 18 Feb 2001 15:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129273AbRBRULK>; Sun, 18 Feb 2001 15:11:10 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:26277 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S129216AbRBRULI>; Sun, 18 Feb 2001 15:11:08 -0500
Date: Sun, 18 Feb 2001 20:17:27 +0000 (GMT)
From: Mark Hemment <markhe@veritas.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd + scalability
Message-ID: <Pine.LNX.4.21.0102182007310.11260-200000@alloc>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="168455872-403620456-982527447=:11260"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--168455872-403620456-982527447=:11260
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi Neil, all,

  The nfs daemons run holding the global kernel lock.  They still hold
this lock over calls to file_op's read and write.

  The file system kernel interface (FSKI) doesn't require the kernel lock
to be held over these read/write calls.  The nfs daemons do not require 
that the reads or writes do not block (would be v silly if they did), so
they have no guarantee the lock isn't dropped and retaken during
blocking.  ie. they aren't using it as a guard across the calls.

  Dropping the kernel lock around read and write in fs/nfsd/vfs.c is a
_big_ SMP scalability win!

  Attached patch is against 2.4.1-ac18, but should apply to most recent
kernel versions.

Mark

--168455872-403620456-982527447=:11260
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="nfsd.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0102182017270.11260@alloc>
Content-Description: nfsd.patch
Content-Disposition: attachment; filename="nfsd.patch"

LS0tIHZhbmlsbGEtMi40LjEtYWMxOC9mcy9uZnNkL3Zmcy5jCVN1biBGZWIg
MTggMTU6MDY6MjcgMjAwMQ0KKysrIG1hcmtoZS0yLjQuMS1hYzE4L2ZzL25m
c2QvdmZzLmMJU3VuIEZlYiAxOCAxOTozMjoxOCAyMDAxDQpAQCAtMzAsNiAr
MzAsNyBAQA0KICNpbmNsdWRlIDxsaW51eC9uZXQuaD4NCiAjaW5jbHVkZSA8
bGludXgvdW5pc3RkLmg+DQogI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCisj
aW5jbHVkZSA8bGludXgvc21wX2xvY2suaD4NCiAjaW5jbHVkZSA8bGludXgv
aW4uaD4NCiAjZGVmaW5lIF9fTk9fVkVSU0lPTl9fDQogI2luY2x1ZGUgPGxp
bnV4L21vZHVsZS5oPg0KQEAgLTYwMiwxMiArNjAzLDI4IEBADQogCQlmaWxl
LmZfcmFsZW4gPSByYS0+cF9yYWxlbjsNCiAJCWZpbGUuZl9yYXdpbiA9IHJh
LT5wX3Jhd2luOw0KIAl9DQorDQorCS8qDQorCSAqIFRoZSBuZnMgZGFlbW9u
cyBydW4gaG9sZGluZyB0aGUgZ2xvYmFsIGtlcm5lbCBsb2NrLCBidXQNCisJ
ICogZl9vcC0+cmVhZCgpIGRvZXNuJ3QgbmVlZCB0aGUgbG9jayB0byBiZSBo
ZWxkLg0KKwkgKiBEcm9wIGl0IGhlcmUgdG8gaGVscCBzY2FsYWJpbGl0eS4N
CisJICoNCisJICogVGhlICJrZXJuZWxfbG9ja2VkKCkiIHRlc3QgaXNuJ3Qg
cGVyZmVjdCAoc29tZW9uZSBlbHNlIGNvdWxkIGJlDQorCSAqIGhvbGRpbmcg
dGhlIGxvY2sgd2hlbiB3ZSdyZSBub3QpLCBidXQgaXQgd2lsbCBldmVudHVh
bGx5IGNhdGNoDQorCSAqIGFueSBjYXNlcyBvZiBlbnRlcmluZyBoZXJlIHdp
dGhvdXQgdGhlIGxvY2sgaGVsZC4NCisJICovDQorCWlmICgha2VybmVsX2xv
Y2tlZCgpKQ0KKwkJQlVHKCk7DQorCXVubG9ja19rZXJuZWwoKTsNCisNCiAJ
ZmlsZS5mX3BvcyA9IG9mZnNldDsNCiANCiAJb2xkZnMgPSBnZXRfZnMoKTsg
c2V0X2ZzKEtFUk5FTF9EUyk7DQogCWVyciA9IGZpbGUuZl9vcC0+cmVhZCgm
ZmlsZSwgYnVmLCAqY291bnQsICZmaWxlLmZfcG9zKTsNCiAJc2V0X2ZzKG9s
ZGZzKTsNCiANCisJbG9ja19rZXJuZWwoKTsNCisNCiAJLyogV3JpdGUgYmFj
ayByZWFkYWhlYWQgcGFyYW1zICovDQogCWlmIChyYSAhPSBOVUxMKSB7DQog
CQlkcHJpbnRrKCJuZnNkOiByYXBhcm1zICVsZCAlbGQgJWxkICVsZCAlbGRc
biIsDQpAQCAtNjY0LDYgKzY4MSwyMiBAQA0KIAkJZ290byBvdXRfY2xvc2U7
DQogI2VuZGlmDQogDQorCS8qDQorCSAqIFRoZSBuZnMgZGFlbW9ucyBydW4g
aG9sZGluZyB0aGUgZ2xvYmFsIGtlcm5lbCBsb2NrLCBidXQNCisJICogZl9v
cC0+d3JpdGUoKSBkb2Vzbid0IG5lZWQgdGhlIGxvY2sgdG8gYmUgaGVsZC4N
CisJICogQWxzbywgYXMgdGhlIHN0cnVjdCBmaWxlIGlzIHByaXZhdGUsIHRo
ZSBleHBvcnQgaXMgcmVhZC1sb2NrZWQsDQorCSAqIGFuZCB0aGUgaW5vZGUg
YXR0YWNoZWQgdG8gdGhlIGRlbnRyeSBjYW5ub3QgY2hhbmdlIHVuZGVyIHVz
LCB0aGUNCisJICogbG9jayBjYW4gYmUgZHJvcHBlZCBhaGVhZCBvZiB0aGUg
Y2FsbCB0byB3cml0ZSgpIGZvciBldmVuIGJldHRlcg0KKwkgKiBzY2FsYWJp
bGl0eS4NCisJICoNCisJICogVGhlICJrZXJuZWxfbG9ja2VkKCkiIHRlc3Qg
aXNuJ3QgcGVyZmVjdCAoc29tZW9uZSBlbHNlIGNvdWxkIGJlDQorCSAqIGhv
bGRpbmcgdGhlIGxvY2sgd2hlbiB3ZSdyZSBub3QpLCBidXQgaXQgd2lsbCBl
dmVudHVhbGx5IGNhdGNoDQorCSAqIGFueSBjYXNlcyBvZiBlbnRlcmluZyBo
ZXJlIHdpdGhvdXQgdGhlIGxvY2sgaGVsZC4NCisJICovDQorCWlmICgha2Vy
bmVsX2xvY2tlZCgpKQ0KKwkJQlVHKCk7DQorCXVubG9ja19rZXJuZWwoKTsN
CisNCiAJZGVudHJ5ID0gZmlsZS5mX2RlbnRyeTsNCiAJaW5vZGUgPSBkZW50
cnktPmRfaW5vZGU7DQogCWV4cCAgID0gZmhwLT5maF9leHBvcnQ7DQpAQCAt
NjkyLDkgKzcyNSwxMiBAQA0KIAkvKiBXcml0ZSB0aGUgZGF0YS4gKi8NCiAJ
b2xkZnMgPSBnZXRfZnMoKTsgc2V0X2ZzKEtFUk5FTF9EUyk7DQogCWVyciA9
IGZpbGUuZl9vcC0+d3JpdGUoJmZpbGUsIGJ1ZiwgY250LCAmZmlsZS5mX3Bv
cyk7DQorCXNldF9mcyhvbGRmcyk7DQorDQorCWxvY2tfa2VybmVsKCk7DQor
DQogCWlmIChlcnIgPj0gMCkNCiAJCW5mc2RzdGF0cy5pb193cml0ZSArPSBj
bnQ7DQotCXNldF9mcyhvbGRmcyk7DQogDQogCS8qIGNsZWFyIHNldHVpZC9z
ZXRnaWQgZmxhZyBhZnRlciB3cml0ZSAqLw0KIAlpZiAoZXJyID49IDAgJiYg
KGlub2RlLT5pX21vZGUgJiAoU19JU1VJRCB8IFNfSVNHSUQpKSkgew0K
--168455872-403620456-982527447=:11260--
