Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWFBORN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWFBORN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 10:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWFBORN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 10:17:13 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:28379 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932130AbWFBORN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 10:17:13 -0400
Date: Fri, 2 Jun 2006 16:17:02 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Nick Warne <nick@linicks.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.16.18 scripts/kconfig/mconf.c
In-Reply-To: <200606010628.08966.nick@linicks.net>
Message-ID: <Pine.LNX.4.64.0606021608110.17704@scrub.home>
References: <200606010628.08966.nick@linicks.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 1 Jun 2006, Nick Warne wrote:

> 
> --- linux-current/scripts/kconfig/mconf.cORIG	2006-05-30 18:58:59.000000000 
> +0100
> +++ linux-current/scripts/kconfig/mconf.c	2006-05-30 19:10:29.000000000 +0100
> @@ -402,6 +402,9 @@
>  	bool hit;
>  	struct property *prop;
>  
> +	if (!sym->name)
> +		return;
> +
>  	str_printf(r, "Symbol: %s [=%s]\n", sym->name,
>  	                               sym_get_string_value(sym));
>  	for_all_prompts(sym, prop)

Only choice symbols currently have no name, but there are otherwise normal 
symbols, so there is need to just return here. This should look more like:

	if (sym->name)
		str_printf(r, "Symbol: %s", sym->name);
	else if (sym_is_choice(sym))
		str_printf(r, "Choice:");
	else
		str_printf(r, "Weird symbol:");
	str_printf(r, "[=%s]\n", sym_get_string_value(sym));


> @@ -853,15 +856,17 @@
>  	{
>  		if (sym->name) {
>  			str_printf(&help, "CONFIG_%s:\n\n", sym->name);
> -			str_append(&help, _(sym->help));
> -			str_append(&help, "\n");
>  		}
> -	} else {
> -		str_append(&help, nohelp_text);
> -	}
> +	str_append(&help, _(sym->help));
> +	str_append(&help, "\n");
>  	get_symbol_str(&help, sym);
>  	show_helptext(menu_get_prompt(menu), str_get(&help));
>  	str_free(&help);
> +	} else {
> +		str_append(&help, nohelp_text);
> +		show_helptext(menu_get_prompt(menu), str_get(&help));
> +		str_free(&help);
> +	}
>  }

That looks a little misformated, anyway, this should just be:

	if (sym->name)
		str_printf(&help, "CONFIG_%s:\n\n", sym->name);

	str_append(&help, sym->help ? _(sym->help) : nohelp_text);
	str_append(&help, "\n");
	get_symbol_str(&help, sym);
	show_helptext(menu_get_prompt(menu), str_get(&help));
	str_free(&help);

bye, Roman
