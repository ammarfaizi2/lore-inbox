Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267577AbSLFIp0>; Fri, 6 Dec 2002 03:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267578AbSLFIp0>; Fri, 6 Dec 2002 03:45:26 -0500
Received: from holomorphy.com ([66.224.33.161]:27022 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267577AbSLFIp0>;
	Fri, 6 Dec 2002 03:45:26 -0500
Date: Fri, 6 Dec 2002 00:52:52 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.50-bk5-wli-1
Message-ID: <20021206085252.GO9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20021206080009.GB11023@holomorphy.com> <3DF05EA7.4BDCBFF0@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF05EA7.4BDCBFF0@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> 2.5.50-wli-bk5-12 resize inode cache wait table -- 8 is too small

On Fri, Dec 06, 2002 at 12:24:07AM -0800, Andrew Morton wrote:
> Heh.  I decided to make that really, really, really tiny in the expectation
> that if it was _too_ small, someone would notice.
> For what workload is the 8 too small, and what is the call path
> of the waiters?
> (If it is `tiobench 100000000' and the wait is in __writeback_single_inode(),
> then we should probably just return from there if !sync and the inode is locked)

This is actually the result of quite a bit of handwaving; in the OOM-
handling series of patches with the GFP_NOKILL business, I found that
tasks would block exessively in wait_on_inode() (which was tiobench
16384). The qualitative evidence points toward the inode table as a
potential bottleneck in the presence of many tasks and/or cpus. No
specific benchmark numbers apply; in the original series (GFP_NOKILL),
I increased this to much larger than 256. The entire summary of results
of that series of patches was "highmem drops dead under load". But
performance benefits from this minor increase in size should be obvious.

Bill
