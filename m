Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbULHN6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbULHN6f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 08:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbULHN6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 08:58:35 -0500
Received: from [213.146.154.40] ([213.146.154.40]:19607 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261219AbULHN5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 08:57:37 -0500
Date: Wed, 8 Dec 2004 13:57:37 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Patrick van de Lageweg <patrick@bitwizard.nl>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>, Eric Wood <eric@interplas.com>,
       bmckinlay@perle.com, tmckinlay@perle.com
Subject: Re: [PATCH] RIO
Message-ID: <20041208135737.GB31975@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patrick van de Lageweg <patrick@bitwizard.nl>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Rogier Wolff <R.E.Wolff@BitWizard.nl>,
	Eric Wood <eric@interplas.com>, bmckinlay@perle.com,
	tmckinlay@perle.com
References: <20041208132951.GC19937@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041208132951.GC19937@bitwizard.nl>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 02:29:51PM +0100, Patrick van de Lageweg wrote:
> Hi,
> 
> This patch converts all save_flags/restore_flags to the new 
> spin_lick_irqsave/spin_unlock_irqrestore calls, as well as some
> other 2.6.X cleanups. This allows the "rio" driver to become
> SMP safe.
> 
> 
> Signed-off-by: Patrick vd Lageweg <patrick@bitwizard.nl>
> Signed-off-by: Rogier Wolff <R.E.Wolff@BitWizard.nl>
> 
>         Patrick

> diff -u -r linux-2.6.10-rc3-clean/drivers/char/Kconfig linux-2.6.10-rc3-rio/drivers/char/Kconfig
> --- linux-2.6.10-rc3-clean/drivers/char/Kconfig	Fri Dec  3 15:13:32 2004
> +++ linux-2.6.10-rc3-rio/drivers/char/Kconfig	Fri Dec  3 15:28:48 2004
> @@ -299,7 +299,7 @@
>  
>  config RIO
>  	tristate "Specialix RIO system support"
> -	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
> +	depends on SERIAL_NONSTANDARD
>  	help
>  	  This is a driver for the Specialix RIO, a smart serial card which
>  	  drives an outboard box that can support up to 128 ports.  Product
> diff -u -r linux-2.6.10-rc3-clean/drivers/char/rio/linux_compat.h linux-2.6.10-rc3-rio/drivers/char/rio/linux_compat.h
> --- linux-2.6.10-rc3-clean/drivers/char/rio/linux_compat.h	Fri Dec  3 15:11:52 2004
> +++ linux-2.6.10-rc3-rio/drivers/char/rio/linux_compat.h	Fri Dec  3 15:28:48 2004
> @@ -19,8 +19,8 @@
>  #include <linux/interrupt.h>
>  
>  
> -#define disable(oldspl) save_flags (oldspl)
> -#define restore(oldspl) restore_flags (oldspl)
> +#define disable(oldspl) local_irq_save(oldspl);
> +#define restore(oldspl) local_irq_restore(oldspl) ;

This looks broken.  local_irq_* really isn't for driver use except for
exception case.  Also please kill such silly wrappers..

>  
>  #define sysbrk(x) kmalloc ((x),in_interrupt()? GFP_ATOMIC : GFP_KERNEL)
>  #define sysfree(p,size) kfree ((p))

dito here.  Also the in_interrupt() check is wrong.


Looking at the driver with it's deep mess and K&R prototypes you might
be better off with a start from scratch.

