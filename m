Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131586AbRC0VLY>; Tue, 27 Mar 2001 16:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131578AbRC0VLP>; Tue, 27 Mar 2001 16:11:15 -0500
Received: from lowell.missioncriticallinux.com ([208.51.139.16]:43887 "EHLO
	jerrell.lowell.mclinux.com") by vger.kernel.org with ESMTP
	id <S131586AbRC0VLI>; Tue, 27 Mar 2001 16:11:08 -0500
Date: Tue, 27 Mar 2001 16:29:07 -0500 (EST)
From: Richard Jerrell <jerrell@missioncriticallinux.com>
To: Stephen Tweedie <sct@redhat.com>
cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@nl.linux.org>
Subject: Re: [PATCH] mm/memory.c, 2.4.1 : memory leak with swap cache (updated)
Message-ID: <Pine.LNX.4.21.0103271624520.1989-200000@jerrell.lowell.mclinux.com>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="17458952-640493736-985727040=:1989"
Content-ID: <Pine.LNX.4.21.0103271624521.1989@jerrell.lowell.mclinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--17458952-640493736-985727040=:1989
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.21.0103271623482.1989@jerrell.lowell.mclinux.com>

> fork and exit are very hot paths in the kernel, and this patch can force
> a page cache lookup on a large number of pte which wouldn't be looked
> up before.

True, but I don't know how large of a performance hit the system takes.

> Given that the leak is, as you say, temporary, and that the leak will
> be recovered as soon as we start swapping again, do we really want to
> pollute the fast path for the sake of a bit more speed during
> swapping?

It isn't speed of swapping that is the biggest problem.  The problem is
that if you run a memory intensive task, exit after being placed on an
lru, and run it again, there won't be enough memory to execute because all
the memory you used previously is now sitting in the swap cache.  That
isn't to say that without being patched the speed isn't poor.  After all,
we'd be paging out a dead processes pages.

But you are right, this fix is slow and that can be improved.  So,
hopefully this patch is satisfactory in respect to speed and fixing the
leak.  And will also remove the panic which is possible with the other
patches (can't do a lookup_swap_cache with a spinlock held).

Instead of removing the swap cache page at process exit and possibly
expending time doing disk IO as you have pointed out, we check during
refill_inactive_scan and page_launder for a page that is 

1)  in the swap cache 
2)  is not locked 
3)  is only being referenced by the swap cache, us, and possibly by
    buffers
4)  has no one else referencing the swap cell

If that is true, we can safely remove that page without writing it to
disk.  In addition, the number of swap cache pages are included in the
amount returned from vm_enough_memory to get rid of the temporary leak.

So, the exit path remains unchanged, reclaiming a page is faster for when
the page is no longer being mapped, and the lazy reclaiming for multiply
referenced pages remains intact.

Rich

--17458952-640493736-985727040=:1989
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="2.4.1-paging-fix-27.03.01.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0103271604000.1989@jerrell.lowell.mclinux.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="2.4.1-paging-fix-27.03.01.patch"

