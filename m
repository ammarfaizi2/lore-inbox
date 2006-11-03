Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753265AbWKCO4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265AbWKCO4m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 09:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753267AbWKCO4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 09:56:42 -0500
Received: from usea-naimss2.unisys.com ([192.61.61.104]:42250 "EHLO
	usea-naimss2.unisys.com") by vger.kernel.org with ESMTP
	id S1753265AbWKCO4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 09:56:41 -0500
Subject: Re: [RFC] [PATCH 2.6.19-rc4] kdump panics early in boot when 
	reserving MP Tables located in high memory
From: Amul Shah <amul.shah@unisys.com>
To: Andi Kleen <ak@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, fastboot <fastboot@lists.osdl.org>,
       Vivek Goyal <vgoyal@in.ibm.com>
In-Reply-To: <200611030340.55952.ak@suse.de>
References: <1162506272.19677.33.camel@ustr-linux-shaha1.unisys.com>
	 <200611030340.55952.ak@suse.de>
Content-Type: text/plain
Date: Fri, 03 Nov 2006 09:55:21 -0500
Message-Id: <1162565722.19677.68.camel@ustr-linux-shaha1.unisys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Nov 2006 14:56:20.0242 (UTC) FILETIME=[38D66F20:01C6FF58]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-03 at 03:40 +0100, Andi Kleen wrote:
> On Thursday 02 November 2006 23:24, Amul Shah wrote:
> 
> > 
> > The ACPI tables and MP Tables reside higher in memory.  When reserving
> > memory with reserve_bootmem_generic, the function has a BUG panic if the
> > memory location to reserve is above the top of memory.  The MP table is
> > above the top of memory in a user defined memory map.
> 
> I think it would be cleaner to add a check in reserve_bootmem_generic
> that just returns when pfn >= end_pfn && pfn < end_pfn_mapped
> 
> How about this patch? Does it work?
> 
> -Andi
> 
> Handle reserve_bootmem_generic beyond end_pfn
> 
> This can happen on kexec kernels with some configurations, in particularly
> on Unisys ES7000 systems.
> 
> Analysis by Amul Shah 
> 
> Cc: Amul Shah <amul.shah@unisys.com>
> 
> Signed-off-by: Andi Kleen <ak@suse.de>
> 
> Index: linux/arch/x86_64/mm/init.c
> ===================================================================
> --- linux.orig/arch/x86_64/mm/init.c
> +++ linux/arch/x86_64/mm/init.c
> @@ -655,9 +655,22 @@ void free_initrd_mem(unsigned long start
>  
>  void __init reserve_bootmem_generic(unsigned long phys, unsigned len) 
>  { 
> -	/* Should check here against the e820 map to avoid double free */ 
>  #ifdef CONFIG_NUMA
>  	int nid = phys_to_nid(phys);
> +#endif
> +	unsigned long pfn = phys >> PAGE_SHIFT;
> +	if (pfn >= end_pfn) {
> +		/* This can happen with kdump kernels when accessing firmware
> +		   tables. */
> +		if (pfn < end_pfn_map) 
> +			return;
> +		printk(KERN_ERR "reserve_bootmem: illegal reserve %lx %u\n",
> +				phys, len);
> +		return;
> +	}
> +
> +	/* Should check here against the e820 map to avoid double free */ 
> +#ifdef CONFIG_NUMA
>    	reserve_bootmem_node(NODE_DATA(nid), phys, len);
>  #else       		
>  	reserve_bootmem(phys, len);    

Andi,
  That won't worked because in arch/86_64/kernel/e820.c, the exactmap
parsing clobbers end_pfn_map.

static int __init parse_memmap_opt(char *p)
{
	char *oldp;
	unsigned long long start_at, mem_size;

	if (!strcmp(p, "exactmap")) {
#ifdef CONFIG_CRASH_DUMP
		/* If we are doing a crash dump, we
		 * still need to know the real mem
		 * size before original memory map is
		 * reset.
		 */
		saved_max_pfn = e820_end_of_ram();
#endif
		end_pfn_map = 0;
		e820.nr_map = 0;
		userdef = 1;
		return 0;
	}

The following was my alternate patch with uses the saved_max_pfn
variable which avoids the MP config table reservation bug.  I'll rewrite
it to go into reserve_bootmem_generic and submit that patch once I have
tested it.

I chose to use end_user_pfn because it is left unmodified unless the
user specifies an exactmap or a "mem=" value as a kernel boot parameter.
This might be a no-no, since I didn't check to see if I'm under the top
of memory.  I'm making the assumption that since the user chose to
define memory the user knows what s/he is doing.

This patch is just for comment since I'll be using the same logic when I
update the patch that Andi sent.

thanks,
Amul

diff -Naur linux-2.6.19-rc4/arch/x86_64/kernel/mpparse.c linux-2.6.19-rc4-pfncheck/arch/x86_64/kernel/mpparse.c
--- linux-2.6.19-rc4/arch/x86_64/kernel/mpparse.c	2006-10-31 17:38:41.000000000 -0500
+++ linux-2.6.19-rc4-pfncheck/arch/x86_64/kernel/mpparse.c	2006-11-03 10:18:24.000000000 -0500
@@ -34,6 +34,7 @@
 /* Have we found an MP table */
 int smp_found_config;
 unsigned int __initdata maxcpus = NR_CPUS;
+extern unsigned long end_user_pfn;
 
 int acpi_found_madt;
 
@@ -528,6 +529,8 @@
 	extern void __bad_mpf_size(void); 
 	unsigned int *bp = phys_to_virt(base);
 	struct intel_mp_floating *mpf;
+	int mpf_below_mem;
+	unsigned long mpf_pfn;
 
 	Dprintk("Scan SMP from %p for %ld bytes.\n", bp,length);
 	if (sizeof(*mpf) != 16)
@@ -542,8 +545,33 @@
 				|| (mpf->mpf_specification == 4)) ) {
 
 			smp_found_config = 1;
+			mpf_below_mem = 0;
 			reserve_bootmem_generic(virt_to_phys(mpf), PAGE_SIZE);
-			if (mpf->mpf_physptr)
+			if (mpf->mpf_physptr) {
+				mpf_pfn = mpf->mpf_physptr>>PAGE_SHIFT;
+				mpf_below_mem = 1;
+#ifdef CONFIG_CRASH_DUMP
+				if (mpf_pfn > end_pfn &&
+				    mpf_pfn < saved_max_pfn) {
+					printk(KERN_WARNING "WARNING: "
+					       "mpf_physptr > end_pfn %lx in "
+					       "user defined map\n", end_pfn);
+					printk(KERN_WARNING "WARNING: "
+					       "Not reserving the MP Tables\n");
+					mpf_below_mem = 0;
+				}
+#endif
+				if (mpf_pfn > end_pfn &&
+				    end_user_pfn != MAXMEM>>PAGE_SHIFT) {
+					printk(KERN_WARNING "WARNING: "
+					       "mpf_physptr > end_pfn %lx. Try"
+					       " a larger 'mem='\n", end_pfn);
+					printk(KERN_WARNING "WARNING: "
+					       "Not reserving the MP Tables\n");
+					mpf_below_mem = 0;
+				}
+			}
+			if (mpf_below_mem)
 				reserve_bootmem_generic(mpf->mpf_physptr, PAGE_SIZE);
 			mpf_found = mpf;
 			return 1;



