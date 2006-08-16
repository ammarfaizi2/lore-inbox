Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWHPQYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWHPQYW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWHPQYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:24:22 -0400
Received: from hera.kernel.org ([140.211.167.34]:53125 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751138AbWHPQYV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:24:21 -0400
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Andi Kleen <ak@suse.de>, Rusty Russell <rusty@rustcorp.com.au>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH for review] [89/145] x86_64: Allow early_param and identical __setup to exist
Date: Wed, 16 Aug 2006 12:25:51 -0400
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20060810 935.775038000@suse.de> <20060810193646.7174C13C0B@wotan.suse.de>
In-Reply-To: <20060810193646.7174C13C0B@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608161225.51413.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 August 2006 15:36, Andi Kleen wrote:
> 
> From: Rusty Russell <rusty@rustcorp.com.au>
> We currently assume that boot parameters which are handled by
> early_param() will not overlap boot parameters handled by __setup: if
> they do, behaviour is dependent on link order, usually meaning __setup
> will not get called.
> 
> ACPI wants to use early_param("pci"), and pci uses __setup("pci="), so
> we modify the core to let them coexist: "pci=noacpi" will now get
> passed to both.

For what it is worth....
"pci=noacpi" is the same as "acpi=noirq", except in addition it also sets acpi_pci_disabled.

For some time, it seems that "acpi=noirq" has been sufficient where "pci=noacpi" was being used.
Thopugh we used to have some BIOS quirks that would fool ACPI root bus initialization,
I think that we are probably past those.

So I'll venture that today any uses of "pci=noacpi" could likely be down-graded
to "acpi=noirq", and "pci=noacpi" could be deleted --- though it seems that people
tend to get very upset when cmdline options are removed...

thanks,
-Len



> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> Signed-off-by: Andi Kleen <ak@suse.de>
> 
> ---
>  init/main.c |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)
> 
> Index: linux/init/main.c
> ===================================================================
> --- linux.orig/init/main.c
> +++ linux/init/main.c
> @@ -162,16 +162,19 @@ extern struct obs_kernel_param __setup_s
>  static int __init obsolete_checksetup(char *line)
>  {
>  	struct obs_kernel_param *p;
> +	int had_early_param = 0;
>  
>  	p = __setup_start;
>  	do {
>  		int n = strlen(p->str);
>  		if (!strncmp(line, p->str, n)) {
>  			if (p->early) {
> -				/* Already done in parse_early_param?  (Needs
> -				 * exact match on param part) */
> +				/* Already done in parse_early_param?
> +				 * (Needs exact match on param part).
> +				 * Keep iterating, as we can have early
> +				 * params and __setups of same names 8( */
>  				if (line[n] == '\0' || line[n] == '=')
> -					return 1;
> +					had_early_param = 1;
>  			} else if (!p->setup_func) {
>  				printk(KERN_WARNING "Parameter %s is obsolete,"
>  				       " ignored\n", p->str);
> @@ -181,7 +184,8 @@ static int __init obsolete_checksetup(ch
>  		}
>  		p++;
>  	} while (p < __setup_end);
> -	return 0;
> +
> +	return had_early_param;
>  }
>  
>  /*
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
