Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965559AbWJCBgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965559AbWJCBgv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 21:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965560AbWJCBgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 21:36:51 -0400
Received: from cantor2.suse.de ([195.135.220.15]:50135 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965559AbWJCBgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 21:36:50 -0400
From: Neil Brown <neilb@suse.de>
To: "J. Bruce Fields" <bfields@fieldses.org>
Date: Tue, 3 Oct 2006 11:36:32 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17697.48800.933642.581926@cse.unsw.edu.au>
Cc: NeilBrown <neilb@suse.de>, nfs@lists.sourceforge.net,
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
> 
> We're reporting svc_max_payload(rqstp) as the server's maximum
> read/write block size:

Yes.  So I'm going to change the number returned by
svc_max_payload(rqstp) to mean the maximum read/write block size.
i.e. when a service is created, the number passed isn't the maximum
packet size, but is the maximum payload size.
The assumption is that all of the request that is not payload will fit
into one page, and all of the reply that is not payload will also fit
into one page (though a different page).

It means that RPC services that have lots of non-payload data combined
with payload data won't work, but making sunrpc code completely
general when there are only two users is just too painful.

The only real problem is that NFSv4 can have arbitrarily large
non-payload data, and arbitrarily many payloads.  But I guess any
client that trying to send two full-sized payloads in the one request
is asking for trouble (I don't suppose the RPC spells this out at
all?).

> 
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
> 
> I think this results in 80 less bytes less than before, I think.
> 
> No doubt we have lots of wiggle room here, but I'd rather we didn't
> decrease that size without seeing a careful analysis.

The above change makes this loss in bytes irrelevant. NFSD_BUFSIZE
will now only be used once - near the end of nfs4proc.c and there if
it is wrong you just get a warning.

And the fact that the code change to effect this is so tiny seems to
imply that most of the code was already assuming that sv_bufsz was
really the payload size rather than the packet size.

So this is my proposed 'fix' for
	knfsd-prepare-knfsd-for-support-of-rsize-wsize-of-up-to-1mb-over-tcp.patch.

NeilBrown

------------
Make sv_bufsiz really be the payload size for rpc requests.

svc.c already allocated 2 extra pages for the request and the reply,
so it is perfectly consistent to assume that the size passed to
svc_create_pooled is the size of the payload.  This means that
the number returned by svc_max_payload - and thus returned to the client
as the maxiumu IO size - is exactly the chosen max block size.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfssvc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff .prev/fs/nfsd/nfssvc.c ./fs/nfsd/nfssvc.c
--- .prev/fs/nfsd/nfssvc.c	2006-09-29 11:57:27.000000000 +1000
+++ ./fs/nfsd/nfssvc.c	2006-10-03 11:23:11.000000000 +1000
@@ -217,7 +217,7 @@ int nfsd_create_serv(void)
 
 	atomic_set(&nfsd_busy, 0);
 	nfsd_serv = svc_create_pooled(&nfsd_program,
-				      NFSD_BUFSIZE - NFSSVC_MAXBLKSIZE + nfsd_max_blksize,
+				      nfsd_max_blksize,
 				      nfsd_last_thread,
 				      nfsd, SIG_NOCLEAN, THIS_MODULE);
 	if (nfsd_serv == NULL)
