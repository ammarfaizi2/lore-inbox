Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWGKI2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWGKI2E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 04:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWGKI2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 04:28:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51922 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750729AbWGKI2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 04:28:02 -0400
Date: Tue, 11 Jul 2006 01:27:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, efault@gmx.de
Subject: Re: [patch] i386: handle_BUG(): don't print garbage if debug info
 unavailable
Message-Id: <20060711012755.59965932.akpm@osdl.org>
In-Reply-To: <200607101034_MC3-1-C497-51F7@compuserve.com>
References: <200607101034_MC3-1-C497-51F7@compuserve.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006 10:30:55 -0400
Chuck Ebbert <76306.1226@compuserve.com> wrote:

> handle_BUG() tries to print file and line number even when
> they're not available (CONFIG_DEBUG_BUGVERBOSE is not set.)
> Change this to print a message stating info is unavailable
> instead of printing a misleading message.
> 
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
> 
> ---
> 
>  Compile tested only, with/without CONFIG_DEBUG_BUGVERBOSE.
> 
>  arch/i386/kernel/traps.c |   20 +++++++++++++-------
>  1 files changed, 13 insertions(+), 7 deletions(-)
> 
> --- 2.6.18-rc1-nb.orig/arch/i386/kernel/traps.c
> +++ 2.6.18-rc1-nb/arch/i386/kernel/traps.c
> @@ -324,13 +324,14 @@ void show_registers(struct pt_regs *regs
>  
>  static void handle_BUG(struct pt_regs *regs)
>  {
> +	unsigned long eip = regs->eip;
>  	unsigned short ud2;
> +
> +#ifdef CONFIG_DEBUG_BUGVERBOSE
>  	unsigned short line;
>  	char *file;
>  	char c;
> -	unsigned long eip;
> -
> -	eip = regs->eip;
> +#endif
>  
>  	if (eip < PAGE_OFFSET)
>  		goto no_bug;
> @@ -338,21 +339,26 @@ static void handle_BUG(struct pt_regs *r
>  		goto no_bug;
>  	if (ud2 != 0x0b0f)
>  		goto no_bug;
> +	printk(KERN_EMERG "------------[ cut here ]------------\n");
> +
> +#ifdef CONFIG_DEBUG_BUGVERBOSE
>  	if (__get_user(line, (unsigned short __user *)(eip + 2)))
> -		goto bug;
> +		goto no_info;
>  	if (__get_user(file, (char * __user *)(eip + 4)) ||
>  		(unsigned long)file < PAGE_OFFSET || __get_user(c, file))
>  		file = "<bad filename>";
>  
> -	printk(KERN_EMERG "------------[ cut here ]------------\n");
>  	printk(KERN_EMERG "kernel BUG at %s:%d!\n", file, line);
> +#else
> +	goto no_info;
> +#endif
>  
>  no_bug:
>  	return;
>  
>  	/* Here we know it was a BUG but file-n-line is unavailable */
> -bug:
> -	printk(KERN_EMERG "Kernel BUG\n");
> +no_info:
> +	printk(KERN_EMERG "Kernel BUG at [verbose debug info unavailable]\n");
>  }
>  

I think we can do it a lot more tidily.

static void handle_BUG(struct pt_regs *regs)
{
	unsigned long eip = regs->eip;
	unsigned short ud2;

	if (eip < PAGE_OFFSET)
		return;
	if (__get_user(ud2, (unsigned short __user *)eip))
		return;
	if (ud2 != 0x0b0f)
		return;

	printk(KERN_EMERG "------------[ cut here ]------------\n");

#ifdef CONFIG_DEBUG_BUGVERBOSE
	do {
		unsigned short line;
		char *file;
		char c;

		if (__get_user(line, (unsigned short __user *)(eip + 2)))
			break;
		if (__get_user(file, (char * __user *)(eip + 4)) ||
		    (unsigned long)file < PAGE_OFFSET || __get_user(c, file))
			file = "<bad filename>";

		printk(KERN_EMERG "kernel BUG at %s:%d!\n", file, line);
		return;
	} while (0);
#endif
	printk(KERN_EMERG "Kernel BUG at [verbose debug info unavailable]\n");
}


OK?
