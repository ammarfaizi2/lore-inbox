Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268702AbRGaGIc>; Tue, 31 Jul 2001 02:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269186AbRGaGIX>; Tue, 31 Jul 2001 02:08:23 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:32274 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S268702AbRGaGIS>; Tue, 31 Jul 2001 02:08:18 -0400
Message-ID: <3B664CA6.564DA9BA@zip.com.au>
Date: Tue, 31 Jul 2001 16:13:58 +1000
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Tony.Lill@ajlc.waterloo.on.ca, linux-kernel@vger.kernel.org
Subject: Re: laptops and journalling filesystems
In-Reply-To: <3B662642.4AB6E800@zip.com.au> <Pine.LNX.4.33L.0107310046570.5582-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Rik van Riel wrote:
> 
> On Tue, 31 Jul 2001, Andrew Morton wrote:
> > Tony Lill wrote:
> > >
> > > Do any of the current batch of journalling filesystems NOT diddle the
> > > disk every 5 seconds?
> 
> > Unfortunately ext3 defeats the trick of setting the kupdate
> > interval to something huge.  On my list of things-to-do.
> >
> > Probably it's as simple as setting the commit timer to
> > a large interval (grep for "HZ" in fs/jbd/journal.c).
> 
> How about using bdf_prm.b_un.interval as the commit
> timer for ext3 ?

It may be best to keep them separate - they do rather different
things, and the system may have multiple filesystems.  Plus
it'd be yet another thing we need which isn't exported :(

What would be nice would be the ability for external code to be
notified of kupdate and bdflush activity - that way we can
do what you suggest for laptops - do all the disk activity in
a single hit.

The ability to know when bdflush is woken would be useful
for other VM-related reasons.  Generally the bulk of ext3 data
is writable by bdflush and freeable by the releasepage()
address_space op (aka try_to_free_buffers).  But metadata
doesn't have an address_space, which is why we can get a 
bit gummed up at times.   The best fix for this is to take
over all the IO scheduling and drop the ext3 structures from the
buffers at IO completion time.  That's version 2.

> With the addition that normal writeouts to disk (those
> go via the ext3 code, right?) also trigger a commit, if
> the last commit was long enough ago to not impact system
> efficiency.
> 
> This way you should, on laptops, have the ext3 commit
> happening either at the same time as the kflushd write
> (triggered by the write) or the next kflushd interval
> away.

When ext3 commits, all data is written to its final resting place
on disk, and then all metadata is written to the journal and then
released for normal writeback.  So if we were to start IO on that
writeback data immediately, there is no need for kupdate at all.
That would work, as a special laptop feature.  A mount option or
tune2fs setting.    Any synchronous operation would force an immediate
commit, of course.

-
