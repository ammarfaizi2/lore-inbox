Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287570AbRLaRPL>; Mon, 31 Dec 2001 12:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287571AbRLaRPC>; Mon, 31 Dec 2001 12:15:02 -0500
Received: from mail1.mx.voyager.net ([216.93.66.200]:29194 "EHLO
	mail1.mx.voyager.net") by vger.kernel.org with ESMTP
	id <S287570AbRLaROz>; Mon, 31 Dec 2001 12:14:55 -0500
Message-ID: <3C309CDC.DEA9960A@megsinet.net>
Date: Mon, 31 Dec 2001 11:14:04 -0600
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Hartmann <andihartmann@freenet.de>
CC: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <Pine.LNX.4.33L.0112292256490.24031-100000@imladris.surriel.com> <3C2F04F6.7030700@athlon.maya.org>
Content-Type: multipart/mixed;
 boundary="------------9F7319976796EE1195FD9075"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9F7319976796EE1195FD9075
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andreas,

Glad you liked oom2 patch ;)

I split of the patch into 2 pieces, mostly because the OOM killer tamer isn't
really needed anymore with the characteristics of the vmscan/cache recovery
changes.  Both are a little different then before.

a. bug fixed oom killer that looked at whether or not cache was shrinking.
   A greater or equal check should have been a greater then check only...unless
   you were severely stressing your system you probably wouldn't have hit this
   and because vmscan/cache recovery is working quite well.

b. removed nr_swap_pages from the check before deciding to goto swap_out.  it seems
   that we really do need to go to swap_out even for systems w/o any swap to clean
   up various resources before some cache can be recovered.  Unless you run out of
   swap space or have no swap device you probably didn't hit this problem either.

I'm a little concerned about the amount of pages we are potentially throwing between
the active and inactive (refill_inactive) and back again once max_mapped is hit, but
a few experiments with limiting page movement between lists just seemed to make
near OOM performance much worse (lengthly system pauses & mouse freezes).

Anyone else have any comments on the patch(es)?

Do they make any since, if so, should either/both patches or pieces therof be
pushed to Marcello?

Martin
--------------------------------------------------------------------------------------
OOM tamer patch:

a. if cache continues to shrink, we're not OOM, just reset OOM variables and exit
b. instead of waiting 1 second, wait variable time based on Mb of cache, thus the
   larger the cache the longer we wait to start killing processes.  eg 10 megs of
   cache causes OOM killer to wait 10 seconds before starting "c" below.
c. instead of fixed 10 occurrances after the N second wait above, wait 10 * Mb cache.

vmscan patch:

a. instead of calling swap_out as soon as max_mapped is reached, continue to try
   to free pages.  this reduces the number of times we hit try_to_free_pages() and
   swap_out().
b. once max_mapped count is reached move any Referenced pages to the active list, until
   enough pages have been freed or there are no more pages that can be freed.
c. only call swap_out() if both max_mapped is reached and we fail to free enough pages.
--------------9F7319976796EE1195FD9075
Content-Type: application/octet-stream;
 name="oom.patch.2.4.17"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="oom.patch.2.4.17"

