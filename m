Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265841AbSKFTJi>; Wed, 6 Nov 2002 14:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266040AbSKFTJi>; Wed, 6 Nov 2002 14:09:38 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:17802 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265841AbSKFTJ3>; Wed, 6 Nov 2002 14:09:29 -0500
Date: Wed, 06 Nov 2002 12:11:09 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: jejb@steeleye.com, Andrew Morton <akpm@zip.com.au>, dipankar@in.ibm.com
Subject: Strange panic as soon as timer interrupts are enabled (recent 2.5)
Message-ID: <116630000.1036613469@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had this strange panic on and off and since about 2.5.43-mm3.
Attempts to binary chop-search it down to a particular patch have
failed ... removing one of several patches will make it go away,
or changing the config file (sometimes). In general, it seems that
just jiggling things around makes it disappear or reappear, which
is extrememly frustrating. It's also been hard to get some comprehensible
data out of it, as all the CPUs spew data onto the console simultaneously,
thus making everything unreadable.

OK, so basically it panics when I'm setting up the IO-APIC ... seems
that as soon as the timer interrupt is enabled, and a non-boot CPU
cops the first timer interrupt, it gets confused. We're in do_IRQ,
inside irq_exit at the time (below is some debug from do_IRQ).
Seems as though irq_exit decides that there's a pending softirq, which
it decices to process, we go into tasklet_hi_action, and in there we
call t->func, which seems to contain garbage?

Oh, this is a 16 cpu NUMA-Q box. Happens on 2.5.45 and 2.5.46 mainline,
2.5.43-mm3, 2.5.44-mm1,mm2,mm6 ... but doesn't seem to be tied to any
one patch, hence me trying to work out the real cause instead.

Conversations on IRC revealed that jejb has hit the same thing on 
voyager ... as I understood him, he felt the cause was the CPU was 
taking an interrupt before cpu_up was called, and the interrupt was 
going back through a non existent tasklet structure (tasklets now 
have per_cpu areas which are allocated as the cpu comes up) I'll let
him discuss what he did to fix that, but the ensuing discussion made
me think that taking this out to a wider audience for an appropriate
long-term solution would be prudent.

Thanks,

M.

do_IRQ: cpu 1, irq 0, irq_desc c02c3800, desc c02c3800
Call Trace:
 [<c0108f2c>] do_IRQ+0x6c/0x1b0
 [<c01078cc>] common_interrupt+0x18/0x20
 [<c0118bc8>] _call_console_drivers+0x50/0x58
 [<c0118ca9>] call_console_drivers+0xd9/0xe0
 [<c0118ee2>] release_console_sem+0x42/0xa4

Call Trace:
 [<c0108f48>] do_IRQ+0x88/0x1b0
 [<c01078cc>] common_interrupt+0x18/0x20
 [<c0118bc8>] _call_console_drivers+0x50/0x58
 [<c0118ca9>] call_console_drivers+0xd9/0xe0
 [<c0118ee2>] release_console_sem+0x42/0xa4

do_IRQ before irq_exit cpu 1, id 1
preempt_count = 00010000, in_interrupt = 00010000, softirq_pending = 17
Call Trace:
 [<c0109016>] do_IRQ+0x156/0x1b0
 [<c01078cc>] common_interrupt+0x18/0x20
 [<c0118bc8>] _call_console_drivers+0x50/0x58
 [<c0118ca9>] call_console_drivers+0xd9/0xe0
 [<c0118ee2>] release_console_sem+0x42/0xa4

Unable to handle kernel paging request at virtual address ffffff97
 printing eip:
ffffff97
*pde = 00000000
Oops: 0000
 
CPU:    1
EIP:    0060:[<ffffff97>]    Not tainted
EFLAGS: 00010286
EIP is at E ipv4_config+0x3fc828af/0xffe42c88
eax: 00000000   ebx: c3934940   ecx: c031f178   edx: 036147a0
esi: 00000000   edi: f019c000   ebp: 00000001   esp: f019def0
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 0, threadinfo=f019c000 task=f01c5740)
Stack: f019c000 00000000 00000001 f019df10 c3934940 036147a0 c031f178 00000000 
       c011d8b5 00000000 00000011 c02db960 ffffffee 00000020 c031f178 c031f178 
       c011d5ba c02db960 f019c000 00000000 c02aff00 f019df64 00000046 c010904d 
