Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130745AbRCEXBh>; Mon, 5 Mar 2001 18:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130748AbRCEXB2>; Mon, 5 Mar 2001 18:01:28 -0500
Received: from fungus.teststation.com ([212.32.186.211]:40651 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S130743AbRCEXBP>; Mon, 5 Mar 2001 18:01:15 -0500
Date: Tue, 6 Mar 2001 00:01:13 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: <linux-kernel@vger.kernel.org>
cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: d_add on negative dentry?
Message-ID: <Pine.LNX.4.30.0103052322540.29931-200000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463780587-374043905-983833273=:29931"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463780587-374043905-983833273=:29931
Content-Type: TEXT/PLAIN; charset=US-ASCII


Is it valid to call d_add on a negative dentry?
(or on a dentry that is already linked in d_hash, but all negative
 dentries are, right?)

I'm guessing it isn't because I think that is how I can get my machine to
hang in d_lookup, looping on a corrupt d_hash list.


The problem can be reproduced like this. /mnt/smb is a smbfs mount of
/mnt/samba/export from a samba server on localhost.

/mnt/smb% ls
aa
/mnt/smb% rm aa
/mnt/smb% touch /mnt/samba/export/aa
/mnt/smb% ls
ls: aa: No such file or directory

And shortly after it will lock up completely.


My printk's tell me that a negative dentry is still hashed since d_hash is
non-empty. d_add calls d_instantiate and d_rehash, the later adds it to a
d_hash list without first removing it. But it was already linked so now 2
extra dentries are also pointing to this dentry. And it is then no longer
a list ...

The attached patch fixes things for me. Comments?

Oh, and I *think* ncpfs has the same problem. But that's just from reading
the code.

/Urban

---1463780587-374043905-983833273=:29931
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="smbfs-2.4.2-ac11-cache.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0103060001130.29931@cola.teststation.com>
Content-Description: 
Content-Disposition: attachment; filename="smbfs-2.4.2-ac11-cache.patch"

ZGlmZiAtdXJOIC1YIGV4Y2x1ZGUgbGludXgtMi40LjItYWMxMS1vcmlnL2Zz
L3NtYmZzL2NhY2hlLmMgbGludXgtMi40LjItYWMxMS1zbWJmcy9mcy9zbWJm
cy9jYWNoZS5jDQotLS0gbGludXgtMi40LjItYWMxMS1vcmlnL2ZzL3NtYmZz
L2NhY2hlLmMJVGh1IEZlYiAyMiAyMDo1MjowMyAyMDAxDQorKysgbGludXgt
Mi40LjItYWMxMS1zbWJmcy9mcy9zbWJmcy9jYWNoZS5jCU1vbiBNYXIgIDUg
MjM6NDg6MTIgMjAwMQ0KQEAgLTE2Nyw2ICsxNjcsNyBAQA0KIAlzdHJ1Y3Qg
aW5vZGUgKm5ld2lubywgKmlub2RlID0gZGVudHJ5LT5kX2lub2RlOw0KIAlz
dHJ1Y3Qgc21iX2NhY2hlX2NvbnRyb2wgY3RsID0gKmN0cmw7DQogCWludCB2
YWxpZCA9IDA7DQorCWludCBoYXNoZWQgPSAwOw0KIAlpbm9fdCBpbm8gPSAw
Ow0KIA0KIAlxbmFtZS0+aGFzaCA9IGZ1bGxfbmFtZV9oYXNoKHFuYW1lLT5u
YW1lLCBxbmFtZS0+bGVuKTsNCkBAIC0xODEsOSArMTgyLDExIEBADQogCQlu
ZXdkZW50ID0gZF9hbGxvYyhkZW50cnksIHFuYW1lKTsNCiAJCWlmICghbmV3
ZGVudCkNCiAJCQlnb3RvIGVuZF9hZHZhbmNlOw0KLQl9IGVsc2UNCisJfSBl
bHNlIHsNCisJCWhhc2hlZCA9IDE7DQogCQltZW1jcHkoKGNoYXIgKikgbmV3
ZGVudC0+ZF9uYW1lLm5hbWUsIHFuYW1lLT5uYW1lLA0KIAkJICAgICAgIG5l
d2RlbnQtPmRfbmFtZS5sZW4pOw0KKwl9DQogDQogCWlmICghbmV3ZGVudC0+
ZF9pbm9kZSkgew0KIAkJc21iX3JlbmV3X3RpbWVzKG5ld2RlbnQpOw0KQEAg
LTE5MSw3ICsxOTQsMTAgQEANCiAJCW5ld2lubyA9IHNtYl9pZ2V0KGlub2Rl
LT5pX3NiLCBlbnRyeSk7DQogCQlpZiAobmV3aW5vKSB7DQogCQkJc21iX25l
d19kZW50cnkobmV3ZGVudCk7DQotCQkJZF9hZGQobmV3ZGVudCwgbmV3aW5v
KTsNCisJCQlpZiAoaGFzaGVkKQ0KKwkJCQlkX2luc3RhbnRpYXRlKG5ld2Rl
bnQsIG5ld2lubyk7DQorCQkJZWxzZQ0KKwkJCQlkX2FkZChuZXdkZW50LCBu
ZXdpbm8pOw0KIAkJfQ0KIAl9IGVsc2UNCiAJCXNtYl9zZXRfaW5vZGVfYXR0
cihuZXdkZW50LT5kX2lub2RlLCBlbnRyeSk7DQo=
---1463780587-374043905-983833273=:29931--
