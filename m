Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261454AbRE0TDg>; Sun, 27 May 2001 15:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261486AbRE0TD0>; Sun, 27 May 2001 15:03:26 -0400
Received: from chiara.elte.hu ([157.181.150.200]:43272 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S261454AbRE0TDV>;
	Sun, 27 May 2001 15:03:21 -0400
Date: Sun, 27 May 2001 21:00:35 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "David S. Miller" <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: [patch] softirq-2.4.5-B0
In-Reply-To: <15120.16986.610478.279574@pizda.ninka.net>
Message-ID: <Pine.LNX.4.33.0105271020310.1667-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-739968658-990990035=:5852"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-739968658-990990035=:5852
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Sat, 26 May 2001, David S. Miller wrote:

> And looking at the x86 code, I don't even understand how your fixes
> can make a difference, what about the do_softirq() call in
> arch/i386/kernel/irq.c:do_IRQ()??? [...]

[you are right, it's a brain fart on my part. doh. i guess i was too happy
having fixed the longstanding latency problem.]

the TCP latency issues and the missed softirq execution bug is still
there, but for a slightly different reason.

the bug/misbehavior causing bad latencies turned out to be the following:
if a hardirq triggers a softirq, but syscall-level code on the same CPU
disabled local bhs via local_bh_disable(), then we 'miss' the execution of
the softirq, until the next IRQ. (or next direct call to do_softirq()).

the attached softirq-2.4.5-B0 patch fixes this problem by calling
do_softirq()  from local_bh_enable() [if the bh count is 0, to avoid
recursion]. This slightly changes local_bh_enable() semantics: calling
do_softirq() has the side-effect of disabling/enabling interrupts, so code
that used local_bh_enable while interrupts are disabled (and depended on
them staying disabled) will break. I checked all code that uses
local_bh_enable() via a debugging check, and the only (harmless) violation
of this new rule is machine_restart() in the x86 tree.

Yesterday's patches fix this problem too, but only as a lucky side-effect,
and only in the idle-poll case. 2.4.5 + softirq-2.4.5-B0 TCP latency is
down from a fluctuating 300-400 microseconds to a stable 109 microseconds.

	Ingo

--8323328-739968658-990990035=:5852
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="softirq-2.4.5-B0"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0105272100350.5852@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="softirq-2.4.5-B0"

LS0tIGxpbnV4L2tlcm5lbC9zb2Z0aXJxLmMub3JpZwlTdW4gTWF5IDI3IDIw
OjU3OjM2IDIwMDENCisrKyBsaW51eC9rZXJuZWwvc29mdGlycS5jCVN1biBN
YXkgMjcgMjA6NTc6NTIgMjAwMQ0KQEAgLTg3LDcgKzg3LDcgQEANCiAJCQln
b3RvIHJldHJ5Ow0KIAl9DQogDQotCWxvY2FsX2JoX2VuYWJsZSgpOw0KKwlf
X2xvY2FsX2JoX2VuYWJsZSgpOw0KIA0KIAkvKiBMZWF2ZSB3aXRoIGxvY2Fs
bHkgZGlzYWJsZWQgaGFyZCBpcnFzLiBJdCBpcyBjcml0aWNhbCB0byBjbG9z
ZQ0KIAkgKiB3aW5kb3cgZm9yIGluZmluaXRlIHJlY3Vyc2lvbiwgd2hpbGUg
d2UgaGVscCBsb2NhbCBiaCBjb3VudCwNCi0tLSBsaW51eC9pbmNsdWRlL2Fz
bS1pMzg2L3NvZnRpcnEuaC5vcmlnCVN1biBNYXkgMjcgMjA6NTY6NTggMjAw
MQ0KKysrIGxpbnV4L2luY2x1ZGUvYXNtLWkzODYvc29mdGlycS5oCVN1biBN
YXkgMjcgMjA6NTg6MTUgMjAwMQ0KQEAgLTUsMTAgKzUsMTIgQEANCiAjaW5j
bHVkZSA8YXNtL2hhcmRpcnEuaD4NCiANCiAjZGVmaW5lIGNwdV9iaF9kaXNh
YmxlKGNwdSkJZG8geyBsb2NhbF9iaF9jb3VudChjcHUpKys7IGJhcnJpZXIo
KTsgfSB3aGlsZSAoMCkNCi0jZGVmaW5lIGNwdV9iaF9lbmFibGUoY3B1KQlk
byB7IGJhcnJpZXIoKTsgbG9jYWxfYmhfY291bnQoY3B1KS0tOyB9IHdoaWxl
ICgwKQ0KKyNkZWZpbmUgX19jcHVfYmhfZW5hYmxlKGNwdSkJZG8geyBiYXJy
aWVyKCk7IGxvY2FsX2JoX2NvdW50KGNwdSktLTsgfSB3aGlsZSAoMCkNCitl
eHRlcm4gdm9pZCBjcHVfYmhfZW5hYmxlICh1bnNpZ25lZCBpbnQgY3B1KTsN
CiANCiAjZGVmaW5lIGxvY2FsX2JoX2Rpc2FibGUoKQljcHVfYmhfZGlzYWJs
ZShzbXBfcHJvY2Vzc29yX2lkKCkpDQogI2RlZmluZSBsb2NhbF9iaF9lbmFi
bGUoKQljcHVfYmhfZW5hYmxlKHNtcF9wcm9jZXNzb3JfaWQoKSkNCisjZGVm
aW5lIF9fbG9jYWxfYmhfZW5hYmxlKCkJX19jcHVfYmhfZW5hYmxlKHNtcF9w
cm9jZXNzb3JfaWQoKSkNCiANCiAjZGVmaW5lIGluX3NvZnRpcnEoKSAobG9j
YWxfYmhfY291bnQoc21wX3Byb2Nlc3Nvcl9pZCgpKSAhPSAwKQ0KIA0KLS0t
IGxpbnV4L2FyY2gvaTM4Ni9rZXJuZWwvaXJxLmMub3JpZwlTdW4gTWF5IDI3
IDIwOjU1OjA4IDIwMDENCisrKyBsaW51eC9hcmNoL2kzODYva2VybmVsL2ly
cS5jCVN1biBNYXkgMjcgMjA6NTY6NDUgMjAwMQ0KQEAgLTYyOCw2ICs2Mjgs
MTkgQEANCiAJcmV0dXJuIDE7DQogfQ0KIA0KKy8qDQorICogQSBiaC1hdG9t
aWMgc2VjdGlvbiBtaWdodCBoYXZlIGJsb2NrZWQgdGhlIGV4ZWN1dGlvbiBv
ZiBzb2Z0aXJxcy4NCisgKiByZS1ydW4gdGhlbSBpZiBhcHByb3ByaWF0ZS4N
CisgKi8NCit2b2lkIGNwdV9iaF9lbmFibGUgKHVuc2lnbmVkIGludCBjcHUp
DQorew0KKwlpZiAoIS0tbG9jYWxfYmhfY291bnQoY3B1KSAmJg0KKwkJCShz
b2Z0aXJxX2FjdGl2ZShjcHUpICYgc29mdGlycV9tYXNrKGNwdSkpKSB7DQor
CQlkb19zb2Z0aXJxKCk7DQorCQlfX3N0aSgpOw0KKwl9DQorfQ0KKw0KIC8q
Kg0KICAqCXJlcXVlc3RfaXJxIC0gYWxsb2NhdGUgYW4gaW50ZXJydXB0IGxp
bmUNCiAgKglAaXJxOiBJbnRlcnJ1cHQgbGluZSB0byBhbGxvY2F0ZQ0K
--8323328-739968658-990990035=:5852--
