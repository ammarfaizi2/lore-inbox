Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751484AbWB0QbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbWB0QbY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 11:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWB0QbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 11:31:24 -0500
Received: from dslsmtp.struer.net ([62.242.36.21]:5642 "EHLO
	dslsmtp.struer.net") by vger.kernel.org with ESMTP id S1751484AbWB0QbX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 11:31:23 -0500
Message-ID: <49447.194.237.142.21.1141057876.squirrel@194.237.142.21>
In-Reply-To: <1141054054.2992.130.camel@laptopd505.fenrus.org>
References: <1141053825.2992.125.camel@laptopd505.fenrus.org>
    <1141054054.2992.130.camel@laptopd505.fenrus.org>
Date: Mon, 27 Feb 2006 17:31:16 +0100 (CET)
Subject: Re: [Patch 2/4] Basic reorder infrastructure
From: sam@ravnborg.org
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org, ak@suse.de
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch puts the infrastructure in place to allow for a reordering of
> functions based inside the vmlinux.

Can we make this general instead of x86_64 only?
Then we can use Kconfig to enable it for the architectures where we want it.


>
> Index: linux-reorder2/arch/x86_64/Makefile
> ===================================================================
> --- linux-reorder2.orig/arch/x86_64/Makefile
> +++ linux-reorder2/arch/x86_64/Makefile
> @@ -35,6 +35,7 @@ CFLAGS += -m64
>  CFLAGS += -mno-red-zone
>  CFLAGS += -mcmodel=kernel
>  CFLAGS += -pipe
> +CFLAGS += -ffunction-sections

This should go in top-level Makefile
> Index: linux-reorder2/arch/x86_64/kernel/functionlist
> ===================================================================
> --- /dev/null
> +++ linux-reorder2/arch/x86_64/kernel/functionlist

I would have used extension .lds - but no strong feeling for it.

> Index: linux-reorder2/arch/x86_64/kernel/vmlinux.lds.S
> ===================================================================
> --- linux-reorder2.orig/arch/x86_64/kernel/vmlinux.lds.S
> +++ linux-reorder2/arch/x86_64/kernel/vmlinux.lds.S
> @@ -20,7 +20,12 @@ SECTIONS
>    phys_startup_64 = startup_64 - LOAD_OFFSET;
>    _text = .;			/* Text and read-only data */
>    .text :  AT(ADDR(.text) - LOAD_OFFSET) {
> +	/* First the code that has to be first for bootstrapping */
>  	*(.bootstrap.text)
> +	/* Then all the functions that are "hot" in profiles, to group them
> +           onto the same hugetlb entry */
> +	#include "functionlist"
> +	/* Then the rest */

And this part to go into include/asm-generaic/vmlinux.lds.h

>  	*(.text)
>  	SCHED_TEXT
>  	LOCK_TEXT


   Sam

