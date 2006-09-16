Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWIPXTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWIPXTc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 19:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWIPXTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 19:19:32 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:3776 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S964811AbWIPXTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 19:19:31 -0400
Message-ID: <450C8680.6050904@comcast.net>
Date: Sat, 16 Sep 2006 19:19:28 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Scheduler tunables?
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

It looks like the scheduler tunables have been removed from 2.6
somewhere before 2.6.17.  I'm looking at these because I am considering
increasing the minimum timeslice to at least 80msec.

I'm considering also either a geometric or algebraic transform (multiply
or add) to timeslices, letting them get calculated as-is but then
applying the transformation after the base timeslice size is figured
out.  The reason for this is to try and tweak certain embedded systems
which seem to suffer from CPU cache issues... low L1 cache, cache isn't
stored/restored across task switches like registers (that would be
dumb...), and a cache miss costs 25 cycles while a cache hit costs 1.

I took a look at this in cachegrind (profile is I1 and D1 are both 16384
byte 4-way set associative with 32-byte cache lines; there is no L2
cache, feed it 64,2,32 and ignore the stats for I2/D2) and came up with
something like a 44.5% performance hit if we assume that context
switches and multitasking never happen based ONLY on the D1 stats (1.9%
D1 cache miss).  For comparision, my Athlon 64 misses 0.9% of the time
but only misses L2 cache 0.2% of the time and would suffer a 5%
performance hit from this (assuming L2 cache takes 1 extra cycle and an
L2 cache miss takes 25 extra).

My worry is that 44.5% is based on idiotic assumptions, namely that the
process is never scheduled away from, not for interrupts or multitasking
or syscalls.  When scheduling or syscalls happens, the cache will start
to have entries replaced by entries in other tasks; by the time we come
back to the current task, we'll have a few areas of the working set no
longer cached, and get more cache misses.  The only thing I can do for
this is prevent scheduling as long as is feasible.

If anyone wants to correct me on anything I've gotten wrong here feel
free, I'm still digging around looking for ways to improve the
situation.  Reducing code executed is a good way (i.e. make programs not
do a lot of excess junk), but is case by case; finding a way to knock
out even 5% of the overhead here globally would be helpful.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRQyGfgs1xW0HCTEFAQLTxw//cWJ2Ep473TqC9KmuiM1Lr189gKs9sfgk
Aacrt10nSGBlLmjH6dR51By8kpjGasMH3Wr4l2/TdeMhWx+ME+uWM8jYTclX5Cei
LcJamzCoMQGmqFvDe4iGbh66zFhUnJFX+UhQ2zvPhAd1RVBad1sCvb8YJC5M892d
abSBPWO3FmP2JsDdfcq82Th0kxi7xHfib3QBMoVD+3nRiAgOCMkXle7yb3G7M375
j2F7etKqDnd1Iv0Rm7VuWvG/gA8hoMtgYR5q/sibZGAk3BwPCNTg1T0D/LSIKoat
v+5monnYUMN2X491zF0JPONqTh0KtpBURGfWPQ59OODkVBcJQqPelHsZXuUBzdGz
STyNIvCKMZkjFDJ7VMxopfxneG76DEbyd9MlllNhWqbLT5OREJZm62MOWP1nfInT
/LkuyOe5GvEtPTy1DT13upSkxAppPfpqmkNwOXAlgrEuriTp6mOep32v+/XoWoFB
oYSATThDN7vaZFbw3V5+wQFbaA7uzAzfyvptXstFhDtM9791WoRZWRJArqQJnCcr
nayqJvEH/H4oOhtFIwCpICOu1upcuN6s34R7ROZ+5OpajduXRa/ejIEaW3TEecyY
nteQLmy+gYvzISOf8ynK3JV5tEcSOS8uNWJFX9dSsw2/HK0GDJCpMNDFrCbZi6ou
JgytxT3qAiE=
=K8DM
-----END PGP SIGNATURE-----
