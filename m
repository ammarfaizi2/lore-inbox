Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVBNNL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVBNNL0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 08:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbVBNNL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 08:11:26 -0500
Received: from [195.23.16.24] ([195.23.16.24]:49538 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261264AbVBNNLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 08:11:23 -0500
Message-ID: <4210A345.6030304@grupopie.com>
Date: Mon, 14 Feb 2005 13:10:29 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: ARM undefined symbols.  Again.
References: <20050124154326.A5541@flint.arm.linux.org.uk> <20050131161753.GA15674@mars.ravnborg.org> <20050207114359.A32277@flint.arm.linux.org.uk> <20050208194243.GA8505@mars.ravnborg.org> <20050208200501.B3544@flint.arm.linux.org.uk> <20050209104053.A31869@flint.arm.linux.org.uk> <20050213172940.A12469@flint.arm.linux.org.uk>
In-Reply-To: <20050213172940.A12469@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Wed, Feb 09, 2005 at 10:40:53AM +0000, Russell King wrote:
>>On Tue, Feb 08, 2005 at 08:05:01PM +0000, Russell King wrote:
>>[...]
>>  LD      .tmp_vmlinux1
>>.tmp_vmlinux1: error: undefined symbol(s) found:
>>         w kallsyms_addresses
>>         w kallsyms_markers
>>         w kallsyms_names
>>         w kallsyms_num_syms
>>         w kallsyms_token_index
>>         w kallsyms_token_table
>>
>>Maybe kallsyms needs to provide an empty object with these symbols
>>defined for the first linker pass, instead of using weak symbols?
> 
> 
> So, what's the answer?  Maybe this patch?  With this, we can drop the
> __attribute__((weak)) from the kallsyms symbols since they're always
> provided.
> 
> diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/Makefile linux/Makefile
> --- orig/Makefile	Sun Feb 13 17:26:38 2005
> +++ linux/Makefile	Sun Feb 13 17:24:17 2005
> @@ -702,14 +702,20 @@ quiet_cmd_kallsyms = KSYM    $@
>        cmd_kallsyms = $(NM) -n $< | $(KALLSYMS) \
>                       $(if $(CONFIG_KALLSYMS_ALL),--all-symbols) > $@
>  
> -.tmp_kallsyms1.o .tmp_kallsyms2.o .tmp_kallsyms3.o: %.o: %.S scripts FORCE
> +.tmp_kallsyms0.o .tmp_kallsyms1.o .tmp_kallsyms2.o .tmp_kallsyms3.o: %.o: %.S scripts FORCE
>  	$(call if_changed_dep,as_o_S)
>  
> +.tmp_kallsyms0.S: FORCE
> +	@( echo ".data"; \
> +	  for sym in addresses markers names num_syms token_index token_table; \
> +	  do echo -e ".globl kallsyms_$$sym\nkallsyms_$$sym:\n"; done; \
> +	  echo ".word 0"; ) > $@

I think it would be better to pass an argument to scripts/kallsyms (like 
-0 or something) that instructed it to generate the same file it usually 
generates but without any actual symbol information.

This way it will be easier to maintain this code in case new symbols are 
needed in the future. Having this done in the Makefile means that to add 
a new symbol we will have to change scripts/kallsyms, kernel/kallsyms 
and a not so clearly related Makefile.

I'll try to make a small patch if I can get some time (maybe later this 
week).

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
