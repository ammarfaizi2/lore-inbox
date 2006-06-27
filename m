Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422633AbWF0VxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422633AbWF0VxM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 17:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422635AbWF0VxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 17:53:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7369 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422633AbWF0VxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 17:53:10 -0400
Date: Tue, 27 Jun 2006 14:56:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Doug Thompson <norsk5@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6]  EDAC mc numbers refactor 2-of-2
Message-Id: <20060627145633.533bc2dc.akpm@osdl.org>
In-Reply-To: <20060626221713.42428.qmail@web50106.mail.yahoo.com>
References: <20060626221713.42428.qmail@web50106.mail.yahoo.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Thompson <norsk5@yahoo.com> wrote:
>
> From: Doug Thompson <norsk5@xmission.com>
> 
> This is part 2 of a 2-part patch set.
> 
> 1 Reimplement add_mc_to_global_list() with semantics that allow the caller to
>   determine the ID number for a mem_ctl_info structure.  Then modify
>   edac_mc_add_mc() so that the caller specifies the ID number for the new
>   mem_ctl_info structure.  Platform-specific code should be able to assign the
>   ID numbers in a platform-specific manner.  For instance, on Opteron it makes
>   sense to have the ID of the mem_ctl_info structure match the ID of the node
>   that the memory controller belongs to.
> 
> 2 Modify callers of edac_mc_add_mc() so they use the new semantics.
> 
> ...
>  
> +/* Return 0 on success, 1 on failure.
> + * Before calling this function, caller must
> + * assign a unique value to mci->mc_idx.
> + */
> +static int add_mc_to_global_list (struct mem_ctl_info *mci)
> +{
> +	struct list_head *item, *insert_before;
> +	struct mem_ctl_info *p;
> +
> +	insert_before = &mc_devices;
> +
> +	if (unlikely((p = find_mci_by_dev(mci->dev)) != NULL))
> +		goto fail0;
> +
> +	list_for_each(item, &mc_devices) {
> +		p = list_entry(item, struct mem_ctl_info, link);
> +
> +		if (p->mc_idx >= mci->mc_idx) {
> +			if (unlikely(p->mc_idx == mci->mc_idx))
> +				goto fail1;
> +
> +			insert_before = item;
> +			break;
> +		}
> +	}
> +
> +	list_add_tail_rcu(&mci->link, insert_before);
> +	return 0;
> +
> +fail0:
> +	edac_printk(KERN_WARNING, EDAC_MC,
> +		    "%s (%s) %s %s already assigned %d\n", p->dev->bus_id,
> +		    dev_name(p->dev), p->mod_name, p->ctl_name, p->mc_idx);
> +	return 1;
> +
> +fail1:
> +	edac_printk(KERN_WARNING, EDAC_MC,
> +		    "bug in low-level driver: attempt to assign\n"
> +		    "    duplicate mc_idx %d in %s()\n", p->mc_idx, __func__);
> +	return 1;
> +}

I assume the caller must hold some lock to prevent the list from getting
trashed, but I didn't locate it in (literally) a five-second search.  I'd
suggest that a comment describing the locking requirements be added to this
function.

