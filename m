Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135339AbRDWRHP>; Mon, 23 Apr 2001 13:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132886AbRDWRHF>; Mon, 23 Apr 2001 13:07:05 -0400
Received: from chiara.elte.hu ([157.181.150.200]:63244 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S135206AbRDWRGs>;
	Mon, 23 Apr 2001 13:06:48 -0400
Date: Mon, 23 Apr 2001 18:05:22 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Szabolcs Szakacsits <szaka@f-secure.com>
Subject: [patch] swap-speedup-2.4.3-A2
In-Reply-To: <Pine.LNX.4.21.0104231218000.1685-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.30.0104231707350.31693-200000@elte.hu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="655616-249442813-988041691=:32406"
Content-ID: <Pine.LNX.4.30.0104231801490.32406@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--655616-249442813-988041691=:32406
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.30.0104231801491.32406@elte.hu>


On Mon, 23 Apr 2001, Rik van Riel wrote:

> There seems to be one more reason, take a look at the function
> read_swap_cache_async() in swap_state.c, around line 240:

you are right - i thought about that issue too and assumed it works like
the pagecache (which first reads the page without hashing it, then tries
to add the result to the pagecache and throws away the page if anyone else
finished it already), but that was incorrect.

i think the swapcache's behavior is actually the more correct one, and the
pagecache should first hash pending reads, then start the IO. If someone
else tries to read the page and the page is not uptodate and locked, then
we should sleep on the page's waitqueue. End-of-page-IO or PageError
should then unlock the page and wake up all waiters. [which happens
already]

several processes trying to read the same page is a legitimate scenario,
and should not result in multiple reads done on the same disk area.
Besides the (albeit small) performance win, IMO this is also a quality of
implementation issue, even if the window is small. (the window might be
not that small in some cases like NFS?)

i've fixed the patch so that it checks Page_Uptodate() within
__find_get_swapcache_page(). The only case i'm not convinced about is the
case of IO errors, but otherwise this should work. I've also fixed an
SMP-only bug in the new __find_get_swapcache_page()  function: it must not
run __find_page_nolock() with the LRU lock held.

i've attached swap-speedup-2.4.3-A2 which has these fixes included.

> OTOH, no matter how fast we make the current functionality, there will
> always be some point at which the system is so overloaded that no
> paging system can help save it from thrashing.

agreed - but this should really be the last resort, and i'm still worried
about potentially hiding real performance bugs.

> Btw, to test this ... try running 10 copies of gnuchess playing
> against itself on a machine with 64 MB of RAM. You'll go under
> thrashing pretty quickly.

thanks, i'll try that. (do you have any easy oneliner command line to
start up gnuchess against itself?)

	Ingo

--655616-249442813-988041691=:32406
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="swap-speedup-2.4.3-A2"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0104231801310.32406@elte.hu>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="swap-speedup-2.4.3-A2"

