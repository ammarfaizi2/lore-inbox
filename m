Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965151AbVHZR4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965151AbVHZR4s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbVHZR4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:56:48 -0400
Received: from peabody.ximian.com ([130.57.169.10]:61629 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S965151AbVHZR4r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:56:47 -0400
Subject: Re: Inotify problem [was Re: 2.6.13-rc6-mm1]
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: jim.houston@comcast.net, linux-kernel@vger.kernel.org, george@mvista.com,
       akpm@osdl.org, johannes@sipsolutions.net
In-Reply-To: <1125078764.13243.6.camel@vertex>
References: <1125075832.2783.99.camel@new.localdomain>
	 <1125078764.13243.6.camel@vertex>
Content-Type: text/plain
Date: Fri, 26 Aug 2005 13:56:45 -0400
Message-Id: <1125079005.18155.57.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-26 at 13:52 -0400, John McCutchan wrote:

> Thanks for your suggestion, it has fixed the inotify problem. But where
> to put the fix is turning into a bit of a mess. Some callers like
> drivers/md/dm.c:682 call idr_get_new_above as if it will return >=
> starting_id. The comment says that it will return > starting_id, and the
> function name leads people to believe the same thing. In the patch below
> I change inotify do add one to the value was pass into idr. I also
> change the comment to more accurately reflect what the function does.
> The function name doesn't fit, but it never did.
> 
> Signed-off-by: John McCutchan <ttb@tentacle.dhs.org>

Signed-off-by: Robert Love <rml@novell.com>

Keeping the current behavior is probably the best way to go.

	Robert Love

> Index: linux/fs/inotify.c
> ===================================================================
> --- linux.orig/fs/inotify.c	2005-08-26 13:38:29.000000000 -0400
> +++ linux/fs/inotify.c	2005-08-26 13:38:55.000000000 -0400
> @@ -353,7 +353,7 @@
>  	do {
>  		if (unlikely(!idr_pre_get(&dev->idr, GFP_KERNEL)))
>  			return -ENOSPC;
> -		ret = idr_get_new_above(&dev->idr, watch, dev->last_wd, &watch->wd);
> +		ret = idr_get_new_above(&dev->idr, watch, dev->last_wd+1, &watch->wd);
>  	} while (ret == -EAGAIN);
>  
>  	return ret;
> Index: linux/lib/idr.c
> ===================================================================
> --- linux.orig/lib/idr.c	2005-08-26 13:38:22.000000000 -0400
> +++ linux/lib/idr.c	2005-08-26 13:39:08.000000000 -0400
> @@ -207,7 +207,7 @@
>  }
>  
>  /**
> - * idr_get_new_above - allocate new idr entry above a start id
> + * idr_get_new_above - allocate new idr entry above or equal to a start id
>   * @idp: idr handle
>   * @ptr: pointer you want associated with the ide
>   * @start_id: id to start search at
> 

