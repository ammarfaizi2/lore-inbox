Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbWCTVhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbWCTVhT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWCTVhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:37:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64212 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964975AbWCTVhR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:37:17 -0500
Date: Mon, 20 Mar 2006 13:34:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: matthew@wil.cx, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make sure nobody's leaking resources
Message-Id: <20060320133407.1e75eafa.akpm@osdl.org>
In-Reply-To: <20060320161007.GA25444@granada.merseine.nu>
References: <20060320155304.GI8980@parisc-linux.org>
	<20060320161007.GA25444@granada.merseine.nu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda <mulix@mulix.org> wrote:
>
> On Mon, Mar 20, 2006 at 08:53:04AM -0700, Matthew Wilcox wrote:
> > 
> > Currently, releasing a resource also releases all of its children.  That
> > made sense when request_resource was the main method of dividing up the
> > memory map.  With the increased use of insert_resource, it seems to me
> > that we should instead reparent the newly orphaned resources.  Before
> > we do that, let's make sure that nobody's actually relying on the current
> > semantics.
> > 
> > Signed-off-by: Matthew Wilcox <matthew@wil.cx>
> > 
> > diff -urpNX dontdiff linus-2.6/kernel/resource.c parisc-2.6/kernel/resource.c
> > --- linus-2.6/kernel/resource.c	2006-03-20 07:29:06.000000000 -0700
> > +++ parisc-2.6/kernel/resource.c	2006-03-20 07:00:47.000000000 -0700
> > @@ -181,6 +181,8 @@ static int __release_resource(struct res
> >  {
> >  	struct resource *tmp, **p;
> >  
> > +	BUG_ON(old->child);
> > +
> 
> Is this expressely forbidden at this stage, or just "not recommended"?
> if the latter, WARN_ON() might be more appropriate.
> 

Yes, there's no way we can make changes like this to either -mm or to
mainline.  Making people's perfectly-working kernels go splat helps neither
them nor us.

A WARN_ON() which shuts itself up after one or three invokations would be
appropriate here.

