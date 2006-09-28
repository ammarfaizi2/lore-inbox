Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWI1Dll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWI1Dll (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 23:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWI1Dlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 23:41:40 -0400
Received: from cantor2.suse.de ([195.135.220.15]:10113 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751265AbWI1Dlj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 23:41:39 -0400
From: Neil Brown <neilb@suse.de>
To: "J. Bruce Fields" <bfields@fieldses.org>
Date: Thu, 28 Sep 2006 13:41:27 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17691.17511.884028.425714@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Greg Banks <gnb@melbourne.sgi.com>
Subject: Re: [NFS] [PATCH 008 of 11] knfsd: Prepare knfsd for support of
	rsize/wsize of up to 1MB, over TCP.
In-Reply-To: message from J. Bruce Fields on Monday September 25
References: <20060824162917.3600.patches@notabene>
	<1060824063711.5008@suse.de>
	<20060925154316.GA17465@fieldses.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday September 25, bfields@fieldses.org wrote:
> On Thu, Aug 24, 2006 at 04:37:11PM +1000, NeilBrown wrote:
> > The limit over UDP remains at 32K.  Also, make some of
> > the apparently arbitrary sizing constants clearer.
> > 
> > The biggest change here involves replacing NFSSVC_MAXBLKSIZE
> > by a function of the rqstp.  This allows it to be different
> > for different protocols (udp/tcp) and also allows it
> > to depend on the servers declared sv_bufsiz.
> > 
> > Note that we don't actually increase sv_bufsz for nfs yet.
> > That comes next.
> 
> This patch has some problems.  (Apologies for being so slow to look at
> them!)

Problems. Yes.  It makes my brain hurt for one!  We have various
things called a 'size' with some being rounded up version of others
and ... ARG.

> 
> We're reporting svc_max_payload(rqstp) as the server's maximum
> read/write block size:
> 
> > @@ -538,15 +539,16 @@ nfsd3_proc_fsinfo(struct svc_rqst * rqst
> >  					   struct nfsd3_fsinfores *resp)
> >  {
> >  	int	nfserr;
> > +	u32	max_blocksize = svc_max_payload(rqstp);
...
> 
> But svc_max_payload() usually returns sv_bufsz in the TCP case:
> 
...
> 
> That's the *total* size of the buffer for holding requests and replies.

Yes... for consistency with nfsd_create_serv, this should probably
be
   max_blocksize = svc_max_payload(rqstp) - (NFSD_BUFSIZE - NFSSVC_MAXBLKSIZE);

as (NFSD_BUFSIZE - NFSSVC_MAXBLKSIZE) have been determined to be the
maximum overhead in a read reply / write request.

> > -#define NFSD_BUFSIZE		(1024 + NFSSVC_MAXBLKSIZE)
> > +/*
> > + * Largest number of bytes we need to allocate for an NFS
> > + * call or reply.  Used to control buffer sizes.  We use
> > + * the length of v3 WRITE, READDIR and READDIR replies
> > + * which are an RPC header, up to 26 XDR units of reply
> > + * data, and some page data.
> > + *
> > + * Note that accuracy here doesn't matter too much as the
> > + * size is rounded up to a page size when allocating space.
> > + */
> 
> Is the rounding up *always* going to increase the size?  And if not,
> then why doesn't accuracy matter?
> 
> > +#define NFSD_BUFSIZE		((RPC_MAX_HEADER_WITH_AUTH+26)*XDR_UNIT + NFSSVC_MAXBLKSIZE)

Well the code in svc_init_buffer says:
	pages = 2 + (size+ PAGE_SIZE -1) / PAGE_SIZE;
So it doesn't just round up, but adds one page.  It might look like it
is adding 2 pages, but one of those is for the message in the other
direction.
It is really one page for the request, one page for the reply, and
N pages for the data.  So why do we add all that padding to
NFSD_BUFSIZE?
I'm not sure.  I think there is a good reason, but as I said - it
makes my brain hurt.

And the above comment only mentions v3.  v4 could presumably have lots
more overhead.  A 'write' could be in compound with lots of other
stuff, and if we say we can handle a 32k write, might the client send
a 40K message with 8k of UNLINK requests???

> 
> No doubt we have lots of wiggle room here, but I'd rather we didn't
> decrease that size without seeing a careful analysis.

Yes. careful analysis.  That sounds like a good idea.
I'll race you ... but I hope you win :-)

NeilBrown
