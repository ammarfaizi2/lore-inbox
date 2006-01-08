Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752657AbWAHSPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657AbWAHSPV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 13:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752670AbWAHSPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 13:15:21 -0500
Received: from [139.30.44.16] ([139.30.44.16]:35914 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1752657AbWAHSPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 13:15:21 -0500
Date: Sun, 8 Jan 2006 19:15:19 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: Michael Buesch <mbuesch@freenet.de>, arjan@infradead.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 1/4] move capable() to capability.h
In-Reply-To: <20060107215106.38d58bb9.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.63.0601081904170.6962@gockel.physik3.uni-rostock.de>
References: <1136543825.2940.8.camel@laptopd505.fenrus.org>
 <200601061218.17369.mbuesch@freenet.de> <1136546539.2940.28.camel@laptopd505.fenrus.org>
 <200601061226.42416.mbuesch@freenet.de> <20060107215106.38d58bb9.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jan 2006, Randy.Dunlap wrote:

> (nothing to do with inlining here)
> 
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> headers + core:
> - Move capable() from sched.h to capability.h;
> - Use <linux/capability.h> where capable() is used
> 	(in include/, block/, ipc/, kernel/, a few drivers/,
> 	mm/, security/, & sound/;
> 	many more drivers/ to go)
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>

> --- linux-2615-g3.orig/include/linux/capability.h
> +++ linux-2615-g3/include/linux/capability.h
> @@ -43,6 +43,7 @@ typedef struct __user_cap_data_struct {
>  #ifdef __KERNEL__
>  
>  #include <linux/spinlock.h>
> +#include <asm/current.h>
>  
>  /* #define STRICT_CAP_T_TYPECHECKS */
>  
> @@ -356,6 +357,20 @@ static inline kernel_cap_t cap_invert(ke
>  
>  #define cap_is_fs_cap(c)     (CAP_TO_MASK(c) & CAP_FS_MASK)
>  
> +#ifdef CONFIG_SECURITY
> +/* code is in security.c */
> +extern int capable(int cap);
> +#else
> +static inline int capable(int cap)
> +{
> +	if (cap_raised(current->cap_effective, cap)) {
> +		current->flags |= PF_SUPERPRIV;
> +		return 1;
> +	}
> +	return 0;
> +}
> +#endif

I wonder how this can actually work. For dereferencing current, it is not 
enough to include <asm/current.h>. The actual layout of struct task_struct
needs to be known to the compiler, which is given in <linux/sched.h>.

Maybe you were just lucky with your .config and every file using capable()
just by chance also included <linux/sched.h>?

(Chances are not bad since currently about every other .c file includes 
sched.h. However, I have patches pending to reduce this number to ~500..1000)

Uninlining capable() might indeed help us here.

Tim
