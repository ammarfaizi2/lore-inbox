Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUHHIDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUHHIDP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 04:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUHHIDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 04:03:15 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:9213 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265207AbUHHIDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 04:03:04 -0400
Date: Sun, 8 Aug 2004 01:22:03 -0700 (PDT)
From: Ram Pai <linuxram@us.ibm.com>
X-X-Sender: ram@dyn319181.beaverton.ibm.com
Reply-To: linuxram@us.ibm.com
To: "Mr. Berkley Shands" <berkley@cse.wustl.edu>
cc: linux-kernel@vger.kernel.org, <akpm@osdl.org>
Subject: Re: Fast patch for Severe I/O performance regression 2.6.6 to 2.6.7
 or 2.6.8-rc3
In-Reply-To: <4113C7BA.6060608@cse.wustl.edu>
Message-ID: <Pine.LNX.4.44.0408080104270.23623-200000@dyn319181.beaverton.ibm.com>
Organization: IBM Linux Technology Center
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="789158165-1675623982-1091953318=:23623"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--789158165-1675623982-1091953318=:23623
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 6 Aug 2004, Mr. Berkley Shands wrote:

> in 2.6.8-rc3/mm/readahead.c line 475 (about label do_io:)
> #if 0
>             ra->next_size = min(average , (unsigned long)max);
> #endif
> 
> the comment for the above is here after an lseek. The lseek IS inside 
> the window, but the code will always
> destroy the window and start again. The above patch corrects the 
> performance problem,
> but it would be better to do nothing if the lseek is still within the 
> read ahead window.

Ok. I can see your point. I did introduce a subtle change in behavior
in 2.6.8-rc3. The change in behavior is: the current window got populated
based on the average number of contiguous pages accessed  in the past.
Earlier to that patch, the current window got populated based on the
amount of locality in the current window, seen in the past.

Try this patch and see if things get back to normal. This patch 
populates the current window based on the average amount of locality 
noticed in the current window. It should help your case, but who knows
which other benchmark will scream :( . Its hard to keep every workload happy.

In any case try and see if this helps your case atleast. Meanwhile I will
run my set of benchmarks and see what gets effected. 

RP


> 
> berkley
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

--789158165-1675623982-1091953318=:23623
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="thread_readahead.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0408080121580.23623@dyn319181.beaverton.ibm.com>
Content-Description: 
Content-Disposition: attachment; filename="thread_readahead.patch"

LS0tIGxpbnV4LTIuNi44LXJjMy9tbS9yZWFkYWhlYWQuYwkyMDA0LTA4LTAz
IDE0OjI2OjQ2LjAwMDAwMDAwMCAtMDcwMA0KKysrIHJhbS9saW51eC0yLjYu
OC1yYzMvbW0vcmVhZGFoZWFkLmMJMjAwNC0wOC0wOCAwNzo0NTo0MC41NTk0
MzEyODAgLTA3MDANCkBAIC0zODgsMTAgKzM4OCw3IEBAIHBhZ2VfY2FjaGVf
cmVhZGFoZWFkKHN0cnVjdCBhZGRyZXNzX3NwYWMNCiAJCWdvdG8gZG9faW87
DQogCX0NCiANCi0JaWYgKG9mZnNldCA9PSByYS0+cHJldl9wYWdlICsgMSkg
ew0KLQkJaWYgKHJhLT5zZXJpYWxfY250IDw9IChtYXggKiAyKSkNCi0JCQly
YS0+c2VyaWFsX2NudCsrOw0KLQl9IGVsc2Ugew0KKwlpZiAob2Zmc2V0IDwg
cmEtPnN0YXJ0IHx8IG9mZnNldCA+IChyYS0+c3RhcnQgKyByYS0+c2l6ZSkp
IHsNCiAJCS8qDQogCQkgKiB0byBhdm9pZCByb3VuZGluZyBlcnJvcnMsIGVu
c3VyZSB0aGF0ICdhdmVyYWdlJw0KIAkJICogdGVuZHMgdG93YXJkcyB0aGUg
dmFsdWUgb2YgcmEtPnNlcmlhbF9jbnQuDQpAQCAtNDAyLDkgKzM5OSwxMyBA
QCBwYWdlX2NhY2hlX3JlYWRhaGVhZChzdHJ1Y3QgYWRkcmVzc19zcGFjDQog
CQl9DQogCQlyYS0+YXZlcmFnZSA9IChhdmVyYWdlICsgcmEtPnNlcmlhbF9j
bnQpIC8gMjsNCiAJCXJhLT5zZXJpYWxfY250ID0gMTsNCisJfSBlbHNlIHsN
CisJCWlmIChyYS0+c2VyaWFsX2NudCA8PSAobWF4ICogMikpDQorCQkJcmEt
PnNlcmlhbF9jbnQrKzsNCiAJfQ0KIAlyYS0+cHJldl9wYWdlID0gb2Zmc2V0
Ow0KIA0KKw0KIAlpZiAob2Zmc2V0ID49IHJhLT5zdGFydCAmJiBvZmZzZXQg
PD0gKHJhLT5zdGFydCArIHJhLT5zaXplKSkgew0KIAkJLyoNCiAJCSAqIEEg
cmVhZGFoZWFkIGhpdC4gIEVpdGhlciBpbnNpZGUgdGhlIHdpbmRvdywgb3Ig
b25lDQo=
--789158165-1675623982-1091953318=:23623--
