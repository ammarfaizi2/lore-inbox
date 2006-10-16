Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161058AbWJPWR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161058AbWJPWR1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 18:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161138AbWJPWR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 18:17:27 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:58851 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1161058AbWJPWR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 18:17:26 -0400
Message-ID: <453404F6.5040202@vmware.com>
Date: Mon, 16 Oct 2006 15:17:26 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: caglar@pardus.org.tr
Cc: Gerd Hoffmann <kraxel@suse.de>, john stultz <johnstul@us.ibm.com>,
       Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Avoid PIT SMP lockups
References: <1160170736.6140.31.camel@localhost.localdomain> <1160592235.5973.5.camel@localhost.localdomain> <452DEEAB.3000403@suse.de> <200610121045.32846.caglar@pardus.org.tr>
In-Reply-To: <200610121045.32846.caglar@pardus.org.tr>
Content-Type: multipart/mixed;
 boundary="------------010600020702000108000206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010600020702000108000206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

S.Çag(lar Onur wrote:
> 12 Eki 2006 Per 10:28 tarihinde, Gerd Hoffmann s,unlar? yazm?s,t?: 
>   
>> Try switching the vmware configuration to "other OS".  This turns off
>> os-specific binary patching.  The alternatives code might have broken
>> assumptions vmware does about the linux kernel code ...
>>     
>
> I did before, i tried these combinations
>
> * Guest Os: Linux, Version: Other Linux 2.6.x kernel
> * Guest Os: Linux, Version: Other Linux
> * Guest Os: Other, Version: Other
>
> all of them ends up with panic.
>   

We don't do any binary patching. In general, most of the guest OS types 
turn on various performance hints or activate fairly expensive 
workarounds to known OS bugs, but they don't make the system less 
correct by limiting the functionality available to the OS kernel.

It sounds to me like an interrupt is firing in the alternatives code. 
Perhaps some callee is doing a raw local_irq_enable from somewhere 
inside here, or nobody took care to disable interrupts in the first 
place. You need to have interrupts disabled here.

OMG! When did we start calling alternative_instructions from init with 
_after_ local_irq_enable()? This is totally wrong. Even on native 
hardware, you can be hit with a timer interrupt in this window where we 
are patching the kernel. It does not surprise me that you hit this 
repeatedly. It surprises me that other people don't! The kernel has 
managed to take enough time to get from the last timer IRQ (likely in 
lpj calibration, as you noted in the output) to the alternative patching 
point that 90% of the time, another timer IRQ is pending. This can 
happen on any machine, not just VMware, and I'm surprised it doesn't 
happen with other emulators as well.

It might only happen with SMP because the difficulty of getting good 
enough TSC / timer IRQ synchronization during boot increases 
exponentially with SMP configurations. And it might pass 10% of the time 
because you were lucky enough not to fire off another timer interrupt yet.

My nasty quick patch might not apply - the only tree I've got is a very 
hacked 2.6.18-rc6-mm1+local-patches thing, but the fix should be obvious 
enough.

Zach

--------------010600020702000108000206
Content-Type: text/plain;
 name="hotfix-alternatives-irq-safety.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hotfix-alternatives-irq-safety.patch"

diff -r 2b8ef2e0e25f arch/i386/kernel/alternative.c
--- a/arch/i386/kernel/alternative.c	Mon Oct 16 02:30:58 2006 -0700
+++ b/arch/i386/kernel/alternative.c	Mon Oct 16 02:34:29 2006 -0700
@@ -389,6 +389,7 @@ extern struct paravirt_patch *__start_pa
 
 void __init alternative_instructions(void)
 {
+	unsigned long flags;
 	if (no_replacement) {
 		printk(KERN_INFO "(SMP-)alternatives turned off\n");
 		free_init_pages("SMP alternatives",
@@ -396,6 +397,8 @@ void __init alternative_instructions(voi
 				(unsigned long)__smp_alt_end);
 		return;
 	}
+
+	local_irq_save(flags);
 	apply_alternatives(__alt_instructions, __alt_instructions_end);
 
 	/* switch to patch-once-at-boottime-only mode and free the
@@ -433,4 +436,5 @@ void __init alternative_instructions(voi
		alternatives_smp_switch(0);
	}
#endif
-}
+	local_irq_restore(flags);
+}

--------------010600020702000108000206--
