Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWGKGDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWGKGDq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 02:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965130AbWGKGDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 02:03:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:41390 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964798AbWGKGDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 02:03:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=geoCE8mjNiCqBSbNoI+b529PPLRrHp7XpjIj/Y7e55Hvt3GpME6UoYy/onsMHHWnyYSYD8mO1PPIQJsXA1d6QtnqAczL5/e+f8uN/Vd2f1ouJDbvV1EkLmCDZMiiqPH4GjM6+WfWWP0YKOKsaDn7R6Uzt94TpGcy5ohlxeMYfc0=
Message-ID: <84144f020607102303o3e379e95qc58cec97cbfd7d0c@mail.gmail.com>
Date: Tue, 11 Jul 2006 09:03:43 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] msi: Only keep one msi_desc in each slab entry.
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <m1veq5m87s.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <m1veq5m87s.fsf@ebiederm.dsl.xmission.com>
X-Google-Sender-Auth: ed0a9f5d84599f42
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> It looks like someone confused kmem_cache_create with a different
> allocator and was attempting to give it knowledge of how many cache
> entries there were.
>
> With the unfortunate result that each slab entry was big enough to
> hold every irq.
>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  drivers/pci/msi.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 0cd4a3e..082e942 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -40,13 +40,13 @@ msi_register(struct msi_ops *ops)
>
>  static void msi_cache_ctor(void *p, kmem_cache_t *cache, unsigned long flags)
>  {
> -       memset(p, 0, NR_IRQS * sizeof(struct msi_desc));
> +       memset(p, 0, sizeof(struct msi_desc));

You can use kmem_cache_zalloc() for this.

>  }
>
>  static int msi_cache_init(void)
>  {
>         msi_cachep = kmem_cache_create("msi_cache",
> -                       NR_IRQS * sizeof(struct msi_desc),
> +                       sizeof(struct msi_desc),
>                         0, SLAB_HWCACHE_ALIGN, msi_cache_ctor, NULL);
>         if (!msi_cachep)
>                 return -ENOMEM;
> --
> 1.4.1.gac83a
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
