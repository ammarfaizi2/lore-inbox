Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261771AbRGCJiu>; Tue, 3 Jul 2001 05:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265682AbRGCJik>; Tue, 3 Jul 2001 05:38:40 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:65515 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265681AbRGCJiW>; Tue, 3 Jul 2001 05:38:22 -0400
Date: Tue, 3 Jul 2001 10:38:09 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: michaelc <michaelc@turbolinux.com.cn>
Cc: linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: about kmap_high function
Message-ID: <20010703103809.A29868@redhat.com>
In-Reply-To: <3620762046.20010629150601@turbolinux.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3620762046.20010629150601@turbolinux.com.cn>; from michaelc@turbolinux.com.cn on Fri, Jun 29, 2001 at 03:06:01PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 29, 2001 at 03:06:01PM +0800, michaelc wrote:
>     I found that the kmap_high function didn't call __flush_tlb_one()
> when it mapped a highmem page sucessfully, and I think it maybe
> cause the problem that TLB may store obslete page table entries, but
> the kmap_atomic() function do call the __flush_tlb_one(), someone tell
> me what's the differenc between the kmap_atomic and kmap_high except
> that kmap_atomic can be used in IRQ contexts. I appreciate in advance.

kmap_high is intended to be called routinely for access to highmem
pages.  It is coded to be as fast as possible as a result.  TLB
flushes are expensive, especially on SMP, so kmap_high tries hard to
avoid unnecessary flushes.

The way it does it is to do only a single, complete TLB flush of the
whole kmap VA range once every time the kmap address ring cycles.
That's what flush_all_zero_pkmaps() does --- it evicts old, unused
kmap mappings and flushes the whole TLB range, so that we are
guaranteed that there is a TLB flush between any two different uses of
any given kmap virtual address.

That way, we can avoid the cost of having to flush the TLB for every
single kmap mapping we create.

Cheers,
 Stephen
