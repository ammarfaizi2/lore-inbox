Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbTLPQnG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 11:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbTLPQnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 11:43:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:55509 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261931AbTLPQm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 11:42:58 -0500
Date: Tue, 16 Dec 2003 08:42:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: jw schultz <jw@pegasys.ws>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: raid0 slower than devices it is assembled of?
In-Reply-To: <3FDF1C03.2020509@aitel.hist.no>
Message-ID: <Pine.LNX.4.58.0312160825570.1599@home.osdl.org>
References: <200312151434.54886.adasi@kernel.pl> <20031216040156.GJ12726@pegasys.ws>
 <3FDF1C03.2020509@aitel.hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Dec 2003, Helge Hafting wrote:
>
> Raid-0 is ideally N times faster than a single disk, when
> you have N disks.

Well, that's a _really_ "ideal" world. Ideal to the point of being
unrealistic.

In most real-world situations, latency is at least as important as
throughput, and often dominates the story. At which point RAID-0 doesn't
improve performance one iota (it might make the seeks shorter, but since
seek latency tends to be dominated by things like rotational delay and
settle times, that's unlikely to be a really noticeable issue).

Latency is noticeable even on what appears to be "prue throughput" tests,
because not only do you seldom get perfect overlap (RAID-0 also increases
your required IO window size by a factor of N to get the N-time
improvement), but even "pure throughput" benchmarks often have small
serialized sections, and Amdahls law bites you in the ass _really_
quickly.

In fact, Amdahls law should be revered a hell of a lot more than Moore's
law. One is a conjecture, the other one is simple math.

Anyway, the serialized sections can be CPU or bus (quite common at the
point where a single disk can stream 50MB/s when accessed linearly), or it
can be things like fetching meta-data (ie indirect blocks).

> Wether the current drivers manages that is of course another story.

No. Please don't confuse limitations of RAID0 with limitations of "the
current drivers".

Yes, the drivers are a part of the picture, but they are a _small_ part of
a very fundamental issue.

The fact is, modern disks are GOOD at streaming data. They're _really_
good at it compared to just about anything else they ever do. The win you
get from even medium-sized stripes on RAID0 are likely to not be all that
noticeable, and you can definitely lose _big_ just because it tends to
hack your IO patterns to pieces.

My personal guess is that modern RAID0 stripes should be on the order of
several MEGABYTES in size rather than the few hundred kB that most people
use (not to mention the people who have 32kB stripes or smaller - they
just kill their IO access patterns with that, and put the CPU at
ridiculous strain).

Big stripes help because:

 - disks already do big transfers well, so you shouldn't split them up.
   Quite frankly, the kinds of access patterns that let you stream
   multiple streams of 50MB/s and get N-way throughput increases just
   don't exists in the real world outside of some very special niches (DoD
   satellite data backup, or whatever).

 - it makes it more likely that the disks in the array really have
   _independent_ IO patterns, ie if you access multiple files the disks
   may not seek around together, but instead one disk accesses one file.
   At this point RAID0 starts to potentially help _latency_, simply
   because by now it may help avoid physical seeking rather than just try
   to make throughput go up.

I may be wrong, of course. But I doubt it.

			Linus
