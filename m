Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUBXAtG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 19:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbUBXAtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 19:49:06 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:63890 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S262114AbUBXAqi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 19:46:38 -0500
Date: Mon, 23 Feb 2004 19:46:35 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Daniel Ritz <daniel.ritz@gmx.ch>, Andrew Morton <akpm@osdl.org>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] yenta: irq-routing for TI bridges
In-Reply-To: <20040224000051.C25358@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0402231920110.30605@marabou.research.att.com>
References: <200402240033.31042.daniel.ritz@gmx.ch> <20040224000051.C25358@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-748924038-1077583521=:30605"
Content-ID: <Pine.LNX.4.58.0402231945250.30605@marabou.research.att.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-748924038-1077583521=:30605
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.58.0402231945251.30605@marabou.research.att.com>

On Tue, 24 Feb 2004, Russell King wrote:

> On Tue, Feb 24, 2004 at 12:33:31AM +0100, Daniel Ritz wrote:
> > this patch should fix up wrongly initialized TI bridges. in a safe way
> > (hopefully).
>
> Unfortunately not.

I admire your ability to see problems so fast.

Could you please look at my patch that I posted many times (attached
again)?  It's much simpler than the one by Daniel.

First of all, it removes the old attempts to fix the TI issue.  You can
always leave them intact if you want.

The fixup is applied is following conditions are met:

1) The card is a ti12xx or newer.  If older cards need any fixups, they
are going to be different.  Such cards don't have irqmux.

2) No ISA interrupts were detected.  That is, we are not breaking working
systems with ISA or serial ISA interrupts.

3) irqmux (the 32 bit value) is 0.  This value is not compatible with
working PCI interrupts.  Also, being 0 is a sign that irqmux wasn't
initialized from EEPROM.

Those conditions, if implemented properly (I hope so) mean that we are not
breaking existing functionality.

My testing shows that this patch fixes interrupts on certain TI PCI1410
cards with one slot.  I believe they have EEPROM but cannot be programmed.
I actually tried that and I can describe my attempts in more details in a
separate thread.

I also have a two-slot TI PCI1221 card, but it has proper irqmux and
doesn't need any fixups.

If any two-slot TI card needs to be supported, it can be done.  Most
likely this patch will set up interrupts at least for one of the slots,
which is good already.  I don't trust my skills to code from specs without
testing, so it's quite deliberate that the code makes no attempts to
support the second slot.  I can do it using the pcmcia-cs i82365 driver as
the starting point.

Please let me know what I can do make the kernel support TI PCI1410
bridges.  I have a lot of them on many systems, and it's quite an
annoyance to patch the kernel every time for each of those systems.  I'm
ready to put efforts into fixing this problem permanently.

-- 
Regards,
Pavel Roskin
--8323328-748924038-1077583521=:30605
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="ti_irq.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0402231945210.30605@marabou.research.att.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="ti_irq.diff"

