Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266198AbUG0BtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266198AbUG0BtU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 21:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266210AbUG0BtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 21:49:20 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:37283 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266198AbUG0BtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 21:49:18 -0400
Date: Mon, 26 Jul 2004 20:47:57 -0500
From: Dimitri Sivanich <sivanich@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] Locking optimization for cache_reap
Message-ID: <20040727014757.GA23937@sgi.com>
References: <20040723190555.GB16956@sgi.com> <20040726180104.62c480c6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040726180104.62c480c6.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 06:01:04PM -0700, Andrew Morton wrote:
> Dimitri Sivanich <sivanich@sgi.com> wrote:
> >
> > Here is another cache_reap optimization that reduces latency when
> > applied after the 'Move cache_reap out of timer context' patch I
> > submitted on 7/14 (for inclusion in -mm next week).
> > 
> > This applies to 2.6.8-rc2 + the above mentioned patch.
> 
> How does it "reduce latency"?
> 
> It looks like a reasonable cleanup, but afaict it will result in the
> per-cache spinlock actually being held for longer periods, thus increasing
> latencies???
> 

While you've got irq's disabled, drain_array() (the function my patch removes)
acquires the cache spin_lock, then releases it.  Cache_reap then acquires
it again (with irq's having been off the entire time).  My testing has found
that simply acquiring the lock once while irq's are off results in fewer
excessively long latencies.

Results probably vary somewhat depending on the circumstance.
