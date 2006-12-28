Return-Path: <linux-kernel-owner+w=401wt.eu-S1753701AbWL1UPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701AbWL1UPL (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 15:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753737AbWL1UPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 15:15:11 -0500
Received: from smtp.osdl.org ([65.172.181.25]:56176 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753701AbWL1UPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 15:15:09 -0500
Date: Thu, 28 Dec 2006 12:14:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Guillaume Chazarain <guichaz@yahoo.fr>, David Miller <davem@davemloft.net>,
       ranma@tdiedrich.de, gordonfarquharson@gmail.com, tbm@cyrius.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, andrei.popa@i-neo.ro,
       hugh@veritas.com, nickpiggin@yahoo.com.au, arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chen Kenneth W <kenneth.w.chen@intel.com>
Subject: Re: [PATCH] mm: fix page_mkclean_one
In-Reply-To: <20061228114517.3315aee7.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612281156150.4473@woody.osdl.org>
References: <20061226.205518.63739038.davem@davemloft.net>
 <Pine.LNX.4.64.0612271601430.4473@woody.osdl.org>
 <Pine.LNX.4.64.0612271636540.4473@woody.osdl.org> <20061227.165246.112622837.davem@davemloft.net>
 <Pine.LNX.4.64.0612271835410.4473@woody.osdl.org> <4593DE31.4070401@yahoo.fr>
 <459418D2.2000702@yahoo.fr> <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org>
 <20061228114517.3315aee7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463790079-528681190-1167336871=:4473"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463790079-528681190-1167336871=:4473
Content-Type: TEXT/PLAIN; charset=US-ASCII



On Thu, 28 Dec 2006, Andrew Morton wrote:
> 
> It would be interesting to convert your app to do fsync() before
> FADV_DONTNEED.  That would take WB_SYNC_NONE out of the picture as well
> (apart from pdflush activity).

I get corruption - but the whole point is that it's very much pdflush that 
should be writing these pages out.

Andrew - give my test-program a try. It can run in about 1 minute if you 
have a 256MB machine (I didn't, but "mem=256M" is my friend), and it seems 
to very consistently cause corruption.

What I do is:

	# Make sure we write back aggressively
	echo 5 > /proc/sys/vm/dirty_ratio

as root, and then just run the thing. Tons of corruption. But the 
corruption goes away if I just leave the default dirty ratio alone (but 
then I can increse the file size to trigger it, of course - but that 
also makes the test run a lot slower).

Now, with a pre-2.6.19 kernel, I bet you won't get the corruption as 
easily (at least with the "fsync()"), but that's less to do with anything 
new, and probably just because then you simply won't have any pdflushing 
going on - since the kernel won't even notice that you have tons of dirty 
pages ;)

It might also depend on the speed of your disk drive - the machine I test 
this on has a slow 4200 rpm laptop drive in it, and that probably makes 
things go south more easily. That's _especially_ true if this is related 
to any "bdi_write_congested()" logic.

Now, it could also be related to various code snippets like

	...
	if (wbc->sync_mode != WB_SYNC_NONE)
		wait_on_page_writeback(page);

	if (PageWriteback(page) ||
			!clear_page_dirty_for_io(page)) {
		unlock_page(page);
		continue;
	}
	...

where the WB_SYNC_NONE case will hit the "PageWriteback()" and just not do 
the writeback at all (but it also won't clear the dirty bit, so it's 
certainly not an *OBVIOUS* bug).

We also have code like this ("pageout()"):

	if (clear_page_dirty_for_io(page)) {
		int res;
		struct writeback_control wbc = {
			.sync_mode = WB_SYNC_NONE,
			..
		}
		...
		res = mapping->a_ops->writepage(page, &wbc);

and in this case, if the "WB_SYNC_NONE" means that the "writepage()" call 
won't do anything at all because of congestion, then that would be a _bad_ 
thing, and would certainly explain how something didn't get written out.

But that particular path should only trigger for the "shrink_page_list()" 
case, and it's not the case I seem to be testing with my "low dirty_ratio" 
testing.

		Linus
---1463790079-528681190-1167336871=:4473
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=test.c
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0612281214310.4473@woody.osdl.org>
Content-Description: 
Content-Disposition: attachment; filename=test.c

I2luY2x1ZGUgPHN5cy9tbWFuLmg+DQojaW5jbHVkZSA8c3lzL2ZjbnRsLmg+
DQojaW5jbHVkZSA8dW5pc3RkLmg+DQojaW5jbHVkZSA8c3RkbGliLmg+DQoj
aW5jbHVkZSA8c3RyaW5nLmg+DQojaW5jbHVkZSA8c3RkaW8uaD4NCiNpbmNs
dWRlIDx0aW1lLmg+DQoNCiNkZWZpbmUgVEFSR0VUU0laRSAoMjIgPDwgMjAp
DQojZGVmaW5lIENIVU5LU0laRSAoMTQ2MCkNCiNkZWZpbmUgTlJDSFVOS1Mg
KFRBUkdFVFNJWkUgLyBDSFVOS1NJWkUpDQojZGVmaW5lIFNJWkUgKE5SQ0hV
TktTICogQ0hVTktTSVpFKQ0KDQpzdGF0aWMgdm9pZCBmaWxsbWVtKHZvaWQg
KnN0YXJ0LCBpbnQgbnIpDQp7DQoJbWVtc2V0KHN0YXJ0LCBuciwgQ0hVTktT
SVpFKTsNCn0NCg0KI2RlZmluZSBwYWdlX29mZnNldChidWYsIG9mZikgKHVu
c2lnbmVkKSgodW5zaWduZWQgbG9uZykoYnVmKSsob2ZmKS0odW5zaWduZWQg
bG9uZykobWFwcGluZykpDQoNCnN0YXRpYyBpbnQgY2h1bmtvcmRlcltOUkNI
VU5LU107DQpzdGF0aWMgY2hhciAqbWFwcGluZzsNCg0Kc3RhdGljIGludCBv
cmRlcihpbnQgbnIpDQp7DQoJaW50IGk7DQoJaWYgKG5yIDwgMCB8fCBuciA+
PSBOUkNIVU5LUykNCgkJcmV0dXJuIC0xOw0KCWZvciAoaSA9IDA7IGkgPCBO
UkNIVU5LUzsgaSsrKQ0KCQlpZiAoY2h1bmtvcmRlcltpXSA9PSBucikNCgkJ
CXJldHVybiBpOw0KCXJldHVybiAtMjsNCn0NCg0Kc3RhdGljIHZvaWQgY2hl
Y2ttZW0odm9pZCAqYnVmLCBpbnQgbnIpDQp7DQoJdW5zaWduZWQgaW50IHN0
YXJ0ID0gfjB1LCBlbmQgPSAwOw0KCXVuc2lnbmVkIGNoYXIgYyA9IG5yLCAq
cCA9IGJ1ZiwgZGlmZmVycyA9IDA7DQoJaW50IGk7DQoJZm9yIChpID0gMDsg
aSA8IENIVU5LU0laRTsgaSsrKSB7DQoJCXVuc2lnbmVkIGNoYXIgZ290ID0g
KnArKzsNCgkJaWYgKGdvdCAhPSBjKSB7DQoJCQlpZiAoaSA8IHN0YXJ0KQ0K
CQkJCXN0YXJ0ID0gaTsNCgkJCWlmIChpID4gZW5kKQ0KCQkJCWVuZCA9IGk7
DQoJCQlkaWZmZXJzID0gZ290Ow0KCQl9DQoJfQ0KCWlmIChzdGFydCA8IGVu
ZCkgew0KCQlwcmludGYoIkNodW5rICVkIGNvcnJ1cHRlZCAoJXUtJXUpICAo
JXgtJXgpICAgICAgICAgICAgXG4iLCBuciwgc3RhcnQsIGVuZCwNCgkJCXBh
Z2Vfb2Zmc2V0KGJ1Ziwgc3RhcnQpLCBwYWdlX29mZnNldChidWYsIGVuZCkp
Ow0KCQlwcmludGYoIkV4cGVjdGVkICV1LCBnb3QgJXVcbiIsIGMsIGRpZmZl
cnMpOw0KCQlwcmludGYoIldyaXR0ZW4gYXMgKCVkKSVkKCVkKVxuIiwgb3Jk
ZXIobnItMSksIG9yZGVyKG5yKSwgb3JkZXIobnIrMSkpOw0KCX0NCn0NCg0K
c3RhdGljIGNoYXIgKnJlbWFwKGludCBmZCwgY2hhciAqbWFwcGluZykNCnsN
CglpZiAobWFwcGluZykgew0KCQltdW5tYXAobWFwcGluZywgU0laRSk7DQov
LwkJZnN5bmMoZmQpOw0KCQlwb3NpeF9mYWR2aXNlKGZkLCAwLCBTSVpFLCBQ
T1NJWF9GQURWX0RPTlRORUVEKTsNCgl9DQoJcmV0dXJuIG1tYXAoTlVMTCwg
U0laRSwgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwgTUFQX1NIQVJFRCwgZmQs
IDApOw0KfQ0KDQppbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQp7
DQoJaW50IGZkLCBpOw0KDQoJLyoNCgkgKiBNYWtlIHNvbWUgcmFuZG9tIG9y
ZGVyaW5nIG9mIHdyaXRpbmcgdGhlIGNodW5rcyB0byB0aGUNCgkgKiBtZW1v
cnkgbWFwLi4NCgkgKg0KCSAqIFN0YXJ0IHdpdGggZnVsbHkgb3JkZXJlZC4u
DQoJICovDQoJZm9yIChpID0gMDsgaSA8IE5SQ0hVTktTOyBpKyspDQoJCWNo
dW5rb3JkZXJbaV0gPSBpOw0KDQoJLyogLi5hbmQgdGhlbiBtaXggaXQgdXAg
cmFuZG9tbHkgKi8NCglzcmFuZG9tKHRpbWUoTlVMTCkpOw0KCWZvciAoaSA9
IDA7IGkgPCBOUkNIVU5LUzsgaSsrKSB7DQoJCWludCBpbmRleCA9ICh1bnNp
Z25lZCBpbnQpIHJhbmRvbSgpICUgTlJDSFVOS1M7DQoJCWludCBuciA9IGNo
dW5rb3JkZXJbaW5kZXhdOw0KCQljaHVua29yZGVyW2luZGV4XSA9IGNodW5r
b3JkZXJbaV07DQoJCWNodW5rb3JkZXJbaV0gPSBucjsNCgl9DQoNCglmZCA9
IG9wZW4oIm1hcGZpbGUiLCBPX1JEV1IgfCBPX1RSVU5DIHwgT19DUkVBVCwg
MDY2Nik7DQoJaWYgKGZkIDwgMCkNCgkJcmV0dXJuIC0xOw0KCWlmIChmdHJ1
bmNhdGUoZmQsIFNJWkUpIDwgMCkNCgkJcmV0dXJuIC0xOw0KCW1hcHBpbmcg
PSByZW1hcChmZCwgTlVMTCk7DQoJaWYgKC0xID09IChpbnQpKGxvbmcpbWFw
cGluZykNCgkJcmV0dXJuIC0xOw0KDQoJZm9yIChpID0gMDsgaSA8IE5SQ0hV
TktTOyBpKyspIHsNCgkJaW50IGNodW5rID0gY2h1bmtvcmRlcltpXTsNCgkJ
cHJpbnRmKCJXcml0aW5nIGNodW5rICVkLyVkICglZCUlKSAgICAgXHIiLCBp
LCBOUkNIVU5LUywgMTAwKmkvTlJDSFVOS1MpOw0KCQlmaWxsbWVtKG1hcHBp
bmcgKyBjaHVuayAqIENIVU5LU0laRSwgY2h1bmspOw0KCX0NCglwcmludGYo
IlxuIik7DQoNCgkvKiBVbm1hcCwgZHJvcCwgYW5kIHJlbWFwLi4gKi8NCglt
YXBwaW5nID0gcmVtYXAoZmQsIG1hcHBpbmcpOw0KDQoJLyogLi4gYW5kIGNo
ZWNrICovDQoJZm9yIChpID0gMDsgaSA8IE5SQ0hVTktTOyBpKyspIHsNCgkJ
aW50IGNodW5rID0gaTsNCgkJcHJpbnRmKCJDaGVja2luZyBjaHVuayAlZC8l
ZCAoJWQlJSkgICAgIFxyIiwgaSwgTlJDSFVOS1MsIDEwMCppL05SQ0hVTktT
KTsNCgkJY2hlY2ttZW0obWFwcGluZyArIGNodW5rICogQ0hVTktTSVpFLCBj
aHVuayk7DQoJfQ0KCXByaW50ZigiXG4iKTsNCg0KCS8qIENsZWFuIHVwIGZv
ciBuZXh0IHRpbWUgKi8NCglzbGVlcCg1KTsNCglzeW5jKCk7DQoJc2xlZXAo
NSk7DQoJbXVubWFwKG1hcHBpbmcsIFNJWkUpOw0KCWNsb3NlKGZkKTsNCgl1
bmxpbmsoIm1hcGZpbGUiKTsNCgkNCglyZXR1cm4gMDsNCn0NCg==

---1463790079-528681190-1167336871=:4473--
