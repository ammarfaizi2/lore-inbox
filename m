Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263652AbTDISKX (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 14:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263654AbTDISKX (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 14:10:23 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:47282 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S263652AbTDISKW (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 14:10:22 -0400
Date: Wed, 9 Apr 2003 19:24:01 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Andrew Morton <akpm@digeo.com>, Dave McCracken <dmccr@us.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix obj vma sorting
In-Reply-To: <192640000.1049908071@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0304091900280.2540-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Apr 2003, Martin J. Bligh wrote:

> Hmmm. Something somewhere went wrong. Some semaphore blew up
> somewhere ... I'm not convinced that this is your patch
> causing the problem, I just thought that since vma_link seems
> to have gone up rather in the profile. I'm playing with getting
> some better data on what actually happened, but in case someone
> is feeling psychic. 
> 
> The main thing I changed here (66-mjb2 -> 67-mjb0.2) was to pick up 
> Andrew's rmap speedups, and drop the objrmap code I had for the stuff 

I haven't examined it, but I'm guessing 66-mjb2 did not have Dave's
vma sorting in at all?  Its linear search would certainly raise the
time spent in __vma_link (notable in your diffprofile), which would
increase the pressure on i_shared_sem.

(Whether it's a worthwhile optimization remains to be seen: like
rmap generally, it speeds up page_referenced and try_to_unmap at
the expense of the fast path.  One improvement would be for fork
to just slot dst vma in next to src vma instead of linear search.)

I don't think my fix to the sort order could have slowed it down
further (though once there are stray entries out of order, it may
be hard to predict how things will work out).  But without it
page_referenced and try_to_unmap sometimes couldn't quite find
all the mappings they were looking for.

> he had. *However*, what he had worked fine. I also picked up your 
> sorting patch here Hugh ... this bit worries me:
> 
> +static void move_vma_start(struct vm_area_struct *vma, unsigned long addr)

It does use i_shared_sem where it wasn't used before, yes, but it's
only called by one case of vma_merge and one case of split_vma:
unless your tests are doing a lot of vma splitting (e.g. mprotecting
ranges which break up vmas), I wouldn't expect it to figure highly.
I can see it's there in the plus part of your diffprofile, but I'm
too inexperienced at reading these things, without the original
profiles, to tell whether it's being used a surprising amount.

When you say "*However*, what he had worked fine", are you saying
you profiled before adding in my patch on top?  The diffprofile of
the before and after my patch should in that case illuminate.

Hugh