LS0tIGxpbnV4Lm9yaWcvZHJpdmVycy9wY21jaWEvdGkxMTN4LmgNCisrKyBs
aW51eC9kcml2ZXJzL3BjbWNpYS90aTExM3guaA0KQEAgLTI4MSwzMyArMjgx
LDYgQEAgc3RhdGljIGludCB0aV9vdmVycmlkZShzdHJ1Y3QgeWVudGFfc29j
aw0KIA0KIAl0aV9zZXRfenYoc29ja2V0KTsNCiANCi0jaWYgMA0KLQkvKg0K
LQkgKiBJZiBJU0EgaW50ZXJydXB0cyBkb24ndCB3b3JrLCB0aGVuIGZhbGwg
YmFjayB0byByb3V0aW5nIGNhcmQNCi0JICogaW50ZXJydXB0cyB0byB0aGUg
UENJIGludGVycnVwdCBvZiB0aGUgc29ja2V0Lg0KLQkgKg0KLQkgKiBUd2Vh
a2luZyB0aGlzIHdoZW4gd2UgYXJlIHVzaW5nIHNlcmlhbCBQQ0kgSVJRcyBj
YXVzZXMgaGFuZ3MNCi0JICogICAtLXJtaw0KLQkgKi8NCi0JaWYgKCFzb2Nr
ZXQtPnNvY2tldC5pcnFfbWFzaykgew0KLQkJdTggaXJxbXV4LCBkZXZjdGw7
DQotDQotCQlkZXZjdGwgPSBjb25maWdfcmVhZGIoc29ja2V0LCBUSTExM1hf
REVWSUNFX0NPTlRST0wpOw0KLQkJaWYgKChkZXZjdGwgJiBUSTExM1hfRENS
X0lNT0RFX01BU0spICE9IFRJMTJYWF9EQ1JfSU1PREVfQUxMX1NFUklBTCkg
ew0KLQkJCXByaW50ayAoS0VSTl9JTkZPICJ0aTExM3g6IFJvdXRpbmcgY2Fy
ZCBpbnRlcnJ1cHRzIHRvIFBDSVxuIik7DQotDQotCQkJZGV2Y3RsICY9IH5U
STExM1hfRENSX0lNT0RFX01BU0s7DQotDQotCQkJaXJxbXV4ID0gY29uZmln
X3JlYWRsKHNvY2tldCwgVEkxMjJYX0lSUU1VWCk7DQotCQkJaXJxbXV4ID0g
KGlycW11eCAmIH4weDBmKSB8IDB4MDI7IC8qIHJvdXRlIElOVEEgKi8NCi0J
CQlpcnFtdXggPSAoaXJxbXV4ICYgfjB4ZjApIHwgMHgyMDsgLyogcm91dGUg
SU5UQiAqLw0KLQ0KLQkJCWNvbmZpZ193cml0ZWwoc29ja2V0LCBUSTEyMlhf
SVJRTVVYLCBpcnFtdXgpOw0KLQkJCWNvbmZpZ193cml0ZWIoc29ja2V0LCBU
STExM1hfREVWSUNFX0NPTlRST0wsIGRldmN0bCk7DQotCQl9DQotCX0NCi0j
ZW5kaWYNCi0NCiAJcmV0dXJuIDA7DQogfQ0KIA0KQEAgLTM0Nyw2ICszMjAs
MzMgQEAgc3RhdGljIGludCB0aTEyeHhfb3ZlcnJpZGUoc3RydWN0IHllbnRh
Xw0KIAlwcmludGsoS0VSTl9JTkZPICJZZW50YTogUm91dGluZyBDYXJkQnVz
IGludGVycnVwdHMgdG8gJXNcbiIsDQogCQkodmFsICYgVEkxMjUwX0RJQUdf
UENJX0lSRVEpID8gIlBDSSIgOiAiSVNBIik7DQogDQorCS8qDQorCSAqIElm
IElTQSBpbnRlcnJ1cHRzIGRvbid0IHdvcmssIGZhbGwgYmFjayB0byByb3V0
aW5nIGNhcmQNCisJICogaW50ZXJydXB0cyB0byB0aGUgUENJIGJ1cy4gIE9u
bHkgZG8gaXQgaWYgbXVsdGlmdW5jdGlvbg0KKwkgKiByb3V0aW5nIHJlZ2lz
dGVyIChpcnFtdXgpIGlzIGluIHRoZSBkZWZhdWx0IHN0YXRlLCBpLmUuDQor
CSAqIHRoZSBjYXJkIHdhc24ndCBpbml0aWFsaXplZC4NCisJICovDQorCWlm
ICghc29ja2V0LT5zb2NrZXQuaXJxX21hc2spIHsNCisJCXUzMiBpcnFtdXg7
DQorDQorCQlpcnFtdXggPSBjb25maWdfcmVhZGwoc29ja2V0LCBUSTEyMlhf
SVJRTVVYKTsNCisNCisJCWlmIChpcnFtdXggPT0gMCkgew0KKwkJCXU4IGRl
dmN0bDsNCisNCisJCQlwcmludGsgKEtFUk5fSU5GTyAidGkxMTN4OiBVbmlu
aXRpYWxpemVkIElSUSByb3V0aW5nICINCisJCQkJImRldGVjdGVkLCBlbmFi
bGluZyBQQ0kgaW50ZXJydXB0c1xuIik7DQorDQorCQkJLyogUm91dGUgSU5U
QSB0byBNRlVOQzAgKi8NCisJCQljb25maWdfd3JpdGVsKHNvY2tldCwgVEkx
MjJYX0lSUU1VWCwgMHgwMik7DQorDQorCQkJLyogRW5hYmxlIHBhcmFsbGVs
IFBDSSBpbnRlcnJ1cHRzICovDQorCQkJZGV2Y3RsID0gY29uZmlnX3JlYWRi
KHNvY2tldCwgVEkxMTNYX0RFVklDRV9DT05UUk9MKTsNCisJCQlkZXZjdGwg
Jj0gflRJMTEzWF9EQ1JfSU1PREVfTUFTSzsNCisJCQljb25maWdfd3JpdGVi
KHNvY2tldCwgVEkxMTNYX0RFVklDRV9DT05UUk9MLCBkZXZjdGwpOw0KKwkJ
fQ0KKwl9DQorDQogCXJldHVybiB0aV9vdmVycmlkZShzb2NrZXQpOw0KIH0N
CiANCkBAIC0zNjYsMjYgKzM2Niw2IEBAIHN0YXRpYyBpbnQgdGkxMjUwX292
ZXJyaWRlKHN0cnVjdCB5ZW50YV8NCiAJCWNvbmZpZ193cml0ZWIoc29ja2V0
LCBUSTEyNTBfRElBR05PU1RJQywgZGlhZyk7DQogCX0NCiANCi0jaWYgMA0K
LQkvKg0KLQkgKiBUaGlzIGlzIGhpZ2hseSBtYWNoaW5lIHNwZWNpZmljLCBh
bmQgd2Ugc2hvdWxkIE5PVCB0b3VjaA0KLQkgKiB0aGlzIHJlZ2lzdGVyIC0g
d2UgaGF2ZSBubyBrbm93bGVkZ2UgaG93IHRoZSBoYXJkd2FyZQ0KLQkgKiBp
cyBhY3R1YWxseSB3aXJlZC4NCi0JICoNCi0JICogSWYgd2UncmUgZ29pbmcg
dG8gZG8gdGhpcywgd2Ugc2hvdWxkIHByb2JhYmx5IGxvb2sgaW50bw0KLQkg
KiB1c2luZyB0aGUgc3Vic3lzdGVtIElEcy4NCi0JICoNCi0JICogT24gVGhp
bmtQYWQgMzgwWEQsIHRoaXMgY2hhbmdlcyBNRlVOQzAgZnJvbSB0aGUgSVNB
IElSUTMNCi0JICogb3V0cHV0ICh3aGljaCBpdCBpcykgdG8gSVJRMi4gIFdl
IGFsc28gY2hhbmdlIE1GVU5DMQ0KLQkgKiBmcm9tIElTQSBJUlE0IHRvIElS
UTYuDQotCSAqLw0KLQlpcnFtdXggPSBjb25maWdfcmVhZGwoc29ja2V0LCBU
STEyMlhfSVJRTVVYKTsNCi0JaXJxbXV4ID0gKGlycW11eCAmIH4weDBmKSB8
IDB4MDI7IC8qIHJvdXRlIElOVEEgKi8NCi0JaWYgKCEodGlfc3lzY3RsKHNv
Y2tldCkgJiBUSTEyMlhfU0NSX0lOVFJUSUUpKQ0KLQkJaXJxbXV4ID0gKGly
cW11eCAmIH4weGYwKSB8IDB4MjA7IC8qIHJvdXRlIElOVEIgKi8NCi0JY29u
ZmlnX3dyaXRlbChzb2NrZXQsIFRJMTIyWF9JUlFNVVgsIGlycW11eCk7DQot
I2VuZGlmDQotDQogCXJldHVybiB0aTEyeHhfb3ZlcnJpZGUoc29ja2V0KTsN
CiB9DQogDQo=

--8323328-748924038-1077583521=:30605--
