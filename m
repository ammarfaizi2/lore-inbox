Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbWDMWDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbWDMWDM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 18:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWDMWDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 18:03:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9355 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932459AbWDMWDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 18:03:11 -0400
Date: Thu, 13 Apr 2006 15:05:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Mahoney <jeffm@suse.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 01/08] idr: add idr_replace method for replacing
 pointers
Message-Id: <20060413150527.0028bc88.akpm@osdl.org>
In-Reply-To: <20060413203546.GA3170@locomotive.unixthugs.org>
References: <20060413203546.GA3170@locomotive.unixthugs.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Mahoney <jeffm@suse.com> wrote:
>
> +/**
> + * idr_replace - replace pointer for given id
> + * @idp: idr handle
> + * @ptr: pointer you want associated with the ide
> + * @id: lookup key
> + *
> + * Replace the pointer registered with the id.  A -ENOENT
> + * return indicates that @id was not found.
> + *
> + * The caller must serialize vs idr_find(), idr_get_new(), and idr_remove().
> + */
> +int idr_replace(struct idr *idp, void *ptr, int id)
> +{
> +	int n;
> +	struct idr_layer *p;
> +	int shift = (idp->layers - 1) * IDR_BITS;
> +
> +	n = idp->layers * IDR_BITS;
> +	p = idp->top;
> +
> +	id &= MAX_ID_MASK;
> +
> +	while ((shift > 0) && p) {
> +		n = (id >> shift) & IDR_MASK;
> +		p = p->ary[n];
> +		shift -= IDR_BITS;
> +	}
> +
> +	n = id & IDR_MASK;
> +	if (unlikely(p == NULL || !test_bit(n, &p->bitmap)))
> +		return -ENOENT;
> +
> +	p->ary[n] = ptr;
> +	return 0;
> +}

I'd have thought it would be more flexible were this to return the old
pointer.

If there was no old item, we could return NULL and "succeed".  But that gets
a bit ill-defined, because lack of an old pointer can occur if either a)
there was a layer, but the slot was empty or b) there wasn't a layer for
this new item.  So perhaps it's best to continue considering lack of an old
pointer as an error, with ERR_PTR(-ENOENT).

