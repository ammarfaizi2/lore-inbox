Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbWGKXaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWGKXaW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 19:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWGKXaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 19:30:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1205 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751011AbWGKXaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 19:30:21 -0400
Date: Tue, 11 Jul 2006 16:32:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: dev@sw.ru, linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru,
       devel@openvz.org
Subject: Re: [PATCH] struct file leakage
Message-Id: <20060711163254.5ac8941b.akpm@osdl.org>
In-Reply-To: <1152619446.5745.16.camel@lade.trondhjem.org>
References: <44B2185F.1060402@sw.ru>
	<20060710030526.fdb1ca27.akpm@osdl.org>
	<1152619446.5745.16.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> > > -	if (error)
> > > +	if (error) {
> > > +		/* Does someone understand code flow here? Or it is only
> > > +		 * me so stupid? Anathema to whoever designed this non-sense
> > > +		 * with "intent.open".
> > > +		 */
> > > +		if (!IS_ERR(nd->intent.open.file))
> > > +			release_open_intent(nd);
> > >  		return error;
> > > +	}
> > >  	nd->flags &= ~LOOKUP_PARENT;
> > >  	if (nd->last_type == LAST_BIND)
> > >  		goto ok;
> > > 
> > 
> > It's good to have some more Alexeycomments in the tree.
> > 
> > I wonder if we're also needing a path_release() here.  And if not, whether
> > it is still safe to run release_open_intent() against this nameidata?
> > 
> > Hopefully Trond can recall what's going on in there...
> 
> The patch looks correct, except that I believe we can skip the IS_ERR()
> test there: if we're following links then we presumably have not tried
> to open any files yet, so the call to release_open_intent(nd) can be
> made unconditional.

Sorry, but phrases like "looks correct" and "I believe" don't inspire
confidence.  (Although what you say looks correct ;)) Are you sure?

And do we also need a path_release(nd) in there?
