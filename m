Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbWC3HSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWC3HSE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 02:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWC3HSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 02:18:04 -0500
Received: from pat.uio.no ([129.240.10.6]:58806 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751050AbWC3HSC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 02:18:02 -0500
Subject: Re: [PATCH] knfsd: Correct reserved reply space for read requests.
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <1060330055350.25337@suse.de>
References: <20060330165307.25307.patches@notabene>
	 <1060330055350.25337@suse.de>
Content-Type: text/plain
Date: Thu, 30 Mar 2006 02:17:31 -0500
Message-Id: <1143703051.8129.2.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.117, required 12,
	autolearn=disabled, AWL 1.70, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-30 at 16:53 +1100, NeilBrown wrote:
> Single patch for nfsd in 2.6.16.  As the comment say, it is sensible
> for this to sit in -mm for a while just in case.
> 
> ### Comments for Changeset
> 
> NFSd makes sure there is enough space to hold the maximum possible
> reply before accepting a request.  The units for this maximum is
> (4byte) words.  However in three places, particularly for read
> request, the number given is a number of bytes.
> 
> This means too much space is reserved which is slightly wasteful.
> 
> This is the sort of patch that could uncover a deeper bug, and it is
> not critical, so it would be best for it to spend a while in -mm before going in to mainline.
> 
> Discovered-by: "Eivind  Sarto" <ivan@kasenna.com>
> 
> Cc: "Eivind  Sarto" <ivan@kasenna.com>
> 
> Signed-off-by: Neil Brown <neilb@suse.de>
> 
> ### Diffstat output
>  ./fs/nfsd/nfs3proc.c |    2 +-
>  ./fs/nfsd/nfs4proc.c |    2 +-
>  ./fs/nfsd/nfsproc.c  |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff ./fs/nfsd/nfs3proc.c~current~ ./fs/nfsd/nfs3proc.c
> --- ./fs/nfsd/nfs3proc.c~current~	2006-03-30 16:48:30.000000000 +1100
> +++ ./fs/nfsd/nfs3proc.c	2006-03-30 16:48:58.000000000 +1100
> @@ -682,7 +682,7 @@ static struct svc_procedure		nfsd_proced
>    PROC(lookup,	 dirop,		dirop,		fhandle2, RC_NOCACHE, ST+FH+pAT+pAT),
>    PROC(access,	 access,	access,		fhandle,  RC_NOCACHE, ST+pAT+1),
>    PROC(readlink, readlink,	readlink,	fhandle,  RC_NOCACHE, ST+pAT+1+NFS3_MAXPATHLEN/4),
> -  PROC(read,	 read,		read,		fhandle,  RC_NOCACHE, ST+pAT+4+NFSSVC_MAXBLKSIZE),
> +  PROC(read,	 read,		read,		fhandle,  RC_NOCACHE, ST+pAT+4+NFSSVC_MAXBLKSIZE/4),

Hmm... Wouldn't it be safer to use XDR_QUADLEN()? I doubt that we will
ever set a NFSSVC_MAXBLKSIZE that is not divisible by 4, but...

>    PROC(write,	 write,		write,		fhandle,  RC_REPLBUFF, ST+WC+4),
>    PROC(create,	 create,	create,		fhandle2, RC_REPLBUFF, ST+(1+FH+pAT)+WC),
>    PROC(mkdir,	 mkdir,		create,		fhandle2, RC_REPLBUFF, ST+(1+FH+pAT)+WC),
> 
> diff ./fs/nfsd/nfs4proc.c~current~ ./fs/nfsd/nfs4proc.c
> --- ./fs/nfsd/nfs4proc.c~current~	2006-03-30 16:48:30.000000000 +1100
> +++ ./fs/nfsd/nfs4proc.c	2006-03-30 16:48:58.000000000 +1100
> @@ -973,7 +973,7 @@ struct nfsd4_voidargs { int dummy; };
>   */
>  static struct svc_procedure		nfsd_procedures4[2] = {
>    PROC(null,	 void,		void,		void,	  RC_NOCACHE, 1),
> -  PROC(compound, compound,	compound,	compound, RC_NOCACHE, NFSD_BUFSIZE)
> +  PROC(compound, compound,	compound,	compound, RC_NOCACHE, NFSD_BUFSIZE/4)

Ditto...

>  };
>  
>  struct svc_version	nfsd_version4 = {
> 
> diff ./fs/nfsd/nfsproc.c~current~ ./fs/nfsd/nfsproc.c
> --- ./fs/nfsd/nfsproc.c~current~	2006-03-30 16:48:30.000000000 +1100
> +++ ./fs/nfsd/nfsproc.c	2006-03-30 16:48:58.000000000 +1100
> @@ -553,7 +553,7 @@ static struct svc_procedure		nfsd_proced
>    PROC(none,	 void,		void,		none,		RC_NOCACHE, ST),
>    PROC(lookup,	 diropargs,	diropres,	fhandle,	RC_NOCACHE, ST+FH+AT),
>    PROC(readlink, readlinkargs,	readlinkres,	none,		RC_NOCACHE, ST+1+NFS_MAXPATHLEN/4),
> -  PROC(read,	 readargs,	readres,	fhandle,	RC_NOCACHE, ST+AT+1+NFSSVC_MAXBLKSIZE),
> +  PROC(read,	 readargs,	readres,	fhandle,	RC_NOCACHE, ST+AT+1+NFSSVC_MAXBLKSIZE/4),
>    PROC(none,	 void,		void,		none,		RC_NOCACHE, ST),
>    PROC(write,	 writeargs,	attrstat,	fhandle,	RC_REPLBUFF, ST+AT),
>    PROC(create,	 createargs,	diropres,	fhandle,	RC_REPLBUFF, ST+FH+AT),

Cheers,
  Trond

