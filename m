Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965983AbWKINTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965983AbWKINTX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 08:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965984AbWKINTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 08:19:23 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:50361 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965983AbWKINTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 08:19:22 -0500
Date: Thu, 9 Nov 2006 22:18:57 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [PATHC] [2.6.19-rc4-mm2] driver/base/memory.c :: remove
 warnings of sysfs_create_file()
Message-Id: <20061109221857.77df443a.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20061108133859.cdaa8127.akpm@osdl.org>
References: <20061108155921.62f9a68f.kamezawa.hiroyu@jp.fujitsu.com>
	<20061108133859.cdaa8127.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2006 13:38:59 -0800
Andrew Morton <akpm@osdl.org> wrote:
> I think the below is better?
> 
Ah yes. It seems better. Thank you.

-Kame

> From: Andrew Morton <akpm@osdl.org>
> 
> Do proper error-checking and propagation in drivers/base/memory.c, hence fix
> __must_check warnings.
> 
> Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/base/memory.c |   34 +++++++++++++++++++++++-----------
>  1 files changed, 23 insertions(+), 11 deletions(-)
> 
> diff -puN drivers/base/memory.c~driver-base-memoryc-remove-warnings-of drivers/base/memory.c
> --- a/drivers/base/memory.c~driver-base-memoryc-remove-warnings-of
> +++ a/drivers/base/memory.c
> @@ -290,9 +290,8 @@ static CLASS_ATTR(block_size_bytes, 0444
>  
>  static int block_size_init(void)
>  {
> -	sysfs_create_file(&memory_sysdev_class.kset.kobj,
> -		&class_attr_block_size_bytes.attr);
> -	return 0;
> +	return sysfs_create_file(&memory_sysdev_class.kset.kobj,
> +				&class_attr_block_size_bytes.attr);
>  }
>  
>  /*
> @@ -323,12 +322,14 @@ static CLASS_ATTR(probe, 0700, NULL, mem
>  
>  static int memory_probe_init(void)
>  {
> -	sysfs_create_file(&memory_sysdev_class.kset.kobj,
> -		&class_attr_probe.attr);
> -	return 0;
> +	return sysfs_create_file(&memory_sysdev_class.kset.kobj,
> +				&class_attr_probe.attr);
>  }
>  #else
> -#define memory_probe_init(...)	do {} while (0)
> +static inline int memory_probe_init(void)
> +{
> +	return 0;
> +}
>  #endif
>  
>  /*
> @@ -431,9 +432,12 @@ int __init memory_dev_init(void)
>  {
>  	unsigned int i;
>  	int ret;
> +	int err;
>  
>  	memory_sysdev_class.kset.uevent_ops = &memory_uevent_ops;
>  	ret = sysdev_class_register(&memory_sysdev_class);
> +	if (ret)
> +		goto out;
>  
>  	/*
>  	 * Create entries for memory sections that were found
> @@ -442,11 +446,19 @@ int __init memory_dev_init(void)
>  	for (i = 0; i < NR_MEM_SECTIONS; i++) {
>  		if (!valid_section_nr(i))
>  			continue;
> -		add_memory_block(0, __nr_to_section(i), MEM_ONLINE, 0);
> +		err = add_memory_block(0, __nr_to_section(i), MEM_ONLINE, 0);
> +		if (!ret)
> +			ret = err;
>  	}
>  
> -	memory_probe_init();
> -	block_size_init();
> -
> +	err = memory_probe_init();
> +	if (!ret)
> +		ret = err;
> +	err = block_size_init();
> +	if (!ret)
> +		ret = err;
> +out:
> +	if (ret)
> +		printk(KERN_ERR "%s() failed: %d\n", __FUNCTION__, ret);
>  	return ret;
>  }
> _
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

