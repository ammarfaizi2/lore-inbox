Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263717AbTDITGy (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 15:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263708AbTDITGx (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 15:06:53 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:24932 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S263717AbTDITGu (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 15:06:50 -0400
Date: Wed, 9 Apr 2003 20:20:28 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Andrew Morton <akpm@digeo.com>, Dave McCracken <dmccr@us.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix obj vma sorting
In-Reply-To: <71580000.1049913191@flay>
Message-ID: <Pine.LNX.4.44.0304092007040.2595-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Apr 2003, Martin J. Bligh wrote:
> >> Hmmm. Something somewhere went wrong. Some semaphore blew up
> >> somewhere ... I'm not convinced that this is your patch
> >> causing the problem, I just thought that since vma_link seems
> >> to have gone up rather in the profile. I'm playing with getting
> >> some better data on what actually happened, but in case someone
> >> is feeling psychic. 
> >> 
> >> The main thing I changed here (66-mjb2 -> 67-mjb0.2) was to pick up 
> >> Andrew's rmap speedups, and drop the objrmap code I had for the stuff 
> > 
> > I haven't examined it, but I'm guessing 66-mjb2 did not have Dave's
> > vma sorting in at all?  Its linear search would certainly raise the
> > time spent in __vma_link (notable in your diffprofile), which would
> > increase the pressure on i_shared_sem.
> 
> No it didn't ... but I think 67-mm1 did.
>  
> > (Whether it's a worthwhile optimization remains to be seen: like
> > rmap generally, it speeds up page_referenced and try_to_unmap at
> > the expense of the fast path.  One improvement would be for fork
> > to just slot dst vma in next to src vma instead of linear search.)

Ignore that last parenthetical sentence: I just took a look at copy_mm,
noticing it up in your diffprofile, and it does already slot new vma
in next to old vma without linear search.

> > I don't think my fix to the sort order could have slowed it down
> > further (though once there are stray entries out of order, it may
> > be hard to predict how things will work out).  But without it
> > page_referenced and try_to_unmap sometimes couldn't quite find
> > all the mappings they were looking for.
> 
> It is that fix ... I just backed that one patch off and recompared:

Thanks.  Yes, seems conclusive, but I'm puzzled.
I hope a fresh pair of eyes can work it out for us.

> DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
> trademarks of the Standard Performance Evaluation Corporation. This 
> benchmarking was performed for research purposes only, and the run results
> are non-compliant and not-comparable with any published results.
> 
> Results are shown as percentages of the first set displayed
> 
> SDET 32  (see disclaimer)
>                            Throughput    Std. Dev
>                    2.5.67       100.0%         0.3%
>             2.5.67-mjb0.2       151.7%         0.5%
>      2.5.67-mjb0.2-nosort       207.1%         0.0%
> 
> SDET 64  (see disclaimer)
>                            Throughput    Std. Dev
>                    2.5.67       100.0%         0.4%
>             2.5.67-mjb0.2       147.0%         0.5%
>      2.5.67-mjb0.2-nosort       201.5%         0.2%
> 
> SDET 128  (see disclaimer)
>                            Throughput    Std. Dev
>                    2.5.67       100.0%         5.1%
>             2.5.67-mjb0.2       144.5%         0.1%
>      2.5.67-mjb0.2-nosort       188.6%         0.3%
> 
> 
> I think it's that sem, which seems to be heavily contented.
> Quite possibly for glibc's address_space or something.
> (even though it says "-nosort", it's just your sort fix I
> backed out ... otherwise it's what was in -mm).

Certainly your idea of glibc's address_space is plausible: I can
well imagine (sorry, can't try right now) that it patches the mmap
of some jump tables, doing mprotect and split and merge.  But
split_vma and vma_merge didn't show all that high before.  Of
course, the inline __vma_link_file in move_vma_start will push
it quite high, but I still don't see why __down soars that high.

> >> he had. *However*, what he had worked fine. I also picked up your 
> >> sorting patch here Hugh ... this bit worries me:
> >> 
> >> +static void move_vma_start(struct vm_area_struct *vma, unsigned long addr)
> > 
> > It does use i_shared_sem where it wasn't used before, yes, but it's
> > only called by one case of vma_merge and one case of split_vma:
> > unless your tests are doing a lot of vma splitting (e.g. mprotecting
> > ranges which break up vmas), I wouldn't expect it to figure highly.
> > I can see it's there in the plus part of your diffprofile, but I'm
> > too inexperienced at reading these things, without the original
> > profiles, to tell whether it's being used a surprising amount.
> 
> Here's the diffprofile for just your patch ... where it's positive,
> that's the increase in the number of ticks by applying your patch.
> Where it's negative, that's the decrease. The %age is the change from
> the first to the second profile:
> 
> larry:/var/bench/results# diffprofile 2.5.67-mjb0.2{-nosort,}/sdetbench/64/profile
>       7148    24.9% total
>       6482    37.7% default_idle
>       1466   842.5% __down
>        442   566.7% __wake_up
>        435   378.3% schedule
>        251     0.0% move_vma_start
>        149   876.5% __vma_link
>         72    40.2% remove_shared_vm_struct
>         46    35.1% copy_mm
>         20    60.6% vma_link
>         12   300.0% default_wake_function
>         11   137.5% rb_insert_color
> ...
>        -20   -37.0% number
>        -20   -12.6% do_anonymous_page
>        -21   -36.8% fd_install
>        -23   -27.7% __find_get_block
>        -24   -55.8% flush_signal_handlers
>        -27   -45.0% __set_page_dirty_buffers
>        -28   -26.7% kmem_cache_free
>        -28    -7.5% find_get_page
>        -29   -34.1% buffered_rmqueue
>        -32   -34.8% path_release
>        -33   -32.0% file_move
>        -35   -60.3% __read_lock_failed
>        -35   -43.8% .text.lock.highmem
>        -37   -59.7% .text.lock.namei
>        -37   -29.1% pte_alloc_one
>        -40   -10.3% page_add_rmap
>        -41   -41.4% free_hot_cold_page
>        -44   -60.3% .text.lock.file_table
>        -54   -18.4% __copy_to_user_ll
>        -58   -43.0% follow_mount
>        -62   -29.0% path_lookup
>        -85   -20.9% __d_lookup
>        -86   -20.4% release_pages
>        -99   -68.8% .text.lock.dcache
>       -100   -15.4% page_remove_rmap
>       -106   -36.6% atomic_dec_and_lock
>       -126   -16.8% zap_pte_range
>       -141   -66.8% .text.lock.dec_and_lock
> 
> Note the massive increase in down() (and some of the vma ops).
> The things that are cheaper are probably just because of less
> contention, I guess.
> 
> > When you say "*However*, what he had worked fine", are you saying
> > you profiled before adding in my patch on top?  The diffprofile of
> > the before and after my patch should in that case illuminate.
> 
> Well, I hadn't ... but I should have done, and I have now ;-)
> 
> I'll attach the two raw profiles for you as well. profile.with
> is with your patch, profile.without is without ... I was looking
> at SDET 64, since it showed the most dramatic difference.

Thanks for all the info, I'm sorry, I must rush away now.
I'll try another think later, but hope someone can do better.

Hugh

