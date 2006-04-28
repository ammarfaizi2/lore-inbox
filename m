Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWD1WX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWD1WX4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 18:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbWD1WX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 18:23:56 -0400
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:11934 "EHLO
	mail8.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751773AbWD1WX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 18:23:56 -0400
Date: Fri, 28 Apr 2006 15:23:55 -0700 (PDT)
From: Trent Piepho <xyzzy@speakeasy.org>
X-X-Sender: xyzzy@shell3.speakeasy.net
To: linux-kernel@vger.kernel.org
cc: xyzzy@speakeasy.org
Subject: [PATCH] symbol_put_addr() locks kernel
Message-ID: <Pine.LNX.4.58.0604281508560.14508@shell3.speakeasy.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="289735796-49824383-1146263035=:14508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--289735796-49824383-1146263035=:14508
Content-Type: TEXT/PLAIN; charset=US-ASCII

Please CC me on any replies, I'm not subscribed.

Even since a previous patch:

Fix race between CONFIG_DEBUG_SLABALLOC and modules
Sun, 27 Jun 2004 17:55:19 +0000 (17:55 +0000)
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git;a=commit;h=92b3db26d31cf21b70e3c1eadc56c179506d8fbe

The function symbol_put_addr() will deadlock the kernel.
symbol_put_addr() acquires the modlist_lock spinlock, then calls
kernel_text_address() and module_text_address() while it still holds
the lock.  That patch changed those two functions so they also try to
acquire the spinlock, which of course locks the kernel.

If you look at the original thread:  http://lkml.org/lkml/2004/6/23/20
The first patch corrected symbol_put_addr() to use the new
"double-underscore" functions that don't try to acquire the lock, but
the final patch missed symbol_put_addr().

Here is a patch which fixes this.  The locking inside
symbol_put_addr() is removed.  I changed symbol_put_addr() to call
core_kernel_text() instead of kernel_text_address(), the latter
includes an additional check if the addr is inside a module.  Since we
will call module_text_address() to get the module, this extra check
isn't needed.
--289735796-49824383-1146263035=:14508
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="symbol_put_addr.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0604281523550.14508@shell3.speakeasy.net>
Content-Description: 
Content-Disposition: attachment; filename="symbol_put_addr.patch"

