Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263811AbSIQHZ7>; Tue, 17 Sep 2002 03:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263870AbSIQHZ7>; Tue, 17 Sep 2002 03:25:59 -0400
Received: from holomorphy.com ([66.224.33.161]:27875 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263811AbSIQHZ5>;
	Tue, 17 Sep 2002 03:25:57 -0400
Date: Tue, 17 Sep 2002 00:27:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: dbench on tmpfs OOM's
Message-ID: <20020917072716.GN3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <3D86BE4F.75C9B6CC@digeo.com> <Pine.LNX.4.44.0209170726050.19523-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209170726050.19523-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2002 at 08:01:20AM +0100, Hugh Dickins wrote:
> shmem uses GFP_USER for its index pages to GFP_HIGHUSER data pages.
> Not to say there aren't other problems in the mix too, but Bill's
> main problem here will be one you discovered a while ago, Andrew.
> We fixed it then, but in my loopable tmpfs version, and I've been
> slow to extract the fixes and push them to mainline (or now -mm),
> since there's not much else that suffers than dbench.
> The problem is that dbench likes to do large random(?) seeks and
> then writes at resulting offset; and although shmem-tmpfs imposes
> a cap (default: half of memory) on the data pages, it imposes no
> cap on its index pages.  So it foolishly ends up filling normal
> zone with empty index blocks for zero-length files, the index
> page allocation being done _before_ the data cap check.

The extreme configurations of my machines put a great deal of stress on
many codepaths. It shouldn't be regarded as any great failing that some
corrections are required to function properly on them, as the visibility
given to highmem-related pressures is far, far greater than seen elsewhere.

One thing to bear in mind is that though the kernel may be functioning
correctly in refusing the requests made, the additional functionality
of being capable of servicing them would be much appreciated and likely
to be of good use for the machines in the field we serve. Although from
your general stance on things, it seems I've little to convince you of.


On Tue, Sep 17, 2002 at 08:01:20AM +0100, Hugh Dickins wrote:
> I'll rebase the relevant fixes against 2.5.35-mm1 later today,
> do a little testing and post the patch.
> What I never did was try GFP_HIGHUSER and kmap on the index pages:
> I think I decided back then that it wasn't likely to be needed
> (sparsely filled file indexes are a rarer case than sparsely filled
> pagetables, once the stupidity is fixed; and small files don't use
> index pages at all).  But Bill's testing may well prove me wrong.

I suspected you may well have plots here, as you have often before,
so I held off on brewing up attempts at such myself until you replied.
I'll defer to you.


Thanks,
Bill

P.S.:

The original intent of this testing was to obtain a profile of "best
case" behavior not limited by throttling within the block layer. The
method was derived from the observation that though the test on-disk
was seek-bound according to the block layer, as the test was configured,
it should have been able to have been carried out in-core. Carrying out
the test on tmpfs was the method chosen to eliminate the block throttling.

Whatever kind of additional stress-testing and optimization you have an
interest in enabling tmpfs for I'd be at least moderately interested in
providing, as I've some interest in using tmpfs to assist with
generalized large page support within the core kernel.
