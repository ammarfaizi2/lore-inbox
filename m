Return-Path: <linux-kernel-owner+w=401wt.eu-S1751261AbXAIKK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbXAIKK0 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbXAIKK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:10:26 -0500
Received: from smtp.osdl.org ([65.172.181.24]:55203 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261AbXAIKKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:10:24 -0500
Date: Tue, 9 Jan 2007 02:10:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH - RFC] allow setting vm_dirty below 1% for large memory
 machines
Message-Id: <20070109021017.447b682d.akpm@osdl.org>
In-Reply-To: <17827.22798.625018.673326@notabene.brown>
References: <17827.22798.625018.673326@notabene.brown>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2007 19:57:50 +1100
Neil Brown <neilb@suse.de> wrote:

> 
> Imagine a machine with lots of memory - say 100Gig.
> 
> Suppose there is one (largish) filesystem that is ext3 (or maybe
> reiser) with the default data=ordered.
> 
> Suppose this filesystem is being written to steadily so that the
> maximum amount of memory is always dirty.  With the default
> vm.dirty_ratio of 40%, this could be 40Gig.
> 
> When the journal triggers a commit, all the dirty data needs to be
> flushed out in order to adhere to the "data=ordered" semantics.
> This can take a while.
> 
> While this is happening, some small updates such as 'atime' update can
> block waiting for the journal to be unlocked again after the flush.

Actually, ext3 doesn't work that way.  The atime update will go into the
"running transaction", which is an instance of journal_t which is separate
from the committing transaction.

But there are situations (ie; journal free-space exhaustion) where things
can go synchronous.  They're more likely to occur during metadata storms
though, and perhaps indicate an undersized journal.

But yeah, overall point agreed with.

> Waiting for 40gig to flush for an atime update to complete is clearly
> unsatisfactory. 
> 
> We can reduce the amount of dirty memory by setting vm.dirty_ratio
> down to 1 still allows 1Gig of dirty data which can cause unpleasant
> pauses (and this was on a kernel where '1' still meant something.  In
> current kernels, '5' is the effective minimum).
> 
> So this patch removes the minimum of '5' and introduces a new tunable
> 'vm.dirty_kb' which sets an upper limit in Kibibytes.

kibibytes?  We're feeding the kernel catfood now?

> This allows the amount of dirty memory to be limited to - say - 50M
> which should flush fast enough.
> 
> So: is this patch acceptable?  And should a lower default value for
> vm_dirty_kb be used?
> 
> 
> Some of the details in the above description might not be 100%
> accurate (I'm not sure of the exact connection between atime updates
> and journal commits).  The symptoms are:
>   While generating constant write traffic on a machine with > 20Gig
>   of RAM, performing assorted read-only operations can sometimes
>   produces a pause of 10s of seconds.
>   The pause can be removed by:
>     - mounting noatime
>     - mounting data=writeback
>     - setting vm.dirty_kb to 1000 with this patch.

Could be IO scheduler borkage, could be ext3 borkage.  A well-timed sysrq-T
will tell us, and is worth doing (please).

Does increasing the journal size help?

> @@ -149,15 +154,21 @@ get_dirty_limits(long *pbackground, long
>  	if (dirty_ratio > unmapped_ratio / 2)
>  		dirty_ratio = unmapped_ratio / 2;
>  
> -	if (dirty_ratio < 5)
> -		dirty_ratio = 5;
> -
>  	background_ratio = dirty_background_ratio;
>  	if (background_ratio >= dirty_ratio)
>  		background_ratio = dirty_ratio / 2;
> +	if (dirty_background_ratio && !background_ratio)
> +		background_ratio = 1;
>  
> -	background = (background_ratio * available_memory) / 100;
>  	dirty = (dirty_ratio * available_memory) / 100;
> +	if (dirty > vm_dirty_kb / (PAGE_SIZE/1024))
> +		dirty = vm_dirty_kb / (PAGE_SIZE/1024);
> +	if (dirty_ratio == 0)
> +		background = 0;
> +	else if (background_ratio >= dirty_ratio)
> +		background = dirty / 2;
> +	else
> +		background = dirty * background_ratio / dirty_ratio;
>  	tsk = current;
>  	if (tsk->flags & PF_LESS_THROTTLE || rt_task(tsk)) {
>  		background += background / 4;

It would be better if we can avoid creating the second global variable.  Is
it not possible to remove dirty_ratio?  Make everything work off
vm_dirty_kb and do arithmetricks at the /proc/sys/vm/dirty_ratio interface?

We should perform the same conversion to dirty_background_ratio, I suspect.

And these guys should be `long', not `int'.  Otherwise things will go
pearshaped at 2 tabbybytes.

