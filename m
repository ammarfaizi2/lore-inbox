Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161536AbWJaDPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161536AbWJaDPe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 22:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161540AbWJaDPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 22:15:34 -0500
Received: from nz-out-0102.google.com ([64.233.162.192]:29718 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161536AbWJaDPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 22:15:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oS3qGwH+NMH2yjjV5m9qVZfO5kqqau0GmfXt10eN9/mkJbfDW2hhqUtMNOvp9WL0Q8WjK5yLrHiQ4fYRnZDJhI4+U0g9u7HU6c5zhaJN8hJVWC1d8XbzYzZU6HZtRq9foA8gCSVZsb1IIF7FmVHR1sahCFmlAFPJGqziXynnZHU=
Message-ID: <961aa3350610301915i5a954dbemd5420a350fd0c625@mail.gmail.com>
Date: Tue, 31 Oct 2006 12:15:32 +0900
From: "Akinobu Mita" <akinobu.mita@gmail.com>
To: "Trond Myklebust" <Trond.Myklebust@netapp.com>
Subject: Re: [PATCH 2/2] auth_gss: unregister gss_domain when unloading module
Cc: linux-kernel@vger.kernel.org, "Andy Adamson" <andros@citi.umich.edu>,
       "J. Bruce Fields" <bfields@citi.umich.edu>,
       "Olaf Kirch" <okir@monad.swb.de>
In-Reply-To: <1162221449.5517.70.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061028185554.GM9973@localhost>
	 <20061029133551.GA10072@localhost> <20061029133700.GA10295@localhost>
	 <20061029133816.GB10295@localhost>
	 <1162152960.5545.57.camel@lade.trondhjem.org>
	 <20061030145404.GA7258@localhost>
	 <1162221449.5517.70.camel@lade.trondhjem.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/10/31, Trond Myklebust <Trond.Myklebust@netapp.com>:
> On Mon, 2006-10-30 at 23:54 +0900, Akinobu Mita wrote:
> > On Sun, Oct 29, 2006 at 03:15:59PM -0500, Trond Myklebust wrote:
> >
> > > > +void svcauth_gss_unregister_pseudoflavor(char *name)
> > > > +{
> > > > + struct auth_domain *dom;
> > > > +
> > > > + dom = auth_domain_find(name);
> > > > + if (dom) {
> > > > +         auth_domain_put(dom);
> > > > +         auth_domain_put(dom);
> > > > + }
> > > > +}
> > >
> > > Strictly speaking, if you want to be smp-safe, you probably need
> > > something like the following:
> > >
> > >     dom = auth_domain_find(name);
> > >     if (dom) {
> > >             spin_lock(&auth_domain_lock);
> > >             if (!hlist_unhashed(dom->hash)) {
> > >                     hlist_del_init(dom->hash);
> > >                     spin_unlock(&auth_domain_lock);
> > >                     auth_domain_put(dom);
> > >             } else
> > >                     spin_unlock(&auth_domain_lock);
> > >             auth_domain_put(dom);
> > >     }
> > >
> > > and then add a test for hlist_unhashed into auth_domain_put(). If not,
> > > some other processor could race you inside
> > > svcauth_gss_unregister_pseudoflavor.
> >
> > But auth_domain_table is protected by auth_domain_lock while we are
> > using auth_domain_put()/auth_domain_lookup()/auth_domain_find().
> > So I think there is not big difference.
>
> No. The auth_domain_lock was released after the call to
> auth_domain_find(), and thus there is no guarantee that the entry is
> still referenced when you get round to that second call to
> auth_domain_put(). Testing for hlist_unhashed() and then removing the
> entry from the lookup table while under the spin lock fixes this
> problem: it ensures that you only call auth_domain_put() once if some
> other process has raced you.
>

Thanks, I understand it.

But I noticed that even if we have this kind of smp-safe code, there
is no guarantee that 2nd auth_domain_put() in
svcauth_gss_unregister_pseudoflavor() is the last reference of
this gss_domain.

So it is possible to happen invalid dereference by real last user of
this gss_domain after unloading module. If this is not wrong,
Is it neccesary to have try_get_module()/put_module() somewhere to
prevent this?
