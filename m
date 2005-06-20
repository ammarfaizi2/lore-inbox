Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVFTWkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVFTWkJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 18:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVFTWjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 18:39:54 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:33297 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262279AbVFTWEs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:04:48 -0400
Message-ID: <42B73E03.9020900@tmr.com>
Date: Mon, 20 Jun 2005 18:06:59 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Telemaque Ndizihiwe <telendiz@eircom.net>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replaces two GOTO statements with one IF_ELSE statement
 in   /fs/open.c
References: <Pine.LNX.4.62.0506201834460.5008@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.62.0506201834460.5008@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Telemaque Ndizihiwe wrote:
> 
> This Patch replaces two GOTO statements and their corresponding LABELs
> with one IF_ELSE statement in /fs/open.c, 2.6.12 kernel.
> The patch keeps the same implementation of sys_open system call, it only 
> makes the code smaller and easy to read.

Full credit with making the code more readable and maintainable. I'd 
like to look at the code generated to see if you have introduced a 
slowdown, however. My personal preference is for readable code and let 
the compiler sort it out, but I know there are people who would trade 
ugly code to save a cycle even in seldom-used code paths.

You might like to see if "unlikely" halps the code, I won't have a 
recent compiler until tomorrow night, since I'm locked into AS3.0 (gcc 
3.2.3) today and tomorrow. Oops, I do have 3.3.2 on my lappie, but 
that's still old.

> 
> Signed-off-by: Telemaque Ndizihiwe <telendiz@eircom.net>
> 
> 
> --- linux-2.6.12/fs/open.c.orig    2005-06-20 15:15:52.000000000 +0100
> +++ linux-2.6.12/fs/open.c    2005-06-20 15:38:47.580923552 +0100
> @@ -945,19 +945,16 @@ asmlinkage long sys_open(const char __us
>          if (fd >= 0) {
>              struct file *f = filp_open(tmp, flags, mode);
>              error = PTR_ERR(f);
> -            if (IS_ERR(f))
> -                goto out_error;
> -            fd_install(fd, f);
> +            if (IS_ERR(f)) {
> +                put_unused_fd(fd);
> +                fd = error;
> +            } else {
> +                fd_install(fd, f);
> +            }
>          }
> -out:
>          putname(tmp);
>      }
>      return fd;
> -
> -out_error:
> -    put_unused_fd(fd);
> -    fd = error;
> -    goto out;
>  }
>  EXPORT_SYMBOL_GPL(sys_open);
> 

