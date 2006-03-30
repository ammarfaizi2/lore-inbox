Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbWC3SBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWC3SBL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 13:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWC3SBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 13:01:10 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:40890 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750923AbWC3SBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 13:01:09 -0500
In-Reply-To: <1060330055350.25337@suse.de>
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net, nfs-admin@lists.sourceforge.net
Subject: Re: [NFS] [PATCH] knfsd: Correct reserved reply space for read requests.
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 7.0 HF85 November 04, 2005
Message-ID: <OF66A2887E.D01D36C5-ON88257141.0061C8EF-88257141.00626357@us.ibm.com>
From: Marc Eshel <eshel@almaden.ibm.com>
Date: Thu, 30 Mar 2006 09:58:44 -0800
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Release 7.0.1HF18 | February 28, 2006) at
 03/30/2006 13:00:50,
	Serialize complete at 03/30/2006 13:00:50
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil
Can we use this opportunity to change NFSSVC_MAXBLKSIZE from 32K to 64K to 
match RPCSVC_MAXPAYLOAD. It makes real difference in I/O performance (we 
will still be saving half the space we used to allocate :).
Thanks, Marc. 

NeilBrown wrote on 03/29/2006 09:53:50 PM:

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
> not critical, so it would be best for it to spend a while in -mm 
> before going in to mainline.
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
> --- ./fs/nfsd/nfs3proc.c~current~   2006-03-30 16:48:30.000000000 +1100
> +++ ./fs/nfsd/nfs3proc.c   2006-03-30 16:48:58.000000000 +1100
> @@ -682,7 +682,7 @@ static struct svc_procedure      nfsd_proced
>    PROC(lookup,    dirop,      dirop,      fhandle2, RC_NOCACHE, 
> ST+FH+pAT+pAT),
>    PROC(access,    access,   access,      fhandle,  RC_NOCACHE, 
ST+pAT+1),
>    PROC(readlink, readlink,   readlink,   fhandle,  RC_NOCACHE, 
> ST+pAT+1+NFS3_MAXPATHLEN/4),
> -  PROC(read,    read,      read,      fhandle,  RC_NOCACHE, 
> ST+pAT+4+NFSSVC_MAXBLKSIZE),
> +  PROC(read,    read,      read,      fhandle,  RC_NOCACHE, 
> ST+pAT+4+NFSSVC_MAXBLKSIZE/4),
>    PROC(write,    write,      write,      fhandle,  RC_REPLBUFF, 
ST+WC+4),
>    PROC(create,    create,   create,      fhandle2, RC_REPLBUFF, 
> ST+(1+FH+pAT)+WC),
>    PROC(mkdir,    mkdir,      create,      fhandle2, RC_REPLBUFF, 
> ST+(1+FH+pAT)+WC),
> 
> diff ./fs/nfsd/nfs4proc.c~current~ ./fs/nfsd/nfs4proc.c
> --- ./fs/nfsd/nfs4proc.c~current~   2006-03-30 16:48:30.000000000 +1100
> +++ ./fs/nfsd/nfs4proc.c   2006-03-30 16:48:58.000000000 +1100
> @@ -973,7 +973,7 @@ struct nfsd4_voidargs { int dummy; };
>   */
>  static struct svc_procedure      nfsd_procedures4[2] = {
>    PROC(null,    void,      void,      void,     RC_NOCACHE, 1),
> -  PROC(compound, compound,   compound,   compound, RC_NOCACHE, 
NFSD_BUFSIZE)
> +  PROC(compound, compound,   compound,   compound, RC_NOCACHE, 
> NFSD_BUFSIZE/4)
>  };
> 
>  struct svc_version   nfsd_version4 = {
> 
> diff ./fs/nfsd/nfsproc.c~current~ ./fs/nfsd/nfsproc.c
> --- ./fs/nfsd/nfsproc.c~current~   2006-03-30 16:48:30.000000000 +1100
> +++ ./fs/nfsd/nfsproc.c   2006-03-30 16:48:58.000000000 +1100
> @@ -553,7 +553,7 @@ static struct svc_procedure      nfsd_proced
>    PROC(none,    void,      void,      none,      RC_NOCACHE, ST),
>    PROC(lookup,    diropargs,   diropres,   fhandle,   RC_NOCACHE, 
ST+FH+AT),
>    PROC(readlink, readlinkargs,   readlinkres,   none, 
> RC_NOCACHE, ST+1+NFS_MAXPATHLEN/4),
> -  PROC(read,    readargs,   readres,   fhandle,   RC_NOCACHE, 
> ST+AT+1+NFSSVC_MAXBLKSIZE),
> +  PROC(read,    readargs,   readres,   fhandle,   RC_NOCACHE, 
> ST+AT+1+NFSSVC_MAXBLKSIZE/4),
>    PROC(none,    void,      void,      none,      RC_NOCACHE, ST),
>    PROC(write,    writeargs,   attrstat,   fhandle,   RC_REPLBUFF, 
ST+AT),
>    PROC(create,    createargs,   diropres,   fhandle, 
RC_REPLBUFF,ST+FH+AT),
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting 
language
> that extends applications into web and mobile media. Attend the live 
webcast
> and join the prime developer group breaking into this new coding 
territory!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
> _______________________________________________
> NFS maillist  -  NFS@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/nfs

