Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbVJFVbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbVJFVbt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 17:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbVJFVbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 17:31:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40390 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750900AbVJFVbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 17:31:48 -0400
Date: Thu, 6 Oct 2005 14:31:38 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Rick Lindsley <ricklind@us.ibm.com>
cc: Robert Derr <rderr@weatherflow.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       amitarora@in.ibm.com, suzukikp@in.ibm.com,
       Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: 2.6.13.3 Memory leak, names_cache 
In-Reply-To: <200510062003.j96K3In0016900@owlet.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.64.0510061428340.31407@g5.osdl.org>
References: <200510062003.j96K3In0016900@owlet.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Oct 2005, Rick Lindsley wrote:
> 
> The code in open_namei() is a bit non-intuitive in error conditions,
> but the general fix appears to be pretty straightforward.  Let me know if
> this patch seems to do the trick for you.

This patch seems to be correct.

As far as I can tell, the name in "last.name" has always been allocated 
with "__getname()", and it should thus always be free'd with "__putname()" 
in order to not cause trouble with the horrible AUDITSYSCALL code.

Now, very arguably the real bug is that bug-prone code in AUDITSYSCALL, 
but I suspect that for 2.6.14 I should just apply this patch.

Al? Any comments? (Full patch quoted here in case you haven't followed the 
mailing list)

		Linus

> --- linux-2.6.13.3/fs/namei.c	2005-08-28 16:41:01.000000000 -0700
> +++ linux-2.6.13.3-new/fs/namei.c	2005-10-06 12:45:41.996243768 -0700
> @@ -1557,19 +1557,19 @@ do_link:
>  	if (nd->last_type != LAST_NORM)
>  		goto exit;
>  	if (nd->last.name[nd->last.len]) {
> -		putname(nd->last.name);
> +		__putname(nd->last.name);
>  		goto exit;
>  	}
>  	error = -ELOOP;
>  	if (count++==32) {
> -		putname(nd->last.name);
> +		__putname(nd->last.name);
>  		goto exit;
>  	}
>  	dir = nd->dentry;
>  	down(&dir->d_inode->i_sem);
>  	path.dentry = __lookup_hash(&nd->last, nd->dentry, nd);
>  	path.mnt = nd->mnt;
> -	putname(nd->last.name);
> +	__putname(nd->last.name);
>  	goto do_last;
>  }
>  
