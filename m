Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276170AbRI1RPk>; Fri, 28 Sep 2001 13:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276177AbRI1RPb>; Fri, 28 Sep 2001 13:15:31 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:61865 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S276170AbRI1RPY>; Fri, 28 Sep 2001 13:15:24 -0400
Date: Fri, 28 Sep 2001 10:23:17 -0700
From: "Martin J. Bligh" <fletch@aracnet.com>
Reply-To: "Martin J. Bligh" <fletch@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Adding a printk in start_secondary breaks 2.4.10, not 2.4.9 ??
Message-ID: <945217781.1001672597@[10.10.1.2]>
X-Mailer: Mulberry/2.0.5 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I add a couple of printks to the latter part of start_secondary
on 2.4.10, and I enable serial console, I get a garbled panic.
This worked fine on 2.4.9 - can anyone give me any idea why
it broke on 2.4.10?

This is error is on a normal SMP box, not just a NUMA system
with wierd patches ;-)

(I need the printks for some arcane and disgusting reasons.
Without them, the multiquad NUMA machines die with an
undiagnosable BINT error - I have no idea why ... maybe
the console_lock serialises some action of the procs?)

Thanks,

Martin.

The patch
========

  int __init start_secondary(void *unused)
  {
        /*
         * Dont put anything before smp_callin(), SMP
         * booting is too fragile that we want to limit the
         * things done here to the most necessary things.
         */
        cpu_init();
        smp_callin();
        while (!atomic_read(&smp_commenced))
                rep_nop();
        /*
         * low-memory mappings have been cleared, flush them from
         * the local TLBs too.
         */
+       printk("Before tlbflush - processor: \n");
        local_flush_tlb();
+       printk("After tlbflush - processor: \n");

        return cpu_idle();
  }

The panic
========

Before tlbf2.4
-Based upon Swansea University C- processor: 6
NBT3.039
bUnable to hcessor: 7
l NULL pointer dereferencer at virtual address 00000050
.10 enting eip:
2c0114214
us=2
= 00000000
cOops: 0000
 type 1
1
I: Probing010:[<ardware
]
 CI: SeaS: 000 for i450NX host bridges on 00:10.0
 Unknown00000040   edx: c025b440
nesi: c0279550   edi: 00000IRQ transform: 5f1c   ,P0) -> 23
0
Ids: 0018PPB(B1,I12,P ) to get irqPr0
sPCIwapper (pid: 1, form: (B2,I4,P0) -> 40
                                          StPCI: u000002PB(Bc02795P1) to 
get irqffffffff -fffIC IRQ 00000040 : (B2,260 1) -> 39
P
 CI:       PP00000002,00000002 t irq 302 0PCI->APICf7ee6000 sform: 
(B2,f7ee2) -  f7ef5f28  usi       Bc0115,P3) t7ee4000 qf7e
                                             4000 -c0PIC IR  transfor 
:f7ef5fac 3c0105000 f7ef5f70 s[10Cal101f] for [<c0115a28>] 
[<c0116be7>rat[<c0105000>] I[<c01059faAfter tlbflush - proc
so   2
011bad8>] [<c0105000>] [<c0105626>] [<c011bad8>] [<c010507d>] [<c0105000>]
   [<c010562f>]

Code: 8b 4f 50 89 4d dc 8b 5d d0 8b 4d fc 89 5d d8 8b 41 28 a8 10
 <0>Kernel panic: Attempted to kill init!


