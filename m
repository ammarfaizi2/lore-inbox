Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271897AbRH1Tqi>; Tue, 28 Aug 2001 15:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271899AbRH1Tq3>; Tue, 28 Aug 2001 15:46:29 -0400
Received: from fungus.teststation.com ([212.32.186.211]:25092 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S271898AbRH1TqI>; Tue, 28 Aug 2001 15:46:08 -0400
Date: Tue, 28 Aug 2001 21:46:18 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: David Schmitt <david@heureka.co.at>
cc: <linux-kernel@vger.kernel.org>, Dennis Bjorklund <db@zigo.dhs.org>
Subject: Re: ISSUE: DFE530-TX REV-A3-1 times out on transmit
In-Reply-To: <20010828154540.A23296@www.heureka.co.at>
Message-ID: <Pine.LNX.4.30.0108282034210.1851-200000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463780587-1567128627-999027303=:1851"
Content-ID: <Pine.LNX.4.30.0108282135130.1851@cola.teststation.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463780587-1567128627-999027303=:1851
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.30.0108282135131.1851@cola.teststation.com>

On Tue, 28 Aug 2001, David Schmitt wrote:

> Note 1: '005e9700' doesn't always cause a timeout.

That status is from the Rx, not Tx. I think they are all ok.
005e9700 - length=0x5e, RxOK, accept broadcast, single buffer, end buffer
00668f00 - length=0x66, RxOk, chain buffer, single buffer, end buffer


> Correct shutdown:
> Aug 28 14:53:34 cheesy kernel: eth0: Shutting down ethercard, status was 085a.
> 
> After first resets:
> Aug 28 14:54:11 cheesy kernel: eth0: Shutting down ethercard, status was 081a.
> 
> After total NIC lockup:
> Aug 28 14:56:24 cheesy kernel: eth0: Shutting down ethercard, status was 883a.

8000 means that the chip is still doing a software reset. I think the
difference between 085a/081a is simply that you caught it in different
states.


>  Tx disabled, Rx enabled, half-duplex (0x800c).
>   Receive  mode is 0x6c: Normal unicast and hashed multicast.
>   Transmit mode is 0x22: Transmitter set to INTERNAL LOOPBACK!.

Is this after unloading the module? The via_rhine_close sets the
transmitter to loopback mode (comment says to avoid hardware races ...).
The reset code does not.

That should not be a problem, when loading the module (and on reset) it
changes this to normal mode.

> 2.2.19 with Dennis' patch
> 
> Resets often, but no lock up.

That is interesting. This code should be almost identical to 2.4.x (or
not, Dennis?). The way the timeout code is run may be different of course,
but the driver part is the same.

I'm ignoring that for now (if you don't mind) and have made a patch with
some possible improvements. Someone found a modified driver on some dlink
server that contains (claimed) workarounds for various chip peculiarities
(bugs).

I also added a "force software reset" that is described in the datasheet.
Not sure what the difference is, but it can't hurt trying that if the
normal reset fails.

Perhaps this helps, probably not.

/Urban

---1463780587-1567128627-999027303=:1851
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="via-rhine-2.4.9-reset.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0108282144320.1851@cola.teststation.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="via-rhine-2.4.9-reset.patch"

