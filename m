Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263652AbTDTSNV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 14:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263655AbTDTSNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 14:13:21 -0400
Received: from adsl-66-120-100-11.dsl.sndg02.pacbell.net ([66.120.100.11]:24334
	"HELO glacier.arctrix.com") by vger.kernel.org with SMTP
	id S263652AbTDTSNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 14:13:18 -0400
Date: Sun, 20 Apr 2003 11:26:48 -0700
From: Neil Schemenauer <nas@python.ca>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][CFT] new IO scheduler for 2.4.20
Message-ID: <20030420182648.GA18120@glacier.arctrix.com>
References: <20030417172818.GA8848@glacier.arctrix.com> <20030417134103.4e69fc1b.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030417134103.4e69fc1b.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> One suggestion I'd make here is to not count "sectors" at all.  Just
> count requests.
[...]
> I'd be interested in seeing some comparative benchmark results with
> the above DoS attack.  And contest numbers too...

Okay, nas1 is the patch I orginally posted.  With nas2, I am counting
requests instead of sectors.  The times below are for the find/cat
command to complete while the dd command is running.

            time
    2.4.20  ????????? (I gave up after about 15 minutes)
    -nas1   1m56.746s
    -nas2   2m36.928s

Here's the contest results:

    no_load:
    Kernel      [runs]	Time	CPU%	Loads	LCPU%	Ratio
    2.4.20           1	50	90.0	0.0	0.0	1.00
    2.4.20-nas1      1	50	90.0	0.0	0.0	1.00
    2.4.20-nas2      1	50	92.0	0.0	0.0	1.00
    cacherun:
    Kernel      [runs]	Time	CPU%	Loads	LCPU%	Ratio
    2.4.20           1	46	97.8	0.0	0.0	0.92
    2.4.20-nas1      1	46	97.8	0.0	0.0	0.92
    2.4.20-nas2      1	46	97.8	0.0	0.0	0.92
    process_load:
    Kernel      [runs]	Time	CPU%	Loads	LCPU%	Ratio
    2.4.20           1	74	58.1	70.0	40.5	1.48
    2.4.20-nas1      1	75	57.3	73.0	40.0	1.50
    2.4.20-nas2      1	76	56.6	76.0	40.8	1.52
    ctar_load:
    Kernel      [runs]	Time	CPU%	Loads	LCPU%	Ratio
    2.4.20           1	60	78.3	9.0	16.7	1.20
    2.4.20-nas1      1	58	81.0	8.0	13.8	1.16
    2.4.20-nas2      1	60	78.3	9.0	16.7	1.20
    xtar_load:
    Kernel      [runs]	Time	CPU%	Loads	LCPU%	Ratio
    2.4.20           1	139	34.5	6.0	7.9	2.78
    2.4.20-nas1      1	71	64.8	2.0	4.2	1.42
    2.4.20-nas2      1	71	66.2	1.0	4.2	1.42
    io_load:
    Kernel      [runs]	Time	CPU%	Loads	LCPU%	Ratio
    2.4.20           1	191	27.7	42.1	13.1	3.82
    2.4.20-nas1      1	71	71.8	12.1	8.5	1.42
    2.4.20-nas2      1	76	69.7	12.3	9.1	1.52
    io_other:
    Kernel      [runs]	Time	CPU%	Loads	LCPU%	Ratio
    2.4.20           1	97	55.7	21.5	12.4	1.94
    2.4.20-nas1      1	65	80.0	12.3	9.0	1.30
    2.4.20-nas2      1	68	79.4	15.5	11.8	1.36
    read_load:
    Kernel      [runs]	Time	CPU%	Loads	LCPU%	Ratio
    2.4.20           1	75	73.3	3.6	9.3	1.50
    2.4.20-nas1      1	75	70.7	3.4	9.3	1.50
    2.4.20-nas2      1	79	69.6	3.7	8.9	1.58
    list_load:
    Kernel      [runs]	Time	CPU%	Loads	LCPU%	Ratio
    2.4.20           1	66	89.4	0.0	7.5	1.32
    2.4.20-nas1      1	66	87.9	0.0	7.6	1.32
    2.4.20-nas2      1	66	87.9	0.0	7.6	1.32
    mem_load:
    Kernel      [runs]	Time	CPU%	Loads	LCPU%	Ratio
    2.4.20           1	78	62.8	77.0	3.8	1.56
    2.4.20-nas1      1	70	68.6	77.0	5.7	1.40
    2.4.20-nas2      1	68	72.1	75.0	5.9	1.36
    dbench_load:
    Kernel      [runs]	Time	CPU%	Loads	LCPU%	Ratio
    2.4.20           1	202	23.8	6.0	60.4	4.04
    2.4.20-nas1      1	194	24.2	6.0	63.4	3.88
    2.4.20-nas2      1	194	24.2	6.0	63.4	3.88

It looks like nas1 works a little better.  I think the reason is that if
requests are counted then as soon as there is one read in queue, however
small, the next non-contiguous read request will be inserted after a
write request, however large.

  Neil
