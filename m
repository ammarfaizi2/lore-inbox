Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264351AbUANWcq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 17:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbUANWcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 17:32:45 -0500
Received: from fmr05.intel.com ([134.134.136.6]:53479 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263571AbUANWba
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 17:31:30 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C3DAEE.218B7118"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Limit hash table size
Date: Wed, 14 Jan 2004 14:31:19 -0800
Message-ID: <B05667366EE6204181EABE9C1B1C0EB580245C@scsmsx401.sc.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Limit hash table size
Thread-Index: AcPZEZIkqALiCxuuTBWhgMb+yXDLRAB2N5JQ
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Anton Blanchard" <anton@samba.org>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 14 Jan 2004 22:31:20.0280 (UTC) FILETIME=[21EDA580:01C3DAEE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C3DAEE.218B7118
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Anton Blanchard wrote:
> Well x86 isnt very interesting here, its all the 64bit archs
> that will end up with TBs of memory in the future.

To address Anton's concerns on PPC64, we have revised the patch to
enforce maximum size base on number of entry instead of page order.  So
differences in page size/pointer size etc doesn't affect the final
calculation.  The upper bound is capped at 2M.  All numbers on x86
remain the same as we don't want to disturb already established and
working number.  See patch at the end of the email.  It is diff'ed
relative to 2.6.1-mm3 tree.

> But look at the horrid worst case there. My point is limiting
> the hash without any data is not a good idea. In 2.4 we raised
> MAX_ORDER on ppc64 because we spent so much time walking
> pagecache chains,

I just have to re-iterate that when hash table is made too large, we
start trading cache misses on the head array accesses for misses on the
hash list traversal. Big hashes can hurt you if you don't actually use
the capacity.

> Why cant we do something like Andrews recent min_free_kbytes
> patch and make the rate of change non linear. Just slow the
> increase down as we get bigger. I agree a 2GB hashtable is
> pretty ludicrous, but a 4MB one on a 512GB machine (which
> we sell at the moment) could be too :)

It doesn't need to be over designed.  Generally there is no one size fit
all type of solution either.  Linear scale works fine for many years and
it just start to tip off on large machine.  We just need to put a upper
bound before it runs away.

- Ken

------_=_NextPart_001_01C3DAEE.218B7118
Content-Type: application/octet-stream;
	name="hash2.patch"
Content-Transfer-Encoding: base64
Content-Description: hash2.patch
Content-Disposition: attachment;
	filename="hash2.patch"

