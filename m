Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154174-13019>; Wed, 25 Nov 1998 00:13:10 -0500
Received: from beowulf.ucsd.edu ([132.239.17.2]:53740 "EHLO beowulf.ucsd.edu" ident: "IDENT-NONSENSE") by vger.rutgers.edu with ESMTP id <154745-17796>; Tue, 24 Nov 1998 19:34:39 -0500
Date: Tue, 24 Nov 1998 18:01:51 -0800 (PST)
From: Stephane Belmon <sbelmon@cs.ucsd.edu>
Reply-To: Stephane Belmon <sbelmon@cs.ucsd.edu>
To: linux-kernel@vger.rutgers.edu
cc: Colin Plumb <colin@nyx.net>
Subject: Re: Timeout overflow in select()
In-Reply-To: <199811230134.SAA24922@nyx10.nyx.net>
Message-ID: <Pine.SOL.3.96.981124101906.21069A-100000@beowulf.ucsd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Sun, 22 Nov 1998, Colin Plumb wrote:

> > Implementations may place limitations on the maximum timeout interval
> > supported. On all implementations, the maximum timeout interval
> > supported will be at least 31 days.
[...]
> Note that this can impose an upper limit on HZ.
> In particular, 2^32 jiffies is 31 days at 1603.5 Hz.
> If you need an extra bit, 2^31 jiffies is 31 days at 801.8 Hz.
> 
> Thus, a 31-bit jiffies limit is not compatible with HZ=1024.

My first reaction was to say that all this was hypothetical (looking at
i386 only). But it's not, because of the Alpha. If we want to be
conformant, and have a large HZ, and still have a 32 bit time_t, we have
to loop around the do_select() as I suggested in my original email. I
guess it can be exercised by crippling the timeout allowed to go to
"current->timeout", to (say) a few minutes. 

Poll: what do you think? Do we want that loop? Or do we just say that a
couple days for the maximum timeout when you have a big HZ is good enough?
(and the hell with those standards).

Poll: Has anyone ever seen (heard of) code which would use huge timeouts
in select() and would require accuracy on them? (ie, wouldn't like at all
to be woken up before it's due) Does anyone know what other Unices do?

"He who has not sinned ...": my fix didn't include any checking on
tv_usec. While it takes care of the overflow (well, mostly) that started
this thread, it doesn't close the select() argument checks issue. I should
add something, so that we're 100% sure that the computed timeout is valid.
BTW, we probably should be tolerant with negative tv_usec values (the
current select() very much is). There could be some code out there that
does "0.999 seconds" as (1 sec, -1000 microseconds). Or stuff like that,
you get the idea. So a little bit of double guessing is to be expected. 

(Colin: sorry for the mess, and thanks)
--
Stephane Belmon <sbelmon@cse.ucsd.edu>
University of California, San Diego
Computer Science and Engineering Department






-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
