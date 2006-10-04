Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422678AbWJDSRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422678AbWJDSRv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 14:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161933AbWJDSRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 14:17:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5822 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161255AbWJDSRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 14:17:49 -0400
Date: Wed, 4 Oct 2006 11:17:46 -0700
From: Bryce Harrington <bryce@osdl.org>
To: "Moore, Eric" <Eric.Moore@lsil.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [Eng] [OOPS] -git8, 9:  NULL pointer dereference in
Message-ID: <20061004181746.GA17434@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mptspi_dv_renegotiate_work
Reply-To:
In-Reply-To: <20060930215544.GB7957@osdl.org>

On Sat, Sep 30, 2006 at 02:55:44PM -0700, Bryce Harrington wrote:
> On Fri, Sep 29, 2006 at 10:22:50PM -0600, Moore, Eric wrote:
> > On Fri 9/29/2006 6:27 PM, Bryce Harrington wrote:
> > >    http://crucible.osdl.org/runs/2265/sysinfo/amd01.3.console
>
> > Besides, we need to undertand why your interrupt controller is not
> > generating interrupts.

The following patch seems to have fixed the issue, as of
patch-2.6.18-git20.

http://crucible.osdl.org/runs/2390/sysinfo/amd01.console

Thanks,
Bryce

-------- Forwarded Message --------
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Moore, Eric <Eric.Moore@lsil.com>, Martin Bligh <mbligh@google.com>,
LKML <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@shadowen.org>,
linux-scsi@vger.kernel.org
Subject: Re: Panic from mptspi_dv_renegotiate_work in 2.6.18-mm2
Date: 	Mon, 2 Oct 2006 17:41:47 -0700

On Mon, 02 Oct 2006 20:32:13 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> FWIW, I am seeing precisely this problem, in the latest -git.

I just sent this to Linus.  Fingers crossed, it'll fix...

From: Andrew Morton <akpm@osdl.org>

54dbc0c9ebefb38840c6b07fa6eabaeb96c921f5 is causing various people's machines
to fail to map PCI resources.

Revert it in preparation for addressing the show-APICs-in-/proc/iomem
requirement in a different manner.

Cc: Aaron Durbin <adurbin@google.com>
Cc: Andi Kleen <ak@muc.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/x86_64/kernel/apic.c |   54 ------------------------------------
 1 file changed, 54 deletions(-)

diff -puN arch/x86_64/kernel/apic.c~revert-insert-ioapics-and-local-apic-into-resource-map arch/x86_64/kernel/apic.c
--- a/arch/x86_64/kernel/apic.c~revert-insert-ioapics-and-local-apic-into-resource-map
+++ a/arch/x86_64/kernel/apic.c
@@ -25,7 +25,6 @@
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
 #include <linux/module.h>
-#include <linux/ioport.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -46,11 +45,6 @@ int apic_calibrate_pmtmr __initdata;
 
 int disable_apic_timer __initdata;
 
-static struct resource lapic_resource = {
-	.name = "Local APIC",
-	.flags = IORESOURCE_MEM | IORESOURCE_BUSY,
-};
-
 /*
  * cpu_mask that denotes the CPUs that needs timer interrupt coming in as
  * IPIs in place of local APIC timers
@@ -591,40 +585,6 @@ static int __init detect_init_APIC (void
 	return 0;
 }
 
-#ifdef CONFIG_X86_IO_APIC
-static struct resource * __init ioapic_setup_resources(void)
-{
-#define IOAPIC_RESOURCE_NAME_SIZE 11
-	unsigned long n;
-	struct resource *res;
-	char *mem;
-	int i;
-
-	if (nr_ioapics <= 0)
-		return NULL;
-
-	n = IOAPIC_RESOURCE_NAME_SIZE + sizeof(struct resource);
-	n *= nr_ioapics;
-
-	res = alloc_bootmem(n);
-
-	if (!res)
-		return NULL;
-
-	memset(res, 0, n);
-	mem = (void *)&res[nr_ioapics];
-
-	for (i = 0; i < nr_ioapics; i++) {
-		res[i].name = mem;
-		res[i].flags = IORESOURCE_MEM | IORESOURCE_BUSY;
-		snprintf(mem, IOAPIC_RESOURCE_NAME_SIZE, "IOAPIC %u", i);
-		mem += IOAPIC_RESOURCE_NAME_SIZE;
-	}
-
-	return res;
-}
-#endif
-
 void __init init_apic_mappings(void)
 {
 	unsigned long apic_phys;
@@ -644,11 +604,6 @@ void __init init_apic_mappings(void)
 	apic_mapped = 1;
 	apic_printk(APIC_VERBOSE,"mapped APIC to %16lx (%16lx)\n", APIC_BASE, apic_phys);
 
-	/* Put local APIC into the resource map. */
-	lapic_resource.start = apic_phys;
-	lapic_resource.end = lapic_resource.start + PAGE_SIZE - 1;
-	insert_resource(&iomem_resource, &lapic_resource);
-
 	/*
 	 * Fetch the APIC ID of the BSP in case we have a
 	 * default configuration (or the MP table is broken).
@@ -658,9 +613,7 @@ void __init init_apic_mappings(void)
 	{
 		unsigned long ioapic_phys, idx = FIX_IO_APIC_BASE_0;
 		int i;
-		struct resource *ioapic_res;
 
-		ioapic_res = ioapic_setup_resources();
 		for (i = 0; i < nr_ioapics; i++) {
 			if (smp_found_config) {
 				ioapic_phys = mp_ioapics[i].mpc_apicaddr;
@@ -672,13 +625,6 @@ void __init init_apic_mappings(void)
 			apic_printk(APIC_VERBOSE,"mapped IOAPIC to %016lx (%016lx)\n",
 					__fix_to_virt(idx), ioapic_phys);
 			idx++;
-
-			if (ioapic_res) {
-				ioapic_res->start = ioapic_phys;
-				ioapic_res->end = ioapic_phys + (4 * 1024) - 1;
-				insert_resource(&iomem_resource, ioapic_res);
-				ioapic_res++;
-			}
 		}
 	}
 }
_

-
To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Mark Haverkamp <markh@osdl.org>

----- End forwarded message -----
