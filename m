Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278962AbRJ2Cpm>; Sun, 28 Oct 2001 21:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278961AbRJ2CpX>; Sun, 28 Oct 2001 21:45:23 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:30536 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S278960AbRJ2CpS>; Sun, 28 Oct 2001 21:45:18 -0500
Date: Mon, 29 Oct 2001 03:45:46 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: VM test on 2.4.14pre3aa2 (compared to 2.4.14pre3aa1)
Message-ID: <20011029034546.L1396@athlon.random>
In-Reply-To: <20011028120721.A286@earthlink.net> <20011029014715.J1396@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011029014715.J1396@athlon.random>; from andrea@suse.de on Mon, Oct 29, 2001 at 01:47:15AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 01:47:15AM +0100, Andrea Arcangeli wrote:
> I'm looking into optimizing this test. While it probably doesn't affect

Ok here it is some feedback from my part on this swap bandwith bench.

hardware: 4G of ram and 2G of swap, 4-way (provided by osdlab.org, thanks!)

2.4.14pre3aa3 (not yet released, should fix oom faliure with mmap001,
though didn't tested it yet)

started 3 swap-bench-pause that puts the machine into this state (4G allocated
and 450M swapped out, all tasks stopped).

 0  0  0 450012   4100    136   3512   0   0     0     0  113    30   0   0 100
 0  0  0 450012   4084    136   3512   0   0     0     0  117    70   0   0 100

now started a copy of 'mtest01 -b $[1024*1024*512] -w' that swapouts additional
512mbytes.

PASS ... 536870912 bytes allocated.

real    1m9.254s
user    0m9.240s
sys     0m2.410s

Repeat again the same (so kill the previous swap-bench-pause, start them
again and wait to return into the 450M swapped out and all ram in
anonoymous memory, and then finally run the mtest01 again). Ok ready again
to startup the benchmark (with my previous patch applied, thought it
doesn't matter as I have to use -b because on a 4G+2G machine the -p logic
overflows :)

 0  0  0 450564   4724    160   3324   0   0     0     0  104     6   0   0 100
 0  0  0 450564   4720    160   3324   0   0     0     0  103     6   0   0 100

andrea@dev4-000:~> time ./mtest01 -b $[1024*1024*512] -w     
PASS ... 536870912 bytes allocated.

real    1m8.655s
user    0m9.370s
sys     0m2.250s
andrea@dev4-000:~> 

last lines of vmstat 1 while the benchmark finishes.

 0  1  1 932696   2720    156   3324   0 7424     4  7428  187   115   4   6  89
 0  1  1 941784   2816    156   3324   0 8732     0  8732  187   132   4   3  93
 0  1  1 949464   4840    156   3324   0 7648     0  7648  188   120   3   2  95
 0  1  1 956888   3584    156   3324   0 7612     0  7612  185   114   5   1  94
 0  1  1 964824   2816    156   3324   0 7776    16  7776  191   134   4   1  95
 0  1  0 972120   4736    156   3324   0 7512     0  7512  188   120   3   1  95
 0  0  0 975828 529852    160   3344   0 3728    28  3728  154    81   3   4  93
 0  0  0 975828 529852    160   3344   0   0     0     0  103     6   0   0 100

All run smoothly (not handy to play mp3 remotely [or better, not handy to check
they don't skip :], but vmstat beats are also an interactive feedback and they
were fine, no one skept).

So in short 1m and 9 seconds to swapout exactly 512m, with 4.5G worth of address
space mapped in memory. System time used is 2 seconds and user time is 9 seconds.

Now try again with vanilla 2.4.14pre3 with no a single patch applied:

started the three swap-bench-pause to swapout the 500mbytes and to keep the 4G of
ram in anon memory, very bad vmstat responsiveness, 2.4.14pre3aa3 never skept
a beat, here it hangs all the time for several seconds.

 3  0  0      0 682632   1844  15732   0   0     0   128  129    11   1  74  25
 3  0  0      0 356876   1844  15732   0   0     0     0  103     5   1  74  25
 3  0  0      0  30992   1844  15732   0   0     0     0  103     5   1  75  25
 3  0  1 183852   2920    132   7260   0 10328     0 10832  576  1924   0  53  47
 5  0  1 247024   3656    132   7272   0 85056     0 85016 2549  4044   0   4  96
 2  1  0 248668   2752    140   7260   0 8348     8  8360  280   328   0  14  86
 3  0  0 309060   2388    132   7268   0 72872     0 72848 2194  3532   0   6  94
 4  0  1 380220   3284    132   7264   0 68736     4 68740 2089  3842   0   7  93
 0  2  1 383428   2436    136   7260   0 14780     4 14780  448   473   0   7  93
 3  0  0 448324   2176    132   7264   0 59576     0 59576 1777  2819   0   6  94
 2  0  1 459588   4332    136   7256   0 2920     4  2920  243   417   0  30  70
 0  2  0 461124   2568    136   7244   0 5952     0  5952  189   197   0  11  89
 2  0  0 527044   2248    132   7244   0 70004     0 70004 2100  2796   0   5  95
 3  0  0 595140   2176    140   7244   0 72024     8 72028 2220  3682   0   7  93
 2  0  1 597828   3480    136   7252   0 10964     4 10964  292   283   0   1  99
 0  0  0 597948   3476    136   7244   0   0     0     0  104    89   0   7  93
 0  0  0 597948   3476    136   7244   0   0     0     0  103     6   0   0 100
 0  0  0 597948   3476    136   7244   0   0     0     0  103     6   0   0 100
 0  0  0 597948   3472    136   7244   0   0     0     0  103     8   0   0 100

now with 512G in swap and 4G in anon memory we're ready to start the real benchmark:

andrea@dev4-000:~> time ./mtest01 -b $[1024*1024*512] -w
PASS ... 536870912 bytes allocated.

real    1m44.269s
user    0m9.050s
sys     0m6.420s
andrea@dev4-000:~> 

here the last vmstat lines during the bench:

 0  1  1 1051388   4064    136   7092   0 8132     0  8132  191   161   1   1  98
 1  0  0 1063548   2240    136   7092   0 3636     0  3636  144   285  12   5  83
 0  4  1 1100796   2592    136   7092   0 63572     0 63564 1795  2068   1   3  96
 0  1  1 1102972   3600    136   7092   0 8220     0  8220  186   162   5   3  92
 0  1  1 1105404   4112    136   7092   0 7760     0  7760  186   154   5   3  92
 0  1  1 1107964   3460    136   7092   0 8056     0  8056  186   156   6   2  93
 0  2  1 1133180   2564    136   7092   0 48904     0 48900 1284  1543   0   1  99
 0  0  0 1091836 529988    140   7096   0 2072     8  2072  145   147   4   7  89
 0  0  0 1091836 529980    140   7096   0   0     0     0  107     8   0   0 100
 0  0  0 1091836 529980    140   7096   0   0     0     0  103     6   0   0 100
 0  0  0 1091836 529980    140   7096   0   0     0     0  103     6   0   0 100

vmstat skips beat during the bench too.

Repeat again the whole thing. basically same results and same vmstat skips during
swapout activity:

andrea@dev4-000:~> time ./mtest01 -b $[1024*1024*512] -w
PASS ... 536870912 bytes allocated.

real    1m39.406s
user    0m8.920s
sys     0m7.070s
andrea@dev4-000:~> 

So 2.4.14pre3aa3 takes 1m and 9s to swapout 512mbytes, while 2.4.14pre3
vanilla takes 1m and 40s, plus my tree doesn't skip a single beat during
the preparation of the benchmark and during the benchmark itself, while
mainline is hanging all the time for serveral seconds.  The system time
of vanilla 2.4.14pre3 is also 3 times bigger than in 2.4.14pre3aa3. So
I've no doubt my current tree is swapping out much faster than
2.4.14pre3 vanilla, at least on the large mem boxes (as said such
machine has 4G), and as far I can tell the offender for mainline is the
design to put anon pages in the lru that generates waste of cpu due
complexity problems.

Not sure why you got slower results with pre3aa1/pre3aa2 than with pre3
mainline, OTOH I also did some very interesting change in this aa3,
maybe aa2 and aa1 where slower because of other reasons (didn't
benchmarked them the above way).

And if pre3aa3 swapouts +44% faster than pre3 vanilla on a 4G box, I
expect it to swapout at least 80% faster on the 16G box by doing the
same test (with 16G in anon memory and 512m swapped out, then starting
the same bench, didn't tested it though).

Andrea
