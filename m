Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269634AbUINSGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269634AbUINSGI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269653AbUINSCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:02:31 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:48773 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S269598AbUINRxs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 13:53:48 -0400
Date: Tue, 14 Sep 2004 19:53:26 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: yuvalt@gmail.com
cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Menuconfig search changes - pt. 3
In-Reply-To: <20040914121401.GA13531@aduva.com>
Message-ID: <Pine.LNX.4.61.0409141613050.877@scrub.home>
References: <20040914121401.GA13531@aduva.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 14 Sep 2004, Yuval Turgeman wrote:

> +static int regex_match(const char *string, regex_t *re)
> +{
> +	int rc;
> +
> +	rc = regexec(re, string, (size_t) 0, NULL, 0);
> +	if (rc)
> +		return 0;
> +	return 1;
> +}

I guess, this doesn't has to be a separate function anymore.

> +static void show_expr(struct menu *menu, FILE *fp)
> +{
> +	bool hit = false;
> +	fprintf(fp, "Depends:\n ");
> +	if (menu->prompt->visible.expr) {
> +		if (!hit)
> +			hit = true;
> +		expr_fprint(menu->prompt->visible.expr, fp);
> +	}
> +	if (!hit)
> +		fprintf(fp, "None");
> +	if (menu->sym) {
> +		struct property *prop;
> +		hit = false;
> +		fprintf(fp, "\nSelects:\n ");
> +		for_all_properties(menu->sym, prop, P_SELECT) {
> +			if (!hit)
> +				hit = true;
> +			expr_fprint(prop->expr, fp);
> +		}
> +		if (!hit)
> +			fprintf(fp, "None");
> +		hit = false;
> +		fprintf(fp, "\nSelected by:\n ");
> +		if (menu->sym->rev_dep.expr) {
> +			hit = true;
> +			expr_fprint(menu->sym->rev_dep.expr, fp);
> +		}
> +		if (!hit)
> +			fprintf(fp, "None");
> +	}
> +}

This still prints duplicate information, look at how 
ConfigMainWindow::setHelp() in qconf.cc does it. Your function should have 
pretty much the same structure, e.g.

> +	for_all_symbols(i, sym) {
> +		if (!sym->name)
> +			continue;
> +		if (!regex_match(sym->name, &re))
> +			continue;
> +		for_all_prompts(sym, prop) {

here you should iterate over all properties and print the info about it.

> +	if (!hit)
> +		fprintf(fp, "No matches found.");

You could print the number of found symbols here.

>  		stat = exec_conf();
> +		if (stat == 26) {

Move this into the switch part a few lines below and simply use the next 
available number. For this you need to print the currently selected 
symbol and the search string from lxdialog, this way you also return to 
the same previously selected symbol after exiting the search.

bye, Roman
