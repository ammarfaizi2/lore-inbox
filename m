Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVDDVxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVDDVxR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 17:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVDDVvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 17:51:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:17803 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261410AbVDDVpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 17:45:49 -0400
Message-ID: <4251B585.1080009@osdl.org>
Date: Mon, 04 Apr 2005 14:45:41 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: maximilian attems <janitor@sternwelten.at>
CC: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       matt_domsch@dell.com
Subject: Re: [patch 3/3] efi eliminate bad section references
References: <20050404181136.GC12394@sputnik.stro.at>
In-Reply-To: <20050404181136.GC12394@sputnik.stro.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(adding Matt Domsch to cc:)

maximilian attems wrote:
> Randy please double check especially this one.
> there may be a better solution.
> 
> Fix efi section references:
>  remove __initdata for struct efi efi_phys 
>  and struct efi_memory_map memmap

'memmap' can be used after init, so remove __initdata from it
certainly looks correct to me.

Regarding efi_phys:
'efi_get_time' can be called after init (that "inline ... _init"
on it is confusing to me), and it calls phys_efi_get_time(),
which uses 'efi_phys', so efi_phys should not be marked
as __initdata.

OTOH, phys_efi_set_virtual_address_map() can be marked as __init.
You could add that as an efficiency measure.

so
Acked-by: Randy Dunlap <rddunlap@osdl.org>

> Error: ./arch/i386/kernel/efi.o .text refers to 000000d3 R_386_32
> .init.data
> Error: ./arch/i386/kernel/efi.o .text refers to 000000ff R_386_32
> .init.data
> 
> efi_memmap_walk (which is not __init nor static) 
> accesses both efi_phys and memmap.
> 
> Signed-off-by: maximilian attems <janitor@sternwelten.at>
> 
> 
> --- linux-2.6.12-rc1-bk5/arch/i386/kernel/efi.c.orig	2005-04-04 19:41:13.109877906 +0200
> +++ linux-2.6.12-rc1-bk5/arch/i386/kernel/efi.c	2005-04-04 19:34:23.886343763 +0200
> @@ -46,8 +46,8 @@
>  
>  struct efi efi;
>  EXPORT_SYMBOL(efi);
> -static struct efi efi_phys __initdata;
> -struct efi_memory_map memmap __initdata;
> +static struct efi efi_phys;
> +struct efi_memory_map memmap;
>  
>  /*
>   * We require an early boot_ioremap mapping mechanism initially


-- 
~Randy
