Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbVIMTlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbVIMTlK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 15:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbVIMTlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 15:41:10 -0400
Received: from hera.kernel.org ([209.128.68.125]:56799 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932400AbVIMTlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 15:41:08 -0400
Date: Tue, 13 Sep 2005 16:35:39 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Assar <assar@permabit.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs client, kernel 2.4.31: readlink result overflow
Message-ID: <20050913193539.GB17222@dmt.cnet>
References: <78irx6wh6j.fsf@sober-counsel.permabit.com> <200509121846.j8CIk5YE025124@turing-police.cc.vt.edu> <784q8qrsad.fsf@sober-counsel.permabit.com> <200509122001.j8CK1kpW028651@turing-police.cc.vt.edu> <788xy2qas0.fsf@sober-counsel.permabit.com> <20050913183948.GE14889@dmt.cnet> <784q8okdfn.fsf@sober-counsel.permabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <784q8okdfn.fsf@sober-counsel.permabit.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 02:52:44PM -0400, Assar wrote:
> Hi, Marcelo.
> 
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:
> > > diff -u linux-2.4.31.orig/fs/nfs/nfs2xdr.c linux-2.4.31/fs/nfs/nfs2xdr.c
> > > --- linux-2.4.31.orig/fs/nfs/nfs2xdr.c	2002-11-28 18:53:15.000000000 -0500
> > > +++ linux-2.4.31/fs/nfs/nfs2xdr.c	2005-09-12 16:12:30.000000000 -0400
> > > @@ -571,8 +571,8 @@
> > >  	strlen = (u32*)kmap(rcvbuf->pages[0]);
> > >  	/* Convert length of symlink */
> > >  	len = ntohl(*strlen);
> > > -	if (len > rcvbuf->page_len)
> > > -		len = rcvbuf->page_len;
> > > +	if (len > rcvbuf->page_len - sizeof(*strlen) - 1)
> > > +		len = rcvbuf->page_len - sizeof(*strlen) - 1;
> > 
> > So the problem is that the "len" variable encapsulated in (u32 *)rcvbuf->pages[0]
> > does not account for its own length (4 bytes)? 
> 
> That's one problem.
> 
> > If thats the reason, you don't need the "-1" there?
> 
> It also writes a 0 byte.  I think it looks like this:
> 
> ---- ------------ -
> len  string...    0

If an overflow happens (len > rcvbuf->page_len) the last character will get 
truncated anyway, so there is no need for the "-1" AFAICS.


