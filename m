Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266373AbUAHXMf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 18:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266372AbUAHXMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 18:12:35 -0500
Received: from fmr06.intel.com ([134.134.136.7]:65473 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S266367AbUAHXM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 18:12:29 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C3D63C.DB60EBA0"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: Limit hash table size
Date: Thu, 8 Jan 2004 15:12:16 -0800
Message-ID: <B05667366EE6204181EABE9C1B1C0EB5802441@scsmsx401.sc.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Limit hash table size
Thread-Index: AcPWPNtk4AFFN0JXTq2N5zcYk4+V3A==
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
Cc: "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 08 Jan 2004 23:12:17.0061 (UTC) FILETIME=[DBCE2D50:01C3D63C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C3D63C.DB60EBA0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The issue of exceedingly large hash tables has been discussed on the
mailing list a while back, but seems to slip through the cracks.

What we found is it's not a problem for x86 (and most other
architectures) because __get_free_pages won't be able to get anything
beyond order MAX_ORDER-1 (10) which means at most those hash tables are
4MB each (assume 4K page size).  However, on ia64, in order to support
larger hugeTLB page size, the MAX_ORDER is bumped up to 18, which now
means a 2GB upper limits enforced by the page allocator (assume 16K page
size).  PPC64 is another example that bumps up MAX_ORDER.

Last time I checked, the tcp ehash table is taking a whooping (insane!)
2GB on one of our large machine.  dentry and inode hash tables also take
considerable amount of memory.

This patch just enforces all the hash tables to have a max order of 10,
which limits them down to 16MB each on ia64.  People can clean up other
part of table size calculation.  But minimally, this patch doesn't
change any hash sizes already in use on x86.

Andrew, would you please apply?

- Ken Chen
 <<hashtable.patch>>=20

------_=_NextPart_001_01C3D63C.DB60EBA0
Content-Type: application/octet-stream;
	name="hashtable.patch"
Content-Transfer-Encoding: base64
Content-Description: hashtable.patch
Content-Disposition: attachment;
	filename="hashtable.patch"

