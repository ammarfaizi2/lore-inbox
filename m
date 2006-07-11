Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965229AbWGKHQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965229AbWGKHQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965236AbWGKHQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:16:58 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54961 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965229AbWGKHQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:16:57 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] msi: Only keep one msi_desc in each slab entry.
References: <m1veq5m87s.fsf@ebiederm.dsl.xmission.com>
	<84144f020607102303o3e379e95qc58cec97cbfd7d0c@mail.gmail.com>
	<m1k66kiqvw.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0607110951240.12720@sbz-30.cs.Helsinki.FI>
Date: Tue, 11 Jul 2006 01:16:12 -0600
In-Reply-To: <Pine.LNX.4.58.0607110951240.12720@sbz-30.cs.Helsinki.FI> (Pekka
	J. Enberg's message of "Tue, 11 Jul 2006 09:55:56 +0300 (EEST)")
Message-ID: <m1psgcharn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg <penberg@cs.Helsinki.FI> writes:

> On Tue, 11 Jul 2006, Eric W. Biederman wrote:
>> Please look at what the code changes.
>> Please recognize how very bad the current code is behaving.
>
> Yes, there's plenty of slab confusion going on.
>
> On Tue, 11 Jul 2006, Eric W. Biederman wrote:
>> As for the rest sure go ahead and create a patch to address it
>> but that really is a separate issue and thus a separate patch.
>> 
>> I'm just trying to keep the kernel from calling BUG_ON the first
>> time a msi irq is allocated on a kernel with a maximum NR_CPUS
>> configuration, and from wasting memory the rest of the time.
>> 
>> Or you know how bad the msi code is when every patch to fix a major
>> issue is followed up comments on how to improve the code even further.
>
> Ok.

Looks good to me. 

> Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
> ---
>
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 36bc7c4..77b08ee 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -45,16 +45,11 @@ msi_register(struct msi_ops *ops)
>  	return 0;
>  }
>  
> -static void msi_cache_ctor(void *p, kmem_cache_t *cache, unsigned long flags)
> -{
> -	memset(p, 0, NR_IRQS * sizeof(struct msi_desc));
> -}
> -
>  static int msi_cache_init(void)
>  {
>  	msi_cachep = kmem_cache_create("msi_cache",
> -			NR_IRQS * sizeof(struct msi_desc),
> -		       	0, SLAB_HWCACHE_ALIGN, msi_cache_ctor, NULL);
> +			sizeof(struct msi_desc),
> +		       	0, SLAB_HWCACHE_ALIGN, NULL, NULL);
>  	if (!msi_cachep)
>  		return -ENOMEM;
>  
> @@ -402,11 +397,10 @@ static struct msi_desc* alloc_msi_entry(
>  {
>  	struct msi_desc *entry;
>  
> -	entry = kmem_cache_alloc(msi_cachep, SLAB_KERNEL);
> +	entry = kmem_cache_zalloc(msi_cachep, GFP_KERNEL);
>  	if (!entry)
>  		return NULL;
>  
> -	memset(entry, 0, sizeof(struct msi_desc));
>  	entry->link.tail = entry->link.head = 0;	/* single message */
>  	entry->dev = NULL;
>  