LS0tIC4vbW0vb29tX2tpbGwuYwlNb24gTm92ICA1IDE5OjQ1OjEwIDIwMDEKKysrIC91c3Iv
c3JjL2xpbnV4Ly4vbW0vb29tX2tpbGwuYwlTdW4gRGVjIDMwIDIxOjM1OjE5IDIwMDEKQEAg
LTE5OCw3ICsxOTgsNyBAQAogICovCiB2b2lkIG91dF9vZl9tZW1vcnkodm9pZCkKIHsKLQlz
dGF0aWMgdW5zaWduZWQgbG9uZyBmaXJzdCwgbGFzdCwgY291bnQ7CisJc3RhdGljIHVuc2ln
bmVkIGxvbmcgZmlyc3QsIGxhc3QsIGNvdW50LCBtZWdhOwogCXVuc2lnbmVkIGxvbmcgbm93
LCBzaW5jZTsKIAogCS8qCkBAIC0yMjAsMTkgKzIyMCwzMCBAQAogCQlnb3RvIHJlc2V0Owog
CiAJLyoKLQkgKiBJZiB3ZSBoYXZlbid0IHRyaWVkIGZvciBhdCBsZWFzdCBvbmUgc2Vjb25k
LAorCSAqIElmIGNhY2hlIGlzIHN0aWxsIHNocmlua2luZywgd2UncmUgbm90IG9vbS4KKwkg
Ki8KKwlpZiAobWVnYSA+IHBhZ2VzX3RvX21iKGF0b21pY19yZWFkKCZwYWdlX2NhY2hlX3Np
emUpKSkgeworCQlnb3RvIHJlc2V0OworCX0KKworCS8qCisJICogSWYgd2UgaGF2ZW4ndCB0
cmllZCBmb3IgYXQgbGVhc3QgbWVnYSpzZWNvbmQocyksCiAJICogd2UncmUgbm90IHJlYWxs
eSBvb20uCiAJICovCiAJc2luY2UgPSBub3cgLSBmaXJzdDsKLQlpZiAoc2luY2UgPCBIWikK
KwlpZiAoc2luY2UgPCBtZWdhICogSFopIHsKKwkJcHJpbnRrKEtFUk5fREVCVUcgIm91dF9v
Zl9tZW1vcnk6IGNhY2hlIHNpemUgJWQgTWIsIHNpbmNlID0gJWx1LiUwMmx1XG4iLG1lZ2Es
IHNpbmNlL0haLCBzaW5jZSVIWik7CiAJCXJldHVybjsKKwl9CiAKIAkvKgotCSAqIElmIHdl
IGhhdmUgZ290dGVuIG9ubHkgYSBmZXcgZmFpbHVyZXMsCisJICogSWYgd2UgaGF2ZW4ndCBn
b3R0ZW4gbWVnYSBmYWlsdXJlcywKIAkgKiB3ZSdyZSBub3QgcmVhbGx5IG9vbS4gCiAJICov
Ci0JaWYgKCsrY291bnQgPCAxMCkKKwlpZiAoKytjb3VudCA8IG1lZ2EgKiAxMCkgeworCQlw
cmludGsoS0VSTl9ERUJVRyAib3V0X29mX21lbW9yeTogY2FjaGUgc2l6ZSAlZCBNYiwgc2lu
Y2UgPSAlbHUuJTAybHUsIGNvdW50ICVkXG4iLG1lZ2EsIHNpbmNlL0haLCBzaW5jZSVIWiwg
Y291bnQpOwogCQlyZXR1cm47CisJfQogCiAJLyoKIAkgKiBPaywgcmVhbGx5IG91dCBvZiBt
ZW1vcnkuIEtpbGwgc29tZXRoaW5nLgpAQCAtMjQwLDYgKzI1MSw3IEBACiAJb29tX2tpbGwo
KTsKIAogcmVzZXQ6CisJbWVnYSA9IHBhZ2VzX3RvX21iKGF0b21pY19yZWFkKCZwYWdlX2Nh
Y2hlX3NpemUpKTsKIAlmaXJzdCA9IG5vdzsKIAljb3VudCA9IDA7CiB9Cg==
--------------9F7319976796EE1195FD9075
Content-Type: application/octet-stream;
 name="vmscan.patch.2.4.17"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="vmscan.patch.2.4.17"

