Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318045AbSIESVN>; Thu, 5 Sep 2002 14:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318047AbSIESVN>; Thu, 5 Sep 2002 14:21:13 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20752 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318045AbSIESVM>; Thu, 5 Sep 2002 14:21:12 -0400
Date: Thu, 5 Sep 2002 11:28:28 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Suparna Bhattacharya <suparna@in.ibm.com>, Jens Axboe <axboe@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: One more bio for for floppy users in 2.5.33..
In-Reply-To: <3D779BAA.BAA5A742@zip.com.au>
Message-ID: <Pine.LNX.4.33.0209051120100.1307-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Sep 2002, Andrew Morton wrote:
> 
> OK.  But still, I don't see why we need partial BIO completions.  If
> we say that the basic unit of completion is a whole BIO, then readahead
> can then manage latency via the outgoing bio size.

But that's horrible. The floppy driver can take huge bio's no problem, and 
limiting bio sizes to track sizes would be a huge pain in the driver for 
no good reason. In fact, it would be pretty much impossible, since the 
tracks aren't even page-aligned.

So limiting bio's fundamentally _cannot_ do the right thing. While adding
two lines of code _can_.

> Well I'd be interested in knowing specifically what is wrong with the
> behaviour of 2.5.33 against a floppy disk.

Try it (not plain 2.5.33, but current BK where floppy actually works). It
works, but reading a single sector will pause until it has read several 
tracks. Even though the sector came back much earlier.

Also, you missed the error case argument. Right now we _cannot_ handle 
error cases for partial transfers AT ALL. The bio interface simply does 
not support it.  And there is no way you can fix that with the current 
interface. While the partial completion case allows for at least partial 
recovery.

Andrew, give it up. The current interface _sucks_.

> In the testing I did a few weeks back, everything checked out.  An
> application which was reading the raw device at 95% of media bandwidth
> never blocked.  An application which was capable of processing data at
> 120% of media bandwidth achieved 100%.

And an application that only wanted one sector? To notice that the 
filesystem is of the wrong type, for example? 

Throughput is _secondary_ to many latency concerns. And you cannot fix the 
latency with full bio's (see the track issue).

			Linus

