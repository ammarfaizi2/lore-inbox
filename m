Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbTL2H5F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 02:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbTL2H5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 02:57:05 -0500
Received: from mx2.it.wmich.edu ([141.218.1.94]:18318 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S263053AbTL2H5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 02:57:01 -0500
Message-ID: <3FEFDE4A.1030208@wmich.edu>
Date: Mon, 29 Dec 2003 02:56:58 -0500
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Walt H <waltabbyh@comcast.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Can't eject a previously mounted CD?
References: <3FEF89D5.4090103@comcast.net> <3FEF8BB1.6090704@wmich.edu> <3FEFA36A.5050307@comcast.net>
In-Reply-To: <3FEFA36A.5050307@comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In your patch here i think the person who made the code originally 
confused or got wrong the conditions of success for opening the cdrom 
drive. This is in the same function as the patch applies to.

        if ((fp->f_flags & O_NONBLOCK) && (cdi->options & 
CDO_USE_FFLAGS))
                 ret = cdi->ops->open(cdi, 1); 

         else 

                 ret = open_for_data(cdi); 

 

         if (!ret) cdi->use_count++;

Here we see that if the open fails we incriment our use_count.  But this 
doesn't make sense. We increment the use_count at the  beginning of the 
function as a "lock" so that we can't do anything while the open 
function is executing like rmmod the cdrom (supposedly?).  Now removing 
the if(!ret) line makes sense. Under the out: label, if the open fails, 
then we close our makeshift lock on the device because our function is 
done. If it succeeded, then the use_count stays at 1 we go along our 
merry way.

> -Walt
> 
> --- /usr/src/linux/drivers/cdrom/cdrom.c        2003-12-25 09:53:59.000000000 -0800
> +++ linux-2.6.0-mm1/drivers/cdrom/cdrom.c       2003-12-28 19:42:04.174098225 -0800
> @@ -744,4 +744,7 @@
>         }
> 
> +       if (cdi->use_count > 0)
> +               cdi->use_count--;
> +
>         /* if this was a O_NONBLOCK open and we should honor the flags,
>          * do a quick open without drive/disc integrity checks. */
> @@ -931,5 +934,5 @@
>         struct cdrom_device_ops *cdo = cdi->ops;
> 
> -       cdinfo(CD_CLOSE, "entering cdrom_release\n");
> +       cdinfo(CD_CLOSE, "entering cdrom_release\n");
> 
>         if (cdi->use_count > 0)
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


