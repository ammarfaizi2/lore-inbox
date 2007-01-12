Return-Path: <linux-kernel-owner+w=401wt.eu-S1751272AbXALQjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbXALQjE (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 11:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbXALQjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 11:39:04 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2828 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbXALQjC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 11:39:02 -0500
Date: Fri, 12 Jan 2007 16:38:52 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, rusty@rustcorp.com.au
Subject: Re: [patch 2.6.20-rc4-git] remove modpost false warnings on ARM
Message-ID: <20070112163852.GA16511@flint.arm.linux.org.uk>
Mail-Followup-To: David Brownell <david-b@pacbell.net>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	rusty@rustcorp.com.au
References: <200701120831.37513.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701120831.37513.david-b@pacbell.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2007 at 08:31:36AM -0800, David Brownell wrote:
> Index: at91/scripts/mod/modpost.c
> ===================================================================
> --- at91.orig/scripts/mod/modpost.c	2007-01-11 22:51:49.000000000 -0800
> +++ at91/scripts/mod/modpost.c	2007-01-12 04:20:00.000000000 -0800
> @@ -679,6 +679,26 @@ static Elf_Sym *find_elf_symbol(struct e
>  }
>  
>  /*
> + * If there's no name there, ignore it; likewise, ignore it if it's
> + * one of the magic symbols emitted used by current ARM tools.
> + *
> + * Otherwise if find_symbols_between() returns those symbols, they'll
> + * fail the whitelist tests and cause lots of false alarms ... fixable
> + * only by shrinking __exit and __init sections into __text, bloating
> + * the kernel (which is especially evil on embedded platforms).
> + */
> +static int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
> +{
> +	const char *name = elf->strtab + sym->st_name;
> +
> +	if (!name || !strlen(name))
> +		return 0;
> +	if (strcmp(name, "$a") == 0 || strcmp(name, "$d") == 0)
> +		return 0;

A more correct test would be that found in kallsyms.c:

/*
 * This ignores the intensely annoying "mapping symbols" found
 * in ARM ELF files: $a, $t and $d.
 */
static inline int is_arm_mapping_symbol(const char *str)
{
        return str[0] == '$' && strchr("atd", str[1])
               && (str[2] == '\0' || str[2] == '.');
}

Suggest that code is re-used here (as well as in other tools such as
oprofile, readprofile, etc.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
