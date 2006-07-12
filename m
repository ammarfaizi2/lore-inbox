Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWGLA0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWGLA0X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 20:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWGLA0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 20:26:23 -0400
Received: from pat.uio.no ([129.240.10.4]:53214 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932296AbWGLA0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 20:26:22 -0400
Subject: Re: [PATCH] struct file leakage
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: dev@sw.ru, linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru,
       devel@openvz.org
In-Reply-To: <20060711163254.5ac8941b.akpm@osdl.org>
References: <44B2185F.1060402@sw.ru> <20060710030526.fdb1ca27.akpm@osdl.org>
	 <1152619446.5745.16.camel@lade.trondhjem.org>
	 <20060711163254.5ac8941b.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 20:26:02 -0400
Message-Id: <1152663962.5681.58.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.184, required 12,
	autolearn=disabled, AWL 1.63, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 16:32 -0700, Andrew Morton wrote:
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> >
> > > > -	if (error)
> > > > +	if (error) {
> > > > +		/* Does someone understand code flow here? Or it is only
> > > > +		 * me so stupid? Anathema to whoever designed this non-sense
> > > > +		 * with "intent.open".
> > > > +		 */
> > > > +		if (!IS_ERR(nd->intent.open.file))
> > > > +			release_open_intent(nd);
> > > >  		return error;
> > > > +	}
> > > >  	nd->flags &= ~LOOKUP_PARENT;
> > > >  	if (nd->last_type == LAST_BIND)
> > > >  		goto ok;
> > > > 
> > > 
> > > It's good to have some more Alexeycomments in the tree.
> > > 
> > > I wonder if we're also needing a path_release() here.  And if not, whether
> > > it is still safe to run release_open_intent() against this nameidata?
> > > 
> > > Hopefully Trond can recall what's going on in there...
> > 
> > The patch looks correct, except that I believe we can skip the IS_ERR()
> > test there: if we're following links then we presumably have not tried
> > to open any files yet, so the call to release_open_intent(nd) can be
> > made unconditional.
> 
> Sorry, but phrases like "looks correct" and "I believe" don't inspire
> confidence.  (Although what you say looks correct ;)) Are you sure?

We do need the call to release_open_intent(), since otherwise we will
leak a struct file. The question is whether we can optimise away the
IS_ERR() test. In my opinion, we can.

> And do we also need a path_release(nd) in there?

No. do_follow_link() should release the path for us on error. Replacing
with a 'goto exit' would therefore be a mistake.

Cheers,
  Trond

