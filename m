Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030438AbVIVQiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030438AbVIVQiv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 12:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030439AbVIVQiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 12:38:51 -0400
Received: from postage-due.permabit.com ([66.228.95.230]:11925 "EHLO
	postage-due.permabit.com") by vger.kernel.org with ESMTP
	id S1030438AbVIVQiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 12:38:50 -0400
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Peter Staubach <staubach@redhat.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs client: handle long symlinks properly
References: <20050922161420.GC5588@dmt.cnet>
	<1127406811.8365.8.camel@lade.trondhjem.org>
From: Assar <assar@permabit.com>
Date: 22 Sep 2005 12:38:18 -0400
In-Reply-To: <1127406811.8365.8.camel@lade.trondhjem.org>
Message-ID: <78u0gd2h39.fsf@sober-counsel.permabit.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Permabit-Spam: SKIPPED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> writes:
> > diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
> > --- a/fs/nfs/nfs2xdr.c
> > +++ b/fs/nfs/nfs2xdr.c
> > @@ -571,8 +571,11 @@ nfs_xdr_readlinkres(struct rpc_rqst *req
> >         strlen = (u32*)kmap(rcvbuf->pages[0]);
> >         /* Convert length of symlink */
> >         len = ntohl(*strlen);
> > -       if (len > rcvbuf->page_len)
> > -               len = rcvbuf->page_len;
> > +       if (len >= rcvbuf->page_len - sizeof(u32) || len > NFS2_MAXPATHLEN) {
> 
> Shouldn't that be
> 
> 	if (len > rcvbuf->page_len - sizeof(u32) || len > NFS2_MAXPATHLEN)
> 
> ? As long as we use page_len == PAGE_SIZE, we probably don't care, but
> if someone some day decides to set a different value for page_len, then
> we want to make sure that we don't end up overflowing the buffer when we
> NUL-terminate.

Wouldn't len == rcvbuf->page_len - sizeof(u32) mean that there isn't
room for writing the terminating NUL?
