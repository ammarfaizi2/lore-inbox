Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280786AbRKSX6l>; Mon, 19 Nov 2001 18:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280787AbRKSX6X>; Mon, 19 Nov 2001 18:58:23 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22795 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280786AbRKSX6A>; Mon, 19 Nov 2001 18:58:00 -0500
Date: Mon, 19 Nov 2001 15:52:44 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ken Brownfield <brownfld@irridia.com>
cc: <linux-kernel@vger.kernel.org>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [VM] 2.4.14/15-pre4 too "swap-happy"?
In-Reply-To: <20011119173935.A10597@asooo.flowerfire.com>
Message-ID: <Pine.LNX.4.33.0111191543390.19585-200000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="168447515-340658433-1006213964=:19585"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--168447515-340658433-1006213964=:19585
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Mon, 19 Nov 2001, Ken Brownfield wrote:
>
> I went straight to the aa patch, and it looks like it either fixes the
> problem or (because of the side-effects Linus mentioned) otherwise
> prevents the issue:

So is this pre6aa1, or pre6 + just the watermark patch?

> The machine went into swap immediately when the page cache stopped
> growing and hovered at 100-400MB.  Also, in my experience the page cache
> will grow until there's only 5ishMB of free RAM, but with the aa patch
> it looks like it stops at 320MB or maybe 10% of RAM.  Was that the aa
> patch, or part of -pre6?

That was the watermarking. The way Andrea did it, the page cache will
basically refuse to touch as much of the "normal" page zone, because it
would prefer to allocate more from highmem..

I think it's excessive to have 320MB free memory, though, that's just
an insane waste. I suspect that the real number should be somewhere
between the old behaviour and the new one. You can tweak the behaviour of
andrea's kernel by changing the "reserved" page numbers, but I'd like to
hear whether my simpler approach works too..

> The Oracle SGA is set to ~522MB, with nothing else running except a
> couple of sshds, getty, etc.  Now that I'm looking, 2.8GB page cache
> plus 328MB free adds up to about 3.1GB of RAM -- where does the 512MB
> shared memory segment fit?  Is it being swapped out in deference to page
> cache?

Shared memory actually uses the page cache too, so it will be accounted
for in the 2.8GB number.

Anyway, can you try plain vanilla pre6, with the appended patch? This is
my suggested simplified version of what Andrea tried to do, and it should
try to keep only a few extra megs of memory free in the low memory
regions, not 300+ MB.

(and the profiling would be interesting regardless, but I think Andrea did
find the real problem, his fix just seems a bit of an overkill ;)

		Linus

--168447515-340658433-1006213964=:19585
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=p6p7
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0111191552440.19585@penguin.transmeta.com>
Content-Description: 
Content-Disposition: attachment; filename=p6p7

