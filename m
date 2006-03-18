Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWCRTyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWCRTyv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 14:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWCRTyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 14:54:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9106 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750827AbWCRTyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 14:54:50 -0500
Date: Sat, 18 Mar 2006 11:48:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: bunk@stusta.de, pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: -mm: PM=y, VT=n doesn't compile
Message-Id: <20060318114825.75dba55a.akpm@osdl.org>
In-Reply-To: <200603181704.44873.rjw@sisk.pl>
References: <20060317171814.GO3914@stusta.de>
	<200603181704.44873.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> --- linux-2.6.16-rc6-mm2.orig/drivers/base/power/suspend.c
>  +++ linux-2.6.16-rc6-mm2/drivers/base/power/suspend.c
>  @@ -8,6 +8,9 @@
>    *
>    */
>   
>  +#include <linux/vt_kern.h>
>  +#include <linux/kbd_kern.h>
>  +#include <linux/console.h>
>   #include <linux/device.h>
>   #include <linux/kallsyms.h>
>   #include <linux/pm.h>
>  @@ -65,6 +68,17 @@ int suspend_device(struct device * dev, 
>   	return error;
>   }
>   
>  +#ifdef CONFIG_VT
>  +static inline int is_suspend_console_safe(void)
>  +{
>  +	/* It is unsafe to suspend devices while X has control of the
>  +	 * hardware. Make sure we are running on a kernel-controlled console.
>  +	 */
>  +	return vc_cons[fg_console].d->vc_mode == KD_TEXT;
>  +}

Please implement this inside the vt subsystem, not the pm subsystem.  That way

a) It gets to be called "console_is_in_text_mode()", or
   "vt_not_running_X()" or something, which is something someone else might
   want to know.  

b) People who work on vt code don't need to keep an eye on a hunk of pm
   code at the same time.

c) You won't need all those includes.

>  +#else
>  +#define is_suspend_console_safe()	1

And this can go in console.h

>  +#endif
