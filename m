Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbVJUAqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbVJUAqn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 20:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbVJUAqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 20:46:43 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:4288 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964836AbVJUAql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 20:46:41 -0400
Date: Fri, 21 Oct 2005 02:46:30 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: David Gibson <david@gibson.dropbear.id.au>
cc: kbuild-devel@lists.sourceforge.net, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix Kconfig performance bug
In-Reply-To: <20051020032342.GA11273@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0510210132210.1386@scrub.home>
References: <20051020032342.GA11273@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 20 Oct 2005, David Gibson wrote:

> When doing its recursive dependency check, scripts/kconfig/conf uses
> the flag SYMBOL_CHECK_DONE to avoid rechecking a symbol it has already
> checked.  However, that flag is only set at the top level, so if a
> symbol is first encountered as a dependency of another symbol it will
> be rechecked every time it is encountered until it's encountered at
> the top level.

You're correct, the check does too much.

> Index: working-2.6/scripts/kconfig/symbol.c
> ===================================================================
> --- working-2.6.orig/scripts/kconfig/symbol.c	2005-10-20 12:40:45.000000000 +1000
> +++ working-2.6/scripts/kconfig/symbol.c	2005-10-20 12:41:43.000000000 +1000
> @@ -758,6 +758,8 @@
>  out:
>  	if (sym2)
>  		printf(" %s", sym->name);
> +	else
> +		sym->flags |= SYMBOL_CHECK_DONE;
>  	sym->flags &= ~SYMBOL_CHECK;
>  	return sym2;
>  }

Actually this way it becomes redundant with SYMBOL_CHECKED, could you 
merge these two flags? The above check would be also probably better:

	if (sym2) {
		printf(" %s", sym->name);
		if (sym2 == sym) {
			printf("\n");
			sym2 = NULL;
		}
	}

So that this check will stop when it hits the start symbol and continue 
looking for more dependency problems, which is I think I intended with the 
original code.

> Index: working-2.6/scripts/kconfig/zconf.y
> ===================================================================
> --- working-2.6.orig/scripts/kconfig/zconf.y	2005-10-20 12:40:45.000000000 +1000
> +++ working-2.6/scripts/kconfig/zconf.y	2005-10-20 12:41:43.000000000 +1000
> @@ -495,10 +495,9 @@
>  		exit(1);
>  	menu_finalize(&rootmenu);
>  	for_all_symbols(i, sym) {
> +/* 		fprintf(stderr, "Checking %s...\n", sym->name); */

One "quilt refresh" missing? :-)

bye, Roman
