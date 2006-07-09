Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030481AbWGIMtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030481AbWGIMtm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 08:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030482AbWGIMtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 08:49:42 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:56030 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030481AbWGIMtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 08:49:40 -0400
Date: Sun, 9 Jul 2006 14:49:27 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modpost error about size inconsitency
Message-ID: <20060709124927.GA25899@mars.ravnborg.org>
References: <20060709021106.9310d4d1.akpm@osdl.org> <20060709124640.GA23306@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060709124640.GA23306@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 02:46:40PM +0200, Sam Ravnborg wrote:

Patch below is on top of -rc1 - not -mm by the way. So you will see some
minor conflicts with the eisa stuff.

	Sam

> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index 37f67c2..c522f16 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -52,6 +52,23 @@ do {                                    
>                  sprintf(str + strlen(str), "*");                \
>  } while(0)
>  
> +/**
> + * Check that sizeof(device_id type) are consistent with size of section
> + * in .o file. If in-consistent then userspace and kernel does not agree
> + * on actual size which is a bug.
> + **/
> +static void device_id_size_check(const char *modname, const char *device_id,
> +				 unsigned long size, unsigned long id_size)
> +{
> +	if (size % id_size || size < id_size) {
> +		fatal("%s: sizeof(struct %s_device_id)=%lu is not a modulo "
> +		      "of the size of section __mod_%s_device_table=%lu.\n"
> +		      "Fix definition of struct %s_device_id "
> +		      "in mod_devicetable.h\n",
> +		      modname, device_id, id_size, device_id, size, device_id);
> +	}
> +}
> +
>  /* USB is special because the bcdDevice can be matched against a numeric range */
>  /* Looks like "usb:vNpNdNdcNdscNdpNicNiscNipN" */
>  static void do_usb_entry(struct usb_device_id *id,
> @@ -152,10 +169,8 @@ static void do_usb_table(void *symval, u
>  	unsigned int i;
>  	const unsigned long id_size = sizeof(struct usb_device_id);
>  
> -	if (size % id_size || size < id_size) {
> -		warn("%s ids %lu bad size "
> -		     "(each on %lu)\n", mod->name, size, id_size);
> -	}
> +	device_id_size_check(mod->name, "usb", size, id_size);
> +
>  	/* Leave last one: it's the terminator. */
>  	size -= id_size;
>  
> @@ -434,6 +449,7 @@ static inline int sym_is(const char *sym
>  
>  static void do_table(void *symval, unsigned long size,
>  		     unsigned long id_size,
> +		     const char *device_id,
>  		     void *function,
>  		     struct module *mod)
>  {
> @@ -441,10 +457,7 @@ static void do_table(void *symval, unsig
>  	char alias[500];
>  	int (*do_entry)(const char *, void *entry, char *alias) = function;
>  
> -	if (size % id_size || size < id_size) {
> -		warn("%s ids %lu bad size "
> -		     "(each on %lu)\n", mod->name, size, id_size);
> -	}
> +	device_id_size_check(mod->name, device_id, size, id_size);
>  	/* Leave last one: it's the terminator. */
>  	size -= id_size;
>  
> @@ -476,40 +489,51 @@ void handle_moddevtable(struct module *m
>  		+ sym->st_value;
>  
>  	if (sym_is(symname, "__mod_pci_device_table"))
> -		do_table(symval, sym->st_size, sizeof(struct pci_device_id),
> +		do_table(symval, sym->st_size,
> +			 sizeof(struct pci_device_id), "pci",
>  			 do_pci_entry, mod);
>  	else if (sym_is(symname, "__mod_usb_device_table"))
>  		/* special case to handle bcdDevice ranges */
>  		do_usb_table(symval, sym->st_size, mod);
>  	else if (sym_is(symname, "__mod_ieee1394_device_table"))
> -		do_table(symval, sym->st_size, sizeof(struct ieee1394_device_id),
> +		do_table(symval, sym->st_size,
> +			 sizeof(struct ieee1394_device_id), "ieee1394",
>  			 do_ieee1394_entry, mod);
>  	else if (sym_is(symname, "__mod_ccw_device_table"))
> -		do_table(symval, sym->st_size, sizeof(struct ccw_device_id),
> +		do_table(symval, sym->st_size,
> +			 sizeof(struct ccw_device_id), "ccw",
>  			 do_ccw_entry, mod);
>  	else if (sym_is(symname, "__mod_serio_device_table"))
> -		do_table(symval, sym->st_size, sizeof(struct serio_device_id),
> +		do_table(symval, sym->st_size,
> +			 sizeof(struct serio_device_id), "serio",
>  			 do_serio_entry, mod);
>  	else if (sym_is(symname, "__mod_pnp_device_table"))
> -		do_table(symval, sym->st_size, sizeof(struct pnp_device_id),
> +		do_table(symval, sym->st_size,
> +			 sizeof(struct pnp_device_id), "pnp",
>  			 do_pnp_entry, mod);
>  	else if (sym_is(symname, "__mod_pnp_card_device_table"))
> -		do_table(symval, sym->st_size, sizeof(struct pnp_card_device_id),
> +		do_table(symval, sym->st_size,
> +			 sizeof(struct pnp_card_device_id), "pnp_card",
>  			 do_pnp_card_entry, mod);
>  	else if (sym_is(symname, "__mod_pcmcia_device_table"))
> -		do_table(symval, sym->st_size, sizeof(struct pcmcia_device_id),
> +		do_table(symval, sym->st_size,
> +			 sizeof(struct pcmcia_device_id), "pcmia",
>  			 do_pcmcia_entry, mod);
>          else if (sym_is(symname, "__mod_of_device_table"))
> -		do_table(symval, sym->st_size, sizeof(struct of_device_id),
> +		do_table(symval, sym->st_size,
> +			 sizeof(struct of_device_id), "of",
>  			 do_of_entry, mod);
>          else if (sym_is(symname, "__mod_vio_device_table"))
> -		do_table(symval, sym->st_size, sizeof(struct vio_device_id),
> +		do_table(symval, sym->st_size,
> +			 sizeof(struct vio_device_id), "vio",
>  			 do_vio_entry, mod);
>  	else if (sym_is(symname, "__mod_i2c_device_table"))
> -		do_table(symval, sym->st_size, sizeof(struct i2c_device_id),
> +		do_table(symval, sym->st_size,
> +			 sizeof(struct i2c_device_id), "i2c",
>  			 do_i2c_entry, mod);
>  	else if (sym_is(symname, "__mod_input_device_table"))
> -		do_table(symval, sym->st_size, sizeof(struct input_device_id),
> +		do_table(symval, sym->st_size,
> +			 sizeof(struct input_device_id), "input",
>  			 do_input_entry, mod);
>  }
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
