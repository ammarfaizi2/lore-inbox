Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266275AbUHBGAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266275AbUHBGAd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 02:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266287AbUHBGAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 02:00:32 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:453 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S266275AbUHBGA2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 02:00:28 -0400
Subject: Re: [RFC] [PATCH 1/2] export module parameters in sysfs for
	modules _and_ built-in code
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dominik Brodowski <linux@dominikbrodowski.de>, Greg KH <greg@kroah.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040801165407.GA8667@dominikbrodowski.de>
References: <20040801165407.GA8667@dominikbrodowski.de>
Content-Type: text/plain
Message-Id: <1091426395.430.13.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 02 Aug 2004 15:59:57 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-02 at 02:54, Dominik Brodowski wrote:
> Create a new /sys top-level directory named "parameters", and make all
> to-be-sysfs-exported module parameters available as attributes to kobjects.
> Currently, only module parameters in _modules_ are exported in /sys/modules/,
> while those of "modules" built into the kernel can be set by the kernel command 
> line, but not read or set via sysfs.

Thanks for this Dominik!

One question from reading the code:


> diff -ruN linux-original/kernel/module.c linux/kernel/module.c
> --- linux-original/kernel/module.c	2004-08-01 18:40:25.939948264 +0200
> +++ linux/kernel/module.c	2004-08-01 18:39:01.097846224 +0200
> @@ -1131,6 +1131,12 @@
>  };
>  static decl_subsys(module, &module_ktype, NULL);
>  
> +extern int module_param_sysfs_setup(struct module *mod, 
> +				    struct kernel_param *kparam,
> +				    unsigned int num_params);
> +
> +extern void module_param_sysfs_remove(struct module *mod);

Put these in moduleparam.h please, otherwise AKPM will kill us both.

> +	kbuild_modname = kmalloc(sizeof(char) * (MAX_KBUILD_MODNAME + 1), GFP_KERNEL);
> +	if (!kbuild_modname)
> +		return -ENOMEM;
> +	memset(kbuild_modname, 0, sizeof(char) * (MAX_KBUILD_MODNAME + 1));

...

> +	kfree (kbuild_modname);

I would have thought this a good candidate for a stack variable?

> +/* Needs to be before __initcall(module_init) */
> +fs_initcall(param_sysfs_init);

That's horrible.  And I think the initcall in module.c should be removed
in your second patch, no?

Rusty,
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

