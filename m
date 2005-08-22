Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbVHVV0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbVHVV0E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVHVV0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:26:02 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:5614 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751229AbVHVVZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:25:55 -0400
Date: Mon, 22 Aug 2005 16:37:13 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.13-rc6-mm1
Message-ID: <20050822143713.GA12947@ens-lyon.fr>
References: <20050821222229.GC6935@ens-lyon.fr> <9e47339105082115347bde79bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339105082115347bde79bb@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2005 at 06:34:48PM -0400, Jon Smirl wrote:
> This should fix it, but I'm not on a machine where I can test it. Can
> you give it a try and let me know?
> 

it works ok.
But there is still at least one problem: if ops->store returns an error,
then there will be a substraction and the write will loop (i could do it
with a store wich returned EINVAL and a 22 length string).

I don't know if you can put a '\0' at buffer->page[count] if
count == PAGE_SIZE.

Moreover, i think it is more correct to add only the leading
whitespace from the count because if the ops->store doesn't read
everything it will do something weird:

For example, if we have ' 123    ' and ops->store read only one char,
then the function will return 7 (1 leading + 4 trailing + 1 read).  For
the next call the buffer will be filled only by spaces which is
incorrect (it should be '23    ').

> diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> --- a/fs/sysfs/file.c
> +++ b/fs/sysfs/file.c
> @@ -6,6 +6,7 @@
>  #include <linux/fsnotify.h>
>  #include <linux/kobject.h>
>  #include <linux/namei.h>
> +#include <linux/ctype.h>
>  #include <asm/uaccess.h>
>  #include <asm/semaphore.h>
>  
> @@ -207,8 +208,28 @@ flush_write_buffer(struct dentry * dentr
>  	struct attribute * attr = to_attr(dentry);
>  	struct kobject * kobj = to_kobj(dentry->d_parent);
>  	struct sysfs_ops * ops = buffer->ops;
> +	int ws_count = count;
> +	char *x;
>  
> -	return ops->store(kobj,attr,buffer->page,count);
> +	/* locate trailing white space */
> +	while ((count > 0) && isspace(buffer->page[count - 1]))
> +		count--;
> +
> +	/* locate leading white space */
> +	x = buffer->page;
> +	if (count > 0) {
> +		while (isspace(*x))
> +			x++;
> +		count -= (x - buffer->page);
> +	}
> +	/* terminate the string */
> +	x[count] = '\0';
	 what if count == PAGE_SIZE ?
> +	ws_count -= count;
> +
> +	if (count != 0)
> +		count = ops->store(kobj, attr, x, count);
> +
> +	return count + ws_count;
	return (count < 0) ? count : count + ws_count;
>  }
>  
>  
-- 
powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS
