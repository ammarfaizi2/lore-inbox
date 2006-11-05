Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161688AbWKETpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161688AbWKETpt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 14:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161689AbWKETpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 14:45:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64484 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161688AbWKETps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 14:45:48 -0500
Date: Sun, 5 Nov 2006 11:45:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, riesebie@lxtec.de
Cc: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
       Andy Adamson <andros@citi.umich.edu>,
       "J. Bruce Fields" <bfields@citi.umich.edu>,
       Trond Myklebust <Trond.Myklebust@netapp.com>,
       Olaf Kirch <okir@monad.swb.de>
Subject: Re: [PATCH 1/2] sunrpc: add missing spin_unlock
Message-Id: <20061105114533.4f57f333.akpm@osdl.org>
In-Reply-To: <1162744516.26989.43.camel@twins>
References: <20061028185554.GM9973@localhost>
	<20061029133551.GA10072@localhost>
	<20061029133700.GA10295@localhost>
	<1162744516.26989.43.camel@twins>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Nov 2006 17:35:16 +0100
Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> On Sun, 2006-10-29 at 22:37 +0900, Akinobu Mita wrote:
> > auth_domain_put() forgot to unlock acquired spinlock.
> > 
> > Cc: Olaf Kirch <okir@monad.swb.de>
> > Cc: Andy Adamson <andros@citi.umich.edu>
> > Cc: J. Bruce Fields <bfields@citi.umich.edu>
> > Cc: Trond Myklebust <Trond.Myklebust@netapp.com>
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> 
> Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> 
> I just found this too while trying to get .19-rc4-git up and running on
> a machine here - took me a few hours.
> 
> It made my kernel decidedly unhappy :-(
> 
> Andrew, could you push this and:
>   http://lkml.org/lkml/2006/11/3/109
> into .19 still? - those patches are needed to make todays git happy on
> my machine.

OK.

> > Index: work-fault-inject/net/sunrpc/svcauth.c
> > ===================================================================
> > --- work-fault-inject.orig/net/sunrpc/svcauth.c
> > +++ work-fault-inject/net/sunrpc/svcauth.c
> > @@ -126,6 +126,7 @@ void auth_domain_put(struct auth_domain 
> >  	if (atomic_dec_and_lock(&dom->ref.refcount, &auth_domain_lock)) {
> >  		hlist_del(&dom->hash);
> >  		dom->flavour->domain_release(dom);
> > +		spin_unlock(&auth_domain_lock);
> >  	}
> >  }

I wonder if this will fix http://bugzilla.kernel.org/show_bug.cgi?id=7457
