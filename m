Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbULUNPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbULUNPb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 08:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbULUNPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 08:15:30 -0500
Received: from [195.23.16.24] ([195.23.16.24]:55765 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261751AbULUNPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 08:15:15 -0500
Message-ID: <41C821DD.2030700@grupopie.com>
Date: Tue, 21 Dec 2004 13:15:09 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
Cc: hugang@soulinfo.com, linux-kernel@vger.kernel.org
Subject: Re: swsusp bigdiff [was Re: [PATCH] Software Suspend split to two
 stage V2.]
References: <20041119194007.GA1650@hugang.soulinfo.com> <20041120003010.GG1594@elf.ucw.cz>
In-Reply-To: <20041120003010.GG1594@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.29.0.5; VDF: 6.29.0.25; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> [...]
> --- clean/Documentation/sparse.txt	2004-10-16 23:48:08.000000000 +0200
> +++ linux/Documentation/sparse.txt	2004-10-24 22:44:47.000000000 +0200
> @@ -0,0 +1,72 @@
> +Copyright 2004 Linus Torvalds
> +Copyright 2004 Pavel Machek <pavel@suse.cz>
> +
> +Using sparse for typechecking
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +"__bitwise" is a type attribute, so you have to do something like this:
> +
> +        typedef int __bitwise pm_request_t;
> +
> +        enum pm_request {
> +                PM_SUSPEND = (__force pm_request_t) 1,
> +                PM_RESUME = (__force pm_request_t) 2
> +        };
> +
> +which makes PM_SUSPEND and PM_RESUME "bitwise" integers (the "__force" is
> +there because sparse will complain about casting to/from a bitwise type,
> +but in this case we really _do_ want to force the conversion). And because
> +the enum values are all the same type, now "enum pm_request" will be that
> +type too.
> +
> +And with gcc, all the __bitwise/__force stuff goes away, and it all ends
> +up looking just like integers to gcc.
> +
> +Quite frankly, you don't need the enum there. The above all really just
> +boils down to one special "int __bitwise" type.
> +
> +So the simpler way is to just do
> +
> +        typedef int __bitwise pm_request_t;
> +
> +        #define PM_SUSPEND ((__force pm_request_t) 1)
> +        #define PM_RESUME ((__force pm_request_t) 2)
> +
> +and you now have all the infrastructure needed for strict typechecking.
> +
> +One small note: the constant integer "0" is special. You can use a
> +constant zero as a bitwise integer type without sparse ever complaining.
> +This is because "bitwise" (as the name implies) was designed for making
> +sure that bitwise types don't get mixed up (little-endian vs big-endian
> +vs cpu-endian vs whatever), and there the constant "0" really _is_
> +special.
> +
> +Modify top-level Makefile to say
> +
> +CHECK           = sparse -Wbitwise
> +
> +or you don't get any checking at all.
> +
> +
> +Where to get sparse
> +~~~~~~~~~~~~~~~~~~~
> +
> +With BK, you can just get it from
> +
> +        bk://sparse.bkbits.net/sparse
> +
> +and DaveJ has tar-balls at
> +
> +	http://www.codemonkey.org.uk/projects/bitkeeper/sparse/
> +
> +
> +Once you have it, just do
> +
> +        make
> +        make install
> +
> +as your regular user, and it will install sparse in your ~/bin directory.
> +After that, doing a kernel make with "make C=1" will run sparse on all the
> +C files that get recompiled, or with "make C=2" will run sparse on the
> +files whether they need to be recompiled or not (ie the latter is fast way
> +to check the whole tree if you have already built it).
> --- clean/Makefile	2004-10-19 14:16:26.000000000 +0200
> +++ linux/Makefile	2004-10-29 11:56:48.000000000 +0200
> @@ -325,7 +325,7 @@
>  DEPMOD		= /sbin/depmod
>  KALLSYMS	= scripts/kallsyms
>  PERL		= perl
> -CHECK		= sparse
> +CHECK		= sparse -Wbitwise

I know this is a "big diff" patch, but it seems that these sparse 
changes are completely unrelated to software suspend.

-- 
Paulo Marques - www.grupopie.com

"A journey of a thousand miles begins with a single step."
Lao-tzu, The Way of Lao-tzu

