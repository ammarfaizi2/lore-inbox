Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbWKBVP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWKBVP1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 16:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWKBVP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 16:15:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10671 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751415AbWKBVP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 16:15:26 -0500
Date: Thu, 2 Nov 2006 13:14:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Steve Langasek <vorlon@debian.org>
Cc: Eki <eki@sci.fi>, Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       linux-kernel@vger.kernel.org, thias.lelourd@gmail.com,
       jharrison@linuxbs.org
Subject: Re: [patch] video: support for VGA hoses on alpha TITAN, TSUNAMI
 systems (ES45, DS25)
Message-Id: <20061102131443.918d6c2e.akpm@osdl.org>
In-Reply-To: <20061102083718.GC12267@mauritius.dodds.net>
References: <20061102083718.GC12267@mauritius.dodds.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2006 00:37:20 -0800
Steve Langasek <vorlon@debian.org> wrote:

> From: Jay Estabrook <jay.estabrook@hp.com>
> 
> Add working support for VGA hoses on Alpha, which is required in order to
> use a VGA console on TITAN- and TSUNAMI-class Alpha systems.  This also
> generalizes support for non-standard VGA offsets on Alpha to cover the
> Marvel class of alphas without special-casing.  Includes recognizing an
> additional model of TITAN-class Alpha.
> 
> Tested successfully on an ES45 and a DS25 with a vanilla 2.6.18 kernel,
> also tested on an LX164 with the Debian 2.6.18 kernel with no regressions. 
> Included in Alpha Core distribution for some time.
> 

It would be appropriate for both yourself and Jay to provide signoffs for
this work, as per section 11 of Documentation/SubmittingPatches, please.

What is a "hose"?


Some trivia:


> +	if (!hose || (conswitchp == &vga_con && pci_vga_hose == hose)) return;

This is missing a newline.

> +static int titan_pchip1_present = 0;

Unneeded (and undesirable) initialisation.

> +++ source-es45/arch/alpha/kernel/proto.h	2006-09-30 03:14:44.000000000 -0700
> @@ -106,6 +106,11 @@
>  extern unsigned long wildfire_node_mem_start(int);
>  extern unsigned long wildfire_node_mem_size(int);
>  
> +/* console.c */
> +#ifdef CONFIG_VGA_HOSE
> +  extern void locate_and_init_vga(void *(*)(void *, void *));
> +#endif

The ifdef isn't really needed - we usually leave it out.

> diff -uNr source/arch/alpha/kernel/sys_dp264.c source-es45/arch/alpha/kernel/sys_dp264.c
> --- source/arch/alpha/kernel/sys_dp264.c	2006-09-19 20:42:06.000000000 -0700
> +++ source-es45/arch/alpha/kernel/sys_dp264.c	2006-09-30 03:14:44.000000000 -0700
> @@ -543,6 +543,9 @@
>  {
>  	common_init_pci();
>  	SMC669_Init(0);
> +#ifdef CONFIG_VGA_HOSE
> +	locate_and_init_vga(NULL);
> +#endif
>  }
>  
>  static void __init
> @@ -551,6 +554,18 @@
>  	common_init_pci();
>  	SMC669_Init(1);
>  	es1888_init();
> +#ifdef CONFIG_VGA_HOSE
> +	locate_and_init_vga(NULL);
> +#endif
> +}
> +
> +static void __init
> +clipper_init_pci(void)
> +{
> +	common_init_pci();
> +#ifdef CONFIG_VGA_HOSE
> +	locate_and_init_vga(NULL);
> +#endif
>  }

We normally do:

#ifdef CONFIG_VGA_HOSE
extern void locate_and_init_vga(void *(*handler)(void *, void *));
#else
static inline void locate_and_init_vga(void *(*handler)(void *, void *))
{
}
#endif

so that all those ifdefs go away and so that the new code gets
compile-checked regardless of config settings.

>  
> +/* wait until after includes to test for this, to allow arch-specific mod. */
> +#ifndef vga_request_resource
> +# define vga_request_resource request_resource
> +#endif
> +

erk.

> +#define vga_request_resource alpha_vga_request_resource
> +
> +static int __inline__
> +alpha_vga_request_resource(struct resource *root, struct resource *new)
> +{
> +	/* First, fixup the VGA resource bounds WRT the hose it is on. */
> +	if (pci_vga_hose) {
> +		new->start += pci_vga_hose->io_space->start;
> +		new->end += pci_vga_hose->io_space->start;
> +	}
> +
> +	/* Finally, do a normal request_resource(). */
> +	return request_resource(root, new);
> +}
> 

So if the resource is being requested by vga we adjust the caller's
resource before actually requesting it.

Isn't this a bit hacky?  How come vgacon ended up requesting the wrong
addresses in the first place?

(And please don't use __inline__ or __inline - plain old `inline' works fine)

>  static DEFINE_SPINLOCK(vga_lock);
>  static int cursor_size_lastfrom;
>  static int cursor_size_lastto;
> @@ -393,7 +398,7 @@
>  			vga_video_type = VIDEO_TYPE_EGAM;
>  			vga_vram_size = 0x8000;
>  			display_desc = "EGA+";
> -			request_resource(&ioport_resource,
> +			vga_request_resource(&ioport_resource,
>  					 &ega_console_resource);
>
> ..
>
> diff -uNr source/include/asm-alpha/core_titan.h source-es45/include/asm-alpha/core_titan.h
> --- source/include/asm-alpha/core_titan.h	2006-09-19 20:42:06.000000000 -0700
> +++ source-es45/include/asm-alpha/core_titan.h	2006-09-30 03:14:44.000000000 -0700
> @@ -3,6 +3,7 @@
>  
>  #include <linux/types.h>
>  #include <linux/pci.h>
> +#include <asm/pci.h>
>  #include <asm/compiler.h>
>  
> ...
>
> diff -uNr source/include/asm-alpha/core_tsunami.h source-es45/include/asm-alpha/core_tsunami.h
> --- source/include/asm-alpha/core_tsunami.h	2006-09-19 20:42:06.000000000 -0700
> +++ source-es45/include/asm-alpha/core_tsunami.h	2006-09-30 03:14:44.000000000 -0700
> @@ -2,6 +2,8 @@
>  #define __ALPHA_TSUNAMI__H__
>  
>  #include <linux/types.h>
> +#include <linux/pci.h>
> +#include <asm/pci.h>
>  #include <asm/compiler.h>

So we actually need to include asm/pci.h in these files?  linux/pci.h
already did that?


