Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263604AbUDMQwL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 12:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263613AbUDMQwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 12:52:11 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.145]:6407 "EHLO
	hqemgate02.nvidia.com") by vger.kernel.org with ESMTP
	id S263604AbUDMQwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 12:52:07 -0400
Date: Tue, 13 Apr 2004 11:50:47 -0500
From: Terence Ripperda <tripperda@nvidia.com>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Terence Ripperda <tripperda@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PAT support
Message-ID: <20040413165046.GD453@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
References: <4680790.1081848973@42.150.104.212.access.eclipse.net.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4680790.1081848973@42.150.104.212.access.eclipse.net.uk>
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.4.23
X-OriginalArrivalTime: 13 Apr 2004 16:51:48.0148 (UTC) FILETIME=[9C5E7F40:01C42177]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2004 at 01:36:13AM -0700, apw@shadowen.org wrote:
> But I did notice there appear to be no notes or
> warnings on the issues of using PAT based mappings.  Cirtainly there are
> some _very_ onerus restrictions which I have personally tested and found to
> be true :(.  Perhaps we could get some big fat warning style comments.

where would you like to see such warnings? arguably, all of the dangerous conditions should be handled by this core code to avoid problems (such as only using the first 4 pat entries, flushing the correct caches when updating the pat entries or pte bits). these problems really aren't all that different than any other cache aliasing/pte flushing issues that always exist, right?

> + * According to the INTEL documentation it is the systems responsibility
> + * to ensure that the PAT registers are kept in agreement on all processors
> + * in a system.  Changing these registers must occu in a manner which
> + * maintains the consistency of the processor caches and translation
> + * lookaside buggers (TLB). 

absolutely. I tried to handle this by initializing the pat entries as each cpu comes online at boot time, with cache flushes. I think Andi mentioned flushing the TLBs as well, I'll check up on that to make sure I'm doing that as well.
 
> Also, I have confirmed that if you have any Intel processors which do not
> have the SS (Self Snoop) capability, you cannot have two independent
> mappings to a page with different cache attributes.  I have been hit by
> this and you get stale data returned from the cache.

certainly, that is more or less what this mechanism is intended to prevent. cmap_compare_cachings is an arch-dependent function, which allows architectures to allow/disallow different cache attributes. I certainly consider the current implementation to be a sample that needs some tweaking. for example, I forgot that I had allowed CACHED/NOCACHED overlaps, due to MTRRs that legally overlap like this. but that's probably not a situation we want for any other case, so I need to fix that.

Thanks,
Terence
