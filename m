Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268048AbUI3BMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268048AbUI3BMv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 21:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267918AbUI3BMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 21:12:51 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:51355 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268048AbUI3BM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 21:12:26 -0400
Date: Wed, 29 Sep 2004 18:12:05 -0700 (PDT)
From: Ram Pai <linuxram@us.ibm.com>
X-X-Sender: ram@dyn319181.beaverton.ibm.com
Reply-To: linuxram@us.ibm.com
To: Steven Pratt <slpratt@austin.ibm.com>
cc: linuxram@us.ibm.com, <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC] Simplified Readahead
In-Reply-To: <415B3845.3010005@austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0409291558430.3273-200000@dyn319181.beaverton.ibm.com>
Organization: IBM Linux Technology Center
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="789158165-663654575-1096503756=:3273"
Content-ID: <Pine.LNX.4.44.0409291802100.3273@dyn319181.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--789158165-663654575-1096503756=:3273
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0409291802101.3273@dyn319181.beaverton.ibm.com>

On Wed, 29 Sep 2004, Steven Pratt wrote:

> Ram Pai wrote:
> 
> snip...
> 
> >  
> >
> > I have enclosed 5 patches that address each of the issues.
> >
> >1 . Code is obtuse and hard to maintain
> >
> >	The best I could do is update the comments to reflect the
> >	current code. Hopefully that should help. 
> >	
> >	attached patch 1_comment.patch takes care of that part to
> >	some extent.
> >  
> >
> I was more concerend with the multiple ways in which the readhead 
> changed, and the fact that we were going down the sequential read path 
> on random I/O requests.  More comments are always good, but that was not 
> really my concern.
> 
> >
> >2. page cache hits not handled properly.
> >
> >	I fixed this by decrementing the size of the next readahead window
> >	by the number of pages hit in the page cache. Now it slowly
> >	accomodates the page cache hits. 
> >
> >	attached patch 2_cachehits.patch takes care of this issue.
> >  
> >
> I think this will be way too agressive. This means turn off readhead if 
> 1 max_readhead I/O is completely in cache.  You then will need to do 
> multiple 4k I/Os to get it turned back on.

Having a max_readahead pages completely in cache is pretty good reason
to switch-off readahead. Yes it is aggressive, and the downside of
this is multiple 4k I/o. That is the reason we need the slow-read
patch[patch number 5] to speed up the slow-read path.


> 
> >3. queue congestion not handled.
> >
> >	The fix is: call force_page_cache_readahead() if we are 
> >	populating pages in the current window.
> >	And call do_page_cache_readahead() if we are populating
> >	pages in the ahead window. However if do_page_cache_readahead()
> >	return with congestion, the readahead window is collapsed back 
> >	to size zero. This will ensure that the next time ahead window
> >	is attempted to populate.
> >
> >	attached patch 3_queuecongestion.patch handles this issue.
> >  
> >
> Yeah, I had thought about something along these lines.  Just not sure if 
> it is worth it.

Well does not seem to hurt!

> 
> >4. page thrash handled ineffectively.
> >
> >	The fix is: on page thrash detection shutdown readahead.
> >
> >	attached patch 4_pagethrash.patch handles this issue.
> >  
> >
> Same comments as on 2.  Way too agressive.

yes. But think about it. Why did a page get thrashed?  there
is memory pressure. Hence better stop reading ahead. Again
yes it is agressive. And to compensate the agression we need the 
slowread patch that fixes the slow read path.


> 
> >5. slow read path is too slow.
> >
> >	I could not figure out a way to atleast-read-the-requested-
> >	number-of-pages if readahead is shutdown, without incorporating
> >	the readsize parameter to page_cache_readahead(). So had
> >	to pick some of your code in filemap.c to do that. Thanks!
> >	
> >	attached patch 5_fixedslowread.patch handles this issue.
> >
> >  
> >
> Step in the right direction.  Now if I could just get you to pick up the 
> rest we would be done :-)

:-) I wish it was my call.


> 
> >Apart from this you have noticed other issues
> >
> >6.  cache lookup done unneccessrily twice for pagecache_hits.
> >
> >	I have not handled this issue currently. But should be doable
> >	if I introducing a flag, which notes when readahead is
> >	shutdown by pagecahche hits. And hence attempts to lookup
> >	the page only once.
> >	
> >  
> >
> Umm, actually you do (if the code works).  When you get too many cache 
> hits you turn off readahead. This will disable the multiple lookups 
> until you re-enable readhead which will only happen in handle_ra_miss 
> which means you are reading pages not in page cache so that is ok.


