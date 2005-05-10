Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbVEJWQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbVEJWQI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 18:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVEJWQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 18:16:07 -0400
Received: from ns2.suse.de ([195.135.220.15]:2700 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261838AbVEJWPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 18:15:53 -0400
Date: Wed, 11 May 2005 00:15:52 +0200
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       axboe@suse.de, alexn@dsv.su.se, lnxluv@yahoo.com
Subject: Re: [BUG][Resend] 2.6.12-rc3-mm3: Kernel BUG at "mm/slab.c":1219 [update]
Message-ID: <20050510221552.GR25612@wotan.suse.de>
References: <200505092239.37834.rjw@sisk.pl> <20050509145424.6ffba49a.akpm@osdl.org> <200505101443.31229.rjw@sisk.pl> <20050510112224.761f5d68.akpm@osdl.org> <20050510211121.GO25612@wotan.suse.de> <Pine.LNX.4.58.0505101443140.23713@graphe.net> <20050510214918.GQ25612@wotan.suse.de> <Pine.LNX.4.58.0505101457530.23713@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505101457530.23713@graphe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 03:01:13PM -0700, Christoph Lameter wrote:
> On Tue, 10 May 2005, Andi Kleen wrote:
> 
> > > +  . = ALIGN(32);
> >
> > This should be . = ALIGN(CONFIG_X86_L1_CACHE_BYTES)
> >
> > It was wrong on i386 already btw, which needs the same.
> 
> i386 always specifies the numbers and does not use symbolic constants.
> We better leave that as it is.

That's broken then and needs to be fixed.

> 
> > > +  /* Rarely changed data like cpu maps */
> > > +  . = ALIGN(4096);
> >
> > Does it really need an 4096 byte alignment? That seems like
> > a waste of memory. Cache line alignment should be enough.
> 
> Ok.

Looks good.

-Andi

> 
> Index: linux-2.6.11/arch/i386/kernel/vmlinux.lds.S
> ===================================================================
> --- linux-2.6.11.orig/arch/i386/kernel/vmlinux.lds.S	2005-05-10 13:35:25.000000000 -0700
> +++ linux-2.6.11/arch/i386/kernel/vmlinux.lds.S	2005-05-10 13:59:18.000000000 -0700
> @@ -58,7 +58,7 @@ SECTIONS
>    }
> 
>    /* rarely changed data like cpu maps */
> -  . = ALIGN(4096);
> +  . = ALIGN(32);
>    .data.mostly_readonly : AT(ADDR(.data.mostly_readonly) - LOAD_OFFSET) {
>  	*(.data.mostly_readonly)
>    }
> Index: linux-2.6.11/arch/x86_64/kernel/vmlinux.lds.S
> ===================================================================
> --- linux-2.6.11.orig/arch/x86_64/kernel/vmlinux.lds.S	2005-05-10 13:35:24.000000000 -0700
> +++ linux-2.6.11/arch/x86_64/kernel/vmlinux.lds.S	2005-05-10 14:02:06.000000000 -0700
> @@ -42,6 +42,13 @@ SECTIONS
>  	CONSTRUCTORS
>  	}
> 
> +  . = ALIGN(CONFIG_X86_L1_CACHE_BYTES);
> +  .data.cacheline_aligned : { (.data.cacheline_aligned) }
> +
> +  /* Rarely changed data like cpu maps */
> +  . = ALIGN(CONFIG_X86_L1_CACHE_BYTES);
> +  .data.mostly_readonly : { *(.data.mostly_readonly) }
> +
>    _edata = .;			/* End of data section */
> 
>    __bss_start = .;		/* BSS */
