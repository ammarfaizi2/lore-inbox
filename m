Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268677AbUHLTkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268677AbUHLTkD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 15:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268675AbUHLTkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 15:40:03 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:36085 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268677AbUHLTj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 15:39:58 -0400
Subject: Re: module.viomap support for ppc64
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Olaf Hering <olh@suse.de>
Cc: Dave Boutcher <boutcher@us.ibm.com>, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <20040812173751.GA30564@suse.de>
References: <20040812173751.GA30564@suse.de>
Content-Type: text/plain
Message-Id: <1092339278.19137.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 12 Aug 2004 14:34:38 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-12 at 12:37, Olaf Hering wrote:
> Current MODULE_DEVICE_TABLE(vio, $table); defines 2 char pointers. I'm
> not sure if depmod can really handle it. Where do they point to in the
> module binary? I could find an answer, so far. I just declared an array.

Olaf explained on irc that output_vio_entry() below was finding NULL for
the name and compat pointers. Perhaps some additional relocation needs
to take place before those can be used?

> diff -p -purN module-init-tools-3.0-pre10.orig/moduleops_core.c module-init-tools-3.0-pre10/moduleops_core.c
> --- module-init-tools-3.0-pre10.orig/moduleops_core.c	2003-12-24 06:17:07.000000000 +0100
> +++ module-init-tools-3.0-pre10/moduleops_core.c	2004-08-12 15:21:44.000000000 +0200
> @@ -176,6 +176,10 @@ static void PERBIT(fetch_tables)(struct
>  	module->ccw_table = PERBIT(deref_sym)(module->data,
>  					"__mod_ccw_device_table");
> 
> +	module->vio_size = PERBIT(VIO_DEVICE_SIZE);
> +	module->vio_table = PERBIT(deref_sym)(module->data,
> +					"__mod_vio_device_table");
> +
>  	module->ieee1394_size = PERBIT(IEEE1394_DEVICE_SIZE);
>  	module->ieee1394_table = PERBIT(deref_sym)(module->data,
>  					"__mod_ieee1394_device_table");
> diff -p -purN module-init-tools-3.0-pre10.orig/tables.c module-init-tools-3.0-pre10/tables.c
> --- module-init-tools-3.0-pre10.orig/tables.c	2003-12-24 06:23:38.000000000 +0100
> +++ module-init-tools-3.0-pre10/tables.c	2004-08-12 19:19:01.708780583 +0200
> @@ -127,7 +127,31 @@ void output_ieee1394_table(struct module
>  			output_ieee1394_entry(fw, shortname, out);
>  	}
>  }
> +static void output_vio_entry(struct vio_device_id *fw, char *name, FILE *out)
> +{
> +	fprintf(out, "%-20s %-32s %s\n",
> +		name, fw->name, fw->compat);
> +}
> 
> +void output_vio_table(struct module *modules, FILE *out)
> +{
> +	struct module *i;
> +
> +	fprintf(out, "%-20s %-32s compatible\n", "# vio module", "name");
> +
> +	for (i = modules; i; i = i->next) {
> +		struct vio_device_id *fw;
> +		char shortname[strlen(i->pathname) + 1];
> +
> +		if (!i->vio_table)
> +			continue;
> +
> +		make_shortname(shortname, i->pathname);
> +		for (fw = i->vio_table; *fw->name;
> +		     fw = (void *) fw + i->vio_size)
> +			output_vio_entry(fw, shortname, out);
> +	}
> +}
> 
>  /* We set driver_data to zero */
>  static void output_ccw_entry(struct ccw_device_id *ccw, char *name, FILE *out)

-- 
Hollis Blanchard
IBM Linux Technology Center

