Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030332AbWJ3O4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbWJ3O4a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 09:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030336AbWJ3O43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 09:56:29 -0500
Received: from wr-out-0506.google.com ([64.233.184.235]:57023 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030332AbWJ3O42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 09:56:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=pcngkdsHRrzlhVrdeRgYB4xGWCOYaE8wrfh+cc2zHb4XAVaQeExBr7KqFxAfCRDRtxCguB2+LwEBrzZSzx+m+oDt+7T6ABRx/Q2xzai+BwOj098odEdW0qWhkd4pcxOJsFznHdgCAuZviSoFdT6oEe7eQnhAeDS2RlSIVexUNIM=
Date: Mon, 30 Oct 2006 23:57:01 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Neil Brown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Trond Myklebust <Trond.Myklebust@netapp.com>,
       linux-kernel@vger.kernel.org, Andy Adamson <andros@citi.umich.edu>,
       "J. Bruce Fields" <bfields@citi.umich.edu>,
       Olaf Kirch <okir@monad.swb.de>
Subject: [PATCH -mm] sunrpc/auth_gss: auth_domain refcount fix
Message-ID: <20061030145701.GB7258@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Neil Brown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
	Trond Myklebust <Trond.Myklebust@netapp.com>,
	linux-kernel@vger.kernel.org, Andy Adamson <andros@citi.umich.edu>,
	"J. Bruce Fields" <bfields@citi.umich.edu>,
	Olaf Kirch <okir@monad.swb.de>
References: <20061028185554.GM9973@localhost> <20061029133551.GA10072@localhost> <20061029133700.GA10295@localhost> <1162153319.5545.62.camel@lade.trondhjem.org> <17733.37127.64785.591939@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17733.37127.64785.591939@cse.unsw.edu.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 04:43:35PM +1100, Neil Brown wrote:

> 1/ We were adding to the refcount when inserting in the hash table,
>    but only removing from the hashtable when the refcount reached zero.
>    Obviously it never would.  So don't count the implied reference of
>    being in the hash table.

...

> diff .prev/net/sunrpc/svcauth.c ./net/sunrpc/svcauth.c
> --- .prev/net/sunrpc/svcauth.c	2006-10-30 15:41:10.000000000 +1100
> +++ ./net/sunrpc/svcauth.c	2006-10-30 16:12:00.000000000 +1100
> @@ -148,10 +148,8 @@ auth_domain_lookup(char *name, struct au
>  			return hp;
>  		}
>  	}
> -	if (new) {
> +	if (new)
>  		hlist_add_head(&new->hash, head);
> -		kref_get(&new->ref);
> -	}
>  	spin_unlock(&auth_domain_lock);
>  	return new;
>  }

This refcount change affects [PATCH 2/2].
(http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc3/2.6.19-rc3-mm1/broken-out/auth_gss-unregister-gss_domain-when-unloading-module.patch)

Subject: sunrpc/auth_gss: auth_domain refcount fix

auth_domain_lookup() has been changed not to increase refcount when
inserting in the hash table.

Cc: Neil Brown <neilb@suse.de>
Cc: Andy Adamson <andros@citi.umich.edu>
Cc: J. Bruce Fields <bfields@citi.umich.edu>
Cc: Trond Myklebust <Trond.Myklebust@netapp.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Index: 2.6-mm/net/sunrpc/auth_gss/svcauth_gss.c
===================================================================
--- 2.6-mm.orig/net/sunrpc/auth_gss/svcauth_gss.c
+++ 2.6-mm/net/sunrpc/auth_gss/svcauth_gss.c
@@ -770,7 +770,6 @@ svcauth_gss_register_pseudoflavor(u32 ps
 		kfree(new->h.name);
 		goto out_free_dom;
 	}
-	auth_domain_put(&new->h);
 	return 0;
 
 out_free_dom:


