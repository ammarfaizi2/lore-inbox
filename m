Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422657AbWI2VW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422657AbWI2VW2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 17:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422635AbWI2VW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 17:22:28 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:32399 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1422657AbWI2VW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 17:22:27 -0400
Date: Fri, 29 Sep 2006 23:14:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Jim Cromie <jim.cromie@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [patch] fix !apic build breakage
Message-ID: <20060929211417.GA11834@elte.hu>
References: <20060928014623.ccc9b885.akpm@osdl.org> <200609292236.15330.ak@suse.de> <20060929203227.GA5051@elte.hu> <200609292258.24546.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609292258.24546.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> > 63K???? You've got to be kidding. That's huge. That's ~10% of the 
> > minconfig kernel. 
> 
> A large part of it is the ACPI support. Without that it's smaller:
> 
>    text    data     bss     dec     hex filename
> 2978333  640752  416100 4035185  3d9271 obj32-up-noacpi/vmlinux
> 2947808  612088  400292 3960188  3c6d7c obj32-up-noacpi-noapic/vmlinux
> 
> ~30k

that's still huge! The patch below fixes the panic_on_unrecovered_nmi 
thing ...

> You might be able to do without ACPI on your embedded system.

of course many people do.

> > Even 1K would be bad. We did config hacks for half a K  
> > win. 
> 
> <rant>
> 
> Sorry, but that's silly. I did some measurements and just tweaking a 
> few dynamic allocation pigs saves you much more memory without 
> uglifying the code. In fact in most configurations you can find 
> dynamic users who need more than the complete kernel text - this means 
> even if you got the kernel text down to 0 bytes you wouldn't save as 
> much as simple tweaks in the dynamic pig.

so please do it. The fact that there are /other/ reductions possible 
doesnt mean we can be lax. It's like: "oh, the buddy allocator scales 
better now, so we can slow down the SLAB allocator". No, kernel size is 
like scalability: we need a million small steps.

the panic_on_unrecovered_nmi thing is gross anyway: it has no place in 
kernel.h, it should go into include/[asm-i386|x86_64]/nmi.h and not the 
generic headers. There the prototype can be made #ifdef APIC, hence 
eliminating the #ifdefs from traps.c. (that's all we care about anyway)

please dont throw away a perfectly fine config option.

	Ingo

---------------->
From: Ingo Molnar <mingo@elte.hu>
Subject: fix !apic build breakage

fix !apic build breakage.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux-hrt-mm.q/arch/i386/kernel/traps.c
===================================================================
--- linux-hrt-mm.q.orig/arch/i386/kernel/traps.c
+++ linux-hrt-mm.q/arch/i386/kernel/traps.c
@@ -709,8 +709,10 @@ mem_parity_error(unsigned char reason, s
 		"CPU %d.\n", reason, smp_processor_id());
 	printk(KERN_EMERG "You probably have a hardware problem with your RAM "
 			"chips\n");
+#ifdef CONFIG_X86_LOCAL_APIC
 	if (panic_on_unrecovered_nmi)
                 panic("NMI: Not continuing");
+#endif
 
 	printk(KERN_EMERG "Dazed and confused, but trying to continue\n");
 
@@ -749,8 +751,10 @@ unknown_nmi_error(unsigned char reason, 
 	printk(KERN_EMERG "Uhhuh. NMI received for unknown reason %02x on "
 		"CPU %d.\n", reason, smp_processor_id());
 	printk(KERN_EMERG "Do you have a strange power saving mode enabled?\n");
+#ifdef CONFIG_X86_LOCAL_APIC
 	if (panic_on_unrecovered_nmi)
                 panic("NMI: Not continuing");
+#endif
 
 	printk(KERN_EMERG "Dazed and confused, but trying to continue\n");
 }
