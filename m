Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282091AbRKWJjH>; Fri, 23 Nov 2001 04:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282093AbRKWJjB>; Fri, 23 Nov 2001 04:39:01 -0500
Received: from mx2.elte.hu ([157.181.151.9]:11210 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S282094AbRKWJip>;
	Fri, 23 Nov 2001 04:38:45 -0500
Date: Fri, 23 Nov 2001 12:36:27 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Ryan Cumming <bodnar42@phalynx.dhs.org>
Cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>,
        <linux-smp@vger.kernel.org>
Subject: Re: [patch] sched_[set|get]_affinity() syscall, 2.4.15-pre9
In-Reply-To: <E16744i-0004zQ-00@localhost>
Message-ID: <Pine.LNX.4.33.0111231220350.3988-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-421162814-1006515387=:3988"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-421162814-1006515387=:3988
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Thu, 22 Nov 2001, Ryan Cumming wrote:

> [...] a /proc interface would allow me to change the CPU affinity of
> processes that aren't {get, set}_affinity aware (i.e., all Linux
> applications written up to this point). [...]

had you read my patch then you'd perhaps have noticed how easy it is
actually. I've attached a simple utility called 'chaff' (change affinity)
that allows to change the affinity of unaware processes:

 mars:~> ./chaff 714 0xf0
 pid 714's old affinity: 000000ff.
 pid 714's new affinity: 000000f0.

>  And one final thing... what sort of benifit does CPU affinity have if
> we have the scheduler take in account CPU migration costs correctly?
> [...]

while you are right that the scheduler can and should guess lots of
things, but it cannot guess some things. Eg. it has no idea whether a
particular process' workload is related to any IRQ source or not. And if
we bind IRQ sources for performance reasons, then the scheduler has no
chance finding the right CPU for the process. (I have attempted to
implement such a generic mechanizm a few months ago but quickly realized
that nothing like that will ever be accepted in the mainline kernel -
there is simply no way establish any reliable link between IRQ load and
process activities.)

So i implemented the smp_affinity and ->cpus_allowed mechanizms to allow
specific applications (who know the kind of load they generate) to bind to
specific CPUs, and to bind IRQs to CPUs. Obviously we still want the
scheduler to make good decisions - but linking IRQ load and scheduling
activity is too expensive. (i have a scheduler improvement patch that does
do some of this work at wakeup time, and which patch benefits Apache, but
this is still not enough to get the 'best' affinity.)

	Ingo

--8323328-421162814-1006515387=:3988
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="chaff.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0111231236270.3988@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="chaff.c"

DQovKg0KICogU2ltcGxlIGxvb3AgdGVzdGluZyB0aGUgQ1BVLWFmZmluaXR5
IHN5c2NhbGwuDQogKi8NCiNpbmNsdWRlIDx0aW1lLmg+DQojaW5jbHVkZSA8
c3RkaW8uaD4NCiNpbmNsdWRlIDxzdGRsaWIuaD4NCiNpbmNsdWRlIDxsaW51
eC91bmlzdGQuaD4NCg0KI2RlZmluZSBfX05SX3NjaGVkX3NldF9hZmZpbml0
eSAyMjYNCl9zeXNjYWxsMyAoaW50LCBzY2hlZF9zZXRfYWZmaW5pdHksIHBp
ZF90LCBwaWQsIHVuc2lnbmVkIGludCwgbWFza19sZW4sIHVuc2lnbmVkIGxv
bmcgKiwgbWFzaykNCg0KI2RlZmluZSBfX05SX3NjaGVkX2dldF9hZmZpbml0
eSAyMjcNCl9zeXNjYWxsMyAoaW50LCBzY2hlZF9nZXRfYWZmaW5pdHksIHBp
ZF90LCBwaWQsIHVuc2lnbmVkIGludCAqLCBtYXNrX2xlbiwgdW5zaWduZWQg
bG9uZyAqLCBtYXNrKQ0KDQppbnQgbWFpbiAoaW50IGFyZ2MsIGNoYXIgKiph
cmd2KQ0Kew0KCWludCBwaWQsIHJldDsNCgl1bnNpZ25lZCBpbnQgbWFza19s
ZW47DQoJdW5zaWduZWQgbG9uZyBtYXNrLCBuZXdfbWFzazsNCg0KCWlmIChh
cmdjICE9IDMpIHsNCgkJcHJpbnRmKCJ1c2FnZTogY2hhZmYgPHBpZD4gPGhl
eF9tYXNrPlxuIik7DQoJCWV4aXQoLTEpOw0KCX0NCglwaWQgPSBhdG9sKGFy
Z3ZbMV0pOw0KCXNzY2FuZihhcmd2WzJdLCAiJWx4IiwgJm5ld19tYXNrKTsN
Cg0KcHJpbnRmKCJwaWQ6ICVkLiBuZXdfbWFzazogKCVzKSAlMDhseC5cbiIs
IHBpZCwgYXJndlsyXSwgbmV3X21hc2spOw0KDQoJcmV0ID0gc2NoZWRfZ2V0
X2FmZmluaXR5KHBpZCwgJm1hc2tfbGVuLCAmbWFzayk7DQoJaWYgKHJldCkg
ew0KCQlwcmludGYoImNvdWxkIG5vdCBnZXQgcGlkICVkJ3MgYWZmaW5pdHku
XG4iLCBwaWQpOw0KCQlyZXR1cm4gLTE7DQoJfQ0KCXByaW50ZigicGlkICVk
J3Mgb2xkIGFmZmluaXR5OiAlMDhseC4iLCBwaWQsIG1hc2spOw0KDQoJcmV0
ID0gc2NoZWRfc2V0X2FmZmluaXR5KHBpZCwgc2l6ZW9mKG5ld19tYXNrKSwg
Jm5ld19tYXNrKTsNCglpZiAocmV0KSB7DQoJCXByaW50ZigiY291bGQgbm90
IHNldCBwaWQgJWQncyBhZmZpbml0eS5cbiIsIHBpZCk7DQoJCXJldHVybiAt
MTsNCgl9DQoJcmV0ID0gc2NoZWRfZ2V0X2FmZmluaXR5KHBpZCwgJm1hc2tf
bGVuLCAmbWFzayk7DQoJaWYgKHJldCkgew0KCQlwcmludGYoInNjaGVkX2dl
dF9hZmZpbml0eSByZXR1cm5lZCAlZCwgZXhpdGluZy5cbiIsIHJldCk7DQoJ
CXJldHVybiAtMTsNCgl9DQoJcHJpbnRmKCJwaWQgJWQncyBuZXcgYWZmaW5p
dHk6ICUwOGx4LiIsIHBpZCwgbWFzayk7DQoJcmV0dXJuIDA7DQp9DQo=
--8323328-421162814-1006515387=:3988--
