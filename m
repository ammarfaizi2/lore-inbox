Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265843AbSLXUwu>; Tue, 24 Dec 2002 15:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265844AbSLXUwu>; Tue, 24 Dec 2002 15:52:50 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:32784
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S265843AbSLXUws>; Tue, 24 Dec 2002 15:52:48 -0500
Subject: Re: Horrible drive performance under concurrent i/o jobs (dlh
	problem?)
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: jw schultz <jw@pegasys.ws>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021224172122.GB30929@pegasys.ws>
References: <000d01c2a8b6$3d102e20$941e1c43@joe>
	 <B7CC2AA8-1720-11D7-8DC6-000393950CC2@karlsbakk.net>
	 <20021224172122.GB30929@pegasys.ws>
Content-Type: text/plain
Organization: 
Message-Id: <1040763659.2109.26.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 24 Dec 2002 13:00:59 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-24 at 09:21, jw schultz wrote:
> I'm afraid your math is off.
> 
> The rotational frequency should be 7200*60/sec which makes
> for 2.31 us which would produce an average rotational
> latency of 1.16us if such a condition even still applies.

No, I think you're just a bit off.  A 7200RPM drive *does* revolve in
8.3ms.  A 2.31us rotation time would be 432900 RPS or approx. 26,000,000
RPM.  Which is pushing it.

The 8.3ms rotational latency is clearly visible as a wide band if you
graph access time against distance. 
http://www.goop.org/~jeremy/seek-buf.eps is an example of a 7200RPM
Western Digital drive.

> My expectation is that the whole track is buffered starting
> from the first sector that syncs thereby making the time
> rotfreq + rotfreq/nsect or something similar.  In any case
> the rotational latency or frequency is orders of magnitude
> smaller than the seek time, even between adjacent
> tracks/cylinders.

Track to track seek time is typically around 1ms.  Rotational latency is
often the dominating factor in access time.

> If the the stated average seek is 50% of full stroke and not
> based on reality then 76% of the cost of an average seek is
> attributed to distance and likewise 87% of the cost of a
> full.

Well, average seek is a vague concept.  If you assume that all seeks are
randomly distributed, then it might mean a half-stroke seek.  But almost
all seeks are short, so the weighting means that short seek time is the
most important to optimise (which drive vendors do: they use techniques
like dumping more current into the coils for short seeks because they
know it is short; if they dumped the same current for a long seek, it
would burn things out).  Also, there are only two cylinders between
which you can have the maximal seek, whereas every adjacent pair of
cylinders can have a minimal seek; in other words the physical nature of
the drive means that short seeks will dominate, even with random
seeking.

Rotational latency tends to dominate these days: a fast drive can do a
track to track seek in 1ms, and full-stroke seek in 9ms or so.  That
means that a 1ms track-to-track seek can take longer than a full stroke
if you include the 8.3ms variation.

Elevators are important for keeping seeks short.  This is partly to
reduce the seek time, but mostly because drives are optimised so that
the track-to-track skew is set up to minimise rotational latency.  The
further you seek, the more likely you are to miss the rotlat deadline
and have to take a full rotation penalty.

	J

