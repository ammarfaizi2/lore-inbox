Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273255AbRJaVdn>; Wed, 31 Oct 2001 16:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273213AbRJaVde>; Wed, 31 Oct 2001 16:33:34 -0500
Received: from mailrelay2.inwind.it ([212.141.54.102]:44205 "EHLO
	mailrelay2.inwind.it") by vger.kernel.org with ESMTP
	id <S273065AbRJaVdS>; Wed, 31 Oct 2001 16:33:18 -0500
Message-Id: <3.0.6.32.20011031223140.01fdd100@pop.tiscalinet.it>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Wed, 31 Oct 2001 22:31:40 +0100
To: Linus Torvalds <torvalds@transmeta.com>
From: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Subject: Re: new OOM heuristic failure  (was: Re: VM: qsbench)
Cc: Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0110311002560.32505-100000@penguin.transmeta
 .com>
In-Reply-To: <3.0.6.32.20011031185529.01fc4310@pop.tiscalinet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10.06 31/10/01 -0800, Linus Torvalds wrote:
>
>On Wed, 31 Oct 2001, Lorenzo Allegrucci wrote:
>>
>> Until swpd is "139968" everything is fine and I have about 60M of
>> free swap (I have 256M RAM + 200M of swap and qsbench uses about 343M).
>
>Ok, that's the problem. The swap free on swap-in logic got removed, try
>this simple patch, and I bet it ends up working ok for you
>
>You should see better performance with a bigger swapspace, though. Linux
>would prefer to keep the swap cache allocated as long as possible, and not
>drop the pages just because swap is smaller than the working set.
>
>(Ie the best setup is not when "RAM + SWAP > working set", but when you
>have "SWAP > working set").
>
>Can you re-do the numbers with this one on top of pre6?
>
>Thanks,
>
>		Linus
>
>-----
>diff -u --recursive pre6/linux/mm/memory.c linux/mm/memory.c
>--- pre6/linux/mm/memory.c	Wed Oct 31 10:04:11 2001
>+++ linux/mm/memory.c	Wed Oct 31 10:02:33 2001
>@@ -1158,6 +1158,8 @@
> 	pte = mk_pte(page, vma->vm_page_prot);
>
> 	swap_free(entry);
>+	if (vm_swap_full())
>+		remove_exclusive_swap_page(page);
>
> 	flush_page_to_ram(page);
> 	flush_icache_page(vma, page);

Linus,

your patch seems to help one case out of three.
(even though I have not any meaningful statistical data)

lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
Out of Memory: Killed process 225 (qsbench).
69.500u 3.200s 2:11.23 55.3%    0+0k 0+0io 15297pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
Out of Memory: Killed process 228 (qsbench).
69.720u 3.190s 2:12.23 55.1%    0+0k 0+0io 15561pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.250u 3.470s 2:15.88 54.2%    0+0k 0+0io 17170pf+0w

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 2  0  0 136320   3644     72    284   0   0     0     0  101     5 100   0   0
 1  0  0 136320   3644     72    284   0   0     0     0  101     3 100   0   0
 1  0  0 136320   3644     72    284   0   0     0     0  101     3 100   0   0
 1  0  0 136320   3644     72    284   0   0     0     0  101     9 100   0   0
 0  1  0 133140   2608     72    284 3344 768  3344   768  215   215  47   2  51
 0  1  0 132276   1608     72    284 3552 6376  3552  6376  280   227   2   3  95
 1  0  0 128648   3240     72    284 768 3656   768  3660  162    54  57   1  42
 1  0  0 128648   3240     72    284   0   0     0     0  101     3 100   0   0
 1  0  0 128648   3240     72    284   0   0     0     4  102     9 100   0   0
 1  0  0 128648   3240     72    284   0   0     0     0  101     3 100   0   0
 1  0  0 128648   3240     72    284   0   0     0     0  101     3 100   0   0
 1  0  0 128648   3240     72    284   0   0     0     0  101     3 100   0   0
 1  0  0 128648   3240     72    284   0   0     0     0  101     3 100   0   0
 1  0  0 129672   3316     68    284 4328 2860  4328  2860  265   282  62   2  36
 1  0  0 137992   1644     68    280 19216 3172 19216  3172  743  1227   7   5  88
 0  1  0 153096   3648     68    280 3072 17788  3072 17788  353   218   2   6  92
 0  1  1 160136   1660     68    280 15240 4740 15240  4740  647   963  16  10  74
 1  0  0 177288   1588     68    280 5868 14220  5868 14220  422   393   0   7  93
 0  1  0 188680   1620     68    280 8144 11904  8144 11904  473   544   4   5  91
 0  1  0 192136   1552     68    280 17136 5860 17136  5860  689  1081   8   9  83
 1  0  0 195512   2948     68    280 7672 9008  7672  9008  476   512   2   8  90
 1  0  0 195512   1556     68    280 21688 356 21688   356  786  1375  11   8  81
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 2  0  0 195512   1608     68    276 22352   0 22352     0  801  1422  10  17  73
 1  0  0 195512   1588     68    276 22748   0 22748     0  812  1431  14  12  74
 1  0  0 195512   1560     68    276 12768   0 12768     0  502   809  55   4  41
 1  0  0 195512   1552     68    280 23012   0 23012     0  823  1446  11   6  83
 0  1  0   4696 250440     80    632 9048   0  9412     4  409   609  27   7  66
 0  0  0   4564 250284     84    752  32   0   156     0  108    17   0   0 100
 0  0  0   4564 250280     88    752   0   0     4     0  106    18   0   0 100
 0  0  0   4564 250280     88    752   0   0     0     0  101     3   0   0 100
 0  0  0   4564 250280     88    752   0   0     0     0  109    21   0   0 100
 0  0  0   4564 250280     88    752   0   0     0     0  121    44   0   0 100
 0  0  0   4564 250280     88    752   0   0     0     0  101     3   0   0 100

Then, I repeated the test with a bigger swap partition (400M):
qsbench working set is about 343M, so now SWAP > working set.

lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.770u 3.630s 2:14.21 55.4%    0+0k 0+0io 16545pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.720u 3.370s 2:16.66 54.2%    0+0k 0+0io 17444pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.050u 3.380s 2:15.05 54.3%    0+0k 0+0io 17045pf+0w

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 2  0  0 124040   3652     68   3428   0   0     0     0  101     7 100   0   0
 1  0  0 122096   1640     68   3428 2880 1656  2880  1656  208   184  51   1  48
 1  0  0 129972   1896     68   3428 2328 1836  2328  1836  195   292  45   3  52
 1  0  0 130740   2000     68   3428   0 168     0   168  106     6 100   0   0
 1  0  0 131508   2104     68   3428   0 252     0   252  101     8 100   0   0
 1  0  0 132660   2340     68   3428   0 336     0   336  107    10 100   0   0
 1  0  0 133428   2460     68   3428   0 208     0   208  101     6 100   0   0
 1  0  0 134196   2560     68   3428   0 212     0   212  105     6 100   0   0
 1  0  0 134196   2560     68   3428   0   0     0     0  101     5 100   0   0
 0  1  1 138932   1664     68   3428 1856 2052  1856  2052  178   156  83   0  17
 0  1  0 145076   1612     68   3428 6900 9956  6900  9964  451   532   3   5  92
 1  0  0 149044   3648     68   3424 3232 9556  3232  9556  333   259   2   5  93
 1  0  0 154036   1580     64   3424 13816 4736 13816  4736  635   951   6   4  90
 0  1  0 171444   1648     64   2404 14328 6544 14328  6544  620  1155   5  13  82
 0  1  0 182580   1648     64   1584 6180 21916  6180 21912  438   422   1   7  92
 0  1  0 184500   1628     64   1584 13800 3980 13800  3984  602   878  11   5  84
 1  0  0 196532   1624     64   1584 10876 7576 10876  7576  522   707   6   5  89
 0  1  0 210612   1540     64   1584 8992 13760  8992 13760  492   592   5   9  86
 0  1  0 214452   2412     64   1584 12928 10176 12928 10176  593   817  11   4  85
 1  0  0 225460   1632     64   1584 11704 8380 11704  8380  564   766   5   8  87
 1  0  0 230976   1592     64   1224 8012 10008  8012 10008  465   525   2   6  92
 1  0  0 233340   1556     80    288 17748 888 17764   888  674  1136   7  12  81
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 2  0  0 233340   3524     64    284 20276 2392 20276  2392  771  1315  10   6  84
 1  0  0 233340   3632     64    284 14948   0 14948     0  569   957  44   5  51
 1  0  0 233340   1556     64    284 24448   0 24448     0  865  1575  12   8  80
 0  1  0 240920   1580     68    288 18208 4656 18212  4656  717  1186   7   5  88
 1  0  0 240920   2704     68    288 16672 2924 16672  2928  656  1069  25  11  64
 0  0  0   4536 250948     84    760 4384   0  4872     0  270   340   3   8  89
 0  0  0   4536 250948     84    760   0   0     0     0  101     3   0   0 100
 0  0  0   4536 250948     84    760   0   0     0     0  101     3   0   0 100
 0  0  0   4536 250948     84    760   0   0     0     0  101     7   0   0 100



-- 
Lorenzo
