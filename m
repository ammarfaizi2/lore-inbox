Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263711AbUAHEyL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 23:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263723AbUAHEyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 23:54:11 -0500
Received: from dci.doncaster.on.ca ([66.11.168.194]:12934 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S263711AbUAHEyH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 23:54:07 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, jw schultz <jw@pegasys.ws>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: raid0 slower than devices it is assembled of?
References: <200312151434.54886.adasi@kernel.pl>
	<20031216040156.GJ12726@pegasys.ws> <3FDF1C03.2020509@aitel.hist.no>
	<Pine.LNX.4.58.0312160825570.1599@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312160825570.1599@home.osdl.org>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 07 Jan 2004 23:54:05 -0500
Message-ID: <87llojujki.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds <torvalds@osdl.org> writes:

> The fact is, modern disks are GOOD at streaming data. They're _really_
> good at it compared to just about anything else they ever do. The win you
> get from even medium-sized stripes on RAID0 are likely to not be all that
> noticeable, and you can definitely lose _big_ just because it tends to
> hack your IO patterns to pieces.

I'm not sure how you reach this conclusion. 50MB/s may sound like a lot, it's
sure a whole lot more than the 2MB/s I get on this 486 over here. But then the
hard drive I have that gets 50MB/s is also 250G and the one in the 486 is
425M, a factor of 588 difference in size. So as good as the drives are getting
at streaming data, the amount of data we want to stream is going up even
faster.

> My personal guess is that modern RAID0 stripes should be on the order of
> several MEGABYTES in size rather than the few hundred kB that most people
> use (not to mention the people who have 32kB stripes or smaller - they
> just kill their IO access patterns with that, and put the CPU at
> ridiculous strain).

> Big stripes help because:
> 
>  - disks already do big transfers well, so you shouldn't split them up.
>    Quite frankly, the kinds of access patterns that let you stream
>    multiple streams of 50MB/s and get N-way throughput increases just
>    don't exists in the real world outside of some very special niches (DoD
>    satellite data backup, or whatever).

Or just about any moderate sized SQL database. Virtually any large query will
cause what Oracle calls "full table scan"s or what postgres calls a
"sequential scan" precisely because reading sequential data is way faster than
random access. Often a single query will generate several such streams, and
often large on-disk sorts which have sequential access patterns as well.

It seems to me that having a stripe-size of several megabytes will defeat the
read-ahead and essentially limit the database to 50MB/s which while it seems
like a lot really isn't fast enough to keep up with the increase in the amount
of data being handled. Even a small database with tables around 1GB will
benefit enormously from being able to stream the data at 100MB/s or 150MB/s.

> I may be wrong, of course. But I doubt it.

Well it should be easy enough to test. It would be quite a radical change in
thinking. All the raidtools documentation suggests starting with 32kb and
experimenting -- largely with smaller stripe sizes. I've certainly never
considered anything much larger. It would be really interesting to know how
even a typical database query ran on raid arrays of varying stripe sizes.

-- 
greg

