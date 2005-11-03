Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030378AbVKCQe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030378AbVKCQe1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 11:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030379AbVKCQe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 11:34:27 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:19731 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1030378AbVKCQe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 11:34:26 -0500
Message-ID: <436A3C10.9050302@vmware.com>
Date: Thu, 03 Nov 2005 08:34:24 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14: CR4 not needed to be inspected on the 486 anymore?
References: <Pine.LNX.4.55.0511031600010.24109@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0511031600010.24109@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Nov 2005 16:34:39.0241 (UTC) FILETIME=[7C237F90:01C5E094]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:

>Hello,
>
> The following hunk of the 2.6.14 patch:
>
>diff --git a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
>index e3f362e..7a14fdf 100644
>--- a/arch/i386/kernel/process.c
>+++ b/arch/i386/kernel/process.c
>@@ -313,16 +311,12 @@ void show_regs(struct pt_regs * regs)
> 	printk(" DS: %04x ES: %04x\n",
> 		0xffff & regs->xds,0xffff & regs->xes);
> 
>-	__asm__("movl %%cr0, %0": "=r" (cr0));
>-	__asm__("movl %%cr2, %0": "=r" (cr2));
>-	__asm__("movl %%cr3, %0": "=r" (cr3));
>-	/* This could fault if %cr4 does not exist */
>-	__asm__("1: movl %%cr4, %0		\n"
>-		"2:				\n"
>-		".section __ex_table,\"a\"	\n"
>-		".long 1b,2b			\n"
>-		".previous			\n"
>-		: "=r" (cr4): "0" (0));
>+	cr0 = read_cr0();
>+	cr2 = read_cr2();
>+	cr3 = read_cr3();
>+	if (current_cpu_data.x86 > 4) {
>+		cr4 = read_cr4();
>+	}
> 	printk("CR0: %08lx CR2: %08lx CR3: %08lx CR4: %08lx\n", cr0, cr2, cr3, cr4);
> 	show_trace(NULL, &regs->esp);
> }
>
>disables code to retrieve the actual value of CR4 on 486-class systems
>(which may or may not implement the register, depending on the exact CPU
>type and stepping).  This seems suspicious to me, but I have to admit I
>haven't followed the discussion on the issue if there was any.
>  
>

This was deliberate.  CR4 doesn't exist on standard 486 class systems, 
and I'm not sure how you could make use of it anyway, since the features 
used by Linux - machine check, page size extensions, time stamp counter, 
global pages, are only available in Pentium and later class systems, and 
identified by CPUID, which also doesn't exist on 486.

There may be some funky Cyrix or even Intel CPUs that have CR4 
registers, but showing the output in a register dump seems very 
useless.  I would also not recommend using undocumented features in CR4 
even if you have such a freaky processor - there were bugs and/or 
missing functionality with the early large page and global page 
extensions that were not ironed out until the features became 
documented, IIRC.  YMMV - please let me know if anyone has found ways to 
make this useful.

If I am wrong, I am happy to correct this, but I would like to do so 
properly by adding safe_read_cr4() or equivalent rather than using raw 
inlines assembler to catch the fault.

Thanks,

Zach
