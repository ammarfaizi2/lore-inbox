Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbSKKExB>; Sun, 10 Nov 2002 23:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265515AbSKKExB>; Sun, 10 Nov 2002 23:53:01 -0500
Received: from smtp.sw.oz.au ([203.31.96.1]:39186 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id <S265446AbSKKExA>;
	Sun, 10 Nov 2002 23:53:00 -0500
Date: Mon, 11 Nov 2002 15:59:41 +1100
From: Kingsley Cheung <kingsley@aurema.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: Re: [PATCH] setrlimit incorrectly allows hard limits to exceed soft limits
Message-ID: <20021111155941.A15095@aurema.com>
References: <20021111151005.B14949@aurema.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021111151005.B14949@aurema.com>; from kingsley@aurema.com on Mon, Nov 11, 2002 at 03:10:05PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, should be after the copy :-(

--- sys.c       Sat Aug  3 10:39:46 2002
+++ edited.sys.c        Mon Nov 11 15:56:51 2002
@@ -1120,6 +1120,8 @@
                return -EINVAL;
        if(copy_from_user(&new_rlim, rlim, sizeof(*rlim)))
                return -EFAULT;
+       if (new_rlim.rlim_cur > new_rlim.rlim_max)
+               return -EINVAL;
        old_rlim = current->rlim + resource;
        if (((new_rlim.rlim_cur > old_rlim->rlim_max) ||
             (new_rlim.rlim_max > old_rlim->rlim_max)) &&


On Mon, Nov 11, 2002 at 03:10:05PM +1100, Kingsley Cheung wrote:
> Hi,
> 
> In 2.4.19 (also 2.5.46) setrlimit code only ever makes a comparison to
> check the old soft limit with the new soft limit and the new hard
> limit with the old hard limit.  There is never a check to ensure the
> new soft limit never exceeds the new hard limit. 
> 
> Just try "ulimit -H -m 10000" for memory limits that were not
> previously set.  You end up with (hard limit = 10000) < (soft limit =
> unlimited).
> 
> Fix is trivial.
> 
> --- sys.c       Sat Aug  3 10:39:46 2002
> +++ edited.sys.c        Mon Nov 11 14:49:19 2002
> @@ -1118,6 +1118,8 @@
>  
>         if (resource >= RLIM_NLIMITS)
>                 return -EINVAL;
> +       if (new_rlim.rlim_cur > new_rlim.rlim_max)
> +               return -EINVAL;
>         if(copy_from_user(&new_rlim, rlim, sizeof(*rlim)))
>                 return -EFAULT;
>         old_rlim = current->rlim + resource;
> 

-- 
		Kingsley
