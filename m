Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136751AbRAHF0J>; Mon, 8 Jan 2001 00:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136926AbRAHF0G>; Mon, 8 Jan 2001 00:26:06 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:520 "EHLO
	mf1.private") by vger.kernel.org with ESMTP id <S136917AbRAHFZs>;
	Mon, 8 Jan 2001 00:25:48 -0500
Date: Sun, 7 Jan 2001 21:29:29 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: <linux-kernel@vger.kernel.org>
cc: "William A. Stein" <was@math.harvard.edu>
Subject: Re: Subtle MM bug
Message-ID: <Pine.LNX.4.30.0101072014300.17414-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sunday, January 7, 20001, Rik van Riel <riel@conectiva.com.br> wrote:

> Now if 2.4 has worse _performance_ than 2.2 due to one reason or
> another, that I'd like to hear about ;)

Well, here is a workload that performs worse on 2.4.0 than on 2.2.19pre,
and as it is the usual workload on my little cluster of 3 machines, they
are all running 2.2.19pre:

The application is some mathematics computations (modular symbols) using a
package called MAGMA;  at times this requires very large matrices.  The
RSS can get up to 870MB; for some reason a MAGMA process under linux
thinks it has run out of memory at 870MB, regardless of the actual
memory/swap in the machine.  MAGMA is single-threaded.

The typical machine is a dual Intel box with 512MB RAM and 512MB swap.
There is no problem with just one MAGMA process, it just hits that 870MB
barrier and gracefully exits.  But if I do the following test, I notice
very different behaviour under 2.2 and 2.4:  while running 'top d 1' I
simultaneously launch two instances of a job which actually requires more
than 870MB of memory to complete.  So each instance will slowly grow in
RSS until it gets killed by OOM or hits that 870MB limit.

Under 2.2, everything proceeds smoothly: before physical RAM is exhausted,
top updates every second, and the jobs have all the CPU.  When swapping
kicks in, top updates every 1-2 seconds and lists most of the CPU as
'system' (kswapd), but I perceive not much loss of interactivity.
Eventually the 1GB of virtual memory is exhausted, the OOM killer kills
one of the MAGMA's, and the other runs till it hits the 870MB barrier and
exits.

But under 2.4, interactivity suffers as soon as physical RAM is exhausted.
Top only updates every 2-10 seconds, the load average hits 3-4, and top
reports the CPUs are 90% idle.  Eventually, the OOM killer kicks in and
all returns to normal.  For practical purposes, the machine is unusual
while swapping like this.

I have heard 'vmstat' mentioned here, so below is the output of a 'vmstat
1' concommitant with the test above (top and the two MAGMA jobs).  I would
be more than happy to provide any other relevant information about this.

I read the LKML via an archive that updates once a day, so please cc: me
if you would like a speedier response.  I wish I knew of a newsgroup
interface to the LKML, then I could read it more often :-).

