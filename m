Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284096AbRLANP1>; Sat, 1 Dec 2001 08:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284097AbRLANPR>; Sat, 1 Dec 2001 08:15:17 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:275 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S284096AbRLANPF>; Sat, 1 Dec 2001 08:15:05 -0500
Date: Sat, 1 Dec 2001 07:15:02 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Slight Return (was Re: [VM] 2.4.14/15-pre4 too "swap-happy"?)
Message-ID: <20011201071502.B2916@asooo.flowerfire.com>
In-Reply-To: <20011119173935.A10597@asooo.flowerfire.com> <20011119210941.C10597@asooo.flowerfire.com> <20011120043222.T1331@athlon.random> <20011119235422.F10597@asooo.flowerfire.com> <9tcuga$1gi$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <9tcuga$1gi$1@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Nov 20, 2001 at 06:50:50AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When updatedb kicked off on my 2.4.16 6-way Xeon 4GB box this morning, I
had an unfortunate flashback:

  5:02am  up 2 days, 1 min, 59 users,  load average: 5.66, 4.86, 3.60
741 processes: 723 sleeping, 4 running, 0 zombie, 14 stopped
CPU states:  0.2% user, 77.3% system,  0.0% nice, 22.3% idle
Mem:  3351664K av, 3346504K used,    5160K free,       0K shrd,  498048K buff
Swap: 1052248K av,  282608K used,  769640K free                 2531892K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME COMMAND
 2117 root      15   5   580  580   408 R N     0 99.9  0.0  17:19 updatedb
 2635 kb        12   0  1696 1556  1216 R       0 99.9  0.0   4:16 smbd
 2672 root      17  10  4212 4212   492 D N     0 94.7  0.1   1:39 rsync
 2609 root       2 -20  1284 1284   672 R <     0 81.2  0.0   4:02 top
    9 root       9   0     0    0     0 SW      0 80.7  0.0  42:50 kswapd
22879 kb         9   0 11548 6316  1684 S       0 11.8  0.1   7:33 smbd

Under varied load I'm not seeing the kswapd issue, but it looks like
updatedb combined with one or two samba transfers does still reproduce
the problem easily, and adding rsync or NFS transfers to the mix makes
kswapd peg at 99%.

I noticed because I was trying to do kernel patches and compiles using a
partition NFS-mounted from this machine.  I guess it sometimes pays to
be up at 5am...

Unfortunately it's difficult for me to reboot this machine to update the
kernel (59 users) but I will try to reproduce the problem on a separate
machine this weekend or early next week.  And I don't have profiling on,
so that will have to wait as well. :-(

Andrea, do you have a patch vs. 2.4.16 of your original solution to this
problem that I could test out?  I'd rather just change one thing at a
time rather than switching completely to an -aa kernel.

Grrrr!

Thanks much,
-- 
Ken.
brownfld@irridia.com


On Tue, Nov 20, 2001 at 06:50:50AM +0000, Linus Torvalds wrote:
| In article <20011119235422.F10597@asooo.flowerfire.com>,
| Ken Brownfield  <brownfld@irridia.com> wrote:
| >kswapd goes up to 5-10% CPU (vs 3-6) but it finishes without issue or
| >apparent interactivity problems.  I'm keeping it in while( 1 ), but it's
| >been predictable so far.
| >
| >3-10 is a lot better than 99, but is kswapd really going to eat that
| >much CPU in an essentially allocation-less state?
| 
| Well, it's obviously not allocation-less: updatedb will really hit on
| the dcache and icache (which are both in the NORMAL zone only, which is
| why Andrea asked for it), and obviously your Oracle load itself seems to
| be happily paging stuff around, which causes a lot of allocations for
| page-ins. 
| 
| It only _looks_ static, because once you find the proper "balance", the
| VM numbers themselves shouldn't change under a constant load.
| 
| We could make kswapd use less CPU time, of course, simply by making the
| actual working processes do more of the work to free memory.  The total
| work ends up being the same, though, and the advantage of kswapd is that
| it tends to make the freeing slightly more asynchronous, which helps
| throughput. 
| 
| The _disadvantage_ of kswapd is that if it goes crazy and uses up all
| CPU time, you get bad results ;)
| 
| But it doesn't sound crazy in your load.  I'd be happier if the VM took
| less CPU, of course, but for now we seem to be doing ok.
| 
| 		Linus
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
