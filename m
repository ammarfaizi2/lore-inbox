Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261974AbVCQRYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbVCQRYW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 12:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVCQRYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 12:24:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43410 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261974AbVCQRYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 12:24:12 -0500
Subject: [Patch] ext2/3 file limits to avoid overflowing i_blocks
From: "Stephen C. Tweedie" <sct@redhat.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Stephen Tweedie <sct@redhat.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Content-Type: multipart/mixed; boundary="=-dd8SEXyZ3DM3Y5/zSPfJ"
Message-Id: <1111080221.2684.122.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Thu, 17 Mar 2005 17:23:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dd8SEXyZ3DM3Y5/zSPfJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all,

As discussed before, we can overflow i_blocks in ext2/ext3 inodes by
growing a file up to 2TB.  That gives us 2^32 sectors of data in the
file; but once you add on the indirect tree and possible EA/ACL
metadata, i_blocks will wrap beyond 2^32.  Consensus seemed to be that
the best way to avoid this was simply to stop files getting so large
that this was a problem in the first place; anything else would lead to
complications if a sparse file tried to overflow that 2^32 sector limit
while filling in holes.

I wrote a small program to calculate the total indirect tree overhead
for any given file size, and 0x1ff7fffe000 turned out to be the largest
file we can get without the total i_blocks overflowing 2^32.

But in testing, that *just* wrapped --- we need to limit the file to be
one page smaller than that to deal with the possibility of an EA/ACL
block being accounted against i_blocks.

So this patch has been tested, at least on ext3, by letting a file grow
densely to its maximum size permitted by the kernel; at 0x1ff7fffe000,
stat shows the file to have wrapped back exactly to 0 st_blocks, but
with the limit at 0x1ff7fffd000, du shows it occupying the expected
2TB-blocksize bytes.

Cheers,
 Stephen


--=-dd8SEXyZ3DM3Y5/zSPfJ
Content-Disposition: inline; filename=ext3-file-limit.patch
Content-Type: text/plain; name=ext3-file-limit.patch; charset=ISO-8859-15
Content-Transfer-Encoding: base64

