Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129400AbRA0KdG>; Sat, 27 Jan 2001 05:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129444AbRA0Kc4>; Sat, 27 Jan 2001 05:32:56 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:53470 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129400AbRA0Kcn>; Sat, 27 Jan 2001 05:32:43 -0500
Message-ID: <3A72A578.28D27AED@uow.edu.au>
Date: Sat, 27 Jan 2001 21:39:52 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Ion Badulescu <ionut@moisil.cs.columbia.edu>
CC: lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <3A726087.764CC02E@uow.edu.au> <200101271005.f0RA5DX04357@moisil.dev.hydraweb.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu wrote:
> 
> 2.4.1-pre10+zerocopy, using read()/write():     18.3%-29.6% CPU         * why so much variance?

The variance is presumably because of the naive read/write
implementation.  It sucks in 16 megs and writes out out again.
With a 100 megabyte file you'll get aliasing effects between
the sampling interval and the client's activity.

You will get more repeatable results using smaller files.  I'm
just sending /usr/local/bin/* ten times, with

./zcc -s otherhost -c /usr/local/bin/* -n10 -N2 -S

Maybe that 16 meg buffer should be shorter...  Yes, making it
smaller smooths things out.

Heh, look at this.  It's a simple read-some, send-some loop.
Plot CPU utilisation against the transfer size:

Size           %CPU


256             31
512             25
1024            22
2048            18
4096            17
8192            16
16384           18
32768           19
65536           21
128k            22
256k            22.5

8192 bytes is best.

I've added the `-b' option to zcc to set the transfer size.  Same
URL.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
