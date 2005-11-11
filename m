Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbVKKUSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbVKKUSy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 15:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVKKUSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 15:18:54 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:13061 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751114AbVKKUSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 15:18:53 -0500
Date: Fri, 11 Nov 2005 21:18:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, anton@samba.org,
       linuxppc64-dev@ozlabs.org
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-ID: <20051111201849.GP5376@stusta.de>
References: <20051107200336.GH3847@stusta.de> <20051110042857.38b4635b.akpm@osdl.org> <20051111021258.GK5376@stusta.de> <20051110182443.514622ed.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051110182443.514622ed.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 06:24:43PM -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > On Thu, Nov 10, 2005 at 04:28:57AM -0800, Andrew Morton wrote:
> > > Adrian Bunk <bunk@stusta.de> wrote:
> > > >
> > > > Currently, using an undeclared function gives a compile warning, but it 
> > > >  can lead to a nasty runtime error if the prototype of the function is 
> > > >  different from what gcc guessed.
> > > > 
> > > >  With -Werror-implicit-function-declaration, we are getting an immediate 
> > > >  compile error instead.
> > > > 
> > > >  There will be some compile errors in cases where compilation previously
> > > >  worked because the undefined function wasn't called due to gcc dead code
> > > >  elimination, but in these cases a proper fix doesnt harm.
> > > > 
> > > 
> > > Sorry, I need to build allmodconfig kernels on wacky architectures (eg
> > > ppc64) and this patch is killing me.
> > 
> > Can you send me the list of compile errors so that I can work on fixing 
> > them?
> > 
> 
> No handily, sorry.   Missing virt_to_bus() is the typical problem.
>

But in this case -Werror-implicit-function-declaration doesn't create 
new compile errors, it only moves compile errors from compile time to 
link or depmod time - which is IMHO not a bad change.

If you really want to keep the status quo, you can still steal the 
following from sparc64:
  extern unsigned long virt_to_bus_not_defined_use_pci_map(volatile void *addr);
  #define virt_to_bus virt_to_bus_not_defined_use_pci_map
  extern unsigned long bus_to_virt_not_defined_use_pci_map(volatile void *addr);
  #define bus_to_virt bus_to_virt_not_defined_use_pci_map

Would a patch to mark the ISA legacy functions as __deprecated be OK?

This might give some motivation for people to convert drivers and would 
avoid new code like the recently introduced kexec to use this obsolete 
API.

> The cross-tools at http://developer.osdl.org/dev/plm/cross_compile/ are
> quite simple to install.

Thanks, I've tried it.

Other problems I found until I gave up on compiling:
- a problem in sk98lin indirectly corrected by my SkPciWriteCfgDWord() 
  patch
- drivers/net/wireless/tiacx/: missing #include <linux/vmalloc.h>'s
  (see my patch) - this seems to be a real bug

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

