Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbVCTEdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVCTEdY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 23:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVCTEdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 23:33:24 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:56235 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S261996AbVCTEc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 23:32:59 -0500
Date: Sun, 20 Mar 2005 05:37:20 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: 7eggert@gmx.de
Subject: [PATCH 2.6.11.2][RFC] printk with anti-cluttering-feature
Message-ID: <Pine.LNX.4.58.0503200528520.2804@be1.lrz>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="-1463760639-1199172649-1111188901=:4541"
Content-ID: <Pine.LNX.4.58.0503191554250.3024@be1.lrz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463760639-1199172649-1111188901=:4541
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.58.0503191554251.3024@be1.lrz>

(I hope I avoided all spam-keywords this time, my previous mails didn't 
 seem to make it)
(please CC me on reply)

Issue:

On some conditions, the dmesg is spammed with repeated warnings about the
same issue which is neither critical nor going to be fixed. This may
result in losing the boot messages or missing other important messages.

Examples are:

nfs warning: mount version older than kernel
 (my mount is newer than documented to be required)

atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
 (I'm using a keyboard switch and a IBM PS/2 keyboard)

program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
 (I'll use the latest version as soon as I need to)



Rate-limiting these messages is won't help, since it would still allow
these messages to (slowly or in a burst) spam the log.

Printing these messages only once after booting might result in missing
important messages, especially on long-running systems (e.g. if my
keyboard really breaks after I have used the keyboard switch).


Suggested solution:

Instead, I decided to use a global flag with a semi-random magic number,
which will indicate the last printk being supposed to be limited, and to
reset this flag on each normal printk. By doing this, dmesg will not be
spammed, but the latest issue is displayed last.

(I suggest using the first value from "cksum file.c" as the magic number
unless there are thousands of printks to convert.)

The magic number depends on the CPU being able to read and write a
complete int at once *or* being lucky not to have a magic value that can
be constructed by combining some other magic numbers and printking with
exactly that magic number while the update happens. I can convert the
variable to an atomic type if it is a concern, but that would increase the
chances of a clash due to the 24 bit limit.

The patch increases the size of vmlinux by 141 bytes.
-- 
The programmer's National Anthem is 'AAAAAAAAHHHHHHHH' 
---1463760639-1199172649-1111188901=:4541
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="printk_nospam.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0503182303270.4541@be1.lrz>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="printk_nospam.patch"

ZGlmZiAtdXByTiBsaW51eC0yLjYuMTEvZHJpdmVycy9ibG9jay9zY3NpX2lv

Y3RsLmMgbGludXgtMi42LjExLm5ldy9kcml2ZXJzL2Jsb2NrL3Njc2lfaW9j

dGwuYw0KLS0tIGxpbnV4LTIuNi4xMS9kcml2ZXJzL2Jsb2NrL3Njc2lfaW9j

dGwuYwkyMDA1LTAzLTAzIDE1OjQxOjI4LjAwMDAwMDAwMCArMDEwMA0KKysr

IGxpbnV4LTIuNi4xMS5uZXcvZHJpdmVycy9ibG9jay9zY3NpX2lvY3RsLmMJ

MjAwNS0wMy0xOCAyMjowODozNS4wMDAwMDAwMDAgKzAxMDANCkBAIC01NDcs

NyArNTQ3LDcgQEAgaW50IHNjc2lfY21kX2lvY3RsKHN0cnVjdCBmaWxlICpm

aWxlLCBzdA0KIAkJICogb2xkIGp1bmsgc2NzaSBzZW5kIGNvbW1hbmQgaW9j

dGwNCiAJCSAqLw0KIAkJY2FzZSBTQ1NJX0lPQ1RMX1NFTkRfQ09NTUFORDoN

Ci0JCQlwcmludGsoS0VSTl9XQVJOSU5HICJwcm9ncmFtICVzIGlzIHVzaW5n

IGEgZGVwcmVjYXRlZCBTQ1NJIGlvY3RsLCBwbGVhc2UgY29udmVydCBpdCB0

byBTR19JT1xuIiwgY3VycmVudC0+Y29tbSk7DQorCQkJcHJpbnRrX25vc3Bh

bSgyMjk2MTU5NTkxLCBLRVJOX1dBUk5JTkcgInByb2dyYW0gJXMgaXMgdXNp

bmcgYSBkZXByZWNhdGVkIFNDU0kgaW9jdGwsIHBsZWFzZSBjb252ZXJ0IGl0

IHRvIFNHX0lPXG4iLCBjdXJyZW50LT5jb21tKTsNCiAJCQllcnIgPSAtRUlO

VkFMOw0KIAkJCWlmICghYXJnKQ0KIAkJCQlicmVhazsNCmRpZmYgLXVwck4g

bGludXgtMi42LjExL2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvYXRrYmQuYyBs

aW51eC0yLjYuMTEubmV3L2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvYXRrYmQu

Yw0KLS0tIGxpbnV4LTIuNi4xMS9kcml2ZXJzL2lucHV0L2tleWJvYXJkL2F0

a2JkLmMJMjAwNS0wMy0wMyAxNTo0MTozMy4wMDAwMDAwMDAgKzAxMDANCisr

KyBsaW51eC0yLjYuMTEubmV3L2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvYXRr

YmQuYwkyMDA1LTAzLTE4IDIyOjQ1OjQyLjAwMDAwMDAwMCArMDEwMA0KQEAg

LTMyMCw3ICszMjAsNyBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgYXRrYmRfaW50

ZXJydXB0KHN0cnVjDQogCQkJYXRrYmRfcmVwb3J0X2tleSgmYXRrYmQtPmRl

diwgcmVncywgS0VZX0hBTkpBLCAzKTsNCiAJCQlnb3RvIG91dDsNCiAJCWNh

c2UgQVRLQkRfUkVUX0VSUjoNCi0JCQlwcmludGsoS0VSTl9ERUJVRyAiYXRr

YmQuYzogS2V5Ym9hcmQgb24gJXMgcmVwb3J0cyB0b28gbWFueSBrZXlzIHBy

ZXNzZWQuXG4iLCBzZXJpby0+cGh5cyk7DQorCQkJcHJpbnRrX25vc3BhbSgy

MjYwNjIwMTU4LCBLRVJOX0RFQlVHICJhdGtiZC5jOiBLZXlib2FyZCBvbiAl

cyByZXBvcnRzIHRvbyBtYW55IGtleXMgcHJlc3NlZC5cbiIsIHNlcmlvLT5w

aHlzKTsNCiAJCQlnb3RvIG91dDsNCiAJfQ0KIA0KZGlmZiAtdXByTiBsaW51

eC0yLjYuMTEvZnMvbmZzL2lub2RlLmMgbGludXgtMi42LjExLm5ldy9mcy9u

ZnMvaW5vZGUuYw0KLS0tIGxpbnV4LTIuNi4xMS9mcy9uZnMvaW5vZGUuYwky

MDA1LTAzLTAzIDE1OjQxOjU5LjAwMDAwMDAwMCArMDEwMA0KKysrIGxpbnV4

LTIuNi4xMS5uZXcvZnMvbmZzL2lub2RlLmMJMjAwNS0wMy0xOCAyMjo0ODow

OS4wMDAwMDAwMDAgKzAxMDANCkBAIC0xMzg2LDcgKzEzODYsNyBAQCBzdGF0

aWMgc3RydWN0IHN1cGVyX2Jsb2NrICpuZnNfZ2V0X3NiKHN0DQogCWluaXRf

bmZzdjRfc3RhdGUoc2VydmVyKTsNCiANCiAJaWYgKGRhdGEtPnZlcnNpb24g

IT0gTkZTX01PVU5UX1ZFUlNJT04pIHsNCi0JCXByaW50aygibmZzIHdhcm5p

bmc6IG1vdW50IHZlcnNpb24gJXMgdGhhbiBrZXJuZWxcbiIsDQorCQlwcmlu

dGtfbm9zcGFtKDEzNzc0ODEwMzYsICJuZnMgd2FybmluZzogbW91bnQgdmVy

c2lvbiAlcyB0aGFuIGtlcm5lbFxuIiwNCiAJCQlkYXRhLT52ZXJzaW9uIDwg

TkZTX01PVU5UX1ZFUlNJT04gPyAib2xkZXIiIDogIm5ld2VyIik7DQogCQlp

ZiAoZGF0YS0+dmVyc2lvbiA8IDIpDQogCQkJZGF0YS0+bmFtbGVuID0gMDsN

CmRpZmYgLXVwck4gbGludXgtMi42LjExL2luY2x1ZGUvbGludXgva2VybmVs

LmggbGludXgtMi42LjExLm5ldy9pbmNsdWRlL2xpbnV4L2tlcm5lbC5oDQot

LS0gbGludXgtMi42LjExL2luY2x1ZGUvbGludXgva2VybmVsLmgJMjAwNS0w

My0wMyAxNTo0MjoxMy4wMDAwMDAwMDAgKzAxMDANCisrKyBsaW51eC0yLjYu

MTEubmV3L2luY2x1ZGUvbGludXgva2VybmVsLmgJMjAwNS0wMy0xOCAyMjow

Njo0Mi4wMDAwMDAwMDAgKzAxMDANCkBAIC0xMDQsNiArMTA0LDEwIEBAIGV4

dGVybiBpbnQgc2Vzc2lvbl9vZl9wZ3JwKGludCBwZ3JwKTsNCiBhc21saW5r

YWdlIGludCB2cHJpbnRrKGNvbnN0IGNoYXIgKmZtdCwgdmFfbGlzdCBhcmdz

KTsNCiBhc21saW5rYWdlIGludCBwcmludGsoY29uc3QgY2hhciAqIGZtdCwg

Li4uKQ0KIAlfX2F0dHJpYnV0ZV9fICgoZm9ybWF0IChwcmludGYsIDEsIDIp

KSk7DQorYXNtbGlua2FnZSBpbnQgcHJpbnRrX25vc3BhbShpbnQgbWFnaWMs

IGNvbnN0IGNoYXIgKiBmbXQsIC4uLikNCisJX19hdHRyaWJ1dGVfXyAoKGZv

cm1hdCAocHJpbnRmLCAyLCAzKSkpOw0KKy8qIHVzZSBhIHJhbmRvbSB2YWx1

ZSBmb3IgdGhlIG1hZ2ljLCBlLmcuIHRoZSBmaXJzdCB2YWx1ZSBmcm9tDQor

ICAgY2tzdW0gb24gdGhlIGZpbGUgeW91J3JlIGVkaXRpbmcgKi8NCiANCiB1

bnNpZ25lZCBsb25nIGludF9zcXJ0KHVuc2lnbmVkIGxvbmcpOw0KIA0KZGlm

ZiAtdXByTiBsaW51eC0yLjYuMTEva2VybmVsL3ByaW50ay5jIGxpbnV4LTIu

Ni4xMS5uZXcva2VybmVsL3ByaW50ay5jDQotLS0gbGludXgtMi42LjExL2tl

cm5lbC9wcmludGsuYwkyMDA1LTAzLTE4IDIxOjU0OjM1LjAwMDAwMDAwMCAr

MDEwMA0KKysrIGxpbnV4LTIuNi4xMS5uZXcva2VybmVsL3ByaW50ay5jCTIw

MDUtMDMtMTggMjI6NDA6MDIuMDAwMDAwMDAwICswMTAwDQpAQCAtMTE1LDYg

KzExNSw4IEBAIHN0YXRpYyBpbnQgcHJlZmVycmVkX2NvbnNvbGUgPSAtMTsN

CiAvKiBGbGFnOiBjb25zb2xlIGNvZGUgbWF5IGNhbGwgc2NoZWR1bGUoKSAq

Lw0KIHN0YXRpYyBpbnQgY29uc29sZV9tYXlfc2NoZWR1bGU7DQogDQorc3Rh

dGljIGludCBhbnRpc3BhbV9tYWdpYzsNCisNCiAvKg0KICAqCVNldHVwIGEg

bGlzdCBvZiBjb25zb2xlcy4gQ2FsbGVkIGZyb20gaW5pdC9tYWluLmMNCiAg

Ki8NCkBAIC01MTcsNiArNTE5LDI0IEBAIGFzbWxpbmthZ2UgaW50IHByaW50

ayhjb25zdCBjaGFyICpmbXQsIC4NCiAJdmFfbGlzdCBhcmdzOw0KIAlpbnQg

cjsNCiANCisJYW50aXNwYW1fbWFnaWMgPSAwOw0KKw0KKwl2YV9zdGFydChh

cmdzLCBmbXQpOw0KKwlyID0gdnByaW50ayhmbXQsIGFyZ3MpOw0KKwl2YV9l

bmQoYXJncyk7DQorDQorCXJldHVybiByOw0KK30NCisNCithc21saW5rYWdl

IGludCBwcmludGtfbm9zcGFtKGludCBtYWdpYywgY29uc3QgY2hhciAqZm10

LCAuLi4pDQorew0KKwl2YV9saXN0IGFyZ3M7DQorCWludCByOw0KKwkNCisJ

aWYgKG1hZ2ljID09IGFudGlzcGFtX21hZ2ljKQ0KKwkJcmV0dXJuIDA7DQor

CWFudGlzcGFtX21hZ2ljID0gbWFnaWM7DQorDQogCXZhX3N0YXJ0KGFyZ3Ms

IGZtdCk7DQogCXIgPSB2cHJpbnRrKGZtdCwgYXJncyk7DQogCXZhX2VuZChh

cmdzKTsNCkBAIC01OTEsNiArNjExLDcgQEAgb3V0Og0KIAlyZXR1cm4gcHJp

bnRlZF9sZW47DQogfQ0KIEVYUE9SVF9TWU1CT0wocHJpbnRrKTsNCitFWFBP

UlRfU1lNQk9MKHByaW50a19ub3NwYW0pOw0KIEVYUE9SVF9TWU1CT0wodnBy

aW50ayk7DQogDQogLyoqDQo=


---1463760639-1199172649-1111188901=:4541--
