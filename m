Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279303AbRKXTJc>; Sat, 24 Nov 2001 14:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279418AbRKXTJV>; Sat, 24 Nov 2001 14:09:21 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:13072 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S279303AbRKXTJM>; Sat, 24 Nov 2001 14:09:12 -0500
Message-ID: <3BFFF021.D963B467@zip.com.au>
Date: Sat, 24 Nov 2001 11:08:17 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steve Bergman <steve@rueb.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Disk hardware caching, performance, and journalling
In-Reply-To: <3BFFE8A2.1010708@rueb.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Bergman wrote:
> 
> Note that block writes are over 3 times faster with caching on.

With a large linear write, linux typically feeds requests into the
disk like this:

	write 248 sectors
	write 248 sectors
	...
	write 248 sectors
	write 8 sectors
	write 248 sectors
	...

Now, 248+8 sectors is 128 kbytes.  A track is, say, 300 kbytes.

With writebehind the disk can write that entire track in pretty
much a single spin.  But if we're waiting on the result of each
request we'll lose revolutions.  In synchronous mode it's going
to take three or four spins to write a track.
 
> So what are the implications here for journalling?  Do I have to turn
> off caching and suffer a huge performance hit?

In theory, yes.  In my opinion, no.  For ext3, at least.  Caching
isn't bad per-se.  It's reordering which can break the journalling
constraints.  But given that the journal is, we hope, a strictly
ascending and (we really hope) contiguous chunk of blocks, it's
quite unlikely that the disk will decide to write them in an
unexpected order.  This is especially true if the journal was
created when the disk was relatively unfragmented.

And if the disk _does_ write them in the wrong order, it has
to be specifically the journal commit block which was written
prior to some data blocks.  And you need to lose power (not
just crash) prior to the data blocks hitting disk.  It's a
very small time window containing an improbable occurrence.

Now that's all just vigorous handwaving, and may be wrong,
and yes, we really need a way of propagating barriers down
to the request queue.  But I've not seen a whisker of a report
which indicates that write reordering has caused on-recovery
corruption.

-
