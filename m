Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133071AbRDLURO>; Thu, 12 Apr 2001 16:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133099AbRDLURE>; Thu, 12 Apr 2001 16:17:04 -0400
Received: from ns.caldera.de ([212.34.180.1]:19731 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S133071AbRDLUQ6>;
	Thu, 12 Apr 2001 16:16:58 -0400
Date: Thu, 12 Apr 2001 22:16:38 +0200
From: Christoph Hellwig <hch@caldera.de>
To: Wayne.Brown@altec.com
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: badly punctuated parameter list in `#define' (2.4.3-ac5 and 2 .4.4 -pre2)
Message-ID: <20010412221638.A5914@caldera.de>
Mail-Followup-To: Wayne.Brown@altec.com, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
In-Reply-To: <86256A2C.006EA2DE.00@smtpnotes.altec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <86256A2C.006EA2DE.00@smtpnotes.altec.com>; from Wayne.Brown@altec.com on Thu, Apr 12, 2001 at 03:08:28PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2001 at 03:08:28PM -0500, Wayne.Brown@altec.com wrote:
> >old compiler.  The right ifdef seems to be:
> 
> >
> >  #if __GNUC__ == 2 && __GNUC_MINOR__ < 95
> >
> >Could you test it this way?
> 
> Yes, that works for me.  Is this the sort of thing you had in mind?

Yes.
Linus any chance to apply the following patch?

	Christoph

> 
> Wayne
> 
> 
> --- include/asm-i386/rwsem.h.old   Thu Apr 12 14:50:08 2001
> +++ include/asm-i386/rwsem.h  Thu Apr 12 14:54:14 2001
> @@ -20,18 +20,24 @@
>  #include <linux/spinlock.h>
>  #include <linux/wait.h>
> 
> +#if __GNUC__ == 2 && __GNUC_MINOR__ < 95
> +
> +/* old gcc */
>  #if RWSEM_DEBUG
> -#define rwsemdebug(FMT,...) do { if (sem->debug) printk(FMT,__VA_ARGS__); }
> while(0)
> +#define rwsemdebug(FMT, ARGS...) do { if (sem->debug) printk(FMT,##ARGS); }
> while(0)
>  #else
> -#define rwsemdebug(FMT,...)
> +#define rwsemdebug(FMT, ARGS...)
>  #endif
> 
> -/* old gcc */
> +#else
> +
>  #if RWSEM_DEBUG
> -//#define rwsemdebug(FMT, ARGS...) do { if (sem->debug) printk(FMT,##ARGS); }
> while(0)
> +#define rwsemdebug(FMT,...) do { if (sem->debug) printk(FMT,__VA_ARGS__); }
> while(0)
>  #else
> -//#define rwsemdebug(FMT, ARGS...)
> +#define rwsemdebug(FMT,...)
>  #endif
> +
> +#endif /* __GNUC__ == 2 && __GNUC_MINOR__ < 95 */
> 
>  #ifdef CONFIG_X86_XADD
>  #include <asm/rwsem-xadd.h> /* use XADD based semaphores if possible */
> 
---end quoted text---

-- 
Of course it doesn't work. We've performed a software upgrade.
