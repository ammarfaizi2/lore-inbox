Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbWJ3PRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbWJ3PRi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 10:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030426AbWJ3PRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 10:17:38 -0500
Received: from mx2.netapp.com ([216.240.18.37]:11848 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1030393AbWJ3PRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 10:17:37 -0500
X-IronPort-AV: i="4.09,371,1157353200"; 
   d="scan'208"; a="422835935:sNHT18061208"
Subject: Re: [PATCH 2/2] auth_gss: unregister gss_domain when unloading
	module
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andy Adamson <andros@citi.umich.edu>,
       "J. Bruce Fields" <bfields@citi.umich.edu>,
       Olaf Kirch <okir@monad.swb.de>
In-Reply-To: <20061030145404.GA7258@localhost>
References: <20061028185554.GM9973@localhost>
	 <20061029133551.GA10072@localhost> <20061029133700.GA10295@localhost>
	 <20061029133816.GB10295@localhost>
	 <1162152960.5545.57.camel@lade.trondhjem.org>
	 <20061030145404.GA7258@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Mon, 30 Oct 2006 10:17:29 -0500
Message-Id: <1162221449.5517.70.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 30 Oct 2006 15:17:29.0853 (UTC) FILETIME=[83EEB2D0:01C6FC36]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-30 at 23:54 +0900, Akinobu Mita wrote:
> On Sun, Oct 29, 2006 at 03:15:59PM -0500, Trond Myklebust wrote:
> 
> > > +void svcauth_gss_unregister_pseudoflavor(char *name)
> > > +{
> > > +	struct auth_domain *dom;
> > > +
> > > +	dom = auth_domain_find(name);
> > > +	if (dom) {
> > > +		auth_domain_put(dom);
> > > +		auth_domain_put(dom);
> > > +	}
> > > +}
> > 
> > Strictly speaking, if you want to be smp-safe, you probably need
> > something like the following:
> > 
> > 	dom = auth_domain_find(name);
> > 	if (dom) {
> > 		spin_lock(&auth_domain_lock);
> > 		if (!hlist_unhashed(dom->hash)) {
> > 			hlist_del_init(dom->hash);
> > 			spin_unlock(&auth_domain_lock);
> > 			auth_domain_put(dom);
> > 		} else
> > 			spin_unlock(&auth_domain_lock);
> > 		auth_domain_put(dom);
> > 	}
> > 
> > and then add a test for hlist_unhashed into auth_domain_put(). If not,
> > some other processor could race you inside
> > svcauth_gss_unregister_pseudoflavor.
> 
> But auth_domain_table is protected by auth_domain_lock while we are
> using auth_domain_put()/auth_domain_lookup()/auth_domain_find().
> So I think there is not big difference.

No. The auth_domain_lock was released after the call to
auth_domain_find(), and thus there is no guarantee that the entry is
still referenced when you get round to that second call to
auth_domain_put(). Testing for hlist_unhashed() and then removing the
entry from the lookup table while under the spin lock fixes this
problem: it ensures that you only call auth_domain_put() once if some
other process has raced you.

Actually, making a helper "auth_domain_find_and_unhash()" would probably
be even more efficient in this case, since that would enable you to
reduce the auth_domain_lock usage further.

Cheers,
  Trond
