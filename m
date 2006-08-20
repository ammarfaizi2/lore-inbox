Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWHTRhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWHTRhT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 13:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWHTRhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 13:37:18 -0400
Received: from relay02.pair.com ([209.68.5.16]:59143 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S1751015AbWHTRhQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 13:37:16 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] introduce kernel_execve function to replace __KERNEL_SYSCALLS__
Date: Sun, 20 Aug 2006 12:36:49 -0500
User-Agent: KMail/1.9.4
Cc: =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
References: <20060819073031.GA25711@atjola.homenet> <20060820134745.GA11843@atjola.homenet> <200608201913.39989.arnd@arndb.de>
In-Reply-To: <200608201913.39989.arnd@arndb.de>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608201237.13194.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 August 2006 12:13, Arnd Bergmann wrote:

> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-cg/lib/execve.c	2006-08-20 19:06:00.000000000 +0200
> @@ -0,0 +1,19 @@
> +#include <asm/bug.h>
> +#include <asm/uaccess.h>
> +
> +#define __KERNEL_SYSCALLS__
> +static int errno;
> +#include <asm/unistd.h>
> +
> +int kernel_execve(const char *filename, char *const argv[], char *const
> envp[]) +{
> +	mm_segment_t fs = get_fs();
> +	int ret;
> +
> +	WARN_ON(segment_eq(fs, USER_DS));
> +	ret = execve(filename, (char **)argv, (char **)envp);
> +	if (ret)
> +		ret = errno;
> +
> +	return ret;
> +}

I noticed this global errno in lib/errno.c a while ago and was wondering what 
the right way to clean it up is. From what I remember, no one actually uses 
errno in the kernel (unless it's an "errno" they've defined locally). The 
only other place errno gets used is by all of the syscall macros.

Unless there's some TLS kernel magic that I've totally missed, using errno in 
this manner is totally unsafe anyway. So I would NAK the above because your 
kernel_execve() function gives an unsafe errno value significance it should 
not have by turning it into a return value. (As an aside, shouldn't that have 
read [ ret = -errno; ] anyway?)

Unless 'errno' has some significant reason to live on in the kernel, I think 
it would be better to kill it and write kernel syscall macros that don't muck 
with it.

Thanks,
Chase