ZGlmZiAtTnVyIGxpbnV4LTIuNi4xLW1tMy5vcmlnL2ZzL2RjYWNoZS5jIGxpbnV4LTIuNi4xLW1t
My9mcy9kY2FjaGUuYwotLS0gbGludXgtMi42LjEtbW0zLm9yaWcvZnMvZGNhY2hlLmMJMjAwNC0w
MS0xNCAxMzo0ODowOS4wMDAwMDAwMDAgLTA4MDAKKysrIGxpbnV4LTIuNi4xLW1tMy9mcy9kY2Fj
aGUuYwkyMDA0LTAxLTE0IDE0OjAyOjAyLjAwMDAwMDAwMCAtMDgwMApAQCAtNDksNiArNDksNyBA
QAogICovCiAjZGVmaW5lIERfSEFTSEJJVFMgICAgIGRfaGFzaF9zaGlmdAogI2RlZmluZSBEX0hB
U0hNQVNLICAgICBkX2hhc2hfbWFzaworI2RlZmluZSBEX0hBU0hNQVgJKDIqMTAyNCoxMDI0VUwp
CS8qIG1heCBudW1iZXIgb2YgZW50cmllcyAqLwogCiBzdGF0aWMgdW5zaWduZWQgaW50IGRfaGFz
aF9tYXNrOwogc3RhdGljIHVuc2lnbmVkIGludCBkX2hhc2hfc2hpZnQ7CkBAIC0xNTUyLDkgKzE1
NTMsOSBAQAogCQogCXNldF9zaHJpbmtlcihERUZBVUxUX1NFRUtTLCBzaHJpbmtfZGNhY2hlX21l
bW9yeSk7CiAKLQltZW1wYWdlcyA+Pj0gMTsKLQltZW1wYWdlcyAqPSBzaXplb2Yoc3RydWN0IGhs
aXN0X2hlYWQpOwotCWZvciAob3JkZXIgPSAwOyAob3JkZXIgPCAxMCkgJiYgKCgoMVVMIDw8IG9y
ZGVyKSA8PCBQQUdFX1NISUZUKSA8IG1lbXBhZ2VzKTsgb3JkZXIrKykKKwltZW1wYWdlcyA9ICht
ZW1wYWdlcyA8PCBQQUdFX1NISUZUKSA+PiAxMzsKKwltZW1wYWdlcyA9IG1pbihEX0hBU0hNQVgs
IG1lbXBhZ2VzKSAqIHNpemVvZihzdHJ1Y3QgaGxpc3RfaGVhZCk7CisJZm9yIChvcmRlciA9IDA7
ICgoMVVMIDw8IG9yZGVyKSA8PCBQQUdFX1NISUZUKSA8IG1lbXBhZ2VzOyBvcmRlcisrKQogCQk7
CiAKIAlkbyB7CmRpZmYgLU51ciBsaW51eC0yLjYuMS1tbTMub3JpZy9mcy9pbm9kZS5jIGxpbnV4
LTIuNi4xLW1tMy9mcy9pbm9kZS5jCi0tLSBsaW51eC0yLjYuMS1tbTMub3JpZy9mcy9pbm9kZS5j
CTIwMDQtMDEtMTQgMTM6NDg6MDkuMDAwMDAwMDAwIC0wODAwCisrKyBsaW51eC0yLjYuMS1tbTMv
ZnMvaW5vZGUuYwkyMDA0LTAxLTE0IDE0OjAxOjM0LjAwMDAwMDAwMCAtMDgwMApAQCAtNTMsNiAr
NTMsNyBAQAogICovCiAjZGVmaW5lIElfSEFTSEJJVFMJaV9oYXNoX3NoaWZ0CiAjZGVmaW5lIElf
SEFTSE1BU0sJaV9oYXNoX21hc2sKKyNkZWZpbmUgSV9IQVNITUFYCSgyKjEwMjQqMTAyNFVMKQkv
KiBtYXggbnVtYmVyIG9mIGVudHJpZXMgKi8KIAogc3RhdGljIHVuc2lnbmVkIGludCBpX2hhc2hf
bWFzazsKIHN0YXRpYyB1bnNpZ25lZCBpbnQgaV9oYXNoX3NoaWZ0OwpAQCAtMTMyOCw5ICsxMzI5
LDkgQEAKIAlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShpX3dhaXRfcXVldWVfaGVhZHMpOyBp
KyspCiAJCWluaXRfd2FpdHF1ZXVlX2hlYWQoJmlfd2FpdF9xdWV1ZV9oZWFkc1tpXS53cWgpOwog
Ci0JbWVtcGFnZXMgPj49IDI7Ci0JbWVtcGFnZXMgKj0gc2l6ZW9mKHN0cnVjdCBobGlzdF9oZWFk
KTsKLQlmb3IgKG9yZGVyID0gMDsgKG9yZGVyIDwgMTApICYmICgoKDFVTCA8PCBvcmRlcikgPDwg
UEFHRV9TSElGVCkgPCBtZW1wYWdlcyk7IG9yZGVyKyspCisJbWVtcGFnZXMgPSAobWVtcGFnZXMg
PDwgUEFHRV9TSElGVCkgPj4gMTQ7CisJbWVtcGFnZXMgPSBtaW4oSV9IQVNITUFYLCBtZW1wYWdl
cykgKiBzaXplb2Yoc3RydWN0IGhsaXN0X2hlYWQpOworCWZvciAob3JkZXIgPSAwOyAoKDFVTCA8
PCBvcmRlcikgPDwgUEFHRV9TSElGVCkgPCBtZW1wYWdlczsgb3JkZXIrKykKIAkJOwogCiAJZG8g
ewo=

------_=_NextPart_001_01C3DAEE.218B7118--
