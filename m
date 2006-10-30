Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbWJ3Oxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWJ3Oxb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 09:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbWJ3Oxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 09:53:31 -0500
Received: from wx-out-0506.google.com ([66.249.82.233]:21954 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964965AbWJ3Oxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 09:53:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ooPSvK3BR2joRJNUzqInKJfKwosq2pkNSNpz3lCFB45351pUd3XaQlEBKbz7tBYTX2tI2qc2WefyWDfwJJZlogrH2VjVPBY7Ts9JUHGSCvXSj3yV/K+z+q/FEL7V71WQ2v86OTXPiQRdxu7D2j7IiZQvl2leaXGbe4nfjpjtTEA=
Date: Mon, 30 Oct 2006 23:54:04 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: linux-kernel@vger.kernel.org, Andy Adamson <andros@citi.umich.edu>,
       "J. Bruce Fields" <bfields@citi.umich.edu>,
       Olaf Kirch <okir@monad.swb.de>
Subject: Re: [PATCH 2/2] auth_gss: unregister gss_domain when unloading module
Message-ID: <20061030145404.GA7258@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Trond Myklebust <Trond.Myklebust@netapp.com>,
	linux-kernel@vger.kernel.org, Andy Adamson <andros@citi.umich.edu>,
	"J. Bruce Fields" <bfields@citi.umich.edu>,
	Olaf Kirch <okir@monad.swb.de>
References: <20061028185554.GM9973@localhost> <20061029133551.GA10072@localhost> <20061029133700.GA10295@localhost> <20061029133816.GB10295@localhost> <1162152960.5545.57.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162152960.5545.57.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2006 at 03:15:59PM -0500, Trond Myklebust wrote:

> > +void svcauth_gss_unregister_pseudoflavor(char *name)
> > +{
> > +	struct auth_domain *dom;
> > +
> > +	dom = auth_domain_find(name);
> > +	if (dom) {
> > +		auth_domain_put(dom);
> > +		auth_domain_put(dom);
> > +	}
> > +}
> 
> Strictly speaking, if you want to be smp-safe, you probably need
> something like the following:
> 
> 	dom = auth_domain_find(name);
> 	if (dom) {
> 		spin_lock(&auth_domain_lock);
> 		if (!hlist_unhashed(dom->hash)) {
> 			hlist_del_init(dom->hash);
> 			spin_unlock(&auth_domain_lock);
> 			auth_domain_put(dom);
> 		} else
> 			spin_unlock(&auth_domain_lock);
> 		auth_domain_put(dom);
> 	}
> 
> and then add a test for hlist_unhashed into auth_domain_put(). If not,
> some other processor could race you inside
> svcauth_gss_unregister_pseudoflavor.

But auth_domain_table is protected by auth_domain_lock while we are
using auth_domain_put()/auth_domain_lookup()/auth_domain_find().
So I think there is not big difference.
