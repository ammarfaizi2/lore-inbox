Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267237AbUHYMtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267237AbUHYMtT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 08:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267226AbUHYMtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 08:49:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38322 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267237AbUHYMtN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 08:49:13 -0400
Date: Wed, 25 Aug 2004 08:08:49 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "O.Sezer" <sezeroz@ttnet.net.tr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.4.28-pre1] more gcc3.4 inline fixes [9/10] [3/4]
Message-ID: <20040825110848.GA13285@logos.cnet>
References: <412A2630.70509@ttnet.net.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412A2630.70509@ttnet.net.tr>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 08:15:28PM +0300, O.Sezer wrote:
> splitted-up the fs/* gcc3.4-inline-patches.
> 
> [3/4] intermezzo, while we're here
> 
> 

Ozkan,

What is this about?

I can't understand this as trivial gcc3.4 inline fixes.


> --- 28p1/fs/intermezzo/file.c~	2004-02-18 15:36:31.000000000 +0200
> +++ 28p1/fs/intermezzo/file.c	2004-08-07 14:09:39.000000000 +0300
> @@ -78,16 +78,19 @@
>          pathlen = MYPATHLEN(buffer, path);
>          
>          CDEBUG(D_FILE, "de %p, dd %p\n", de, dd);
> +
>          if (dd->remote_ino == 0) {
>                  rc = presto_get_fileid(minor, fset, de);
> +                if (dd->remote_ino == 0)
> +                        CERROR("get_fileid failed %d, ino: %Lx, fetching by name\n", rc,
> +                               dd->remote_ino);
> +
>          }
>          memset (&info, 0, sizeof(info));
>          if (dd->remote_ino > 0) {
>                  info.remote_ino = dd->remote_ino;
>                  info.remote_generation = dd->remote_generation;
> -        } else
> -                CERROR("get_fileid failed %d, ino: %Lx, fetching by name\n", rc,
> -                       dd->remote_ino);
> +        }
>  
>          rc = izo_upc_open(minor, pathlen, path, fset->fset_name, &info);
>          PRESTO_FREE(buffer, PAGE_SIZE);
> === http://marc.theaimsgroup.com/?l=bk-commits-head&m=105399886001079&w=2
> --- 28p1/fs/intermezzo/methods.c~	2002-11-29 01:53:15.000000000 +0200
> +++ 28p1/fs/intermezzo/methods.c	2004-08-17 05:02:58.000000000 +0300
> @@ -254,8 +254,8 @@
>          if (ops == NULL) {
>                  CERROR("prepare to die: unrecognized cache type for Filter\n");
>          }
> -        return ops;
>          FEXIT;
> +        return ops;
>  }
>  
>  
> --- 28p1/fs/intermezzo/journal_xfs.c~	2002-11-29 01:53:15.000000000 +0200
> +++ 28p1/fs/intermezzo/journal_xfs.c	2004-08-17 05:02:58.000000000 +0300
> @@ -58,7 +57,7 @@
>          VFS_STATVFS(vfsp, &stat, NULL, rc);
>          avail = statp.f_bfree;
>  
> -        return sbp->sb_fdblocks;; 
> +        return sbp->sb_fdblocks;
>  #endif
>          return 0x0fffffff;
>  }
> --- 28p1/fs/intermezzo/psdev.c~	2002-11-29 01:53:15.000000000 +0200
> +++ 28p1/fs/intermezzo/psdev.c	2004-08-17 15:18:34.000000000 +0300
> @@ -564,6 +564,10 @@
>          buffer->u_uniq = req->rq_unique;
>          buffer->u_async = async;
>  
> +        /* Remove potential datarace possibility*/
> +        if ( async ) 
> +                req->rq_flags = REQ_ASYNC;
> +
>          spin_lock(&channel->uc_lock); 
>          /* Append msg to pending queue and poke Lento. */
>          list_add(&req->rq_chain, channel->uc_pending.prev);
> @@ -576,7 +580,7 @@
>  
>          if ( async ) {
>                  /* req, rq_data are freed in presto_psdev_read for async */
> -                req->rq_flags = REQ_ASYNC;
> +                /* req->rq_flags = REQ_ASYNC;*/
>                  EXIT;
>                  return 0;
>          }
> @@ -647,5 +651,6 @@
>  exit_req:
>          PRESTO_FREE(req, sizeof(struct upc_req));
>  exit_buf:
> +        PRESTO_FREE(buffer,*size);
>          return error;
>  }

