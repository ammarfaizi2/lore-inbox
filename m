Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965351AbWJ2TrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965351AbWJ2TrF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 14:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965360AbWJ2TrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 14:47:05 -0500
Received: from mx2.netapp.com ([216.240.18.37]:62297 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S965351AbWJ2TrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 14:47:03 -0500
X-IronPort-AV: i="4.09,369,1157353200"; 
   d="scan'208"; a="422602527:sNHT288763096"
Subject: Re: [PATCH] auth_gss: unregister gss_domain when unloading module
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andy Adamson <andros@citi.umich.edu>,
       "J. Bruce Fields" <bfields@citi.umich.edu>
In-Reply-To: <20061028185554.GM9973@localhost>
References: <20061028185554.GM9973@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Sun, 29 Oct 2006 14:46:59 -0500
Message-Id: <1162151219.5545.40.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 29 Oct 2006 19:47:23.0606 (UTC) FILETIME=[0DBF8F60:01C6FB93]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-29 at 03:55 +0900, Akinobu Mita wrote:
> Reloading rpcsec_gss_krb5 or rpcsec_gss_spkm3 hit duplicate
> registration in svcauth_gss_register_pseudoflavor().
> (If DEBUG_PAGEALLOC is enabled, oops will happen at
> auth_domain_put() --> hlist_del() with uninitialized hlist_node)
> 
> svcauth_gss_register_pseudoflavor(u32 pseudoflavor, char * name)
> {
> 	...
> 
>         test = auth_domain_lookup(name, &new->h);
>         if (test != &new->h) { /* XXX Duplicate registration? */
>                 auth_domain_put(&new->h);
>                 /* dangling ref-count... */
> 	...
> }
> 
> This patch unregisters gss_domain and free it when unloading
> modules (rpcsec_gss_krb5 or rpcsec_gss_spkm3 module call
> gss_mech_unregister())
> 
> Cc: Andy Adamson <andros@citi.umich.edu>
> Cc: "J. Bruce Fields" <bfields@citi.umich.edu>
> Cc: Trond Myklebust <Trond.Myklebust@netapp.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> 
>  net/sunrpc/auth_gss/gss_mech_switch.c |    4 ++++
>  net/sunrpc/auth_gss/svcauth_gss.c     |    6 +++---
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> Index: work-fault-inject/net/sunrpc/auth_gss/gss_mech_switch.c
> ===================================================================
> --- work-fault-inject.orig/net/sunrpc/auth_gss/gss_mech_switch.c
> +++ work-fault-inject/net/sunrpc/auth_gss/gss_mech_switch.c
> @@ -59,7 +59,11 @@ gss_mech_free(struct gss_api_mech *gm)
>  	int i;
>  
>  	for (i = 0; i < gm->gm_pf_num; i++) {
> +		struct auth_domain *dom;
> +
>  		pf = &gm->gm_pfs[i];
> +		dom = auth_domain_find(pf->auth_domain_name);
> +		auth_domain_put(dom);

Since auth_domain_find() takes a reference on "dom", and
auth_domain_put() releases it, won't this just be a no-op?

>  		kfree(pf->auth_domain_name);
>  		pf->auth_domain_name = NULL;
>  	}
> Index: work-fault-inject/net/sunrpc/auth_gss/svcauth_gss.c
> ===================================================================
> --- work-fault-inject.orig/net/sunrpc/auth_gss/svcauth_gss.c
> +++ work-fault-inject/net/sunrpc/auth_gss/svcauth_gss.c
> @@ -765,9 +765,9 @@ svcauth_gss_register_pseudoflavor(u32 ps
>  
>  	test = auth_domain_lookup(name, &new->h);
>  	if (test != &new->h) { /* XXX Duplicate registration? */
> -		auth_domain_put(&new->h);
> -		/* dangling ref-count... */
> -		goto out;
> +		WARN_ON(1);
> +		kfree(new->h.name);
> +		goto out_free_dom;
>  	}
>  	return 0;
>  

Cheers,
  Trond
