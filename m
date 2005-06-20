Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVFTTK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVFTTK5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 15:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVFTTJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 15:09:50 -0400
Received: from alog0285.analogic.com ([208.224.222.61]:29621 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261481AbVFTTHd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 15:07:33 -0400
Date: Mon, 20 Jun 2005 15:07:20 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Telemaque Ndizihiwe <telendiz@eircom.net>
cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replaces two GOTO statements with one IF_ELSE statement
 in /fs/open.c
In-Reply-To: <Pine.LNX.4.62.0506201834460.5008@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0506201504440.5255@chaos.analogic.com>
References: <Pine.LNX.4.62.0506201834460.5008@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2005, Telemaque Ndizihiwe wrote:

>
> This Patch replaces two GOTO statements and their corresponding LABELs
> with one IF_ELSE statement in /fs/open.c, 2.6.12 kernel.
> The patch keeps the same implementation of sys_open system call, it only
> makes the code smaller and easy to read.
>

Did you check and benchmark the resulting code? The goto statements
are never because the kernel developers didn't know how to use
other constructs, you know.

The goto statements are so that the normal path continues
straight through the code while the exceptions take the jumps.


> Signed-off-by: Telemaque Ndizihiwe <telendiz@eircom.net>
>
>
> --- linux-2.6.12/fs/open.c.orig	2005-06-20 15:15:52.000000000 +0100
> +++ linux-2.6.12/fs/open.c	2005-06-20 15:38:47.580923552 +0100
> @@ -945,19 +945,16 @@ asmlinkage long sys_open(const char __us
>  		if (fd >= 0) {
>  			struct file *f = filp_open(tmp, flags, mode);
>  			error = PTR_ERR(f);
> -			if (IS_ERR(f))
> -				goto out_error;
> -			fd_install(fd, f);
> +			if (IS_ERR(f)) {
> +				put_unused_fd(fd);
> +				fd = error;
> +			} else {
> +				fd_install(fd, f);
> +			}
>  		}
> -out:
>  		putname(tmp);
>  	}
>  	return fd;
> -
> -out_error:
> -	put_unused_fd(fd);
> -	fd = error;
> -	goto out;
>  }
>  EXPORT_SYMBOL_GPL(sys_open);
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
