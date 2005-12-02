Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932712AbVLBBbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932712AbVLBBbA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 20:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932713AbVLBBbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 20:31:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53922 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932712AbVLBBa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 20:30:59 -0500
Date: Thu, 1 Dec 2005 17:30:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       christoph@lameter.com, riel@redhat.com, a.p.zijlstra@chello.nl,
       npiggin@suse.de, andrea@suse.de, magnus.damm@gmail.com
Subject: Re: [PATCH 02/12] mm: supporting variables and functions for
 balanced zone aging
Message-Id: <20051201173015.675f4d80.akpm@osdl.org>
In-Reply-To: <20051202011924.GA3516@mail.ustc.edu.cn>
References: <20051201101810.837245000@localhost.localdomain>
	<20051201101933.936973000@localhost.localdomain>
	<20051201023714.612f0bbf.akpm@osdl.org>
	<20051201222846.GA3646@dmt.cnet>
	<20051201150349.3538638e.akpm@osdl.org>
	<20051202011924.GA3516@mail.ustc.edu.cn>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
>
>    850         sc->nr_to_reclaim = sc->swap_cluster_max;
>      851         
>      852         while (nr_active || nr_inactive) {
>                          //...
>      860                 if (nr_inactive) {
>      861                         sc->nr_to_scan = min(nr_inactive,
>      862                                         (unsigned long)sc->swap_cluster_max);
>      863                         nr_inactive -= sc->nr_to_scan;
>      864                         shrink_cache(zone, sc);
>      865                         if (sc->nr_to_reclaim <= 0)
>      866                                 break;
>      867                 }
>      868         }
> 
>  Line 843 is the core of the scan balancing logic:
> 
>  priority                12      11      10
> 
>  On each call nr_scan_inactive is increased by:
>  DMA(2k pages)           +1      +2      +3
>  Normal(64k pages)      +17      +33     +65 
> 
>  Round it up to SWAP_CLUSTER_MAX=32, we get (scan batches/accumulate rounds):
>  DMA                     1/32    1/16    2/11
>  Normal                  2/2     2/1     3/1
>  DMA:Normal ratio        1:32    1:32    2:33
> 
>  This keeps the scan rate roughly balanced(i.e. 1:32) in low vm pressure.
> 
>  But lines 865-866 together with line 846 make most shrink_zone() invocations
>  only run one batch of scan. The numbers become:

True.  Need to go into a huddle with the changelogs, but I have a feeling
that lines 865 and 866 aren't very important.  What happens if we remove
them?
