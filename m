Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbUCVT5r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 14:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbUCVT5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 14:57:47 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:19911
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262361AbUCVT5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 14:57:40 -0500
Date: Mon, 22 Mar 2004 20:58:26 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: VMA_MERGING_FIXUP and patch
Message-ID: <20040322195826.GA22639@dualathlon.random>
References: <20040322175216.GJ3649@dualathlon.random> <Pine.LNX.4.44.0403221842060.12658-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403221842060.12658-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 07:02:01PM +0000, Hugh Dickins wrote:
> On Mon, 22 Mar 2004, Andrea Arcangeli wrote:
> > 
> > what about this?
> > 
> > @@ -344,6 +360,10 @@ void fastcall page_remove_rmap(struct pa
> >    
> >   out_unlock:
> >  	page_map_unlock(page);
> > +
> > +	if (page_test_and_clear_dirty(page) && !page_mapped(page))
> > +		set_page_dirty(page);
> > +
> >  	return;
> >  }
> 
> No, it has to be
> 	if (!page_mapped(page) && page_test_and_clear_dirty(page))
> 		set_page_dirty(page);
> but the positioning is fine.

you're right, I'll fixup. You saved s390 for the second time in a row ;)

> > @@ -523,6 +543,11 @@ int fastcall try_to_unmap(struct page * 
> >  		dec_page_state(nr_mapped);
> >  		ret = SWAP_SUCCESS;
> >  	}
> > +	page_map_unlock(page);
> > +
> > +	if (page_test_and_clear_dirty(page) && ret == SWAP_SUCCESS)
> > +		set_page_dirty(page);
> > +
> >  	return ret;
> >  }
> 
> No, it has to be
> 	if (ret == SWAP_SUCCESS && page_test_and_clear_dirty(page))
> 		set_page_dirty(page);

agreed.

> Personally, I'd prefer we leave try_to_unmap with the lock we
> had on entry, and do this at the shrink_list end - though I
> can see that the way you've done it actually reduces the code.

I agree with you here too, I also preferred not to drop the lock before
return, I did it to reduce the code (in the asm especially).

> (The s390 header file comments that the page_test_and_clear_dirty
> needs to be done while not mapped, because of race with referenced
> bit, and we are opening up to a race now; but unless s390 is very
> different, I see nothing wrong with a rare race on referenced -
> whereas everything wrong with any race that might lose dirty.)

Agreed. I don't see how could ever lose the dirty bit, however the above
comment is scary, and needs clarification from the hw experts. If it's
not safe we can put it back under the page_map_lock. I don't recall
stuff taking the page_map_lock while holding the mapping locks, so it
should be safe (though if we can do it ouside it's preferable.

> Excited by that glimpse of find_pte_nonlinear you just gave us;
> disappointed to find it empty ;-)

8)8)
