Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWFRTlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWFRTlR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 15:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWFRTlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 15:41:17 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:37844 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932303AbWFRTlP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 15:41:15 -0400
Message-ID: <4495AABE.6090007@in.ibm.com>
Date: Mon, 19 Jun 2006 01:04:22 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jblunck@suse.de
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@zeniv.linux.org.uk, dgc@sgi.com, neilb@suse.de
Subject: Re: [PATCH 2/5] vfs: d_genocide() doesnt add dentries to unused list
References: <20060616104321.778718000@hasse.suse.de> <20060616104322.204073000@hasse.suse.de>
In-Reply-To: <20060616104322.204073000@hasse.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jblunck@suse.de wrote:
> Calling d_genocide() is only lowering the reference count of the dentries but
> doesn't add them to the unused list.
> 
> Signed-off-by: Jan Blunck <jblunck@suse.de>
> ---
>  fs/dcache.c |   18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> Index: work-2.6/fs/dcache.c
> ===================================================================
> --- work-2.6.orig/fs/dcache.c
> +++ work-2.6/fs/dcache.c
> @@ -1612,11 +1612,25 @@ resume:
>  			this_parent = dentry;
>  			goto repeat;
>  		}
> -		atomic_dec(&dentry->d_count);
> +		if (!list_empty(&dentry->d_lru)) {
> +			dentry_stat.nr_unused--;
> +			list_del_init(&dentry->d_lru);
> +		}
> +		if (atomic_dec_and_test(&dentry->d_count)) {
> +			list_add(&dentry->d_lru, dentry_unused.prev);
> +			dentry_stat.nr_unused++;
> +		}

We could have dentries on the LRU list with non-zero d_count. If
we have a dentry on the LRU list with a count of 1, then the code
will remove it from LRU list and then add it back subsequently.

I think the condition below should be an else if

>  	}
>  	if (this_parent != root) {
>  		next = this_parent->d_u.d_child.next;
> -		atomic_dec(&this_parent->d_count);
> +		if (!list_empty(&this_parent->d_lru)) {
> +			dentry_stat.nr_unused--;
> +			list_del_init(&this_parent->d_lru);
> +		}
> +		if (atomic_dec_and_test(&this_parent->d_count)) {
> +			list_add(&this_parent->d_lru, dentry_unused.prev);
> +			dentry_stat.nr_unused++;
> +		}

Ditto

>  		this_parent = this_parent->d_parent;
>  		goto resume;
>  	}
> 

d_genocide() now almost looks like select_parent(). I think we can share a lot
of code between the two.

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
