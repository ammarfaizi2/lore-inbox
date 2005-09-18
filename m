Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbVIRXWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbVIRXWj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 19:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbVIRXWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 19:22:39 -0400
Received: from tiere.net.avaya.com ([198.152.12.100]:44978 "EHLO
	tiere.net.avaya.com") by vger.kernel.org with ESMTP id S932261AbVIRXWj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 19:22:39 -0400
Date: Sun, 18 Sep 2005 17:22:32 -0600 (MDT)
From: "Bhavesh P. Davda" <bhavesh@avaya.com>
X-X-Sender: <bhaveshd@drces.dr.avaya.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Show Mr. SIGKILL some R-E-S-P-E-C-T
Message-ID: <Pine.GSO.4.33.0509181718230.17133-200000@drces.dr.avaya.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1127085752=:17133"
X-OriginalArrivalTime: 18 Sep 2005 23:22:32.0352 (UTC) FILETIME=[D83F6200:01C5BCA7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-1127085752=:17133
Content-Type: TEXT/PLAIN; charset=US-ASCII


Here's the scenario (single-threaded, multi-threaded doesn't matter)

# kill -STOP pid
# egrep "^State|^SigPnd|^ShdPnd" /proc/pid/status
State:  T (stopped)
SigPnd: 0000000000000000
ShdPnd: 0000000000000000

The following command sends a signal to the specified thread ID using the
tkill(2) syscall interface

# tkill -ALRM pid (Or any other signal other than SIGCONT or SIGKILL)
# egrep "^State|^SigPnd|^ShdPnd" /proc/pid/status
State:  T (stopped)
SigPnd: 0000000000002000  [ SIGALRM pending ]
ShdPnd: 0000000000000000

# kill -ABRT pid
# egrep "^State|^SigPnd|^ShdPnd" /proc/pid/status
State:  T (stopped)
SigPnd: 0000000000002000  [ SIGALRM pending ]
ShdPnd: 0000000000000020  [ SIGABRT pending ]

# kill -KILL pid
# egrep "^State|^SigPnd|^ShdPnd" /proc/pid/status
State:  T (stopped)
SigPnd: 0000000000002000  [ SIGALRM pending ]
ShdPnd: 0000000000000120  [ SIGABRT and SIGKILL pending ]

EGAD! SIGKILL should have whacked the pid, no matter what.

Here's a patch that fixes this.

Thanks!

- Bhavesh

Bhavesh P. Davda | Distinguished Member of Technical Staff | Avaya |
1300 West 120th Avenue | B3-B03 | Westminster, CO 80234 | U.S.A. |
Voice/Fax: 303.538.4438 | bhavesh@avaya.com

---559023410-851401618-1127085752=:17133
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="sigkill.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0509181722320.17133@drces.dr.avaya.com>
Content-Description: 
Content-Disposition: attachment; filename="sigkill.patch"

LS0tIGEva2VybmVsL3NpZ25hbC5jCTIwMDUtMDktMTIgMTU6NTA6MTYuMDAw
MDAwMDAwIC0wNjAwDQorKysgYi9rZXJuZWwvc2lnbmFsLmMJMjAwNS0wOS0x
NyAxMjowNDo1OC44OTg0NjU3MjggLTA2MDANCkBAIC05MzUsMTAgKzkzNSwx
MSBAQA0KICAqIGhhdmUgcGVuZGluZyBzaWduYWxzLiAgU3VjaCB0aHJlYWRz
IHdpbGwgZGVxdWV1ZSBmcm9tIHRoZSBzaGFyZWQgcXVldWUNCiAgKiBhcyBz
b29uIGFzIHRoZXkncmUgYXZhaWxhYmxlLCBzbyBwdXR0aW5nIHRoZSBzaWdu
YWwgb24gdGhlIHNoYXJlZCBxdWV1ZQ0KICAqIHdpbGwgYmUgZXF1aXZhbGVu
dCB0byBzZW5kaW5nIGl0IHRvIG9uZSBzdWNoIHRocmVhZC4NCisgKiBEb24n
dCBib3RoZXIgdHJhY2VkIGFuZCBzdG9wcGVkIHRhc2tzDQogICovDQotI2Rl
ZmluZSB3YW50c19zaWduYWwoc2lnLCBwLCBtYXNrKSAJCQlcDQorI2RlZmlu
ZSB3YW50c19zaWduYWwoc2lnLCBwKSAJCQkJXA0KIAkoIXNpZ2lzbWVtYmVy
KCYocCktPmJsb2NrZWQsIHNpZykJCVwNCi0JICYmICEoKHApLT5zdGF0ZSAm
IG1hc2spCQkJXA0KKwkgJiYgISgocCktPnN0YXRlICYgKFRBU0tfU1RPUFBF
RHxUQVNLX1RSQUNFRCkpCVwNCiAJICYmICEoKHApLT5mbGFncyAmIFBGX0VY
SVRJTkcpCQkJXA0KIAkgJiYgKHRhc2tfY3VycihwKSB8fCAhc2lnbmFsX3Bl
bmRpbmcocCkpKQ0KIA0KQEAgLTk0NiwyNCArOTQ3LDE3IEBADQogc3RhdGlj
IHZvaWQNCiBfX2dyb3VwX2NvbXBsZXRlX3NpZ25hbChpbnQgc2lnLCBzdHJ1
Y3QgdGFza19zdHJ1Y3QgKnApDQogew0KLQl1bnNpZ25lZCBpbnQgbWFzazsN
CiAJc3RydWN0IHRhc2tfc3RydWN0ICp0Ow0KIA0KIAkvKg0KLQkgKiBEb24n
dCBib3RoZXIgdHJhY2VkIGFuZCBzdG9wcGVkIHRhc2tzIChidXQNCi0JICog
U0lHS0lMTCB3aWxsIHB1bmNoIHRocm91Z2ggdGhhdCkuDQotCSAqLw0KLQlt
YXNrID0gVEFTS19TVE9QUEVEIHwgVEFTS19UUkFDRUQ7DQotCWlmIChzaWcg
PT0gU0lHS0lMTCkNCi0JCW1hc2sgPSAwOw0KLQ0KLQkvKg0KIAkgKiBOb3cg
ZmluZCBhIHRocmVhZCB3ZSBjYW4gd2FrZSB1cCB0byB0YWtlIHRoZSBzaWdu
YWwgb2ZmIHRoZSBxdWV1ZS4NCiAJICoNCiAJICogSWYgdGhlIG1haW4gdGhy
ZWFkIHdhbnRzIHRoZSBzaWduYWwsIGl0IGdldHMgZmlyc3QgY3JhY2suDQog
CSAqIFByb2JhYmx5IHRoZSBsZWFzdCBzdXJwcmlzaW5nIHRvIHRoZSBhdmVy
YWdlIGJlYXIuDQorCSAqDQorCSAqIFNJR0tJTEwgaXMgYWx3YXlzIGRlbGl2
ZXJlZCB0byB0aGUgbWFpbiB0aHJlYWQNCiAJICovDQotCWlmICh3YW50c19z
aWduYWwoc2lnLCBwLCBtYXNrKSkNCisJaWYgKChzaWcgPT0gU0lHS0lMTCkg
fHwgKHdhbnRzX3NpZ25hbChzaWcsIHApKSkNCiAJCXQgPSBwOw0KIAllbHNl
IGlmICh0aHJlYWRfZ3JvdXBfZW1wdHkocCkpDQogCQkvKg0KQEAgLTk4MSw3
ICs5NzUsNyBAQA0KIAkJCXQgPSBwLT5zaWduYWwtPmN1cnJfdGFyZ2V0ID0g
cDsNCiAJCUJVR19PTih0LT50Z2lkICE9IHAtPnRnaWQpOw0KIA0KLQkJd2hp
bGUgKCF3YW50c19zaWduYWwoc2lnLCB0LCBtYXNrKSkgew0KKwkJd2hpbGUg
KCF3YW50c19zaWduYWwoc2lnLCB0KSkgew0KIAkJCXQgPSBuZXh0X3RocmVh
ZCh0KTsNCiAJCQlpZiAodCA9PSBwLT5zaWduYWwtPmN1cnJfdGFyZ2V0KQ0K
IAkJCQkvKg0K
---559023410-851401618-1127085752=:17133--
