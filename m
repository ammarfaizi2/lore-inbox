Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281277AbRKVSso>; Thu, 22 Nov 2001 13:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281323AbRKVSsf>; Thu, 22 Nov 2001 13:48:35 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:60792 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S281277AbRKVSsW>; Thu, 22 Nov 2001 13:48:22 -0500
Date: Thu, 22 Nov 2001 19:48:28 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] flush_icache_user_range
Message-ID: <20011122194828.N1338@athlon.random>
In-Reply-To: <15356.58612.264155.733585@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <15356.58612.264155.733585@cargo.ozlabs.ibm.com>; from paulus@samba.org on Thu, Nov 22, 2001 at 10:43:48PM +1100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2001 at 10:43:48PM +1100, Paul Mackerras wrote:
> The patch below changes access_one_page in kernel/ptrace.c to use a
> new function, flush_icache_user_range, instead of flush_icache_page as
> at present.  The reason for making this change is that
> flush_icache_page is also called in do_no_page and do_swap_page, where
> it does a fundamentally different job.  Decoupling the two makes it
> possible to improve performance, because we can make flush_icache_page
> do the flush only when needed.
> 
> This patch particularly affects alpha: for alpha I renamed the
> existing flush_icache_page to flush_icache_user_range and made
> flush_icache_page a no-op.  This is based on a suggestion from
> Andrea and the comments in the code.  I would be very interested to
> hear how it affects alpha as regards stability and performance.
> 
> For PPC, I have added a flush_icache_user_range that only flushes the
> cachelines that have been modified.  I have a more extensive
> cache-flush avoidance patch in the works that depends on this one and
> also needs modifications to clear_user_page and copy_user_page.  This
> all gives us a substantial performance increase on PPC.
> 
> For all the other architectures I have made flush_icache_user_range
> the same as flush_icache_page, i.e. a no-op for most architectures.
> So this patch should have zero impact except on alpha and PPC, and on
> alpha it should improve performance.
> 
> Note that flush_icache_user_range is different from flush_icache_page
> now in that flush_icache_user_range is only called when the page has
> been modified, so we know we do have to flush (if the icache doesn't
> snoop stores by the cpu).  In contrast, flush_icache_page is called in
> situations where the page often (usually?) is unmodified, so it makes
> sense to try to work out whether the flush is actually needed.
> 
> Comments?  Linus, would you be willing to apply this?

I will try to give it a spin, it should be a very nice speedup for
alpha, we were wasting an huge amount of asn (and possibly of IPI too
with threads) during major faults and this will optimize it away.
thanks,

Andrea
