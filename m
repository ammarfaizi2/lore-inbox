Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267945AbUHPUb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267945AbUHPUb6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 16:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267946AbUHPUb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 16:31:58 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:30440 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267945AbUHPUaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 16:30:55 -0400
Date: Mon, 16 Aug 2004 13:30:06 -0700 (PDT)
From: Ram Pai <linuxram@us.ibm.com>
X-X-Sender: ram@localhost.localdomain
Reply-To: linuxram@us.ibm.com
To: akpm@osdl.org
cc: "Mr. Berkley Shands" <berkley@cse.wustl.edu>,
       <linux-kernel@vger.kernel.org>, <miklos@szeredi.hu>, <shrybman@aei.ca>,
       <badari@us.ibm.com>
Subject: [PATCH] Re: Fast patch for Severe I/O performance regression 2.6.6
 to 2.6.7 or 2.6.8-rc3
In-Reply-To: <Pine.LNX.4.44.0408080104270.23623-200000@dyn319181.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0408161303550.20970-200000@localhost.localdomain>
Organization: IBM Linux Technology Center
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-118656043-1092687689=:20970"
Content-ID: <Pine.LNX.4.44.0408161322010.20970@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-118656043-1092687689=:20970
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0408161322011.20970@localhost.localdomain>

On Sun, 8 Aug 2004, Ram Pai wrote:

