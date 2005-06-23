Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262647AbVFWUtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbVFWUtz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 16:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbVFWUtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 16:49:46 -0400
Received: from mail.dif.dk ([193.138.115.101]:22174 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262984AbVFWUkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 16:40:23 -0400
Date: Thu, 23 Jun 2005 22:46:06 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Laurence Culhane <loz@holmes.demon.co.uk>, linux-serial@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SLIP: simplify sl_free_bufs
In-Reply-To: <Pine.LNX.4.62.0506152136310.3842@dragon.hyggekrogen.localhost>
Message-ID: <Pine.LNX.4.62.0506232243340.7467@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0506152136310.3842@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch below still applies cleanly to 2.6.12 - any chance this might 
get applied? or any good reasons not to apply it?

-- Jesper


On Wed, 15 Jun 2005, Jesper Juhl wrote:

> We can avoid assignments to the local variable 'tmp' and 
> actually get rid of tmp alltogether in sl_free_bufs(). This patch does 
> that.  This is safe since both kfree() and slhc_free() handles NULL 
> pointers gracefully.
> 
> A related question: Why the use of NULLSLCOMPR & NULLSLSTATE instead of 
> plain NULL for struct slcompress and its members?
> They are defined as 
> 	#define NULLSLCOMPR     (struct slcompress *)0
> 	#define NULLSLSTATE     (struct cstate *)0
> Seems to me that plain NULL might as well be used (and if so I have a few 
> more potential cleanups in the queue).
> 
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> ---
> 
>  drivers/net/slip.c |   14 ++++----------
>  1 files changed, 4 insertions(+), 10 deletions(-)
> 
> --- linux-2.6.12-rc6-orig/drivers/net/slip.c	2005-06-07 00:07:22.000000000 +0200
> +++ linux-2.6.12-rc6-mm1/drivers/net/slip.c	2005-06-15 21:39:39.000000000 +0200
> @@ -198,18 +198,12 @@ err_exit:
>  static void
>  sl_free_bufs(struct slip *sl)
>  {
> -	void * tmp;
> -
>  	/* Free all SLIP frame buffers. */
> -	tmp = xchg(&sl->rbuff, NULL);
> -	kfree(tmp);
> -	tmp = xchg(&sl->xbuff, NULL);
> -	kfree(tmp);
> +	kfree(xchg(&sl->rbuff, NULL));
> +	kfree(xchg(&sl->xbuff, NULL));
>  #ifdef SL_INCLUDE_CSLIP
> -	tmp = xchg(&sl->cbuff, NULL);
> -	kfree(tmp);
> -	if ((tmp = xchg(&sl->slcomp, NULL)) != NULL)
> -		slhc_free(tmp);
> +	kfree(xchg(&sl->cbuff, NULL));
> +	slhc_free(xchg(&sl->slcomp, NULL));
>  #endif
>  }
>  
> 
> 
> 
> Please CC me on replies.
> 
> -- 
> Jesper Juhl
> 

