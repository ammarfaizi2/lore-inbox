Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751641AbWFQOfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbWFQOfX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 10:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbWFQOfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 10:35:23 -0400
Received: from witte.sonytel.be ([80.88.33.193]:44736 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1751638AbWFQOfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 10:35:23 -0400
Date: Sat, 17 Jun 2006 16:34:41 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Vivek Goyal <vgoyal@in.ibm.com>
cc: Greg KH <greg@kroah.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH 16/16] 64bit Resource: finally enable 64bit resource
 sizes
In-Reply-To: <20060616201605.GA27462@in.ibm.com>
Message-ID: <Pine.LNX.4.62.0606171633190.24519@pademelon.sonytel.be>
References: <11501587223213-git-send-email-greg@kroah.com>
 <11501587273612-git-send-email-greg@kroah.com> <11501587303683-git-send-email-greg@kroah.com>
 <11501587343689-git-send-email-greg@kroah.com>
 <Pine.LNX.4.62.0606141417430.1886@pademelon.sonytel.be> <20060614233507.GA23629@kroah.com>
 <20060615042806.GC8587@in.ibm.com> <Pine.LNX.4.62.0606151345420.21517@pademelon.sonytel.be>
 <20060615155643.GB8706@in.ibm.com> <20060616013543.GB2566@kroah.com>
 <20060616201605.GA27462@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2006, Vivek Goyal wrote:
> On Thu, Jun 15, 2006 at 06:35:43PM -0700, Greg KH wrote:
> > On Thu, Jun 15, 2006 at 11:56:43AM -0400, Vivek Goyal wrote:
> > > On Thu, Jun 15, 2006 at 01:47:43PM +0200, Geert Uytterhoeven wrote:
> > > > On Thu, 15 Jun 2006, Vivek Goyal wrote:
> > > > > On Wed, Jun 14, 2006 at 04:35:07PM -0700, Greg KH wrote:
> > > > > > On Wed, Jun 14, 2006 at 02:20:06PM +0200, Geert Uytterhoeven wrote:
> > > > > > > On Mon, 12 Jun 2006, Greg KH wrote:
> > > > > > > > From: Greg Kroah-Hartman <gregkh@suse.de>
> > > > > > > > 
> > > > > > > > Introduce the Kconfig entry and actually switch to a 64bit value, if
> > > > > > > > wanted, for resource_size_t.
> > > > > > > 
> > > > > > > > diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> > > > > > > > index 805b81f..22dcaa5 100644
> > > > > > > > --- a/arch/m68k/Kconfig
> > > > > > > > +++ b/arch/m68k/Kconfig
> > > > > > > > @@ -368,6 +368,13 @@ config 060_WRITETHROUGH
> > > > > > > >  
> > > > > > > >  source "mm/Kconfig"
> > > > > > > >  
> > > > > > > > +config RESOURCES_32BIT
> > > > > > > > +	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
> > > > > > > > +	depends on EXPERIMENTAL
> > > > > > > > +	help
> > > > > > > > +	  By default resources are 64 bit. This option allows memory and IO
> > > > > > > > +	  resources to be 32 bit to optimize code size.
> > > > > > > > +
> > > > > > > >  endmenu
> > > > > > > 
> > > > > > > Why is the default 64 bit? Because 32 bit became experimental?
> > > > > > 
> > > > > > That's a really good question.  Vivek, why did you change it to be this
> > > > > > way?  In thinking about it some more, this should be a 64bit option
> > > > > > instead.
> > > > > > 
> > > > > 
> > > > > I thought 64bit is more inclusive. Works both for 32bit and 64bit BARs.
> > > > 
> > > > >From a PCI viewpoint? Not all machines have PCI.
> > > > 
> > > > > Also exports memory more than 4G through /proc/iomem without selecting
> > > > > an additional option in config file. The flip side is that it introduces
> > > > > little memory overhead. I thought most of the users should be ok with this
> > > > > increased memory usage and those who are particular, they can choose
> > > > > RESOURCES_32BIT.
> > > > 
> > > > Not all 32 bit platforms support more than 4 GiB of memory, so it's of no use
> > > > to waste memory on 64 bit resources.
> > > > 
> > > 
> > > Hmm.. That makes sense. I will rework the patch.
> > 
> > Thanks, just rework the last one.
> > 
> > And it looks like you can add just one entry to mm/Kconfig instead of
> > touching every arch's Kconfig file.
> 
> Greg, Please find attached the reworked-patch. I have gotten rid of
> CONFIG_RESOURCES_32BIT and instead introduced CONFIG_RESOURCES_64BIT in 
> arch intenepndent file mm/Kconfig.

Thanks!

> o Introuces CONFIG_RESOURCES_64BIT Kconfig option.
> 
> o This option is available only for 32bit platforms/kernels (!CONFIG_64BIT),
>   as for 64bit kernels, resources have to be 64 bits and they already
>   are.

> diff -puN mm/Kconfig~64bit-resources-modify-kconfig-options mm/Kconfig
> --- linux-2.6.17-rc6-1M/mm/Kconfig~64bit-resources-modify-kconfig-options	2006-06-16 14:40:15.000000000 -0400
> +++ linux-2.6.17-rc6-1M-vivek/mm/Kconfig	2006-06-16 14:51:31.000000000 -0400
> @@ -145,3 +145,10 @@ config MIGRATION
>  	  while the virtual addresses are not changed. This is useful for
>  	  example on NUMA systems to put pages nearer to the processors accessing
>  	  the page.
> +
> +config RESOURCES_64BIT
> +	bool "64 bit Memory and IO resources (EXPERIMENTAL)"
> +	depends on (EXPERIMENTAL && !64BIT)
> +	default n
> +	help
> +	  This option allows memory and IO resources to be 64 bit.
> diff -puN include/linux/types.h~64bit-resources-modify-kconfig-options include/linux/types.h
> --- linux-2.6.17-rc6-1M/include/linux/types.h~64bit-resources-modify-kconfig-options	2006-06-16 14:40:15.000000000 -0400
> +++ linux-2.6.17-rc6-1M-vivek/include/linux/types.h	2006-06-16 14:49:28.000000000 -0400
> @@ -179,7 +179,12 @@ typedef __u64 __bitwise __be64;
>  #ifdef __KERNEL__
>  typedef unsigned __bitwise__ gfp_t;
>  
> -typedef unsigned long resource_size_t;
> +#if defined(CONFIG_RESOURCES_64BIT) || defined(CONFIG_64BIT)

If you'd set CONFIG_RESOURCES_64BIT in Kconfig if CONFIG_64BIT, you don't need
the `|| defined(CONFIG_64BIT)'.

IMHO it looks a bit confusing that resources are 64 bit on 64 bit platforms,
while CONFIG_RESOURCES_64BIT is not set.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
