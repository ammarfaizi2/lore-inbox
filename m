Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268129AbUHQHGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268129AbUHQHGl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 03:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268128AbUHQHGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 03:06:41 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:49096 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S268132AbUHQHGG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 03:06:06 -0400
Subject: Re: 2.6.8.1-mm1
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Zwane Mwaikambo <zwane@linuxpower.ca>
In-Reply-To: <20040816143710.1cd0bd2c.akpm@osdl.org>
References: <20040816143710.1cd0bd2c.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1092726346.3081.145.camel@booger>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 17 Aug 2004 02:05:46 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> i386-hotplug-cpu.patch
>   i386 Hotplug CPU

i386 seems to want something like this to avoid crashing in
find_busiest_group... looks like there's a short window in fixup_irqs
where interrupts are enabled while we're taking a cpu down.

Unable to handle kernel NULL pointer dereference at virtual address 00000008    
 printing eip:                                                                  
c011eb2d                                                                        
*pde = 00000000                                                                 
Oops: 0000 [#1]                                                                 
SMP                                                                             
Modules linked in:                                                              
CPU:    1                                                                       
EIP:    0060:[<c011eb2d>]    Not tainted VLI                                    
EFLAGS: 00010002   (2.6.8.1-mm1)                                                
EIP is at find_busiest_group+0x1cd/0x350                                        
eax: db4cfec0   ebx: 00000000   ecx: 00000080   edx: 00000000                   
esi: 0000007d   edi: c05d3460   ebp: db4cfea0   esp: db4cfe54                   
ds: 007b   es: 007b   ss: 0068                                                  
Process kstopmachine (pid: 3527, threadinfo=db4cf000 task=c157a030)             
Stack: c014cb31 dff9bba0 c05b7000 00000000 00000001 00000080 00000000 00004000  
       00000080 c05d346c 00000000 c05d3460 db4cfec0 00000001 c14119e0 00000001  
       c14119e0 c1410f60 00000001 db4cfedc c011edad 00000001 dfb70130 dfb70130  
Call Trace:                                                                     
 [<c010815a>] show_stack+0x7a/0x90                                              
 [<c01082e2>] show_registers+0x152/0x1c0                                        
 [<c0108501>] die+0x101/0x1e0                                                   
 [<c011be11>] do_page_fault+0x301/0x5d1                                         
 [<c0107d4d>] error_code+0x2d/0x38                                              
 [<c011edad>] load_balance+0x3d/0x280                                           
 [<c011f381>] rebalance_tick+0xa1/0xb0                                          
 [<c011f4a1>] scheduler_tick+0x111/0x4c0                                        
 [<c0118612>] smp_apic_timer_interrupt+0xe2/0xf0                                
 [<c0107cd2>] apic_timer_interrupt+0x1a/0x20                                    
 [<c0117e66>] __cpu_disable+0x16/0x30                                           
 [<c013d654>] take_cpu_down+0x24/0x50                                           
 [<c0143b53>] do_stop+0x63/0x70                                                 
 [<c013c1a5>] kthread+0xa5/0xb0                                                 
 [<c0105375>] kernel_thread_helper+0x5/0x10                                     
Code: 02 0f af d6 39 d0 0f 86 05 01 00 00 8b 5d cc 89 ca 8b 45 d4 29 da 29 c8 39
 c2 0f 47 d0 8b 45 e4 89 10 8b 5d e0 8b 4b 08 8b 5d dc <8b> 43 08 39 c8 0f 47 c1
 0f af c2 8b 55 e4 c1 e8 07 83 f8 7e 89

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>

Index: 2.6.8.1-mm1/arch/i386/kernel/apic.c
===================================================================
--- 2.6.8.1-mm1.orig/arch/i386/kernel/apic.c
+++ 2.6.8.1-mm1/arch/i386/kernel/apic.c
@@ -1138,7 +1138,8 @@
 	 * interrupt lock, which is the WrongThing (tm) to do.
 	 */
 	irq_enter();
-	smp_local_timer_interrupt(&regs);
+	if (!cpu_is_offline(cpu))
+		smp_local_timer_interrupt(&regs);
 	irq_exit();
 }
 


