Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWFSIGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWFSIGk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 04:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWFSIGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 04:06:40 -0400
Received: from witte.sonytel.be ([80.88.33.193]:2999 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S932251AbWFSIGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 04:06:39 -0400
Date: Mon, 19 Jun 2006 10:05:53 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Vivek Goyal <vgoyal@in.ibm.com>, Roman Zippel <zippel@linux-m68k.org>
cc: Greg KH <greg@kroah.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH 16/16] 64bit Resource: finally enable 64bit resource
 sizes
In-Reply-To: <20060618180547.GA14049@in.ibm.com>
Message-ID: <Pine.LNX.4.62.0606191003230.6499@pademelon.sonytel.be>
References: <11501587303683-git-send-email-greg@kroah.com>
 <11501587343689-git-send-email-greg@kroah.com>
 <Pine.LNX.4.62.0606141417430.1886@pademelon.sonytel.be> <20060614233507.GA23629@kroah.com>
 <20060615042806.GC8587@in.ibm.com> <Pine.LNX.4.62.0606151345420.21517@pademelon.sonytel.be>
 <20060615155643.GB8706@in.ibm.com> <20060616013543.GB2566@kroah.com>
 <20060616201605.GA27462@in.ibm.com> <Pine.LNX.4.62.0606171633190.24519@pademelon.sonytel.be>
 <20060618180547.GA14049@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Jun 2006, Vivek Goyal wrote:
> On Sat, Jun 17, 2006 at 04:34:41PM +0200, Geert Uytterhoeven wrote:
> > > diff -puN mm/Kconfig~64bit-resources-modify-kconfig-options mm/Kconfig
> > > --- linux-2.6.17-rc6-1M/mm/Kconfig~64bit-resources-modify-kconfig-options	2006-06-16 14:40:15.000000000 -0400
> > > +++ linux-2.6.17-rc6-1M-vivek/mm/Kconfig	2006-06-16 14:51:31.000000000 -0400
> > > @@ -145,3 +145,10 @@ config MIGRATION
> > >  	  while the virtual addresses are not changed. This is useful for
> > >  	  example on NUMA systems to put pages nearer to the processors accessing
> > >  	  the page.
> > > +
> > > +config RESOURCES_64BIT
> > > +	bool "64 bit Memory and IO resources (EXPERIMENTAL)"
> > > +	depends on (EXPERIMENTAL && !64BIT)
> > > +	default n
> > > +	help
> > > +	  This option allows memory and IO resources to be 64 bit.
> > > diff -puN include/linux/types.h~64bit-resources-modify-kconfig-options include/linux/types.h
> > > --- linux-2.6.17-rc6-1M/include/linux/types.h~64bit-resources-modify-kconfig-options	2006-06-16 14:40:15.000000000 -0400
> > > +++ linux-2.6.17-rc6-1M-vivek/include/linux/types.h	2006-06-16 14:49:28.000000000 -0400
> > > @@ -179,7 +179,12 @@ typedef __u64 __bitwise __be64;
> > >  #ifdef __KERNEL__
> > >  typedef unsigned __bitwise__ gfp_t;
> > >  
> > > -typedef unsigned long resource_size_t;
> > > +#if defined(CONFIG_RESOURCES_64BIT) || defined(CONFIG_64BIT)
> > 
> > If you'd set CONFIG_RESOURCES_64BIT in Kconfig if CONFIG_64BIT, you don't need
> > the `|| defined(CONFIG_64BIT)'.
> > 
> > IMHO it looks a bit confusing that resources are 64 bit on 64 bit platforms,
> > while CONFIG_RESOURCES_64BIT is not set.
> > 
> 
> Ok. Here is another take. I have used "select" in arch dependent files to
> select CONFIG_RESOURCES_64BIT forcibly if 64BIT is set. Please suggest if
> there is an arch independent way to do that.

I don't think you need to explicitly select it, since

> --- linux-2.6.17-rc6-1M/mm/Kconfig~64bit-resources-modify-kconfig-options	2006-06-18 13:35:13.000000000 -0400
> +++ linux-2.6.17-rc6-1M-vivek/mm/Kconfig	2006-06-18 13:35:13.000000000 -0400
> @@ -145,3 +145,12 @@ config MIGRATION
>  	  while the virtual addresses are not changed. This is useful for
>  	  example on NUMA systems to put pages nearer to the processors accessing
>  	  the page.
> +
> +config RESOURCES_64BIT
> +	bool "64 bit Memory and IO resources (EXPERIMENTAL)"
> +	depends on (EXPERIMENTAL && !64BIT) || 64BIT
> +	default y if 64BIT

it defaults to y if 64BIT. Roman?

> There is a small issue though. On 64bit kernels RESOURCES_64BIT should not
> be exprimental as rosources are already 64bit. "select" will make sure
> that RESOURCES_64BIT is set but following line will be visible to user on 
> 64bit platforms and user might be confused about "EXPERIMENTAL" keyword.
> 
> "64 bit Memory and IO resources (EXPERIMENTAL)"
> 
> At the same time this key word is required on 32bit platforms so that user
> knows that this is something new and experimental.

`EXPERIMENTAL on 32 bit'?

> Please suggest if there is a way to handle this situation. Ideally I would
> like to set RESOURCES_64BIT on 64bit platforms without prompting anything
> to user.

Yes, that's what you want. Roman?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