yes but with the slowread patch, we attempt to read pages
and then do_generic_mapping_read() anyway attempts to check if the
page frame is there. This is a small optimization. You did mention that you
saw .5% decrease in CPU time. Did'nt you?

> 
> >And you have other features in your patch which will be the real
> >differentiating factors.
> >
> >7.  exponential expand and shrink of window sizes.
> >
> >8.  overlapped read of current window and ahead window. 
> >
> >	( I think both are  desirable feature )
> >  
> >
> Glad we agree.
> 
We never disagreed. Did we? :) The concern Andrew had was, have you
tried to fix the problem with the current code, and then check
if your patch does better with the fixed-code.

I am trying to help you get a solid case to get Andrew's acceptance.

So with these set of patches, your algorithm and the current algorithm
are on even playing ground to do some fair comparison.


> >I did run some premilinary tests using your patch and the above patches
> >and found 
> >
> >your patch was doing slightly better on iozone and sysbench.
> >however the above patch were doing slightly better with DSS workload.
> >  
> >
> Care to expand on slightly better?  Also these tests don't cover many 
> cases.  You are only running iozone single threaded which won't show 
> much, you don't seem to vary IO requests sizes to see the effect (all 
> this based on your readahead web page). Also it would be really helpful 
> if you had some sort of machine description, disk, memory etc.  

2proc 700Mhz , 2GBmemory. Ultra160 SCSI disk.

> Also for 
> the DSS workload I need ot know what type of IO pattern you generate.  I 
> know it is mostly random IO, but the size of the IOs and the number of 
> prefetcher threads and the number of disks make a huge difference.

256k iosize with 50 prefetchers.

> 
> Also what is the units in the iozone results?  I thought it was in 
> kbytes which would make your throughputs in the 350-400MB/sec range 
> which is way more than you could do on a single adapter.  So unless I am 
> really off base here, your IOzone results appear to be mostly cache 
> reads and thus not really testing readahead.  I must have missed something.

correct observation. My filesize is 1.2GB and memory size is 2GB so it 
will end up being entirely cache based. Good observation. Rerunning
with a larger file.

> 
> >But my setup is rather tiny compared to your setup, so my comparison
> >is rather incomplete. 
> >  
> >
> Not really. I made sure that I ran this on machine from single cpu ide 
> up through really big machines. It is important to run well across a 
> variety of platforms which I tried to ensure my code does.
> 
> 
> I'll try to run this through my test suite tomorrow

sure. that will help. And once results are in place, its Andrew's call.
No, these patches are not in competition with yours.
Its just helping you to convince others.  

> , but is there 
> something you don't like about the new code?  You seem to be moving in 
> that direction.  Is there any reason to not make the complete jump and 
> help out on the (hopefully) simpler code base?

Thought I was helping you out, No?

BTW: the last patch 5_fixedslowread.patch accidently did not contain all 
the changes. Enclosed the remaining changes.

RP
> 
> Steve
> 

--789158165-663654575-1096503756=:3273
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="6_fixedslowread.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0409291722360.3273@dyn319181.beaverton.ibm.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="6_fixedslowread.patch"

