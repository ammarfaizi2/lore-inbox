Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965392AbWJ2UQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965392AbWJ2UQT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 15:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965387AbWJ2UQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 15:16:18 -0500
Received: from mx2.netapp.com ([216.240.18.37]:47697 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S965394AbWJ2UQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 15:16:17 -0500
X-IronPort-AV: i="4.09,369,1157353200"; 
   d="scan'208"; a="422611383:sNHT24045364"
Subject: Re: [PATCH 2/2] auth_gss: unregister gss_domain when unloading
	module
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andy Adamson <andros@citi.umich.edu>,
       "J. Bruce Fields" <bfields@citi.umich.edu>,
       Olaf Kirch <okir@monad.swb.de>
In-Reply-To: <20061029133816.GB10295@localhost>
References: <20061028185554.GM9973@localhost>
	 <20061029133551.GA10072@localhost> <20061029133700.GA10295@localhost>
	 <20061029133816.GB10295@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Sun, 29 Oct 2006 15:15:59 -0500
Message-Id: <1162152960.5545.57.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 29 Oct 2006 20:16:00.0954 (UTC) FILETIME=[0D5E11A0:01C6FB97]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-29 at 22:38 +0900, Akinobu Mita wrote:
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
> modules.
> 
> - Define svcauth_gss_unregister_pseudoflavor()
>   (doing the opposite of svcauth_gss_register_pseudoflavor())
> 
> - Call svcauth_gss_unregister_pseudoflavor() in gss_mech_free()
> 
> Cc: Andy Adamson <andros@citi.umich.edu>
> Cc: J. Bruce Fields <bfields@citi.umich.edu>
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
> @@ -60,6 +60,9 @@ gss_mech_free(struct gss_api_mech *gm)
>  
>  	for (i = 0; i < gm->gm_pf_num; i++) {
>  		pf = &gm->gm_pfs[i];
> +		if (!pf->auth_domain_name)
> +			continue;
> +		svcauth_gss_unregister_pseudoflavor(pf->auth_domain_name);
>  		kfree(pf->auth_domain_name);
>  		pf->auth_domain_name = NULL;
>  	}
> @@ -93,8 +96,11 @@ gss_mech_svc_setup(struct gss_api_mech *
>  			goto out;
>  		status = svcauth_gss_register_pseudoflavor(pf->pseudoflavor,
>  							pf->auth_domain_name);
> -		if (status)
> +		if (status) {
> +			kfree(pf->auth_domain_name);
> +			pf->auth_domain_name = NULL;
>  			goto out;
> +		}
>  	}
>  	return 0;
>  out:
> Index: work-fault-inject/net/sunrpc/auth_gss/svcauth_gss.c
> ===================================================================
> --- work-fault-inject.orig/net/sunrpc/auth_gss/svcauth_gss.c
> +++ work-fault-inject/net/sunrpc/auth_gss/svcauth_gss.c
> @@ -765,10 +765,12 @@ svcauth_gss_register_pseudoflavor(u32 ps
>  
>  	test = auth_domain_lookup(name, &new->h);
>  	if (test != &new->h) { /* XXX Duplicate registration? */
> -		auth_domain_put(&new->h);
> -		/* dangling ref-count... */
> -		goto out;
> +		WARN_ON(1);
> +		stat = -EBUSY;
> +		kfree(new->h.name);
> +		goto out_free_dom;
>  	}
> +	auth_domain_put(&new->h);
>  	return 0;
>  
>  out_free_dom:
> @@ -779,6 +781,19 @@ out:
>  
>  EXPORT_SYMBOL(svcauth_gss_register_pseudoflavor);
>  
> +void svcauth_gss_unregister_pseudoflavor(char *name)
> +{
> +	struct auth_domain *dom;
> +
> +	dom = auth_domain_find(name);
> +	if (dom) {
> +		auth_domain_put(dom);
> +		auth_domain_put(dom);
> +	}
> +}

Strictly speaking, if you want to be smp-safe, you probably need
something like the following:

	dom = auth_domain_find(name);
	if (dom) {
		spin_lock(&auth_domain_lock);
		if (!hlist_unhashed(dom->hash)) {
			hlist_del_init(dom->hash);
			spin_unlock(&auth_domain_lock);
			auth_domain_put(dom);
		} else
			spin_unlock(&auth_domain_lock);
		auth_domain_put(dom);
	}

and then add a test for hlist_unhashed into auth_domain_put(). If not,
some other processor could race you inside
svcauth_gss_unregister_pseudoflavor.

However since all this is being done under the BKL, then your
alternative above might be sufficient. The only question then would be
why we need auth_domain_lock?

> +EXPORT_SYMBOL(svcauth_gss_unregister_pseudoflavor);
> +
>  static inline int
>  read_u32_from_xdr_buf(struct xdr_buf *buf, int base, u32 *obj)
>  {
> Index: work-fault-inject/include/linux/sunrpc/svcauth_gss.h
> ===================================================================
> --- work-fault-inject.orig/include/linux/sunrpc/svcauth_gss.h
> +++ work-fault-inject/include/linux/sunrpc/svcauth_gss.h
> @@ -22,6 +22,7 @@
>  int gss_svc_init(void);
>  void gss_svc_shutdown(void);
>  int svcauth_gss_register_pseudoflavor(u32 pseudoflavor, char * name);
> +void svcauth_gss_unregister_pseudoflavor(char *name);
>  
>  #endif /* __KERNEL__ */
>  #endif /* _LINUX_SUNRPC_SVCAUTH_GSS_H */

Cheers,
  Trond
