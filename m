Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbTLGFom (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 00:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263447AbTLGFom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 00:44:42 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:29970 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261539AbTLGFok
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 00:44:40 -0500
Date: Sun, 7 Dec 2003 00:33:22 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Jamie Lokier <jamie@shareable.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: libata in 2.4.24?
In-Reply-To: <20031203004736.GB27306@mail.shareable.org>
Message-ID: <Pine.LNX.3.96.1031207002609.7168A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Dec 2003, Jamie Lokier wrote:

> bill davidsen wrote:
> > With O_SYNC files there is the possibility of having a don't cache bit
> > in the packet to the drive, even with write caching. With fsync I don't
> > see any way to do it after the fact for only some of the data in the
> > drive cache. That's just an observation.
> 
> With fsync, can't you write all the dirty pages with that bit set,
> write _again_ all the pages in RAM which are clean but which have
> never been written with the don't-cache bit, and read-then-write with
> the bit set all the pages which are not in RAM but which were dirtied
> and written without the don't cache bit set?

Actually, what I meant was to pass the bit to the drive, so that it would
not return completion status until physical completion. That can be done
for O_SYNC. But fsync() is after the fact, the o/s has no way of knowing
that the pages already sent to the drive have been written to media except
to do a cache flush and flush everything.

I don't think there's anything else you can do with fsync() with or
without the bit, since you may no longer have the buffers to send with the
bit set. Moreover, some drives, reportedly IBM, tend to botch a sevtor
being written during power fail, if I understand your proposal it *cold*
result in a buffer being sent to the drive twice, and a power fail during
the 2nd write could clobber the good data you wrote.

That's assuming I understand what you propose.

> 
> I know, it sounds a bit complicated :)
> 
> But would it work?

Maybe a guru will disagree, but I would say that just switching to what
SCSI does and caching the write on the drive and not returning done status
until it completes is the right solution. Maybe a drive vendor will do
that, maybe it's in SATA-2 spec, I was just making up the bit which
indicated a realtime write buffer, as a way O_SYNC could work without
killing performance.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

