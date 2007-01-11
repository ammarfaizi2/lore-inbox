Return-Path: <linux-kernel-owner+w=401wt.eu-S965307AbXAKGpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965307AbXAKGpP (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 01:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965303AbXAKGpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 01:45:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:51396 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965302AbXAKGpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 01:45:13 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BP/93REsAKMQMdCoX/1ukYdAVAiwkwNMt+JSsEjQ8zKE+tkwkdoPTPOEDp4Yqa3qdTJDorRsDcuoFX2IyXYQ4bqbCKho2RIdrErEiNzUeJrKCxAYakbhqzLTagsKGYcQGu0+5MQm38SDUlXokGIZeBTXfH7vrl5tsIIT6MGSv/k=
Message-ID: <6d6a94c50701102245g6afe6aacxfcb2136baee5cbfa@mail.gmail.com>
Date: Thu, 11 Jan 2007 14:45:12 +0800
From: Aubrey <aubreylee@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: O_DIRECT question
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Hua Zhong" <hzhong@gmail.com>,
       "Hugh Dickins" <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, mjt@tls.msk.ru
In-Reply-To: <20070110220603.f3685385.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
	 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>
	 <6d6a94c50701102150w4c3b46d0w6981267e2b873d37@mail.gmail.com>
	 <20070110220603.f3685385.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/07, Andrew Morton <akpm@osdl.org> wrote:
> On Thu, 11 Jan 2007 13:50:53 +0800
> Aubrey <aubreylee@gmail.com> wrote:
>
> > Firstly I want to say I'm working on no-mmu arch and uClinux.
> > After much of file operations VFS cache eat up all of the memory.
> > At this time, if an application request memory which order > 3, the
> > kernel will report failure.
>
> nommu kernels should probably run reclaim for higher-order allocations as
> well.

Here is the limitation. rebalance doesn't occur if order > 3.
/*
         * Don't let big-order allocations loop unless the caller explicitly
         * requests that.  Wait for some write requests to complete then retry.
         *
         * In this implementation, __GFP_REPEAT means __GFP_NOFAIL for order
         * <= 3, but that may not be true in other implementations.
         */
        do_retry = 0;
        if (!(gfp_mask & __GFP_NORETRY)) {
                if ((order <= 3) || (gfp_mask & __GFP_REPEAT))
                        do_retry = 1;
                if (gfp_mask & __GFP_NOFAIL)
                        do_retry = 1;
        }
        if (do_retry) {
                blk_congestion_wait(WRITE, HZ/50);
                goto rebalance;
        }

>
> That's rather a blunt instrument.  The "lumpy reclaim" patches in -mm
> provide a much better approach, but they need more work yet (although I
> don't immediately recall what's needed).

Thanks, I'll take a look.

>
> In the interim you could do the old "echo 3 > /proc/sys/vm/drop_caches"
> thing, but that's terribly crude - drop_caches is really only for debugging
> and benchmarking.
>
Yes. This method can drop caches, but will fragment memory. This is
not what I want. I want cache is limited to a tunable value of the
whole memory. For example, if total memory is 128M, is there a way to
trigger reclaim when cache size > 16M?

-Aubrey