W1BhdGNoXSBleHQyLzMgZmlsZSBsaW1pdHMgdG8gYXZvaWQgb3ZlcmZsb3dpbmcgaV9ibG9ja3MN
Cg0KZXh0Mi8zIGNhbiBjdXJyZW50bHkgb3ZlcmZsb3cgaV9ibG9ja3MgcGFzdCB0aGUgbWF4aW11
bSAyXjMyIHNlY3Rvcg0KKDJUQikgbGltaXQuICBUaGUgZXh0WzIzXV9tYXhfc2l6ZSBmdW5jdGlv
bnMgdHJ5IHRvIGVuZm9yY2UgYW4gdXBwZXINCmxpbWl0IG9mIDJeMzItMSBibG9ja3MgYnkgbGlt
aXRpbmcgdGhlIGZpbGUgc2l6ZSB0byAyVEItYmxvY2tzaXplLCBidXQNCnRoaXMgZmFpbHMgdG8g
YWNjb3VudCBmb3IgaW5kaXJlY3QgYmxvY2sgbWV0YWRhdGEgYW5kIHRoZSBwb3NzaWJpbGl0eSBv
Zg0KYW4gZXh0ZW5kZWQgYXR0cmlidXRlIGJsb2NrIGFsc28gYmVpbmcgYWNjb3VudGVkIGFnYWlu
c3QgaV9ibG9ja3MuDQoNClRoZSBuZXcgZmlsZSBzaXplIGxpbWl0IG9mIDB4MWZmN2ZmZmQwMDAg
YWxsb3dzIGEgZmlsZSB0byBncm93IHRvDQoyXjMyLWJsb2Nrc2l6ZSBzZWN0b3JzLCBhc3N1bWlu
ZyA0ayBibG9ja3NpemUuICAoV2UgZG9uJ3QgaGF2ZSB0byB3b3JyeQ0KYWJvdXQgc21hbGxlciBi
bG9ja3NpemVzIGFzIHRob3NlIGhhdmUgaW5kaXJlY3QgdHJlZSBsaW1pdHMgdGhhdCBkb24ndA0K
bGV0IHRoZWlyIHNpemUgZ3JvdyBuZWFyIHRoaXMgdXBwZXIgYm91bmQgaW4gdGhlIGZpcnN0IHBs
YWNlLikNCg0KU2lnbmVkLW9mZi1ieTogU3RlcGhlbiBUd2VlZGllIDxzY3RAcmVkaGF0LmNvbT4N
Cg0KLS0tIGxpbnV4LTIuNi1leHQzL2ZzL2V4dDIvc3VwZXIuYy49SzAwMDE9Lm9yaWcNCisrKyBs
aW51eC0yLjYtZXh0My9mcy9leHQyL3N1cGVyLmMNCkBAIC01MTgsMTIgKzUxOCwxOCBAQCBzdGF0
aWMgaW50IGV4dDJfY2hlY2tfZGVzY3JpcHRvcnMgKHN0cnVjDQogc3RhdGljIGxvZmZfdCBleHQy
X21heF9zaXplKGludCBiaXRzKQ0KIHsNCiAJbG9mZl90IHJlcyA9IEVYVDJfTkRJUl9CTE9DS1M7
DQorCS8qIFRoaXMgY29uc3RhbnQgaXMgY2FsY3VsYXRlZCB0byBiZSB0aGUgbGFyZ2VzdCBmaWxl
IHNpemUgZm9yIGENCisJICogZGVuc2UsIDRrLWJsb2Nrc2l6ZSBmaWxlIHN1Y2ggdGhhdCB0aGUg
dG90YWwgbnVtYmVyIG9mDQorCSAqIHNlY3RvcnMgaW4gdGhlIGZpbGUsIGluY2x1ZGluZyBkYXRh
IGFuZCBhbGwgaW5kaXJlY3QgYmxvY2tzLA0KKwkgKiBkb2VzIG5vdCBleGNlZWQgMl4zMi4gKi8N
CisJY29uc3QgbG9mZl90IHVwcGVyX2xpbWl0ID0gMHgxZmY3ZmZmZDAwMExMOw0KKw0KIAlyZXMg
Kz0gMUxMIDw8IChiaXRzLTIpOw0KIAlyZXMgKz0gMUxMIDw8ICgyKihiaXRzLTIpKTsNCiAJcmVz
ICs9IDFMTCA8PCAoMyooYml0cy0yKSk7DQogCXJlcyA8PD0gYml0czsNCi0JaWYgKHJlcyA+ICg1
MTJMTCA8PCAzMikgLSAoMSA8PCBiaXRzKSkNCi0JCXJlcyA9ICg1MTJMTCA8PCAzMikgLSAoMSA8
PCBiaXRzKTsNCisJaWYgKHJlcyA+IHVwcGVyX2xpbWl0KQ0KKwkJcmVzID0gdXBwZXJfbGltaXQ7
DQogCXJldHVybiByZXM7DQogfQ0KIA0KLS0tIGxpbnV4LTIuNi1leHQzL2ZzL2V4dDMvc3VwZXIu
Yy49SzAwMDE9Lm9yaWcNCisrKyBsaW51eC0yLjYtZXh0My9mcy9leHQzL3N1cGVyLmMNCkBAIC0x
MTkzLDEyICsxMTkzLDE4IEBAIHN0YXRpYyB2b2lkIGV4dDNfb3JwaGFuX2NsZWFudXAgKHN0cnVj
dCANCiBzdGF0aWMgbG9mZl90IGV4dDNfbWF4X3NpemUoaW50IGJpdHMpDQogew0KIAlsb2ZmX3Qg
cmVzID0gRVhUM19ORElSX0JMT0NLUzsNCisJLyogVGhpcyBjb25zdGFudCBpcyBjYWxjdWxhdGVk
IHRvIGJlIHRoZSBsYXJnZXN0IGZpbGUgc2l6ZSBmb3IgYQ0KKwkgKiBkZW5zZSwgNGstYmxvY2tz
aXplIGZpbGUgc3VjaCB0aGF0IHRoZSB0b3RhbCBudW1iZXIgb2YNCisJICogc2VjdG9ycyBpbiB0
aGUgZmlsZSwgaW5jbHVkaW5nIGRhdGEgYW5kIGFsbCBpbmRpcmVjdCBibG9ja3MsDQorCSAqIGRv
ZXMgbm90IGV4Y2VlZCAyXjMyLiAqLw0KKwljb25zdCBsb2ZmX3QgdXBwZXJfbGltaXQgPSAweDFm
ZjdmZmZkMDAwTEw7DQorDQogCXJlcyArPSAxTEwgPDwgKGJpdHMtMik7DQogCXJlcyArPSAxTEwg
PDwgKDIqKGJpdHMtMikpOw0KIAlyZXMgKz0gMUxMIDw8ICgzKihiaXRzLTIpKTsNCiAJcmVzIDw8
PSBiaXRzOw0KLQlpZiAocmVzID4gKDUxMkxMIDw8IDMyKSAtICgxIDw8IGJpdHMpKQ0KLQkJcmVz
ID0gKDUxMkxMIDw8IDMyKSAtICgxIDw8IGJpdHMpOw0KKwlpZiAocmVzID4gdXBwZXJfbGltaXQp
DQorCQlyZXMgPSB1cHBlcl9saW1pdDsNCiAJcmV0dXJuIHJlczsNCiB9DQogDQo=

--=-dd8SEXyZ3DM3Y5/zSPfJ--
