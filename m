Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWCXPGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWCXPGx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 10:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWCXPGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 10:06:52 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:56223 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750861AbWCXPGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 10:06:51 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] swswsup: return correct load_image error
Date: Fri, 24 Mar 2006 16:05:33 +0100
User-Agent: KMail/1.9.1
Cc: linux list <linux-kernel@vger.kernel.org>, ck list <ck@vds.kolivas.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       linux-mm@kvack.org
References: <200603200234.01472.kernel@kolivas.org> <200603241600.56144.kernel@kolivas.org> <200603241617.24434.kernel@kolivas.org>
In-Reply-To: <200603241617.24434.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603241605.34706.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 March 2006 06:17, Con Kolivas wrote:
> > On Tuesday 21 March 2006 10:22, Rafael J. Wysocki wrote:
> > > Basically, yes.  swsusp.c and snapshot.c contain common functions,
> > > disk.c and swap.c contain the code used by the built-in swsusp only,
> > > and user.c contains the userland interface.  If you want something to
> > > be run by the built-in swsusp only, place it in disk.c.
> 
> Would this patch suffice?

I'd change one thing (please see below).

> ---
> Swsusp reclaims a lot of memory during the suspend cycle and can benefit
> from the aggressive_swap_prefetch mode immediately upon resuming.
> 
> Signed-off-by: Con Kolivas <kernel@kolivas.org>
> ---
>  kernel/power/disk.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6.16-mm1/kernel/power/disk.c
> ===================================================================
> --- linux-2.6.16-mm1.orig/kernel/power/disk.c	2006-03-24 15:48:14.000000000 +1100
> +++ linux-2.6.16-mm1/kernel/power/disk.c	2006-03-24 16:15:05.000000000 +1100
> @@ -19,6 +19,7 @@
>  #include <linux/fs.h>
>  #include <linux/mount.h>
>  #include <linux/pm.h>
> +#include <linux/swap-prefetch.h>
>  
>  #include "power.h"
>  
> @@ -138,8 +139,10 @@ int pm_suspend_disk(void)
>  			unprepare_processes();
>  			return error;
>  		}
> -	} else
> +	} else {
>  		pr_debug("PM: Image restored successfully.\n");
> +		aggressive_swap_prefetch();
> +	}
>  
>  	swsusp_free();

I'd put aggressive_swap_prefetch() here.  Before swsusp_free() there may be no
room for the prefetched pages.  [I should have noticed it earlier.  _This_ must
have been the problem last time I tested it.]

>   Done:
> 
> 

Greetings,
Rafael
