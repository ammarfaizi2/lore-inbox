Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262702AbVG2Suv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbVG2Suv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 14:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbVG2Suv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 14:50:51 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:23492 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262702AbVG2Sus convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 14:50:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fnZxqy+1JZG2REgJckXwU2CwQi8n1b1lv2le829gE6XI08MYD8a9/3K2TYUBx8F2irdXUQhsDxhZzwWTx+teqiVJ0yFzk7MJ8WD0e9VOkzGgK9eQdXDynaQR6OHDVxTPd1YRkcim9J482YF1ugj+eJliuJa3XMVd/SVgOpz9UKc=
Message-ID: <9e4733910507291150fe8f839@mail.gmail.com>
Date: Fri, 29 Jul 2005 14:50:44 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9e473391050728132757a75d5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e47339105072719057c833e62@mail.gmail.com>
	 <20050728040544.GA12476@kroah.com>
	 <9e47339105072721495d3788a8@mail.gmail.com>
	 <20050728054914.GA13904@kroah.com>
	 <20050728070455.GF9985@gaz.sfgoth.com>
	 <9e47339105072805545766f97d@mail.gmail.com>
	 <20050728190352.GA29092@kroah.com>
	 <9e47339105072812575e567531@mail.gmail.com>
	 <20050728202214.GA9041@gaz.sfgoth.com>
	 <9e473391050728132757a75d5f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg, is this ok for your tree now or does it need more work?

On 7/28/05, Jon Smirl <jonsmirl@gmail.com> wrote:
> Even simpler version....
> 
> --
> Jon Smirl
> jonsmirl@gmail.com
> 
> Remove leading and trailing whitespace when text sysfs attribute is set
> signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> 
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
> @@ -207,8 +208,23 @@ flush_write_buffer(struct dentry * dentr
>         struct attribute * attr = to_attr(dentry);
>         struct kobject * kobj = to_kobj(dentry->d_parent);
>         struct sysfs_ops * ops = buffer->ops;
> +       char *x;
> 
> -       return ops->store(kobj,attr,buffer->page,count);
> +       /* locate trailing white space */
> +       while ((count > 0) && isspace(buffer->page[count - 1]))
> +               count--;
> +
> +       /* locate leading white space */
> +       x = buffer->page;
> +       if (count > 0) {
> +               while (isspace(*x))
> +                       x++;
> +               count -= (x - buffer->page);
> +       }
> +       /* terminate the string */
> +       x[count] = '\0';
> +
> +       return ops->store(kobj, attr, x, count);
>  }
> 


-- 
Jon Smirl
jonsmirl@gmail.com
