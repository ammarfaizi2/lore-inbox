Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285828AbSA2XGn>; Tue, 29 Jan 2002 18:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286413AbSA2XFO>; Tue, 29 Jan 2002 18:05:14 -0500
Received: from [217.9.226.246] ([217.9.226.246]:22912 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S286411AbSA2XDs>; Tue, 29 Jan 2002 18:03:48 -0500
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <20020129165444.A26626@caldera.de>
	<a36t3f$oh8$1@penguin.transmeta.com>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <a36t3f$oh8$1@penguin.transmeta.com>
Date: 30 Jan 2002 01:02:11 +0200
Message-ID: <877kq04v7w.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Linus" == Linus Torvalds <torvalds@transmeta.com> writes:

Linus> In article <20020129165444.A26626@caldera.de>,
Linus> Christoph Hellwig  <hch@caldera.de> wrote:
>> I've ported my hacked up version of Momchil Velikov's radix tree
>> radix tree pagecache to 2.5.3-pre{5,6}.
>> 
>> The changes over the 2.4.17 version are:
>> 
>> o use mempool to avoid OOM situation involving radix nodes.
>> o remove add_to_page_cache_locked, it was unused in the 2.4.17 patch.
>> o unify add_to_page and add_to_page_unique
>> 
>> It gives nice scalability improvements on big machines and drops the
>> memory usage on small ones (if you consider my 64MB Athlon small :)).

Linus> Can you post the numbers on scalability (I can see the locking
Linus> improvement, but if you have numbers I'd be even happier) and any
Linus> benchmarks you have?

Well, these are dbench numbers from December, it's
2.4.17. Unfortunately, it appears OSDL have trouble with 2.5 currently ...

FWIW, box is 8-way PIII Xeon, 700MHz, 1MB cache, 8G RAM

rat-7 is with 128-way radix tree branch factor, rat-4 is with 16-way.

#Clients        2.4.17     2.4.17-rat-7   2.4.17-rat-4
---------------------------------------------------------
1                81.81        82.70         79.49
2               131.77       133.15        116.32
3               179.74       188.04        184.80
4               221.60       228.70        223.97
5               249.86       252.89        258.77
6               260.56       277.70        265.20
7               285.82       287.47        281.27
8               263.61       258.81        256.29
9               271.06       268.29        261.04
10              261.23       265.82        259.34
11              256.82       260.38        258.35
12              255.55       255.68        252.78
13              252.70       254.02        249.42
14              251.41       253.93        252.21
15              255.27       257.13        262.21
16              156.81       146.69        180.77
17              113.00       103.32        101.14
18               81.06        78.98         86.77
19               76.24        40.09         39.89
20               17.51        17.64         17.53

The results are similar on 4-way OSDL boxen and on the 12- and 16-way
PPC64 runs by Anton Blanchard:

   # clients
   [1 - ncpu]         - linear increase in the throughput, small improvement over the
                        stock kernel, I guess we quickly hit other locks
   [ncpu - 2 * ncpu]  - flat
   [2 * ncpu, +infty) - drops down do zero

Linus> The only real complaint I have is that I'd rather see "radix_root" than
Linus> "rat_root". Maybe it is just me, but the latter makes me wonder about
Linus> the sex-lives of small furry mammals. Which is not what I really want to
Linus> be thinking about.

Done. rat_* -> radix_tree_*

Linus> It looks straigthforward enough, so if you feel it is stable (and
Linus> cleaned up), I'd suggest just submitting it for real.

I'll wait for a day for some more comments (e.g. Ingo) and will submit
it.

Regards,
-velco


