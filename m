Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWAROnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWAROnb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 09:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbWAROnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 09:43:31 -0500
Received: from over.co.us.ibm.com ([32.97.110.157]:62593 "EHLO
	over.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030195AbWAROna
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 09:43:30 -0500
Date: Mon, 16 Jan 2006 09:37:48 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Cc: linuxppc64-dev@ozlabs.org, Andrew Morton <akpm@osdl.org>,
       paulus@au1.ibm.com, anton@au1.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm4 failure on power5
Message-ID: <20060116153748.GA25866@sergelap.austin.ibm.com>
References: <20060116063530.GB23399@sergelap.austin.ibm.com> <20060115230557.0f07a55c.akpm@osdl.org> <200601170000.58134.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601170000.58134.michael@ellerman.id.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Michael Ellerman (michael@ellerman.id.au):
> On Mon, 16 Jan 2006 18:05, Andrew Morton wrote:
> > "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> > > On my power5 partition, 2.6.15-mm4 hangs on boot
> >
> > It might be worth reverting the changes to arch/powerpc/mm/hash_utils_64.c,
> > see if that unbreaks it.
> >
> > -		base = lmb.memory.region[i].base + KERNELBASE;
> > +		base = (unsigned long)__va(lmb.memory.region[i].base);
> 
> You can try it, but if that fixes the problem I'll buy a sombrero and then eat 
> it.

Sounds unpleasant, but no need - that didn't fix it.

> > The nice comment in page.h:
> >
> >  * KERNELBASE is the virtual address of the start of the kernel, it's often
> >  * the same as PAGE_OFFSET, but _might not be_.
> >  *
> >  * The kdump dump kernel is one example where KERNELBASE != PAGE_OFFSET.
> >  *
> >  * To get a physical address from a virtual one you subtract PAGE_OFFSET,
> >  * _not_ KERNELBASE.
> >
> > Tells us that was not an equivalent transformation.
> 
> True, not equivalent in all cases, but correct. For non-kdump kernels (which I 
> assume this is) KERNELBASE == PAGE_OFFSET, and for a kdump kernel that code 
> wants to use PAGE_OFFSET, not KERNELBASE.
> 
> Try enabling early debugging (see arch/powerpc/kernel/setup_64.c) and then 
> turning on DEBUG in hash_utils_64.c, setup_64.c etc.

That gives me the following output:

boot: quicktest
Please wait, loading kernel...
   Elf64 kernel loaded...
OF stdout device is: /vdevice/vty@30000000
Hypertas detected, assuming LPAR !
command line: ro console=hvc0 root=/dev/sda6 smt-enabled=1 
memory layout at init:
  memory_limit : 0000000000000000 (16 MB aligned)
  alloc_bottom : 0000000002223000
  alloc_top    : 0000000008000000
  alloc_top_hi : 0000000088000000
  rmo_top      : 0000000008000000
  ram_top      : 0000000088000000
Looking for displays
instantiating rtas at 0x00000000077d7000 ... done
0000000000000000 : boot cpu     0000000000000000
0000000000000002 : starting cpu hw idx 0000000000000002... done
0000000000000004 : starting cpu hw idx 0000000000000004... done
0000000000000006 : starting cpu hw idx 0000000000000006... done
copying OF device tree ...
Building dt strings...
Building dt structure...
Device tree strings 0x0000000002424000 -> 0x0000000002424f36
Device tree struct  0x0000000002425000 -> 0x000000000242c000
Calling quiesce ...
returning from prom_init
 -> early_setup()
Probing machine type for platform 101...
Found, Initializing memory management...
 -> htab_initialize()
creating mapping for region: c000000000000000 : 88000000
 <- htab_initialize()
 <- early_setup()
 -> setup_system()
 -> initialize_cache_info()
 <- initialize_cache_info()
Page orders: linear mapping = 24, others = 12
 -> smp_release_cpus()
 <- smp_release_cpus()
 <- setup_system()

So setup_system() at least finishes, though I don't see the
printk's at the bottom of that function.

thanks,
-serge