LS0tIGxpbnV4L21tL2ZpbGVtYXAuYy5vcmlnCU1vbiBBcHIgMjMgMTM6MzU6
MDYgMjAwMQ0KKysrIGxpbnV4L21tL2ZpbGVtYXAuYwlNb24gQXByIDIzIDIw
OjU1OjIzIDIwMDENCkBAIC03MTAsNiArNzEwLDQzIEBADQogfQ0KIA0KIC8q
DQorICogRmluZCBhIHN3YXBjYWNoZSBwYWdlIChhbmQgZ2V0IGEgcmVmZXJl
bmNlKSBvciByZXR1cm4gTlVMTC4NCisgKiBUaGUgU3dhcENhY2hlIGNoZWNr
IGlzIHByb3RlY3RlZCBieSB0aGUgcGFnZWNhY2hlIGxvY2suDQorICovDQor
c3RydWN0IHBhZ2UgKiBfX2ZpbmRfZ2V0X3N3YXBjYWNoZV9wYWdlKHN0cnVj
dCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLA0KKwkJCSAgICAgIHVuc2lnbmVk
IGxvbmcgb2Zmc2V0LCBzdHJ1Y3QgcGFnZSAqKmhhc2gpDQorew0KKwlzdHJ1
Y3QgcGFnZSAqcGFnZTsNCisNCisJLyoNCisJICogV2UgbmVlZCB0aGUgTFJV
IGxvY2sgdG8gcHJvdGVjdCBhZ2FpbnN0IHBhZ2VfbGF1bmRlcigpLg0KKwkg
Ki8NCityZXBlYXQ6DQorCXNwaW5fbG9jaygmcGFnZWNhY2hlX2xvY2spOw0K
KwlwYWdlID0gX19maW5kX3BhZ2Vfbm9sb2NrKG1hcHBpbmcsIG9mZnNldCwg
Kmhhc2gpOw0KKwlpZiAocGFnZSkgew0KKwkJc3Bpbl9sb2NrKCZwYWdlbWFw
X2xydV9sb2NrKTsNCisJCWlmIChQYWdlU3dhcENhY2hlKHBhZ2UpKSB7DQor
CQkJcGFnZV9jYWNoZV9nZXQocGFnZSk7DQorCQkJaWYgKCFQYWdlX1VwdG9k
YXRlKHBhZ2UpICYmIFBhZ2VMb2NrZWQocGFnZSkpIHsNCisJCQkJc3Bpbl91
bmxvY2soJnBhZ2VtYXBfbHJ1X2xvY2spOw0KKwkJCQlzcGluX3VubG9jaygm
cGFnZWNhY2hlX2xvY2spOw0KKwkJCQlfX193YWl0X29uX3BhZ2UocGFnZSk7
DQorCQkJCXBhZ2VfY2FjaGVfcmVsZWFzZShwYWdlKTsNCisJCQkJZ290byBy
ZXBlYXQ7DQorCQkJfQ0KKwkJCWlmICghUGFnZV9VcHRvZGF0ZShwYWdlKSkN
CisJCQkJcHJpbnRrKCJobTogcGFnZSBub3QgdXB0b2RhdGUgaW4gX19maW5k
X2dldF9zd2FwY2FjaGVfcGFnZSgpPyBwYWdlIGZsYWdzOiAlMDhseFxuIiwg
cGFnZS0+ZmxhZ3MpOw0KKwkJfSBlbHNlDQorCQkJcGFnZSA9IE5VTEw7DQor
CQlzcGluX3VubG9jaygmcGFnZW1hcF9scnVfbG9jayk7DQorCX0NCisJc3Bp
bl91bmxvY2soJnBhZ2VjYWNoZV9sb2NrKTsNCisNCisJcmV0dXJuIHBhZ2U7
DQorfQ0KKw0KKy8qDQogICogU2FtZSBhcyB0aGUgYWJvdmUsIGJ1dCBsb2Nr
IHRoZSBwYWdlIHRvbywgdmVyaWZ5aW5nIHRoYXQNCiAgKiBpdCdzIHN0aWxs
IHZhbGlkIG9uY2Ugd2Ugb3duIGl0Lg0KICAqLw0KLS0tIGxpbnV4L21tL3N3
YXBfc3RhdGUuYy5vcmlnCU1vbiBBcHIgMjMgMTM6MzU6MDYgMjAwMQ0KKysr
IGxpbnV4L21tL3N3YXBfc3RhdGUuYwlNb24gQXByIDIzIDEzOjM3OjAxIDIw
MDENCkBAIC0xNjMsMzcgKzE2MywxOCBAQA0KIAkJLyoNCiAJCSAqIFJpZ2h0
IG5vdyB0aGUgcGFnZWNhY2hlIGlzIDMyLWJpdCBvbmx5LiAgQnV0IGl0J3Mg
YSAzMiBiaXQgaW5kZXguID0pDQogCQkgKi8NCi1yZXBlYXQ6DQotCQlmb3Vu
ZCA9IGZpbmRfbG9ja19wYWdlKCZzd2FwcGVyX3NwYWNlLCBlbnRyeS52YWwp
Ow0KKwkJZm91bmQgPSBmaW5kX2dldF9zd2FwY2FjaGVfcGFnZSgmc3dhcHBl
cl9zcGFjZSwgZW50cnkudmFsKTsNCiAJCWlmICghZm91bmQpDQogCQkJcmV0
dXJuIDA7DQotCQkvKg0KLQkJICogVGhvdWdoIHRoZSAiZm91bmQiIHBhZ2Ug
d2FzIGluIHRoZSBzd2FwIGNhY2hlIGFuIGluc3RhbnQNCi0JCSAqIGVhcmxp
ZXIsIGl0IG1pZ2h0IGhhdmUgYmVlbiByZW1vdmVkIGJ5IHJlZmlsbF9pbmFj
dGl2ZSBldGMuDQotCQkgKiBSZSBzZWFyY2ggLi4uIFNpbmNlIGZpbmRfbG9j
a19wYWdlIGdyYWJzIGEgcmVmZXJlbmNlIG9uDQotCQkgKiB0aGUgcGFnZSwg
aXQgY2FuIG5vdCBiZSByZXVzZWQgZm9yIGFueXRoaW5nIGVsc2UsIG5hbWVs
eQ0KLQkJICogaXQgY2FuIG5vdCBiZSBhc3NvY2lhdGVkIHdpdGggYW5vdGhl
ciBzd2FwaGFuZGxlLCBzbyBpdA0KLQkJICogaXMgZW5vdWdoIHRvIGNoZWNr
IHdoZXRoZXIgdGhlIHBhZ2UgaXMgc3RpbGwgaW4gdGhlIHNjYWNoZS4NCi0J
CSAqLw0KLQkJaWYgKCFQYWdlU3dhcENhY2hlKGZvdW5kKSkgew0KLQkJCVVu
bG9ja1BhZ2UoZm91bmQpOw0KLQkJCXBhZ2VfY2FjaGVfcmVsZWFzZShmb3Vu
ZCk7DQotCQkJZ290byByZXBlYXQ7DQotCQl9DQorCQlpZiAoIVBhZ2VTd2Fw
Q2FjaGUoZm91bmQpKQ0KKwkJCUJVRygpOw0KIAkJaWYgKGZvdW5kLT5tYXBw
aW5nICE9ICZzd2FwcGVyX3NwYWNlKQ0KLQkJCWdvdG8gb3V0X2JhZDsNCisJ
CQlCVUcoKTsNCiAjaWZkZWYgU1dBUF9DQUNIRV9JTkZPDQogCQlzd2FwX2Nh
Y2hlX2ZpbmRfc3VjY2VzcysrOw0KICNlbmRpZg0KLQkJVW5sb2NrUGFnZShm
b3VuZCk7DQogCQlyZXR1cm4gZm91bmQ7DQogCX0NCi0NCi1vdXRfYmFkOg0K
LQlwcmludGsgKEtFUk5fRVJSICJWTTogRm91bmQgYSBub24tc3dhcHBlciBz
d2FwIHBhZ2UhXG4iKTsNCi0JVW5sb2NrUGFnZShmb3VuZCk7DQotCXBhZ2Vf
Y2FjaGVfcmVsZWFzZShmb3VuZCk7DQotCXJldHVybiAwOw0KIH0NCiANCiAv
KiANCi0tLSBsaW51eC9pbmNsdWRlL2xpbnV4L3BhZ2VtYXAuaC5vcmlnCU1v
biBBcHIgMjMgMTM6MzU6MDUgMjAwMQ0KKysrIGxpbnV4L2luY2x1ZGUvbGlu
dXgvcGFnZW1hcC5oCU1vbiBBcHIgMjMgMTM6Mzc6MDEgMjAwMQ0KQEAgLTc3
LDcgKzc3LDEyIEBADQogCQkJCXVuc2lnbmVkIGxvbmcgaW5kZXgsIHN0cnVj
dCBwYWdlICoqaGFzaCk7DQogZXh0ZXJuIHZvaWQgbG9ja19wYWdlKHN0cnVj
dCBwYWdlICpwYWdlKTsNCiAjZGVmaW5lIGZpbmRfbG9ja19wYWdlKG1hcHBp
bmcsIGluZGV4KSBcDQotCQlfX2ZpbmRfbG9ja19wYWdlKG1hcHBpbmcsIGlu
ZGV4LCBwYWdlX2hhc2gobWFwcGluZywgaW5kZXgpKQ0KKwlfX2ZpbmRfbG9j
a19wYWdlKG1hcHBpbmcsIGluZGV4LCBwYWdlX2hhc2gobWFwcGluZywgaW5k
ZXgpKQ0KKw0KK2V4dGVybiBzdHJ1Y3QgcGFnZSAqIF9fZmluZF9nZXRfc3dh
cGNhY2hlX3BhZ2UgKHN0cnVjdCBhZGRyZXNzX3NwYWNlICogbWFwcGluZywN
CisJCQkJdW5zaWduZWQgbG9uZyBpbmRleCwgc3RydWN0IHBhZ2UgKipoYXNo
KTsNCisjZGVmaW5lIGZpbmRfZ2V0X3N3YXBjYWNoZV9wYWdlKG1hcHBpbmcs
IGluZGV4KSBcDQorCV9fZmluZF9nZXRfc3dhcGNhY2hlX3BhZ2UobWFwcGlu
ZywgaW5kZXgsIHBhZ2VfaGFzaChtYXBwaW5nLCBpbmRleCkpDQogDQogZXh0
ZXJuIHZvaWQgX19hZGRfcGFnZV90b19oYXNoX3F1ZXVlKHN0cnVjdCBwYWdl
ICogcGFnZSwgc3RydWN0IHBhZ2UgKipwKTsNCiANCg==
--655616-249442813-988041691=:32406--
