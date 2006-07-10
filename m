Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbWGJKGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWGJKGb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 06:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWGJKGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 06:06:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44761 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751393AbWGJKGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 06:06:30 -0400
Date: Mon, 10 Jul 2006 03:05:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru, devel@openvz.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [PATCH] struct file leakage
Message-Id: <20060710030526.fdb1ca27.akpm@osdl.org>
In-Reply-To: <44B2185F.1060402@sw.ru>
References: <44B2185F.1060402@sw.ru>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006 13:05:35 +0400
Kirill Korotaev <dev@sw.ru> wrote:

> Hello!
> 
> Andrew, this is a patch from Alexey Kuznetsov for 2.6.16.
> I believe 2.6.17 still has this leak.
> 
> -------------------------------------------------------------
> 
> 2.6.16 leaks like hell. While testing, I found massive leakage
> (reproduced in openvz) in:
> 
> *filp
> *size-4096
> 
> And 1 object leaks in
> *size-32
> *size-64
> *size-128
> 
> 
> It is the fix for the first one. filp leaks in the bowels
> of namei.c.
> 
> Seems, size-4096 is file table leaking in expand_fdtables.

I suspect that's been there for a long time.

> I have no idea what are the rest and why they show only
> accompaniing another leaks. Some debugging structs?

I don't understand this.  Are you implying that there are other bugs.

> Signed-Off-By: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
> CC: Kirill Korotaev <dev@openvz.org>
> 

> --- linux-2.6.16-w/fs/namei.c	2006-07-10 11:43:11.000000000 +0400
> +++ linux-2.6.16/fs/namei.c	2006-07-10 11:53:36.000000000 +0400
> @@ -1774,8 +1774,15 @@ do_link:
>  	if (error)
>  		goto exit_dput;
>  	error = __do_follow_link(&path, nd);
> -	if (error)
> +	if (error) {
> +		/* Does someone understand code flow here? Or it is only
> +		 * me so stupid? Anathema to whoever designed this non-sense
> +		 * with "intent.open".
> +		 */
> +		if (!IS_ERR(nd->intent.open.file))
> +			release_open_intent(nd);
>  		return error;
> +	}
>  	nd->flags &= ~LOOKUP_PARENT;
>  	if (nd->last_type == LAST_BIND)
>  		goto ok;
> 

It's good to have some more Alexeycomments in the tree.

I wonder if we're also needing a path_release() here.  And if not, whether
it is still safe to run release_open_intent() against this nameidata?

Hopefully Trond can recall what's going on in there...