ZGlmZiAtck51IGxpbnV4LTIuNC4xL2luY2x1ZGUvbGludXgvc3dhcC5oIGxp
bnV4LTIuNC4xLXBhZ2luZy1maXgvaW5jbHVkZS9saW51eC9zd2FwLmgNCi0t
LSBsaW51eC0yLjQuMS9pbmNsdWRlL2xpbnV4L3N3YXAuaAlUdWUgSmFuIDMw
IDAyOjI0OjU2IDIwMDENCisrKyBsaW51eC0yLjQuMS1wYWdpbmctZml4L2lu
Y2x1ZGUvbGludXgvc3dhcC5oCVR1ZSBNYXIgMjcgMTA6NDM6MjIgMjAwMQ0K
QEAgLTY5LDYgKzY5LDcgQEANCiBGQVNUQ0FMTCh1bnNpZ25lZCBpbnQgbnJf
ZnJlZV9idWZmZXJfcGFnZXModm9pZCkpOw0KIGV4dGVybiBpbnQgbnJfYWN0
aXZlX3BhZ2VzOw0KIGV4dGVybiBpbnQgbnJfaW5hY3RpdmVfZGlydHlfcGFn
ZXM7DQorZXh0ZXJuIGludCBucl9zd2FwX2NhY2hlX3BhZ2VzOw0KIGV4dGVy
biBhdG9taWNfdCBucl9hc3luY19wYWdlczsNCiBleHRlcm4gc3RydWN0IGFk
ZHJlc3Nfc3BhY2Ugc3dhcHBlcl9zcGFjZTsNCiBleHRlcm4gYXRvbWljX3Qg
cGFnZV9jYWNoZV9zaXplOw0KZGlmZiAtck51IGxpbnV4LTIuNC4xL21tL21t
YXAuYyBsaW51eC0yLjQuMS1wYWdpbmctZml4L21tL21tYXAuYw0KLS0tIGxp
bnV4LTIuNC4xL21tL21tYXAuYwlNb24gSmFuIDI5IDExOjEwOjQxIDIwMDEN
CisrKyBsaW51eC0yLjQuMS1wYWdpbmctZml4L21tL21tYXAuYwlUdWUgTWFy
IDI3IDEwOjM4OjE3IDIwMDENCkBAIC02Myw2ICs2Myw3IEBADQogCWZyZWUg
Kz0gYXRvbWljX3JlYWQoJnBhZ2VfY2FjaGVfc2l6ZSk7DQogCWZyZWUgKz0g
bnJfZnJlZV9wYWdlcygpOw0KIAlmcmVlICs9IG5yX3N3YXBfcGFnZXM7DQor
CWZyZWUgKz0gbnJfc3dhcF9jYWNoZV9wYWdlczsNCiAJcmV0dXJuIGZyZWUg
PiBwYWdlczsNCiB9DQogDQpkaWZmIC1yTnUgbGludXgtMi40LjEvbW0vc3dh
cF9zdGF0ZS5jIGxpbnV4LTIuNC4xLXBhZ2luZy1maXgvbW0vc3dhcF9zdGF0
ZS5jDQotLS0gbGludXgtMi40LjEvbW0vc3dhcF9zdGF0ZS5jCUZyaSBEZWMg
MjkgMTg6MDQ6MjcgMjAwMA0KKysrIGxpbnV4LTIuNC4xLXBhZ2luZy1maXgv
bW0vc3dhcF9zdGF0ZS5jCVR1ZSBNYXIgMjcgMTA6NDE6MDQgMjAwMQ0KQEAg
LTE3LDYgKzE3LDggQEANCiANCiAjaW5jbHVkZSA8YXNtL3BndGFibGUuaD4N
CiANCitpbnQgbnJfc3dhcF9jYWNoZV9wYWdlcyA9IDA7DQorDQogc3RhdGlj
IGludCBzd2FwX3dyaXRlcGFnZShzdHJ1Y3QgcGFnZSAqcGFnZSkNCiB7DQog
CXJ3X3N3YXBfcGFnZShXUklURSwgcGFnZSwgMCk7DQpAQCAtNTgsNiArNjAs
NyBAQA0KICNpZmRlZiBTV0FQX0NBQ0hFX0lORk8NCiAJc3dhcF9jYWNoZV9h
ZGRfdG90YWwrKzsNCiAjZW5kaWYNCisJbnJfc3dhcF9jYWNoZV9wYWdlcysr
Ow0KIAlpZiAoIVBhZ2VMb2NrZWQocGFnZSkpDQogCQlCVUcoKTsNCiAJaWYg
KFBhZ2VUZXN0YW5kU2V0U3dhcENhY2hlKHBhZ2UpKQ0KQEAgLTk2LDYgKzk5
LDcgQEANCiAjaWZkZWYgU1dBUF9DQUNIRV9JTkZPDQogCXN3YXBfY2FjaGVf
ZGVsX3RvdGFsKys7DQogI2VuZGlmDQorCW5yX3N3YXBfY2FjaGVfcGFnZXMt
LTsNCiAJcmVtb3ZlX2Zyb21fc3dhcF9jYWNoZShwYWdlKTsNCiAJc3dhcF9m
cmVlKGVudHJ5KTsNCiB9DQpkaWZmIC1yTnUgbGludXgtMi40LjEvbW0vdm1z
Y2FuLmMgbGludXgtMi40LjEtcGFnaW5nLWZpeC9tbS92bXNjYW4uYw0KLS0t
IGxpbnV4LTIuNC4xL21tL3Ztc2Nhbi5jCU1vbiBKYW4gMTUgMTU6MzY6NDkg
MjAwMQ0KKysrIGxpbnV4LTIuNC4xLXBhZ2luZy1maXgvbW0vdm1zY2FuLmMJ
VHVlIE1hciAyNyAxMjozMTowNCAyMDAxDQpAQCAtNDY2LDYgKzQ2NiwxNyBA
QA0KIAkJCWNvbnRpbnVlOw0KIAkJfQ0KIA0KKwkJaWYgKFBhZ2VTd2FwQ2Fj
aGUocGFnZSkpIHsNCisJCQlwYWdlX2NhY2hlX2dldChwYWdlKTsNCisJCQlp
ZighaXNfcGFnZV9zaGFyZWQocGFnZSkpIHsNCisJCQkJZGVsZXRlX2Zyb21f
c3dhcF9jYWNoZV9ub2xvY2socGFnZSk7DQorCQkJCVVubG9ja1BhZ2UocGFn
ZSk7DQorCQkJCXBhZ2VfY2FjaGVfcmVsZWFzZShwYWdlKTsNCisJCQkJY29u
dGludWU7DQorCQkJfQ0KKwkJCXBhZ2VfY2FjaGVfcmVsZWFzZShwYWdlKTsN
CisJCX0NCisNCiAJCS8qDQogCQkgKiBEaXJ0eSBzd2FwLWNhY2hlIHBhZ2U/
IFdyaXRlIGl0IG91dCBpZg0KIAkJICogbGFzdCBjb3B5Li4NCkBAIC02NTAs
NiArNjYxLDE3IEBADQogCQkJbGlzdF9kZWwocGFnZV9scnUpOw0KIAkJCW5y
X2FjdGl2ZV9wYWdlcy0tOw0KIAkJCWNvbnRpbnVlOw0KKwkJfQ0KKw0KKwkJ
aWYgKFBhZ2VTd2FwQ2FjaGUocGFnZSkpIHsNCisJCQlwYWdlX2NhY2hlX2dl
dChwYWdlKTsNCisJCQlpZighaXNfcGFnZV9zaGFyZWQocGFnZSkgJiYgIVRy
eUxvY2tQYWdlKHBhZ2UpKSB7DQorCQkJCWRlbGV0ZV9mcm9tX3N3YXBfY2Fj
aGVfbm9sb2NrKHBhZ2UpOw0KKwkJCQlVbmxvY2tQYWdlKHBhZ2UpOw0KKwkJ
CQlwYWdlX2NhY2hlX3JlbGVhc2UocGFnZSk7DQorCQkJCWNvbnRpbnVlOw0K
KwkJCX0NCisJCQlwYWdlX2NhY2hlX3JlbGVhc2UocGFnZSk7DQogCQl9DQog
DQogCQkvKiBEbyBhZ2luZyBvbiB0aGUgcGFnZXMuICovDQo=
--17458952-640493736-985727040=:1989--
