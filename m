Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267187AbSLECAM>; Wed, 4 Dec 2002 21:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267193AbSLECAM>; Wed, 4 Dec 2002 21:00:12 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:24297 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267187AbSLECAG>;
	Wed, 4 Dec 2002 21:00:06 -0500
Message-ID: <3DEEB39A.4020306@us.ibm.com>
Date: Wed, 04 Dec 2002 18:02:02 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@HansenPartnership.com>
CC: linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>,
       wli@holomorphy.com, mochel@osdl.org
Subject: Re: [RFC] rethinking the topology functions
References: <200211291918.gATJIUQ03127@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> The attached represents an initial stab at implementing topology functions (or 
> actually indirecting topology through the subarchitecture features).

Hmm..  I think this is actually a really good goal.  I've got some 
comments on your implementation below, but I think this goes in the 
right direction.


> Getting this far made me realise that the current topology infrastructure is 
> rather inadequate (being geared towards the needs of NUMA machines).
> 
> All I really need for voyager is the concept of cpu_nodes (voyager CPU cards 
> have huge L3 caches and up to 4 CPUs each, so scheduling between CPU cards can 
> end up rather expensive in terms of cache invalidation).  I have no use for 
> memory affinities since the voyager memory map is uniform.

Inadequate?  It sounds as though the current topology infrastructure 
does everything you need plus *more*.  In that case, simply don't use 
that part you don't need (memory affinity), and you get the part you do 
need (CPU affinity) for free.  No?


> I'd like to rework the current sysfs cpu/node pieces to provide two separate 
> topologies (one for CPU and one for memory).

If you don't want the memblk stuff in for voyager, just edit the 
makefile, and make sure drivers/base/memblk.c isn't compiled in for you. 
  Or, even more simply, when you write the topology init for voyager, 
don't initialize any memblks...  problem solved! ;)


> Ultimately, the scheduler could be tuned to use the topologies to make 
> scheduling decisions.  When that happens, we can probably fold the current 
> Pentium Hyperthreading stuff into a simple topology map as well.
> 
> I believe Martin Bligh and Bill Irwin are working (or at least thinking) 
> somewhat along these lines, so I thought I'd gather feedback before jumping 
> into a wholesale rewrite.

Martin already responded to this bit, but I'll reitterate a piece.  The 
scheduler already does use some of the topology macros.  We (I?) don't 
want to split the in-kernel topology into multiple different topology 
infrastructures: one for VM, one for scheduling, one for I/O, etc.  It 
would be best if we could all use the same infrastructure, and just use 
the information it provides for each subsystem.  For example, the 
scheduler could cache some of the cpu<->node mappings in local per-pool 
arrays or something, rather than inventing new cpu<->pool topology.


> James Bottomley
> 
> 
> ------------------------------------------------------------------------
> 
> # This is a BitKeeper generated patch for the following project:
> # Project Name: Linux kernel tree
> # This patch format is intended for GNU patch command version 2.5 or higher.
> # This patch includes the following deltas:
> #	           ChangeSet	1.934   -> 1.935  
> #	include/asm-i386/voyager.h	1.3     -> 1.4    
> #	   arch/i386/Kconfig	1.16    -> 1.17   
> #	 drivers/base/node.c	1.3     -> 1.4    
> #	include/asm-i386/topology.h	1.2     -> 1.3    
> #	include/asm-i386/numnodes.h	1.2     -> 1.3    
> #	arch/i386/mach-voyager/voyager_cat.c	1.7     -> 1.8    
> #	include/asm-i386/vic.h	1.4     -> 1.5    
> #	arch/i386/mach-voyager/Makefile	1.9     -> 1.10   
> #	drivers/base/Makefile	1.16    -> 1.17   
> #	               (new)	        -> 1.1     arch/i386/mach-generic/machine_topology.h
> #	               (new)	        -> 1.1     arch/i386/mach-voyager/topology.c
> #	               (new)	        -> 1.1     arch/i386/mach-voyager/machine_topology.h
> #
> # The following is the BitKeeper ChangeSet Log
> # --------------------------------------------
> # 02/11/29	jejb@malley.(none)	1.935
> # add topology to voyager
> # --------------------------------------------
> #
> diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
> --- a/arch/i386/Kconfig	Fri Nov 29 13:01:29 2002
> +++ b/arch/i386/Kconfig	Fri Nov 29 13:01:29 2002
> @@ -1698,3 +1698,13 @@
>  	bool
>  	depends on SMP
>  	default y
> +
> +config BASE_NODE
> +	bool
> +	depends on NUMA || VOYAGER
> +	default y
> +
> +config X86_NUMNODES
> +	int
> +	default "8" if VOYAGER
> +	default "1" if !VOYAGER

Ok..  I *really* don't think that we need *another* maximum number of 
nodes counter.  We already have MAX_NR_NODES, and MAX_NUMNODES.  The 
last thing we need is one more.

