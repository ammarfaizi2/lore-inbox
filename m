Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262653AbUKXQXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbUKXQXs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 11:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbUKXQW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 11:22:26 -0500
Received: from r3az252.chello.upc.cz ([213.220.243.252]:7554 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S262653AbUKXQTI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 11:19:08 -0500
Message-ID: <41A4AE3A.4050906@ribosome.natur.cuni.cz>
Date: Wed, 24 Nov 2004 16:52:26 +0100
From: =?UTF-8?B?TWFydGluIE1PS1JFSsWg?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a5) Gecko/20041114
X-Accept-Language: cs, en, en-us
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Andrew Morton <akpm@osdl.org>, piggin@cyberone.com.au, chris@tebibyte.org,
       marcelo.tosatti@cyclades.com, andrea@novell.com,
       LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH] fix spurious OOM kills
References: <20041111112922.GA15948@logos.cnet>	 <20041114094417.GC29267@logos.cnet>	 <20041114170339.GB13733@dualathlon.random>	 <20041114202155.GB2764@logos.cnet>	<419A2B3A.80702@tebibyte.org>	 <419B14F9.7080204@tebibyte.org>	<20041117012346.5bfdf7bc.akpm@osdl.org>	 <419CD8C1.4030506@ribosome.natur.cuni.cz>	 <20041118131655.6782108e.akpm@osdl.org>	 <419D25B5.1060504@ribosome.natur.cuni.cz>	 <419D2987.8010305@cyberone.com.au>	 <419D383D.4000901@ribosome.natur.cuni.cz>	 <20041118160824.3bfc961c.akpm@osdl.org>	 <419E821F.7010601@ribosome.natur.cuni.cz>	 <1100946207.2635.202.camel@thomas> <419F2AB4.30401@ribosome.natur.cuni.cz>	 <1100957349.2635.213.camel@thomas>	 <419FB4CD.7090601@ribosome.natur.cuni.cz> <1101037999.23692.5.camel@thomas>	 <41A08765.7030402@ribosome.natur.cuni.cz>	 <1101045469.23692.16.camel@thomas>	 <1101120922.19380.17.camel@tglx.tec.linutronix.de>	 <41A2E98E.7090109@ribosome.natur.cuni.cz> <1101205649.3888.6.camel@tglx.tec.linutronix.de>
In-Reply-To: <1101205649.3888.6.camel@tglx.tec.linutronix.de>
Content-Type: multipart/mixed;
 boundary="------------010607000005010204050106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010607000005010204050106
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thomas Gleixner wrote:
> On Tue, 2004-11-23 at 08:41 +0100, Martin MOKREJŠ wrote: 
> 
>>>One big problem when killing the requesting process or just sending
>>>ENOMEM to the requesting process is, that exactly this process might be
>>>a ssh login, when you try to log into to machine after some application
>>>went crazy and ate up most of the memory. The result is that you
>>>_cannot_ log into the machine, because the login is either killed or
>>>cannot start because it receives ENOMEM.
>>
>>I believe the application is _first_ who will get ENOMEM. It must be
>>terrible luck that it would ask exactly for the size of remaining free
>>memory. Most probably, it will ask for less or more. "Less" in not
>>a problem in this case, so consider it asks for more. Then, OOM killer
>>might well expect the application asking for memory is most probably
>>exactly the application which caused the trouble.
> 
> 
> For one application, which eats up all memory the 2.4 ENOMEM bahviour
> works.
> 
> The scenario which made one of my boxes unusable under 2.4 is a forking
> server, which gets out of control. The last fork gets ENOMEM and does
> not happen, but the other forked processes are still there and consuming
> memory. The server application does the correct thing. It receives
> ENOMEM on fork() and cancels the connection request. On the next request
> the game starts again. Somebody notices that the box is not repsonding
> anymore and tries to login via ssh. Guess what happens. ssh login cannot
> fork due to ENOMEM. The same will happen on 2.6 if we make it behave
> like 2.4. 
> 
> We have TWO problems in oom handling:
> 
> 1. When do we trigger the out of memory killer
> 
> As far as my test cases go, 2.6.10-rc2-mm3 does not longer trigger the
> oom without reason.
> 
> 2. Which process do we select to kill
> 
> The decision is screwed since the oom killer was introduced. Also the
> reentrancy problem and some of the mechanisms in the out_of_memory
> function have to be modified to make it work.
> That's what my patch is addressing.
> 
> 
>>>Putting hard coded decisions like "prefer sshd, xyz,...", " don't kill
>>>a, b, c" are out of discussion.
>>
>>I'd go for it at least nowadays.
> 
> 
> Sure, you can do so on your box, but can you accept, that we _CANNOT_
> hard code a list of do not kill apps, except init, into the kernel. I
> don't want to see the mail thread on LKML, where the list of precious
> application is discussed.
> 
> 
>>> 
>>>The ideas which were proposed to have a possibility to set a "don't kill
>>>me" or "yes, I'm a candidate" flag are likely to be a future way to go.
>>>But at the moment we have no way to make this work in current userlands.
>>
>>Do you think login or sshd will ever use flag "yes, I'm a candidate"?
>>I think exactly same bahaviour we get right now with those hard coded decisions
>>you mention above. Otherwise the hard coded decision is programmed into
>>every sshd, init instance anyway. I think it's not necessary to put
>>login and shells on thsi ban list, user will re-login again. ;)
> 
> 
> Having a generic interface to make this configurable is the only way to
> go. So users can decide what is important in their environment. There is
> more than a desktop PC environment and a lot of embedded boxes need to
> protect special applications.
> 
> 
>>>I refined the decision, so it does not longer kill the parent, if there
>>>were forked child processes available to kill. So it now should keep
>>>your bash alive.
>>
>>Yes, it doesn't kill parent bash. I don't understand the _doubled_ output
>>in syslog, but maybe you do. Is that related to hyperthreading? ;)
>>Tested on 2.6.10-rc2-mm2.
> 
> 
>>oom-killer: gfp_mask=0xd2
>>Free pages:        3924kB (112kB HighMem)
> 
> 
>>oom-killer: gfp_mask=0x1d2
>>Free pages:        3924kB (112kB HighMem)
> 
> 
> No, it's not related to hyperthreading. It's on the way out. 
> 
> I put an additional check into the page allocator. Does this help ?

