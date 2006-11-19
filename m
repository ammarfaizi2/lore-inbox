Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754410AbWKSCFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754410AbWKSCFI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 21:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755498AbWKSCFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 21:05:08 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45495 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1754410AbWKSCFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 21:05:06 -0500
Date: Sun, 19 Nov 2006 03:04:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH 1/4] swsusp: Untangle thaw_processes
Message-ID: <20061119020445.GB15873@elf.ucw.cz>
References: <200611182335.27453.rjw@sisk.pl> <200611182347.05656.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611182347.05656.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Move the loop from thaw_processes() to a separate function and call it
> independently for kernel threads and user space processes so that the order
> of thawing tasks is clearly visible.
> 
> Drop thaw_kernel_threads() which is never used.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  include/linux/freezer.h |    6 -----
>  kernel/power/process.c  |   55 +++++++++++++++++++++++++++---------------------
>  2 files changed, 33 insertions(+), 28 deletions(-)
> 
> Index: linux-2.6.19-rc5-mm2/include/linux/freezer.h
> ===================================================================
> --- linux-2.6.19-rc5-mm2.orig/include/linux/freezer.h
> +++ linux-2.6.19-rc5-mm2/include/linux/freezer.h
> @@ -1,8 +1,5 @@
>  /* Freezer declarations */
>  
> -#define FREEZER_KERNEL_THREADS 0
> -#define FREEZER_ALL_THREADS 1
> -
>  #ifdef CONFIG_PM
>  /*
>   * Check if a process has been frozen
> @@ -60,8 +57,7 @@ static inline void frozen_process(struct
>  
>  extern void refrigerator(void);
>  extern int freeze_processes(void);
> -#define thaw_processes() do { thaw_some_processes(FREEZER_ALL_THREADS); } while(0)
> -#define thaw_kernel_threads() do { thaw_some_processes(FREEZER_KERNEL_THREADS); } while(0)
> +extern void thaw_processes(void);
>  
>  static inline int try_to_freeze(void)
>  {
> Index: linux-2.6.19-rc5-mm2/kernel/power/process.c
> ===================================================================
> --- linux-2.6.19-rc5-mm2.orig/kernel/power/process.c
> +++ linux-2.6.19-rc5-mm2/kernel/power/process.c
> @@ -20,6 +20,8 @@
>   */
>  #define TIMEOUT	(20 * HZ)
>  
> +#define FREEZER_KERNEL_THREADS 0
> +#define FREEZER_USER_SPACE 1

The variable is named "is_user_space"... so maybe the defines are not
strictly needed?

> +	do_each_thread(g, p) {
> +		if (!freezeable(p))
> +			continue;
>  
> +		if (is_user_space(p)) {
> +			if (!thaw_user_space)
> +				continue;
> +		} else {
> +			if (thaw_user_space)
> +				continue;
> +		}

if (is_user_space(p) != thaw_user_space)
	continue;

?

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