Call Trace:
 [<c011d8b5>] tasklet_hi_action+0x85/0xe0
 [<c011d5ba>] do_softirq+0x5a/0xac
 [<c010904d>] do_IRQ+0x18d/0x1b0
 [<c01078cc>] common_interrupt+0x18/0x20
 [<c0118bc8>] _call_console_drivers+0x50/0x58
 [<c0118ca9>] call_console_drivers+0xd9/0xe0
 [<c0118ee2>] release_console_sem+0x42/0xa4

-------------------------------------

(gdb) disassemble tasklet_hi_action
0xc011d830 <tasklet_hi_action>: sub    $0x8,%esp
0xc011d833 <tasklet_hi_action+3>:       push   %ebp
0xc011d834 <tasklet_hi_action+4>:       push   %edi
0xc011d835 <tasklet_hi_action+5>:       push   %esi
0xc011d836 <tasklet_hi_action+6>:       push   %ebx
0xc011d837 <tasklet_hi_action+7>:       cli    
0xc011d838 <tasklet_hi_action+8>:       mov    $0xc031f178,%ecx
0xc011d83d <tasklet_hi_action+13>:      mov    $0xffffe000,%ebx
0xc011d842 <tasklet_hi_action+18>:      and    %esp,%ebx
0xc011d844 <tasklet_hi_action+20>:      mov    0xc(%ebx),%eax
0xc011d847 <tasklet_hi_action+23>:      shl    $0x2,%eax
0xc011d84a <tasklet_hi_action+26>:      mov    $0xc0321000,%ebp
0xc011d84f <tasklet_hi_action+31>:      mov    (%eax,%ebp,1),%edx
0xc011d852 <tasklet_hi_action+34>:      mov    $0xc031f178,%eax
0xc011d857 <tasklet_hi_action+39>:      mov    (%edx,%ecx,1),%esi
0xc011d85a <tasklet_hi_action+42>:      movl   $0x0,(%edx,%eax,1)
0xc011d861 <tasklet_hi_action+49>:      sti    
0xc011d862 <tasklet_hi_action+50>:      test   %esi,%esi
0xc011d864 <tasklet_hi_action+52>:
    je     0xc011d908 <tasklet_hi_action+216>
0xc011d86a <tasklet_hi_action+58>:      mov    $0xc031f178,%eax
0xc011d86f <tasklet_hi_action+63>:      mov    %eax,0x14(%esp,1)
0xc011d873 <tasklet_hi_action+67>:      mov    $0xc031f178,%eax
0xc011d878 <tasklet_hi_action+72>:      mov    %ebx,%edi
0xc011d87a <tasklet_hi_action+74>:      mov    $0x1,%ebp
0xc011d87f <tasklet_hi_action+79>:      mov    %eax,0x10(%esp,1)
0xc011d883 <tasklet_hi_action+83>:      mov    %esi,%ebx
0xc011d885 <tasklet_hi_action+85>:      mov    (%esi),%esi
0xc011d887 <tasklet_hi_action+87>:      lock bts %ebp,0x4(%ebx)
0xc011d88c <tasklet_hi_action+92>:      sbb    %eax,%eax
0xc011d88e <tasklet_hi_action+94>:      test   %eax,%eax
0xc011d890 <tasklet_hi_action+96>:
    jne    0xc011d8c6 <tasklet_hi_action+150>
0xc011d892 <tasklet_hi_action+98>:      mov    0x8(%ebx),%eax
0xc011d895 <tasklet_hi_action+101>:     test   %eax,%eax
0xc011d897 <tasklet_hi_action+103>:
    jne    0xc011d8c0 <tasklet_hi_action+144>
