Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310601AbSCHAMy>; Thu, 7 Mar 2002 19:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310606AbSCHAMp>; Thu, 7 Mar 2002 19:12:45 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:24084 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S310601AbSCHAM2>; Thu, 7 Mar 2002 19:12:28 -0500
Date: Fri, 8 Mar 2002 01:11:45 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
        riel@surriel.com, hch@infradead.org, phillips@bonn-fries.net
Subject: Re: 2.4.19pre2aa1
Message-ID: <20020308011145.A1356@dualathlon.random>
In-Reply-To: <20020307092119.A25470@dualathlon.random> <20020307104942.GC786@holomorphy.com> <20020307180300.B25470@dualathlon.random> <20020307201819.GF786@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020307201819.GF786@holomorphy.com>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 12:18:19PM -0800, William Lee Irwin III wrote:
> On Thu, Mar 07, 2002 at 06:03:00PM +0100, Andrea Arcangeli wrote:
> > For the other points I think you shouldn't really complain (both at
> > runtime and in code style as well, please see how clean it is with the
> > wait_table_t thing), I made a definitive improvement to your code, the
> > only not obvious part is the hashfn but I really cannot see yours
> > beating mine because of the total random input, infact it could be the
> > other way around due the fact if something there's the probability the
> > pages are physically consecutive and I take care of that fine.
> 
> 
> I don't know whose definition of clean code this is:
> 
> +static inline wait_queue_head_t * wait_table_hashfn(struct page * page, wait_table_t * wait_table)
> +{
> +#define i (((unsigned long) page)/(sizeof(struct page) & ~ (sizeof(struct page) - 1)))
> +#define s(x) ((x)+((x)>>wait_table->shift))
> +	return wait_table->head + (s(i) & (wait_table->size-1));
> +#undef i
> +#undef s
> +}
> 
> 
> I'm not sure I want to find out.

The above is again the hashfunction, the hashfn code doesn't need to be
nice, the API around wait_table_hashfn has to instead. See the above
wait_table_t typedef.

During some further auditing I also noticed now that you introduced
a certain usused wake_up_page. That's buggy, if you use it you'll
deadlock. Also it would be cleaner if __lock_page wasn't using the
exclusive waitqueue and that in turn you would keep using wake_up for
unlock_page. By the time you share the waitqueue nothing can be wake one
any longer, this is probably the worst drawback of the wait_table
memory-saving patch. Infact I was considering to solve the collisions
with additional memory, rather than by having to drop the wake-one
behaviour when many threads are working on the same chunk of the file
that your design solution requires. quite frankly I don't think this was
an urgent thing to change in 2.4 (it only saves some memory and even if
64G will now boot with CONFIG_1G, the lowmem will be way too much
unbalanced to be good for general purpose).

Andrea
