Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbVLGBS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbVLGBS5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 20:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbVLGBS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 20:18:57 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:2025 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S964841AbVLGBS5 (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Tue, 6 Dec 2005 20:18:57 -0500
Date: Wed, 7 Dec 2005 09:42:35 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH 01/16] mm: delayed page activation
Message-ID: <20051207014235.GA5186@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Nikita Danilov <nikita@clusterfs.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
References: <20051203071444.260068000@localhost.localdomain> <20051203071609.755741000@localhost.localdomain> <17298.56560.78408.693927@gargle.gargle.HOWL> <20051204134818.GA4305@mail.ustc.edu.cn> <17299.1331.368159.374754@gargle.gargle.HOWL> <20051205014842.GA5103@mail.ustc.edu.cn> <17301.53377.614777.913013@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17301.53377.614777.913013@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 08:55:13PM +0300, Nikita Danilov wrote:
> Wu Fengguang writes:
>  > On Sun, Dec 04, 2005 at 06:03:15PM +0300, Nikita Danilov wrote:
>  > >  > inter-reference distance, and therefore should be better protected(if ignore
>  > >  > possible read-ahead effects). If we move re-accessed pages immediately into
>  > >  > active_list, we are pushing them closer to danger of eviction.
>  > > 
>  > > Huh? Pages in the active list are closer to the eviction? If it is
>  > > really so, then CLOCK-pro hijacks the meaning of active list in a very
>  > > unintuitive way. In the current MM active list is supposed to contain
>  > > hot pages that will be evicted last.
>  > 
>  > The page is going to active list anyway. So its remaining lifetime in inactive
>  > list is killed by the early move.
> 
> But this change increased lifetimes of _all_ pages, so this is

Yes, it also increased the lifetimes by meaningful values: first re-accessed
pages are prolonged more lifetime. Immediately removing them from inactive_list 
is basicly doing MRU eviction.

> irrelevant. Consequently, it has a chance of increasing scanning
> activity, because there will be more referenced pages at the cold tail
> of the inactive list.

Delayed activation increased scanning activity, while immediate activation
increased the locking activity. Early profiling data on a 2 CPU Xeon box showed
that the delayed activation acctually cost less time.

> And --again-- this erases information about relative order of
> references, and this is important. In the past, several VM modifications
> (like split inactive_clean and inactive_dirty lists) were tried that had
> various advantages over current scanner, but maintained weaker LRU, and
> they all were found to degrade horribly under certain easy triggerable
> conditions.

Yeah, the patch does need more testing. 
It has been in -ck tree for a while, and there's no negative report about it.

Andrew, and anyone in the lkml, do you feel ok to test it in -mm tree?
It is there because some readahead code test the PG_actvation bit explicitly.
If the answer is 'not for now', I'll strip it out from the readahead patchset
in the next version.

Thanks,
Wu
