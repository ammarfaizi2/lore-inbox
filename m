Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268382AbUIDAv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268382AbUIDAv0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 20:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269938AbUIDAtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 20:49:36 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:50355 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S268382AbUIDArp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 20:47:45 -0400
Date: Sat, 4 Sep 2004 02:47:29 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: yuvalt@gmail.com
cc: sam@ravnborg.org, rddunlap@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Menuconfig search changes - pt. 3
In-Reply-To: <20040903190023.GA8898@aduva.com>
Message-ID: <Pine.LNX.4.61.0409040152160.877@scrub.home>
References: <20040903190023.GA8898@aduva.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 3 Sep 2004, Yuval Turgeman wrote:

> (Once again, this patch should be applied after Andrew's changes)

Please send a complete patch, it makes commenting on it easier.

> +	if (regcomp(&re, pattern, REG_EXTENDED|REG_NOSUB))
> +		return 0;
> +	rc = regexec(&re, string, (size_t) 0, NULL, 0);
> +	regfree(&re);

You shouldn't compute the pattern at every search.

> +static void show_expr(struct menu *menu, FILE *fp)
> +{
> +	bool hit = false;
> +	fprintf(fp, "Depends:\n ");
> +	if (menu->dep) {
> +		if (!hit)
> +			hit = true;
> +		expr_fprint(menu->dep, fp);
> +	}

menu->dep contains only temporary information. The real information is in 
prop->visible.expr.

> +	if (menu->sym && menu->sym->dep) {
> +		if (!hit)
> +			hit = true;
> +		expr_fprint(menu->sym->dep, fp);
>  	}

sym->dep doesn't contain user relevant information.

> +	if (menu->sym) {
> +		struct property *prop;
> +		hit = false;
> +		fprintf(fp, "\nSelects:\n ");
> +		for_all_properties(menu->sym, prop, P_SELECT) {
> +			if (!hit)
> +				hit = true;
> +			expr_fprint(prop->expr, fp);
> +		}

With this you print all selection with every menu entry.
You probably also want to print sym->rev_dep, which is used to calculate 
the selections for this symbol.

>  			while (submenu) {
>  				menu[j++] = submenu;
>  				submenu = submenu->parent;
>  			}

This loop should stop when you find root_menu.

>  			if (j > 0) {
> +				if (!hit)
> +					hit = true;
> +				if (prop->text)
> +					fprintf(fp, "%s (%s)\n", prop->text, 
> +								sym->name);
>  				else
>  					fprintf(fp, "%s\n", sym->name);

This test isn't necessary, every prompt has a text.

> +			space = (char*)malloc(sizeof(char)*j);

This isn't necessary, just use "%*c" like the other indentations.

bye, Roman
