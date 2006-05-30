Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWE3Ahy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWE3Ahy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 20:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWE3Ahy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 20:37:54 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:38812 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1750756AbWE3Ahx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 20:37:53 -0400
Message-ID: <348949470.27872@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Tue, 30 May 2006 08:37:57 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Adaptive Readahead V14 - statistics question...
Message-ID: <20060530003757.GA5164@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
References: <200605291944.k4TJixBW011192@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605291944.k4TJixBW011192@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2006 at 03:44:59PM -0400, Valdis.Kletnieks@vt.edu wrote:
> Running 2.6.17-rc4-mm3 + V14.  I see this in /debug/readahead/events:
> 
> [table summary]      total   initial     state   context  contexta  backward  onthrash    onseek      none
> random_rate             8%        0%        4%       46%        9%       44%        0%       38%       18%
> ra_hit_rate            89%       97%       90%       40%       83%       76%        0%       49%        0%
> la_hit_rate            62%       99%       88%       29%       84%     9500%        0%      200%     3700%
> var_ra_size            703         4      8064        39      5780         3         0        59      3010
> avg_ra_size              6         2        67         6        33         2         0         4        36
> avg_la_size             37         1        96         4        45         0         0         0         0
> 
> Are the 9500%, 200%, and 3700% numbers in la_hit_rate related to reality
> in any way, or is something b0rken?

It's ok. They are computed from the following lines:
> lookahead             1972       153       671      1050        98         0         0         0         0
> lookahead_hit         1241       152       596       312        84        95         0         2        37
Here 'lookahead_hit' can somehow be greater than 'lookahead', which means
'cache hit' happened. i.e. the new readahead request overlapped with
some previous ones, and the 'lookahead_hit' is counted into the wrong
place. The 'cache hit' can also make the 'readahead_hit' larger or smaller.

This kind of mistakes can happen randomly because the accounting
mechanism is simple and supposed to work in normal. However there's no
guarantee of exact accurate - or the overhead will be unacceptable.

> And is there any documentation on what these mean, so you can tell if it's

This code snip helps a bit understanding:

/* Read-ahead events to be accounted. */
enum ra_event {
        RA_EVENT_CACHE_MISS,            /* read cache misses */
        RA_EVENT_RANDOM_READ,           /* random reads */
        RA_EVENT_IO_CONGESTION,         /* i/o congestion */
        RA_EVENT_IO_CACHE_HIT,          /* canceled i/o due to cache hit */
        RA_EVENT_IO_BLOCK,              /* wait for i/o completion */

        RA_EVENT_READAHEAD,             /* read-ahead issued */
        RA_EVENT_READAHEAD_HIT,         /* read-ahead page hit */
        RA_EVENT_LOOKAHEAD,             /* look-ahead issued */
        RA_EVENT_LOOKAHEAD_HIT,         /* look-ahead mark hit */
        RA_EVENT_LOOKAHEAD_NOACTION,    /* look-ahead mark ignored */
        RA_EVENT_READAHEAD_MMAP,        /* read-ahead for mmap access */
        RA_EVENT_READAHEAD_EOF,         /* read-ahead reaches EOF */
        RA_EVENT_READAHEAD_SHRINK,      /* ra_size falls under previous la_size */
        RA_EVENT_READAHEAD_THRASHING,   /* read-ahead thrashing happened */
        RA_EVENT_READAHEAD_MUTILATE,    /* read-ahead mutilated by imbalanced aging */
        RA_EVENT_READAHEAD_RESCUE,      /* read-ahead rescued */

        RA_EVENT_READAHEAD_CUBE,
        RA_EVENT_COUNT
};

> doing anything useful? (One thing I've noticed is that xmms, rather than gobble
> up 100K of data off disk every 10 seconds or so, snarfs a big 2M chunk every
> 3-4 minutes, often sucking in an entire song at (nearly) one shot...)

Hehe, it's resulted from the enlarged default max readahead size(128K => 1M).
Too much aggressive? I'm interesting to know the recommended size for
desktops, thanks. For now you can adjust it through the 'blockdev
--setra /dev/hda' command.

Wu
--

> (Complete contents of readahead/events follows, in case it helps diagnose...)
> 
> [table requests]     total   initial     state   context  contexta  backward  onthrash    onseek      none
> cache_miss            3934       543        93      2013        39      1199         0        47       417
> random_read           1772        59        49      1059        11       575         0        19       327
> io_congestion            4         0         4         0         0         0         0         0         0
> io_cache_hit          1082         1        63       855        14       144         0         5         0
> io_block             26320     18973      3519      2225       265      1288         0        50      1371
> readahead            18601     15540      1008      1203       110       710         0        30      1483
> lookahead             1972       153       671      1050        98         0         0         0         0
> lookahead_hit         1241       152       596       312        84        95         0         2        37
> lookahead_ignore         0         0         0         0         0         0         0         0         0
> readahead_mmap           0         0         0         0         0         0         0         0         0
> readahead_eof        14951     14348       569        19        15         0         0         0         0
> readahead_shrink         0         0         0         0         0         0         0         0        70
> readahead_thrash         0         0         0         0         0         0         0         0         0
> readahead_mutilt         0         0         0         0         0         0         0         0         0
> readahead_rescue         0         0         0         0         0         0         0         0       138
> 
> [table pages]        total   initial     state   context  contexta  backward  onthrash    onseek      none
> cache_miss            6541      2472       754      2026        43      1199         0        47      1194
> random_read           1784        62        51      1065        12       575         0        19       337
> io_congestion          396         0       396         0         0         0         0         0         0
> io_cache_hit         10185         2       571      7930      1383       293         0         6         0
> readahead           111015     30757     67949      6864      3642      1681         0       122     53677
> readahead_hit        98812     30052     61602      2762      3041      1294         0        61       277
> lookahead            72607       185     64222      3734      4466         0         0         0         0
> lookahead_hit        68640       184     59207      4475      4774         0         0         0         0
> lookahead_ignore         0         0         0         0         0         0         0         0         0
> readahead_mmap           0         0         0         0         0         0         0         0         0
> readahead_eof        39959     25045     14102        64       748         0         0         0         0
> readahead_shrink         0         0         0         0         0         0         0         0      1076
> readahead_thrash         0         0         0         0         0         0         0         0         0
> readahead_mutilt         0         0         0         0         0         0         0         0         0
> readahead_rescue         0         0         0         0         0         0         0         0      9538
> 
> [table summary]      total   initial     state   context  contexta  backward  onthrash    onseek      none
> random_rate             8%        0%        4%       46%        9%       44%        0%       38%       18%
> ra_hit_rate            89%       97%       90%       40%       83%       76%        0%       49%        0%
> la_hit_rate            62%       99%       88%       29%       84%     9500%        0%      200%     3700%
> var_ra_size            703         4      8064        39      5780         3         0        59      3010
> avg_ra_size              6         2        67         6        33         2         0         4        36
> avg_la_size             37         1        96         4        45         0         0         0         0
> 


