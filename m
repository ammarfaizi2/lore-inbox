Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWCTN0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWCTN0h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbWCTN0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:26:37 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:19354 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S964774AbWCTN0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:26:36 -0500
Date: Mon, 20 Mar 2006 21:31:47 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH 07/23] readahead: insert cond_resched() calls
Message-ID: <20060320133147.GA5150@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>
References: <20060319023413.305977000@localhost.localdomain> <20060319023451.808130000@localhost.localdomain> <1142740242.4532.1.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142740242.4532.1.camel@mindpipe>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2006 at 10:50:42PM -0500, Lee Revell wrote:
> On Sun, 2006-03-19 at 10:34 +0800, Wu Fengguang wrote:
> > Since the VM_MAX_READAHEAD is greatly enlarged and the algorithm become more
> > complex, it becomes necessary to insert some cond_resched() calls in the
> > read-ahead path.
> 
> Do you have any numbers on this (say, from Ingo's latency tracer)?  Have
> you confirmed it's not a latency regression with the default settings?

Now I have some from Ingo's latency tracer. When doing 1M sized readaheads,
the original kernel have ~5ms latency. This patch reduced that number to ~1ms.

The trace data are collected on the following command:
        cp 3G_sparse_file /dev/null

The resulted maximum latencies are:

wfg ~% head -n5 latency_trace1
preemption latency trace v1.1.5 on 2.6.16
--------------------------------------------------------------------
 latency: 1169 us, #319/319, CPU#0 | (M:server VP:0, KP:0, SP:0 HP:0 #P:1)
    -----------------
    | task: xmms-5077 (uid:1000 nice:0 policy:0 rt_prio:0)
wfg ~% head -n5 latency_trace2
preemption latency trace v1.1.5 on 2.6.16
--------------------------------------------------------------------
 latency: 4835 us, #14102/14102, CPU#0 | (M:server VP:0, KP:0, SP:0 HP:0 #P:1)
    -----------------
    | task: xmms-5065 (uid:1000 nice:0 policy:0 rt_prio:0)

The folloing commands show that the 4835us latency is mainly caused by
        __do_page_cache_readahead():    from 575us to 1723us
        mpage_readpages():              from 1724us to 4795us

wfg ~% grep readahead latency_trace1
wfg ~% grep readpages latency_trace1
wfg ~% grep readahead latency_trace2
      cp-5068  0dn..  575us : _read_lock_irq (__do_page_cache_readahead)
      cp-5068  0dn..  576us : radix_tree_lookup_node (__do_page_cache_readahead)
      cp-5068  0dn..  576us : _read_unlock_irq (__do_page_cache_readahead)
      cp-5068  0dn..  577us : __alloc_pages (__do_page_cache_readahead)
      cp-5068  0dn..  580us : _read_lock_irq (__do_page_cache_readahead)
      cp-5068  0dn..  580us : radix_tree_lookup_node (__do_page_cache_readahead)
      cp-5068  0dn..  581us : _read_unlock_irq (__do_page_cache_readahead)
      cp-5068  0dn..  581us : __alloc_pages (__do_page_cache_readahead)
      cp-5068  0dn..  583us : _read_lock_irq (__do_page_cache_readahead)
......[899 LINES SKIPPED]
      cp-5068  0dn.. 1712us : radix_tree_lookup_node (__do_page_cache_readahead)
      cp-5068  0dn.. 1712us : _read_unlock_irq (__do_page_cache_readahead)
      cp-5068  0dn.. 1713us : __alloc_pages (__do_page_cache_readahead)
      cp-5068  0dn.. 1715us : _read_lock_irq (__do_page_cache_readahead)
      cp-5068  0dn.. 1716us : radix_tree_lookup_node (__do_page_cache_readahead)
      cp-5068  0dn.. 1716us : _read_unlock_irq (__do_page_cache_readahead)
      cp-5068  0dn.. 1716us : __alloc_pages (__do_page_cache_readahead)
      cp-5068  0dn.. 1719us : _read_lock_irq (__do_page_cache_readahead)
      cp-5068  0dn.. 1719us : radix_tree_lookup_node (__do_page_cache_readahead)
      cp-5068  0dn.. 1719us : _read_unlock_irq (__do_page_cache_readahead)
      cp-5068  0dn.. 1720us : __alloc_pages (__do_page_cache_readahead)
      cp-5068  0dn.. 1722us : _read_lock_irq (__do_page_cache_readahead)
      cp-5068  0dn.. 1723us : _read_unlock_irq (__do_page_cache_readahead)
      cp-5068  0dn.. 1723us : read_pages (__do_page_cache_readahead)
      cp-5068  0dn.. 4800us : readahead_cache_hit (do_generic_mapping_read)
wfg ~% grep readpages latency_trace2
      cp-5068  0dn.. 1724us : ext3_readpages (read_pages)
      cp-5068  0dn.. 1724us : mpage_readpages (ext3_readpages)
      cp-5068  0dn.. 1725us : add_to_page_cache (mpage_readpages)
      cp-5068  0dn.. 1728us : do_mpage_readpage (mpage_readpages)
      cp-5068  0dn.. 1742us : add_to_page_cache (mpage_readpages)
      cp-5068  0dn.. 1744us : do_mpage_readpage (mpage_readpages)
      cp-5068  0dn.. 1753us : add_to_page_cache (mpage_readpages)
      cp-5068  0dn.. 1755us : do_mpage_readpage (mpage_readpages)
      cp-5068  0dn.. 1764us : add_to_page_cache (mpage_readpages)
......[508 LINES SKIPPED]
      cp-5068  0dn.. 4716us : do_mpage_readpage (mpage_readpages)
      cp-5068  0dn.. 4726us : add_to_page_cache (mpage_readpages)
      cp-5068  0dn.. 4728us : do_mpage_readpage (mpage_readpages)
      cp-5068  0dn.. 4737us : add_to_page_cache (mpage_readpages)
      cp-5068  0dn.. 4739us : do_mpage_readpage (mpage_readpages)
      cp-5068  0dn.. 4748us : __pagevec_lru_add (mpage_readpages)
      cp-5068  0dn.. 4750us : add_to_page_cache (mpage_readpages)
      cp-5068  0dn.. 4752us : do_mpage_readpage (mpage_readpages)
      cp-5068  0dn.. 4761us : add_to_page_cache (mpage_readpages)
      cp-5068  0dn.. 4763us : do_mpage_readpage (mpage_readpages)
      cp-5068  0dn.. 4772us : add_to_page_cache (mpage_readpages)
      cp-5068  0dn.. 4774us : do_mpage_readpage (mpage_readpages)
      cp-5068  0dn.. 4784us : add_to_page_cache (mpage_readpages)
      cp-5068  0dn.. 4785us : do_mpage_readpage (mpage_readpages)
      cp-5068  0dn.. 4795us : __pagevec_lru_add (mpage_readpages)

Cheers,
Wu
