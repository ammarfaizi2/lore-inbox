Return-Path: <linux-kernel-owner+w=401wt.eu-S1751108AbXAPMs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbXAPMs2 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 07:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbXAPMs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 07:48:28 -0500
Received: from aun.it.uu.se ([130.238.12.36]:60774 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751108AbXAPMs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 07:48:27 -0500
Date: Tue, 16 Jan 2007 13:48:16 +0100 (MET)
Message-Id: <200701161248.l0GCmG7O025771@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: giuliano.procida@googlemail.com, rgooch@atnf.csiro.au
Subject: Re: [PATCH]: MTRR: fix 32-bit ioctls on x64_32
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2007 08:14:30 +0000, Giuliano Procida wrote:
> [MTRR] fix 32-bit ioctls on x64_32
> 
> Signed-off-by: Giuliano Procida <giuliano.procida@googlemail.com>
> 
> ---
> 
> Fixed incomplete support for 32-bit compatibility ioctls in
> 2.6.19.1. They were unhandled in one of three case-statements.
> Testing using X server before and after change.
> 
> --- linux-source-2.6.19.1.orig/arch/i386/kernel/cpu/mtrr/if.c	2006-12-11 19:32:53.000000000 +0000
> +++ linux-source-2.6.19.1/arch/i386/kernel/cpu/mtrr/if.c	2007-01-16 07:31:06.000000000 +0000
> @@ -211,6 +211,9 @@ mtrr_ioctl(struct file *file, unsigned i
>  	default:
>  		return -ENOTTY;
>  	case MTRRIOC_ADD_ENTRY:
> +#ifdef CONFIG_COMPAT
> +	case MTRRIOC32_ADD_ENTRY:
> +#endif
>  		if (!capable(CAP_SYS_ADMIN))
>  			return -EPERM;
>  		err =
> @@ -218,21 +221,33 @@ mtrr_ioctl(struct file *file, unsigned i
>  				  file, 0);
>  		break;
>  	case MTRRIOC_SET_ENTRY:
> +#ifdef CONFIG_COMPAT
> +	case MTRRIOC32_SET_ENTRY:
> +#endif

etc

These #ifdefs are too ugly.

Since you apparently just add aliases for the case labels,
and do no actual code changes, why not
1. make the new cases unconditional, or 
2. invoke a translation function before the switch which
   maps the MTRRCIOC32_ constants to what the kernel uses

/Mikael