ZGlmZiAtTnVycCBsaW51eC0yLjYuMC5vcmlnL2ZzL2RjYWNoZS5jIGxpbnV4LTIuNi4wL2ZzL2Rj
YWNoZS5jCi0tLSBsaW51eC0yLjYuMC5vcmlnL2ZzL2RjYWNoZS5jCTIwMDMtMTItMTcgMTg6NTg6
MTUuMDAwMDAwMDAwIC0wODAwCisrKyBsaW51eC0yLjYuMC9mcy9kY2FjaGUuYwkyMDA0LTAxLTA4
IDE0OjU5OjU4LjAwMDAwMDAwMCAtMDgwMApAQCAtMTU3MSwxMSArMTU3MSw5IEBAIHN0YXRpYyB2
b2lkIF9faW5pdCBkY2FjaGVfaW5pdCh1bnNpZ25lZCAKIAkKIAlzZXRfc2hyaW5rZXIoREVGQVVM
VF9TRUVLUywgc2hyaW5rX2RjYWNoZV9tZW1vcnkpOwogCi0jaWYgUEFHRV9TSElGVCA8IDEzCi0J
bWVtcGFnZXMgPj49ICgxMyAtIFBBR0VfU0hJRlQpOwotI2VuZGlmCisJbWVtcGFnZXMgPj49IDE7
CiAJbWVtcGFnZXMgKj0gc2l6ZW9mKHN0cnVjdCBobGlzdF9oZWFkKTsKLQlmb3IgKG9yZGVyID0g
MDsgKCgxVUwgPDwgb3JkZXIpIDw8IFBBR0VfU0hJRlQpIDwgbWVtcGFnZXM7IG9yZGVyKyspCisJ
Zm9yIChvcmRlciA9IDA7IChvcmRlciA8IDEwKSAmJiAoKCgxVUwgPDwgb3JkZXIpIDw8IFBBR0Vf
U0hJRlQpIDwgbWVtcGFnZXMpOyBvcmRlcisrKQogCQk7CiAKIAlkbyB7CmRpZmYgLU51cnAgbGlu
dXgtMi42LjAub3JpZy9mcy9pbm9kZS5jIGxpbnV4LTIuNi4wL2ZzL2lub2RlLmMKLS0tIGxpbnV4
LTIuNi4wLm9yaWcvZnMvaW5vZGUuYwkyMDAzLTEyLTE3IDE4OjU5OjU1LjAwMDAwMDAwMCAtMDgw
MAorKysgbGludXgtMi42LjAvZnMvaW5vZGUuYwkyMDA0LTAxLTA4IDE1OjAwOjE5LjAwMDAwMDAw
MCAtMDgwMApAQCAtMTM0MCw5ICsxMzQwLDkgQEAgdm9pZCBfX2luaXQgaW5vZGVfaW5pdCh1bnNp
Z25lZCBsb25nIG1lbQogCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKGlfd2FpdF9xdWV1ZV9o
ZWFkcyk7IGkrKykKIAkJaW5pdF93YWl0cXVldWVfaGVhZCgmaV93YWl0X3F1ZXVlX2hlYWRzW2ld
LndxaCk7CiAKLQltZW1wYWdlcyA+Pj0gKDE0IC0gUEFHRV9TSElGVCk7CisJbWVtcGFnZXMgPj49
IDI7CiAJbWVtcGFnZXMgKj0gc2l6ZW9mKHN0cnVjdCBobGlzdF9oZWFkKTsKLQlmb3IgKG9yZGVy
ID0gMDsgKCgxVUwgPDwgb3JkZXIpIDw8IFBBR0VfU0hJRlQpIDwgbWVtcGFnZXM7IG9yZGVyKysp
CisJZm9yIChvcmRlciA9IDA7IChvcmRlciA8IDEwKSAmJiAoKCgxVUwgPDwgb3JkZXIpIDw8IFBB
R0VfU0hJRlQpIDwgbWVtcGFnZXMpOyBvcmRlcisrKQogCQk7CiAKIAlkbyB7CmRpZmYgLU51cnAg
bGludXgtMi42LjAub3JpZy9uZXQvaXB2NC9yb3V0ZS5jIGxpbnV4LTIuNi4wL25ldC9pcHY0L3Jv
dXRlLmMKLS0tIGxpbnV4LTIuNi4wLm9yaWcvbmV0L2lwdjQvcm91dGUuYwkyMDAzLTEyLTE3IDE4
OjU5OjU1LjAwMDAwMDAwMCAtMDgwMAorKysgbGludXgtMi42LjAvbmV0L2lwdjQvcm91dGUuYwky
MDA0LTAxLTA4IDE1OjAxOjE3LjAwMDAwMDAwMCAtMDgwMApAQCAtMjc0Nyw3ICsyNzQ3LDcgQEAg
aW50IF9faW5pdCBpcF9ydF9pbml0KHZvaWQpCiAKIAlnb2FsID0gbnVtX3BoeXNwYWdlcyA+PiAo
MjYgLSBQQUdFX1NISUZUKTsKIAotCWZvciAob3JkZXIgPSAwOyAoMVVMIDw8IG9yZGVyKSA8IGdv
YWw7IG9yZGVyKyspCisJZm9yIChvcmRlciA9IDA7IChvcmRlciA8IDEwKSAmJiAoKDFVTCA8PCBv
cmRlcikgPCBnb2FsKTsgb3JkZXIrKykKIAkJLyogTk9USElORyAqLzsKIAogCWRvIHsKZGlmZiAt
TnVycCBsaW51eC0yLjYuMC5vcmlnL25ldC9pcHY0L3RjcC5jIGxpbnV4LTIuNi4wL25ldC9pcHY0
L3RjcC5jCi0tLSBsaW51eC0yLjYuMC5vcmlnL25ldC9pcHY0L3RjcC5jCTIwMDMtMTItMTcgMTg6
NTg6MzguMDAwMDAwMDAwIC0wODAwCisrKyBsaW51eC0yLjYuMC9uZXQvaXB2NC90Y3AuYwkyMDA0
LTAxLTA4IDE1OjAwOjQyLjAwMDAwMDAwMCAtMDgwMApAQCAtMjYxMCw3ICsyNjEwLDcgQEAgdm9p
ZCBfX2luaXQgdGNwX2luaXQodm9pZCkKIAllbHNlCiAJCWdvYWwgPSBudW1fcGh5c3BhZ2VzID4+
ICgyMyAtIFBBR0VfU0hJRlQpOwogCi0JZm9yIChvcmRlciA9IDA7ICgxVUwgPDwgb3JkZXIpIDwg
Z29hbDsgb3JkZXIrKykKKwlmb3IgKG9yZGVyID0gMDsgKG9yZGVyIDwgMTApICYmICgoMVVMIDw8
IG9yZGVyKSA8IGdvYWwpOyBvcmRlcisrKQogCQk7CiAJZG8gewogCQl0Y3BfZWhhc2hfc2l6ZSA9
ICgxVUwgPDwgb3JkZXIpICogUEFHRV9TSVpFIC8K

------_=_NextPart_001_01C3D63C.DB60EBA0--
