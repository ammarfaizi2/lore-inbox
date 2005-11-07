Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbVKGPoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbVKGPoy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 10:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbVKGPoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 10:44:54 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:8708 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S964821AbVKGPox
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 10:44:53 -0500
Message-ID: <436F7673.5040309@vmware.com>
Date: Mon, 07 Nov 2005 07:44:51 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14: CR4 not needed to be inspected on the 486 anymore?
References: <Pine.LNX.4.55.0511031600010.24109@blysk.ds.pg.gda.pl> <436A3C10.9050302@vmware.com> <Pine.LNX.4.55.0511031639310.24109@blysk.ds.pg.gda.pl> <436AA1FD.3010401@vmware.com> <p73fyqb2dtx.fsf@verdi.suse.de> <Pine.LNX.4.55.0511070931560.28165@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0511070931560.28165@blysk.ds.pg.gda.pl>
Content-Type: multipart/mixed;
 boundary="------------070409040600000208020207"
X-OriginalArrivalTime: 07 Nov 2005 15:44:52.0626 (UTC) FILETIME=[31A13720:01C5E3B2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070409040600000208020207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Maciej W. Rozycki wrote:

>On Sat, 5 Nov 2005, Andi Kleen wrote:
>
>  
>
>>I don't think it's a good idea. Relying on nested faults in oops
>>is a bit unsafe because it could lead to recursive faults in the worst case. 
>>    
>>
>
> Good point.
>
>  
>
>>Better keep the if
>>    
>>
>
> Except the condition is wrong.  Presence of CR4 could be tested elsewhere
>though, with the result being the condition here.
>
>  Maciej
>
>  
>

While this is at least no worse in the nested fault case than earlier 
kernels, I really wish I had one of those weird 486s so I could test the 
faulting mechanism.  It seems the trap handling code has gotten quite 
complicated now, with notifiers adding nice functionality, but making 
the ordering of potential fault paths difficult to reason about (in 
particular when considering functionality like kexec, kprobes, NMIs and 
friends).

Zach

--------------070409040600000208020207
Content-Type: text/plain;
 name="cr4-is-valid-on-some-486s"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cr4-is-valid-on-some-486s"

So some 486 processors do have CR4 register.  Allow them to present it in
register dumps by using the old fault technique rather than testing processor
family.

Thanks to Maciej for noticing this.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14-zach-work/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/kernel/process.c	2005-11-05 01:19:21.000000000 -0800
+++ linux-2.6.14-zach-work/arch/i386/kernel/process.c	2005-11-05 03:02:21.000000000 -0800
@@ -314,9 +314,7 @@ void show_regs(struct pt_regs * regs)
 	cr0 = read_cr0();
 	cr2 = read_cr2();
 	cr3 = read_cr3();
-	if (current_cpu_data.x86 > 4) {
-		cr4 = read_cr4();
-	}
+	cr4 = read_cr4_safe();
 	printk("CR0: %08lx CR2: %08lx CR3: %08lx CR4: %08lx\n", cr0, cr2, cr3, cr4);
 	show_trace(NULL, &regs->esp);
 }
Index: linux-2.6.14-zach-work/include/asm-i386/system.h
===================================================================
--- linux-2.6.14-zach-work.orig/include/asm-i386/system.h	2005-11-05 01:11:32.000000000 -0800
+++ linux-2.6.14-zach-work/include/asm-i386/system.h	2005-11-05 03:06:57.000000000 -0800
@@ -97,6 +97,19 @@ extern struct task_struct * FASTCALL(__s
 		:"=r" (__dummy)); \
 	__dummy; \
 })
+
+#define read_cr4_safe() ({			      \
+	unsigned int __dummy;			      \
+	/* This could fault if %cr4 does not exist */ \
+	__asm__("1: movl %%cr4, %0		\n"   \
+		"2:				\n"   \
+		".section __ex_table,\"a\"	\n"   \
+		".long 1b,2b			\n"   \
+		".previous			\n"   \
+		: "=r" (__dummy): "0" (0));	      \
+	__dummy;				      \
+})
+
 #define write_cr4(x) \
 	__asm__ __volatile__("movl %0,%%cr4": :"r" (x));
 #define stts() write_cr0(8 | read_cr0())

--------------070409040600000208020207--
