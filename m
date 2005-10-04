Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbVJDRI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbVJDRI6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 13:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbVJDRI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 13:08:58 -0400
Received: from mx1.suse.de ([195.135.220.2]:18350 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964826AbVJDRI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 13:08:58 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] [RFC][PATCH][Fix] swsusp: Yet another attempt to fix Bug #4959
Date: Tue, 4 Oct 2005 19:09:00 +0200
User-Agent: KMail/1.8.2
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <200510011813.54755.rjw@sisk.pl>
In-Reply-To: <200510011813.54755.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510041909.00714.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Saturday 01 October 2005 18:13, Rafael J. Wysocki wrote:

> Your comments, criticisms and (preferably) suggestions will be appreciated.

First always write a full description of the problem and the rationale
of the change and a overview what it changes. Also please add Signed-off-by 
lines.

> +#ifdef CONFIG_SOFTWARE_SUSPEND
> +extern unsigned long resume_table_start, resume_table_end;

These should be all in some include. Adding externs in C files is near
always wrong because it avoids cross file type checking.

Also the convention is to add _pfn to variables that are in PFNs,
otherwise it's full addresses.


> 10:40:03.000000000 +0200 +++
> linux-2.6.14-rc3/arch/x86_64/mm/init.c	2005-10-01 14:31:34.000000000 +0200
> @@ -260,6 +260,9 @@
>  	pmds = (end + PMD_SIZE - 1) >> PMD_SHIFT;
>  	tables = round_up(puds * sizeof(pud_t), PAGE_SIZE) +
>  		 round_up(pmds * sizeof(pmd_t), PAGE_SIZE);
> +#ifdef CONFIG_SOFTWARE_SUSPEND
> +	tables += tables;
> +#endif

This needs a comment. Also I would still prefer if it was allocated
only when suspend is actually attempted.


>  	table_start = find_e820_area(0x8000, __pa_symbol(&_text), tables);
>  	if (table_start == -1UL)
> @@ -272,6 +275,7 @@
>  /* Setup the direct mapping of the physical memory at PAGE_OFFSET.
>     This runs before bootmem is initialized and gets pages directly from
> the physical memory. To access them they are temporarily mapped. */
> +#ifndef CONFIG_SOFTWARE_SUSPEND
>  void __init init_memory_mapping(unsigned long start, unsigned long end)
>  {
>  	unsigned long next;
> @@ -307,6 +311,69 @@
>  	       table_start<<PAGE_SHIFT,
>  	       table_end<<PAGE_SHIFT);
>  }
> +#else
> +
> +extern pgd_t resume_level4_pgt[];

These should be in some include again.

I don't like it that you duplicated the function fully. Is that really 
needed?


-Andi
