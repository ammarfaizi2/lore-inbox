Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272764AbTHKPeS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 11:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272765AbTHKPeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 11:34:18 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:62223 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S272764AbTHKPeN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:34:13 -0400
Date: Mon, 11 Aug 2003 17:33:53 +0200
From: Willy Tarreau <willy@w.ods.org>
To: davej@redhat.com, marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH-2.4] Disable APIC on reboot.
Message-ID: <20030811153353.GA2751@alpha.home.local>
References: <E19mCuO-0003dI-00@tetrachloride>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19mCuO-0003dI-00@tetrachloride>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

This patch allows my VAIO to reboot with LOCAL_APIC enabled. I too have a
broken BIOS which cannot put hardware into a sane state at boot, and it hangs
on IDE detection if the kernel left LOCAL_APIC enabled. Now with this patch
upon 2.4.22-rc2, it's OK, so I can enable LOCAL_APIC again. Do you find it too
late for 2.4.22 ? Depending on how we see it, it may be considered as a
workaround for broken BIOSes, or as a bugfix for a kernel which didn't restore
hardware into its original state. Or at least, please accept it for 2.4.23-pre1.

I rediffed it against 2.4.22-rc2, and attached the patch at the end of this
mail.

Cheers,
Willy

On Mon, Aug 11, 2003 at 02:40:24PM +0100, davej@redhat.com wrote:
> Forward port of a patch from Felix [surname mangled by MTA] <fxkuehl@gmx.de>
> 
> Original mail:-
> 
> when I reboot my laptop the BIOS complains about a keyboard controller
> failure and timer interrupts not working. On the BIOS password screen
> the keyboard doesn't work. If I disable the BIOS password the system
> hangs a bit later on the POST screen. I tried all reboot methods via the
> kernel command line without success. I saw this problem with Debian
> Woody's precompiled 2.4.18 kernel, self compiled Debian 2.4.20 sources
> and Linux 2.4.21-rc1+ACPI patch. This problem only occurs if
> CONFIG_X86_LOCAL_APIC is enabled. With CONFIG_X86_LOCAL_APIC disabled it
> reboots just fine.
> 
> My guess is that it's a BIOS bug as I've never had this problem on other
> machines before. I found a workaround: disable the local APIC before
> rebooting. I don't really know how it works. Just calling
> disable_local_APIC wasn't enough, so I copied a bit more code from
> apic_pm_suspend (arch/i386/kernel/apic.c:465) to machine_restart
> (arch/i386/kernel/process.c:369). I'm pretty sure that this is not the
> proper way to do it but it works here. A patch against 2.4.21-rc1 can be
> found at the end of this email.
> 

--- linux-2.4.22-rc2/arch/i386/kernel/process.c	Wed Jul 30 09:18:21 2003
+++ linux-2.4.22-rc2-lapic/arch/i386/kernel/process.c	Mon Aug 11 17:18:57 2003
@@ -42,6 +42,7 @@
 #include <asm/processor.h>
 #include <asm/i387.h>
 #include <asm/irq.h>
+#include <asm/apic.h>
 #include <asm/desc.h>
 #include <asm/mmu_context.h>
 #ifdef CONFIG_MATH_EMULATION
@@ -400,6 +401,17 @@
 	 */
 	smp_send_stop();
 	disable_IO_APIC();
+#elif CONFIG_X86_LOCAL_APIC
+	{
+		unsigned int l, h;
+
+		local_irq_disable();
+		disable_local_APIC();
+		rdmsr(MSR_IA32_APICBASE, l, h);
+		l &= ~MSR_IA32_APICBASE_ENABLE;
+		wrmsr(MSR_IA32_APICBASE, l, h);
+		local_irq_enable();
+	}
 #endif
 
 	if(!reboot_thru_bios) {

