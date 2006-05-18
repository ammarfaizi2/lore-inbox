Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWERQgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWERQgI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 12:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWERQgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 12:36:08 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:59264 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751373AbWERQgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 12:36:07 -0400
Date: Thu, 18 May 2006 12:35:42 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Morton Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Subject: [PATCH] i386 kdump boot cpu physical apicid fix
Message-ID: <20060518163542.GA20121@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sombody reported following BUG while testing kdump. Please find attached
the fix.

------------[ cut here ]------------
kernel BUG at arch/i386/kernel/apic.c:447!
invalid opcode: 0000 [#1]
Modules linked in:
CPU:    0
EIP:    0060:[<c100acc3>]    Not tainted VLI
EFLAGS: 00010246   (2.6.17-rc4-16M #5)
EIP is at setup_local_APIC+0x20/0x1a3
eax: 00000000   ebx: c4e61f88   ecx: 00000000   edx: 00000020
esi: 00050014   edi: c4e61f88   ebp: 00000000   esp: c4e61f5c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c4e60000 task=c1389a10)
Stack: <0>c4e61f88 c133dd44 c13264c0 00000001 00000000 00000000 00000000 00000000
       00000000 00000000 00000000 00000001 00000000 00000000 00000000 00000000
       00000000 00000000 00000000 c4e60000 00000000 c1000284 c1002342 c12a6260
Call Trace:
 <c13264c0> APIC_init_uniprocessor+0xa9/0xd8   <c1000284> init+0x28/0x1f6
 <c1002342> ret_from_fork+0x6/0x14   <c100025c> init+0x0/0x1f6
 <c100025c> init+0x0/0x1f6   <c1000ae5> kernel_thread_helper+0x5/0xb
Code: 9d 5b 5e c3 a1 18 1c 35 c1 eb e0 56 53 8b 35 30 d0 ff ff a1 20 d0 ff ff c1 e8 18 83 e0 0f 0f a3 05 80 d2 34 c1 19 c0 85 c0 75 08 <0f> 0b bf 01 9b 78 24 c1 c7 05 e0 d0 ff ff ff ff ff ff a1 d0 d0
EIP: [<c100acc3>] setup_local_APIC+0x20/0x1a3 SS:ESP 0068:c4e61f5c
 <0>Kernel panic - not syncing: Attempted to kill init!

=============================================================================


o Kdump second kernel boot fails after a system crash if second kernel
  is UP and acpi=off and if crash occurred on a non-boot cpu. 

o Issue here is that MP tables report boot cpu lapic id as 0 but second
  kernel is booting on a different processor and MP table data is stale
  in this context. Hence apic_id_registered() check fails in setup_local_APIC()
  when called from APIC_init_uniprocessor(). 

o Problem is not seen if ACPI is enabled as in that case
  boot_cpu_physical_apicid is read from the LAPIC.

o Problem is not seen with SMP kernels as well because in this case also
  boot_cpu_physical_apicid is read from LAPIC. (smp_boot_cpus()).

o This patch fixes the problem by reading the boot_cpu_physical_apicid
  from LAPIC for all the cases hence bringing uniformity. At the same time
  reading from LAPIC should be more reliable then trusting MP tables. My
  understanding is that MP tables are anyway becoming a thing of past.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/kernel/apic.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff -puN arch/i386/kernel/apic.c~kdump-i386-boot-cpu-physical-apicid-fix arch/i386/kernel/apic.c
--- linux-2.6.17-rc4-16M/arch/i386/kernel/apic.c~kdump-i386-boot-cpu-physical-apicid-fix	2006-05-17 13:27:44.000000000 -0400
+++ linux-2.6.17-rc4-16M-root/arch/i386/kernel/apic.c	2006-05-18 05:11:44.000000000 -0400
@@ -860,12 +860,7 @@ void __init init_apic_mappings(void)
 	printk(KERN_DEBUG "mapped APIC to %08lx (%08lx)\n", APIC_BASE,
 	       apic_phys);
 
-	/*
-	 * Fetch the APIC ID of the BSP in case we have a
-	 * default configuration (or the MP table is broken).
-	 */
-	if (boot_cpu_physical_apicid == -1U)
-		boot_cpu_physical_apicid = GET_APIC_ID(apic_read(APIC_ID));
+	boot_cpu_physical_apicid = GET_APIC_ID(apic_read(APIC_ID));
 
 #ifdef CONFIG_X86_IO_APIC
 	{
_
