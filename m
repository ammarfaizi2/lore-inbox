Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWJCXjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWJCXjr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 19:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWJCXjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 19:39:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6286 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932261AbWJCXjr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 19:39:47 -0400
Date: Tue, 3 Oct 2006 16:39:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Reinette Chatre <reinette.chatre@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Inaky Perez-Gonzalez <inaky@linux.intel.com>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] bitmap: bitmap_parse takes a kernel buffer instead of a
 user buffer
Message-Id: <20061003163936.d8e26629.akpm@osdl.org>
In-Reply-To: <200610030816.27941.reinette.chatre@linux.intel.com>
References: <200610030816.27941.reinette.chatre@linux.intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2006 08:16:27 -0700
Reinette Chatre <reinette.chatre@linux.intel.com> wrote:

> lib/bitmap.c:bitmap_parse() is a library function that received as input a  user buffer. This seemed to have originated from the way the write_proc function of the /proc filesystem operates.
> 
> This function will be useful for other uses as well; for example, taking input  for /sysfs instead of /proc, so it was changed to accept kernel buffers. We have this use for the Linux UWB project, as part as the upcoming bandwidth allocator code.
> 
> Only a few routines used this function and they were changed too.

Fair enough.  But this:

>  
> -	err = cpumask_parse(buffer, count, new_value);
> +	kbuf = kmalloc(count, GFP_KERNEL);
> +	if (kbuf == NULL)
> +		return -ENOMEM;
> +	ret = copy_from_user(kbuf, buffer, count);
> +	if (ret != 0) {
> +		kfree(kbuf);
> +		return -EFAULT;
> +	}
> +	err = cpumask_parse(kbuf, count, new_value);
> +	kfree(kbuf);
>  	if (err)
>  		return err;
>
> ...
>
> -	err = cpumask_parse(buffer, count, new_value);
> +	kbuf = kmalloc(count, GFP_KERNEL);
> +	if (kbuf == NULL)
> +		return -ENOMEM;
> +	ret = copy_from_user(kbuf, buffer, count);
> +	if (ret != 0) {
> +		kfree(kbuf);
> +		return -EFAULT;
> +	}
> +	err = cpumask_parse(kbuf, count, new_value);
> +	kfree(kbuf);
>  	if (err)
>  		return err;
>  

is sending us a message ;)

How about adding a new bitmap_parse_user() (and cpumask_parse_user()) which
does the above?
