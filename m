Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWHSIOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWHSIOj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 04:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWHSIOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 04:14:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20353 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751479AbWHSIOi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 04:14:38 -0400
Date: Sat, 19 Aug 2006 01:14:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?B?Qmr2cm4=?= Steinbrink <B.Steinbrink@gmx.de>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Return real errno from execve in
 ____call_usermodehelper
Message-Id: <20060819011428.05ec2ae4.akpm@osdl.org>
In-Reply-To: <20060819073031.GA25711@atjola.homenet>
References: <20060819073031.GA25711@atjola.homenet>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Aug 2006 09:30:31 +0200
Björn Steinbrink <B.Steinbrink@gmx.de> wrote:

> If execve fails in ____call_usermodehelper we treat its return value as
> error code, but as execve is a syscall, we actually want -errno there.
> 
> Signed-off-by: Björn Steinbrink <B.Steinbrink@gmx.de>
> 
> --
> 
> diff --git a/kernel/kmod.c b/kernel/kmod.c
> index 1d32def..865abc0 100644
> --- a/kernel/kmod.c
> +++ b/kernel/kmod.c
> @@ -149,8 +149,10 @@ static int ____call_usermodehelper(void 
>  	set_cpus_allowed(current, CPU_MASK_ALL);
>  
>  	retval = -EPERM;
> -	if (current->fs->root)
> -		retval = execve(sub_info->path, sub_info->argv,sub_info->envp);
> +	if (current->fs->root) {
> +		execve(sub_info->path, sub_info->argv, sub_info->envp);
> +		retval = -errno;
> +	}
>  
>  	/* Exec failed? */
>  	sub_info->retval = retval;

ug.  I wish we could find some way of using do_execve() here.  Or hoist
sys_execve() out of the architectures.
