Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137170AbRA1OMh>; Sun, 28 Jan 2001 09:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137171AbRA1OMS>; Sun, 28 Jan 2001 09:12:18 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:15611 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S137109AbRA1OMI>; Sun, 28 Jan 2001 09:12:08 -0500
Message-ID: <3A742A79.6AF39EEE@uow.edu.au>
Date: Mon, 29 Jan 2001 01:19:37 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: yodaiken@fsmlabs.com
CC: Nigel Gamble <nigel@nrg.org>, linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
In-Reply-To: <200101220150.UAA29623@renoir.op.net> <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>,
				<Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>; from Nigel Gamble on Sun, Jan 21, 2001 at 06:21:05PM -0800 <20010128061428.A21416@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yodaiken@fsmlabs.com wrote:
> 
> ...
> 
> I suggest that you get your hearing checked. I'm fully in favor of sensible
> low latency Linux. I believe however that low latency  in Linux will
>         A. be "soft realtime", close to deadline most of the time.
>         B. millisecond level on present hardware
>         C. Best implemented by careful algorithm design instead of
>         "stuff the kernel with resched points" and hope for the best.

Point C would be nice, but I don't believe it will happen because of

a) The sheer number of problem areas
b) The complexity of fixing them this way and
c) The low level of motivation to make Linux perform well in
   this area.

Main problem areas are the icache, dcache, pagecache, buffer cache,
slab manager, filemap and filesystems.  That's a lot of cantankerous
cats to herd.

In many cases it just doesn't make sense.  If we need to unmap 10,000
pages, well, we need to unmap 10,000 pages.  The only algorithmic
redesign we can do here is to free them in 500 page blobs.  That's
silly because we're unbatching work which can be usefully batched.
You're much better off unbatching the work *on demand* rather than
by prior decision.  And the best way of doing that is, yup, by
peeking at current->need_resched, or by preempting the kernel.

There has been surprisingly little discussion here about the
desirability of a preemptible kernel.

> 
> Nice marketing line, but it is not working code.
> 

Guys, please don't.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
