Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131151AbRAUBRt>; Sat, 20 Jan 2001 20:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131590AbRAUBRj>; Sat, 20 Jan 2001 20:17:39 -0500
Received: from mtiwmhc25.worldnet.att.net ([204.127.131.50]:16809 "EHLO
	mtiwmhc25.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S131151AbRAUBRa>; Sat, 20 Jan 2001 20:17:30 -0500
Message-ID: <3A6A39D0.E6E76CD3@att.net>
Date: Sat, 20 Jan 2001 20:22:24 -0500
From: Michael Lindner <mikel@att.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Dan Maas <dmaas@dcine.com>, Edgar Toernig <froese@gmx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: select() on TCP socket sleeps for 1 tick even if data  
 available
In-Reply-To: <fa.nc2eokv.1dj8r80@ifi.uio.no> <fa.dcei62v.1s5scos@ifi.uio.no> <015e01c082ac$4bf9c5e0$0701a8c0@morph> <3A69361F.EBBE76AA@att.net> <20010120200727.A1069@metastasis.f00f.org> <3A694254.B52AE20B@att.net> <3A6A09F2.8E5150E@gmx.de> <022f01c08342$088f67b0$0701a8c0@morph> <20010121133433.A1112@metastasis.f00f.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> 
> On Sat, Jan 20, 2001 at 07:35:12PM -0500, Dan Maas wrote:
> 
>     Bingo! With this fix, 2.2.18 performance becomes almost identical to 2.4.0
>     performance. I assume 2.4.0 disables Nagle by default on local
>     connections...
> 
> 2.4.x has a smarter nagle algorithm.

Thanks again for all the help, guys...

Haven't installed 2.4 yet, but I tried the setsockoption route.
Performance is better, but the two processes together never total more
than 50% of the CPU (i.e. the thing is still schedule-bound, not compute
bound, as it is on other platforms), and throughput is only up to 800
sends/sec. Better than the 100/sec. I was getting, but still a far cry
from the identical box running Windows, where performance is 8K/sec.

...and I still don't understand why the identical program, but using one
socket instead of 2 sockets, IS CPU bound, and gets on the order of
10K/sec. on the same HW. Diffs to produce 10K/sec. 1 socket version from
my previous sample follow...

--
Mike Lindner

diff sockperf.c sockperf1.c
163c163
<                               if (pings++ < 1000) {
---
>                               if (pings++ < 10000) {
177c177
<       fprintf(stderr, "elapsed time for 1000 pingpongs is %g\n",
now.tv_sec - then.tv_sec + (now.tv_usec - then.tv_usec) / 1000000.0);
---
>       fprintf(stderr, "elapsed time for 10000 pingpongs is %g\n", now.tv_sec - then.tv_sec + (now.tv_usec - then.tv_usec) / 1000000.0);
205c205
<                       int     s = connectsock(argv[1], argv[3],
"tcp");
---
>                       int     s = r;
214c214
<                       int     r = accept(f, (struct sockaddr *) &fsin,
&alen);
---
>                       int     r = s;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
