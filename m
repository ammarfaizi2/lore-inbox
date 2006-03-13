Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751514AbWCMQxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbWCMQxU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 11:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWCMQxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 11:53:20 -0500
Received: from silver.veritas.com ([143.127.12.111]:22839 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751514AbWCMQxU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 11:53:20 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.02,187,1139212800"; 
   d="scan'208"; a="35806266:sNHT24373836"
Date: Mon, 13 Mar 2006 16:52:53 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Akinobu Mita <mita@miraclelinux.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] fix swap cluster offset
In-Reply-To: <20060312043450.GA7088@miraclelinux.com>
Message-ID: <Pine.LNX.4.61.0603131632300.9207@goblin.wat.veritas.com>
References: <20060312043450.GA7088@miraclelinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Mar 2006 16:52:05.0013 (UTC) FILETIME=[752B2450:01C646BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Mar 2006, Akinobu Mita wrote:

> When we've allocated SWAPFILE_CLUSTER pages, ->cluster_next should
> be the first index of swap cluster. But current code probably sets it
> wrong offset.
> 
> Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

Acked-by: Hugh Dickins <hugh@veritas.com>

Very good eye!  My shame.
No need to say "probably" above, it was simply wrong.

By a stroke of luck, it's no worse than a slight inefficiency in an
algorithm only used when we're already going slow; but (if offset had
been signed, or not checked against highest_bit for unrelated reasons)
it could very easily have tried to access and modify swap_map[-1].

Anyway, thanks for catching that:
Andrew, please apply (but not desperate for 2.6.16).

Hugh

> Index: work/mm/swapfile.c
> ===================================================================
> --- work.orig/mm/swapfile.c
> +++ work/mm/swapfile.c
> @@ -116,7 +116,7 @@ static inline unsigned long scan_swap_ma
>  				last_in_cluster = offset + SWAPFILE_CLUSTER;
>  			else if (offset == last_in_cluster) {
>  				spin_lock(&swap_lock);
> -				si->cluster_next = offset-SWAPFILE_CLUSTER-1;
> +				si->cluster_next = offset-SWAPFILE_CLUSTER+1;
>  				goto cluster;
>  			}
>  			if (unlikely(--latency_ration < 0)) {
