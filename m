Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266867AbRHALwk>; Wed, 1 Aug 2001 07:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266870AbRHALwa>; Wed, 1 Aug 2001 07:52:30 -0400
Received: from picard.csihq.com ([204.17.222.1]:24493 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S266867AbRHALwR>;
	Wed, 1 Aug 2001 07:52:17 -0400
Message-ID: <020001c11a80$43297110$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: <tridge@valinux.com>, <marcelo@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>, <riel@conectiva.com.br>,
        "Andrew Morton" <andrewm@uow.edu.au>
In-Reply-To: <Pine.LNX.4.21.0108010504160.9379-100000@freak.distro.conectiva> <20010801105419.8F078424A@lists.samba.org>
Subject: Re: 2.4.8preX VM problems
Date: Wed, 1 Aug 2001 07:51:09 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This sounds a lot like the problem I've been having with ext3 and raid.
A one-thread tiobench performs just great.
A two-thread tiobench starts having lots of kswapd action when free memory
gets down to ~5Meg.  ext3 exacerbates the problem.
kswapd kicks up it's heals and starts grinding away (and NEVER swaps
anything out).

I've been working this with Andrew Morton (the ext3 guy).

I have come to the opinion that kswapd needs to be a little smarter -- if it
doesn't find anything to swap shouldn't it go to sleep a little longer
before trying again?  That way it could gracefully degrade itself when it's
not making any progress.

In my testing (on a dual 1Ghz/2G machine) the machine "locks up" for long
periods of time while kswapd runs around trying to do it's thing.
If I could disable kswapd I would just to test this.
I tried to figure out how to lengthen the sleep time of kswapd but didn't
have time to chase it down (it wasn't intuitively obvious :-)

________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355
----- Original Message -----
From: "Andrew Tridgell" <tridge@valinux.com>
To: <marcelo@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>; <riel@conectiva.com.br>
Sent: Wednesday, August 01, 2001 6:54 AM
Subject: Re: 2.4.8preX VM problems


Marcelo,

> The following patch sets the zone free target to freepages.high. Can you
> test it ? (I tried here and got the expected results)

Running just that patch against 2.4.8pre3 gives:

[root@fraud /root]# ~/readfiles /dev/ddisk
198 MB    198.084 MB/sec
386 MB    188.634 MB/sec
570 MB    183.827 MB/sec
743 MB    172.5 MB/sec
810 MB    67.0501 MB/sec
862 MB    52.1381 MB/sec
901 MB    37.9501 MB/sec
957 MB    55.8253 MB/sec
998 MB    41.1541 MB/sec
1046 MB    48.1661 MB/sec
1088 MB    40.3898 MB/sec
1140 MB    50.8782 MB/sec
1183 MB    42.5749 MB/sec
1229 MB    46.1378 MB/sec
1275 MB    44.8515 MB/sec
1319 MB    43.5389 MB/sec
1368 MB    47.5747 MB/sec
1411 MB    42.8134 MB/sec


which is much better, but is pretty poor performance for a null
device.

Running with that latest patch plus the patch you sent previously
gives roughly the same result. Also, kswapd chews lots of cpu during
these runs:

CPU0 states:  0.0% user, 79.0% system,  0.0% nice, 20.4% idle
CPU1 states:  0.2% user, 77.1% system,  0.0% nice, 22.1% idle
Mem:  2059088K av,  892256K used, 1166832K free,       0K shrd,  784972K
buff
Swap: 1052216K av,       0K used, 1052216K free                   10072K
cached

  PID USER     PRI  NI  SIZE  RSS SHARE LC STAT %CPU %MEM   TIME COMMAND
  608 root      19   0   452  452   328  1 R    95.2  0.0   1:23 readfiles
    5 root      14   0     0    0     0  1 SW   58.3  0.0   0:52 kswapd
    6 root       9   0     0    0     0  1 RW    2.1  0.0   0:01 kreclaimd

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