0xc011d899 <tasklet_hi_action+105>:     lock btr %eax,0x4(%ebx)
0xc011d89e <tasklet_hi_action+110>:     sbb    %eax,%eax
0xc011d8a0 <tasklet_hi_action+112>:     test   %eax,%eax
0xc011d8a2 <tasklet_hi_action+114>:
    jne    0xc011d8ac <tasklet_hi_action+124>
0xc011d8a4 <tasklet_hi_action+116>:     ud2a   
0xc011d8a6 <tasklet_hi_action+118>:     fild   (%eax)
0xc011d8a8 <tasklet_hi_action+120>:     in     (%dx),%eax
0xc011d8a9 <tasklet_hi_action+121>:     push   %eax
0xc011d8aa <tasklet_hi_action+122>:     and    %al,%al
0xc011d8ac <tasklet_hi_action+124>:     mov    0x10(%ebx),%eax
0xc011d8af <tasklet_hi_action+127>:     push   %eax
0xc011d8b0 <tasklet_hi_action+128>:     mov    0xc(%ebx),%eax
0xc011d8b3 <tasklet_hi_action+131>:     call   *%eax
0xc011d8b5 <tasklet_hi_action+133>:     add    $0x4,%esp
0xc011d8b8 <tasklet_hi_action+136>:     lock btrl $0x1,0x4(%ebx)
0xc011d8be <tasklet_hi_action+142>:
    jmp    0xc011d900 <tasklet_hi_action+208>
0xc011d8c0 <tasklet_hi_action+144>:     lock btrl $0x1,0x4(%ebx)
0xc011d8c6 <tasklet_hi_action+150>:     cli    
0xc011d8c7 <tasklet_hi_action+151>:     mov    0xc(%edi),%edx
0xc011d8ca <tasklet_hi_action+154>:     mov    0x14(%esp,1),%eax
0xc011d8ce <tasklet_hi_action+158>:     shl    $0x2,%edx
0xc011d8d1 <tasklet_hi_action+161>:     add    0xc0321000(%edx),%eax
0xc011d8d7 <tasklet_hi_action+167>:     mov    (%eax),%eax
0xc011d8d9 <tasklet_hi_action+169>:     mov    %eax,(%ebx)
0xc011d8db <tasklet_hi_action+171>:     mov    0xc(%edi),%edx
0xc011d8de <tasklet_hi_action+174>:     mov    0x10(%esp,1),%eax
0xc011d8e2 <tasklet_hi_action+178>:     shl    $0x2,%edx
0xc011d8e5 <tasklet_hi_action+181>:     add    0xc0321000(%edx),%eax
0xc011d8eb <tasklet_hi_action+187>:     mov    %ebx,(%eax)
0xc011d8ed <tasklet_hi_action+189>:     mov    0xc(%edi),%eax
0xc011d8f0 <tasklet_hi_action+192>:     shl    $0x5,%eax
0xc011d8f3 <tasklet_hi_action+195>:     orb    $0x1,0xc034bc00(%eax)
0xc011d8fa <tasklet_hi_action+202>:     sti    
0xc011d8fb <tasklet_hi_action+203>:     nop    
0xc011d8fc <tasklet_hi_action+204>:     lea    0x0(%esi,1),%esi
0xc011d900 <tasklet_hi_action+208>:     test   %esi,%esi
0xc011d902 <tasklet_hi_action+210>:
    jne    0xc011d883 <tasklet_hi_action+83>
0xc011d908 <tasklet_hi_action+216>:     pop    %ebx
0xc011d909 <tasklet_hi_action+217>:     pop    %esi
0xc011d90a <tasklet_hi_action+218>:     pop    %edi
0xc011d90b <tasklet_hi_action+219>:     pop    %ebp
0xc011d90c <tasklet_hi_action+220>:     pop    %ecx
0xc011d90d <tasklet_hi_action+221>:     pop    %edx
0xc011d90e <tasklet_hi_action+222>:     ret    
0xc011d90f <tasklet_hi_action+223>:     nop    
End of assembler dump.


