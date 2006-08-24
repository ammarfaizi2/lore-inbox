Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbWHXRJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbWHXRJg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 13:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030394AbWHXRJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 13:09:36 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:50877 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1030393AbWHXRJf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 13:09:35 -0400
Date: Fri, 25 Aug 2006 01:33:45 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Greg KH <greg@kroah.com>,
       Matt Helsley <matthltc@us.ibm.com>, Rohit Seth <rohitseth@google.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
Subject: Re: [PATCH 2/6] BC: beancounters core (API)
Message-ID: <20060824213345.GB952@oleg>
References: <44EC31FB.2050002@sw.ru> <44EC35EB.1030000@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44EC35EB.1030000@sw.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/23, Kirill Korotaev wrote:
>
> +struct beancounter *beancounter_findcreate(uid_t uid, int mask)
> +{
> +	struct beancounter *new_bc, *bc;
> +	unsigned long flags;
> +	struct hlist_head *slot;
> +	struct hlist_node *pos;
> +
> +	slot = &bc_hash[bc_hash_fun(uid)];
> +	new_bc = NULL;
> +
> +retry:
> +	spin_lock_irqsave(&bc_hash_lock, flags);
> +	hlist_for_each_entry (bc, pos, slot, hash)
> +		if (bc->bc_id == uid)
> +			break;
> +
> +	if (pos != NULL) {
> +		get_beancounter(bc);
> +		spin_unlock_irqrestore(&bc_hash_lock, flags);
> +
> +		if (new_bc != NULL)
> +			kmem_cache_free(bc_cachep, new_bc);
> +		return bc;
> +	}
> +
> +	if (!(mask & BC_ALLOC))
> +		goto out_unlock;

Very minor nit: it is not clear why we are doing this check under
bc_hash_lock. I'd suggest to do

	if (!(mask & BC_ALLOC))
		goto out;

after unlock(bc_hash_lock) and kill out_unlock label.

> +	if (new_bc != NULL)
> +		goto out_install;
> +
> +	spin_unlock_irqrestore(&bc_hash_lock, flags);
> +
> +	new_bc = kmem_cache_alloc(bc_cachep,
> +			mask & BC_ALLOC_ATOMIC ? GFP_ATOMIC : GFP_KERNEL);
> +	if (new_bc == NULL)
> +		goto out;
> +
> +	memcpy(new_bc, &default_beancounter, sizeof(*new_bc));

May be it is just me, but I need a couple of seconds to parse this 'memcpy'.
How about

	*new_bc = default_beancounter;

?

Oleg.

