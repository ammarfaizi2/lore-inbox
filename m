Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267265AbSKPLGo>; Sat, 16 Nov 2002 06:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267264AbSKPLGo>; Sat, 16 Nov 2002 06:06:44 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:1664 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S267265AbSKPLGn> convert rfc822-to-8bit; Sat, 16 Nov 2002 06:06:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] 2.5.47-mm3 with contest
Date: Sat, 16 Nov 2002 22:13:28 +1100
User-Agent: KMail/1.4.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
References: <200211161422.17438.conman@kolivas.net> <3DD5BBD9.7DA70FFF@digeo.com> <3DD5C86C.70903@cyberone.com.au>
In-Reply-To: <3DD5C86C.70903@cyberone.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211162213.30307.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


>Andrew Morton wrote:
>>Con Kolivas wrote:
>>>Note the significant discrepancy between mm1 and mm3. This reminds me of
>>> what happened last time I enabled shared 3rd level pagetables - Andrew do
>>> you want me to do a set of numbers with this disabled?
>>
>>That certainly couldn't hurt.  But your tests are, in general, tesging
>>the IO scheduler.  And the IO scheduler has changed radically in each
>>of the recent -mm's.
>>
>>So testing with rbtree-iosched reverted would really be the only way
>>to draw comparisons on how the rest of the code is behaving.
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>
>Andrew there is, in fact a problem with the io scheduler in mm3 as far
>as I can see. Jens is away 'till Monday so he hasn't confirmed this yet.
>Basically if the device can't get through the entire queue within the
>read|write_expire timeout, they will start being submitted in fifo order
>slowing down the device more (probably) and contributing to the problem.
>It may be causing the bad numbers in contest. Here is a patch which
>relieves the problem for loads I am testing (bench.c, tiobench).
>
>Con, it would be nice if you could try this, if you value your disk,
>maybe you could wait for Jens to get back!

I gave it a quick run (with expire batch set to 16 to emulate fifo batch=16) 
and found only these different:

2.5.47-mm3ns is no shared 3rd level pagetables
2.5.47-mm3u is the same as 2.5.47-mm3ns but with your update

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.47-mm3ns [1]        121.8   60      5       7       1.71
2.5.47-mm3u [1]         161.1   47      9       9       2.26

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.47-mm3ns [2]        257.9   29      11      2       3.61
2.5.47-mm3u [1]         283.4   27      12      2       3.97

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.47-mm3ns [1]        237.5   32      41      1       3.33
2.5.47-mm3u [1]         218.8   34      39      1       3.06

To me it does not appear to be the cause of the prolongation of kernel 
compilation time under io load in 2.5.47-mm3

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE91ihYF6dfvkL3i1gRAqsnAKCAd0DkP1MDFe8DkNuTc/nl4XfYwQCgh4pR
FqhMIpEdOEFhQOnWx+wQNgE=
=shmO
-----END PGP SIGNATURE-----

