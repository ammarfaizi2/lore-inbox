Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267174AbTGGTZY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 15:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267177AbTGGTZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 15:25:23 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:2688 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S267174AbTGGTZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 15:25:00 -0400
Date: Mon, 7 Jul 2003 21:39:32 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: opening symlinks with O_CREAT under latest 2.5.74
Message-ID: <20030707193932.GA1479@vana.vc.cvut.cz>
References: <20030707154628.GA3220@vana.vc.cvut.cz> <16137.51802.41123.551648@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16137.51802.41123.551648@charged.uio.no>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 07, 2003 at 09:30:34PM +0200, Trond Myklebust wrote:
> >>>>> " " == Petr Vandrovec <vandrove@vc.cvut.cz> writes:
> 
>      > Hi,
>      >   couple of things stopped working on my box
>      > where I have /dev/vc/XX as symlinks to /dev/ttyXX, and some
>      > things use /dev/vc/XX and some /dev/ttyXX. After last update
>      > hour ago things which use /dev/vc/XX stopped working for
>      > non-root - they now fail with EACCES error if they attempt to
>      > redirect its input or output through '>' or '<>' bash
>      > redirection operators:
> 
> Whoops. Looks like I missed an assumption in open_namei().
> Does the following patch fix the problem?

Yes, it fixes problem. Thanks,
						Petr Vandrovec

> Cheers,
>   Trond
> 
> --- linux-2.5.74-up/fs/namei.c.orig	2003-06-30 08:49:25.000000000 +0200
> +++ linux-2.5.74-up/fs/namei.c	2003-07-07 21:25:00.000000000 +0200
> @@ -1344,6 +1344,7 @@
>  	 * stored in nd->last.name and we will have to putname() it when we
>  	 * are done. Procfs-like symlinks just set LAST_BIND.
>  	 */
> +	nd->flags |= LOOKUP_PARENT;
>  	error = security_inode_follow_link(dentry, nd);
>  	if (error)
>  		goto exit_dput;
> @@ -1352,6 +1353,7 @@
>  	dput(dentry);
>  	if (error)
>  		return error;
> +	nd->flags &= ~LOOKUP_PARENT;
>  	if (nd->last_type == LAST_BIND) {
>  		dentry = nd->dentry;
>  		goto ok;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