Cheers,
Wayne


   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0  49180 447840    840  54104 269 969    84   244   76   236  10   4  86
 1  0  0  49180 443276    852  55972   0   0   470     0  163   150  15   2  83
 2  0  0  49180 440060    852  56292   0   0    80     0  115    60  93   1   6
 2  0  0  49180 438236    856  56292   0   0     1     0  107    53  99   1   0
 2  0  0  49180 429468    856  56392   0   0    25     0  109    16  99   0   0
 2  0  0  49180 421296    856  56392   0   0     0     0  104    13  98   2   0
 2  0  0  49180 421132    856  56392   0   0     0     0  108    53 100   0   0
 2  0  0  49180 421128    856  56392   0   0     0     0  108    47 100   0   0
 2  0  0  49180 397520    856  56392   0   0     0     1  107    49  96   4   0
 2  0  0  49180 364860    856  56392   0   0     0     0  106    47  95   5   0
 2  0  0  49180 332244    856  56392   0   0     0     0  106    49  95   5   0
 2  0  0  49180 299660    856  56392   0   0     0     0  106    54  92   8   0
 2  0  0  49180 267076    856  56392   0   0     0     0  109    56  95   5   0
 2  0  0  49180 234632    856  56392   0   0     0     0  110    57  94   6   0
 2  0  0  49180 202096    872  56448  32   0    18     0  117    70  95   5   0
 2  0  0  49180 169544    872  56448   0   0     0     0  103    13  96   4   0
 2  0  0  49180 137108    872  56448   0   0     0     0  107    49  93   7   0
 2  0  0  49180 104600    872  56448   0   0     0     0  107    51  94   6   0
 2  0  0  49180  72368    872  56448   0   0     0    52  136    54  93   7   0
 2  0  0  49180  39964    872  56448   0   0     0     0  110    59  92   8   0
 2  0  2   7296   1576     96  13072   0 720     0   184  130   465  74  22   4
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  2  2  53620   1564    116  23512 1012 31876   565  7969  883  3802   1   8  92
 2  1  2  68800   1560     96  20128  68 15396    17  3850  291  2775   1   7  92
 3  0  1  99484   1556     96  26096  84 29552    21  7388  594  3832   1   4  95
 1  3  2 114708   1560    104  32528 284 14696   161  3674  374  3125   0   4  96
 1  4  2 175484   1560    124  31112 360 63000   237 15753 1404 14952   1   5  94
 1  2  2 205900   1560     96  32748  12 30080     3  7520  606  8356   1   5  94
 2  1  2 221156   1560     96  17848 412 14256   103  3564  308  8450   1  10  89
 1  2  2 222128   1564     96  12736   0 16100     7  4025  346  1010   0   5  95
 1  2  2 236580   1560    108  15220 276 13988    97  3497  347  4102   0   7  92
 2  1  2 267488   1560    104  32044 260 17376    69  4346  405  1265   0   7  93
 3  1  1 282756   1560     96  29380  16 15304     4  3827  335  4359   1   7  92
 2  1  2 282756   1580     96  11460  92 14948    23  3737  332  4120   1   5  94
 2  1  2 313496   1560    100  30476 200 15484    54  3871  318  2359   0   9  90
 2  1  2 313496   1560    100  14148   0 13076     1  3270  246  5165   1   8  91
 3  1  1 344564   1572     96  23892  16 18444    11  4613  419  1555   0   7  93
 2  1  2 375020   1560     96  25400 172 26988    43  6747  556  2910   1   7  93
 1  2  2 375020   1968     96  22760   8 17136     2  4284  378   787   0   2  98
 2  1  2 406056   1568     96  20432 212 17320    53  4330  393  2704   1  10  89
 3  0  3 421316   1560     96  25056  72 14416    18  3604  281  1731   0   5  94
 1  3  0 452120   1544    100  21216 240 31480   116  7870  715  2681   1   6  94
 2  2  2 467488   1588    108  27248 440 15056   123  3765  385  2206   0   5  94
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 2  1  0 467488   1564    136  13352  88 15376    49  3844  368  2913   1   4  95
 3  0  1 482864   1560     96  15256 128 15384    32  3846  296   986   1   7  92
 3  0  1 497920   1560     96  14144   0 12636     0  3159  245  2302   1   9  90
 3  1  1 529844   1540     96  18632 940 33340   569  8336 1104  1366   1  10  88
 0  1  0 269856 205944    148  21772 2628   0  1196     2  267   313   0   3  97
 0  1  0 269856 182736    156  33180 11180   0  2854     0  309   451   6   3  91
 0  1  0 269856 158668    156  44696 11516   0  2879     0  314   462  12   4  83
 0  1  0 269856 131928    156  57588 12892   0  3223     0  312   466   8   4  88
 0  1  0 269856 105176    156  70448 12864   0  3216     0  332   506  12   3  85
 0  1  0 269856  79056    156  82644 12196   0  3049     0  456   602  10   6  83
 1  1  0 269856  46948    156  96900 14252   0  3563     0  359   518  21   7  72

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
