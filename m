Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129735AbRAPUzN>; Tue, 16 Jan 2001 15:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132477AbRAPUzD>; Tue, 16 Jan 2001 15:55:03 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:18849 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S129735AbRAPUys>; Tue, 16 Jan 2001 15:54:48 -0500
Date: Tue, 16 Jan 2001 20:14:20 +0000 (GMT)
From: Mark Hemment <markhe@veritas.com>
To: Paul Hubbard <phubbard@fnal.gov>
cc: linux-kernel@vger.kernel.org, "Richard E. Jetton" <rjetton@fnal.gov>
Subject: Re: 4G SGI quad Xeon - memory-related slowdowns
In-Reply-To: <3A6364AF.AC4D4081@fnal.gov>
Message-ID: <Pine.LNX.4.21.0101162001250.26195-200000@alloc>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-2023635380-979676059=:26195"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--0-2023635380-979676059=:26195
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi Paul,
 
> 2) Other block I/O output (eg dd if=/dev/zero of=/dev/sdi bs=4M) also
> run very slowly

What do you notice when running "top" and doing the above?
Does the "buff" value grow high (+700MB), with high CPU usage?

  If so, I think this might be down to nr_free_buffer_pages().

  This function includes the pages in all zones (including the HIGHMEM
zone) in its calculations, while only DMA and NORMAL zone pages are used
for buffers.  This upsets the result from 
balance_dirty_state() (fs/buffer.c), and as a result the required flushing
of buffers is only done as a result of running v low of pages in the DMA
and NORMAL zones.

  I've attached a "quick hack" I did for 2.4.0.  It doesn't completely
solve the problem, but moves it in the right direction.

  Please let me know if this helps.

Mark

--0-2023635380-979676059=:26195
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="buffer.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0101162014190.26195@alloc>
Content-Description: buffer.patch
Content-Disposition: attachment; filename="buffer.patch"

ZGlmZiAtdXJOIC1YIGRvbnRkaWZmIGxpbnV4LTIuNC4wL21tL3BhZ2VfYWxs
b2MuYyBtYXJraGUtMi40LjAvbW0vcGFnZV9hbGxvYy5jDQotLS0gbGludXgt
Mi40LjAvbW0vcGFnZV9hbGxvYy5jCVdlZCBKYW4gIDMgMTc6NTk6MDYgMjAw
MQ0KKysrIG1hcmtoZS0yLjQuMC9tbS9wYWdlX2FsbG9jLmMJTW9uIEphbiAx
NSAxNTozNToxNCAyMDAxDQpAQCAtNTgzLDYgKzU4MywyNyBAQA0KIH0NCiAN
CiAvKg0KKyAqCUZyZWUgcGFnZXMgaW4gem9uZSAidHlwZSIsIGFuZCB0aGUg
em9uZXMgYmVsb3cgaXQuDQorICovDQordW5zaWduZWQgaW50IG5yX2ZyZWVf
cGFnZXNfem9uZSAoaW50IHR5cGUpDQorew0KKwl1bnNpZ25lZCBpbnQgc3Vt
Ow0KKwl6b25lX3QgKnpvbmU7DQorCXBnX2RhdGFfdCAqcGdkYXQgPSBwZ2Rh
dF9saXN0Ow0KKw0KKwlpZiAodHlwZSA+PSBNQVhfTlJfWk9ORVMpDQorCQlC
VUcoKTsNCisNCisJc3VtID0gMDsNCisJd2hpbGUgKHBnZGF0KSB7DQorCQlm
b3IgKHpvbmUgPSBwZ2RhdC0+bm9kZV96b25lczsgem9uZSA8IHBnZGF0LT5u
b2RlX3pvbmVzICsgdHlwZTsgem9uZSsrKQ0KKwkJCXN1bSArPSB6b25lLT5m
cmVlX3BhZ2VzOw0KKwkJcGdkYXQgPSBwZ2RhdC0+bm9kZV9uZXh0Ow0KKwl9
DQorCXJldHVybiBzdW07DQorfQ0KKw0KKy8qDQogICogVG90YWwgYW1vdW50
IG9mIGluYWN0aXZlX2NsZWFuIChhbGxvY2F0YWJsZSkgUkFNOg0KICAqLw0K
IHVuc2lnbmVkIGludCBucl9pbmFjdGl2ZV9jbGVhbl9wYWdlcyAodm9pZCkN
CkBAIC02MDAsNiArNjIxLDI1IEBADQogCXJldHVybiBzdW07DQogfQ0KIA0K
K3Vuc2lnbmVkIGludCBucl9pbmFjdGl2ZV9jbGVhbl9wYWdlc196b25lKGlu
dCB0eXBlKQ0KK3sNCisJdW5zaWduZWQgaW50IHN1bTsNCisJem9uZV90ICp6
b25lOw0KKwlwZ19kYXRhX3QgKnBnZGF0ID0gcGdkYXRfbGlzdDsNCisNCisJ
aWYgKHR5cGUgPj0gTUFYX05SX1pPTkVTKQ0KKwkJQlVHKCk7DQorCXR5cGUr
KzsNCisNCisJc3VtID0gMDsNCisJd2hpbGUgKHBnZGF0KSB7DQorCQlmb3Ig
KHpvbmUgPSBwZ2RhdC0+bm9kZV96b25lczsgem9uZSA8IHBnZGF0LT5ub2Rl
X3pvbmVzICsgdHlwZTsgem9uZSsrKQ0KKwkJCXN1bSArPSB6b25lLT5pbmFj
dGl2ZV9jbGVhbl9wYWdlczsNCisJCXBnZGF0ID0gcGdkYXQtPm5vZGVfbmV4
dDsNCisJfQ0KKwlyZXR1cm4gc3VtOw0KK30NCisNCiAvKg0KICAqIEFtb3Vu
dCBvZiBmcmVlIFJBTSBhbGxvY2F0YWJsZSBhcyBidWZmZXIgbWVtb3J5Og0K
ICAqLw0KQEAgLTYwNyw5ICs2NDcsOSBAQA0KIHsNCiAJdW5zaWduZWQgaW50
IHN1bTsNCiANCi0Jc3VtID0gbnJfZnJlZV9wYWdlcygpOw0KLQlzdW0gKz0g
bnJfaW5hY3RpdmVfY2xlYW5fcGFnZXMoKTsNCi0Jc3VtICs9IG5yX2luYWN0
aXZlX2RpcnR5X3BhZ2VzOw0KKwlzdW0gPSBucl9mcmVlX3BhZ2VzX3pvbmUo
Wk9ORV9OT1JNQUwpOw0KKwlzdW0gKz0gbnJfaW5hY3RpdmVfY2xlYW5fcGFn
ZXNfem9uZShaT05FX05PUk1BTCk7DQorCXN1bSArPSBucl9pbmFjdGl2ZV9k
aXJ0eV9wYWdlczsJLyogWFhYICovDQogDQogCS8qDQogCSAqIEtlZXAgb3Vy
IHdyaXRlIGJlaGluZCBxdWV1ZSBmaWxsZWQsIGV2ZW4gaWYNCg==
--0-2023635380-979676059=:26195--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
