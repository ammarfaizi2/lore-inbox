Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVAZXnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVAZXnP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVAZXmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:42:42 -0500
Received: from alog0168.analogic.com ([208.224.220.183]:40576 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261716AbVAZSib
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 13:38:31 -0500
Date: Wed, 26 Jan 2005 13:37:43 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Bryn Reeves <breeves@redhat.com>
cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Antill <james.antill@redhat.com>
Subject: Re: don't let mmap allocate down to zero
In-Reply-To: <1106762261.10384.30.camel@breeves.surrey.redhat.com>
Message-ID: <Pine.LNX.4.61.0501261325540.18301@chaos.analogic.com>
References: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com> 
 <Pine.LNX.4.61.0501261130130.17993@chaos.analogic.com> 
 <41F7D4B0.7070401@nortelnetworks.com> <1106762261.10384.30.camel@breeves.surrey.redhat.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1879706418-2029547478-1106764663=:18301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1879706418-2029547478-1106764663=:18301
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

On Wed, 26 Jan 2005, Bryn Reeves wrote:

> On Wed, 2005-01-26 at 17:34, Chris Friesen wrote:
>> linux-os wrote:
>>
>>> Does this mean that we can't mmap the screen regen buffer at
>>> 0x000b8000 anymore?
>>>
>>> How do I look at the real-mode interrupt table starting at
>>> offset 0? You know that the return value of mmap is to be
>>> checked for MAP_FAILED, not for NULL, don't you?
>>
>> Can't you still map those physical addresses to other virtual addresses?
>>
>
> I think that's the case. The 0 address as refered to here is only for
> the user virtual address space.
>
>>> What 'C' standard do you refer to? Seg-faults on null pointers
>>> have nothing to do with the 'C' standard and everything to
>>> do with the platform.
>>
>> I believe the ISO/IEC 9899:1999 C Standard explicitly states that
>> dereferencing a null pointer with the unary * operator results in
>> undefined behavior.
>
> Exactly. Undefined. VAX/UNIX allowed assignment to null pointers. BUT
> it's now such a commonly held assumption that a null pointer is not
> valid that things will break if this is changed. Doesn't glibc malloc
> use mmap for small allocations? From the man page:

Wrong! A returned value of 0 is perfectly correct for mmap()
when mapping a fixed address. The attached code shows it working
perfectly while returning NULL, that event being put on the
terminal.

Any kernel changes that break this code are wrong. There are
many 'C' runtime library functions that signal a problem (or
should signal a problem) by returning NULL. That is, however,
the documented behavior of those procedures. Even malloc()
which __should__ show a failure to allocate by returning NULL,
doesn't work that way because the allocation never fails
(even if you are out of memory) as long as the user address
space hasn't been corrupted by the user (overwriting buffers).

The seg-fault you get when you de-reference a pointer to NULL
is caused by the kernel. You are attempting to access memory
that has not been mapped into your address space. Once that
memory gets mmap()ed, you will no longer get a seg-fault.
Again, the seg-fault has nothing to do with 'C'. It's an
implementation behavior that can be changed with mmap().

[SNIPPED...]

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
--1879706418-2029547478-1106764663=:18301
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="dumpaddr.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0501261337430.18301@chaos.analogic.com>
Content-Description: 
Content-Disposition: attachment; filename="dumpaddr.c"

DQoNCiNpbmNsdWRlIDxzdGRpby5oPg0KI2luY2x1ZGUgPHN0ZGxpYi5oPg0K
I2luY2x1ZGUgPHVuaXN0ZC5oPg0KI2luY2x1ZGUgPHN0cmluZy5oPg0KI2lu
Y2x1ZGUgPGVycm5vLmg+DQojaW5jbHVkZSA8c2lnbmFsLmg+DQojaW5jbHVk
ZSA8ZmNudGwuaD4NCiNpbmNsdWRlIDx0ZXJtaW9zLmg+DQojaW5jbHVkZSA8
c3lzL3R5cGVzLmg+DQojaW5jbHVkZSA8c3lzL21tYW4uaD4NCg0KI2RlZmlu
ZSB4eERFQlVHDQoNCiNpZiAhZGVmaW5lZChQQUdFX1NJWkUpDQojZGVmaW5l
IFBBR0VfU0laRSAweDEwMDANCiNlbmRpZg0KI2lmICFkZWZpbmVkKFBBR0Vf
TUFTSykNCiNkZWZpbmUgUEFHRV9NQVNLIH4oUEFHRV9TSVpFIC0gMSkNCiNl
bmRpZg0KI2lmICFkZWZpbmVkKE1BUF9GQUlMRUQpDQojZGVmaW5lIE1BUF9G
QUlMRUQgKHZvaWQgKikgLTENCiNlbmRpZg0KI2RlZmluZSBVTCB1bnNpZ25l
ZCBsb25nDQoNCiNkZWZpbmUgRVJST1JTIFwNCiAgICB7IGZwcmludGYoc3Rk
ZXJyLCBlcnJtc2csIF9fTElORV9fLFwNCiAgICAgIF9fRklMRV9fLCBlcnJu
bywgc3RyZXJyb3IoZXJybm8pKTtcDQogICAgICBleGl0KEVYSVRfRkFJTFVS
RSk7IH0NCg0KI2lmZGVmIERFQlVHDQojZGVmaW5lIERFQihmKSAoZikNCiNl
bHNlDQojZGVmaW5lIERFQihmKQ0KI2VuZGlmDQoNCnN0YXRpYyBjb25zdCBj
aGFyIGVycm1zZ1tdPSJFcnJvciBhdCBsaW5lICVkLCBmaWxlICVzICglZCkg
WyVzXVxuIjsNCnN0YXRpYyBjb25zdCBjaGFyIG1hcGZpbGVbXT0iL2Rldi9t
ZW0iOw0KI2RlZmluZSBQUk9UIChQUk9UX1JFQUR8UFJPVF9XUklURSkNCiNk
ZWZpbmUgRkxBR1MgKE1BUF9GSVhFRHxNQVBfU0hBUkVEKQ0KLyotPS09LT0t
PS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09
LT0tPS09LT0tPS09LT0tPS09LT0tKi8NCi8qDQogKiAgVGhpcyB3cml0ZXMg
YSAnZGVidWctbGlrZScgZHVtcCBvdXQgdGhlIHNjcmVlbi4gSXQgYWx3YXlz
IHdyaXRlcw0KICogIDE2IGxpbmVzIG9mIDE2IGNoYXJhY3RlcnMuIEl0IHJl
dHVybnMgdGhlIGxhc3QgYWRkcmVzcyBkaXNwbGF5ZWQuDQogKi8NCnN0YXRp
YyBvZmZfdCBkdW1wKG9mZl90IGFkZHIpOw0KDQpzdGF0aWMgb2ZmX3QgZHVt
cChvZmZfdCBhZGRyKQ0Kew0KICAgIHNpemVfdCBpLCBqOw0KICAgIGludCBm
ZDsNCiAgICBjYWRkcl90IG1lbTsNCiAgICBvZmZfdCBuZXh0Ow0KICAgIHVu
c2lnbmVkIGNoYXIgYywgKmJ1ZjsNCg0KICAgIG5leHQgPSBhZGRyOyANCiAg
ICBhZGRyICY9IFBBR0VfTUFTSzsNCiAgICBpZigoZmQgPSBvcGVuKG1hcGZp
bGUsIE9fUkRXUikpIDwgMCkNCiAgICAgICAgRVJST1JTOw0KDQogICAgaWYo
KG1lbSA9IG1tYXAoKGNhZGRyX3QpYWRkciwgUEFHRV9TSVpFICogMiwgUFJP
VCwgRkxBR1MsIGZkLCBhZGRyKSkgPT0gTUFQX0ZBSUxFRCkNCiAgICB7DQog
ICAgICAgICh2b2lkKWNsb3NlKGZkKTsNCiAgICAgICAgZnByaW50ZihzdGRl
cnIsICJcdENhbid0IG1hcCBhZGRyZXNzICUwOGxYXG4iLCAoVUwpIGFkZHIp
Ow0KICAgICAgICByZXR1cm4gKG9mZl90KW1lbTsNCiAgICB9IA0KDQoNCiAg
ICBwcmludGYoIm1tYXAgcmV0dXJuZWQgJXAgICgweCUwOHgpXG4iLCBtZW0s
IChzaXplX3QpIG1lbSk7DQoNCiAgICBidWYgPSAodW5zaWduZWQgY2hhciAq
KSBuZXh0Ow0KICAgIERFQihmcHJpbnRmKHN0ZGVyciwgIk1hcHBlZCBhZGRy
ZXNzID0gMHglbHhcbiIsIGFkZHIpKTsNCiAgICBERUIoZnByaW50ZihzdGRl
cnIsICJCdWZmZXIgYWRkcmVzcyA9ICVwXG4iLCBidWYpKTsNCg0KICAgIGZv
cihpPTA7IGk8IDB4MTA7IGkrKykNCiAgICB7DQogICAgICAgIGZwcmludGYo
c3Rkb3V0LCAiXG4lMDhsWCAiLCAoVUwpIG5leHQpOw0KICAgICAgICBuZXh0
ICs9IDB4MTA7DQogICAgICAgIGZvcihqPTA7IGo8IDB4MTA7IGorKykNCiAg
ICAgICAgICAgIGZwcmludGYoc3Rkb3V0LCAiJTAyWCAiLCAodW5zaWduZWQg
aW50KSAqYnVmKyspOw0KICAgICAgICBidWYgLT0gMHgxMDsNCiAgICAgICAg
Zm9yKGo9MDsgajwweDEwOyBqKyspDQogICAgICAgIHsNCiAgICAgICAgICAg
IGMgPSAqYnVmKys7DQogICAgICAgICAgICBpZigoYyA8ICh1bnNpZ25lZCBj
aGFyKSAnICcpIHx8IChjID4gKHVuc2lnbmVkIGNoYXIpICd6JykpDQogICAg
ICAgICAgICAgICAgYyA9ICh1bnNpZ25lZCBjaGFyKSAnLic7DQogICAgICAg
ICAgICBmcHJpbnRmKHN0ZG91dCwgIiVjIiwgYyk7DQogICAgICAgIH0NCiAg
ICB9DQogICAgZnByaW50ZihzdGRvdXQsICJcbiIpOw0KICAgICh2b2lkKWZm
bHVzaChzdGRvdXQpOw0KICAgICh2b2lkKWNsb3NlKGZkKTsNCiAgICBpZiht
dW5tYXAobWVtLCBQQUdFX1NJWkUpPCAwKQ0KICAgICAgICBFUlJPUlM7DQog
ICAgcmV0dXJuIG5leHQ7DQp9DQoNCnZvaWQgdXNhZ2UoY2hhciAqY3ApDQp7
DQogICAgICAgIGZwcmludGYoc3RkZXJyLCAiVXNhZ2VcbiVzIDxzdGFydCBh
ZGRyZXNzPiBbZW5kIGFkZHJlc3NdXG4iLCBjcCk7DQogICAgICAgIGV4aXQo
RVhJVF9GQUlMVVJFKTsNCn0NCg0KaW50IG1haW4oaW50IGFyZ3MsIGNoYXIg
KmFyZ3ZbXSkNCnsNCiAgICBvZmZfdCBhZGRyOw0KICAgIG9mZl90IGVuZDsN
Cg0KICAgIGlmKGFyZ3MgPCAyKQ0KICAgICAgICB1c2FnZShhcmd2WzBdKTsN
CiAgICBlbmQgPSAwOw0KICAgIGlmKHNzY2FuZihhcmd2WzFdLCAiJWx4Iiwg
JmFkZHIpICE9IDEpDQogICAgICAgIHVzYWdlKGFyZ3ZbMF0pOw0KICAgIGlm
KGFyZ3ZbMl0gIT0gTlVMTCkNCiAgICAgICAgKHZvaWQpc3NjYW5mKGFyZ3Zb
Ml0sICIlbHgiLCAmZW5kKTsNCiAgICBkbyB7ICAgIA0KICAgICAgICBpZigo
YWRkciA9IGR1bXAoYWRkcikpID09IDB4ZmZmZmZmZmYpDQogICAgICAgICAg
ICBicmVhazsNCiAgICAgICAgfSB3aGlsZSAoZW5kID4gYWRkcik7DQogICAg
cmV0dXJuIDA7DQp9DQoNCg==

--1879706418-2029547478-1106764663=:18301--
