Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUHYWRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUHYWRf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 18:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266508AbUHYWRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 18:17:18 -0400
Received: from waste.org ([209.173.204.2]:64443 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S268824AbUHYVM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 17:12:57 -0400
Date: Wed, 25 Aug 2004 16:12:48 -0500
From: Matt Mackall <mpm@selenic.com>
To: Paulo Marques <pmarques@grupopie.com>
Cc: linux-kernel@vger.kernel.org, bcasavan@sgi.com
Subject: Re: [PATCH] kallsyms data size reduction / lookup speedup
Message-ID: <20040825211248.GQ31237@waste.org>
References: <1093406686.412c0fde79d4f@webmail.grupopie.com> <20040825173941.GJ5414@waste.org> <412CDE9D.3090609@grupopie.com> <20040825185854.GP31237@waste.org> <412CE3ED.5000803@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412CE3ED.5000803@grupopie.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 08:09:33PM +0100, Paulo Marques wrote:
> 
> diff -uprN -X dontdiff linux-2.6.9-rc1/kernel/kallsyms.c 
> linux-2.6.9-rc1-kall/kernel/kallsyms.c
> --- linux-2.6.9-rc1/kernel/kallsyms.c	2004-08-24 23:16:39.000000000 +0100
> +++ linux-2.6.9-rc1-kall/kernel/kallsyms.c	2004-08-25 
> 03:59:27.000000000 +0100
> @@ -5,6 +5,12 @@
>   * module loader:
>   *   Copyright 2002 Rusty Russell <rusty@rustcorp.com.au> IBM Corporation
>   * Stem compression by Andi Kleen.

Might as well kill this dangling reference to stem compression.

> 
> +static unsigned int kallsyms_expand_symbol(unsigned int off, char *result)
> +{
> +	int len, tlen;
> +	u8 *tptr, *data;
> +
> +	data = &kallsyms_names[off];
> +	
> +	len=*data++;
> +	off += len + 1;
> +	while(len) {
> +		tptr=&kallsyms_token_table[kallsyms_token_index[*data]];
> +		data++;
> +		len--;
> +
> +		tlen=*tptr++;
> +		while(tlen) {
> +			*result++=*tptr++;

Whitespace, please. Vertical and horizontal. Also, this style with
pointer manipulation tends to be frowned on - it's compact but
needlessly obscure. Using a couple index variables and for loops would
make this quite a bit more readable.

> +static unsigned int get_symbol_offset(unsigned long pos)
> +{
> +	u8 *name;
> +	int i;
> +
> +	name = &kallsyms_names[ kallsyms_markers[pos>>8] ];
> +	for(i = 0; i < (pos&0xFF); i++)
> +		name = name + (*name) + 1;

That's a bit magic looking. A brief description of the data structure in this
vicinity would be appreciated. 

> --- linux-2.6.9-rc1/scripts/kallsyms.c	2004-08-24 23:16:39.000000000 +0100
> +++ linux-2.6.9-rc1-kall/scripts/kallsyms.c	2004-08-25 
> 03:30:30.000000000 +0100
> @@ -6,6 +6,13 @@
>   * of the GNU General Public License, incorporated herein by reference.
>   *
>   * Usage: nm -n vmlinux | scripts/kallsyms [--all-symbols] > symbols.S
> + *
> + * ChangeLog:
> + *
> + * (25/Aug/2004) Paulo Marques
> + *      Changed the compression method from stem compression to "table 
> lookup"
> + *      compression
> + *
>   */

Throw an address in there so we know where to direct complaints. Also
a description of "table compression" belongs here.

Generally looks decent, could use a bit more in the way of comments.

-- 
Mathematics is the supreme nostalgia of our time.
