Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbSJNN0Z>; Mon, 14 Oct 2002 09:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261621AbSJNN0Z>; Mon, 14 Oct 2002 09:26:25 -0400
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:3200 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261615AbSJNN0X> convert rfc822-to-8bit; Mon, 14 Oct 2002 09:26:23 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Subject: ck9/7 v 2.4.19 performance with contest
Date: Mon, 14 Oct 2002 23:29:57 +1000
User-Agent: KMail/1.4.3
Cc: Rodrigo Souza de Castro <rcastro@ime.usp.br>,
       linuxcompressed-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210142330.00711.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've run some benchmarks with contest (http://contest.kolivas.net) and my 
latest patchset (http://kernel.kolivas.net) for public consumption. These are 
to explain why I've included compressed caching and removed the added vm 
work.

CAVEAT:

ck9 will only be advantageous over ck7 on uniprocessor machines with a normal 
or small amount of memory. If you have heaps of memory and almost never get 
into swap then the compressed caching will offer you no advantage. Worse yet, 
SMP machines no longer benefit from the added vm changes in ck7 - these were 
not compatible with compressed caching.

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              67.7    98      0       0       1.01
2.4.19-ck7 [3]          73.8    96      0       0       1.10
2.4.19-ck9 [2]          68.8    97      0       0       1.02

You can see a slight difference here. ck7 and the 2.5 kernels show this 
unusual feature of taking longer to get started on a noload kernel compile 
after the memory and swap is all flushed. ck9 seems to have tamed this 
problem.

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              106.5   59      112     43      1.59
2.4.19-ck7 [3]          93.4    76      68      27      1.39
2.4.19-ck9 [2]          94.3    70      83      32      1.40

Minimal difference from ck7 in time taken, but during that time the background 
process has accomplished more work.

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [2]              106.5   70      1       8       1.59
2.4.19-ck7 [3]          142.3   57      2       10      2.12
2.4.19-ck9 [2]          110.5   71      1       9       1.65

ck7 exhibited quite aggressive work in the background load at the expense of 
the foreground process in tar creation. ck9 tames this a lot.

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [1]              132.4   55      2       9       1.97
2.4.19-ck7 [3]          238.3   33      5       11      3.55
2.4.19-ck9 [2]          138.6   58      2       11      2.06

Even more background work done by ck7 here; tamed by ck9.

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              492.6   14      38      10      7.33
2.4.19-ck7 [2]          174.6   41      8       8       2.60
2.4.19-ck9 [2]          140.6   49      5       5       2.09

Now under heavy file writing ck9 has relaxed even more than ck7 has.

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [2]              134.1   54      14      5       2.00
2.4.19-ck7 [2]          119.4   66      12      5       1.78
2.4.19-ck9 [2]          77.4    85      11      9       1.15

This overstates the advantage of ck9 over ck7 because the file read would be 
easy to compress. Nonetheless it is faster.

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [1]              89.8    77      1       20      1.34
2.4.19-ck7 [2]          104.0   70      1       21      1.55
2.4.19-ck9 [2]          85.2    79      1       22      1.27

Not sure why ck7 was slower than vanilla here, but ck9 improves on it. The 
resolution of loads performed cannot show less than 1 to show if ck7 or ck9 
did more work.

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              100.0   72      33      3       1.49
2.4.19-cc [3]           92.7    76      146     21      1.38
2.4.19-ck7 [2]          116.0   69      35      3       1.73
2.4.19-ck9 [2]          78.3    88      31      8       1.17

This is the most interesting. I've included 2.4.19 with just cc added to show 
the difference. With cc heaps more work is done by the background load and 
only a modest improvement occurs in the kernel compilation time. ck9 on the 
other hand does about the same amount of background work as vanilla, but is 
significantly faster on kernel compilation time - a preferable balance I 
believe. Once again the advantage is overstated because the data would 
compress well but is present.

Cheers,
Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9qsbVF6dfvkL3i1gRAuZ6AJwMDozAY7Bvujh8csCStlC5mWFUHwCfdSg0
2MNWYIRedppbyWh7P18uJN8=
=qWgv
-----END PGP SIGNATURE-----

