Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbVAYDOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbVAYDOQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 22:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVAYDOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 22:14:16 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:39906 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261719AbVAYDOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 22:14:10 -0500
Date: Tue, 25 Jan 2005 08:53:41 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-aio@kvack.org
Subject: Re: [PATCH] BUG in io_destroy (fs/aio.c:1248)
Message-ID: <20050125032341.GA3707@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <41F04D73.20800@us.ibm.com> <20050124085805.GA4462@in.ibm.com> <20050124155613.3a741825.akpm@osdl.org> <1106613801.11633.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106613801.11633.2.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Anything wrong with just a get_ioctx() instead ?


--- aio.c	2005-01-12 09:30:44.000000000 +0530
+++ aio.c.fix	2005-01-25 08:51:31.000000000 +0530
@@ -1284,7 +1284,7 @@
 		ret = put_user(ioctx->user_id, ctxp);
 		if (!ret)
 			return 0;
-
+		get_ioctx(ioctx); /* as io_destroy() expects us to hold a ref */
 		io_destroy(ioctx);
 	}
 


On Mon, Jan 24, 2005 at 04:43:21PM -0800, Darrick J. Wong wrote:
> Andrew Morton wrote:
> 
> > So...  Will someone be sending a new patch?
> 
> Here's a cheesy patch that simply marks the ioctx as dead before
> destroying it.  Though I'd like to simply mark the ioctx as dead until
> it actually gets used, I don't know enough about the code to make that
> sort of invasive change.
> 
> --D
> 
> -----------------
> Signed-off-by: Darrick Wong <djwong@us.ibm.com>
> 
> --- linux-2.6.10/fs/aio.c.old	2005-01-24 16:12:46.000000000 -0800
> +++ linux-2.6.10/fs/aio.c	2005-01-24 16:30:53.000000000 -0800
> @@ -1285,6 +1285,10 @@
>  		if (!ret)
>  			return 0;
>  
> +		spin_lock_irq(&ctx->ctx_lock);
> +		ctx->dead = 1;
> +		spin_unlock_irq(&ctx->ctx_lock);
> +
>  		io_destroy(ioctx);
>  	}
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

