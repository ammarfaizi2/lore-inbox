Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVF2ScV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVF2ScV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 14:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVF2ScV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 14:32:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52107 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261496AbVF2ScN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 14:32:13 -0400
Date: Wed, 29 Jun 2005 11:31:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Luca Falavigna <dktrkranz@gmail.com>
Cc: prasanna@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kprobes: Verify probepoint in register_jprobe()
Message-Id: <20050629113139.533aea7d.akpm@osdl.org>
In-Reply-To: <42C2BD26.7090209@gmail.com>
References: <42C2BD26.7090209@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Falavigna <dktrkranz@gmail.com> wrote:
>
> This patch, built against version 2.6.12, checks if probepoint address is a
> function entry point using an offset value, obtained from kallsyms_lookup().
> If offset is zero, we register jprobe, otherwise we return -EINVAL.
> 

a) kallsyms holds symbols other than just function names.

b) This won't work with CONFIG_KALLSYMS=n

> 
> --- ./kernel/kprobes.c.orig	2005-06-29 00:17:43.000000000 +0000
> +++ ./kernel/kprobes.c	2005-06-29 11:08:02.000000000 +0000
> @@ -33,6 +33,7 @@
>  #include <linux/hash.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
> +#include <linux/kallsyms.h>
>  #include <asm/cacheflush.h>
>  #include <asm/errno.h>
>  #include <asm/kdebug.h>
> @@ -245,7 +246,15 @@ static struct notifier_block kprobe_exce
> 
>  int register_jprobe(struct jprobe *jp)
>  {
> -	/* Todo: Verify probepoint is a function entry point */
> +	unsigned long size, offset;
> +	char *modname, namebuf[KSYM_NAME_LEN+1];
> +	
> +	kallsyms_lookup((unsigned long)jp->kp.addr, &size,
> +			&offset, &modname, namebuf);
> +	
> +	if(unlikely(offset))
> +		return -EINVAL;
> +	
>  	jp->kp.pre_handler = setjmp_pre_handler;
>  	jp->kp.break_handler = longjmp_break_handler;
> 

