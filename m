Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbVDFO2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbVDFO2m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 10:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbVDFO2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 10:28:42 -0400
Received: from farside.demon.co.uk ([62.49.25.247]:19696 "EHLO
	mail.farside.org.uk") by vger.kernel.org with ESMTP id S262214AbVDFO2j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 10:28:39 -0400
References: <20050405225747.15125.8087.59570@clementine.local>
            <courier.4253BAD7.000018D2@mail.farside.org.uk>
            <aec7e5c305040606104c86712c@mail.gmail.com>
In-Reply-To: <aec7e5c305040606104c86712c@mail.gmail.com>
From: Malcolm Rowe <malcolm-linux@farside.org.uk>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] disable built-in modules V2
Date: Wed, 06 Apr 2005 15:28:38 +0100
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID: <courier.4253F216.00001A20@mail.farside.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Damm writes:
>> Regardless of anything else, won't this break booting with initcall_debug on
>> PPC64/IA64 machines? (see the definition of print_fn_descriptor_symbol() in
>> kallsyms.h)
> 
> Correct, thanks for pointing that out. The code below is probably better: 
> 
>  static void __init do_initcalls(void)
>  {
>         initcall_t *call;
> @@ -547,6 +558,9 @@ static void __init do_initcalls(void)
>         for (call = __initcall_start; call < __initcall_end; call++) {
>                 char *msg; 
> 
> +               if (!*call)
> +                       continue;
> +
>                 if (initcall_debug) {
>                         printk(KERN_DEBUG "Calling initcall 0x%p", *call);
>                         print_fn_descriptor_symbol(": %s()", (unsigned
> long) *call);

Yes, that looks more sensible. It hides the fact that the initcall ever 
existed, rather than explicitly telling you that it's been skipped, but I 
don't imagine that that's ever going to cause a problem in practice (i.e., I 
don't think anyone would ever enable "force_ohci1394=off" by mistake and 
also without noticing). 


> And I guess the idea of replacing the initcall pointer with NULL will
> work both with and without function descriptors, right? So we should
> be safe on IA64 and PPC64.

I think so, though I don't really know a great deal about this area. 


An IA64 descriptor is of the form { &code, &data_context }, and a function 
pointer is a pointer to such a descriptor. Presumably, setting a function 
pointer to NULL will either end up setting the pointer-to-descriptor to NULL 
or the code pointer to NULL, but either way, I would expect the 'if 
(!*call)' comparison to work as intended. 


Best thing would be to get someone on IA64 and/or PPC64 to check this for 
you. Also might be worth checking that the patch works as intended with 
CONFIG_MODULES=n (assuming you haven't already). 


Regards,
Malcolm