LS0tIC4vbW0vc3dhcC5jCVNhdCBOb3YgMjQgMjM6NTk6MjggMjAwMQorKysgL3Vzci9zcmMv
bGludXgvLi9tbS9zd2FwLmMJU3VuIERlYyAzMCAxNDoyNjo0NSAyMDAxCkBAIC0zNiw3ICsz
Niw3IEBACiAvKgogICogTW92ZSBhbiBpbmFjdGl2ZSBwYWdlIHRvIHRoZSBhY3RpdmUgbGlz
dC4KICAqLwotc3RhdGljIGlubGluZSB2b2lkIGFjdGl2YXRlX3BhZ2Vfbm9sb2NrKHN0cnVj
dCBwYWdlICogcGFnZSkKK3ZvaWQgYWN0aXZhdGVfcGFnZV9ub2xvY2soc3RydWN0IHBhZ2Ug
KiBwYWdlKQogewogCWlmIChQYWdlTFJVKHBhZ2UpICYmICFQYWdlQWN0aXZlKHBhZ2UpKSB7
CiAJCWRlbF9wYWdlX2Zyb21faW5hY3RpdmVfbGlzdChwYWdlKTsKLS0tIC4vbW0vdm1zY2Fu
LmMJU2F0IERlYyAyMiAwOTozNTo1NCAyMDAxCisrKyAvdXNyL3NyYy9saW51eC8uL21tL3Zt
c2Nhbi5jCVN1biBEZWMgMzAgMjM6NDA6MTAgMjAwMQpAQCAtMzk0LDkgKzM5NCw5IEBACiAJ
CWlmIChQYWdlRGlydHkocGFnZSkgJiYgaXNfcGFnZV9jYWNoZV9mcmVlYWJsZShwYWdlKSAm
JiBwYWdlLT5tYXBwaW5nKSB7CiAJCQkvKgogCQkJICogSXQgaXMgbm90IGNyaXRpY2FsIGhl
cmUgdG8gd3JpdGUgaXQgb25seSBpZgotCQkJICogdGhlIHBhZ2UgaXMgdW5tYXBwZWQgYmVh
dXNlIGFueSBkaXJlY3Qgd3JpdGVyCisJCQkgKiB0aGUgcGFnZSBpcyB1bm1hcHBlZCBiZWNh
dXNlIGFueSBkaXJlY3Qgd3JpdGVyCiAJCQkgKiBsaWtlIE9fRElSRUNUIHdvdWxkIHNldCB0
aGUgUEdfZGlydHkgYml0ZmxhZwotCQkJICogb24gdGhlIHBoaXNpY2FsIHBhZ2UgYWZ0ZXIg
aGF2aW5nIHN1Y2Nlc3NmdWxseQorCQkJICogb24gdGhlIHBoeXNpY2FsIHBhZ2UgYWZ0ZXIg
aGF2aW5nIHN1Y2Nlc3NmdWxseQogCQkJICogcGlubmVkIGl0IGFuZCBhZnRlciB0aGUgSS9P
IHRvIHRoZSBwYWdlIGlzIGZpbmlzaGVkLAogCQkJICogc28gdGhlIGRpcmVjdCB3cml0ZXMg
dG8gdGhlIHBhZ2UgY2Fubm90IGdldCBsb3N0LgogCQkJICovCkBAIC00ODAsMTEgKzQ4MCwx
MiBAQAogCiAJCQkvKgogCQkJICogQWxlcnQhIFdlJ3ZlIGZvdW5kIHRvbyBtYW55IG1hcHBl
ZCBwYWdlcyBvbiB0aGUKLQkJCSAqIGluYWN0aXZlIGxpc3QsIHNvIHdlIHN0YXJ0IHN3YXBw
aW5nIG91dCBub3chCisJCQkgKiBpbmFjdGl2ZSBsaXN0LgorCQkJICogTW92ZSByZWZlcmVu
Y2VkIHBhZ2VzIHRvIHRoZSBhY3RpdmUgbGlzdC4KIAkJCSAqLwotCQkJc3Bpbl91bmxvY2so
JnBhZ2VtYXBfbHJ1X2xvY2spOwotCQkJc3dhcF9vdXQocHJpb3JpdHksIGdmcF9tYXNrLCBj
bGFzc3pvbmUpOwotCQkJcmV0dXJuIG5yX3BhZ2VzOworCQkJaWYgKFBhZ2VSZWZlcmVuY2Vk
KHBhZ2UpKQorCQkJCWFjdGl2YXRlX3BhZ2Vfbm9sb2NrKHBhZ2UpOworCQkJY29udGludWU7
CiAJCX0KIAogCQkvKgpAQCAtNTIxLDYgKzUyMiw5IEBACiAJfQogCXNwaW5fdW5sb2NrKCZw
YWdlbWFwX2xydV9sb2NrKTsKIAorCWlmIChtYXhfbWFwcGVkIDw9IDAgJiYgbnJfcGFnZXMg
PiAwKQorCQlzd2FwX291dChwcmlvcml0eSwgZ2ZwX21hc2ssIGNsYXNzem9uZSk7CisKIAly
ZXR1cm4gbnJfcGFnZXM7CiB9CiAKLS0tIC4vaW5jbHVkZS9saW51eC9zd2FwLmgJU2F0IE5v
diAyNCAyMzo1OToyNCAyMDAxCisrKyAvdXNyL3NyYy9saW51eC8uL2luY2x1ZGUvbGludXgv
c3dhcC5oCVN1biBEZWMgMzAgMTU6MDE6MjEgMjAwMQpAQCAtMTA2LDYgKzEwNiw3IEBACiBl
eHRlcm4gdm9pZCBGQVNUQ0FMTChscnVfY2FjaGVfZGVsKHN0cnVjdCBwYWdlICopKTsKIAog
ZXh0ZXJuIHZvaWQgRkFTVENBTEwoYWN0aXZhdGVfcGFnZShzdHJ1Y3QgcGFnZSAqKSk7Citl
eHRlcm4gdm9pZCBGQVNUQ0FMTChhY3RpdmF0ZV9wYWdlX25vbG9jayhzdHJ1Y3QgcGFnZSAq
KSk7CiAKIGV4dGVybiB2b2lkIHN3YXBfc2V0dXAodm9pZCk7CiAK
--------------9F7319976796EE1195FD9075--

