Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbWIHQrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWIHQrN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 12:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWIHQrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 12:47:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31617 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750891AbWIHQrM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 12:47:12 -0400
Date: Fri, 8 Sep 2006 09:46:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 1/2] own header file for struct page.
Message-Id: <20060908094616.48849a7a.akpm@osdl.org>
In-Reply-To: <20060908111716.GA6913@osiris.boeblingen.de.ibm.com>
References: <20060908111716.GA6913@osiris.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sep 2006 13:17:16 +0200
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> This moves the definition of struct page from mm.h to its own header file
> page.h.
> This is a prereq to fix SetPageUptodate which is broken on s390:
> 
> #define SetPageUptodate(_page)
>        do {
>                struct page *__page = (_page);
>                if (!test_and_set_bit(PG_uptodate, &__page->flags))
>                        page_test_and_clear_dirty(_page);
>        } while (0)
> 
> _page gets used twice in this macro which can cause subtle bugs. Using
> __page for the page_test_and_clear_dirty call doesn't work since it
> causes yet another problem with the page_test_and_clear_dirty macro as
> well.
> In order to get of all these problems caused by macros it seems to
> be a good idea to get rid of them and convert them to static inline
> functions. Because of header file include order it's necessary to have a
> seperate header file for the struct page definition.
> 

hmm.

> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6/include/linux/page.h	2006-09-08 13:10:23.000000000 +0200

We have asm/page.h, and one would expect that a <linux/page.h> would be
related to <asm/page.h> in the usual fashion.  But it isn't.

Can we think of a different filename? page-struct.h, maybe? pageframe.h?

> +#ifndef CONFIG_DISCONTIGMEM
> +/* The array of struct pages - for discontigmem use pgdat->lmem_map */
> +extern struct page *mem_map;
> +#endif

Am surprised to see this declaration in this file.
