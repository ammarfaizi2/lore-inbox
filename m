Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288266AbSATLcE>; Sun, 20 Jan 2002 06:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288274AbSATLbp>; Sun, 20 Jan 2002 06:31:45 -0500
Received: from mx2.elte.hu ([157.181.151.9]:58544 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288266AbSATLbj>;
	Sun, 20 Jan 2002 06:31:39 -0500
Date: Sun, 20 Jan 2002 14:29:04 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [sched] [patch] idle-thread-fixes-2.5.3-pre2-A1
Message-ID: <Pine.LNX.4.33.0201201422320.7972-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-648550002-1011533344=:7972"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-648550002-1011533344=:7972
Content-Type: TEXT/PLAIN; charset=US-ASCII


the attached, bigger patch cleans up a particular aspect of scheduler
initialization that is the source of two unclean pieces of code within the
timer interrupt:

in idle_tick():

        if ((jiffies % IDLE_REBALANCE_TICK) ||
                        likely(this_rq()->curr == NULL))
                return;

in scheduler_tick():

        if (p == rq->idle || !rq->idle)
                return idle_tick();

both the 'this_rq()->curr == NULL' and '!rq->idle' tests are only there to
fix a temporary bootup-only situation where the idle threads are not
initialized yet.

the source of the problem is that idle thread initialization on SMP is not
'atomic'. Eg., on x86 the idle threads first do timer calibration, for
which period of time it's possible for timer interrupts to arrive on that
(partly initialized) CPU.

the attached patch solves this problem by splitting up init_idle() into
two parts: init_idle() and idle_startup_done(). After init_idle() is
called, it's possible to receive timer interrupts on a CPU. But schedule()
can only be called after all idle threads have done idle_startup_done().

	Ingo

--8323328-648550002-1011533344=:7972
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="idle-thread-fixes-2.5.3-pre2-A1"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0201201429040.7972@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="idle-thread-fixes-2.5.3-pre2-A1"

LS0tIGxpbnV4L2luaXQvbWFpbi5jLm9yaWcJU3VuIEphbiAyMCAxMTozNjow
NSAyMDAyDQorKysgbGludXgvaW5pdC9tYWluLmMJU3VuIEphbiAyMCAxMToz
ODo1OSAyMDAyDQpAQCAtMjkwLDggKzI5MCw2IEBADQogZXh0ZXJuIHZvaWQg
c2V0dXBfYXJjaChjaGFyICoqKTsNCiBleHRlcm4gdm9pZCBjcHVfaWRsZSh2
b2lkKTsNCiANCi11bnNpZ25lZCBsb25nIHdhaXRfaW5pdF9pZGxlOw0KLQ0K
ICNpZm5kZWYgQ09ORklHX1NNUA0KIA0KICNpZmRlZiBDT05GSUdfWDg2X0xP
Q0FMX0FQSUMNCkBAIC0zMDUsNiArMzAzLDE2IEBADQogDQogI2Vsc2UNCiAN
CitzdGF0aWMgdW5zaWduZWQgbG9uZyBfX2luaXRkYXRhIHdhaXRfaW5pdF9p
ZGxlOw0KKw0KK3ZvaWQgX19pbml0IGlkbGVfc3RhcnR1cF9kb25lKHZvaWQp
DQorew0KKwljbGVhcl9iaXQoc21wX3Byb2Nlc3Nvcl9pZCgpLCAmd2FpdF9p
bml0X2lkbGUpOw0KKwl3aGlsZSAod2FpdF9pbml0X2lkbGUpIHsNCisJCWNw
dV9yZWxheCgpOw0KKwkJYmFycmllcigpOw0KKwl9DQorfQ0KIA0KIC8qIENh
bGxlZCBieSBib290IHByb2Nlc3NvciB0byBhY3RpdmF0ZSB0aGUgcmVzdC4g
Ki8NCiBzdGF0aWMgdm9pZCBfX2luaXQgc21wX2luaXQodm9pZCkNCkBAIC0z
MTUsNiArMzIzLDcgQEANCiANCiAJc21wX3RocmVhZHNfcmVhZHk9MTsNCiAJ
c21wX2NvbW1lbmNlKCk7DQorCWlkbGVfc3RhcnR1cF9kb25lKCk7DQogfQ0K
IA0KICNlbmRpZg0KQEAgLTQxMSwyMCArNDIwLDEzIEBADQogCWNoZWNrX2J1
Z3MoKTsNCiAJcHJpbnRrKCJQT1NJWCBjb25mb3JtYW5jZSB0ZXN0aW5nIGJ5
IFVOSUZJWFxuIik7DQogDQorCWluaXRfaWRsZSgpOw0KIAkvKiANCiAJICoJ
V2UgY291bnQgb24gdGhlIGluaXRpYWwgdGhyZWFkIGdvaW5nIG9rIA0KIAkg
KglMaWtlIGlkbGVycyBpbml0IGlzIGFuIHVubG9ja2VkIGtlcm5lbCB0aHJl
YWQsIHdoaWNoIHdpbGwNCiAJICoJbWFrZSBzeXNjYWxscyAoYW5kIHRodXMg
YmUgbG9ja2VkKS4NCiAJICovDQogCXNtcF9pbml0KCk7DQotDQotCS8qDQot
CSAqIEZpbmFsbHksIHdlIHdhaXQgZm9yIGFsbCBvdGhlciBDUFUncywgYW5k
IGluaXRpYWxpemUgdGhpcw0KLQkgKiB0aHJlYWQgdGhhdCB3aWxsIGJlY29t
ZSB0aGUgaWRsZSB0aHJlYWQgZm9yIHRoZSBib290IENQVS4NCi0JICogQWZ0
ZXIgdGhpcywgdGhlIHNjaGVkdWxlciBpcyBmdWxseSBpbml0aWFsaXplZCwg
YW5kIHdlIGNhbg0KLQkgKiBzdGFydCBjcmVhdGluZyBhbmQgcnVubmluZyBu
ZXcgdGhyZWFkcy4NCi0JICovDQotCWluaXRfaWRsZSgpOw0KIA0KIAkvKiBE
byB0aGUgcmVzdCBub24tX19pbml0J2VkLCB3ZSdyZSBub3cgYWxpdmUgKi8N
CiAJcmVzdF9pbml0KCk7DQotLS0gbGludXgva2VybmVsL3NjaGVkLmMub3Jp
ZwlTdW4gSmFuIDIwIDExOjM4OjM4IDIwMDINCisrKyBsaW51eC9rZXJuZWwv
c2NoZWQuYwlTdW4gSmFuIDIwIDExOjM4OjU5IDIwMDINCkBAIC00ODksOCAr
NDg5LDcgQEANCiANCiBzdGF0aWMgaW5saW5lIHZvaWQgaWRsZV90aWNrKHZv
aWQpDQogew0KLQlpZiAoKGppZmZpZXMgJSBJRExFX1JFQkFMQU5DRV9USUNL
KSB8fA0KLQkJCWxpa2VseSh0aGlzX3JxKCktPmN1cnIgPT0gTlVMTCkpDQor
CWlmIChqaWZmaWVzICUgSURMRV9SRUJBTEFOQ0VfVElDSykNCiAJCXJldHVy
bjsNCiAJc3Bpbl9sb2NrKCZ0aGlzX3JxKCktPmxvY2spOw0KIAlsb2FkX2Jh
bGFuY2UodGhpc19ycSgpLCAxKTsNCkBAIC01MDYsNyArNTA1LDcgQEANCiAJ
dW5zaWduZWQgbG9uZyBub3cgPSBqaWZmaWVzOw0KIAlydW5xdWV1ZV90ICpy
cSA9IHRoaXNfcnEoKTsNCiANCi0JaWYgKHAgPT0gcnEtPmlkbGUgfHwgIXJx
LT5pZGxlKQ0KKwlpZiAocCA9PSBycS0+aWRsZSkNCiAJCXJldHVybiBpZGxl
X3RpY2soKTsNCiAJLyogVGFzayBtaWdodCBoYXZlIGV4cGlyZWQgYWxyZWFk
eSwgYnV0IG5vdCBzY2hlZHVsZWQgb2ZmIHlldCAqLw0KIAlpZiAocC0+YXJy
YXkgIT0gcnEtPmFjdGl2ZSkgew0KQEAgLTEyMjEsOCArMTIyMCw2IEBADQog
CXJlYWRfdW5sb2NrKCZ0YXNrbGlzdF9sb2NrKTsNCiB9DQogDQotZXh0ZXJu
IHVuc2lnbmVkIGxvbmcgd2FpdF9pbml0X2lkbGU7DQotDQogc3RhdGljIGlu
bGluZSB2b2lkIGRvdWJsZV9ycV9sb2NrKHJ1bnF1ZXVlX3QgKnJxMSwgcnVu
cXVldWVfdCAqcnEyKQ0KIHsNCiAJaWYgKHJxMSA9PSBycTIpDQpAQCAtMTI1
NywxNiArMTI1NCwxMSBAQA0KIAl0aGlzX3JxLT5jdXJyID0gdGhpc19ycS0+
aWRsZSA9IGN1cnJlbnQ7DQogCWRlYWN0aXZhdGVfdGFzayhjdXJyZW50LCBy
cSk7DQogCWN1cnJlbnQtPmFycmF5ID0gTlVMTDsNCi0JY3VycmVudC0+cHJp
byA9IE1BWF9QUklPLTE7DQorCWN1cnJlbnQtPnByaW8gPSBNQVhfUFJJTzsN
CiAJY3VycmVudC0+c3RhdGUgPSBUQVNLX1JVTk5JTkc7DQotCWNsZWFyX2Jp
dChzbXBfcHJvY2Vzc29yX2lkKCksICZ3YWl0X2luaXRfaWRsZSk7DQogCWRv
dWJsZV9ycV91bmxvY2sodGhpc19ycSwgcnEpOw0KLQl3aGlsZSAod2FpdF9p
bml0X2lkbGUpIHsNCi0JCWNwdV9yZWxheCgpOw0KLQkJYmFycmllcigpOw0K
LQl9DQogCWN1cnJlbnQtPm5lZWRfcmVzY2hlZCA9IDE7DQotCV9fc3RpKCk7
DQorCV9fcmVzdG9yZV9mbGFncyhmbGFncyk7DQogfQ0KIA0KIGV4dGVybiB2
b2lkIGluaXRfdGltZXJ2ZWNzKHZvaWQpOw0KQEAgLTEzMDUsNyArMTI5Nyw3
IEBADQogCSAqLw0KIAlycSA9IHRoaXNfcnEoKTsNCiAJcnEtPmN1cnIgPSBj
dXJyZW50Ow0KLQlycS0+aWRsZSA9IE5VTEw7DQorCXJxLT5pZGxlID0gY3Vy
cmVudDsNCiAJd2FrZV91cF9wcm9jZXNzKGN1cnJlbnQpOw0KIA0KIAlpbml0
X3RpbWVydmVjcygpOw0KLS0tIGxpbnV4L2luY2x1ZGUvbGludXgvc2NoZWQu
aC5vcmlnCVN1biBKYW4gMjAgMTE6MzY6MDUgMjAwMg0KKysrIGxpbnV4L2lu
Y2x1ZGUvbGludXgvc2NoZWQuaAlTdW4gSmFuIDIwIDExOjM4OjU5IDIwMDIN
CkBAIC0xNDEsNiArMTQxLDcgQEANCiANCiBleHRlcm4gdm9pZCBzY2hlZF9p
bml0KHZvaWQpOw0KIGV4dGVybiB2b2lkIGluaXRfaWRsZSh2b2lkKTsNCitl
eHRlcm4gdm9pZCBpZGxlX3N0YXJ0dXBfZG9uZSh2b2lkKTsNCiBleHRlcm4g
dm9pZCBzaG93X3N0YXRlKHZvaWQpOw0KIGV4dGVybiB2b2lkIGNwdV9pbml0
ICh2b2lkKTsNCiBleHRlcm4gdm9pZCB0cmFwX2luaXQodm9pZCk7DQotLS0g
bGludXgvYXJjaC9pMzg2L2tlcm5lbC9zbXBib290LmMub3JpZwlTdW4gSmFu
IDIwIDExOjM2OjAyIDIwMDINCisrKyBsaW51eC9hcmNoL2kzODYva2VybmVs
L3NtcGJvb3QuYwlTdW4gSmFuIDIwIDExOjM4OjU5IDIwMDINCkBAIC00NjIs
NiArNDYyLDcgQEANCiAJICogdGhpbmdzIGRvbmUgaGVyZSB0byB0aGUgbW9z
dCBuZWNlc3NhcnkgdGhpbmdzLg0KIAkgKi8NCiAJY3B1X2luaXQoKTsNCisJ
aW5pdF9pZGxlKCk7DQogCXNtcF9jYWxsaW4oKTsNCiAJd2hpbGUgKCFhdG9t
aWNfcmVhZCgmc21wX2NvbW1lbmNlZCkpDQogCQlyZXBfbm9wKCk7DQpAQCAt
NDcwLDggKzQ3MSw4IEBADQogCSAqIHRoZSBsb2NhbCBUTEJzIHRvby4NCiAJ
ICovDQogCWxvY2FsX2ZsdXNoX3RsYigpOw0KKwlpZGxlX3N0YXJ0dXBfZG9u
ZSgpOw0KIA0KLQlpbml0X2lkbGUoKTsNCiAJcmV0dXJuIGNwdV9pZGxlKCk7
DQogfQ0KIA0K
--8323328-648550002-1011533344=:7972--
