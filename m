Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286588AbRLUV1D>; Fri, 21 Dec 2001 16:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286589AbRLUV0u>; Fri, 21 Dec 2001 16:26:50 -0500
Received: from bs1.dnx.de ([213.252.143.130]:10659 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S286579AbRLUV0o>;
	Fri, 21 Dec 2001 16:26:44 -0500
Date: Fri, 21 Dec 2001 22:26:20 +0100 (CET)
From: Robert Schwebel <robert@schwebel.de>
X-X-Sender: <robert@callisto.local>
Reply-To: <robert@schwebel.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, <linux-embedded@waste.org>,
        <rkaiser@sysgo.de>
Subject: AMD SC410 boot problems with recent kernels
Message-ID: <Pine.LNX.4.33.0112212154100.10528-200000@callisto.local>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463786752-1172550433-1008969980=:10528"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463786752-1172550433-1008969980=:10528
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

As I reported some days ago in

  http://marc.theaimsgroup.com/?l=linux-kernel&m=100876129529834&q=raw

there are boot problems with new kernels on AMD SC410 processors. Symptom
is that the machine reboots right in the middle of the initialisation of
the serial port (indeed, right in the middle of a printk message).

In the meantime I've tracked down the problem, but cannot fully find the
origin. Here are some facts:

- The problem came in in 2.4.15. Linus has merged in some changes to
  the boot code by H. Peter Anvin (which basically are a Good Thing(TM)).
  They affect arch/i386/boot/setup.S.

- I could narrow it down to the A20 gate routines. My machine's BIOS
  doesn't seem to have the appropiate routine, so the algorithm falls
  back to using the keyboard controller method (which was also used
  in the old code).

- The problem seems to come from the code that waits for A20 gate to
  be _really_ enabled (shortly after a20_kbc:).

Attached is a experimental patch which demonstrates the problem: in line
687 you can change with a jump to "old_wait" or "new_wait" which routine
shall be used. With the old one the machine starts, with the new one it
reboots.

I must say I do not really understand what the problem is. First I thought
that maybe the loop counter overruns, but it doesn't seem to happen. I
have written the counter value to a port with LEDs and it seems to contain
"1" when the waiting loop detects the successful A20 switch.

Any idea would be helpful...

Robert
--
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+







---1463786752-1172550433-1008969980=:10528
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="test-patch-setup.S"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0112212226200.10528@callisto.local>
Content-Description: 
Content-Disposition: attachment; filename="test-patch-setup.S"

LS0tIHNldHVwLTIuNC4xNS5TCUZyaSBOb3YgIDkgMjI6NTg6MDIgMjAwMQ0K
KysrIHNldHVwLlMJRnJpIERlYyAyMSAyMTo0OTo1MCAyMDAxDQpAQCAtNjg0
LDYgKzY4NCw2MiBAQA0KIAlvdXRiCSVhbCwgJDB4NjANCiAJY2FsbAllbXB0
eV84MDQyDQogDQorCWptcAluZXdfd2FpdA0KKw0KKyMgLS0tLS0gb2xkIHdh
aXQgcm91dGluZSAtLS0tLQ0KKw0KK29sZF93YWl0OiANCisNCisjIHdhaXQg
dW50aWwgYTIwIHJlYWxseSAqaXMqIGVuYWJsZWQ7IGl0IGNhbiB0YWtlIGEg
ZmFpciBhbW91bnQgb2YNCisjIHRpbWUgb24gY2VydGFpbiBzeXN0ZW1zOyBU
b3NoaWJhIFRlY3JhcyBhcmUga25vd24gdG8gaGF2ZSB0aGlzDQorIyBwcm9i
bGVtLiAgVGhlIG1lbW9yeSBsb2NhdGlvbiB1c2VkIGhlcmUgKDB4MjAwKSBp
cyB0aGUgaW50IDB4ODANCisjIHZlY3Rvciwgd2hpY2ggc2hvdWxkIGJlIHNh
ZmUgdG8gdXNlLg0KKw0KKw0KKwlwdXNodwklZHgNCisJcHVzaHcJJWN4DQor
CXhvcncJJWR4LCVkeA0KKwl4b3J3CSVjeCwlY3gNCisNCisgICAgICAgIHhv
cncgICAgJWF4LCAlYXggICAgICAgICAgICAgICAgICAgICAgICAjIHNlZ21l
bnQgMHgwMDAwDQorICAgICAgICBtb3Z3ICAgICVheCwgJWZzDQorICAgICAg
ICBkZWN3ICAgICVheCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIyBz
ZWdtZW50IDB4ZmZmZiAoSE1BKQ0KKyAgICAgICAgbW92dyAgICAlYXgsICVn
cw0KK2EyMF93YWl0X29sZDoNCisJaW5jdwklY3gNCisJam56CWdvb24NCisJ
aW5jdwklZHgNCitnb29uOgkNCisgICAgICAgIGluY3cgICAgJWF4ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAjIHVudXNlZCBtZW1vcnkgbG9jYXRp
b24gPDB4ZmZmMA0KKyAgICAgICAgbW92dyAgICAlYXgsICVmczooMHgyMDAp
ICAgICAgICAgICAgICAgICMgd2UgdXNlIHRoZSAiaW50IDB4ODAiIHZlY3Rv
cg0KKyAgICAgICAgY21wdyAgICAlZ3M6KDB4MjEwKSwgJWF4ICAgICAgICAg
ICAgICAgICMgYW5kIGl0cyBjb3JyZXNwb25kaW5nIEhNQSBhZGRyDQorICAg
ICAgICBqZSAgICAgIGEyMF93YWl0X29sZCAgICAgICAgICAgICAgICAgICAg
IyBsb29wIHVudGlsIG5vIGxvbmdlciBhbGlhc2VkDQorDQorCXB1c2h3CSVh
eA0KKw0KKwltb3ZiICAgICQweGE1LCVhbCAgICAgICAgICAgICAgICAgICAg
ICAgIyBzZWxlY3QgUEFNUi4uLg0KKwlvdXRiICAgICVhbCwkMHgyMiAgICAg
ICAgICAgICAgICAgICAgICAgIyAuLi4gdmlhIENTQ0lSDQorCW1vdmIgICAg
JDB4ZmYsJWFsICAgICAgICAgICAgICAgICAgICAgICAjIGFsbCBsaW5lcyBh
cmUgb3V0cHV0DQorCW91dGIgICAgJWFsLCQweDIzICAgICAgICAgICAgICAg
ICAgICAgICAjIC4uLiBvbiBDU0NEUg0KKw0KKwltb3ZiICAgICQweGE5LCVh
bCAgICAgICAgICAgICAgICAgICAgICAgIyBzZWxlY3QgUEFEUi4uLg0KKwlv
dXRiICAgICVhbCwkMHgyMiAgICAgICAgICAgICAgICAgICAgICAgIyAuLi4g
dmlhIENTQ0lSDQorCW1vdmIgICAgJWNoLCVhbAkJCQkjIAkJCQkNCisJb3V0
YiAgICAlYWwsJDB4MjMNCisNCisJcG9wdwklYXgNCisNCisNCisNCisJcG9w
dwklY3gNCisJcG9wdwklZHgNCisNCisJam1wCXJzX3dhaXRfZG9uZQ0KKw0K
KyMgLS0tLS0gbmV3IHdhaXQgcm91dGluZSAtLS0tLQ0KKw0KK25ld193YWl0
OiANCisNCiAJIyBXYWl0IHVudGlsIGEyMCByZWFsbHkgKmlzKiBlbmFibGVk
OyBpdCBjYW4gdGFrZSBhIGZhaXIgYW1vdW50IG9mDQogCSMgdGltZSBvbiBj
ZXJ0YWluIHN5c3RlbXM7IFRvc2hpYmEgVGVjcmFzIGFyZSBrbm93biB0byBo
YXZlIHRoaXMNCiAJIyBwcm9ibGVtLg0KQEAgLTY5NCw2ICs3NTAsMTAgQEAN
CiAJam56CWEyMF9kb25lDQogCWxvb3AJYTIwX2tiY193YWl0X2xvb3ANCiAN
Cityc193YWl0X2RvbmU6DQorDQorIyAtLS0tLSBlbmQgb2Ygd2FpdCAtLS0t
LQ0KKw0KIAkjIEZpbmFsIGF0dGVtcHQ6IHVzZSAiY29uZmlndXJhdGlvbiBw
b3J0IEEiDQogYTIwX2Zhc3Q6DQogCWluYgkkMHg5MiwgJWFsCQkJIyBDb25m
aWd1cmF0aW9uIFBvcnQgQQ0KQEAgLTkwOSwxMiArOTY5LDEyIEBADQogCXB1
c2h3CSVjeA0KIAlwdXNodwklYXgNCiAJeG9ydwklY3gsICVjeA0KLQltb3Z3
CSVjeCwgJWZzCQkJIyBMb3cgbWVtb3J5DQorCW1vdncJJWN4LCAlZnMJCQkj
IExvdyBtZW1vcnkgKHNlZ21lbnQgMHgwMDAwKQ0KIAlkZWN3CSVjeA0KLQlt
b3Z3CSVjeCwgJWdzCQkJIyBIaWdoIG1lbW9yeSBhcmVhDQorCW1vdncJJWN4
LCAlZ3MJCQkjIEhpZ2ggbWVtb3J5IGFyZWEgKHNlZ21lbnQgMHhmZmZmKQ0K
IAltb3Z3CSRBMjBfVEVTVF9MT09QUywgJWN4DQotCW1vdncJJWZzOihBMjBf
VEVTVF9BRERSKSwgJWF4DQotCXB1c2h3CSVheA0KKwltb3Z3CSVmczooQTIw
X1RFU1RfQUREUiksICVheAkjIHB1dCBjb250ZW50IG9mIHRlc3QgYWRkcmVz
cy4uLg0KKwlwdXNodwklYXgJCQkJIyAuLi4gb24gc3RhY2sNCiBhMjBfdGVz
dF93YWl0Og0KIAlpbmN3CSVheA0KIAltb3Z3CSVheCwgJWZzOihBMjBfVEVT
VF9BRERSKQ0K
---1463786752-1172550433-1008969980=:10528--
