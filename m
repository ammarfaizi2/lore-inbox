Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWHVT0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWHVT0r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 15:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWHVT0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 15:26:47 -0400
Received: from [195.23.16.24] ([195.23.16.24]:43240 "EHLO bipbip.grupopie.com")
	by vger.kernel.org with ESMTP id S1751201AbWHVT0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 15:26:46 -0400
Message-ID: <44EB5A73.9080206@grupopie.com>
Date: Tue, 22 Aug 2006 20:26:43 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Franck <vagabon.xyz@gmail.com>
CC: rusty@rustcorp.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] kallsyms_lookup always requires buffers
References: <44EAFDCA.1080002@innova-card.com>
In-Reply-To: <44EAFDCA.1080002@innova-card.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Franck Bui-Huu wrote:
> Hi,
> 
> Some uses of kallsyms_lookup() do not need to find out the name of
> a symbol and its module's name it belongs. This is specially true
> in arch specific code, which needs to unwind the stack to show the
> back trace during opps (mips is an example). In this specific case,
> we just need to retreive the function's size and the offset of the
> active intruction inside it.
> 
> This simple patch adds a new entry "kallsyms_lookup_gently()". The
> name actually sucks but I can't figure out a coherent name with the
> rest of the file. If someone could give me a better idea...

kallsyms_lookup_size_offset() ?

Granted it is a little bigger, but it tells exactly what it does and 
there are not that many users that we have to write this name all that 
often.

> This new entry does exactly the same as kallsyms_lookup() but does
> not require any buffers to store any names. It returns 0 if it fails
> otherwise 1.
> 
> Do you think this can be usefull ?

You tell me, since you're proposing the change ;)

> diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
> index 849043c..30f8d8d 100644
> --- a/include/linux/kallsyms.h
> +++ b/include/linux/kallsyms.h
> @@ -12,6 +12,10 @@ #ifdef CONFIG_KALLSYMS
>  /* Lookup the address for a symbol. Returns 0 if not found. */
>  unsigned long kallsyms_lookup_name(const char *name);
>  
> +extern int kallsyms_lookup_gently(unsigned long addr,
> +				  unsigned long *symbolsize,
> +				  unsigned long *offset);
> +
>  /* Lookup an address.  modname is set to NULL if it's in the kernel. */
>  const char *kallsyms_lookup(unsigned long addr,
>  			    unsigned long *symbolsize,
> @@ -28,6 +32,13 @@ static inline unsigned long kallsyms_loo
>  	return 0;
>  }
>  
> +static inline const int kallsyms_lookup_gently(unsigned long addr,
> +					       unsigned long *symbolsize,
> +					       unsigned long *offset)
> +{
> +	return 0;
> +}
> +
>  static inline const char *kallsyms_lookup(unsigned long addr,
>  					  unsigned long *symbolsize,
>  					  unsigned long *offset,
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index ab16a5a..c398753 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -69,6 +69,15 @@ static inline int is_kernel(unsigned lon
>  	return in_gate_area_no_task(addr);
>  }
>  
> +static int is_kernel_addr(unsigned long addr)

Maybe change the name to kallsyms_is_kernel_addr, because this function 
does more things than what the generic name implies.

> +{
> +	if (all_var)
> +		return is_kernel(addr);
> +
> +	return is_kernel_text(addr) || is_kernel_inittext(addr) ||
> +		is_kernel_extratext(addr);
> +}
> +

[...]
> +/*
> + * Lookup an address but don't bother to find any names.
> + */
> +int kallsyms_lookup_gently(unsigned long addr, unsigned long *symbolsize,
> +			   unsigned long *offset)
> +{
> +	int rv;
> +
> +	if (is_kernel_addr(addr))
> +		rv = !!get_symbol_pos(addr, symbolsize, offset);
> +	else
> +		rv = !!module_address_lookup(addr, symbolsize, offset, NULL);
> +
> +	return rv;
> +}

<minor nitpick>

Why not just:

 > if (is_kernel_addr(addr))
 >	return !!get_symbol_pos(addr, symbolsize, offset);
 >
 > return !!module_address_lookup(addr, symbolsize, offset, NULL);

and just get rid of "rv" completely?

</minor nitpick>

> +EXPORT_SYMBOL_GPL(kallsyms_lookup_gently);

I agree with Arjan here. If kallsyms_lookup wasn't exported, I don't see 
a reason to export this either.

Everything else seems fine.

-- 
Paulo Marques - www.grupopie.com

"The face of a child can say it all, especially the
mouth part of the face."
