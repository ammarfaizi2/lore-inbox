Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263488AbRFFIJ6>; Wed, 6 Jun 2001 04:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263491AbRFFIJs>; Wed, 6 Jun 2001 04:09:48 -0400
Received: from chiara.elte.hu ([157.181.150.200]:61969 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S263488AbRFFIJc>;
	Wed, 6 Jun 2001 04:09:32 -0400
Date: Wed, 6 Jun 2001 10:06:42 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [patch] softirq-2.4.6-B4
In-Reply-To: <Pine.LNX.4.31.0106051850180.1990-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0106060935160.1712-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-593323588-991814802=:1712"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-593323588-991814802=:1712
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Tue, 5 Jun 2001, Linus Torvalds wrote:

> entry.S:
>
> +       xorl %ecx,%ecx; \
>         testl SYMBOL_NAME(irq_stat)+4(,%eax),%ecx

oops, bogus indeed.

the softirq checks in entry.S are now obsolete and i've removed them in
-C2 completely. (this also explains why this 'dummy' entry.S code had no
effect on performance and stability.) Any code that can somehow end up
delaying softirqs is supposed to restart them explicitly.

this should at least somewhat reduce the cost of having to add a cli to
the need_resched and sigpending checks.

we could avoid the cli in the syscall path by putting an additional check
into the IRQ path: we can check the interrupted EIP and fix up the return
EIP if we interrupted the 'critical path'. (since the window is small,
this check would be triggered rarely.) [the idea is not mine, i think it
came from Chris Evans, and the code is included in the lowlatency
patches.]

>    (The "cli" may help the need_resched thing, but I doubt it matters, and
>    if that's what you're trying to do then you should move it there,
>    instead of having it at the softirq place).

yes, it was there partly for need_resched and sigpending purposes as well,
so a cli before the need_resched and sigpending checks is still needed.

the attached softirq-2.4.6-C2 patch (relative to -B4) has another change
as well:

- to make the local_bh_enable() softirq-check even more lightweight, on
  x86 i've moved parts of it into asssembly, with the slow path moved into
  an offline section. The assembly code does not mark any register as
  clobbered to reduce the register-saving overhead, so it has to save
  %eax, %ecx and %edx prior calling do_softirq().

  in -C2 a softirq-restart check is straight fall-through code with two
  untaken forward-pointing branches, which should put the cost of the
  common softirq check on the order of 1-2 cycles. (plus the unavoidable
  icache footprint increase.)

(the patch has been sanity compiled & booted on both UP and SMP x86.)

	Ingo

--8323328-593323588-991814802=:1712
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="softirq-2.4.6-C2"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0106061006420.1712@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="softirq-2.4.6-C2"

LS0tIGxpbnV4L2luY2x1ZGUvYXNtLWkzODYvc29mdGlycS5oLm9yaWcJV2Vk
IEp1biAgNiAwODo1MTo1NCAyMDAxDQorKysgbGludXgvaW5jbHVkZS9hc20t
aTM4Ni9zb2Z0aXJxLmgJV2VkIEp1biAgNiAwOToxNjoyNiAyMDAxDQpAQCAt
MTEsMTAgKzExLDM5IEBADQogDQogI2RlZmluZSBsb2NhbF9iaF9kaXNhYmxl
KCkJY3B1X2JoX2Rpc2FibGUoc21wX3Byb2Nlc3Nvcl9pZCgpKQ0KICNkZWZp
bmUgX19sb2NhbF9iaF9lbmFibGUoKQlfX2NwdV9iaF9lbmFibGUoc21wX3By
b2Nlc3Nvcl9pZCgpKQ0KLSNkZWZpbmUgbG9jYWxfYmhfZW5hYmxlKCkJZG8g
eyBpbnQgX19jcHUgPSBzbXBfcHJvY2Vzc29yX2lkKCk7IGlmICghLS1sb2Nh
bF9iaF9jb3VudChfX2NwdSkgJiYgc29mdGlycV9wZW5kaW5nKF9fY3B1KSkg
eyBkb19zb2Z0aXJxKCk7IF9fc3RpKCk7IH0gfSB3aGlsZSAoMCkNCiAjZGVm
aW5lIF9fY3B1X3JhaXNlX3NvZnRpcnEoY3B1LG5yKSBzZXRfYml0KChuciks
ICZzb2Z0aXJxX3BlbmRpbmcoY3B1KSk7DQogI2RlZmluZSByYWlzZV9zb2Z0
aXJxKG5yKSBfX2NwdV9yYWlzZV9zb2Z0aXJxKHNtcF9wcm9jZXNzb3JfaWQo
KSwgKG5yKSkNCiANCiAjZGVmaW5lIGluX3NvZnRpcnEoKSAobG9jYWxfYmhf
Y291bnQoc21wX3Byb2Nlc3Nvcl9pZCgpKSAhPSAwKQ0KKw0KKy8qDQorICog
Tk9URTogdGhpcyBhc3NlbWJseSBjb2RlIGFzc3VtZXM6DQorICoNCisgKiAg
ICAoY2hhciAqKSZsb2NhbF9iaF9jb3VudCAtIDggPT0gKGNoYXIgKikmc29m
dGlycV9wZW5kaW5nDQorICoNCisgKiBJZiB5b3UgY2hhbmdlIHRoZSBvZmZz
ZXRzIGluIGlycV9zdGF0IHRoZW4geW91IGhhdmUgdG8NCisgKiB1cGRhdGUg
dGhpcyBjb2RlIGFzIHdlbGwuDQorICovDQorI2RlZmluZSBsb2NhbF9iaF9l
bmFibGUoKQkJCQkJCVwNCitkbyB7CQkJCQkJCQkJXA0KKwl1bnNpZ25lZCBp
bnQgKnB0ciA9ICZsb2NhbF9iaF9jb3VudChzbXBfcHJvY2Vzc29yX2lkKCkp
OwlcDQorCQkJCQkJCQkJXA0KKwlpZiAoIS0tKnB0cikJCQkJCQkJXA0KKwkJ
X19hc21fXyBfX3ZvbGF0aWxlX18gKAkJCQkJXA0KKwkJCSJjbXBsICQwLCAt
OCglMCk7IgkJCQlcDQorCQkJImpueiAyZjsiCQkJCQlcDQorCQkJIjE6OyIJ
CQkJCQlcDQorCQkJCQkJCQkJXA0KKwkJCSIuc2VjdGlvbiAudGV4dC5sb2Nr
LFwiYXhcIjsiCQkJXA0KKwkJCSIyOiBwdXNobCAlJWVheDsgcHVzaGwgJSVl
Y3g7IHB1c2hsICUlZWR4OyIJXA0KKwkJCSJjYWxsIGRvX3NvZnRpcnE7IgkJ
CQlcDQorCQkJInBvcGwgJSVlZHg7IHBvcGwgJSVlY3g7IHBvcGwgJSVlYXg7
IgkJXA0KKwkJCSJqbXAgMWI7IgkJCQkJXA0KKwkJCSIucHJldmlvdXM7IgkJ
CQkJXA0KKwkJCQkJCQkJCVwNCisJCTogLyogbm8gb3V0cHV0ICovCQkJCQlc
DQorCQk6ICJyIiAocHRyKQkJCQkJCVwNCisJCS8qIG5vIHJlZ2lzdGVycyBj
bG9iYmVyZWQgKi8gKTsJCQkJXA0KK30gd2hpbGUgKDApDQogDQogI2VuZGlm
CS8qIF9fQVNNX1NPRlRJUlFfSCAqLw0KLS0tIGxpbnV4L2luY2x1ZGUvYXNt
LWkzODYvaGFyZGlycS5oLm9yaWcJV2VkIEp1biAgNiAwOTowNDo1OSAyMDAx
DQorKysgbGludXgvaW5jbHVkZS9hc20taTM4Ni9oYXJkaXJxLmgJV2VkIEp1
biAgNiAwOToxNjoyNiAyMDAxDQpAQCAtNSw3ICs1LDcgQEANCiAjaW5jbHVk
ZSA8bGludXgvdGhyZWFkcy5oPg0KICNpbmNsdWRlIDxsaW51eC9pcnEuaD4N
CiANCi0vKiBlbnRyeS5TIGlzIHNlbnNpdGl2ZSB0byB0aGUgb2Zmc2V0cyBv
ZiB0aGVzZSBmaWVsZHMgKi8NCisvKiBhc3NlbWJseSBjb2RlIGluIHNvZnRp
cnEuaCBpcyBzZW5zaXRpdmUgdG8gdGhlIG9mZnNldHMgb2YgdGhlc2UgZmll
bGRzICovDQogdHlwZWRlZiBzdHJ1Y3Qgew0KIAl1bnNpZ25lZCBpbnQgX19z
b2Z0aXJxX3BlbmRpbmc7DQogCXVuc2lnbmVkIGludCBfX2xvY2FsX2lycV9j
b3VudDsNCi0tLSBsaW51eC9hcmNoL2kzODYva2VybmVsL2VudHJ5LlMub3Jp
ZwlXZWQgSnVuICA2IDA4OjQ4OjA5IDIwMDENCisrKyBsaW51eC9hcmNoL2kz
ODYva2VybmVsL2VudHJ5LlMJV2VkIEp1biAgNiAwODo1MTozOSAyMDAxDQpA
QCAtMTMzLDE4ICsxMzMsNiBAQA0KIAltb3ZsICQtODE5MiwgcmVnOyBcDQog
CWFuZGwgJWVzcCwgcmVnDQogDQotI2lmZGVmIENPTkZJR19TTVANCi0jZGVm
aW5lIENIRUNLX1NPRlRJUlEgXA0KLQltb3ZsIHByb2Nlc3NvciglZWJ4KSwl
ZWF4OyBcDQotCXNobGwgJENPTkZJR19YODZfTDFfQ0FDSEVfU0hJRlQsJWVh
eDsgXA0KLQl4b3JsICVlY3gsJWVjeDsgXA0KLQl0ZXN0bCBTWU1CT0xfTkFN
RShpcnFfc3RhdCkrNCgsJWVheCksJWVjeA0KLSNlbHNlDQotI2RlZmluZSBD
SEVDS19TT0ZUSVJRIFwNCi0JeG9ybCAlZWN4LCVlY3g7IFwNCi0JdGVzdGwg
U1lNQk9MX05BTUUoaXJxX3N0YXQpKzQsJWVjeA0KLSNlbmRpZg0KLQ0KIEVO
VFJZKGxjYWxsNykNCiAJcHVzaGZsCQkJIyBXZSBnZXQgYSBkaWZmZXJlbnQg
c3RhY2sgbGF5b3V0IHdpdGggY2FsbCBnYXRlcywNCiAJcHVzaGwgJWVheAkJ
IyB3aGljaCBoYXMgdG8gYmUgY2xlYW5lZCB1cCBsYXRlci4uDQpAQCAtMjE1
LDkgKzIwMyw3IEBADQogCWNhbGwgKlNZTUJPTF9OQU1FKHN5c19jYWxsX3Rh
YmxlKSgsJWVheCw0KQ0KIAltb3ZsICVlYXgsRUFYKCVlc3ApCQkjIHNhdmUg
dGhlIHJldHVybiB2YWx1ZQ0KIEVOVFJZKHJldF9mcm9tX3N5c19jYWxsKQ0K
LQljbGkNCi0JQ0hFQ0tfU09GVElSUQ0KLQlqbmUgaGFuZGxlX3NvZnRpcnEN
CisJY2xpCQkJCSMgbmVlZF9yZXNjaGVkIGFuZCBzaWduYWxzIGF0b21pYyB0
ZXN0DQogCWNtcGwgJDAsbmVlZF9yZXNjaGVkKCVlYngpDQogCWpuZSByZXNj
aGVkdWxlDQogCWNtcGwgJDAsc2lncGVuZGluZyglZWJ4KQ0KQEAgLTIzMywx
MyArMjE5LDYgQEANCiAJam5lIHY4Nl9zaWduYWxfcmV0dXJuDQogCXhvcmwg
JWVkeCwlZWR4DQogCWNhbGwgU1lNQk9MX05BTUUoZG9fc2lnbmFsKQ0KLSNp
ZmRlZiBDT05GSUdfU01QDQotCUdFVF9DVVJSRU5UKCVlYngpDQotI2VuZGlm
DQotCWNsaQ0KLQlDSEVDS19TT0ZUSVJRDQotCWplIHJlc3RvcmVfYWxsDQot
CWNhbGwgU1lNQk9MX05BTUUoZG9fc29mdGlycSkNCiAJam1wIHJlc3RvcmVf
YWxsDQogDQogCUFMSUdODQpAQCAtMjQ4LDEzICsyMjcsNiBAQA0KIAltb3Zs
ICVlYXgsJWVzcA0KIAl4b3JsICVlZHgsJWVkeA0KIAljYWxsIFNZTUJPTF9O
QU1FKGRvX3NpZ25hbCkNCi0jaWZkZWYgQ09ORklHX1NNUA0KLQlHRVRfQ1VS
UkVOVCglZWJ4KQ0KLSNlbmRpZg0KLQljbGkNCi0JQ0hFQ0tfU09GVElSUQ0K
LQlqZSByZXN0b3JlX2FsbA0KLQljYWxsIFNZTUJPTF9OQU1FKGRvX3NvZnRp
cnEpDQogCWptcCByZXN0b3JlX2FsbA0KIA0KIAlBTElHTg0KQEAgLTI3Niw4
ICsyNDgsNiBAQA0KIAlBTElHTg0KIHJldF9mcm9tX2V4Y2VwdGlvbjoNCiAJ
Y2xpDQotCUNIRUNLX1NPRlRJUlENCi0Jam5lIGhhbmRsZV9zb2Z0aXJxDQog
CWNtcGwgJDAsbmVlZF9yZXNjaGVkKCVlYngpDQogCWpuZSByZXNjaGVkdWxl
DQogCWNtcGwgJDAsc2lncGVuZGluZyglZWJ4KQ0KQEAgLTI5MiwxMSArMjYy
LDYgQEANCiAJam5lIHJldF9mcm9tX3N5c19jYWxsDQogCWptcCByZXN0b3Jl
X2FsbA0KIA0KLQlBTElHTg0KLWhhbmRsZV9zb2Z0aXJxOg0KLQljYWxsIFNZ
TUJPTF9OQU1FKGRvX3NvZnRpcnEpDQotCWptcCByZXRfZnJvbV9pbnRyDQot
CQ0KIAlBTElHTg0KIHJlc2NoZWR1bGU6DQogCWNhbGwgU1lNQk9MX05BTUUo
c2NoZWR1bGUpICAgICMgdGVzdA0K
--8323328-593323588-991814802=:1712--
