Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbVIXSQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbVIXSQv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 14:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbVIXSQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 14:16:51 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:3718 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S932219AbVIXSQv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 14:16:51 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 24 Sep 2005 11:19:17 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@localhost.localdomain
To: Willy Tarreau <willy@w.ods.org>
cc: Nish Aravamudan <nish.aravamudan@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] sys_epoll_wait() timeout saga ...
In-Reply-To: <20050924172011.GA25997@alpha.home.local>
Message-ID: <Pine.LNX.4.63.0509241113370.31327@localhost.localdomain>
References: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain>
 <20050924040534.GB18716@alpha.home.local> <29495f1d05092321447417503@mail.gmail.com>
 <20050924061500.GA24628@alpha.home.local> <Pine.LNX.4.63.0509240800020.31060@localhost.localdomain>
 <20050924172011.GA25997@alpha.home.local>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1373822066-1127585957=:31327"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1373822066-1127585957=:31327
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

On Sat, 24 Sep 2005, Willy Tarreau wrote:

> On Sat, Sep 24, 2005 at 08:10:32AM -0700, Davide Libenzi wrote:
>>> +       jtimeout = timeout < 0 || \
>>> +                    timeout >= (1000ULL * MAX_SCHEDULE_TIMEOUT / HZ) ||
>>> \
>>> +                    timeout >= (LONG_MAX / HZ - 1000) ?
>>>                  MAX_SCHEDULE_TIMEOUT: (timeout * HZ + 999) / 1000;
>>>
>>> as both are constants, they can be optimized. Otherwise, we can resort to
>>> using a MAX() macro to reduce this to only one test which will catch all
>>> corner cases.
>>
>> Using the MIN() macro would be better so we have a single check, and the
>> compiler optimize that automatically.
>
> you're right, it's MIN() not MAX() ;-)
> Anyway, I've checked the code and the compiler does a single test with -O2.
>
>> Or we can force 'timeout * HZ' to use ULL math. I don't think it makes a lot of difference for something that is in a likely sleep path ;)
>
> "likely", yes, but not necessarily. Under a high load, you can have enough
> events queued so that epoll() will not wait at all. I've already encountered
> such cases during benchmarks, and I noticed that epoll() took more time than
> select() for small numbers of FDs (something like 20% below 100 FDs), but of
> course, it is considerably faster above. So turning the multiply to an ULL
> may increase this overhead on some architectures, while the double check
> will leave the code identical.

The attached patch uses the kernel min() macro, that is optimized has 
single compare by gcc-O2. Andrew, this goes over (hopefully ;) the bits 
you already have in -mm.

PS: It might be possible to move the currently epoll-local EP_MAX_MSTIMEO 
macro, to a MAX_LONG_MSTIMEO (or whatever name you like) somewhere in the 
tree, to be used where needed.


Signed-off-by: Davide Libenzi <davidel@xmailserver.org>


- Davide



--8323328-1373822066-1127585957=:31327
Content-Type: TEXT/plain; charset=US-ASCII; name=epoll-handle-overflow.diff
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename=epoll-handle-overflow.diff

LS0tIGEvZnMvZXZlbnRwb2xsLmMJMjAwNS0wOS0yNCAxMTowNzowNC4wMDAw
MDAwMDAgLTA3MDANCisrKyBiL2ZzL2V2ZW50cG9sbC5jCTIwMDUtMDktMjQg
MTE6MTE6MDYuMDAwMDAwMDAwIC0wNzAwDQpAQCAtMTAxLDYgKzEwMSwxMCBA
QA0KIC8qIE1heGltdW0gbnVtYmVyIG9mIHBvbGwgd2FrZSB1cCBuZXN0cyB3
ZSBhcmUgYWxsb3dpbmcgKi8NCiAjZGVmaW5lIEVQX01BWF9QT0xMV0FLRV9O
RVNUUyA0DQogDQorLyogTWF4aW11bSBtc2VjIHRpbWVvdXQgdmFsdWUgc3Rv
cmVhYmxlIGluIGEgbG9uZyBpbnQgKi8NCisjZGVmaW5lIEVQX01BWF9NU1RJ
TUVPIG1pbigxMDAwVUxMICogTUFYX1NDSEVEVUxFX1RJTUVPVVQgLyBIWiwg
TE9OR19NQVggLyBIWiAtIDEwMDBVTEwpDQorDQorDQogc3RydWN0IGVwb2xs
X2ZpbGVmZCB7DQogCXN0cnVjdCBmaWxlICpmaWxlOw0KIAlpbnQgZmQ7DQpA
QCAtMTUwNyw4ICsxNTExLDcgQEANCiAJICogYW5kIHRoZSBvdmVyZmxvdyBj
b25kaXRpb24uIFRoZSBwYXNzZWQgdGltZW91dCBpcyBpbiBtaWxsaXNlY29u
ZHMsDQogCSAqIHRoYXQgd2h5ICh0ICogSFopIC8gMTAwMC4NCiAJICovDQot
CWp0aW1lb3V0ID0gKHRpbWVvdXQgPCAwIHx8DQotCQkgICAgKHRpbWVvdXQg
LyAxMDAwKSA+PSAoTUFYX1NDSEVEVUxFX1RJTUVPVVQgLyBIWikpID8NCisJ
anRpbWVvdXQgPSAodGltZW91dCA8IDAgfHwgdGltZW91dCA+PSBFUF9NQVhf
TVNUSU1FTykgPw0KIAkJTUFYX1NDSEVEVUxFX1RJTUVPVVQ6ICh0aW1lb3V0
ICogSFogKyA5OTkpIC8gMTAwMDsNCiANCiByZXRyeToNCg==

--8323328-1373822066-1127585957=:31327--
