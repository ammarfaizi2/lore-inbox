Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263505AbUDBBQr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 20:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263490AbUDBBQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 20:16:46 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:5267
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263479AbUDBBQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 20:16:28 -0500
Date: Fri, 2 Apr 2004 03:16:27 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, vrajesh@umich.edu,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040402011627.GK18585@dualathlon.random>
References: <20040402001535.GG18585@dualathlon.random> <Pine.LNX.4.44.0404020145490.2423-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404020145490.2423-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 02:03:14AM +0100, Hugh Dickins wrote:
> On Fri, 2 Apr 2004, Andrea Arcangeli wrote:
> > 
> > the good thing is that I believe this fix will make it work with the -mm
> > writeback changes. However this fix now collides with anon-vma since
> > swapsuspend passes compound pages to rw_swap_page_sync and
> > add_to_page_cache overwrites page->private and the kernel crashes at the
> > next page_cache_get() since page->private is now the swap entry and not
> > a page_t pointer. So I guess I've a good reason now to giveup trying to
> > add the page to the swapcache, and to just fake the radix tree like I
> > did in my original fix. That way the page won't be swapcache either so I
> > don't even need to use get_page to avoid remove_exclusive_swap_page to
> > mess with it.
> 
> Yes, I too was feeling that we'd gone far enough in this "make it like
> a real swap page" direction, and we'd probably have better luck with
> "take away all resemblance to a real swap page".
> 
> I've still done no work or testing on rw_swap_page_sync, but I wonder...
> remember how your page_mapping(page) gives &swapper_space on a swap
> cache page, whereas my page_mapping(page) gives NULL on them?  My guess

yes.

> (quite possibly wrong) is that I won't have any of the trouble you've
> had with this, that the page_writeback functions, seeing NULL mapping,
> won't get involved with the radix tree at all - and why should they,

Not sure but I find your way very risky since writepage operations are
address space methods, it's like calling an object method with a null
object as parameter, very risky and dirty, and the primary reason I
wanted my swap cache to have a true page_mapping(page) ==
&swapper_space, your swapcache having a null mapping looks very dirty to
me and that's why I avoided it.

Note that the same way you drop the swapper_space with your code
applied, you could drop it indipendently from mainline too w/o any other
change. I much prefer to have a real swapper_space with a real tree_lock
with a real ->writepage callback etc..

> it isn't doing anything useful for rw_swap_page_sync, just getting you
> into memory allocation difficulties.  No need for add_to_page_cache or
> add_to_swap_cache there at all.  As I say, I haven't tested this path,

I wouldn't need to call add_to_page_cache either, it's just Andrew
prefers it.

> but I do know that the rest of swap works fine with NULL page_mapping.

though your code still has no way to work since it will clash on the
compound page just like mine. Note that my code already works fine as
far as it's not a compound page, as far as Andrew's code works in
mainline, my code will work fine, if my code doesn't work yours cannot
either (we both clash in the compound page infact).
