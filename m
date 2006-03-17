Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbWCQRc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWCQRc5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 12:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbWCQRc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 12:32:57 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:39125 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030224AbWCQRc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 12:32:56 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] swsusp reclaim tweaks 2
Date: Fri, 17 Mar 2006 18:31:45 +0100
User-Agent: KMail/1.9.1
Cc: ck@vds.kolivas.org, Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Jun OKAJIMA <okajima@digitalinfra.co.jp>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@suse.cz>, Stefan Seyfried <seife@suse.de>
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <200603171546.03002.kernel@kolivas.org> <200603171717.23288.kernel@kolivas.org>
In-Reply-To: <200603171717.23288.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603171831.46811.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 March 2006 07:17, Con Kolivas wrote:
> On Fri, 17 Mar 2006 03:46 pm, Con Kolivas wrote:
> > On Fri, 17 Mar 2006 03:28 pm, Con Kolivas wrote:
> > > Ok here is a kind of directed memory reclaim for swsusp which is
> > > different to ordinary memory reclaim. It reclaims memory in up to 4
> > > passes with just shrink_zone, without hooking into balance_pgdat thereby
> > > simplifying that function as well.
> 
> > It may need to be made more aggressive with another reclaim mapped pass to
> > ensure it frees enough memory. That would be trivial to add.
> 
> Indeed this was true after a few more suspend resume cycles. Here is a rework
> which survived many suspend resume cycles. This worked nicely in combination
> with the aggressive swap prefetch tunable being set on resume.
> 
> Ok, now please test :) Patch for 2.6.16-rc6-mm1
> 
> Cheers,
> Con
> ---
}-- snip --{

I'm not an mm expert, but I like that.

> Index: linux-2.6.16-rc6-mm1/kernel/power/swsusp.c
> ===================================================================
> --- linux-2.6.16-rc6-mm1.orig/kernel/power/swsusp.c	2006-03-17 16:44:47.000000000 +1100
> +++ linux-2.6.16-rc6-mm1/kernel/power/swsusp.c	2006-03-17 16:45:11.000000000 +1100
> @@ -173,9 +173,6 @@ void free_all_swap_pages(int swap, struc
>   *	Notice: all userland should be stopped before it is called, or
>   *	livelock is possible.
>   */
> -
> -#define SHRINK_BITE	10000
> -
>  int swsusp_shrink_memory(void)
>  {
>  	long size, tmp;
> @@ -195,13 +192,12 @@ int swsusp_shrink_memory(void)
>  			if (!is_highmem(zone))
>  				tmp -= zone->free_pages;
>  		if (tmp > 0) {
> -			tmp = shrink_all_memory(SHRINK_BITE);
> +			tmp = shrink_all_memory(tmp);
>  			if (!tmp)
>  				return -ENOMEM;
>  			pages += tmp;
> -		} else if (size > image_size / PAGE_SIZE) {

If you drop this, swsusp can free less memory than you want (image_size is
ignored).  Generally we want it to free memory until
size <= image_size / PAGE_SIZE.

Appended is a fix on top of your patch (untested).

> -			tmp = shrink_all_memory(SHRINK_BITE);
> -			pages += tmp;
> +			if (pages > size)
> +				break;
>  		}
>  		printk("\b%c", p[i++%4]);
>  	} while (tmp > 0);

 kernel/power/swsusp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.16-rc6-mm1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/kernel/power/swsusp.c
+++ linux-2.6.16-rc6-mm1/kernel/power/swsusp.c
@@ -191,13 +191,13 @@ int swsusp_shrink_memory(void)
 		for_each_zone (zone)
 			if (!is_highmem(zone))
 				tmp -= zone->free_pages;
+		if (tmp <= 0)
+			tmp = size - image_size / PAGE_SIZE;
 		if (tmp > 0) {
 			tmp = shrink_all_memory(tmp);
 			if (!tmp)
 				return -ENOMEM;
 			pages += tmp;
-			if (pages > size)
-				break;
 		}
 		printk("\b%c", p[i++%4]);
 	} while (tmp > 0);