IyBIRyBjaGFuZ2VzZXQgcGF0Y2gNCiMgVXNlciBUcmVudCBQaWVwaG8gPHh5
enp5QHNwZWFrZWFzeS5vcmc+DQojIE5vZGUgSUQgYjY2ZjNhYTRiZmU4OGY5
ZWEyZWRiOWM4NzQxOTQxM2VjYzZjYWE4Yw0KIyBQYXJlbnQgIDRjM2YyNDFk
N2JjNTNmYzI1ZGRhYjU0MTQwZjk2Y2FjZDcxYWUxZTENCkZyb206IFRyZW50
IFBpZXBobyA8eHl6enlAc3BlYWtlYXN5Lm9yZz4NCg0Kc3ltYm9sX3B1dF9h
ZGRyKCkgd291bGQgYWNxdWlyZSBtb2RsaXN0X2xvY2ssIHRoZW4gd2hpbGUg
aG9sZGluZyB0aGUgbG9jayBjYWxsDQp0d28gZnVuY3Rpb25zIGtlcm5lbF90
ZXh0X2FkZHJlc3MoKSBhbmQgbW9kdWxlX3RleHRfYWRkcmVzcygpIHdoaWNo
IGFsc28gdHJ5DQp0byBhY3F1aXJlIHRoZSBzYW1lIGxvY2suICBUaGlzIGRl
YWRsb2NrcyB0aGUga2VybmVsIG9mIGNvdXJzZS4NCg0KVGhpcyBwYXRjaCBj
aGFuZ2VzIHN5bWJvbF9wdXRfYWRkcigpIHRvIG5vdCBhY3F1aXJlIHRoZSBt
b2RsaXN0X2xvY2ssIGl0DQpkb2Vzbid0IG5lZWQgaXQgc2luY2UgaXQgbmV2
ZXIgbG9va3MgYXQgdGhlIG1vZHVsZSBsaXN0IGRpcmVjdGx5LiAgQWxzbywg
aXQNCm5vdyB1c2VzIGNvcmVfa2VybmVsX3RleHQoKSBpbnN0ZWFkIG9mIGtl
cm5lbF90ZXh0X2FkZHJlc3MoKS4gIFRoZSBsYXR0ZXINCmhhcyBhbiBhZGRp
dGlvbmFsIGNoZWNrIGZvciBhZGRyIGluc2lkZSBhIG1vZHVsZSwgYnV0IHdl
IGRvbid0IG5lZWQgdG8gZG8gdGhhdA0Kc2luY2Ugd2UgY2FsbCBtb2R1bGVf
dGV4dF9hZGRyZXNzKCkgKHRoZSBzYW1lIGZ1bmN0aW9uIGtlcm5lbF90ZXh0
X2FkZHJlc3MNCnVzZXMpIG91cnNlbHZlcy4NCg0KDQpTaWduZWQtb2ZmLWJ5
OiBUcmVudCBQaWVwaG8gPHh5enp5QHNwZWFrZWFzeS5vcmc+DQoNCiANCiBp
bmNsdWRlL2xpbnV4L2tlcm5lbC5oIHwgICAgMSArDQoga2VybmVsL2V4dGFi
bGUuYyAgICAgICB8ICAgIDIgKy0NCiBrZXJuZWwvbW9kdWxlLmMgICAgICAg
IHwgICAxNCArKysrKysrLS0tLS0tLQ0KIDMgZmlsZXMgY2hhbmdlZCwgOSBp
bnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC1yIDRjM2Yy
NDFkN2JjNSAtciBiNjZmM2FhNGJmZTggaW5jbHVkZS9saW51eC9rZXJuZWwu
aA0KLS0tIGEvaW5jbHVkZS9saW51eC9rZXJuZWwuaAlGcmkgQXByIDI4IDIz
OjAwOjM1IDIwMDYgKzA3MDANCisrKyBiL2luY2x1ZGUvbGludXgva2VybmVs
LmgJRnJpIEFwciAyOCAxNDo0OTozNCAyMDA2IC0wNzAwDQpAQCAtMTI0LDYg
KzEyNCw3IEBAIGV4dGVybiBjaGFyICpnZXRfb3B0aW9ucyhjb25zdCBjaGFy
ICpzdHINCiBleHRlcm4gY2hhciAqZ2V0X29wdGlvbnMoY29uc3QgY2hhciAq
c3RyLCBpbnQgbmludHMsIGludCAqaW50cyk7DQogZXh0ZXJuIHVuc2lnbmVk
IGxvbmcgbG9uZyBtZW1wYXJzZShjaGFyICpwdHIsIGNoYXIgKipyZXRwdHIp
Ow0KIA0KK2V4dGVybiBpbnQgY29yZV9rZXJuZWxfdGV4dCh1bnNpZ25lZCBs
b25nIGFkZHIpOw0KIGV4dGVybiBpbnQgX19rZXJuZWxfdGV4dF9hZGRyZXNz
KHVuc2lnbmVkIGxvbmcgYWRkcik7DQogZXh0ZXJuIGludCBrZXJuZWxfdGV4
dF9hZGRyZXNzKHVuc2lnbmVkIGxvbmcgYWRkcik7DQogZXh0ZXJuIGludCBz
ZXNzaW9uX29mX3BncnAoaW50IHBncnApOw0KZGlmZiAtciA0YzNmMjQxZDdi
YzUgLXIgYjY2ZjNhYTRiZmU4IGtlcm5lbC9leHRhYmxlLmMNCi0tLSBhL2tl
cm5lbC9leHRhYmxlLmMJRnJpIEFwciAyOCAyMzowMDozNSAyMDA2ICswNzAw
DQorKysgYi9rZXJuZWwvZXh0YWJsZS5jCUZyaSBBcHIgMjggMTQ6NDk6MzQg
MjAwNiAtMDcwMA0KQEAgLTQwLDcgKzQwLDcgQEAgY29uc3Qgc3RydWN0IGV4
Y2VwdGlvbl90YWJsZV9lbnRyeSAqc2Vhcg0KIAlyZXR1cm4gZTsNCiB9DQog
DQotc3RhdGljIGludCBjb3JlX2tlcm5lbF90ZXh0KHVuc2lnbmVkIGxvbmcg
YWRkcikNCitpbnQgY29yZV9rZXJuZWxfdGV4dCh1bnNpZ25lZCBsb25nIGFk
ZHIpDQogew0KIAlpZiAoYWRkciA+PSAodW5zaWduZWQgbG9uZylfc3RleHQg
JiYNCiAJICAgIGFkZHIgPD0gKHVuc2lnbmVkIGxvbmcpX2V0ZXh0KQ0KZGlm
ZiAtciA0YzNmMjQxZDdiYzUgLXIgYjY2ZjNhYTRiZmU4IGtlcm5lbC9tb2R1
bGUuYw0KLS0tIGEva2VybmVsL21vZHVsZS5jCUZyaSBBcHIgMjggMjM6MDA6
MzUgMjAwNiArMDcwMA0KKysrIGIva2VybmVsL21vZHVsZS5jCUZyaSBBcHIg
MjggMTQ6NDk6MzQgMjAwNiAtMDcwMA0KQEAgLTcwNSwxNCArNzA1LDE0IEBA
IEVYUE9SVF9TWU1CT0woX19zeW1ib2xfcHV0KTsNCiANCiB2b2lkIHN5bWJv
bF9wdXRfYWRkcih2b2lkICphZGRyKQ0KIHsNCi0JdW5zaWduZWQgbG9uZyBm
bGFnczsNCi0NCi0Jc3Bpbl9sb2NrX2lycXNhdmUoJm1vZGxpc3RfbG9jaywg
ZmxhZ3MpOw0KLQlpZiAoIWtlcm5lbF90ZXh0X2FkZHJlc3MoKHVuc2lnbmVk
IGxvbmcpYWRkcikpDQorCXN0cnVjdCBtb2R1bGUgKm1vZGFkZHI7DQorDQor
CWlmIChjb3JlX2tlcm5lbF90ZXh0KCh1bnNpZ25lZCBsb25nKWFkZHIpKQ0K
KwkJcmV0dXJuOw0KKw0KKwlpZiAoIShtb2RhZGRyID0gbW9kdWxlX3RleHRf
YWRkcmVzcygodW5zaWduZWQgbG9uZylhZGRyKSkpDQogCQlCVUcoKTsNCi0N
Ci0JbW9kdWxlX3B1dChtb2R1bGVfdGV4dF9hZGRyZXNzKCh1bnNpZ25lZCBs
b25nKWFkZHIpKTsNCi0Jc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmbW9kbGlz
dF9sb2NrLCBmbGFncyk7DQorCW1vZHVsZV9wdXQobW9kYWRkcik7DQogfQ0K
IEVYUE9SVF9TWU1CT0xfR1BMKHN5bWJvbF9wdXRfYWRkcik7DQogDQo=

--289735796-49824383-1146263035=:14508--
