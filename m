Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271808AbRICUld>; Mon, 3 Sep 2001 16:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271806AbRICUlX>; Mon, 3 Sep 2001 16:41:23 -0400
Received: from are.twiddle.net ([64.81.246.98]:39812 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S271808AbRICUlI>;
	Mon, 3 Sep 2001 16:41:08 -0400
Date: Mon, 3 Sep 2001 13:41:25 -0700
From: Richard Henderson <rth@twiddle.net>
To: David Mosberger <davidm@hpl.hp.com>
Cc: Paul Mackerras <paulus@samba.org>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [PATCH] avoid unnecessary cache flushes
Message-ID: <20010903134125.B16069@twiddle.net>
Mail-Followup-To: David Mosberger <davidm@hpl.hp.com>,
	Paul Mackerras <paulus@samba.org>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, davem@redhat.com
In-Reply-To: <15247.29338.3671.548678@cargo.ozlabs.ibm.com> <20010903131436.A16069@twiddle.net> <15251.59286.154267.431231@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15251.59286.154267.431231@napali.hpl.hp.com>; from davidm@hpl.hp.com on Mon, Sep 03, 2001 at 01:27:02PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2001 at 01:27:02PM -0700, David Mosberger wrote:
>   >> +		if (!test_bit(PG_arch_1, &page->flags)) {
>   >> +			__flush_dcache_icache((unsigned long)kmap(page));
>   >> +			kunmap(page);
>   >> +			set_bit(PG_arch_1, &page->flags);
> 
>   Richard> Race.  Use test_and_set_bit.
> 
> Nope, the old code is correct: you must turn on PG_arch_1 *after*
> flushing the cache.  Yes, you might sometimes double flush, but that's
> both safe and rare.

You can get a missed flush from

	bit == 0
	flush cache

				modify page
				bit = 0

	bit = 1

unless this is protected from some outer lock of which 
I am not aware.

I do see your point about the early set though.


r~
