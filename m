Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280771AbRKSXkB>; Mon, 19 Nov 2001 18:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280766AbRKSXjv>; Mon, 19 Nov 2001 18:39:51 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:4115 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S280771AbRKSXji>; Mon, 19 Nov 2001 18:39:38 -0500
Date: Mon, 19 Nov 2001 17:39:35 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [VM] 2.4.14/15-pre4 too "swap-happy"?
Message-ID: <20011119173935.A10597@asooo.flowerfire.com>
In-Reply-To: <200111191801.fAJI1l922388@neosilicon.transmeta.com> <Pine.LNX.4.33.0111191003470.8205-100000@penguin.transmeta.com> <20011119123125.B1439@asooo.flowerfire.com> <9tbm7f$86o$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <9tbm7f$86o$1@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Nov 19, 2001 at 07:23:27PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I went straight to the aa patch, and it looks like it either fixes the
problem or (because of the side-effects Linus mentioned) otherwise
prevents the issue:

  2:30pm  up 11 min,  4 users,  load average: 2.23, 2.18, 1.17
106 processes: 104 sleeping, 2 running, 0 zombie, 0 stopped
CPU states: 14.7% user, 10.3% system,  0.0% nice, 74.9% idle
Mem:  3342304K av, 3013888K used,  328416K free,       0K shrd,    1224K buff
Swap: 1004052K av,  276824K used,  727228K free                 2862112K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME COMMAND
  722 oracle    12   0 13364  12M 11856 S    9.9M 29.5  0.3   2:24 oracle
  731 oracle    17   0 13488  12M 11980 D     10M 28.7  0.3   2:27 oracle
  728 oracle    12   0 13048  12M 11540 R    9816 20.8  0.3   2:22 oracle
  718 oracle    12   0  154M 153M  152M S    150M 17.9  4.7   2:22 oracle
  725 oracle    14   0 13472  12M 11964 S     10M 17.9  0.3   2:20 oracle
  734 oracle    12   0 13936  13M 12432 S     10M 15.3  0.4   2:27 oracle
    9 root       9   0     0    0     0 SW      0  4.3  0.0   0:27 kswapd

The machine went into swap immediately when the page cache stopped
growing and hovered at 100-400MB.  Also, in my experience the page cache
will grow until there's only 5ishMB of free RAM, but with the aa patch
it looks like it stops at 320MB or maybe 10% of RAM.  Was that the aa
patch, or part of -pre6?

It would be nice if that number were modifyable via /proc (writable
freepages again? 10% seems a tad high for many boxes) but I think it's
better to have a bit more purely free RAM available than 5MB.

kswapd isn't going nuts, but it seems to still be eating quite a bit of
CPU given plenty of RAM.  And it seems to go pretty hard into swap -- I
would imagine that it's disadvantageous to do significant swapping
(based on age only?) in the presence of a massive page cache.  I would
imagine the performance hit of a 2GB vs. 3GB page cache would be less
egregious than the time and I/O kswapd is causing without memory
pressure.

The Oracle SGA is set to ~522MB, with nothing else running except a
couple of sshds, getty, etc.  Now that I'm looking, 2.8GB page cache
plus 328MB free adds up to about 3.1GB of RAM -- where does the 512MB
shared memory segment fit?  Is it being swapped out in deference to page
cache?

Just my USD$0.02.  I'll try vanilla -pre6 with profiling soon and post
results.  Thanks for the tip Marcelo.

Thanks,
-- 
Ken.
brownfld@irridia.com


On Mon, Nov 19, 2001 at 07:23:27PM +0000, Linus Torvalds wrote:
| In article <20011119123125.B1439@asooo.flowerfire.com>,
| Ken Brownfield  <brownfld@irridia.com> wrote:
| >Linus, so far 2.4.15-pre4 with your patch does not reproduce the kswapd
| >issue with Oracle, but I do need to perform more deterministic tests
| >before I can fully sign off on that.
| >
| >BTW, didn't your patch go into -pre5?  Or is there an additional mod in
| >-pre6 that we should try?
| 
| You're right, it's probably in pre5 already..
| 
| Anyway, it would be interesting to see if the patch by Andrea (I think
| he called it "zone-watermarks") that changes the zone allocators to take
| other zones into account makes a difference. See separate thread with
| the subject line "15pre6aa1 (fixes google VM problem)". 
| 
| (I think the patch is overly complex as-is, but I htink the _ideas_ in
| it are fine).
| 
| 			Linus
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
