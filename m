Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751544AbWIAPb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbWIAPb1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 11:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbWIAPb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 11:31:27 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:58254 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751544AbWIAPb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 11:31:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YgIC16va24PxXJlmyHTKwlbSfudx0wIiaFDl1DM/bhPcDEK+oGbMPnzYOmtD2H8RIEW2btunlwnDoHR2lBA1DKBz58a5qAfZarbnkX/Cacj1mKM7uWwodecMVlk4gcvIrr8pgjs+XlQxCYBEtwMiWNFOq92+C+npM6dwH8LY05k=
Message-ID: <76bd70e30609010831m9e80cfav514d60718d35e7d5@mail.gmail.com>
Date: Fri, 1 Sep 2006 11:31:25 -0400
From: "Chuck Lever" <chucklever@gmail.com>
To: NeilBrown <neilb@suse.de>
Subject: Re: [NFS] [PATCH 019 of 19] knfsd: Register all RPC programs with portmapper by default
Cc: "Andrew Morton" <akpm@osdl.org>, "Olaf Kirch" <okir@suse.de>,
       nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <1060901043948.27677@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060901141639.27206.patches@notabene>
	 <1060901043948.27677@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/06, NeilBrown <neilb@suse.de> wrote:
>
> From: Olaf Kirch <okir@suse.de>
>
>   The NFSACL patches introduced support for multiple RPC services
>   listening on the same transport. However, only the first of these
>   services was registered with portmapper. This was perfectly fine
>   for nfsacl, as you traditionally do not want these to show up in a
>   portmapper listing.
>
>   The patch below changes the default behavior to always register
>   all services listening on a given transport, but retains the
>   old behavior for nfsacl services.

I don't like this.  The idea that multiple RPC services are listening
on the same port is a total hack.  What other service might use this
besides NFSACL?

Does the reference implementation (Solaris) behave this way?

> Signed-off-by: Olaf Kirch <okir@suse.de>
> Signed-off-by: Neil Brown <neilb@suse.de>
>
> ### Diffstat output
>  ./fs/nfsd/nfs2acl.c          |    1 +
>  ./fs/nfsd/nfs3acl.c          |    1 +
>  ./include/linux/sunrpc/svc.h |    3 +++
>  ./net/sunrpc/svc.c           |   37 +++++++++++++++++++++++--------------
>  4 files changed, 28 insertions(+), 14 deletions(-)
>
> diff .prev/fs/nfsd/nfs2acl.c ./fs/nfsd/nfs2acl.c
> --- .prev/fs/nfsd/nfs2acl.c     2006-09-01 12:22:10.000000000 +1000
> +++ ./fs/nfsd/nfs2acl.c 2006-09-01 12:22:11.000000000 +1000
> @@ -333,4 +333,5 @@ struct svc_version  nfsd_acl_version2 = {
>                 .vs_proc        = nfsd_acl_procedures2,
>                 .vs_dispatch    = nfsd_dispatch,
>                 .vs_xdrsize     = NFS3_SVC_XDRSIZE,
> +               .vs_hidden      = 1,
>  };
>
> diff .prev/fs/nfsd/nfs3acl.c ./fs/nfsd/nfs3acl.c
> --- .prev/fs/nfsd/nfs3acl.c     2006-09-01 12:22:10.000000000 +1000
> +++ ./fs/nfsd/nfs3acl.c 2006-09-01 12:22:11.000000000 +1000
> @@ -263,5 +263,6 @@ struct svc_version  nfsd_acl_version3 = {
>                 .vs_proc        = nfsd_acl_procedures3,
>                 .vs_dispatch    = nfsd_dispatch,
>                 .vs_xdrsize     = NFS3_SVC_XDRSIZE,
> +               .vs_hidden      = 1,
>  };
>
>
> diff .prev/include/linux/sunrpc/svc.h ./include/linux/sunrpc/svc.h
> --- .prev/include/linux/sunrpc/svc.h    2006-09-01 12:22:10.000000000 +1000
> +++ ./include/linux/sunrpc/svc.h        2006-09-01 12:22:11.000000000 +1000
> @@ -304,6 +304,9 @@ struct svc_version {
>         struct svc_procedure *  vs_proc;        /* per-procedure info */
>         u32                     vs_xdrsize;     /* xdrsize needed for this version */
>
> +       unsigned int            vs_hidden : 1;  /* Don't register with portmapper.
> +                                                * Only used for nfsacl so far. */
> +
>         /* Override dispatch function (e.g. when caching replies).
>          * A return value of 0 means drop the request.
>          * vs_dispatch == NULL means use default dispatcher.
>
> diff .prev/net/sunrpc/svc.c ./net/sunrpc/svc.c
> --- .prev/net/sunrpc/svc.c      2006-09-01 12:22:11.000000000 +1000
> +++ ./net/sunrpc/svc.c  2006-09-01 12:22:11.000000000 +1000
> @@ -644,23 +644,32 @@ svc_register(struct svc_serv *serv, int
>         unsigned long           flags;
>         int                     i, error = 0, dummy;
>
> -       progp = serv->sv_program;
> -
> -       dprintk("RPC: svc_register(%s, %s, %d)\n",
> -               progp->pg_name, proto == IPPROTO_UDP? "udp" : "tcp", port);
> -
>         if (!port)
>                 clear_thread_flag(TIF_SIGPENDING);
>
> -       for (i = 0; i < progp->pg_nvers; i++) {
> -               if (progp->pg_vers[i] == NULL)
> -                       continue;
> -               error = rpc_register(progp->pg_prog, i, proto, port, &dummy);
> -               if (error < 0)
> -                       break;
> -               if (port && !dummy) {
> -                       error = -EACCES;
> -                       break;
> +       for (progp = serv->sv_program; progp; progp = progp->pg_next) {
> +               for (i = 0; i < progp->pg_nvers; i++) {
> +                       if (progp->pg_vers[i] == NULL)
> +                               continue;
> +
> +                       dprintk("RPC: svc_register(%s, %s, %d, %d)%s\n",
> +                                       progp->pg_name,
> +                                       proto == IPPROTO_UDP?  "udp" : "tcp",
> +                                       port,
> +                                       i,
> +                                       progp->pg_vers[i]->vs_hidden?
> +                                               " (but not telling portmap)" : "");
> +
> +                       if (progp->pg_vers[i]->vs_hidden)
> +                               continue;
> +
> +                       error = rpc_register(progp->pg_prog, i, proto, port, &dummy);
> +                       if (error < 0)
> +                               break;
> +                       if (port && !dummy) {
> +                               error = -EACCES;
> +                               break;
> +                       }
>                 }
>         }
>
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> NFS maillist  -  NFS@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/nfs
>


-- 
"We who cut mere stones must always be envisioning cathedrals"
   -- Quarry worker's creed
