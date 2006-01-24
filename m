Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030414AbWAXJrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030414AbWAXJrO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 04:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030434AbWAXJrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 04:47:14 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:62028 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1030414AbWAXJrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 04:47:13 -0500
Message-ID: <43D5F7DD.7010507@sw.ru>
Date: Tue, 24 Jan 2006 12:48:13 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Jan Blunck <jblunck@suse.de>, viro@zeniv.linux.org.uk,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       olh@suse.de
Subject: Re: [PATCH] shrink_dcache_parent() races against shrink_dcache_memory()
References: <20060120203645.GF24401@hasse.suse.de> <43D48ED4.3010306@sw.ru> <20060123155728.GC26653@hasse.suse.de> <20060124055425.GA30609@in.ibm.com>
In-Reply-To: <20060124055425.GA30609@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I like your idea, but some comments below... I doubt it works.
I will think it over a bit later...

Kirill
P.S. it's not easily reproducable. Before my fix it took us 3-6 hours on 
automated stress testing to hit this bug. Right now I can't setup it for 
testing, maybe in a week or so.

>>On Mon, Jan 23, Kirill Korotaev wrote:
>>
>>[snip] 
>>
>>Hmm, will think about that one again. shrink_dcache_parent() and
>>shrink_dcache_memory()/dput() are not racing against each other now since the
>>reference counting is done before giving up dcache_lock and the select_parent
>>could start.
>>
>>Regards,
>>	Jan
>>
> 
> 
> I have been playing around with a possible solution to the problem.
> I have not been able to reproduce this issue, hence I am unable to verify
> if the patch below fixes the problem. I have run the system with this
> patch and verified that no obvious badness is observed.
> 
> Kirill, Jan if you can easily reproduce the problem, could you
> try this patch and review it as well for correctness of the solution?
> 
> All callers that try to free memory set the PF_MEMALLOC flag, we check
> if the super block is going away due to an unmount, if so we ask the
> allocator to return.
> 
> The patch adds additional cost of holding the sb_lock for each dentry
> being pruned. It holds sb_lock under dentry->d_lock and dcache_lock,
> I am not sure about the locking order of these locks.
> 
> Signed-off-by: Balbir Singh <balbir@in.ibm.com>
> ---
> 
>  fs/dcache.c |   23 +++++++++++++++++++++++
>  1 files changed, 23 insertions(+)
> 
> diff -puN fs/dcache.c~dcache_race_fix2 fs/dcache.c
> --- linux-2.6/fs/dcache.c~dcache_race_fix2	2006-01-24 11:05:46.000000000 +0530
> +++ linux-2.6-balbir/fs/dcache.c	2006-01-24 11:05:46.000000000 +0530
> @@ -425,6 +425,29 @@ static void prune_dcache(int count)
>   			spin_unlock(&dentry->d_lock);
>  			continue;
>  		}
> +
> +		/*
> +		 * Note to reviewers: our current lock order is dcache_lock,
> +		 * dentry->d_lock & sb_lock. Could this create a deadlock?
> +		 */
> +		spin_lock(&sb_lock);
<<<< 1. sb_lock doesn't protect atomic_read() anyhow...
<<<<    I mean, sb_lock is not required to read its value...
> +		if (!atomic_read(&dentry->d_sb->s_active)) {
> +			/*
> +			 * Race condition, umount and other pruning is happening
> +			 * in parallel.
> +			 */
> +			if (current->flags & PF_MEMALLOC) {
> +				/*
> +				 * let the allocator leave this dentry alone
> +				 */
> +				spin_unlock(&sb_lock);
> +				spin_unlock(&dentry->d_lock);
> +				spin_unlock(&dcache_lock);
> +				return;
<<<< you should not return, but rather 'continue'. otherwise you skip 
_all_ dentries, even from active super blocks.
> +			}
> +		}
> +		spin_unlock(&sb_lock);
> +
<<<< and here, when you drop sb_lock, and dentry->d_lock/dcache_lock in 
prune_dentry() it looks to me that we have exactly the same situation as 
it was without your patch:
<<<< another CPU can start umount in parallel.
<<<< maybe sb_lock barrier helps this somehow, but I can't see how yet...

<<<< another idea: down_read(&sb->s_umount) probably could help...
<<<< because it will block the whole umount operation...
<<<< but we can't take it under dcache_lock...
>  		prune_one_dentry(dentry);
>  	}
>  	spin_unlock(&dcache_lock);
> 
> Thanks,
> Balbir
> _
> 


