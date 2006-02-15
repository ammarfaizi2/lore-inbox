Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWBOTQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWBOTQl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 14:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWBOTQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 14:16:41 -0500
Received: from smtprelay05.ispgateway.de ([80.67.18.43]:21169 "EHLO
	smtprelay05.ispgateway.de") by vger.kernel.org with ESMTP
	id S932164AbWBOTQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 14:16:40 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: + acpi_os_acquire_object-gfp_kernel-called-with-irqs.patch added to -mm tree
Date: Wed, 15 Feb 2006 20:15:59 +0100
User-Agent: KMail/1.7.2
Cc: Davi Arnaut <davi.arnaut@gmail.com>, Dave Jones <davej@redhat.com>,
       len.brown@intel.com, pavel@ucw.cz, akpm@osdl.org
References: <200602132314.k1DNElaA011901@shell0.pdx.osdl.net> <20060213235244.GA11200@redhat.com> <20060213222406.518edeb8.davi.arnaut@gmail.com>
In-Reply-To: <20060213222406.518edeb8.davi.arnaut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602152016.05461.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 14 February 2006 02:24, Davi Arnaut wrote:
> You are right, this one instead should work better.
> 
> Signed-off-by: Davi Arnaut <davi.arnaut@gmail.com>
> --
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index ac5bbae..8d44b0d 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -1175,7 +1175,12 @@ acpi_status acpi_os_release_object(acpi_
>  
>  void *acpi_os_acquire_object(acpi_cache_t * cache)
>  {
> -	void *object = kmem_cache_alloc(cache, GFP_KERNEL);
> +	void *object;
> +	
> +	if (acpi_in_resume)
> +		object = kmem_cache_alloc(cache, GFP_ATOMIC);
> +	else
> +		object = kmem_cache_alloc(cache, GFP_KERNEL);
>  	WARN_ON(!object);
>  	return object;
>  }

Why not even fold all the memsets from the caller into this function?
This reduces code of the call sites further and makes it clearer.
Also in every call site, we do some check 
(or not as fixed by your patch :-)) and memset it afterwards.

Since kzalloc() this is the new fashion anyway :-)


Regards

Ingo Oeser

