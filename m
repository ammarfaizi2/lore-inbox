Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932615AbVKBHXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932615AbVKBHXU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 02:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbVKBHXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 02:23:20 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:28326 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932615AbVKBHXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 02:23:19 -0500
Date: Wed, 2 Nov 2005 15:23:15 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Alexandre Cassen <acassen@freebox.fr>
Cc: Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, slpratt@us.ibm.com,
       Con Kolivas <kernel@kolivas.org>,
       Folkert van Heusden <folkert@vanheusden.com>
Subject: Re: [PATCH 2.6.14] Adaptive read-ahead V6
Message-ID: <20051102072315.GB4072@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Alexandre Cassen <acassen@freebox.fr>,
	Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, slpratt@us.ibm.com,
	Con Kolivas <kernel@kolivas.org>,
	Folkert van Heusden <folkert@vanheusden.com>
References: <20051101134925.GA5576@mail.ustc.edu.cn> <Pine.LNX.4.61.0511012131290.20381@lnxos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511012131290.20381@lnxos>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alexandre,

On Tue, Nov 01, 2005 at 09:55:10PM +0100, Alexandre Cassen wrote:
> I just replayed a benchmark with your new patch. You will find attached 
> new bench output.
> 
> Experiment Protocol: . 10 mpeg2 video bit/rate=3.5Mb/s ATM
>                       . around 4Mb/s ip+udp per stream
>                       . Linux Kernel 2.6.14 + your v6 patch
>                       . stored on a raid0 /dev/md0 - XFS
>                       . blockdev --setra 2048 /dev/md0
>                       . 6GB RAM + 2*GiGE NICs Trunk +
>                         2*36GB HDD on a U320 adaptec controler
>                       . R-A LOOKAHEAD_RATIO=4
>                       . ADP R-A /proc/sys/vm/readahead_ratio=200
>                       . Lauch video at true random positions
> 
> I launched 20 clients per video, say 200 streams. I collected infos during 
> around 1hours running.
> 
> Let me know if you want some more inputs.
Thanks.
> [table requests]      total    newfile      state    context   contexta   backward   onthrash   onraseek       none
> cache_miss             2847          6       1525        694          0          0          0          4        618
> read_random             295          2          3          2          0          0          0          0        288
> io_congestion             0          0          0          0          0          0          0          0          0
> io_cache_hit           7420          3       5941       1472          0          0          0          4          0
> io_block               4159        807         36       2648          0          0          0          4        664
This reflects times of IO delays. 
The main delays(2648) occur in context method, which are triggered by cache misses(2847).
The cache misses might be caused by canceled look-ahead marks due to cache hits.
I'll try fixing it.
> readahead            116568        801     113031       2731          1          0          0          4          0
> lookahead            115904        223     112954       2726          1          0          0          0          0
> lookahead_hit        113376         31     111256       2072          1          0          0          0         16
> readahead_eof           660        578         77          5          0          0          0          0          0
> readahead_shrink          0          0          0          0          0          0          0          0          0
> readahead_thrash          0          0          0          0          0          0          0          0          0
> readahead_rescue      18517          0          0          0          0          0          0          0      18517
> 
> [table pages]         total    newfile      state    context   contexta   backward   onthrash   onraseek       none
> cache_miss             5452          6       3037       1377          0          0          0          7       1025
> read_random             391          2          5          2          0          0          0          0        382
> io_congestion             0          0          0          0          0          0          0          0          0
> io_cache_hit         622587          4     386637     235281          0          0          0        665          0
> io_block             547948       1954       1443     542863          0          0          0       1024        664
> readahead          28748734       1959   28414048     332302         66          0          0        359          0
> readahead_hit      28830698       1764   28414032     412507          3          0          0        856       1536
> lookahead          29202363        448   28780361     421521         33          0          0          0          0
> lookahead_hit      28671617         64   28358286     313232         35          0          0          0          0
> readahead_eof         15225       1065      13458        702          0          0          0          0          0
> readahead_shrink          0          0          0          0          0          0          0          0          0
> readahead_thrash          0          0          0          0          0          0          0          0          0
> readahead_rescue     265680          0          0          0          0          0          0          0     265680
Your system is memory bounty and thrashing free.
The ~1G rescued pages are expected to be saved for a following reader.
> 
> [table summary]       total    newfile      state    context   contexta   backward   onthrash   onraseek       none
> random_rate              0%         0%         0%         0%         0%         0%         0%         0%        99%
> ra_hit_rate            100%        90%        99%       124%         4%         0%         0%       237%    153600%
> la_hit_rate             97%        13%        98%        75%        50%         0%         0%         0%      1600%
> avg_ra_size             247          2        251        122         33          0          0         72          0
> avg_la_size             252          2        255        155         16          0          0          0          0

Regards,
Wu Fengguang
