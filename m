Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264762AbTGBGJK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 02:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264763AbTGBGJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 02:09:10 -0400
Received: from angband.namesys.com ([212.16.7.85]:11401 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S264762AbTGBGJC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 02:09:02 -0400
Date: Wed, 2 Jul 2003 10:23:24 +0400
From: Oleg Drokin <green@namesys.com>
To: steven.newbury1@ntlworld.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BadRAM for 2.5.73-mm2
Message-ID: <20030702062324.GA1561@namesys.com>
References: <20030702033326.HNID28183.mta05-svc.ntlworld.com@[10.137.100.64]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030702033326.HNID28183.mta05-svc.ntlworld.com@[10.137.100.64]>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Jul 02, 2003 at 03:33:26AM +0000, steven.newbury1@ntlworld.com wrote:

> It will probably apply cleanly to 2.5.73 as well but I haven't checked it
> yet...

This

> It is based it on
> http://rick.vanrein.org/linux/badram/software/BadRAM-2.4.20.1.patch

and this patches both have a bug that effectively disables all highmem (if present)
when badram patch is activated. I contacted Rick, but never got any answer back.
(in fact I got an auto reply from some Debian bugtracking system, but that's about it).
Corrected 2.4.21 version of the patch is available at
http://linuxhacker.ru/patches/2.4.21-badram.diff

The arch/i386/mm/init.c part:
> +void __init one_highpage_init(struct page *page, int pfn, int bad_ppro,
> +                               _Bool *bad)
>   {
> +       *bad = 0;
>         if (page_is_ram(pfn) && !(bad_ppro && page_kills_ppro(pfn))) {
>                 ClearPageReserved(page);
>                 set_bit(PG_highmem, &page->flags);
>                 set_page_count(page, 1);
> -               __free_page(page);
> +#ifdef CONFIG_BADRAM
> +               if (PageBad(page))
> +                       *bad = 1;
> +               else
> +#else
> +                       __free_page(page);
> +#endif
>                 totalhigh_pages++;

should obviously get "#else" replaced with "#endif" and original "#endif" should be removed
because otherwise all of the highmem pages are either bad or used right from the initialisation.
(Yes, I have highmem (2G RAM) system with 2 bits bad and I am too lazy to to go to the store to
replace the RAM modules, so I given a patch a try and discovered this problem (which is there
for a long time it seems). I suspect that I am the only one who runs this patch on highmem system,
though ;) )

Bye,
    Oleg