ZGlmZiAtdSAtLXJlY3Vyc2l2ZSAtLW5ldy1maWxlIHByZTYvbGludXgvbW0v
cGFnZV9hbGxvYy5jIGxpbnV4L21tL3BhZ2VfYWxsb2MuYw0KLS0tIHByZTYv
bGludXgvbW0vcGFnZV9hbGxvYy5jCVNhdCBOb3YgMTcgMTk6MDc6NDMgMjAw
MQ0KKysrIGxpbnV4L21tL3BhZ2VfYWxsb2MuYwlNb24gTm92IDE5IDE1OjEz
OjM2IDIwMDENCkBAIC0yOTksMjkgKzI5OSwyNiBAQA0KIAlyZXR1cm4gcGFn
ZTsNCiB9DQogDQotc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIHpvbmVf
ZnJlZV9wYWdlcyh6b25lX3QgKiB6b25lLCB1bnNpZ25lZCBpbnQgb3JkZXIp
DQotew0KLQlsb25nIGZyZWUgPSB6b25lLT5mcmVlX3BhZ2VzIC0gKDFVTCA8
PCBvcmRlcik7DQotCXJldHVybiBmcmVlID49IDAgPyBmcmVlIDogMDsNCi19
DQotDQogLyoNCiAgKiBUaGlzIGlzIHRoZSAnaGVhcnQnIG9mIHRoZSB6b25l
ZCBidWRkeSBhbGxvY2F0b3I6DQogICovDQogc3RydWN0IHBhZ2UgKiBfX2Fs
bG9jX3BhZ2VzKHVuc2lnbmVkIGludCBnZnBfbWFzaywgdW5zaWduZWQgaW50
IG9yZGVyLCB6b25lbGlzdF90ICp6b25lbGlzdCkNCiB7DQorCXVuc2lnbmVk
IGxvbmcgbWluOw0KIAl6b25lX3QgKip6b25lLCAqIGNsYXNzem9uZTsNCiAJ
c3RydWN0IHBhZ2UgKiBwYWdlOw0KIAlpbnQgZnJlZWQ7DQogDQogCXpvbmUg
PSB6b25lbGlzdC0+em9uZXM7DQogCWNsYXNzem9uZSA9ICp6b25lOw0KKwlt
aW4gPSAxVUwgPDwgb3JkZXI7DQogCWZvciAoOzspIHsNCiAJCXpvbmVfdCAq
eiA9ICooem9uZSsrKTsNCiAJCWlmICgheikNCiAJCQlicmVhazsNCiANCi0J
CWlmICh6b25lX2ZyZWVfcGFnZXMoeiwgb3JkZXIpID4gei0+cGFnZXNfbG93
KSB7DQorCQltaW4gKz0gei0+cGFnZXNfbG93Ow0KKwkJaWYgKHotPmZyZWVf
cGFnZXMgPiBtaW4pIHsNCiAJCQlwYWdlID0gcm1xdWV1ZSh6LCBvcmRlcik7
DQogCQkJaWYgKHBhZ2UpDQogCQkJCXJldHVybiBwYWdlOw0KQEAgLTMzNCwx
NiArMzMxLDE4IEBADQogCQl3YWtlX3VwX2ludGVycnVwdGlibGUoJmtzd2Fw
ZF93YWl0KTsNCiANCiAJem9uZSA9IHpvbmVsaXN0LT56b25lczsNCisJbWlu
ID0gMVVMIDw8IG9yZGVyOw0KIAlmb3IgKDs7KSB7DQotCQl1bnNpZ25lZCBs
b25nIG1pbjsNCisJCXVuc2lnbmVkIGxvbmcgbG9jYWxfbWluOw0KIAkJem9u
ZV90ICp6ID0gKih6b25lKyspOw0KIAkJaWYgKCF6KQ0KIAkJCWJyZWFrOw0K
IA0KLQkJbWluID0gei0+cGFnZXNfbWluOw0KKwkJbG9jYWxfbWluID0gei0+
cGFnZXNfbWluOw0KIAkJaWYgKCEoZ2ZwX21hc2sgJiBfX0dGUF9XQUlUKSkN
Ci0JCQltaW4gPj49IDI7DQotCQlpZiAoem9uZV9mcmVlX3BhZ2VzKHosIG9y
ZGVyKSA+IG1pbikgew0KKwkJCWxvY2FsX21pbiA+Pj0gMjsNCisJCW1pbiAr
PSBsb2NhbF9taW47DQorCQlpZiAoei0+ZnJlZV9wYWdlcyA+IG1pbikgew0K
IAkJCXBhZ2UgPSBybXF1ZXVlKHosIG9yZGVyKTsNCiAJCQlpZiAocGFnZSkN
CiAJCQkJcmV0dXJuIHBhZ2U7DQpAQCAtMzc2LDEyICszNzUsMTQgQEANCiAJ
CXJldHVybiBwYWdlOw0KIA0KIAl6b25lID0gem9uZWxpc3QtPnpvbmVzOw0K
KwltaW4gPSAxVUwgPDwgb3JkZXI7DQogCWZvciAoOzspIHsNCiAJCXpvbmVf
dCAqeiA9ICooem9uZSsrKTsNCiAJCWlmICgheikNCiAJCQlicmVhazsNCiAN
Ci0JCWlmICh6b25lX2ZyZWVfcGFnZXMoeiwgb3JkZXIpID4gei0+cGFnZXNf
bWluKSB7DQorCQltaW4gKz0gei0+cGFnZXNfbWluOw0KKwkJaWYgKHotPmZy
ZWVfcGFnZXMgPiBtaW4pIHsNCiAJCQlwYWdlID0gcm1xdWV1ZSh6LCBvcmRl
cik7DQogCQkJaWYgKHBhZ2UpDQogCQkJCXJldHVybiBwYWdlOw0K
--168447515-340658433-1006213964=:19585--