> diff -Nru a/arch/i386/mach-generic/machine_topology.h b/arch/i386/mach-generic/machine_topology.h
> --- /dev/null	Wed Dec 31 16:00:00 1969
> +++ b/arch/i386/mach-generic/machine_topology.h	Fri Nov 29 13:01:29 2002
> @@ -0,0 +1,96 @@
> +/*
> + * linux/include/asm-i386/topology.h
> + *
> + * Written by: Matthew Dobson, IBM Corporation
> + *
> + * Copyright (C) 2002, IBM Corp.
> + *
> + * All rights reserved.          
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
> + * NON INFRINGEMENT.  See the GNU General Public License for more
> + * details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + * Send feedback to <colpatch@us.ibm.com>
> + */
> +#ifndef _MACHINE_TOPOLOGY_H
> +#define _MACHINE_TOPOLOGY_H
> +
>  <snip>
> +
> +#endif

I like this.  I wanted to get around to doing this anyhow.  John Stultz 
is doing this for summit, and I planned to follow his lead with the 
sub-arch breakup.  Again, we're all trying for the same thing, so one of 
us should succeed.


> diff -Nru a/arch/i386/mach-voyager/Makefile b/arch/i386/mach-voyager/Makefile
> --- a/arch/i386/mach-voyager/Makefile	Fri Nov 29 13:01:29 2002
> +++ b/arch/i386/mach-voyager/Makefile	Fri Nov 29 13:01:29 2002
> @@ -10,7 +10,7 @@
>  EXTRA_CFLAGS	+= -I../kernel
>  export-objs	:=
>  
> -obj-y			:= setup.o voyager_basic.o voyager_thread.o
> +obj-y			:= setup.o voyager_basic.o voyager_thread.o topology.o
>  
>  obj-$(CONFIG_SMP)	+= voyager_smp.o voyager_cat.o
>  
> diff -Nru a/arch/i386/mach-voyager/machine_topology.h b/arch/i386/mach-voyager/machine_topology.h
> --- /dev/null	Wed Dec 31 16:00:00 1969
> +++ b/arch/i386/mach-voyager/machine_topology.h	Fri Nov 29 13:01:29 2002
> @@ -0,0 +1,45 @@
> +/* -*- mode: c; c-basic-offset: 8 -*- */
> +
> +/* Copyright (C) 1999,2001
> + *
> + * Author: J.E.J.Bottomley@HansenPartnership.com
> + *
> + * linux/arch/i386/mach-voyager/machine_topology.h
> + */
> +#include <asm/voyager.h>
> +
>  <SNIP>
> +
> +/* FIXME: these are useless defines just to get topology to compile
> + * The code needs to be NUMA cleaned up to separate node from what
> + * NUMA thinks of as a node */
> +#define __node_to_memblk(node) (node)
> +#define si_meminfo_node(i, j)
> +

If voyager has a flat memory space, I would highly recommend
#define __node_to_memblk(node) (0)
instead of (node).  Returning the node number makes it look like each 
node has it's own memblk with a 1-1 mapping between them.  Also, your 
si_meminfo_node should be able to more or less just call the non-node 
version.

> diff -Nru a/arch/i386/mach-voyager/topology.c b/arch/i386/mach-voyager/topology.c
> --- /dev/null	Wed Dec 31 16:00:00 1969
> +++ b/arch/i386/mach-voyager/topology.c	Fri Nov 29 13:01:29 2002
> @@ -0,0 +1,51 @@
> +/* -*- mode: c; c-basic-offset: 8 -*- */
> +
> +/* Copyright (C) 2002
> + *
> + * Author: J.E.J.Bottomley@HansenPartnership.com
> + *
> + * voyager topology functions
> + */
> +
> +#include <linux/init.h>
> +#include <linux/string.h>
> +#include <asm/cpu.h>
> +#include <linux/smp.h>
> +#include <asm/topology.h>
> +
> +/* Topology mapping functions */
> +u32 voyager_node_to_cpu_mask[MAX_PROCESSOR_BOARDS] = { 0 };
> +u8 voyager_cpu_to_node[NR_CPUS] = { 0 };
> +u8 voyager_num_nodes = 0;
> +
> +struct i386_cpu cpu_devices[NR_CPUS];
> +struct i386_node node_devices[MAX_NUMNODES];
> +
> +static int __init topology_init(void)
> +{
> +	int i;
> +
> +	printk("VOYAGER BEGINNING TOPOLOGY INITIALISATION %d\n", MAX_NUMNODES);
> +	memset(cpu_devices, 0, sizeof(cpu_devices));
> +	memset(node_devices, 0, sizeof(node_devices));
> +
> +	for (i = 0; i < num_online_nodes(); i++)
> +		arch_register_node(i);
> +	for (i = 0; i < NR_CPUS; i++)
> +		if (cpu_possible(i)) arch_register_cpu(i);
> +
> +	printk("NODES %d\n", num_online_nodes());
> +	printk("CPU TO NODE: ");
> +	for(i=0; i<NR_CPUS; i++)
> +		if(cpu_possible(i))
> +			printk("%d->%d ", i, voyager_cpu_to_node[i]);
> +	printk("\nNODE TO CPU MASK: ");
> +	for(i=0; i<voyager_num_nodes; i++)
> +		printk("%d->0x%04x ", i, voyager_node_to_cpu_mask[i]);
> +	printk("\n");
> +
> +
> +	return 0;
> +}
> +
> +subsys_initcall(topology_init);

