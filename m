Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135178AbRDRNnt>; Wed, 18 Apr 2001 09:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135179AbRDRNnj>; Wed, 18 Apr 2001 09:43:39 -0400
Received: from smtp1.sentex.ca ([199.212.134.4]:18956 "EHLO smtp1.sentex.ca")
	by vger.kernel.org with ESMTP id <S135178AbRDRNnW>;
	Wed, 18 Apr 2001 09:43:22 -0400
Message-ID: <3ADD99E8.FB7F8542@coplanar.net>
Date: Wed, 18 Apr 2001 09:43:04 -0400
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Bjorn Wesen <bjorn@sparta.lu.se>
CC: Laurent Chavet <lchavet@av.com>, linux-kernel@vger.kernel.org
Subject: Re: Is there a way to turn file caching off ?
In-Reply-To: <Pine.LNX.3.96.1010418134153.20558A-100000@medusa.sparta.lu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Wesen wrote:

> A similar phenomenon happens when you simply copy a file - file A is read
> into the cache and file B is written to the cache, until the memory runs
> out. Then both start to flush at the same time, creating a horrible

in this example only file B needs uses IO when being flushed; A's
buffers aren't dirty, so they're just 'forgotten'

>
> performance hit (especially if A and B are on the same disk :)
>

bdflush and 2.4's equivalent are tunable; if all you do is this copying
then optimise these parameters for this task.

>
> I don't know a way to fix this except having the kernel correctly identify
> the access pattern and optimize for it (i.e. if it recognizes that cache

currently all the kernel's heuristics are feed-back control loops.
what you are asking for is a feed-forward system: a way for the application
to tell kernel "I'm only reading this once, so after I'm done, throw it out
straight away"
and "I'm only writing this data, so after I'm done, start writing it out and
then forget it"

perhaps you could try mounting the destinatinon 'sync'
with dd at least you could specify block size,
there is also raw devices (no cache) mmaped files with madvise,
fdatasync()... lots of ways.

>
> pages are flushed in order to make room for more pages from the same
> inode, then it's probably a suboptimal caching pattern and instead it
> should probably increase the readahead and flush bigger chunks of pages at
> the same time). I don't think anything can be done to the writing queue
> (except maybe make the kernel understand that seek-time is more expensive
> than transfer-time, so it does not schedule the read/writeing each odd

there is the elevator seek mechanism...

>
> page..)
>
> I'm still using 2.4.0 though so maybe this behaviour has been fixed to the
> better in later kernels..
>
> As a sidenote, try the same thing on an WinNT box and watch it die :) Like
> unpacking a 1 GB file on a machine with 128 MB ram.. after it has unpacked
> the first 100 MB's or so, performance drops to 1% or something..

Isn't this due to the journaling filesystem?  All that seeking sure slows
things down...

>
>
> -BW
>
> On Tue, 17 Apr 2001, Laurent Chavet wrote:
> >     First cache grows to the size of RAM (2GB) with transfer rate
> > slowing down as the cache grows.
> >     Then the transfer rates drops a lot (2 to 3 time slower than the
> > drive capacity) and there is a very high CPU usage of system time (more
> > than a CPU) used by bdflush and kswapd (and some others like kupdated).
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

