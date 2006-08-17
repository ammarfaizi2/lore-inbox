Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWHQOMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWHQOMD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbWHQOMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 10:12:03 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:55229 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S932275AbWHQOMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 10:12:00 -0400
Date: Thu, 17 Aug 2006 22:35:51 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Kirill Korotaev <dev@sw.ru>
Cc: Pavel Emelianov <xemul@sw.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2/7] UBC: core (structures, API)
Message-ID: <20060817183551.GA588@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
>
> +struct user_beancounter *beancounter_findcreate(uid_t uid,
> +		struct user_beancounter *p, int mask)
> +{
> +	struct user_beancounter *new_ub, *ub, *tmpl_ub;
> +	unsigned long flags;
> +	struct hlist_head *slot;
> +	struct hlist_node *pos;
> +
> +	if (mask & UB_LOOKUP_SUB) {
> +		WARN_ON(p == NULL);
> +		tmpl_ub = &default_subbeancounter;
> +		slot = &ub_hash[ub_subhash_fun(p, uid)];
> +	} else {
> +		WARN_ON(p != NULL);
> +		tmpl_ub = &default_beancounter;
> +		slot = &ub_hash[ub_hash_fun(uid)];
> +	}
> +	new_ub = NULL;
> +
> +retry:
> +	spin_lock_irqsave(&ub_hash_lock, flags);
> +	hlist_for_each_entry (ub, pos, slot, hash)
> +		if (ub->ub_uid == uid && ub->parent == p)
> +			break;
> +
> +	if (pos != NULL) {
> +		get_beancounter(ub);
> +		spin_unlock_irqrestore(&ub_hash_lock, flags);
> +
> +		if (new_ub != NULL) {
> +			put_beancounter(new_ub->parent);
					^^^^^^^^^^^^^^

Stupid question: why ->parent can't be NULL ? (without UB_LOOKUP_SUB).

> +	if (mask & UB_ALLOC_ATOMIC) {
> +		new_ub = kmem_cache_alloc(ub_cachep, GFP_ATOMIC);
> +		if (new_ub == NULL)
> +			goto out_unlock;
> +
> +		memcpy(new_ub, tmpl_ub, sizeof(*new_ub));
> +		init_beancounter_struct(new_ub, uid);
> +		if (p)
> +			new_ub->parent = get_beancounter(p);
> +		goto out_install;
> +	}
> +
> +	spin_unlock_irqrestore(&ub_hash_lock, flags);
> +
> +	new_ub = kmem_cache_alloc(ub_cachep, GFP_KERNEL);

beancounter_findcreate() is not time critical, yes? Isn't it better
to kill 'if (mask & UB_ALLOC_ATOMIC) { ... }' and just do

	new_ub = kmem_cache_alloc(ub_cachep,
		UB_ALLOC_ATOMIC ? GFP_ATOMIC : GFP_KERNEL);

after spin_unlock(&ub_hash_lock) ?

Oleg.