As I mentioned above, since you only have the one memblk, you could 
easily call arch_register_memblk once, or just leave it alone like 
you've done.

>
 > <snip>
 >
> diff -Nru a/drivers/base/Makefile b/drivers/base/Makefile
> --- a/drivers/base/Makefile	Fri Nov 29 13:01:29 2002
> +++ b/drivers/base/Makefile	Fri Nov 29 13:01:29 2002
> @@ -4,7 +4,8 @@
>  			driver.o class.o intf.o platform.o \
>  			cpu.o firmware.o
>  
> -obj-$(CONFIG_NUMA)	+= node.o  memblk.o
> +obj-$(CONFIG_BASE_NODE)	+= node.o
> +obj-$(CONFIG_NUMA)	+= memblk.o
>  
>  obj-y		+= fs/
>  

Mentioned this above.  You could leave it in and just register the 
singular memblk if you liked.

> diff -Nru a/drivers/base/node.c b/drivers/base/node.c
> --- a/drivers/base/node.c	Fri Nov 29 13:01:29 2002
> +++ b/drivers/base/node.c	Fri Nov 29 13:01:29 2002
> @@ -93,7 +93,8 @@
>  
>  static int __init register_node_type(void)
>  {
> +	devclass_register(&node_devclass);
>  	driver_register(&node_driver);
> -	return devclass_register(&node_devclass);
> +	return 0; //devclass_register(&node_devclass);
>  }
>  postcore_initcall(register_node_type);

I've submitted this fix separtately.  It really needs to go in the 
mainline, without this NUMA boxen panic.

> diff -Nru a/include/asm-i386/numnodes.h b/include/asm-i386/numnodes.h
> --- a/include/asm-i386/numnodes.h	Fri Nov 29 13:01:29 2002
> +++ b/include/asm-i386/numnodes.h	Fri Nov 29 13:01:29 2002
> @@ -6,7 +6,7 @@
>  #ifdef CONFIG_X86_NUMAQ
>  #include <asm/numaq.h>
>  #else
> -#define MAX_NUMNODES	1
> +#define MAX_NUMNODES	CONFIG_X86_NUMNODES
>  #endif /* CONFIG_X86_NUMAQ */
>  
>  #endif /* _ASM_MAX_NUMNODES_H */

I'd like to see some of the confusion with MAX_NR_NODES and MAX_NUMNODES 
  disappear, but apparently no one liked my patch.  I'll dust it off and 
resubmit it.  I really think it'd be beneficial to only have one 
variable for this.  I also suppose that there's no reason this has to be 
X86 specific.  We could have this for most arch's and just default to 1.

>
 ><snip>
 >
> diff -Nru a/include/asm-i386/vic.h b/include/asm-i386/vic.h
> --- a/include/asm-i386/vic.h	Fri Nov 29 13:01:29 2002
> +++ b/include/asm-i386/vic.h	Fri Nov 29 13:01:29 2002
> @@ -3,6 +3,8 @@
>   * Author: J.E.J.Bottomley@HansenPartnership.com
>   *
>   * Standard include definitions for the NCR Voyager Interrupt Controller */
> +#ifndef _ASM_VIC_H
> +#define _ASM_VIC_H
>  
>  /* The eight CPI vectors.  To activate a CPI, you write a bit mask
>   * corresponding to the processor set to be interrupted into the
> @@ -59,3 +61,5 @@
>  #define VIC_BOOT_INTERRUPT_MASK		0xfe
>  
>  extern void smp_vic_timer_interrupt(struct pt_regs *regs);
> +
> +#endif
> diff -Nru a/include/asm-i386/voyager.h b/include/asm-i386/voyager.h
> --- a/include/asm-i386/voyager.h	Fri Nov 29 13:01:29 2002
> +++ b/include/asm-i386/voyager.h	Fri Nov 29 13:01:29 2002
> @@ -3,6 +3,8 @@
>   * Author: J.E.J.Bottomley@HansenPartnership.com
>   *
>   * Standard include definitions for the NCR Voyager system */
> +#ifndef _ASM_VOYAGER_H_
> +#define _ASM_VOYAGER_H_
>  
>  #undef	VOYAGER_DEBUG
>  #undef	VOYAGER_CAT_DEBUG
> @@ -519,3 +521,5 @@
>  #define VOYAGER_PSI_SUBREAD	2
>  #define VOYAGER_PSI_SUBWRITE	3
>  extern void voyager_cat_psi(__u8, __u16, __u8 *);
> +
> +#endif

This is voyager specific and I'm sure it's fine.

I'll have a go at a counter-patch tomorrow... ;)

Cheers!

-Matt

