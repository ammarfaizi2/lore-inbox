Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbVIMSpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbVIMSpb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 14:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbVIMSpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 14:45:31 -0400
Received: from hera.kernel.org ([209.128.68.125]:8147 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S964926AbVIMSpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 14:45:30 -0400
Date: Tue, 13 Sep 2005 15:39:48 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Assar <assar@permabit.com>, Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs client, kernel 2.4.31: readlink result overflow
Message-ID: <20050913183948.GE14889@dmt.cnet>
References: <78irx6wh6j.fsf@sober-counsel.permabit.com> <200509121846.j8CIk5YE025124@turing-police.cc.vt.edu> <784q8qrsad.fsf@sober-counsel.permabit.com> <200509122001.j8CK1kpW028651@turing-police.cc.vt.edu> <788xy2qas0.fsf@sober-counsel.permabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <788xy2qas0.fsf@sober-counsel.permabit.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Assar,

On Mon, Sep 12, 2005 at 04:41:19PM -0400, Assar wrote:
> Valdis.Kletnieks@vt.edu writes:
> > > To my reading, the 2.6.13 code does not copy the 4 bytes of length to
> > > rcvbuf.
> > 
> > Hmm... it still does this:
> > 	kaddr[len+rcvbuf->page_base] = '\0';
> > which still has a possible off-by-one? (Was that why you have -1 -4?)
> 
> The check is different.  2.6.13 is using ">=" instead of ">", so hence
> I think that's fine.
> 
> > sizeof(actual_var) is even better, as that way it's clear what you're allowing
> > space for.
> 
> diff -u linux-2.4.31.orig/fs/nfs/nfs2xdr.c linux-2.4.31/fs/nfs/nfs2xdr.c
> --- linux-2.4.31.orig/fs/nfs/nfs2xdr.c	2002-11-28 18:53:15.000000000 -0500
> +++ linux-2.4.31/fs/nfs/nfs2xdr.c	2005-09-12 16:12:30.000000000 -0400
> @@ -571,8 +571,8 @@
>  	strlen = (u32*)kmap(rcvbuf->pages[0]);
>  	/* Convert length of symlink */
>  	len = ntohl(*strlen);
> -	if (len > rcvbuf->page_len)
> -		len = rcvbuf->page_len;
> +	if (len > rcvbuf->page_len - sizeof(*strlen) - 1)
> +		len = rcvbuf->page_len - sizeof(*strlen) - 1;

So the problem is that the "len" variable encapsulated in (u32 *)rcvbuf->pages[0]
does not account for its own length (4 bytes)? 

If thats the reason, you don't need the "-1" there?

Someone with better understanding to ACK this would be nice. Trond?

>  	*strlen = len;
>  	/* NULL terminate the string we got */
>  	string = (char *)(strlen + 1);
> diff -u linux-2.4.31.orig/fs/nfs/nfs3xdr.c linux-2.4.31/fs/nfs/nfs3xdr.c
> --- linux-2.4.31.orig/fs/nfs/nfs3xdr.c	2003-11-28 13:26:21.000000000 -0500
> +++ linux-2.4.31/fs/nfs/nfs3xdr.c	2005-09-12 16:12:29.000000000 -0400
> @@ -759,8 +759,8 @@
>  	strlen = (u32*)kmap(rcvbuf->pages[0]);
>  	/* Convert length of symlink */
>  	len = ntohl(*strlen);
> -	if (len > rcvbuf->page_len)
> -		len = rcvbuf->page_len;
> +	if (len > rcvbuf->page_len - sizeof(*strlen) - 1)
> +		len = rcvbuf->page_len - sizeof(*strlen) - 1;
>  	*strlen = len;
>  	/* NULL terminate the string we got */
>  	string = (char *)(strlen + 1);
