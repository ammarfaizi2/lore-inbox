Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262036AbVCHMmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbVCHMmh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 07:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbVCHMmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 07:42:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11445 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262026AbVCHMkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 07:40:41 -0500
Subject: [PATCH] invalidate/o_direct livelock {was Re: [RFC] ext3/jbd race:
	releasing in-use journal_heads}
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <1110274110.1941.5.camel@sisko.sctweedie.blueyonder.co.uk>
References: <1109966084.5309.3.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050304160451.4c33919c.akpm@osdl.org>
	 <1110213656.15117.193.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050307123118.3a946bc8.akpm@osdl.org>
	 <1110229687.15117.612.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050307131113.0fd7477e.akpm@osdl.org>
	 <1110230527.15117.625.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1110237205.15117.702.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050307155001.099352b5.akpm@osdl.org>
	 <1110274110.1941.5.camel@sisko.sctweedie.blueyonder.co.uk>
Content-Type: multipart/mixed; boundary="=-pUIBo+LH6ISZs6SSO7wq"
Message-Id: <1110285622.1941.30.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 08 Mar 2005 12:40:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pUIBo+LH6ISZs6SSO7wq
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

On Tue, 2005-03-08 at 09:28, Stephen C. Tweedie wrote:

> I think it should be OK just to move the page->mapping != mapping test
> above the page>index > end test.  Sure, if all the pages have been
> stolen by the time we see them, then we'll repeat without advancing
> "next"; but we're still making progress in that case because pages that
> were previously in this mapping *have* been removed, just by a different
> process.  If we're really concerned about that case we can play the
> trick that invalidate_mapping_pages() tries and do a "next++" in that
> case.

Variant on akpm's last patch with this change, plus one extra
s/page->index/page_index/ that he missed.  I've moved the whole
next=page_index+1 and wrapping check up to just after we've tested the
mapping, so even if we break early all of that updating has already been
done reliably and we don't end up setting next in two places in the
code.

A 400-task fsstress used to livelock reliably within minutes inside
O_DIRECT without any fix; this patch has been running for over an hour
now without problem.

--Stephen


--=-pUIBo+LH6ISZs6SSO7wq
Content-Disposition: inline; filename=invalidate-livelock.patch
Content-Type: text/plain; name=invalidate-livelock.patch; charset=ISO-8859-15
Content-Transfer-Encoding: base64

