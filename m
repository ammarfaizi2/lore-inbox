Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWBVTG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWBVTG6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 14:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWBVTG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 14:06:58 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:65177 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751399AbWBVTG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 14:06:57 -0500
Subject: Re: [PATCH] fix broken x86 SMP boot sequence
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Zachary Amsden <zach@vmware.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43FCA8B2.5040306@vmware.com>
References: <1140630504.3227.38.camel@mulgrave.il.steeleye.com>
	 <43FCA8B2.5040306@vmware.com>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 13:06:30 -0600
Message-Id: <1140635190.6616.12.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-22 at 10:08 -0800, Zachary Amsden wrote:
> I'm not adverse to making the gdt descriptors part of the per-cpu data.  

If you can think of another way to fix the bug, I'm open to it.

> But I think your patch is missing some necessary changes to 
> include/asm-i386/desc.h - what do you plan to do with the following 
> definition there?
> 
> extern struct Xgt_desc_struct idt_descr, cpu_gdt_descr[NR_CPUS];

Nothing ... it predates your patch ... it's not much use, but just in
case someone wants to get at the boot cpu gdt descriptors.

> Also, it seems likely you may have broken APM and/or PnP BIOS.

I don't think so, how? ... APM alters the GDT for the APM bios long
after cpu_init() is called, as does drivers/pnp/pnpbios.

> Can't you get rid of this ugly hack _and_ optimize the code at the same 
> time?  I don't understand the details of voyager bringup, but it seems 
> clear that the BSP or node 0 is special in both sub-architectures.  If 
> it is special anyway, the conditional logic can be merged, and better 
> yet, the allocation for the first caller of cpu_init() can skip the 
> allocation entirely - it can simply use the boot GDT, which is already 
> page-aligned and ready to go.  This gets rid of the 
> alloc_bootmem_pages() piece of the hack above.

Not without repeating your bug.  In the original code the gdt runs in
the boot area until cpu_init() where it switches to the original per_cpu
for the descriptor.  Your patch moved the boot CPU to using the boot
area after cpu_init(), which means subsequent boot cpu gdt changes alter
that area before the secondaries have come up (also using it).

If we have to move to individual pages for descriptors, then every CPU
needs one.

> Also, it seems you left the allocation of the GDT in do_boot_cpu().  How 
> do you plan to make sure that GDT allocation is compatible with hotplug 
> CPU startup?  I was worried about that, which is why I moved the GDT 
> allocation for secondary processors (originally in 
> arch/i386/kernel/cpu/common.c) to smpboot.c.

No, this piece of the patch:

diff --git a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
index b3c2e2c..9ed449a 100644
--- a/arch/i386/kernel/smpboot.c
+++ b/arch/i386/kernel/smpboot.c
@@ -903,12 +903,6 @@ static int __devinit do_boot_cpu(int api
        unsigned long start_eip;
        unsigned short nmi_high = 0, nmi_low = 0;
 
-       if (!cpu_gdt_descr[cpu].address &&
-           !(cpu_gdt_descr[cpu].address = get_zeroed_page(GFP_KERNEL)))
{
-               printk("Failed to allocate GDT for CPU %d\n", cpu);
-               return 1;
-       }
-
        ++cpucount;
 
        /*

removes it.

Since the allocation is in cpu_init(), it will be called on hotplug as
well.

James


