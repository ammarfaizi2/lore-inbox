Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVCGEAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVCGEAd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 23:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVCGEAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 23:00:33 -0500
Received: from fire.osdl.org ([65.172.181.4]:56967 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261495AbVCGEAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 23:00:25 -0500
Date: Sun, 6 Mar 2005 19:59:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, barryn@pobox.com
Subject: Re: [Bug 4298] swsusp fails to suspend if CONFIG_DEBUG_PAGEALLOC is
 also enabled
Message-Id: <20050306195954.6d13cff9.akpm@osdl.org>
In-Reply-To: <20050306225730.GA1414@elf.ucw.cz>
References: <20050306030852.23eb59db.akpm@osdl.org>
	<20050306225730.GA1414@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
> 
> > Problem Description:
> > swsusp normally works, but if I enable CONFIG_DEBUG_PAGEALLOC, it breaks --
> > after "PM: snapshotting memory", swsusp never gets to the "critical section" and
> > it kind of bounces back from the suspend attempt, for lack of a better way for
> > me to describe the effect.
> 
> Okay, that is because low-level assembly requires PSE (4mb pages for
> kernel) and DEBUG_PAGEALLOC disables that capability.
> 
> If you feel like rewriting assembly code to turn off paging (and thus
> working with PSE), go ahead, but I do not think it is worth the
> trouble.
> 
> OTOH we should at least tell people what went wrong, some people seen
> same problem on VIA cpus... Please apply,
> 

Isn't some Kconfig solution appropriate here?

> 
> --- clean/include/asm-i386/suspend.h	2004-12-25 13:35:02.000000000 +0100
> +++ linux/include/asm-i386/suspend.h	2005-03-02 01:05:33.000000000 +0100
> @@ -10,10 +10,12 @@
>  arch_prepare_suspend(void)
>  {
>  	/* If you want to make non-PSE machine work, turn off paging
> -           in do_magic. swsusp_pg_dir should have identity mapping, so
> +           in swsusp_arch_suspend. swsusp_pg_dir should have identity mapping, so
>             it could work...  */
> -	if (!cpu_has_pse)
> +	if (!cpu_has_pse) {
> +		printk(KERN_ERR "PSE is required for swsusp.\n");
>  		return -EPERM;
> +	}
>  	return 0;
>  }
>  
> -- 
> People were complaining that M$ turns users into beta-testers...
> ...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