The application got killed. But, consider yourself the stacktrace ... ;)

--------------010607000005010204050106
Content-Type: text/plain;
 name="dm"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="dm"

b29tLWtpbGxlcjogZ2ZwX21hc2s9MHgxZDIKRE1BIHBlci1jcHU6CmNwdSAwIGhvdDogbG93
IDIsIGhpZ2ggNiwgYmF0Y2ggMQpjcHUgMCBjb2xkOiBsb3cgMCwgaGlnaCAyLCBiYXRjaCAx
Ck5vcm1hbCBwZXItY3B1OgpjcHUgMCBob3Q6IGxvdyAzMiwgaGlnaCA5NiwgYmF0Y2ggMTYK
Y3B1IDAgY29sZDogbG93IDAsIGhpZ2ggMzIsIGJhdGNoIDE2CkhpZ2hNZW0gcGVyLWNwdToK
Y3B1IDAgaG90OiBsb3cgMTQsIGhpZ2ggNDIsIGJhdGNoIDcKY3B1IDAgY29sZDogbG93IDAs
IGhpZ2ggMTQsIGJhdGNoIDcKCkZyZWUgcGFnZXM6ICAgICAgICAzOTMya0IgKDExMmtCIEhp
Z2hNZW0pCkFjdGl2ZToxMjgzMzEgaW5hY3RpdmU6MTI1MzIyIGRpcnR5OjAgd3JpdGViYWNr
OjAgdW5zdGFibGU6MCBmcmVlOjk4MyBzbGFiOjE5NDEgbWFwcGVkOjI1MzQ0MyBwYWdldGFi
bGVzOjc5NApETUEgZnJlZTo2OGtCIG1pbjo2OGtCIGxvdzo4NGtCIGhpZ2g6MTAwa0IgYWN0
aXZlOjU0NDRrQiBpbmFjdGl2ZTo1MzA0a0IgcHJlc2VudDoxNjM4NGtCIHBhZ2VzX3NjYW5u
ZWQ6MTEzNzQgYWxsX3VucmVjbGFpbWFibGU/IHllcwpwcm90ZWN0aW9uc1tdOiAwIDAgMApO
b3JtYWwgZnJlZTozNzUya0IgbWluOjM3NTZrQiBsb3c6NDY5MmtCIGhpZ2g6NTYzMmtCIGFj
dGl2ZTo0NDI5ODRrQiBpbmFjdGl2ZTo0MzEwOTJrQiBwcmVzZW50OjkwMTEyMGtCIHBhZ2Vz
X3NjYW5uZWQ6OTM2MzA4IGFsbF91bnJlY2xhaW1hYmxlPyB5ZXMKcHJvdGVjdGlvbnNbXTog
MCAwIDAKSGlnaE1lbSBmcmVlOjExMmtCIG1pbjoxMjhrQiBsb3c6MTYwa0IgaGlnaDoxOTJr
QiBhY3RpdmU6NjQ4OTZrQiBpbmFjdGl2ZTo2NDg5MmtCIHByZXNlbnQ6MTMxMDQ0a0IgcGFn
ZXNfc2Nhbm5lZDoxMzQ4NjggYWxsX3VucmVjbGFpbWFibGU/IHllcwpwcm90ZWN0aW9uc1td
OiAwIDAgMApETUE6IDEqNGtCIDAqOGtCIDAqMTZrQiAwKjMya0IgMSo2NGtCIDAqMTI4a0Ig
MCoyNTZrQiAwKjUxMmtCIDAqMTAyNGtCIDAqMjA0OGtCIDAqNDA5NmtCID0gNjhrQgpOb3Jt
YWw6IDAqNGtCIDEqOGtCIDAqMTZrQiAxKjMya0IgMCo2NGtCIDEqMTI4a0IgMCoyNTZrQiAx
KjUxMmtCIDEqMTAyNGtCIDEqMjA0OGtCIDAqNDA5NmtCID0gMzc1MmtCCkhpZ2hNZW06IDAq
NGtCIDAqOGtCIDEqMTZrQiAxKjMya0IgMSo2NGtCIDAqMTI4a0IgMCoyNTZrQiAwKjUxMmtC
IDAqMTAyNGtCIDAqMjA0OGtCIDAqNDA5NmtCID0gMTEya0IKU3dhcCBjYWNoZTogYWRkIDI5
MzMzNSwgZGVsZXRlIDI5MzMzNSwgZmluZCA0NC82MCwgcmFjZSAwKzAKIFs8YzAxMDNkZmQ+
XSBkdW1wX3N0YWNrKzB4MWUvMHgyMgogWzxjMDEzZWMxYz5dIG91dF9vZl9tZW1vcnkrMHg5
Ny8weGNmCiBbPGMwMTQ2ZGM4Pl0gdHJ5X3RvX2ZyZWVfcGFnZXMrMHgxNjMvMHgxODQKIFs8
YzAxM2ZkZTI+XSBfX2FsbG9jX3BhZ2VzKzB4MjdlLzB4NDAwCiBbPGMwMTQyMzY4Pl0gZG9f
cGFnZV9jYWNoZV9yZWFkYWhlYWQrMHgxNWIvMHgxYjkKIFs8YzAxM2M1YWE+XSBmaWxlbWFw
X25vcGFnZSsweDJkNC8weDM3NQogWzxjMDE0YWE4Mj5dIGRvX25vX3BhZ2UrMHhjNC8weDM4
YwogWzxjMDE0YWYzMD5dIGhhbmRsZV9tbV9mYXVsdCsweGRlLzB4MTg5CiBbPGMwMTE2NmQ1
Pl0gZG9fcGFnZV9mYXVsdCsweDQ1Ni8weDZhZAogWzxjMDEwM2E0Mz5dIGVycm9yX2NvZGUr
MHgyYi8weDMwCk91dCBvZiBNZW1vcnk6IEtpbGxlZCBwcm9jZXNzIDY2NzIgKFJOQXN1Ym9w
dCkuClJOQXN1Ym9wdDogcGFnZSBhbGxvY2F0aW9uIGZhaWx1cmUuIG9yZGVyOjAsIG1vZGU6
MHgxZDIKIFs8YzAxMDNkZmQ+XSBkdW1wX3N0YWNrKzB4MWUvMHgyMgogWzxjMDEzZmQ5MD5d
IF9fYWxsb2NfcGFnZXMrMHgyMmMvMHg0MDAKIFs8YzAxNDIzNjg+XSBkb19wYWdlX2NhY2hl
X3JlYWRhaGVhZCsweDE1Yi8weDFiOQogWzxjMDEzYzVhYT5dIGZpbGVtYXBfbm9wYWdlKzB4
MmQ0LzB4Mzc1CiBbPGMwMTRhYTgyPl0gZG9fbm9fcGFnZSsweGM0LzB4MzhjCiBbPGMwMTRh
ZjMwPl0gaGFuZGxlX21tX2ZhdWx0KzB4ZGUvMHgxODkKIFs8YzAxMTY2ZDU+XSBkb19wYWdl
X2ZhdWx0KzB4NDU2LzB4NmFkCiBbPGMwMTAzYTQzPl0gZXJyb3JfY29kZSsweDJiLzB4MzAK

--------------010607000005010204050106--
