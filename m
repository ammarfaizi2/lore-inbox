Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030427AbVIVQdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030427AbVIVQdu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 12:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030436AbVIVQdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 12:33:50 -0400
Received: from pat.uio.no ([129.240.130.16]:9714 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030427AbVIVQdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 12:33:49 -0400
Subject: Re: [PATCH] nfs client: handle long symlinks properly
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Assar <assar@permabit.com>, Peter Staubach <staubach@redhat.com>,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
In-Reply-To: <20050922161420.GC5588@dmt.cnet>
References: <20050922161420.GC5588@dmt.cnet>
Content-Type: text/plain
Date: Thu, 22 Sep 2005 12:33:30 -0400
Message-Id: <1127406811.8365.8.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.925, required 12,
	autolearn=disabled, AWL 1.07, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 22.09.2005 Klokka 13:14 (-0300) skreiv Marcelo Tosatti:
> commit 87e03738fc15dc3ea4acde3a5dcb5f84b6b6152b
> tree be323c0a65d7e380ad04cad1c3a80015a82056dd
> parent bb52ef60b5caa8f973523eda15d3c3941f298e63
> author Assar <assar@permabit.com> Wed, 14 Sep 2005 16:59:25 -0400
> committer Marcelo Tosatti <marcelo@dmt.cnet> Thu, 22 Sep 2005 13:11:18 -0300
> 
>     [PATCH] nfs client: handle long symlinks properly
> 
>     In 2.4.31, the v2/3 nfs readlink accepts too long symlinks.
>     I have tested this by having a server return long symlinks.
> 
> diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
> --- a/fs/nfs/nfs2xdr.c
> +++ b/fs/nfs/nfs2xdr.c
> @@ -571,8 +571,11 @@ nfs_xdr_readlinkres(struct rpc_rqst *req
>         strlen = (u32*)kmap(rcvbuf->pages[0]);
>         /* Convert length of symlink */
>         len = ntohl(*strlen);
> -       if (len > rcvbuf->page_len)
> -               len = rcvbuf->page_len;
> +       if (len >= rcvbuf->page_len - sizeof(u32) || len > NFS2_MAXPATHLEN) {

Shouldn't that be

	if (len > rcvbuf->page_len - sizeof(u32) || len > NFS2_MAXPATHLEN)

? As long as we use page_len == PAGE_SIZE, we probably don't care, but
if someone some day decides to set a different value for page_len, then
we want to make sure that we don't end up overflowing the buffer when we
NUL-terminate.

> +               printk(KERN_WARNING "NFS: server returned giant symlink!\n");

Please make this a dprintk().

> +               kunmap(rcvbuf->pages[0]);
> +               return -ENAMETOOLONG;
> +        }
>         *strlen = len;
>         /* NULL terminate the string we got */
>         string = (char *)(strlen + 1);
> diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
> --- a/fs/nfs/nfs3xdr.c
> +++ b/fs/nfs/nfs3xdr.c
> @@ -759,8 +759,11 @@ nfs3_xdr_readlinkres(struct rpc_rqst *re
>         strlen = (u32*)kmap(rcvbuf->pages[0]);
>         /* Convert length of symlink */
>         len = ntohl(*strlen);
> -       if (len > rcvbuf->page_len)
> -               len = rcvbuf->page_len;
> +       if (len >= rcvbuf->page_len - sizeof(u32)) {

Ditto.

> +               printk(KERN_WARNING "NFS: server returned giant symlink!\n");

...and ditto.

> +               kunmap(rcvbuf->pages[0]);
> +               return -ENAMETOOLONG;
> +        }
>         *strlen = len;
>         /* NULL terminate the string we got */
>         string = (char *)(strlen + 1);

Cheers,
  Trond

