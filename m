Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263918AbRGIR3S>; Mon, 9 Jul 2001 13:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263927AbRGIR3I>; Mon, 9 Jul 2001 13:29:08 -0400
Received: from ECE.CMU.EDU ([128.2.236.200]:10420 "EHLO ece.cmu.edu")
	by vger.kernel.org with ESMTP id <S263918AbRGIR2z>;
	Mon, 9 Jul 2001 13:28:55 -0400
Date: Mon, 9 Jul 2001 13:28:41 -0400 (EDT)
From: Craig Soules <soules@happyplace.pdl.cmu.edu>
To: trond.myklebust@fys.uio.no, jrs@world.std.com
cc: linux-kernel@vger.kernel.org
Subject: NFS Client patch
Message-ID: <Pine.LNX.3.96L.1010709131315.16113O-200000@happyplace.pdl.cmu.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="41973382-1272356615-994699721=:16113"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--41973382-1272356615-994699721=:16113
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello,

I hope that I am sending this to the appropriate people.  I have been
working on a project known as Self-Securing Storage here at Carnegie
Mellon University.  We have developed our storage server to act as an
NFSv2 server, and have been using the Linux NFSv2 client to do our
benchmarking. I have run across a small problem with the 2.4
implementation of the Linux NFSv2 client.

The problem is in the readdir() operation.  The current cookie for a given
readdir operation is being stored in the file descriptor.  The problem is
that it is not being reset to 0 if a change has been made to the
directory as is indicated in the NFSv2 spec.  This problem is often
seen when doing an operation such as rm -rf to a large directory tree due
to the asynchronous remove operation that has been implemented.

This has not traditionally been a problem for Linux because in ext2 the
cookie is the offset into the directory of the next entry.  If a file
is deleted in that directory during the readdir() operation, it has no
effect since ext2 does lazy directory compaction.

Our system does automatic directory compaction through the use of a tree
structure, and so the cookie needs to be invalidated.  Also, any other
file system whicih does immediate directory compaction would require this.

I have attached my proposed modifications to the end of this file.  They
have been tested under 2.4.5.

Please let me know if there is anything more I need to do, or if you have
any questions.  I would really like to get this proper behavior into the
kernel.

Thanks,
Craig Soules

--41973382-1272356615-994699721=:16113
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="patch.2.4.5"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.96L.1010709132841.16113P@happyplace.pdl.cmu.edu>
Content-Description: 

