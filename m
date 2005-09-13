Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbVIMSxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbVIMSxQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 14:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbVIMSxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 14:53:16 -0400
Received: from postage-due.permabit.com ([66.228.95.230]:49815 "EHLO
	postage-due.permabit.com") by vger.kernel.org with ESMTP
	id S964981AbVIMSxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 14:53:16 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs client, kernel 2.4.31: readlink result overflow
References: <78irx6wh6j.fsf@sober-counsel.permabit.com>
	<200509121846.j8CIk5YE025124@turing-police.cc.vt.edu>
	<784q8qrsad.fsf@sober-counsel.permabit.com>
	<200509122001.j8CK1kpW028651@turing-police.cc.vt.edu>
	<788xy2qas0.fsf@sober-counsel.permabit.com>
	<20050913183948.GE14889@dmt.cnet>
From: Assar <assar@permabit.com>
Date: 13 Sep 2005 14:52:44 -0400
In-Reply-To: <20050913183948.GE14889@dmt.cnet>
Message-ID: <784q8okdfn.fsf@sober-counsel.permabit.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Permabit-Spam: SKIPPED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marcelo.

Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:
> > diff -u linux-2.4.31.orig/fs/nfs/nfs2xdr.c linux-2.4.31/fs/nfs/nfs2xdr.c
> > --- linux-2.4.31.orig/fs/nfs/nfs2xdr.c	2002-11-28 18:53:15.000000000 -0500
> > +++ linux-2.4.31/fs/nfs/nfs2xdr.c	2005-09-12 16:12:30.000000000 -0400
> > @@ -571,8 +571,8 @@
> >  	strlen = (u32*)kmap(rcvbuf->pages[0]);
> >  	/* Convert length of symlink */
> >  	len = ntohl(*strlen);
> > -	if (len > rcvbuf->page_len)
> > -		len = rcvbuf->page_len;
> > +	if (len > rcvbuf->page_len - sizeof(*strlen) - 1)
> > +		len = rcvbuf->page_len - sizeof(*strlen) - 1;
> 
> So the problem is that the "len" variable encapsulated in (u32 *)rcvbuf->pages[0]
> does not account for its own length (4 bytes)? 

That's one problem.

> If thats the reason, you don't need the "-1" there?

It also writes a 0 byte.  I think it looks like this:

---- ------------ -
len  string...    0

