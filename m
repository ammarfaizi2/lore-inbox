Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268033AbUHKMF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268033AbUHKMF0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 08:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268035AbUHKMF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 08:05:26 -0400
Received: from mail.gmx.de ([213.165.64.20]:18837 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268033AbUHKMFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 08:05:08 -0400
X-Authenticated: #4512188
Message-ID: <411A0B71.4030503@gmx.de>
Date: Wed, 11 Aug 2004 14:05:05 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler fairness problem on 2.6 series
References: <20040811022143.4892.qmail@web13910.mail.yahoo.com> <cone.1092193795.772385.25569.502@pc.kolivas.org> <4119F3D9.7040708@gmx.de> <411A024B.6060100@kolivas.org>
In-Reply-To: <411A024B.6060100@kolivas.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Con Kolivas wrote:
| Prakash K. Cheemplavam wrote:
|
|> Con Kolivas wrote:
|> | I tried this on the latest staircase patch (7.I) and am not getting any
|> | output from your script when tested up to 60 threads on my hardware.
|> Can
|> | you try this version of staircase please?
|> |
|> | There are 7.I patches against 2.6.8-rc4 and 2.6.8-rc4-mm1
|> |
|> | http://ck.kolivas.org/patches/2.6/2.6.8/
|>
|> Hi,
|>
|> I just updated to 2.6.8-rc4-ck2 and tried the two options interactive
|> and compute. Is the compute stuff functional? I tried setting it to 1
|> within X and after that X wasn't usable anymore (meaning it looked like
|> locked up, frozen/gone mouse cursor even). I managed to switch back to
|> console and set it to 0 and all was OK again.
|
|
| Compute is very functional. However it isn't remotely meant to be run on
| a desktop because of very large scheduling latencies (on purpose).

Uhm, OK, I didn't know it would have such drastic effect. Perhpas you
should add a warnign that this setting shouldn't be used on X. :-)

|
|> The interactive to 0 setting helped me with runnign locally multiple
|> processes using mpi. Nevertheless (only with interactive 1 regression to
|> vanilla scheduler, else same) can't this be enhanced?
|
|
| I don't understand your question. Can what be enhanced?
|
|> Details: I am working on a load balancing class using mpi. For testing
|> purpises I am running multiple processes on my machine. So for a given
|> problem I can say, it needs x time to solve. Using more processes opn a
|> single machine, this time (except communication and balancing overhead)
|> shouldn't be much larger. Unfortunately this happens. Eg. a given
|> probelm using two processes needs about 20 seconds to finish. But using
|> 8 it already needs 47s (55s with interactiv set to 1). No, my balancing
|> framework is quite good. On a real (small, even larger till 128 nodes
|> tested) cluster overhead is just as low as 3% to 5%, ie. it scales quite
|> linearly.
|
|
| Once again I dont quite understand you. Are you saying that there is
| more than 50% cpu overhead when running 8 processes? Or that the cpu is
| distributed unfairly such that the longest will run for 47s?

I don't think it is the overhead. I rather think the way the kernel
schedulers gives mpich and the cpu bound program  resources is unfair.
Or the timeslice is tto big? Those 8 processes in my test usually do a
load-balancing after 1 second of work. In this second all of those
processes should use the CPU at the same time. I rather have the
impression that the processes get CPU time one after the other, so it
fools the load balancer to think the cpu is fast (the job is done in
"regular" time but the overhead seems to be big, as each process after
having finished now waits for the next one to finish and communicate
with it.

Or to put it more graphically (with 4 processes consisting of 3 parts
just for making it clear and final communication:)

What is done now (xy, x: process, y:part or communication):

11 12 13 1c 21 22 23 2c 31 32 33 3c 41 42 43 4c

What the sheduler should rather do:

11 21 31 41 12 22 32 42 13 23 33 43 1c 2c 3c 4c

So the balancer would rather find the CPU to be slower by the factor of
used processes instead of thinking the overhead is big. (I am not sure
whether this really explains the steep increase of time wasted with more
processes used. Perheaps it really is mpich, though I don't understand
why it would use up so much time. Any way for me to find out? Via
profiling?)

This is just a guess of what I think goes wrong. (Is the timeslice
simply too big which the scheduler gives each process?)

hth,

Prakash
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBGgtxxU2n/+9+t5gRAp4HAJ0eN4j3RHvTmvQDzMi+fpa2YAuU3QCgpQRQ
6zbDInJz3DqrJrzh3DUTiIw=
=Yk5C
-----END PGP SIGNATURE-----
