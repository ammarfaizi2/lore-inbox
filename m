Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbUDZQpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbUDZQpk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 12:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263104AbUDZQpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 12:45:40 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:42257 "EHLO
	pumpkin.fieldses.org") by vger.kernel.org with ESMTP
	id S263084AbUDZQp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 12:45:28 -0400
Date: Mon, 26 Apr 2004 12:45:23 -0400
To: "Petri T. Koistinen" <petri.koistinen@iki.fi>
Cc: "David S. Miller" <davem@redhat.com>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/sunrpc/svcauth_unix.c: unix_domain_find: return NULL if kmalloc fails
Message-ID: <20040426164523.GA29509@fieldses.org>
References: <Pine.LNX.4.58.0404261913550.5531@dsl-prvgw1cc4.dial.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404261913550.5531@dsl-prvgw1cc4.dial.inet.fi>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 07:17:19PM +0300, Petri T. Koistinen wrote:
> Is this correct fix? What happens when unix_domain_find return NULL?

I just noticed that the other day, and have been testing with the
identical fix; seems to work fine.  All the callers check for NULL
returns and appear to do the right thing.  --Bruce Fields

> --- linux-2.5/net/sunrpc/svcauth_unix.c.orig	2004-04-26 18:58:04.000000000 +0300
> +++ linux-2.5/net/sunrpc/svcauth_unix.c	2004-04-26 18:58:58.000000000 +0300
> @@ -36,36 +36,38 @@ struct unix_domain {
>  struct auth_domain *unix_domain_find(char *name)
>  {
>  	struct auth_domain *rv, ud;
>  	struct unix_domain *new;
> 
>  	ud.name = name;
> 
>  	rv = auth_domain_lookup(&ud, 0);
> 
>   foundit:
>  	if (rv && rv->flavour != RPC_AUTH_UNIX) {
>  		auth_domain_put(rv);
>  		return NULL;
>  	}
>  	if (rv)
>  		return rv;
> 
>  	new = kmalloc(sizeof(*new), GFP_KERNEL);
> +	if (new == NULL)
> +		return NULL;
>  	cache_init(&new->h.h);
>  	atomic_inc(&new->h.h.refcnt);
>  	new->h.name = strdup(name);
>  	new->h.flavour = RPC_AUTH_UNIX;
>  	new->addr_changes = 0;
>  	new->h.h.expiry_time = NEVER;
>  	new->h.h.flags = 0;
> 
>  	rv = auth_domain_lookup(&new->h, 2);
>  	if (rv == &new->h) {
>  		if (atomic_dec_and_test(&new->h.h.refcnt)) BUG();
>  	} else {
>  		auth_domain_put(&new->h);
>  		goto foundit;
>  	}
> 
>  	return rv;
>  }
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
