Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132659AbRDWKWT>; Mon, 23 Apr 2001 06:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132724AbRDWKWK>; Mon, 23 Apr 2001 06:22:10 -0400
Received: from chiara.elte.hu ([157.181.150.200]:46860 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132659AbRDWKWE>;
	Mon, 23 Apr 2001 06:22:04 -0400
Date: Mon, 23 Apr 2001 11:20:38 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Szabolcs Szakacsits <szaka@f-secure.com>
Subject: [patch] swap-speedup-2.4.3-A1, massive swapping speedup
Message-ID: <Pine.LNX.4.30.0104231039050.3540-200000@elte.hu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="655616-1005863270-988016470=:3540"
Content-ID: <Pine.LNX.4.30.0104231101310.3796@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--655616-1005863270-988016470=:3540
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.30.0104231101311.3796@elte.hu>


background: sometime during the 2.4 cycle swapping performance and the
efficiency of the swapcache dropped significantly. I believe i finally
managed to find the problem that caused poor swapping performance and
annoying 'sudden process stoppage' symptoms.

(to those people who are experiencing swapping problems in 2.4: please try
the attached swap-speedup-2.4.3-A1 patch and let me know whether it works
& helps. The patch is against 2.4.4-pre6 or 2.4.3-ac12 and works just fine
on UP and SMP systems here.)

the problem is in lookup_swap_cache(). Per design it's a read-only,
lightweight function that just looks up the swapcache and reestablishes
the mapping if there is an entry still present. (ie. in most cases this
means that there is a fresh swapout still pending). In reality
lookup_swap_cache() did not work as intended: pages were locked in most of
the cases due to swap-out WRITEs, which caused the find_lock_page() to act
as a synchronization point - it blocked until the writeout finished. (!!!)
This is highly inefficient and undesirable - a lookup cache should not and
must not serialize with writeouts.

the reason why lookup_swap_cache() locks the page is due to a valid race,
but the solution excessive: it tries to keep the lookup atomic against
destroyers of the page, page_launder() and reclaim_page(). But it does not
really need the page lock for this - what it needs is atomicity against
swapcache updates. The same atomicity can be achieved by taking the LRU
and pagecache locks, the PageSwapCache() check is now embedded in a new
function: __find_get_swapcache_page().

the patch dramatically improves swapping performance in the tests i've
tried: swap-trashing tests that used to effectively lock the system up,
are chugging along just fine now, and the system is still more than
usable. The performance bug basically killed all good effects of the
swapcache. Swap-in latency of swapped-out processes has decreased
significantly, and overall swapping throughput has increased and
stabilized.

I'd really like to ask all MM developers to take some time to lean back
and verify current code to find similar performance bugs, instead of
trying to hack up new functionality to hide symptoms of bad design or bad
implementation. (for example there are some plans to add "avoid trashing
via process suspension" heuristics, which just work around real problems
like this one. With such code in place i'd probably never have found this
problem.) I believe we have most of the VM functionality in place to have
a world-class VM (most of which is new), what we now need is reliable and
verified behavior, not more complexity.

[ i'd also like to ask for new methods to create 'swap trashing', right
now i cannot make my system unusable via excessive swapping. (i'm
currently using the sieve.c memory trasher from Cesar Eduardo Barros, this
code used to produce the most extreme trashing load - it works just fine
now.) ]

	Ingo

--655616-1005863270-988016470=:3540
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="swap-speedup-2.4.3-A1"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0104231101100.3540@elte.hu>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="swap-speedup-2.4.3-A1"

LS0tIGxpbnV4L21tL2ZpbGVtYXAuYy5vcmlnCU1vbiBBcHIgMjMgMTM6MzU6
MDYgMjAwMQ0KKysrIGxpbnV4L21tL2ZpbGVtYXAuYwlNb24gQXByIDIzIDEz
OjM3OjA5IDIwMDENCkBAIC03MTAsNiArNzEwLDM0IEBADQogfQ0KIA0KIC8q
DQorICogRmluZCBhIHN3YXBjYWNoZSBwYWdlIChhbmQgZ2V0IGEgcmVmZXJl
bmNlKSBvciByZXR1cm4gTlVMTC4NCisgKiBUaGUgU3dhcENhY2hlIGNoZWNr
IGlzIHByb3RlY3RlZCBieSB0aGUgcGFnZWNhY2hlIGxvY2suDQorICovDQor
c3RydWN0IHBhZ2UgKiBfX2ZpbmRfZ2V0X3N3YXBjYWNoZV9wYWdlKHN0cnVj
dCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLA0KKwkJCSAgICAgIHVuc2lnbmVk
IGxvbmcgb2Zmc2V0LCBzdHJ1Y3QgcGFnZSAqKmhhc2gpDQorew0KKwlzdHJ1
Y3QgcGFnZSAqcGFnZTsNCisNCisJLyoNCisJICogV2UgbmVlZCB0aGUgTFJV
IGxvY2sgdG8gcHJvdGVjdCBhZ2FpbnN0IHBhZ2VfbGF1bmRlcigpLg0KKwkg
Ki8NCisJc3Bpbl9sb2NrKCZwYWdlY2FjaGVfbG9jayk7DQorCXNwaW5fbG9j
aygmcGFnZW1hcF9scnVfbG9jayk7DQorDQorCXBhZ2UgPSBfX2ZpbmRfcGFn
ZV9ub2xvY2sobWFwcGluZywgb2Zmc2V0LCAqaGFzaCk7DQorCWlmIChwYWdl
KSB7DQorCQlpZiAoUGFnZVN3YXBDYWNoZShwYWdlKSkNCisJCQlwYWdlX2Nh
Y2hlX2dldChwYWdlKTsNCisJCWVsc2UNCisJCQlwYWdlID0gTlVMTDsNCisJ
fQ0KKwlzcGluX3VubG9jaygmcGFnZW1hcF9scnVfbG9jayk7DQorCXNwaW5f
dW5sb2NrKCZwYWdlY2FjaGVfbG9jayk7DQorDQorCXJldHVybiBwYWdlOw0K
K30NCisNCisvKg0KICAqIFNhbWUgYXMgdGhlIGFib3ZlLCBidXQgbG9jayB0
aGUgcGFnZSB0b28sIHZlcmlmeWluZyB0aGF0DQogICogaXQncyBzdGlsbCB2
YWxpZCBvbmNlIHdlIG93biBpdC4NCiAgKi8NCi0tLSBsaW51eC9tbS9zd2Fw
X3N0YXRlLmMub3JpZwlNb24gQXByIDIzIDEzOjM1OjA2IDIwMDENCisrKyBs
aW51eC9tbS9zd2FwX3N0YXRlLmMJTW9uIEFwciAyMyAxMzozNzowMSAyMDAx
DQpAQCAtMTYzLDM3ICsxNjMsMTggQEANCiAJCS8qDQogCQkgKiBSaWdodCBu
b3cgdGhlIHBhZ2VjYWNoZSBpcyAzMi1iaXQgb25seS4gIEJ1dCBpdCdzIGEg
MzIgYml0IGluZGV4LiA9KQ0KIAkJICovDQotcmVwZWF0Og0KLQkJZm91bmQg
PSBmaW5kX2xvY2tfcGFnZSgmc3dhcHBlcl9zcGFjZSwgZW50cnkudmFsKTsN
CisJCWZvdW5kID0gZmluZF9nZXRfc3dhcGNhY2hlX3BhZ2UoJnN3YXBwZXJf
c3BhY2UsIGVudHJ5LnZhbCk7DQogCQlpZiAoIWZvdW5kKQ0KIAkJCXJldHVy
biAwOw0KLQkJLyoNCi0JCSAqIFRob3VnaCB0aGUgImZvdW5kIiBwYWdlIHdh
cyBpbiB0aGUgc3dhcCBjYWNoZSBhbiBpbnN0YW50DQotCQkgKiBlYXJsaWVy
LCBpdCBtaWdodCBoYXZlIGJlZW4gcmVtb3ZlZCBieSByZWZpbGxfaW5hY3Rp
dmUgZXRjLg0KLQkJICogUmUgc2VhcmNoIC4uLiBTaW5jZSBmaW5kX2xvY2tf
cGFnZSBncmFicyBhIHJlZmVyZW5jZSBvbg0KLQkJICogdGhlIHBhZ2UsIGl0
IGNhbiBub3QgYmUgcmV1c2VkIGZvciBhbnl0aGluZyBlbHNlLCBuYW1lbHkN
Ci0JCSAqIGl0IGNhbiBub3QgYmUgYXNzb2NpYXRlZCB3aXRoIGFub3RoZXIg
c3dhcGhhbmRsZSwgc28gaXQNCi0JCSAqIGlzIGVub3VnaCB0byBjaGVjayB3
aGV0aGVyIHRoZSBwYWdlIGlzIHN0aWxsIGluIHRoZSBzY2FjaGUuDQotCQkg
Ki8NCi0JCWlmICghUGFnZVN3YXBDYWNoZShmb3VuZCkpIHsNCi0JCQlVbmxv
Y2tQYWdlKGZvdW5kKTsNCi0JCQlwYWdlX2NhY2hlX3JlbGVhc2UoZm91bmQp
Ow0KLQkJCWdvdG8gcmVwZWF0Ow0KLQkJfQ0KKwkJaWYgKCFQYWdlU3dhcENh
Y2hlKGZvdW5kKSkNCisJCQlCVUcoKTsNCiAJCWlmIChmb3VuZC0+bWFwcGlu
ZyAhPSAmc3dhcHBlcl9zcGFjZSkNCi0JCQlnb3RvIG91dF9iYWQ7DQorCQkJ
QlVHKCk7DQogI2lmZGVmIFNXQVBfQ0FDSEVfSU5GTw0KIAkJc3dhcF9jYWNo
ZV9maW5kX3N1Y2Nlc3MrKzsNCiAjZW5kaWYNCi0JCVVubG9ja1BhZ2UoZm91
bmQpOw0KIAkJcmV0dXJuIGZvdW5kOw0KIAl9DQotDQotb3V0X2JhZDoNCi0J
cHJpbnRrIChLRVJOX0VSUiAiVk06IEZvdW5kIGEgbm9uLXN3YXBwZXIgc3dh
cCBwYWdlIVxuIik7DQotCVVubG9ja1BhZ2UoZm91bmQpOw0KLQlwYWdlX2Nh
Y2hlX3JlbGVhc2UoZm91bmQpOw0KLQlyZXR1cm4gMDsNCiB9DQogDQogLyog
DQotLS0gbGludXgvaW5jbHVkZS9saW51eC9wYWdlbWFwLmgub3JpZwlNb24g
QXByIDIzIDEzOjM1OjA1IDIwMDENCisrKyBsaW51eC9pbmNsdWRlL2xpbnV4
L3BhZ2VtYXAuaAlNb24gQXByIDIzIDEzOjM3OjAxIDIwMDENCkBAIC03Nyw3
ICs3NywxMiBAQA0KIAkJCQl1bnNpZ25lZCBsb25nIGluZGV4LCBzdHJ1Y3Qg
cGFnZSAqKmhhc2gpOw0KIGV4dGVybiB2b2lkIGxvY2tfcGFnZShzdHJ1Y3Qg
cGFnZSAqcGFnZSk7DQogI2RlZmluZSBmaW5kX2xvY2tfcGFnZShtYXBwaW5n
LCBpbmRleCkgXA0KLQkJX19maW5kX2xvY2tfcGFnZShtYXBwaW5nLCBpbmRl
eCwgcGFnZV9oYXNoKG1hcHBpbmcsIGluZGV4KSkNCisJX19maW5kX2xvY2tf
cGFnZShtYXBwaW5nLCBpbmRleCwgcGFnZV9oYXNoKG1hcHBpbmcsIGluZGV4
KSkNCisNCitleHRlcm4gc3RydWN0IHBhZ2UgKiBfX2ZpbmRfZ2V0X3N3YXBj
YWNoZV9wYWdlIChzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqIG1hcHBpbmcsDQor
CQkJCXVuc2lnbmVkIGxvbmcgaW5kZXgsIHN0cnVjdCBwYWdlICoqaGFzaCk7
DQorI2RlZmluZSBmaW5kX2dldF9zd2FwY2FjaGVfcGFnZShtYXBwaW5nLCBp
bmRleCkgXA0KKwlfX2ZpbmRfZ2V0X3N3YXBjYWNoZV9wYWdlKG1hcHBpbmcs
IGluZGV4LCBwYWdlX2hhc2gobWFwcGluZywgaW5kZXgpKQ0KIA0KIGV4dGVy
biB2b2lkIF9fYWRkX3BhZ2VfdG9faGFzaF9xdWV1ZShzdHJ1Y3QgcGFnZSAq
IHBhZ2UsIHN0cnVjdCBwYWdlICoqcCk7DQogDQo=
--655616-1005863270-988016470=:3540--
