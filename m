Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbTELLRl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 07:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbTELLRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 07:17:41 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:24080 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261805AbTELLRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 07:17:36 -0400
Date: Mon, 12 May 2003 13:30:17 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Pavel Machek <pavel@suse.cz>, Linus Torvalds <torvalds@transmeta.com>,
       mikpe@csd.uu.se,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] restore sysenter MSRs at resume
Message-ID: <20030512113017.GA25757@atrey.karlin.mff.cuni.cz>
References: <200305101641.h4AGfEVE002970@harpo.it.uu.se> <Pine.LNX.4.44.0305111158500.12955-100000@home.transmeta.com> <20030511190822.GA1181@atrey.karlin.mff.cuni.cz> <1052681292.1869.5.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052681292.1869.5.camel@laptop-linux>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Ok. I haven't updated it for 2.5.69 version, but it doesn't look like
> any changes are required. Here is the relevant part of the full swsusp
> patch.

I guess it still needs to be updated for the driver model....


> Regards,
> 
> Nigel
> 
> On Mon, 2003-05-12 at 07:08, Pavel Machek wrote:
> > Hi!
> > 
> > Nigel, perhaps this is the right time for retransmitting the mtrr
> > patch?
> > 
> > 					Pavel
> > > 
> > > On Sat, 10 May 2003 mikpe@csd.uu.se wrote:
> > > > 
> > > > This patch should be better. It changes apm.c to invoke
> > > > suspend.c's save and restore processor state procedures
> > > > around suspends, which fixes the SYSENTER MSR problem.
> > > 
> > > Applied.
> > > 
> > > However, the fact that the SYSENTER MSR needs to be restored makes me
> > > suspect that the other MSR/MTRR also will need restoring. I don't see 
> > > where we'd be doing that, but it sounds to me like it should be done here 
> > > too..
> > > 
> > > 		Linus
> 
> diff -ruN linux-2.5.68/arch/i386/kernel/cpu/mtrr/main.c linux-2.5.68-swsusp1925/arch/i386/kernel/cpu/mtrr/main.c
> --- linux-2.5.68/arch/i386/kernel/cpu/mtrr/main.c	2003-01-15 17:00:38.000000000 +1300
> +++ linux-2.5.68-swsusp1925/arch/i386/kernel/cpu/mtrr/main.c	2003-04-25 14:13:05.000000000 +1200
> @@ -35,6 +35,7 @@
>  #include <linux/init.h>
>  #include <linux/pci.h>
>  #include <linux/smp.h>
> +#include <linux/suspend.h>
>  
>  #include <asm/mtrr.h>
>  
> @@ -644,6 +645,65 @@
>      "write-protect",            /* 5 */
>      "write-back",               /* 6 */
>  };
> -
> + 
> +#ifdef SOFTWARE_SUSPEND_MTRR
> +struct mtrr_suspend_state
> +{
> +     mtrr_type ltype;
> +     unsigned long lbase;
> +     unsigned int lsize;
> +};
> +/* We return a pointer ptr on an area of *ptr bytes
> +   beginning at ptr+sizeof(int)
> +   This buffer has to be saved in some way during suspension */
> +int *mtrr_suspend(void)
> +{
> +     int i, len;
> +     int *ptr = NULL;
> +     static struct mtrr_suspend_state *mtrr_suspend_buffer=NULL;
> +     
> +     if(!mtrr_suspend_buffer)
> +     {
> +	  len = num_var_ranges * sizeof (struct mtrr_suspend_state) + sizeof(int);
> +	  ptr = kmalloc (len, GFP_KERNEL);
> +	  if (ptr == NULL)
> +	       return(NULL);
> +	  *ptr = len;
> +	  ptr++;
> +	  mtrr_suspend_buffer = (struct mtrr_suspend_state *)ptr;
> +	  ptr--;
> +     }
> +     for (i = 0; i < num_var_ranges; ++i,mtrr_suspend_buffer++)
> +	  mtrr_if->get (i,
> +		       &(mtrr_suspend_buffer->lbase),
> +		       &(mtrr_suspend_buffer->lsize),
> +		       &(mtrr_suspend_buffer->ltype));
> +     return(ptr);
> +}
> +
> +/* We restore mtrrs from buffer ptr */
> +void mtrr_resume(int *ptr)
> +{
> +     int i, len;
> +     struct mtrr_suspend_state *mtrr_suspend_buffer;
> +     
> +     len = num_var_ranges * sizeof (struct mtrr_suspend_state) + sizeof(int);
> +     if(*ptr != len)
> +     {
> +	  printk ("mtrr: Resuming failed due to different number of MTRRs\n");
> +	  return;
> +     }
> +     ptr++;
> +     mtrr_suspend_buffer=(struct mtrr_suspend_state *)ptr;
> +     for (i = 0; i < num_var_ranges; ++i,mtrr_suspend_buffer++)     
> +	  if (mtrr_suspend_buffer->lsize)	  
> +	       set_mtrr(i,
> +			mtrr_suspend_buffer->lbase,
> +			mtrr_suspend_buffer->lsize,
> +			mtrr_suspend_buffer->ltype);
> +}
> +EXPORT_SYMBOL(mtrr_suspend);
> +EXPORT_SYMBOL(mtrr_resume);
> +#endif
>  core_initcall(mtrr_init);
>  
> 
> 

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
