Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVC2RoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVC2RoT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 12:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVC2RoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 12:44:18 -0500
Received: from fire.osdl.org ([65.172.181.4]:16878 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261249AbVC2RoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 12:44:05 -0500
Message-ID: <424993B0.9010306@osdl.org>
Date: Tue, 29 Mar 2005 09:43:12 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yum Rayan <yum.rayan@gmail.com>
CC: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] Reduce stack usage in module.c
References: <df35dfeb05032823137a208b46@mail.gmail.com>
In-Reply-To: <df35dfeb05032823137a208b46@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yum Rayan wrote:
> Attempt to reduce stack usage in module.c (linux-2.6.12-rc1-mm3). 
> Specifically from checkstack.pl
> 
> Before patch
> ------------------
> who_is_doing_it: 512 
> obsolete_params: 160
> 
> After patch
> ----------------
> who_is_doing_it: none
So all function local variables are in registers?

> obsolete_params: 12
> 
> Also while at it, fix following in who_is_doing_it(...)
> - use only as much memory is needed
> - do not write past array index for the boundary case

I don't see a boundary case problem with the current code,
hence I don't see why the kmalloc(len + 1, GFP_KERNEL) is
needed...

> Patch is against linux-2.6.12-rc1-mm3
> 
> Thanks,
> Rayan
> 
> Signed-off-by: Yum Rayan <yum.rayan@gmail.com>
> 
> --- kernel/module.c.orig	2005-03-28 22:32:35.000000000 -0800
> +++ kernel/module.c	2005-03-28 22:49:26.000000000 -0800
File names start one level deeper than wanted.  They should begin
with linux/ or a/ or ./ e.g.
There are plenty of docs on this, please let me know if you need
references to them.

> @@ -769,15 +769,25 @@
>  	struct kernel_param *kp;
>  	unsigned int i;
>  	int ret;
> +	char *sym_name = NULL;
> +	unsigned int sym_name_len = 0;
>  
>  	kp = kmalloc(sizeof(kp[0]) * num, GFP_KERNEL);
>  	if (!kp)
>  		return -ENOMEM;

Style thing, I guess, but since the case of num == 0 doesn't do
anything here, I would just begin the function with:

	if (!num)
		return;
or		goto out;
to maintain one return point.

and then eliminate the kmalloc()s, if (num), kfree()s, and
parse_args().

> -	for (i = 0; i < num; i++) {
> -		char sym_name[128 + sizeof(MODULE_SYMBOL_PREFIX)];
> +	if (num) {
> +		sym_name_len = 128 + sizeof (MODULE_SYMBOL_PREFIX);
> +		sym_name = kmalloc(sym_name_len, GFP_KERNEL);
> +		if (!sym_name) {
> +			ret = -ENOMEM;
> +			goto free_kp;
> +		}
> +	}
>  
> -		snprintf(sym_name, sizeof(sym_name), "%s%s",
> +	for (i = 0; i < num; i++) {
> +		
> +		snprintf(sym_name, sym_name_len, "%s%s",
>  			 MODULE_SYMBOL_PREFIX, obsparm[i].name);
>  
>  		kp[i].name = obsparm[i].name;
> @@ -791,13 +801,15 @@
>  			printk("%s: falsely claims to have parameter %s\n",
>  			       name, obsparm[i].name);
>  			ret = -EINVAL;
> -			goto out;
> +			goto free_sym;
>  		}
>  		kp[i].arg = &obsparm[i];
>  	}
>  
>  	ret = parse_args(name, args, kp, num, NULL);
> - out:
> + free_sym:
> +	kfree(sym_name);
> + free_kp:
>  	kfree(kp);
>  	return ret;
>  }
> @@ -1399,12 +1411,16 @@
>  static void who_is_doing_it(void)
>  {
>  	/* Print out all the args. */
> -	char args[512];
> +	char *args;
>  	unsigned long i, len = current->mm->arg_end - current->mm->arg_start;
>  
>  	if (len > 512)
>  		len = 512;
>  
> +	args = kmalloc(len + 1, GFP_KERNEL);
> +	if (!args)
> +		return;
> +
>  	len -= copy_from_user(args, (void *)current->mm->arg_start, len);
>  
>  	for (i = 0; i < len; i++) {
> @@ -1413,6 +1429,7 @@
>  	}
>  	args[i] = 0;
>  	printk("ARGS: %s\n", args);
> +	kfree(args);
>  }
>  
>  /* Allocate and load the module: note that size of section 0 is always
> -

-- 
~Randy
