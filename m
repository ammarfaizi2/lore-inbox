Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131377AbQKAWHv>; Wed, 1 Nov 2000 17:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131444AbQKAWHl>; Wed, 1 Nov 2000 17:07:41 -0500
Received: from 041imtd118.chartermi.net ([24.247.41.118]:62458 "EHLO
	oof.netnation.com") by vger.kernel.org with ESMTP
	id <S131377AbQKAWHh>; Wed, 1 Nov 2000 17:07:37 -0500
Date: Wed, 1 Nov 2000 17:07:35 -0500
From: Simon Kirby <sim@stormix.com>
To: linux-kernel@vger.kernel.org
Subject: 2.2.17 toasting cache?
Message-ID: <20001101170735.A25627@stormix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm... This seems to be happening every 20 minutes or so on a mail server
here.  This box handles about 25-35 POP3 logins per second and has 1 GB
of RAM (compiled with the kernel at 1GB currently, oops). I have
2.2.18pre15+VM_global on there ready to go, but we haven't rebooted it to
that yet.

The box runs cucipop and exim and has some staff logins etc., but it
doesn't look like any processes are eating up the memory and dumping it
for a number of different reasons.

This will probably word wrap for lots of people...sorry.  "vmstat 1":

   procs                      memory    swap          io     system         cpu      
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id      
26 13  1   1260   5216 125304 695560   0   0   183    51  829  1473  62  38   0
18 27  1   1260   2172 125304 696940   0   0   313    56  910  1545  77  22   0
23 36  1   1260   2312 124692 693468   0   0   411    76  970  2362  76  24   0  
27 53  2   1260 654044  34656 132704   0   0  1773  1652 3881 15430  43  31  26  
(no reponse for at least 30 seconds here)
 8 43 20  39528 857256  19660  17056 388 38332   985 10906 5160 32640   1  65  34
 0 51 17  39704 856308  19688  18408 560 352   408    88  586   818   4   7  89  
 0 47 16  39564 854304  19748  21128 420   0   753     0  898  5054   6   9  85
 0 45 16  39144 851136  19808  24640 376   0   914     0 1158 12984   7  10  84

As you can see, it decided to throw out around 700 MB of cache.  I've
been watching top and "vmstat 1" for a while now trying to find out what
does it, but no process ever seems to be eating up memory or anything
when it happens -- it seems to just free all the memory and then the box
just goes very slowly as the RAID array is saturated while it reads back
in all of the mailboxes as people login (417 blocked cucipop processes at
one point... ouch :)).

It doesn't look like anything is slowly eating up the memory (and cache)
and then exiting, because if it were, there would be many more blocked
cucipop processes trying to read back in the mail.  It also doesn't look
like something is quickly eating it up and exiting in a single second,
because I can't even do that if I try with an optimized malloc()-and-dirty
program.

It also looks weird that it kicks out some stuff to swap _after_ all of
the memory becomes free.

This is a dual PIII 700 MHz box, the 2.2.17 kernel has no funky patches
other than one to raise the maximum number of simultaneous
processes/threads (as you can probably guess).  Hmm...it'd be interesting
to try 2.4 on there. ;)

Any ideas?

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
