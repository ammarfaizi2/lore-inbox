Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280031AbRJ3QzF>; Tue, 30 Oct 2001 11:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280027AbRJ3Qy5>; Tue, 30 Oct 2001 11:54:57 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25870 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280023AbRJ3Qyt>; Tue, 30 Oct 2001 11:54:49 -0500
Date: Tue, 30 Oct 2001 08:52:58 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        Andrea Arcangeli <andrea@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: need help interpreting 'free' output.
In-Reply-To: <Pine.LNX.4.21.0110301557560.1229-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0110300839360.8603-200000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="168447515-98433695-1004460778=:8603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--168447515-98433695-1004460778=:8603
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Tue, 30 Oct 2001, Hugh Dickins wrote:
>
> However, unlike 2.4.13, 2.4.14-pre (you tried pre4, I just tried pre5)
> seems much too unwilling to shrink_dcache and shrink_icache: your
> memory hog should shrink them, but it seems not to.  Linus?

Yes. It's next on my list.

My _preferred_ approach would actually be to move the slab pages to the
LRU list too, and have a special "slab" address space (we don't need to
actually hash them, we just make page->mapping point to it), and have the
cache shrink be done naturally as part of writepage().

That way "shrink_cache()" reacts very naturally to slab pressure, while
right now it's more of a random behaviour. That's what the "anonymous
pages in the LRU" approach fixes - the VM scanning reacts very naturally
(instead of with subtle tweaking and almost random behaviour) to mapped
page pressure.

The "slab address space" is a longer-range plan, though. It migth be
really simple (the writepage would just move the page to the active list
and try to shrink the slab that was hit), but I think the current stuff is
"good enough".

So in the short range, I haven't come up with any really good approaches,
but I suspect I'll just have to move the shrink_[di]cache() back to the
caller, which will at least shrink them on swapouts (a bit too much, I
think, but on the other hand maybe not).

Patch attached,

		Linus

--168447515-98433695-1004460778=:8603
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=slab
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0110300852580.8603@penguin.transmeta.com>
Content-Description: 
Content-Disposition: attachment; filename=slab

ZGlmZiAtdSAtLXJlY3Vyc2l2ZSBwcmU1L2xpbnV4L21tL3Ztc2Nhbi5jIGxp
bnV4L21tL3Ztc2Nhbi5jDQotLS0gcHJlNS9saW51eC9tbS92bXNjYW4uYwlU
dWUgT2N0IDMwIDA4OjUxOjEzIDIwMDENCisrKyBsaW51eC9tbS92bXNjYW4u
YwlUdWUgT2N0IDMwIDA4OjQ2OjA4IDIwMDENCkBAIC01MTUsMjAgKzUxNSw2
IEBADQogCX0NCiAJc3Bpbl91bmxvY2soJnBhZ2VtYXBfbHJ1X2xvY2spOw0K
IA0KLQlpZiAobnJfcGFnZXMgPD0gMCkNCi0JCXJldHVybiAwOw0KLQ0KLQkv
Kg0KLQkgKiBJZiBzd2FwcGluZyBvdXQgaXNuJ3QgYXBwcm9wcmlhdGUsIGFu
ZCANCi0JICogd2Ugc3RpbGwgZmFpbCwgdHJ5IHRoZSBvdGhlciAodXN1YWxs
eSBzbWFsbGVyKQ0KLQkgKiBjYWNoZXMgaW5zdGVhZC4NCi0JICovDQotCXNo
cmlua19kY2FjaGVfbWVtb3J5KHByaW9yaXR5LCBnZnBfbWFzayk7DQotCXNo
cmlua19pY2FjaGVfbWVtb3J5KHByaW9yaXR5LCBnZnBfbWFzayk7DQotI2lm
ZGVmIENPTkZJR19RVU9UQQ0KLQlzaHJpbmtfZHFjYWNoZV9tZW1vcnkoREVG
X1BSSU9SSVRZLCBnZnBfbWFzayk7DQotI2VuZGlmDQotDQogCXJldHVybiBu
cl9wYWdlczsNCiB9DQogDQpAQCAtNTc3LDcgKzU2MywxNyBAQA0KIAlyYXRp
byA9ICh1bnNpZ25lZCBsb25nKSBucl9wYWdlcyAqIG5yX2FjdGl2ZV9wYWdl
cyAvICgobnJfaW5hY3RpdmVfcGFnZXMgKyAxKSAqIDIpOw0KIAlyZWZpbGxf
aW5hY3RpdmUocmF0aW8pOw0KIA0KLQlyZXR1cm4gc2hyaW5rX2NhY2hlKG5y
X3BhZ2VzLCBjbGFzc3pvbmUsIGdmcF9tYXNrLCBwcmlvcml0eSk7DQorCW5y
X3BhZ2VzID0gc2hyaW5rX2NhY2hlKG5yX3BhZ2VzLCBjbGFzc3pvbmUsIGdm
cF9tYXNrLCBwcmlvcml0eSk7DQorCWlmIChucl9wYWdlcyA8PSAwKQ0KKwkJ
cmV0dXJuIDA7DQorDQorCXNocmlua19kY2FjaGVfbWVtb3J5KHByaW9yaXR5
LCBnZnBfbWFzayk7DQorCXNocmlua19pY2FjaGVfbWVtb3J5KHByaW9yaXR5
LCBnZnBfbWFzayk7DQorI2lmZGVmIENPTkZJR19RVU9UQQ0KKwlzaHJpbmtf
ZHFjYWNoZV9tZW1vcnkoREVGX1BSSU9SSVRZLCBnZnBfbWFzayk7DQorI2Vu
ZGlmDQorDQorCXJldHVybiBucl9wYWdlczsNCiB9DQogDQogaW50IHRyeV90
b19mcmVlX3BhZ2VzKHpvbmVfdCAqY2xhc3N6b25lLCB1bnNpZ25lZCBpbnQg
Z2ZwX21hc2ssIHVuc2lnbmVkIGludCBvcmRlcikNCg0K
--168447515-98433695-1004460778=:8603--
