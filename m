Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132207AbRCVWG7>; Thu, 22 Mar 2001 17:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132208AbRCVWGt>; Thu, 22 Mar 2001 17:06:49 -0500
Received: from lowell.missioncriticallinux.com ([208.51.139.16]:36443 "EHLO
	jerrell.lowell.mclinux.com") by vger.kernel.org with ESMTP
	id <S132207AbRCVWGk>; Thu, 22 Mar 2001 17:06:40 -0500
Date: Thu, 22 Mar 2001 17:21:46 -0500 (EST)
From: Richard Jerrell <jerrell@missioncriticallinux.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] mm/memory.c, 2.4.1 : memory leak with swap cache (updated)
Message-ID: <Pine.LNX.4.21.0103221716460.20061-200000@jerrell.lowell.mclinux.com>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="17458952-1346124290-982275034=:1390"
Content-ID: <Pine.LNX.4.21.0102151740300.1390@jerrell.lowell.mclinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--17458952-1346124290-982275034=:1390
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.21.0102151740301.1390@jerrell.lowell.mclinux.com>

2.4.1 has a memory leak (temporary) where anonymous memory pages that have
been moved into the swap cache will stick around after their vma has been
unmapped by the owning process.  These pages are not free'd in free_pte()
because they are still referenced by the page cache.  In addition, if the
pages are dirty, they will be written out to the swap device before they
are reclaimed even though the owning process no longer will be using the
pages.

free_pte in mm/memory.c has been modified to check to see if the page is
only being referenced by the swap cache (and possibly buffers).  If so,
the buffers (if existant) are free'd and the page and swap cache
entry are removed immediately.

Essentially, this is the same patch as before, but there was one condition
in which case we would leak and extra reference to the targeted page if
the counts would not allow us to remove the swap cache entry.  The leak in
2.4.1 also applies to 2.4.2 and 2.4.3-pre5.

Rich Jerrell
jerrell@missioncriticallinux.com

--17458952-1346124290-982275034=:1390
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="2.4.1-paging-fix-22.03.01.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0103221721461.20061@jerrell.lowell.mclinux.com>
Content-Description: 
Content-Disposition: attachment; filename="2.4.1-paging-fix-22.03.01.patch"

ZGlmZiAtLXJlY3Vyc2l2ZSAtdSAtTiBsaW51eC0yLjQuMS9tbS9tZW1vcnku
YyBsaW51eC0yLjQuMS1wYWdpbmctZml4L21tL21lbW9yeS5jDQotLS0gbGlu
dXgtMi40LjEvbW0vbWVtb3J5LmMJU2F0IEphbiAyNyAyMjoxMjozNSAyMDAx
DQorKysgbGludXgtMi40LjEtcGFnaW5nLWZpeC9tbS9tZW1vcnkuYwlUaHUg
RmViIDE1IDEzOjM2OjA2IDIwMDENCkBAIC0yODEsNiArMjg1LDM0IEBADQog
CQlyZXR1cm4gMTsNCiAJfQ0KIAlzd2FwX2ZyZWUocHRlX3RvX3N3cF9lbnRy
eShwdGUpKTsNCisJew0KKwkJaW50IG51bSwgdGFyZ2V0ID0gMTsNCisJCXN0
cnVjdCBwYWdlICpwYWdlID0gbG9va3VwX3N3YXBfY2FjaGUocHRlX3RvX3N3
cF9lbnRyeShwdGUpKTsNCisJCSAgICAgICAgICAgICAgICAgICAgLyogcmV0
dXJucyB0aGUgcGFnZSBhbmQgdGFrZXMgYSByZWZlcmVuY2UgKi8NCisJCQ0K
KwkJaWYgKCFwYWdlIHx8ICghVkFMSURfUEFHRShwYWdlKSkgfHwgUGFnZVJl
c2VydmVkKHBhZ2UpKQ0KKwkJCXJldHVybiAwOw0KKwkJDQorCQludW0gPSBh
dG9taWNfcmVhZCgmcGFnZS0+Y291bnQpOw0KKwkJaWYocGFnZS0+YnVmZmVy
cykgdGFyZ2V0Kys7CQkvKiAxIGNvdW50IGlmIHdlIGhhdmUgYnVmZmVycyAq
Lw0KKwkJaWYoUGFnZVN3YXBDYWNoZShwYWdlKSkgdGFyZ2V0Kys7CS8qIDEg
Y291bnQgZm9yIHRoZSBwYWdlIGNhY2hlICovDQorCQkJCQkJCS8qIDEgY291
bnQgZm9yIG91ciByZWZlcmVuY2UgICovDQorDQorCQlpZigobnVtID09IHRh
cmdldCkgJiYgUGFnZVN3YXBDYWNoZShwYWdlKSkgew0KKwkJCS8qIFN3YXBD
YWNoZSBlbnRyeSBpcyB0aGUgb25seSB0aGluZyByZWZlcmVuY2luZyB0aGlz
IHBhZ2UgICAqLw0KKwkJCS8qIChhbmQgbWF5YmUgYnVmZmVycykgYXNpZGVz
IGZyb20gdXMsIHNvIHRvIHByZXZlbnQgaXQgZnJvbSAqLw0KKwkJCS8qIHNp
dHRpbmcgYXJvdW5kIGFuZCB3YXN0aW5nIHRpbWUvbWVtb3J5LCB0aHJvdyBp
dCBhd2F5ICAgICAqLw0KKwkJCWlmKChwYWdlLT5idWZmZXJzKSkgew0KKwkJ
CQlpZighdHJ5X3RvX2ZyZWVfYnVmZmVycyhwYWdlLDEpKSB7CS8qIENhbid0
IGdldCByaWQgb2YgYnVmZmVycyAgICovDQorCQkJCQlwYWdlX2NhY2hlX3Jl
bGVhc2UocGFnZSk7CS8qIGdldCByaWQgb2Ygb3VyIHJlZmVyZW5jZSAgICov
DQorCQkJCQlyZXR1cm4gMDsJCQkvKiBhbmQgbGV0IHNvbWVvbmUgZWxzZSBk
byBpdCAqLw0KKwkJCQl9DQorCQkJfQ0KKwkJCWZyZWVfcGFnZV9hbmRfc3dh
cF9jYWNoZShwYWdlKTsJLyogRXhwZWN0cyB0aGUgcGFnZSB0byBiZSBtYXBw
ZWQsIHNvIHdpbGwgKi8NCisJCQlyZXR1cm4gMTsJCQkvKiBhY2NvdW50IGZv
ciB0aGUgcmVmZXJlbmNlIHdlIGhhdmUgICAgICAqLw0KKwkJfQ0KKwkJcGFn
ZV9jYWNoZV9yZWxlYXNlKHBhZ2UpOyAgICAgICAvKiBSZW1vdmUgb3VyIHJl
ZmVyZW5jZSwgd2UgY2FuJ3QgZG8gYW55dGhpbmcgKi8NCisJfQ0KIAlyZXR1
cm4gMDsNCiB9DQogDQo=
--17458952-1346124290-982275034=:1390--
