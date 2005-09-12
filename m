Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbVILThy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbVILThy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 15:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbVILThx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 15:37:53 -0400
Received: from [66.228.95.230] ([66.228.95.230]:24193 "EHLO
	postage-due.permabit.com") by vger.kernel.org with ESMTP
	id S932168AbVILThx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 15:37:53 -0400
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH] nfs client, kernel 2.4.31: readlink result overflow
References: <78irx6wh6j.fsf@sober-counsel.permabit.com>
	<200509121846.j8CIk5YE025124@turing-police.cc.vt.edu>
From: Assar <assar@permabit.com>
Date: 12 Sep 2005 15:37:46 -0400
In-Reply-To: <200509121846.j8CIk5YE025124@turing-police.cc.vt.edu>
Message-ID: <784q8qrsad.fsf@sober-counsel.permabit.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Permabit-Spam: SKIPPED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu writes:
> Odd, as it has similar code - 2.6.13-mm1 nfs2xdr.c has:
>         /* Convert length of symlink */
>         len = ntohl(*p++);
>         if (len >= rcvbuf->page_len || len <= 0) {

To my reading, the 2.6.13 code does not copy the 4 bytes of length to
rcvbuf.

> Is there some *other* code in 2.6 that prevents this from being a problem,
> if it's a problem on 2.4?
> 
> > diff -u linux-2.4.31.orig/fs/nfs/nfs2xdr.c linux-2.4.31/fs/nfs/nfs2xdr.c
> > --- linux-2.4.31.orig/fs/nfs/nfs2xdr.c	2002-11-28 18:53:15.000000000 -0500
> > +++ linux-2.4.31/fs/nfs/nfs2xdr.c	2005-09-07 17:36:04.000000000 -0400
> > @@ -571,8 +571,8 @@
> >  	strlen = (u32*)kmap(rcvbuf->pages[0]);
> >  	/* Convert length of symlink */
> >  	len = ntohl(*strlen);
> > -	if (len > rcvbuf->page_len)
> > -		len = rcvbuf->page_len;
> > +	if (len > rcvbuf->page_len - 1 - 4)
> > +		len = rcvbuf->page_len - 1 - 4;
> 
> Am I the only one who finds an uncommented "-1 -4" construct scary beyond belief?

Probably not.  What do you think looks better?  sizeof(u32) ?