Rml4IGxpdmVsb2NrIGluIGludmFsaWRhdGVfaW5vZGVfcGFnZXMyX3JhbmdlDQoNCmludmFsaWRh
dGVfaW5vZGVfcGFnZXMyX3JhbmdlIGNhbiBsb29wIGluZGVmaW5pdGVseSBpZiBwYWdldmVjX2xv
b2t1cA0KcmV0dXJucyBvbmx5IHBhZ2VzIGJleW9uZCB0aGUgZW5kIG9mIHRoZSByYW5nZSBiZWlu
ZyBpbnZhbGlkYXRlZC4gIEZpeA0KaXQgYnkgYWR2YW5jaW5nIHRoZSByZXN0YXJ0IHBvaW50ZXIs
ICJuZXh0IiwgZXZlcnkgdGltZSB3ZSBzZWUgYSBwYWdlIG9uDQp0aGUgY29ycmVjdCBtYXBwaW5n
LCBub3QganVzdCBpZiB0aGUgcGFnZSBpcyB3aXRoaW4gdGhlIHJhbmdlOyBhbmQgYnJlYWsNCm91
dCBlYXJseSB3aGVuIHdlIGVuY291bnRlciBzdWNoIGEgcGFnZS4gIEJhc2VkIG9uIGEgcHJvcG9z
ZWQgZml4IGJ5DQpha3BtLg0KDQpTaWduZWQtb2ZmLWJ5OiBTdGVwaGVuIFR3ZWVkaWUgPHNjdEBy
ZWRoYXQuY29tPg0KDQoNCi0tLSBsaW51eC0yLjYtZXh0My9tbS90cnVuY2F0ZS5jLj1LMDAwMj0u
b3JpZw0KKysrIGxpbnV4LTIuNi1leHQzL21tL3RydW5jYXRlLmMNCkBAIC0yNjgsMjUgKzI2OCwz
MSBAQCBpbnQgaW52YWxpZGF0ZV9pbm9kZV9wYWdlczJfcmFuZ2Uoc3RydWN0DQogCQkJbWluKGVu
ZCAtIG5leHQsIChwZ29mZl90KVBBR0VWRUNfU0laRSAtIDEpICsgMSkpIHsNCiAJCWZvciAoaSA9
IDA7ICFyZXQgJiYgaSA8IHBhZ2V2ZWNfY291bnQoJnB2ZWMpOyBpKyspIHsNCiAJCQlzdHJ1Y3Qg
cGFnZSAqcGFnZSA9IHB2ZWMucGFnZXNbaV07DQorCQkJcGdvZmZfdCBwYWdlX2luZGV4Ow0KIAkJ
CWludCB3YXNfZGlydHk7DQogDQogCQkJbG9ja19wYWdlKHBhZ2UpOw0KLQkJCWlmIChwYWdlLT5t
YXBwaW5nICE9IG1hcHBpbmcgfHwgcGFnZS0+aW5kZXggPiBlbmQpIHsNCisJCQlpZiAocGFnZS0+
bWFwcGluZyAhPSBtYXBwaW5nKSB7DQogCQkJCXVubG9ja19wYWdlKHBhZ2UpOw0KIAkJCQljb250
aW51ZTsNCiAJCQl9DQotCQkJd2FpdF9vbl9wYWdlX3dyaXRlYmFjayhwYWdlKTsNCi0JCQluZXh0
ID0gcGFnZS0+aW5kZXggKyAxOw0KKwkJCXBhZ2VfaW5kZXggPSBwYWdlLT5pbmRleDsNCisJCQlu
ZXh0ID0gcGFnZV9pbmRleCArIDE7DQogCQkJaWYgKG5leHQgPT0gMCkNCiAJCQkJd3JhcHBlZCA9
IDE7DQorCQkJaWYgKHBhZ2VfaW5kZXggPiBlbmQpIHsNCisJCQkJdW5sb2NrX3BhZ2UocGFnZSk7
DQorCQkJCWJyZWFrOw0KKwkJCX0NCisJCQl3YWl0X29uX3BhZ2Vfd3JpdGViYWNrKHBhZ2UpOw0K
IAkJCXdoaWxlIChwYWdlX21hcHBlZChwYWdlKSkgew0KIAkJCQlpZiAoIWRpZF9yYW5nZV91bm1h
cCkgew0KIAkJCQkJLyoNCiAJCQkJCSAqIFphcCB0aGUgcmVzdCBvZiB0aGUgZmlsZSBpbiBvbmUg
aGl0Lg0KIAkJCQkJICovDQogCQkJCQl1bm1hcF9tYXBwaW5nX3JhbmdlKG1hcHBpbmcsDQotCQkJ
CQkgICAgcGFnZS0+aW5kZXggPDwgUEFHRV9DQUNIRV9TSElGVCwNCi0JCQkJCSAgICAoZW5kIC0g
cGFnZS0+aW5kZXggKyAxKQ0KKwkJCQkJICAgIHBhZ2VfaW5kZXggPDwgUEFHRV9DQUNIRV9TSElG
VCwNCisJCQkJCSAgICAoZW5kIC0gcGFnZV9pbmRleCArIDEpDQogCQkJCQkJCTw8IFBBR0VfQ0FD
SEVfU0hJRlQsDQogCQkJCQkgICAgMCk7DQogCQkJCQlkaWRfcmFuZ2VfdW5tYXAgPSAxOw0KQEAg
LTI5NSw3ICszMDEsNyBAQCBpbnQgaW52YWxpZGF0ZV9pbm9kZV9wYWdlczJfcmFuZ2Uoc3RydWN0
DQogCQkJCQkgKiBKdXN0IHphcCB0aGlzIHBhZ2UNCiAJCQkJCSAqLw0KIAkJCQkJdW5tYXBfbWFw
cGluZ19yYW5nZShtYXBwaW5nLA0KLQkJCQkJICBwYWdlLT5pbmRleCA8PCBQQUdFX0NBQ0hFX1NI
SUZULA0KKwkJCQkJICBwYWdlX2luZGV4IDw8IFBBR0VfQ0FDSEVfU0hJRlQsDQogCQkJCQkgIFBB
R0VfQ0FDSEVfU0laRSwgMCk7DQogCQkJCX0NCiAJCQl9DQo=

--=-pUIBo+LH6ISZs6SSO7wq--