LS0tIGxpbnV4LTIuNC45LW9yaWcvZHJpdmVycy9uZXQvdmlhLXJoaW5lLmMJ
U3VuIEF1ZyAxOSAxMjowODoyMiAyMDAxDQorKysgbGludXgtMi40LjktMDAv
ZHJpdmVycy9uZXQvdmlhLXJoaW5lLmMJVHVlIEF1ZyAyOCAyMTozNzoxOCAy
MDAxDQpAQCAtNDk3LDYgKzQ5NywxNCBAQA0KIAlpZiAoZGVidWcgPiAxKQ0K
IAkJcHJpbnRrKEtFUk5fSU5GTyAiJXM6IHJlc2V0IGZpbmlzaGVkIGFmdGVy
ICVkIG1pY3Jvc2Vjb25kcy5cbiIsDQogCQkJICAgbmFtZSwgNSppKTsNCisN
CisJaWYgKGNoaXBfaWQgPT0gVlQ2MTAyICYmIHJlYWR3KGlvYWRkciArIENo
aXBDbWQpICYgQ21kUmVzZXQpIHsNCisJCS8qIFRyeSB0byBmb3JjZSBzb2Z0
d2FyZSByZXNldCAod2UgYXJlIGRlYWQgYW55d2F5IC4uLikgKi8NCisJCXdy
aXRlYigweDQwLCBpb2FkZHIgKyAweDgxKTsNCisJCWZvciAoaT0wOyBpPDIw
MDAgJiYgKHJlYWR3KGlvYWRkciArIENoaXBDbWQpICYgQ21kUmVzZXQpOyBp
KyspDQorCQkJdWRlbGF5KDUpOw0KKwl9DQorDQogfQ0KIA0KIHN0YXRpYyBp
bnQgX19kZXZpbml0IHZpYV9yaGluZV9pbml0X29uZSAoc3RydWN0IHBjaV9k
ZXYgKnBkZXYsDQpAQCAtMTA3OCw4ICsxMDg2LDUwIEBADQogDQogCXNwaW5f
bG9jaygmbnAtPmxvY2spOw0KIA0KKwkvKiBEaXNhYmxlIGludGVycnVwdHMg
YnkgY2xlYXJpbmcgdGhlIGludGVycnVwdCBtYXNrLiAqLw0KKwl3cml0ZXco
MHgwMDAwLCBpb2FkZHIgKyBJbnRyRW5hYmxlKTsNCisNCisJLyogc2h1dGRv
d24gY29kZSBmcm9tIHRoZSBkcml2ZXIgc3VwcG9zZWRseSBtb2RpZmllZCBi
eSBELUxpbmsuICovDQorCWlmIChucC0+ZHJ2X2ZsYWdzICYgSGFzV09MKSB7
IA0KKwkJaW50IHd3Ow0KKw0KKwkJLyogRklYTUU6IDB4MDEgaXNuJ3QgbG9v
cGJhY2sgYWNjb3JkaW5nIHRvIHRoZSBkb2NzLCBpdCBpcyByZXNlcnZlZCEg
Ki8NCisJCS8qIE5pYyBMb29wIEJhY2sgT24gKi8NCisJCXdyaXRlYihyZWFk
Yihpb2FkZHIgKyBUeENvbmZpZykgfCAweDAxLCBpb2FkZHIgKyBUeENvbmZp
Zyk7DQorDQorCQkvKiBUeCBPZmYgKi8NCisJCXdyaXRlYihyZWFkYihpb2Fk
ZHIgKyBDaGlwQ21kKSBeIDB4MTAsIGlvYWRkciArIENoaXBDbWQpOw0KKwkJ
Zm9yICh3dyA9IDA7IHd3IDwgV19NQVhfVElNRU9VVDsgd3crKykgew0KKwkJ
CWlmICgocmVhZGIoaW9hZGRyICsgQ2hpcENtZCkgJiAweDEwKSA9PSAwKQ0K
KwkJCQlicmVhazsNCisJCX0NCisNCisJCS8qIFJ4IE9mZiAqLw0KKwkJd3Jp
dGViKHJlYWRiKGlvYWRkciArIENoaXBDbWQpIF4gMHgwOCwgaW9hZGRyICsg
Q2hpcENtZCk7DQorCQlmb3IgKHd3ID0gMDsgd3cgPCBXX01BWF9USU1FT1VU
OyB3dysrKSB7DQorCQkJaWYgKChyZWFkYihpb2FkZHIgKyBDaGlwQ21kKSAm
IDB4MDgpID09IDApDQorCQkJCWJyZWFrOyANCisJCX0gDQorDQorCQlpZiAo
d3cgPT0gV19NQVhfVElNRU9VVCkgew0KKwkJCS8qIFR1cm4gb24gZmlmbyB0
ZXN0ICovDQorCQkJd3JpdGV3KHJlYWR3KGlvYWRkciArIEdGSUZPVGVzdCkg
fCAweDAwMDEsIGlvYWRkciArIEdGSUZPVGVzdCk7DQorCQkJLyogVHVybiBv
biBmaWZvIHJlamVjdCAqLw0KKwkJCXdyaXRldyhyZWFkdyhpb2FkZHIgKyBH
RklGT1Rlc3QpIHwgMHgwODAwLCBpb2FkZHIgKyBHRklGT1Rlc3QpOw0KKwkJ
CS8qIFR1cm4gb2ZmIGZpZm8gdGVzdCAqLw0KKwkJCXdyaXRldyhyZWFkdyhp
b2FkZHIgKyBHRklGT1Rlc3QpICYgMHhGRkZFLCBpb2FkZHIgKyBHRklGT1Rl
c3QpOw0KKwkJfQ0KKw0KKwkJLyogTmljIExvb3AgQmFjayBPZmYgKi8NCisJ
CXdyaXRlYihyZWFkYihpb2FkZHIgKyBUeENvbmZpZykgJiAweEZFLCBpb2Fk
ZHIgKyBUeENvbmZpZyk7DQorCX0NCisNCisJLyogU3RvcCB0aGUgY2hpcCdz
IFR4IGFuZCBSeCBwcm9jZXNzZXMuICovDQorCXdyaXRldyhDbWRTdG9wLCBp
b2FkZHIgKyBDaGlwQ21kKTsNCisNCiAJLyogUmVzZXQgdGhlIGNoaXAuICov
DQogCXdyaXRldyhDbWRSZXNldCwgaW9hZGRyICsgQ2hpcENtZCk7DQorCXdh
aXRfZm9yX3Jlc2V0KGRldiwgZGV2LT5uYW1lKTsNCiANCiAJLyogY2xlYXIg
YWxsIGRlc2NyaXB0b3JzICovDQogCWZyZWVfdGJ1ZnMoZGV2KTsNCkBAIC0x
MDg4LDcgKzExMzgsNiBAQA0KIAlhbGxvY19yYnVmcyhkZXYpOw0KIA0KIAkv
KiBSZWluaXRpYWxpemUgdGhlIGhhcmR3YXJlLiAqLw0KLQl3YWl0X2Zvcl9y
ZXNldChkZXYsIGRldi0+bmFtZSk7DQogCWluaXRfcmVnaXN0ZXJzKGRldik7
DQogCQ0KIAlzcGluX3VubG9jaygmbnAtPmxvY2spOw0KQEAgLTE1NTQsNyAr
MTYwMyw4IEBADQogCQkJICAgZGV2LT5uYW1lLCByZWFkdyhpb2FkZHIgKyBD
aGlwQ21kKSk7DQogDQogCS8qIFN3aXRjaCB0byBsb29wYmFjayBtb2RlIHRv
IGF2b2lkIGhhcmR3YXJlIHJhY2VzLiAqLw0KLQl3cml0ZWIobnAtPnR4X3Ro
cmVzaCB8IDB4MDIsIGlvYWRkciArIFR4Q29uZmlnKTsNCisJLyogRklYTUU6
IGRvY3Mgc2F5IDB4MDEgaXMgcmVzZXJ2ZWQhIEJlY2tlciB2ZXJzaW9uIHNl
dCB0aGlzIGFuZCBub3QgMHgwMiAqLw0KKwl3cml0ZWIobnAtPnR4X3RocmVz
aCB8IDB4MDEsIGlvYWRkciArIFR4Q29uZmlnKTsNCiANCiAJLyogRGlzYWJs
ZSBpbnRlcnJ1cHRzIGJ5IGNsZWFyaW5nIHRoZSBpbnRlcnJ1cHQgbWFzay4g
Ki8NCiAJd3JpdGV3KDB4MDAwMCwgaW9hZGRyICsgSW50ckVuYWJsZSk7DQo=
---1463780587-1567128627-999027303=:1851--