LS0tIGxpbnV4LTIuNi44L21tL2ZpbGVtYXAuYwkyMDA0LTA5LTI5IDE3OjMw
OjE3LjA4OTI0ODQ2NCAtMDcwMA0KKysrIGxpbnV4LTIuNi44LmNvbW1lbnQu
cGFnZWNhY2hlaGl0LnF1ZXVlY29uZ2VzdGlvbi5wYWdldGhyYXNoL21tL2Zp
bGVtYXAuYwkyMDA0LTA5LTI5IDE4OjEzOjAyLjk2ODE3NTU3NiAtMDcwMA0K
QEAgLTcxNywxNCArNzE3LDE0IEBAIHZvaWQgZG9fZ2VuZXJpY19tYXBwaW5n
X3JlYWQoc3RydWN0IGFkZHINCiAJCQkgICAgIHJlYWRfYWN0b3JfdCBhY3Rv
cikNCiB7DQogCXN0cnVjdCBpbm9kZSAqaW5vZGUgPSBtYXBwaW5nLT5ob3N0
Ow0KLQl1bnNpZ25lZCBsb25nIGluZGV4LCBlbmRfaW5kZXgsIG9mZnNldDsN
CisJdW5zaWduZWQgbG9uZyBpbmRleCwgZW5kX2luZGV4LCBvZmZzZXQsIHJl
cV9zaXplLCBuZXh0X2luZGV4Ow0KIAlsb2ZmX3QgaXNpemU7DQogCXN0cnVj
dCBwYWdlICpjYWNoZWRfcGFnZTsNCiAJaW50IGVycm9yOw0KIAlzdHJ1Y3Qg
ZmlsZV9yYV9zdGF0ZSByYSA9ICpfcmE7DQogDQogCWNhY2hlZF9wYWdlID0g
TlVMTDsNCi0JaW5kZXggPSAqcHBvcyA+PiBQQUdFX0NBQ0hFX1NISUZUOw0K
KwluZXh0X2luZGV4ID0gaW5kZXggPSAqcHBvcyA+PiBQQUdFX0NBQ0hFX1NI
SUZUOw0KIAlvZmZzZXQgPSAqcHBvcyAmIH5QQUdFX0NBQ0hFX01BU0s7DQog
DQogCWlzaXplID0gaV9zaXplX3JlYWQoaW5vZGUpOw0KQEAgLTczMiw2ICs3
MzIsOCBAQCB2b2lkIGRvX2dlbmVyaWNfbWFwcGluZ19yZWFkKHN0cnVjdCBh
ZGRyDQogCQlnb3RvIG91dDsNCiANCiAJZW5kX2luZGV4ID0gKGlzaXplIC0g
MSkgPj4gUEFHRV9DQUNIRV9TSElGVDsNCisJcmVxX3NpemUgPSBlbmRfaW5k
ZXggLSBpbmRleCArIDE7DQorDQogCWZvciAoOzspIHsNCiAJCXN0cnVjdCBw
YWdlICpwYWdlOw0KIAkJdW5zaWduZWQgbG9uZyBuciwgcmV0Ow0KQEAgLTc0
OSwxMiArNzUxLDIyIEBAIHZvaWQgZG9fZ2VuZXJpY19tYXBwaW5nX3JlYWQo
c3RydWN0IGFkZHINCiAJCW5yID0gbnIgLSBvZmZzZXQ7DQogDQogCQljb25k
X3Jlc2NoZWQoKTsNCi0JCXBhZ2VfY2FjaGVfcmVhZGFoZWFkKG1hcHBpbmcs
ICZyYSwgZmlscCwgaW5kZXgpOw0KKwkJLyoNCisJCSAqIExldCBwYWdlX2Nh
Y2hlX3JlYWRhaGVhZCgpIGtub3cgdGhhdCB3ZSBhcmUgYWNjZXNzaW5nDQor
CQkgKiAncmVxX3NpemUnIG51bWJlciBvZiBwYWdlcy4NCisJCSAqLw0KKwkJ
aWYoaW5kZXggPT0gbmV4dF9pbmRleCAmJiByZXFfc2l6ZSkgew0KKwkJCXVu
c2lnbmVkIGxvbmcgcmV0X3NpemU7DQorCQkJcmV0X3NpemUgPSBwYWdlX2Nh
Y2hlX3JlYWRhaGVhZChtYXBwaW5nLCAmcmEsIA0KKwkJCQkJZmlscCwgaW5k
ZXgsIHJlcV9zaXplKTsNCisJCQluZXh0X2luZGV4ICs9IHJldF9zaXplOw0K
KwkJCXJlcV9zaXplIC09IHJldF9zaXplOw0KKwkJfQ0KIA0KIGZpbmRfcGFn
ZToNCiAJCXBhZ2UgPSBmaW5kX2dldF9wYWdlKG1hcHBpbmcsIGluZGV4KTsN
CiAJCWlmICh1bmxpa2VseShwYWdlID09IE5VTEwpKSB7DQotCQkJaGFuZGxl
X3JhX21pc3MobWFwcGluZywgJnJhLCBpbmRleCk7DQorCQkJaGFuZGxlX3Jh
X21pc3MobWFwcGluZywgJnJhLCBpbmRleCwgMSk7DQogCQkJZ290byBub19j
YWNoZWRfcGFnZTsNCiAJCX0NCiAJCWlmICghUGFnZVVwdG9kYXRlKHBhZ2Up
KQ0KQEAgLTExOTUsNyArMTIwNyw3IEBAIHJldHJ5X2FsbDoNCiAJICogRm9y
IHNlcXVlbnRpYWwgYWNjZXNzZXMsIHdlIHVzZSB0aGUgZ2VuZXJpYyByZWFk
YWhlYWQgbG9naWMuDQogCSAqLw0KIAlpZiAoVk1fU2VxdWVudGlhbFJlYWRI
aW50KGFyZWEpKQ0KLQkJcGFnZV9jYWNoZV9yZWFkYWhlYWQobWFwcGluZywg
cmEsIGZpbGUsIHBnb2ZmKTsNCisJCXBhZ2VfY2FjaGVfcmVhZGFoZWFkKG1h
cHBpbmcsIHJhLCBmaWxlLCBwZ29mZiwgMSk7DQogDQogCS8qDQogCSAqIERv
IHdlIGhhdmUgc29tZXRoaW5nIGluIHRoZSBwYWdlIGNhY2hlIGFscmVhZHk/
DQpAQCAtMTIwNiw3ICsxMjE4LDcgQEAgcmV0cnlfZmluZDoNCiAJCXVuc2ln
bmVkIGxvbmcgcmFfcGFnZXM7DQogDQogCQlpZiAoVk1fU2VxdWVudGlhbFJl
YWRIaW50KGFyZWEpKSB7DQotCQkJaGFuZGxlX3JhX21pc3MobWFwcGluZywg
cmEsIHBnb2ZmKTsNCisJCQloYW5kbGVfcmFfbWlzcyhtYXBwaW5nLCByYSwg
cGdvZmYsIDEpOw0KIAkJCWdvdG8gbm9fY2FjaGVkX3BhZ2U7DQogCQl9DQog
CQlyYS0+bW1hcF9taXNzKys7DQotLS0gbGludXgtMi42LjgvaW5jbHVkZS9s
aW51eC9tbS5oCTIwMDQtMDktMjkgMTc6MzA6MTUuODU3NDM1NzI4IC0wNzAw
DQorKysgbGludXgtMi42LjguY29tbWVudC5wYWdlY2FjaGVoaXQucXVldWVj
b25nZXN0aW9uLnBhZ2V0aHJhc2gvaW5jbHVkZS9saW51eC9tbS5oCTIwMDQt
MDktMjkgMTg6MDY6NDAuNTAwMzE5NTI4IC0wNzAwDQpAQCAtNzIxLDEyICs3
MjEsMTQgQEAgaW50IGRvX3BhZ2VfY2FjaGVfcmVhZGFoZWFkKHN0cnVjdCBh
ZGRyZQ0KIAkJCXVuc2lnbmVkIGxvbmcgb2Zmc2V0LCB1bnNpZ25lZCBsb25n
IG5yX3RvX3JlYWQpOw0KIGludCBmb3JjZV9wYWdlX2NhY2hlX3JlYWRhaGVh
ZChzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZywgc3RydWN0IGZpbGUg
KmZpbHAsDQogCQkJdW5zaWduZWQgbG9uZyBvZmZzZXQsIHVuc2lnbmVkIGxv
bmcgbnJfdG9fcmVhZCk7DQotdm9pZCBwYWdlX2NhY2hlX3JlYWRhaGVhZChz
dHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZywgDQordW5zaWduZWQgbG9u
ZyBwYWdlX2NhY2hlX3JlYWRhaGVhZChzdHJ1Y3QgYWRkcmVzc19zcGFjZSAq
bWFwcGluZywgDQogCQkJICBzdHJ1Y3QgZmlsZV9yYV9zdGF0ZSAqcmEsDQog
CQkJICBzdHJ1Y3QgZmlsZSAqZmlscCwNCi0JCQkgIHVuc2lnbmVkIGxvbmcg
b2Zmc2V0KTsNCisJCQkgIHVuc2lnbmVkIGxvbmcgb2Zmc2V0LA0KKwkJCSAg
dW5zaWduZWQgbG9uZyBzaXplKTsNCiB2b2lkIGhhbmRsZV9yYV9taXNzKHN0
cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLCANCi0JCSAgICBzdHJ1Y3Qg
ZmlsZV9yYV9zdGF0ZSAqcmEsIHBnb2ZmX3Qgb2Zmc2V0KTsNCisJCSAgICBz
dHJ1Y3QgZmlsZV9yYV9zdGF0ZSAqcmEsIHBnb2ZmX3Qgb2Zmc2V0LCANCisJ
CSAgICB1bnNpZ25lZCBsb25nIHNpemUpOw0KIHVuc2lnbmVkIGxvbmcgbWF4
X3NhbmVfcmVhZGFoZWFkKHVuc2lnbmVkIGxvbmcgbnIpOw0KIA0KIC8qIERv
IHN0YWNrIGV4dGVuc2lvbiAqLw0K
--789158165-663654575-1096503756=:3273--
