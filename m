Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280373AbRJaRyY>; Wed, 31 Oct 2001 12:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280352AbRJaRyE>; Wed, 31 Oct 2001 12:54:04 -0500
Received: from mailrelay3.inwind.it ([212.141.54.103]:21409 "EHLO
	mailrelay3.inwind.it") by vger.kernel.org with ESMTP
	id <S280365AbRJaRwt>; Wed, 31 Oct 2001 12:52:49 -0500
Message-Id: <3.0.6.32.20011031185529.01fc4310@pop.tiscalinet.it>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Wed, 31 Oct 2001 18:55:29 +0100
To: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>
From: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Subject: Re: new OOM heuristic failure  (was: Re: VM: qsbench)
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0110310744070.32330-100000@penguin.transmeta
 .com>
In-Reply-To: <Pine.LNX.4.33L.0110311259570.2963-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07.52 31/10/01 -0800, Linus Torvalds wrote:
>
>On Wed, 31 Oct 2001, Rik van Riel wrote:
>>
>> Linus, it seems Lorenzo's test program gets killed due
>> to the new out_of_memory() heuristic ...
>
>Hmm.. The oom killer really only gets invoced if we're really down to zero
>swapspace (that's the _only_ non-rate-based heuristic in the whole thing).
>
>Lorenzo, can you do a "vmstat 1" and show the output of it during the
>interesting part of the test (ie around the kill).

   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
 id
 2  0  0 139908   3588     68   3588   0   0     0     0  101     3 100   0
  0
 1  0  0 139908   3588     68   3588   0   0     0     0  101     7 100   0
  0
 1  0  0 139908   3588     68   3588   0   0     0     0  101     5 100   0
  0
 0  1  0 139336   1568     68   3588 2524 696  2524   696  192   180  57
2  41
 1  0  0 140296   2996     68   3588 3776 4208  3776  4208  287   304   3
3  94
 1  0  0 139968   2708     68   3588 288   0   288     0  110    21  96   0
  4
 1  0  0 139968   2708     68   3588   0   0     0     0  101     5 100   0
  0
 1  0  0 139968   2708     68   3588   0   0     0     0  101     5 100   0
  0
 1  0  0 139968   2708     68   3588   0   0     0     0  101     5  99   1
  0
 1  0  0 139968   2708     68   3588   0   0     0     0  101     3 100   0
  0
 1  0  0 139968   2708     68   3588   0   0     0     0  101     3 100   0
  0
 1  0  0 139968   2708     68   3588   0   0     0    12  104     9 100   0
  0
 0  1  0 144064   1620     64   3588 7256 6880  7256  6880  395   517  28
5  67
 1  0  0 146168   2952     60   3584 5780 6720  5780  6720  396   401   0
8  92
 0  1  0 151672   3580     64   3584 12744 10076 12748 10076  579   870   3
  7  90
 0  1  0 165496   1620     64   3388 14684 4108 14684  4108  629  1131  11
 6  83
 1  0  0 177912   1592     64   1624 4544 14196  4544 14200  377   355   5
 2  93
 0  1  0 182392   1548     60   1624 14648 8064 14648  8064  633   935  11
11  78
 0  1  1 195320   2692     64   1624 14156 9600 14160  9600  605   943   3
 8  89
 1  0  0 195512   3516     64    400 5312 8376  5312  8376  378   374   2
8  90
 1  0  1 195512   1664     64    400 22256   0 22256     0  797  1419  18
8  74
 1  0  0 195512   1544     60    400 23520   0 23520     4  837  1540  13
7  80
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
 id
 2  0  0 195512   1660     60    400 23292   0 23292     0  832  1546  10
10  80
 0  0  0   5384 250420     76    784 2212  24  2672    24  201   208   1
7  92
 0  0  0   5384 250420     76    784   0   0     0     0  101     3   0   0
100
 0  0  0   5384 250416     76    788   0   0     0     0  101     3   0   0
100
 0  0  0   5384 250400     92    788   0   0    16     0  105    15   0   0
100
 0  0  0   5384 250400     92    788   0   0     0     0  101     3   0   0
100
 0  0  0   5384 250400     92    788   0   0     0     0  101     7   0   0
100

Until swpd is "139968" everything is fine and I have about 60M of
free swap (I have 256M RAM + 200M of swap and qsbench uses about 343M).
>From that point Linux starts swapping without any apparent reason (?)
because qsbench allocates its memory just once at the beginning.
I guess Linux starts swapping when qsbench scans sequentially the
whole array to check for errors after sorting, in the final stage.
I wonder why..

Linux-2.4.13:
 1  0  0 109864   3820     64    396   0   0     0     0  101     3 100   0
  0
 1  0  0 109864   3816     68    396   0   0     4     0  107    23 100   0
  0
 1  0  0 109864   3816     68    396   0   0     0     0  101     5  98   2
  0
 1  0  0 109864   3816     68    396   0   0     0     0  101     3 100   0
  0
 1  0  0 109864   3816     68    396   0   0     0     0  101     3 100   0
  0
 1  0  0 109864   3816     68    396   0   0     0     0  102     5 100   0
  0
 0  1  0 112156   3224     64    508 2676 2048  2888  2052  235   239  68
1  31
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
 id
 1  1  0 121372   3416     64    508 8896 9216  8896  9216  519   686   4
5  91
 1  0  0 130460   3340     64    508 9420 9216  9420  9216  559   737   5
2  93
 0  1  0 139932   3168     64    508 9644 9472  9644  9472  547   717   5
4  91
 0  1  1 149532   3488     64    508 9356 9572  9356  9576  550   725   2
5  93
 1  0  1 158308   4008     64    500 8484 8736  8492  8744  502   655   5
15  80
 0  1  0 166244   3724     64    500 8204 8004  8204  8004  452   601   4
13  83
 0  1  0 175716   4092     64    500 9104 9344  9104  9344  525   681   8
4  88
 0  1  0 185188   4076     64    500 9356 9344  9356  9344  545   690   7
8  85
 0  1  1 192100   3624     64    500 7544 7040  7544  7040  444   548   2
13  85
 1  0  0 195512   3972     64    348 11260 3924 11264  3928  521   767   8
23  69
 1  0  0 195512   4184     64    348 16812   0 16812     0  632  1074  14
25  61
 0  1  0 195512   4164     64    364 19828   0 19856     0  722  1251   9
21  70
 1  0  0 195512   3880     64    364 19740   0 19740     0  721  1240  10
16  74
 1  0  0 195512   3752     64    396 20676   0 20736     0  752  1307  13
21  66
 1  0  0 195512   3096     64    372 16260   4 16264     8  617  1040  11
23  66
 1  0  0 195512   3344     68    372 7548   0  7560     0  346   493  51
5  44
 0  0  0   5948 250640     80    800 328   0   768     0  132    64  29   4
 67
 0  0  0   5948 250640     80    800   0   0     0     0  101     3   0   0
100
 0  0  0   5948 250640     80    800   0   0     0     0  104    10   0   0
100
 0  0  0   5948 250640     80    800   0   0     0     0  119    44   0   0
100
 0  0  0   5948 250640     80    800   0   0     0     0  104    11   0   0
100
 0  0  0   5948 250640     80    800   0   0     0     0  130    61   0   0
100

Same behaviour.

Linux-2.4.14-pre5:
 1  0  0 142648   3268     80   3784   0   0     0     0  101     5  99   1
  0
 1  0  0 142648   3268     80   3784   0   0     0     0  101     9 100   0
  0
 1  0  0 142648   3268     80   3784   0   0     0     0  101     3 100   0
  0
 1  0  0 142648   3268     80   3784   0   0     0     0  101     3 100   0
  0
 1  0  0 142648   3268     80   3784   0   0     0     0  101     3 100   0
  0
 1  0  0 142648   3268     80   3784   0   0     0     0  101     5  99   1
  0
 0  1  0 143404   3624     80   3784 5380 2108  5380  2116  298   346  61
2  37
 0  1  0 148324   1632     76   3780 9452 7808  9452  7808  480   601   4
7  89
 1  0  0 153572   3412     72   3780 11492 6044 11492  6044  560   737   6
 4  90
 1  0  0 165604   1584     72   2860 13952 7972 13952  7972  615   889  10
10  80
 1  1  0 175076   1624     72   1624 5232 13536  5232 13536  390   339   4
 6  90
 0  1  0 181604   1540     76   1624 13360 7924 13364  7924  593   852  12
 4  84
 1  0  0 194276   2812     76   1624 12696 7704 12696  7704  575   804   8
 6  86
 1  0  0 195512   1640     76    556 7624 11412  7624 11412  449   488   4
 5  91
 1  0  0 195512   1572     72    496 21768  52 21768    56  784  1367  14
9  77
 1  1  0 195512   1580     72    496 23196   0 23196     0  827  1460  14
10  76
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
 id
 1  1  0 195512   1608     76    496 19208   0 19212     0  704  1220  15
8  77
 1  0  0 195512   1728     76    496 15040   0 15040     4  572   946  48
6  47
 1  0  0 195512   1612     72    496 21664   0 21664     0  782  1363  19
11  70
 0  1  0   5144 250652     84    564 12120   0 12196     0  495   790  30
9  61
 0  0  0   4984 250236     84    748 368   0   552     0  122    44   0   0
100
 0  0  0   4984 250228     92    748   0   0     8     0  106    20   0   0
100
 0  0  0   4984 250228     92    748   0   0     0     0  102     5   0   0
100
 0  0  0   4984 250228     92    748   0   0     0     0  105    12   0   0
100
 0  0  0   4984 250228     92    748   0   0     0     0  102     5   0   0
100
 0  0  0   4984 250228     92    748   0   0     0     0  101     3   0   0
100
 0  0  0   4984 250228     92    748   0   0     0     0  102    11   0   0
100
 0  1  0   4984 250196     92    748  32   0    32     0  112    26   0   0
100

Same behaviour, but 2.4.13 uses less swap space.
Both kernels above seem to fall in OOM conditions, but they don't kill
qsbench.

>I could probably argue that the machine really _is_ out of memory at this
>point: no swap, and it obviously has to work very hard to free any pages.
>Read the "out_of_memory()" code (which is _really_ simple), with the
>realization that it only gets called when "try_to_free_pages()" fails and
>I think you'll agree.
>
>That said, it may be "try_to_free_pages()" itself that just gives up way
>too easily - it simply didn't matter before, because all callers just
>looped around and asked for more memory if it failed. So the code could
>still trigger too easily not because the oom() logic itself is all that
>bad, but simply because it makes the assumption that try_to_free_pages()
>only fails in bad situations.
>
>		Linus


-- 
Lorenzo
