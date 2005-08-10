Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965247AbVHJShm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965247AbVHJShm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 14:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965256AbVHJShm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 14:37:42 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:53263 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S965247AbVHJShl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 14:37:41 -0400
Date: Wed, 10 Aug 2005 20:17:13 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "Andrey J. Melnikoff (TEMHOTA)" <temnota@kmv.ru>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, Olya Briginets <bolya@ukrpost.net>
Subject: Re: [PATCH] 2.4.31: fix isofs mount options parser
Message-ID: <20050810181713.GA28147@alpha.home.local>
References: <20050810124654.GV9857@kmv.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050810124654.GV9857@kmv.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrey,

On Wed, Aug 10, 2005 at 04:46:54PM +0400, Andrey J. Melnikoff (TEMHOTA) wrote:
> 
> Hello Marcelo, LKML.
> 
> Attached patch fix this whatings from gcc-3.4 and allow user mount
> isofs with "session" and "sbsector" options. Without this patch, gcc-3.4
> optimizer always return zero.

It should not, or it's a bug, because the first test (ivalue < 0) is false,
so the second one (ivalue > 99) must be evaluated before returning anything.

You patch is not the correct way to fix it either, because simple_strtoul()
is defined as unsigned long. So with your patch, very large values of ivalue
will be converted to negative and checked as invalid. In fact, you should have
changed the ivalue type to unsigned long, and removed the (ivalue < 0) test.

Please repost it fixed, I should have time to merge it into the next hotfix.

Thanks,
Willy


> 
> --- cut ---
> inode.c: In function `parse_options':
> inode.c:341: warning: comparison of unsigned expression < 0 is always false
> inode.c:347: warning: comparison of unsigned expression < 0 is always false
> --- cut ---
> 
> Signed-of-by: Andrey Melnikoff <temnota@kmv.ru>
> 
> --- linux-2.4.31/fs/isofs/inode.c~old	2005-08-10 16:18:48.000000000 +0400
> +++ linux-2.4.31/fs/isofs/inode.c	2005-08-10 16:19:11.000000000 +0400
> @@ -337,13 +337,13 @@
>  		}
>  		if (!strcmp(this_char,"session") && value) {
>  			char * vpnt = value;
> -			unsigned int ivalue = simple_strtoul(vpnt, &vpnt, 0);
> +			int ivalue = simple_strtoul(vpnt, &vpnt, 0);
>  			if(ivalue < 0 || ivalue >99) return 0;
>  			popt->session=ivalue+1;
>  		}
>  		if (!strcmp(this_char,"sbsector") && value) {
>  			char * vpnt = value;
> -			unsigned int ivalue = simple_strtoul(vpnt, &vpnt, 0);
> +			int ivalue = simple_strtoul(vpnt, &vpnt, 0);
>  			if(ivalue < 0 || ivalue >660*512) return 0;
>  			popt->sbsector=ivalue;
>  		}
> 
> -- 
>  Best regards, TEMHOTA-RIPN aka MJA13-RIPE
>  System Administrator. mailto:temnota@kmv.ru
> 

> --- linux-2.4.31/fs/isofs/inode.c~old	2005-08-10 16:18:48.000000000 +0400
> +++ linux-2.4.31/fs/isofs/inode.c	2005-08-10 16:19:11.000000000 +0400
> @@ -337,13 +337,13 @@
>  		}
>  		if (!strcmp(this_char,"session") && value) {
>  			char * vpnt = value;
> -			unsigned int ivalue = simple_strtoul(vpnt, &vpnt, 0);
> +			int ivalue = simple_strtoul(vpnt, &vpnt, 0);
>  			if(ivalue < 0 || ivalue >99) return 0;
>  			popt->session=ivalue+1;
>  		}
>  		if (!strcmp(this_char,"sbsector") && value) {
>  			char * vpnt = value;
> -			unsigned int ivalue = simple_strtoul(vpnt, &vpnt, 0);
> +			int ivalue = simple_strtoul(vpnt, &vpnt, 0);
>  			if(ivalue < 0 || ivalue >660*512) return 0;
>  			popt->sbsector=ivalue;
>  		}

