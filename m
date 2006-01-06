Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWAFPTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWAFPTT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 10:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWAFPTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 10:19:05 -0500
Received: from [195.23.16.24] ([195.23.16.24]:53915 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S932450AbWAFPTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 10:19:00 -0500
Message-ID: <43BE8A56.2070500@grupopie.com>
Date: Fri, 06 Jan 2006 15:18:46 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@sgi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.15] Tell kallsyms_lookup_name() to ignore type U entries
References: <11037.1136525779@kao2.melbourne.sgi.com>
In-Reply-To: <11037.1136525779@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> When one module exports a function symbol and another module uses that
> symbol then kallsyms shows the symbol twice.  Once from the consumer
> with a type of 'U' and once from the provider with a type of 't' or
> 'T'.  On most architectures, both entries have the same address so it
> does not matter which one is returned by kallsyms_lookup_name().  But
> on architectures with function descriptors, the 'U' entry points to the
> descriptor, not to the code body, which is not what we want.
> 
> IA64 # grep -w qla2x00_remove_one /proc/kallsyms
> a000000208c25ef8 U qla2x00_remove_one   [qla2300]   <= descriptor
> a000000208bf44c0 t qla2x00_remove_one   [qla2xxx]   <= function body
> 
> [...]
> --- linux.orig/kernel/kallsyms.c	2006-01-06 12:58:52.842111488 +1100
> +++ linux/kernel/kallsyms.c	2006-01-06 12:59:03.436355969 +1100
> @@ -144,12 +144,14 @@ unsigned long kallsyms_lookup_name(const
>  {
>  	char namebuf[KSYM_NAME_LEN+1];
>  	unsigned long i;
> -	unsigned int off;
> +	unsigned int off, prev_off;
>  
>  	for (i = 0, off = 0; i < kallsyms_num_syms; i++) {
> +		prev_off = off;
>  		off = kallsyms_expand_symbol(off, namebuf);
>  
> -		if (strcmp(namebuf, name) == 0)
> +		if (strcmp(namebuf, name) == 0 &&
> +		    kallsyms_get_symbol_type(prev_off) != 'U')

This check should not be needed as it is already done in 
scripts/kallsyms.c so that these symbols don't end up in the kernel 
symbol table at all.

It seems that only symbols from modules can suffer from this problem, 
but maybe I'm missing something here...

-- 
Paulo Marques - www.grupopie.com

Pointy-Haired Boss: I don't see anything that could stand in our way.
            Dilbert: Sanity? Reality? The laws of physics?
