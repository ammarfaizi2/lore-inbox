Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264586AbTLQWkx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 17:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264588AbTLQWkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 17:40:53 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:51213 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264586AbTLQWku
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 17:40:50 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: raid0 slower than devices it is assembled of?
Date: 17 Dec 2003 22:29:18 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <brqlbu$7vh$1@gatekeeper.tmr.com>
References: <3FDF1C03.2020509@aitel.hist.no> <Pine.LNX.4.58.0312160825570.1599@home.osdl.org>
X-Trace: gatekeeper.tmr.com 1071700158 8177 192.168.12.62 (17 Dec 2003 22:29:18 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.58.0312160825570.1599@home.osdl.org>,
Linus Torvalds  <torvalds@osdl.org> wrote:
| 
| 
| On Tue, 16 Dec 2003, Helge Hafting wrote:
| >
| > Raid-0 is ideally N times faster than a single disk, when
| > you have N disks.
| 
| Well, that's a _really_ "ideal" world. Ideal to the point of being
| unrealistic.
| 
| In most real-world situations, latency is at least as important as
| throughput, and often dominates the story. At which point RAID-0 doesn't
| improve performance one iota (it might make the seeks shorter, but since
| seek latency tends to be dominated by things like rotational delay and
| settle times, that's unlikely to be a really noticeable issue).

Don't forget time in o/s queues, once an array get loaded that may
dominate the mechanical latency and transfer times. If you call "access
time" the sum of all latency between syscall and the first data
transfer, then reading from multiple drives doesn't reliably help until
you get the transfer time from an i/o somewhere between 2 and 4x the
access time. So if the transfer time for a typical i/o is less than 2x
the typical access time, gains are unlikely. If you set the stripe size
high enough to make it likely that a typical i/o falls on a single drive
you usually win. And when the transfer time reaches 4x the access time,
you almost always win with a split.

So if you are copying 100MB elements you probably win by spreading the
i/o, but for more normal things it doesn't much matter.

THERE'S ONE EXCEPTION: if you have a f/s type which puts the inodes at
the beginning of the space, and you are creating and deleting a LOT of
files, with a large stripe you will beat the snot out of one drive and
the system will bottleneck no end. In that one case you gain by using
small stripe size and spreading the head motion, even though the file
i/o itself may really rot. Makes me wish for a f/s which could put the
inodes in some distributed pattern.
| 
| Latency is noticeable even on what appears to be "prue throughput" tests,
| because not only do you seldom get perfect overlap (RAID-0 also increases
| your required IO window size by a factor of N to get the N-time
| improvement), but even "pure throughput" benchmarks often have small
| serialized sections, and Amdahls law bites you in the ass _really_
| quickly.
| 
| In fact, Amdahls law should be revered a hell of a lot more than Moore's
| law. One is a conjecture, the other one is simple math.
| 
| Anyway, the serialized sections can be CPU or bus (quite common at the
| point where a single disk can stream 50MB/s when accessed linearly), or it
| can be things like fetching meta-data (ie indirect blocks).
| 
| > Wether the current drivers manages that is of course another story.
| 
| No. Please don't confuse limitations of RAID0 with limitations of "the
| current drivers".
| 
| Yes, the drivers are a part of the picture, but they are a _small_ part of
| a very fundamental issue.
| 
| The fact is, modern disks are GOOD at streaming data. They're _really_
| good at it compared to just about anything else they ever do. The win you
| get from even medium-sized stripes on RAID0 are likely to not be all that
| noticeable, and you can definitely lose _big_ just because it tends to
| hack your IO patterns to pieces.
| 
| My personal guess is that modern RAID0 stripes should be on the order of
| several MEGABYTES in size rather than the few hundred kB that most people
| use (not to mention the people who have 32kB stripes or smaller - they
| just kill their IO access patterns with that, and put the CPU at
| ridiculous strain).

Yeah, yeah, what you said... all true.
| 
| Big stripes help because:
| 
|  - disks already do big transfers well, so you shouldn't split them up.
|    Quite frankly, the kinds of access patterns that let you stream
|    multiple streams of 50MB/s and get N-way throughput increases just
|    don't exists in the real world outside of some very special niches (DoD
|    satellite data backup, or whatever).
| 
|  - it makes it more likely that the disks in the array really have
|    _independent_ IO patterns, ie if you access multiple files the disks
|    may not seek around together, but instead one disk accesses one file.
|    At this point RAID0 starts to potentially help _latency_, simply
|    because by now it may help avoid physical seeking rather than just try
|    to make throughput go up.
| 
| I may be wrong, of course. But I doubt it.

Not that I can see, but I'm not sure that you had thought that the
inodes and the data may have very different usage patterns.

About six years ago most usenet software used one file per article to
hold data. Creating and deleting 10-20 files/sec put a severe load on
the directory and journal drives. Eventually (with AIX and JFS) I put
the journal file on a solid state drive to get performance up.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
