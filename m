Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266304AbUBJSwy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 13:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUBJSwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 13:52:54 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:19938
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266304AbUBJSvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 13:51:42 -0500
Date: Tue, 10 Feb 2004 19:51:37 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Michael Frank <mhf@linuxmail.org>
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Reserved page flaging of 2.4 kernel memory changed recently?
Message-ID: <20040210185137.GD4478@dualathlon.random>
References: <200402050941.34155.mhf@linuxmail.org> <20040208020624.GG31926@dualathlon.random> <200402100625.41288.mhf@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402100625.41288.mhf@linuxmail.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 11:24:01PM +0800, Michael Frank wrote:
> By what I read on LKML, 64bit is probably more fussy then 32bit. eg when 
> accessing non-existing memory such as on a system with memory holes 
> with /dev/mem often causes MCE's. 

yes, this happens on ia64 and it may happen on x86-64 too.

> And here is an example of touching non-RAM going wrong on a x86 PC:
> 
> One swsusp user received a MCE on swsusp accessing 0xa0000 (video). 
> This seems to be quite recent hardware: a Athlon mobile XP 20000.
> This Compaq evo is running alright with NOMCE on the commandline.

this is possible too.

> Here is a patch for 2.4.2[45], which marks non-ram, CPU-broken-pages, and 
> nosave kernel-pages pages with PG_nosave. 
> 
> Applications such as swsusp, netdump or debuggers have just to check 
> the PG_nosave bit to be safe.
> 
> I actually would like to rename the bit PG_nosave to PG_donttouch ;)

;)

> 
> diff -uN -r -X /home/mhf/sys/dont/dontdiff linux-2.4.24-Vanilla/arch/i386/mm/init.c linux-2.4.24-mhf179/arch/i386/mm/init.c
> --- linux-2.4.24-Vanilla/arch/i386/mm/init.c	2004-01-21 15:53:01.000000000 +0800
> +++ linux-2.4.24-mhf179/arch/i386/mm/init.c	2004-02-10 06:15:31.000000000 +0800
> @@ -451,15 +451,18 @@
>  {
>  	if (!page_is_ram(pfn)) {
>  		SetPageReserved(page);
> +		SetPageNosave(page);
>  		return;
>  	}
>  	
>  	if (bad_ppro && page_kills_ppro(pfn)) {
>  		SetPageReserved(page);
> +		SetPageNosave(page);
>  		return;
>  	}
>  	
>  	ClearPageReserved(page);
> +	ClearPageNosave(page);

why this clearpagenosave? looks superflous, you're not doing it in the
normal zone anyways.

> +#if defined(__nosave_begin)

this won't work right, __nosave_begin isn't a preprocessor thing so it
will be ignored when you uncomment it. You probably can use #if 0
instead and a comment near __nosave_begin to turn it to 1 when enabling
the suspend code.

> What is your opinion of this approach?

except for the above two nitpicks, the patch is correct and needed for
safe suspend IMHO. 2.6 seems to miss this thing too, why not add it to
2.6 first?

> BTW, The patch below is needed to run it with a nosave region on 
> Vanilla 2.4.2[45]:
> 
> diff -ruN linux-2.4.24/arch/i386/vmlinux.lds software-suspend-linux-2.4.24-rev7/arch/i386/vmlinux.lds
> --- linux-2.4.24/arch/i386/vmlinux.lds	2004-01-22 19:46:03.000000000 +1300
> +++ software-suspend-linux-2.4.24-rev7/arch/i386/vmlinux.lds	2004-01-30 15:23:38.000000000 +1300
> @@ -53,6 +53,12 @@
>    __init_end = .;
>  
>    . = ALIGN(4096);
> +  __nosave_begin = .;
> +  .data_nosave : { *(.data.nosave) }
> +  . = ALIGN(4096);
> +  __nosave_end = .;
> +
> +  . = ALIGN(4096);
>    .data.page_aligned : { *(.data.idt) }
>  
>    . = ALIGN(32);
> 
> also uncomment in mm/init.c the line:
> //extern char __nosave_begin, __nosave_end; 

yep.