> On Fri, 6 Aug 2004, Mr. Berkley Shands wrote:
> 
> > in 2.6.8-rc3/mm/readahead.c line 475 (about label do_io:)
> > #if 0
> >             ra->next_size = min(average , (unsigned long)max);
> > #endif
> > 
> > the comment for the above is here after an lseek. The lseek IS inside 
> > the window, but the code will always
> > destroy the window and start again. The above patch corrects the 
> > performance problem,
> > but it would be better to do nothing if the lseek is still within the 
> > read ahead window.
> 
> Ok. I can see your point. I did introduce a subtle change in behavior
> in 2.6.8-rc3. The change in behavior is: the current window got populated
> based on the average number of contiguous pages accessed  in the past.
> Earlier to that patch, the current window got populated based on the
> amount of locality in the current window, seen in the past.
> 
> Try this patch and see if things get back to normal. This patch 
> populates the current window based on the average amount of locality 
> noticed in the current window. It should help your case, but who knows
> which other benchmark will scream :( . Its hard to keep every workload happy.
> 
> In any case try and see if this helps your case atleast. Meanwhile I will
> run my set of benchmarks and see what gets effected. 

Andrew,

	Here is a consolidated readahead patch against mm tree that takes care
of the performance regression seen with multiple threaded writes to the same
file descriptor. 

	The patch does the following:

	1. Instead of calculating the average count of sequential
		access in the read patterns, it calculates the
		average amount of hits in the current window.
	2. This average is used to guide the size of the next current
		window.
	3. Since the field serial_cnt in the ra structure does not
	 	make sense with the introduction of the new logic,
		I have renamed that field as currnt_wnd_hit.


	This patch will help the read patterns that are not neccessarily
sequential but have sufficient locality. However it may regress random
workload. 

	Results:
		
	1. Berkley Shands has reported great performance with this
		patch.
	2. iozone showed negligible effect on various read patterns.
	3. DSS workload saw neglible change.
	4. Sysbench saw a small improvement.

	I am not sure what good/bad effects this patch will cause
	on other workloads. So can we keep this patch in your tree
	for a while and see which benchmarks scream.
	I have generated this patch w.r.t to 2.6.8-rc4-mm1.

RP

--8323328-118656043-1092687689=:20970
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="thread_readahead_mm.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0408161321290.20970@localhost.localdomain>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="thread_readahead_mm.patch"

ZGlmZiAtcHJ1TiByYW0vbGludXgtMi42LjgtcmM0L2luY2x1ZGUvbGludXgv
ZnMuaCBsaW51eC0yLjYuOC1yYzQvaW5jbHVkZS9saW51eC9mcy5oDQotLS0g
cmFtL2xpbnV4LTIuNi44LXJjNC9pbmNsdWRlL2xpbnV4L2ZzLmgJMjAwNC0w
OC0xNiAxOTo1NTo1My43NTM0NDE0NjQgLTA3MDANCisrKyBsaW51eC0yLjYu
OC1yYzQvaW5jbHVkZS9saW51eC9mcy5oCTIwMDQtMDgtMTYgMjA6MDE6NDUu
OTk2ODkyMzIwIC0wNzAwDQpAQCAtNTU2LDggKzU1Niw4IEBAIHN0cnVjdCBm
aWxlX3JhX3N0YXRlIHsNCiAJdW5zaWduZWQgbG9uZyBwcmV2X3BhZ2U7CS8q
IENhY2hlIGxhc3QgcmVhZCgpIHBvc2l0aW9uICovDQogCXVuc2lnbmVkIGxv
bmcgYWhlYWRfc3RhcnQ7CS8qIEFoZWFkIHdpbmRvdyAqLw0KIAl1bnNpZ25l
ZCBsb25nIGFoZWFkX3NpemU7DQotCXVuc2lnbmVkIGxvbmcgc2VyaWFsX2Nu
dDsJLyogbWVhc3VyZSBvZiBzZXF1ZW50aWFsaXR5ICovDQotCXVuc2lnbmVk
IGxvbmcgYXZlcmFnZTsJCS8qIGFub3RoZXIgbWVhc3VyZSBvZiBzZXF1ZW50
aWFsaXR5ICovDQorCXVuc2lnbmVkIGxvbmcgY3Vycm50X3duZF9oaXQ7CS8q
IGxvY2FsaXR5IGluIHRoZSBjdXJyZW50IHdpbmRvdyAqLw0KKwl1bnNpZ25l
ZCBsb25nIGF2ZXJhZ2U7CQkvKiBzaXplIG9mIG5leHQgY3VycmVudCB3aW5k
b3cgKi8NCiAJdW5zaWduZWQgbG9uZyByYV9wYWdlczsJCS8qIE1heGltdW0g
cmVhZGFoZWFkIHdpbmRvdyAqLw0KIAl1bnNpZ25lZCBsb25nIG1tYXBfaGl0
OwkJLyogQ2FjaGUgaGl0IHN0YXQgZm9yIG1tYXAgYWNjZXNzZXMgKi8NCiAJ
dW5zaWduZWQgbG9uZyBtbWFwX21pc3M7CS8qIENhY2hlIG1pc3Mgc3RhdCBm
b3IgbW1hcCBhY2Nlc3NlcyAqLw0KZGlmZiAtcHJ1TiByYW0vbGludXgtMi42
LjgtcmM0L21tL3JlYWRhaGVhZC5jIGxpbnV4LTIuNi44LXJjNC9tbS9yZWFk
YWhlYWQuYw0KLS0tIHJhbS9saW51eC0yLjYuOC1yYzQvbW0vcmVhZGFoZWFk
LmMJMjAwNC0wOC0xNiAxOTo1NTo1NC4yNDMzNjY5ODQgLTA3MDANCisrKyBs
aW51eC0yLjYuOC1yYzQvbW0vcmVhZGFoZWFkLmMJMjAwNC0wOC0xNiAyMDow
MTo0Ni41NTQ4MDc1MDQgLTA3MDANCkBAIC0zODQsMjUgKzM4NCwxMCBAQCBw
YWdlX2NhY2hlX3JlYWRhaGVhZChzdHJ1Y3QgYWRkcmVzc19zcGFjDQogCQlm
aXJzdF9hY2Nlc3M9MTsNCiAJCXJhLT5uZXh0X3NpemUgPSBtYXggLyAyOw0K
IAkJcmEtPnByZXZfcGFnZSA9IG9mZnNldDsNCi0JCXJhLT5zZXJpYWxfY250
Kys7DQorCQlyYS0+Y3Vycm50X3duZF9oaXQrKzsNCiAJCWdvdG8gZG9faW87
DQogCX0NCiANCi0JaWYgKG9mZnNldCA9PSByYS0+cHJldl9wYWdlICsgMSkg
ew0KLQkJaWYgKHJhLT5zZXJpYWxfY250IDw9IChtYXggKiAyKSkNCi0JCQly
YS0+c2VyaWFsX2NudCsrOw0KLQl9IGVsc2Ugew0KLQkJLyoNCi0JCSAqIHRv
IGF2b2lkIHJvdW5kaW5nIGVycm9ycywgZW5zdXJlIHRoYXQgJ2F2ZXJhZ2Un
DQotCQkgKiB0ZW5kcyB0b3dhcmRzIHRoZSB2YWx1ZSBvZiByYS0+c2VyaWFs
X2NudC4NCi0JCSAqLw0KLQkJYXZlcmFnZSA9IHJhLT5hdmVyYWdlOw0KLQkJ
aWYgKGF2ZXJhZ2UgPCByYS0+c2VyaWFsX2NudCkgew0KLQkJCWF2ZXJhZ2Ur
KzsNCi0JCX0NCi0JCXJhLT5hdmVyYWdlID0gKGF2ZXJhZ2UgKyByYS0+c2Vy
aWFsX2NudCkgLyAyOw0KLQkJcmEtPnNlcmlhbF9jbnQgPSAxOw0KLQl9DQog
CXJhLT5wcmV2X3BhZ2UgPSBvZmZzZXQ7DQogDQogCWlmIChvZmZzZXQgPj0g
cmEtPnN0YXJ0ICYmIG9mZnNldCA8PSAocmEtPnN0YXJ0ICsgcmEtPnNpemUp
KSB7DQpAQCAtNDExLDEyICszOTYsMjIgQEAgcGFnZV9jYWNoZV9yZWFkYWhl
YWQoc3RydWN0IGFkZHJlc3Nfc3BhYw0KIAkJICogcGFnZSBiZXlvbmQgdGhl
IGVuZC4gIEV4cGFuZCB0aGUgbmV4dCByZWFkYWhlYWQgc2l6ZS4NCiAJCSAq
Lw0KIAkJcmEtPm5leHRfc2l6ZSArPSAyOw0KKw0KKwkJaWYgKHJhLT5jdXJy
bnRfd25kX2hpdCA8PSAobWF4ICogMikpDQorCQkJcmEtPmN1cnJudF93bmRf
aGl0Kys7DQogCX0gZWxzZSB7DQogCQkvKg0KIAkJICogQSBtaXNzIC0gbHNl
ZWssIHBhZ2VmYXVsdCwgcHJlYWQsIGV0Yy4gIFNocmluayB0aGUgcmVhZGFo
ZWFkDQogCQkgKiB3aW5kb3cuDQogCQkgKi8NCiAJCXJhLT5uZXh0X3NpemUg
LT0gMjsNCisNCisJCWF2ZXJhZ2UgPSByYS0+YXZlcmFnZTsNCisJCWlmIChh
dmVyYWdlIDwgcmEtPmN1cnJudF93bmRfaGl0KSB7DQorCQkJYXZlcmFnZSsr
Ow0KKwkJfQ0KKwkJcmEtPmF2ZXJhZ2UgPSAoYXZlcmFnZSArIHJhLT5jdXJy
bnRfd25kX2hpdCkgLyAyOw0KKwkJcmEtPmN1cnJudF93bmRfaGl0ID0gMTsN
CiAJfQ0KIA0KIAlpZiAoKGxvbmcpcmEtPm5leHRfc2l6ZSA+IChsb25nKW1h
eCkNCkBAIC00NjgsNyArNDYzLDExIEBAIGRvX2lvOg0KIAkJCSAgKiBwYWdl
cyBzaGFsbCBiZSBhY2Nlc3NlZCBpbiB0aGUgbmV4dA0KIAkJCSAgKiBjdXJy
ZW50IHdpbmRvdy4NCiAJCQkgICovDQotCQkJcmEtPm5leHRfc2l6ZSA9IG1p
bihyYS0+YXZlcmFnZSAsICh1bnNpZ25lZCBsb25nKW1heCk7DQorCQkJYXZl
cmFnZSA9IHJhLT5hdmVyYWdlOw0KKwkJCWlmIChyYS0+Y3Vycm50X3duZF9o
aXQgPiBhdmVyYWdlKQ0KKwkJCQlhdmVyYWdlID0gKHJhLT5jdXJybnRfd25k
X2hpdCArIHJhLT5hdmVyYWdlICsgMSkgLyAyOw0KKw0KKwkJCXJhLT5uZXh0
X3NpemUgPSBtaW4oYXZlcmFnZSAsICh1bnNpZ25lZCBsb25nKW1heCk7DQog
CQl9DQogCQlyYS0+c3RhcnQgPSBvZmZzZXQ7DQogCQlyYS0+c2l6ZSA9IHJh
LT5uZXh0X3NpemU7DQpAQCAtNTAxLDggKzUwMCw4IEBAIGRvX2lvOg0KIAkJ
CSAqIHJhbmRvbS4gSGVuY2UgZG9uJ3QgYm90aGVyIHRvIHJlYWRhaGVhZC4N
CiAJCQkgKi8NCiAJCQlhdmVyYWdlID0gcmEtPmF2ZXJhZ2U7DQotCQkJaWYg
KHJhLT5zZXJpYWxfY250ID4gYXZlcmFnZSkNCi0JCQkJYXZlcmFnZSA9IChy
YS0+c2VyaWFsX2NudCArIHJhLT5hdmVyYWdlICsgMSkgLyAyOw0KKwkJCWlm
IChyYS0+Y3Vycm50X3duZF9oaXQgPiBhdmVyYWdlKQ0KKwkJCQlhdmVyYWdl
ID0gKHJhLT5jdXJybnRfd25kX2hpdCArIHJhLT5hdmVyYWdlICsgMSkgLyAy
Ow0KIA0KIAkJCWlmIChhdmVyYWdlID4gbWF4KSB7DQogCQkJCXJhLT5haGVh
ZF9zdGFydCA9IHJhLT5zdGFydCArIHJhLT5zaXplOw0K
--8323328-118656043-1092687689=:20970--
