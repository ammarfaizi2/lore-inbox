Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318205AbSIJWyE>; Tue, 10 Sep 2002 18:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318207AbSIJWyE>; Tue, 10 Sep 2002 18:54:04 -0400
Received: from h181n1fls11o1004.telia.com ([195.67.254.181]:9357 "EHLO
	ringstrom.mine.nu") by vger.kernel.org with ESMTP
	id <S318205AbSIJWyB>; Tue, 10 Sep 2002 18:54:01 -0400
Date: Wed, 11 Sep 2002 00:58:40 +0200 (CEST)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: tori@boris.prodako.se
To: Ingo Molnar <mingo@elte.hu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with the O(1) scheduler in 2.4.19
In-Reply-To: <Pine.LNX.4.44.0209032004380.4252-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209102306340.14220-300000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811717-1953504357-1031693815=:14271"
Content-ID: <Pine.LNX.4.44.0209102337070.14486@boris.prodako.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811717-1953504357-1031693815=:14271
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0209102337071.14486@boris.prodako.se>

On Tue, 3 Sep 2002, Ingo Molnar wrote:

> does -10 make it equivalent to the 2.4 behavior? Could you somehow measure
> the priority where it's still acceptable? Ie. -8 or -9?

I've done some more experimenting, and I've found something interesting.  
I've attached two very simple CPU hog programs.

The program latency runs in a tight loop calling gettimeofday, and prints
the loop time if it exceeds 8 ms.  This program simulates a game server,
video decoding program or whatever.

The program hog sleeps for five seconds, and then runs in a tight loop.  
This program simulates a cron job.  This program is always run at the
default nice level (0).

I will now run the latency program at the three different nice levels -20
(high prio), 0 (normal) and 20 (low prio).  A few seconds after latency is 
started, hog is started.  Note that there are no visible latency when hog 
program is started, the latency comes from the loop five seconds after 
the start:

[root@boris Prog]# nice -n -20 ./latency
00:22:16: dt = 608.864 ms
00:22:17: dt = 150.978 ms
00:22:18: dt = 150.983 ms
00:22:19: dt = 150.979 ms
00:22:20: dt = 150.981 ms

[root@boris Prog]# nice -n 0 ./latency
00:22:49: dt = 604.865 ms
00:22:50: dt = 150.966 ms
00:22:50: dt = 150.964 ms
00:22:51: dt = 150.963 ms
00:22:51: dt = 152.981 ms

[root@boris Prog]# nice -n 19 ./latency
00:23:44: dt = 678.848 ms
00:23:44: dt = 150.964 ms
00:23:44: dt = 150.978 ms
00:23:44: dt = 150.978 ms
00:23:45: dt = 150.978 ms

Here we can see that the time slice for hog is stabilized at 150 ms, and
that as the latency program is niced, the hog program gets its time slices
more often.  I think this is what's supposed to happen, but the problem is
the >600 ms timeslice that hog gets when it starts to run.  Comments?

One could also argue that 150 ms is a bit too much.  For video playback at
25 FPS, that means three lost frames.  I do understand the benefits of
long timeslices, of course.  It's a hard choice...

This is on a HZ=1000 2.4.19+sched-2.4.19-rc2-A4 kernel.

/Tobias

---1463811717-1953504357-1031693815=:14271
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="hog.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0209110058400.14732@boris.prodako.se>
Content-Description: 
Content-Disposition: attachment; filename="hog.c"

I2luY2x1ZGUgPHVuaXN0ZC5oPg0KaW50IG1haW4oKQ0Kew0KCXNsZWVwKDUp
Ow0KCWZvciAoOzspDQoJCTsNCn0NCg==
---1463811717-1953504357-1031693815=:14271
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="latency.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0209110058401.14732@boris.prodako.se>
Content-Description: 
Content-Disposition: attachment; filename="latency.c"

I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3lzL3RpbWUuaD4NCiNp
bmNsdWRlIDx0aW1lLmg+DQojaW5jbHVkZSA8dW5pc3RkLmg+DQoNCmRvdWJs
ZSBub3codm9pZCkNCnsNCglzdHJ1Y3QgdGltZXZhbCB0Ow0KCWdldHRpbWVv
ZmRheSgmdCwgTlVMTCk7DQoJcmV0dXJuIHQudHZfc2VjICsgdC50dl91c2Vj
ICogMWUtNjsNCn0NCg0KaW50IG1haW4oKQ0Kew0KCWRvdWJsZSB0MCwgdCwg
ZHQsIG1heF9kdCA9IDAuMDsNCgljaGFyIHRidWZbMTAwXTsNCgl0aW1lX3Qg
dXRjOw0KDQoJdDAgPSBub3coKTsNCglmb3IgKDs7KQ0KCXsNCgkJdCA9IG5v
dygpOw0KCQlkdCA9IHQgLSB0MDsNCgkJaWYgKGR0ID4gMC4wMDgpDQoJCXsN
CgkJCW1heF9kdCA9IGR0Ow0KCQkJdGltZSgmdXRjKTsNCgkJCXN0cmZ0aW1l
KHRidWYsIHNpemVvZih0YnVmKSwgIiVUIiwgbG9jYWx0aW1lKCZ1dGMpKTsN
CgkJCXByaW50ZigiJXM6IGR0ID0gJS4zZiBtc1xuIiwgdGJ1ZiwgbWF4X2R0
ICogMWUzKTsNCgkJCXQgPSBub3coKTsNCgkJfQ0KCQl0MCA9IHQ7DQoJfQ0K
DQoJcmV0dXJuIDA7DQp9DQo=
---1463811717-1953504357-1031693815=:14271--
