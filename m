Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132122AbRCVRyj>; Thu, 22 Mar 2001 12:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132123AbRCVRy3>; Thu, 22 Mar 2001 12:54:29 -0500
Received: from www.wen-online.de ([212.223.88.39]:41479 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S132122AbRCVRyV>;
	Thu, 22 Mar 2001 12:54:21 -0500
Date: Thu, 22 Mar 2001 18:53:18 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <arjanv@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Thinko in kswapd?
In-Reply-To: <20010322145810.A7296@redhat.com>
Message-ID: <Pine.LNX.4.33.0103221837360.665-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2001, Stephen C. Tweedie wrote:

> Hi,
>
> There is what appears to be a simple thinko in kswapd.  We really
> ought to keep kswapd running as long as there is either a free space
> or an inactive page shortfall; but right now we only keep going if
> _both_ are short.
>
> Diff below.  With this change, I've got a 64MB box running Applix and
> Star Office with multiple open documents plus a few other big apps
> running, and switching desktops or going between documents is once
> more nice and snappy.  Running a normal heavily populated desktop in
> 256MB used to be painful, with much apparently unnecessary swapping,
> if we had background page-cache intensive operations (eg find|wc)
> going on: the patched kernel feels much better interactively,
> presumably because kswapd is now doing the work it is supposed to do,
> instead of forcing normal apps to go into page stealing mode
> themselves.

OTOH, this change is very bad for sustained load of many tasks (make
-j30) and triggers vm oscillations.  In the vmstat output below, you
can see the oscillation between push too much out to swap, and then
pull it all right back in again.  It continues through the entire
build with the cost seen in the time numbers.  (the ac20.virgin run
was worse by 30 secs than average, but that doesn't matter much)

I've tried this change here myself before.  I think this trying to
use 'how much memory is free _now_' as a parameter is wrong because
that information is stale as soon as you get it.. or will be before
you actually get anything done with it.  I know I've had good results
by throwing all of the loops out and just tell kswapd to go after a
smallish but useful size chunk whenever it's is awakened and go to
sleep again unconditionally (ala bdflush).

	-Mike

2.4.2.ac20.virgin  +change
real    9m2.872s   11m24.705s
user    7m23.090s   7m29.440s
sys     0m35.120s   0m41.280s

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
17 17  1  49536   8872   1216  31348 432 800   268   200  341  1073  80  20   0
19 15  0  49284   7812   1240  31984 560   0   378     0  269   523  93   7   0
16 17  0  48440   6296   1268  32212 596   0   361     0  286   525  94   6   0
19 12  1  47728   1744   1312  32260 544 1584   349   462  512  1608  89  11   0
11 16  1  52716  12916   1256  35896 800 5644   234  1592 1136  2032  59  13  29
14 23  0  49748  18592   1308  36420 2580   0   860     0  706  1347  91   9   0
27 12  0  49236   6188   1352  37396 1132   0   370     0  364   640  89  11   0
32 10  0  50928   1688   1340  37944 1004   0   294     0  329   630  89  11   0
25 15  2  48748   1880   1052  34584 600 2088   280   787  730  2308  89  11   0
20  9  3  76344   1452    616  54908 424 9016   153  2411 1188  3534  55  36   8
18 13  3  86344   1432    284  49828 1092 16788   454  4212 2063  6043  59  24  16
18 17  2  81060   1460    308  47756 3520 3572  1313   893  957  1911  77  23   0
 8 22  1  75420  22864    356  45568 4608 8416  1437  2126 1528  3958  81   8  11
 4 25  0  63456  64244    460  44576 5880   0  3014     0 1439  1956  66   6  28
 0 23  0  60380  64052    696  47368 3884   0  1941     0 1646  2486  11   9  80
 1 35  2  59972  53580    876  49136 1520   0   591     0  856  1314   7  10  83
 0 33  0  59188  49228    984  49544 808   0   283     0  424   747  11  11  78
 0 30  1  59188  45168   1088  50348 608   0   227     0  333   626  12  10  78
 3 27  0  58056  42312   1144  50236 628   0   219     0  273   579  13   9  78
 0 32  1  58056  36640   1264  51336 620   0   262     0  310   704  21   7  72
 1 29  0  58056  35068   1340  51996 536   0   184     0  251   623  18   6  76
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 2 30  0  57300  28216   1368  51944 368   0   146     0  241   582  66  15  19
 0 31  0  56896  22116   1384  52228 404   0   157     0  243   825  28  13  60
 3 29  0  56080  18052   1396  52160 328   0   164     0  219   838  33   7  61
27  4  0  56080   8712   1424  52680  12   0   137     7  229   493  77  10  14
28  3  0  54040   1460   1428  50516   0 708    87   177  236   406  87  13   0
22  8  2  40644   1432   1412  32952   0 9208    94  2726 1119  2866  56  16  28
30  0  1  39372   1432   1100  30404   0 3144     0   807  302  1442  95   5   0
29  1  1  83928   1424    152  52504 160 24372   443  6095 1932  8542  60  33   8
30  0  2  84220   1432    152  44516  36 9864    23  2471  359  1444  85  15   0
29  1  1  84728   1432    160  36252 804 11140   508  2787  426  2338  90  10   0
18 21  1 106944   1448    124  26752 8548 36396  3405  9101 3750 10160  40  46  14
 3 32  1  95940  36476    136  54668 40632 24104 12292  6028 5610  5505  46  34  20
 5 14  0  84008  50636    136  53776 4572   0  1292     0  526   720  96   4   0
 0 31  0  70928  62820    188  52940 6896   0  1931     0 1008  1342  54   6  40
 0 33  1  68000  60016    236  53932 1860   0  1498     0  672  1475   7  12  80
 0 27  1  68000  60392    328  55236 1148   0   367     0  489   808   3  13  84
 0 35  1  68000  45964    528  56728 1056   0   622     0  606  1089   9  12  79
 1 38  2  68000  34632    664  57656 428   0   350     0  411   767  14  10  76
 1 32  1  67500  29384    700  58700 336   0   609     0  296   670  24  14  62
 0 31  1  67500  25800    756  59348 260   0   270     0  238   629  25  14  61
 0 30  1  67500  22496    804  59976 452   0   162     0  249   606  20  15  65
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 2 30  0  66128  20152    828  59872 484   0   164     0  249   787  12  16  72
 2 28  1  64372  19572    860  59388 416   0   176     0  214   829  18  13  69
 0 30  1  64372  15452    872  60340 692   0   241     0  215   926  29  10  62
 3 27  0  63976  10972    924  60692 388   0   173     0  222  1041  37   8  56
23 10  0  63404   1944    956  61192 276   0   265     0  260   710  75  10  15
23 10  0  55912   1460    972  51976  84 1072   138   268  387  1137  81  19   0
31  0  1  56912   1432    984  51380   0 1948    60   685  441  1947  87  13   0
30  0  0  53072   1432    980  43660   0   0     3     0  125   559  91   9   0
31  0  0  49516   1452    964  39540   0   0     6     0  109   428  86  14   0
30  0  1  52532   1460    528  42184  24   0    87    64  166   860  91   9   0
28  2  1  66340   1432    220  28508 724 27248   652  6860 1780  6486  60  37   3
25 11  1  90176   1432    120  31684 3412 21744  1159  5438 1456  7274  62  38   0
 9 23  1 112836   3776    128  49752 14204 18340  4972  4588 2449  5469  50  25  25
17 19  1 112276   9660    132  61376 7156 3188  2464   797 1007  1827  93   7   0
18  9  0 106452   7676    132  63292 4732   0  1400     0  361   624  95   5   0
15 15  0  99796  15272    148  65036 6024   0  1640     0  547   786  97   3   0
17 15  0  91072  20892    176  63416 2608   0  1306     0  345   766  95   5   0
30  0  0  86872  20460    228  62344 352   0   496     0  175   381  88  12   0
 6 29  0  73896  40984    292  53296 1740   0   508     0  544   953  95   5   0
 6 39  1  65640  36820    568  50996 1588   0  1081     0  877  1528  89   7   4
 3 30  0  62900  34872    624  50848 504   0   527     0  287   536  59  13  29
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 2 30  0  60936  32628    668  51380 192   0   327     0  263   734  43  12  45
 1 29  0  60388  27824    680  51736 404   0   145     0  236   732  45  13  42
 0 30  0  56808  34432    688  50712 932   0   266     0  225   753  46   7  47
 0 30  0  56808  32476    712  51232 420   0   136     0  221   801  12  13  75
 1 29  1  56416  31120    724  51416 408   0   131     0  221   766  14  11  75
 0 31  1  55992  27196    732  52012 444   0   144     0  240   829  23   6  70
 0 32  1  55204  24556    736  52080 476   0   174     0  238   924  56   5  39
 4 26  1  54920  20936    748  52552 508   0   167     0  218   889  26  16  58

