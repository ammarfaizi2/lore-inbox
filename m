Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266987AbTGOJd7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 05:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266988AbTGOJd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 05:33:59 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:9938
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266987AbTGOJd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 05:33:57 -0400
Date: Tue, 15 Jul 2003 11:48:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Chris Mason <mason@suse.com>,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: RFC on io-stalls patch
Message-ID: <20030715094826.GF30537@dualathlon.random>
References: <1058214881.13313.291.camel@tiny.suse.com> <20030714224528.GU16313@dualathlon.random> <1058229360.13317.364.camel@tiny.suse.com> <20030714175238.3eaddd9a.akpm@osdl.org> <20030715020706.GC16313@dualathlon.random> <20030715054551.GD833@suse.de> <20030715060101.GB30537@dualathlon.random> <20030715060857.GG833@suse.de> <20030715070314.GD30537@dualathlon.random> <20030715082850.GH833@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715082850.GH833@suse.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 10:28:50AM +0200, Jens Axboe wrote:
> no_load:
> Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
> 2.4.21                 3        133     197.0   0.0     0.0     1.00
> 2.4.22-pre5            2        134     196.3   0.0     0.0     1.00
> 2.4.22-pre5-axboe      3        133     196.2   0.0     0.0     1.00
> ctar_load:
> Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
> 2.4.21                 3        190     140.5   15.0    15.8    1.43
> 2.4.22-pre5            3        235     114.0   25.0    22.1    1.75
> 2.4.22-pre5-axboe      3        194     138.1   19.7    20.6    1.46
> 
> 2.4.22-pre5-axboe is way better than 2.4.21, look at the loads
> completed.
> 
> xtar_load:
> Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
> 2.4.21                 3        287     93.0    14.0    15.3    2.16
> 2.4.22-pre5            3        309     86.4    15.0    14.9    2.31
> 2.4.22-pre5-axboe      3        249     107.2   11.3    14.1    1.87
> 
> 2.4.21 beats 2.4.22-pre5, not too surprising and expected, and not
> terribly interesting either.
> 
> io_load:
> Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
> 2.4.21                 3        543     49.7    100.4   19.0    4.08
> 2.4.22-pre5            3        637     42.5    120.2   18.5    4.75
> 2.4.22-pre5-axboe      3        540     50.0    103.0   18.1    4.06
> 
> 2.4.22-pre5-axboe completes the most loads here per time unit.
> 
> io_other:
> Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
> 2.4.21                 3        581     46.5    111.3   19.1    4.37
> 2.4.22-pre5            3        576     47.2    107.7   19.8    4.30
> 2.4.22-pre5-axboe      3        452     59.7    85.3    19.5    3.40
> 
> 2.4.22-pre5 is again the slowest of the lot when it comes to
> workloads/time, 2.4.22-pre5 is again the fastest and completes the work
> load in the shortest time.
> 
> read_load:
> Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
> 2.4.21                 3        151     180.1   8.3     9.3     1.14
> 2.4.22-pre5            3        150     181.3   8.1     9.3     1.12
> 2.4.22-pre5-axboe      3        152     178.9   8.2     9.9     1.14
> 
> Pretty equal.

io_other and xtar_load aren't exactly equal.  As for elevator-lowlatency
alone I'm not sure why it doesn't show big benefits in the above
workloads. It was very noticeable in my tests where I normally counted
the lines per second in `find /` or `time ls` (from comparisons with
contest with previous kernels w/o elevator-lowlatency, it looked like it
made a difference too and I've got some positive feedback). Maybe it's
because we enlarged the queue size to 4M in this version, in the
original patches where I run most of the latency tests it was 2M but I
was concerned that it could be too small.

If it doesn't take too much time, I would be curious what happens if
you change:

	MAX_QUEUE_SECTORS (4 << (20 - 9)) 

to

	MAX_QUEUE_SECTORS (2 << (20 - 9)) 

(it's up to you if to apply your patch or not along with this change, it
should make a noticeable difference either ways)

Obviously, the smaller the queue, the higher the fairness and the lower
the latency, but the smaller the pipelining will be in the I/O queue, so
it'll be less guaranteed to keep the spindle constantly working, not an
issue for all low end devices though. Ideally it should be tunable per-device.
on a 50mbyte/sec array 2M didn't show any degradation either during
contigous I/O, but I didn't run any test on faster storages, so I felt
safer to use 4M in the latest versions, knowing latency would be
slightly hurted.

Andrea
