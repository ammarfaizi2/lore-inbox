Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318020AbSIESj5>; Thu, 5 Sep 2002 14:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318026AbSIESj5>; Thu, 5 Sep 2002 14:39:57 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:14600 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S318020AbSIESj4>; Thu, 5 Sep 2002 14:39:56 -0400
Message-ID: <3D77A58F.B35779A1@zip.com.au>
Date: Thu, 05 Sep 2002 11:42:23 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Suparna Bhattacharya <suparna@in.ibm.com>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: One more bio for for floppy users in 2.5.33..
References: <3D779BAA.BAA5A742@zip.com.au> <Pine.LNX.4.33.0209051120100.1307-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 5 Sep 2002, Andrew Morton wrote:
> >
> > OK.  But still, I don't see why we need partial BIO completions.  If
> > we say that the basic unit of completion is a whole BIO, then readahead
> > can then manage latency via the outgoing bio size.
> 
> But that's horrible. The floppy driver can take huge bio's no problem, and
> limiting bio sizes to track sizes would be a huge pain in the driver for
> no good reason. In fact, it would be pretty much impossible, since the
> tracks aren't even page-aligned.

erp.  Yes, a BIO can span several tracks.  I see the point.

> ...
> > In the testing I did a few weeks back, everything checked out.  An
> > application which was reading the raw device at 95% of media bandwidth
> > never blocked.  An application which was capable of processing data at
> > 120% of media bandwidth achieved 100%.
> 
> And an application that only wanted one sector? To notice that the
> filesystem is of the wrong type, for example?

OK.  That's the initial-64k thing.  If you read 512 bytes from /dev/fd0,
readahead will go and issue a 64k request, and your 512-byte request takes
ages.

> Throughput is _secondary_ to many latency concerns. And you cannot fix the
> latency with full bio's (see the track issue).

The `nr_of_sectors_completed' would be tricky to handle - we don't know how
to bring the pagecache pages uptodate in response to a 512-byte completion.
We'd have to teach the pagecache read functions to permit userspace to read
from non-uptodate pages by looking at the buffer_head state.  And then
look at buffer_req to distinguish "this part of the page hasn't been read yet"
from "this part of the page had an IO error".  Ick.

It would be simpler if it was nr_of_pages_completed.