LS0tIGxpbnV4L2luY2x1ZGUvbGludXgvbmZzX2ZzLmgJRnJpIE1heSAyNSAy
MTowMjoxMSAyMDAxDQorKysgL3Vzci9zcmMvbGludXgvaW5jbHVkZS9saW51
eC9uZnNfZnMuaAlTdW4gSnVsICA4IDE0OjQwOjU3IDIwMDENCkBAIC0xNjAs
MTMgKzE2MCwxOCBAQA0KIHN0YXRpYyBfX2lubGluZV9fIHN0cnVjdCBycGNf
Y3JlZCAqDQogbmZzX2ZpbGVfY3JlZChzdHJ1Y3QgZmlsZSAqZmlsZSkNCiB7
DQotCXN0cnVjdCBycGNfY3JlZCAqY3JlZCA9IChzdHJ1Y3QgcnBjX2NyZWQg
KikoZmlsZS0+cHJpdmF0ZV9kYXRhKTsNCisJc3RydWN0IG5mc19maWxlX3By
aXZhdGUgKnByaXYgPQ0KKwkJKHN0cnVjdCBuZnNfZmlsZV9wcml2YXRlICop
KGZpbGUtPnByaXZhdGVfZGF0YSk7DQorCXN0cnVjdCBycGNfY3JlZCAqY3Jl
ZCA9IHByaXYtPmNyZWQ7DQogI2lmZGVmIFJQQ19ERUJVRw0KIAlpZiAoY3Jl
ZCAmJiBjcmVkLT5jcl9tYWdpYyAhPSBSUENBVVRIX0NSRURfTUFHSUMpDQog
CQlCVUcoKTsNCiAjZW5kaWYNCiAJcmV0dXJuIGNyZWQ7DQogfQ0KKw0KKyNk
ZWZpbmUgTkZTX0ZJTEVfTEFTVE1PRChmaWxlcCkgXA0KKwkoKHN0cnVjdCBu
ZnNfZmlsZV9wcml2YXRlICopKChmaWxlcCktPnByaXZhdGVfZGF0YSkpLT5s
YXN0bW9kDQogDQogLyoNCiAgKiBsaW51eC9mcy9uZnMvZGlyLmMNCi0tLSBs
aW51eC9pbmNsdWRlL2xpbnV4L25mc19mc19pLmgJTW9uIEZlYiAxOSAyMDox
MzowMCAyMDAxDQorKysgL3Vzci9zcmMvbGludXgvaW5jbHVkZS9saW51eC9u
ZnNfZnNfaS5oCVN1biBKdWwgIDggMTQ6MTg6MTYgMjAwMQ0KQEAgLTk4LDQg
Kzk4LDEyIEBADQogICovDQogI2RlZmluZSBORlNfTENLX0dSQU5URUQJCTB4
MDAwMQkJLyogbG9jayBoYXMgYmVlbiBncmFudGVkICovDQogDQorLyoNCisg
KiBORlMgcHJpdmF0ZSBkYXRhIGluIHRoZSBmaWxlIGRlc2NyaXB0b3INCisg
Ki8NCitzdHJ1Y3QgbmZzX2ZpbGVfcHJpdmF0ZSB7DQorCXN0cnVjdCBycGNf
Y3JlZCAqY3JlZDsNCisJdW5zaWduZWQgbG9uZyBsYXN0bW9kOw0KK307DQor
DQogI2VuZGlmDQotLS0gbGludXgvZnMvbmZzL2Rpci5jCVNhdCBNYXkgMTkg
MjE6MDI6NDUgMjAwMQ0KKysrIC91c3Ivc3JjL2xpbnV4L2ZzL25mcy9kaXIu
YwlTdW4gSnVsICA4IDE0OjM1OjU1IDIwMDENCkBAIC0zODQsNiArMzg0LDEx
IEBADQogCW1lbXNldCgmbXlfZW50cnksIDAsIHNpemVvZihteV9lbnRyeSkp
Ow0KIA0KIAlkZXNjLT5maWxlID0gZmlscDsNCisNCisJaWYoTkZTX0ZJTEVf
TEFTVE1PRChmaWxwKSA8IE5GU19BVFRSVElNRU9fVVBEQVRFKGlub2RlKSkg
ew0KKwkJZmlscC0+Zl9wb3MgPSAwOw0KKwkJTkZTX0ZJTEVfTEFTVE1PRChm
aWxwKSA9IE5GU19BVFRSVElNRU9fVVBEQVRFKGlub2RlKTsNCisJfQ0KIAlk
ZXNjLT50YXJnZXQgPSBmaWxwLT5mX3BvczsNCiAJZGVzYy0+ZW50cnkgPSAm
bXlfZW50cnk7DQogCWRlc2MtPmRlY29kZSA9IE5GU19QUk9UTyhpbm9kZSkt
PmRlY29kZV9kaXJlbnQ7DQotLS0gbGludXgvZnMvbmZzL2lub2RlLmMJU2F0
IE1heSAxOSAyMToxNDozOCAyMDAxDQorKysgL3Vzci9zcmMvbGludXgvZnMv
bmZzL2lub2RlLmMJU3VuIEp1bCAgOCAxNDozNjozMCAyMDAxDQpAQCAtNzk5
LDEzICs3OTksMTQgQEANCiAgKi8NCiBpbnQgbmZzX29wZW4oc3RydWN0IGlu
b2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbHApDQogew0KKwlzdHJ1Y3Qg
bmZzX2ZpbGVfcHJpdmF0ZSAqcHJpdjsNCiAJc3RydWN0IHJwY19hdXRoICph
dXRoOw0KLQlzdHJ1Y3QgcnBjX2NyZWQgKmNyZWQ7DQogDQogCWxvY2tfa2Vy
bmVsKCk7DQorCXByaXYgPSBrbWFsbG9jKHNpemVvZihzdHJ1Y3QgbmZzX2Zp
bGVfcHJpdmF0ZSksIEdGUF9LRVJORUwpOw0KIAlhdXRoID0gTkZTX0NMSUVO
VChpbm9kZSktPmNsX2F1dGg7DQotCWNyZWQgPSBycGNhdXRoX2xvb2t1cGNy
ZWQoYXV0aCwgMCk7DQotCWZpbHAtPnByaXZhdGVfZGF0YSA9IGNyZWQ7DQor
CXByaXYtPmNyZWQgPSBycGNhdXRoX2xvb2t1cGNyZWQoYXV0aCwgMCk7DQor
CWZpbHAtPnByaXZhdGVfZGF0YSA9IHByaXY7DQogCXVubG9ja19rZXJuZWwo
KTsNCiAJcmV0dXJuIDA7DQogfQ0KQEAgLTgxNCwxMiArODE1LDE3IEBADQog
ew0KIAlzdHJ1Y3QgcnBjX2F1dGggKmF1dGg7DQogCXN0cnVjdCBycGNfY3Jl
ZCAqY3JlZDsNCisJc3RydWN0IG5mc19maWxlX3ByaXZhdGUgKnByaXY7DQog
DQogCWxvY2tfa2VybmVsKCk7DQotCWF1dGggPSBORlNfQ0xJRU5UKGlub2Rl
KS0+Y2xfYXV0aDsNCi0JY3JlZCA9IG5mc19maWxlX2NyZWQoZmlscCk7DQot
CWlmIChjcmVkKQ0KLQkJcnBjYXV0aF9yZWxlYXNlY3JlZChhdXRoLCBjcmVk
KTsNCisJcHJpdiA9IGZpbHAtPnByaXZhdGVfZGF0YTsNCisJaWYocHJpdikg
ew0KKwkJYXV0aCA9IE5GU19DTElFTlQoaW5vZGUpLT5jbF9hdXRoOw0KKwkJ
Y3JlZCA9IG5mc19maWxlX2NyZWQoZmlscCk7DQorCQlpZiAoY3JlZCkNCisJ
CQlycGNhdXRoX3JlbGVhc2VjcmVkKGF1dGgsIGNyZWQpOw0KKwkJa2ZyZWUo
cHJpdik7DQorCX0NCiAJdW5sb2NrX2tlcm5lbCgpOw0KIAlyZXR1cm4gMDsN
CiB9DQo=
--41973382-1272356615-994699721=:16113--
