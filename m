Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbVJaLEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbVJaLEJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 06:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbVJaLEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 06:04:09 -0500
Received: from mail4.hitachi.co.jp ([133.145.228.5]:34225 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1750821AbVJaLEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 06:04:07 -0500
Message-ID: <4365FA24.7030207@sdl.hitachi.co.jp>
Date: Mon, 31 Oct 2005 20:04:04 +0900
From: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Satoshi Oshima <soshima@redhat.com>, Hideo Aoki <haoki@redhat.com>,
       Yumiko Sugita <sugita@sdl.hitachi.co.jp>, noboru.obata.ar@hitachi.com,
       systemtap@sources.redhat.com
Subject: [RFC][PATCH 0/3]Djprobe (Direct Jump Probe) for 2.6.14-rc5-mm1
Content-Type: multipart/mixed;
 boundary="------------010809030509090004050606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010809030509090004050606
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

I would like to propose djprobe (Direct Jump Probe) for low overhead
probing.
The djprobe is useful for the performance analysis function and the
kernel flight-recording function which constantly traces events in
the kernel. Because we should make their influence on performance as
small as possible.
Djprobe is a kind of probes in kernel like kprobes.
 It has some features:
- Jump instruction based probe. This is so fast.
- Non interruption.
- Safely code insertion on SMP.
- Lockless probe after registered.
I attached detailed document of djprobe to this mail. If you need
more information, please see it.

This djprobe is NOT a replacement of kprobes. Djprobe and kprobes
have complementary qualities. (ex: djprobe's overhead is low, and
kprobes can be inserted in anywhere.)
You can use both kprobes and djprobe as the situation demands.

I measured the overhead of the djprobe on Pentium4 3.06GHz PC by
using gtodbench (*). The result I got was about 100ns. In the view
of performance, I think djprobe is the best probe method. What would
you think about this?

(*)The gtodbench is micro benchmark which is included in published
djprobe source package. You can download it from LKST's web site:
http://prdownloads.sourceforge.net/lkst/djprobe-20050713.tar.bz2

The following three patches introduce djprobe (Direct Jump Probe)
to linux-2.6.14-rc5-mm1.
patch 1:    Introduce a instruction slot management structure to
            handle different size slots. (a patch for kprobes)
patch 2:    Djprobe core (arch-independant) patch.
patch 3:    Djprobe i386 (arch-dependant) patch.

Please try to use djprobe.

Any comments or suggestions are welcome.

Best regards,

-- 
Masami HIRAMATSU
2nd Research Dept.
Hitachi, Ltd., Systems Development Laboratory
E-mail: hiramatu@sdl.hitachi.co.jp

--------------010809030509090004050606
Content-Type: text/plain;
 name="djprobe.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="djprobe.txt"

Djprobe Documentation
authors: Satoshi Oshima (soshima@redhat.com)
         Masami Hiramatsu (hiramatu@sdl.hitachi.co.jp)

INDEX

1. Djprobe concepts
2. How djprobe works
3. Further Considerations
4. Djprobe Features
5. Architectures Supported
6. Configuring Djprobe
7. API Reference 
8. TODO
9. FAQ

1. Djprobe concepts

The basic idea of Djprobe is to dynamically hook at any kernel function 
entry points and collect the debugging or performance analysis information 
non-disruptively. The functionality of djprobe is very similar to Kprobe 
or Jprobe. The distinction of djprobe is to use jump instruction instead 
of break point instruction. This distinction reduces the overhead of each 
probe.

Developers can trap at almost any kernel function entry points, specifying 
a handler routine to be invoked when the jump instruction is executed.


2. How Djprobe works

Break point instruction is easily inserted on most architecture.
For example, binary size of break point instruction on i386 or x86_64 
architecture is 1 byte. 1 byte replacement is took place in single step.
And replacement with breakpoint instruction is guaranteed as SMP safe.

On the other hand jump instruction is not easily inserted. Binary size of 
jump instruction on i386 is 5 byte. 5 byte replacement cannot be executed 
in single step. And beyond that dynamic code modification has some 
complicated restriction.

To explain the djprobe mechanism, we introduce some terminology.
Image certain binary line which is constructed by 2 byte instruction, 
2byte instruction and 3byte instruction.

         IA
         | 
[-2][-1][0][1][2][3][4][5][6][7]
        [ins1][ins2][  ins3 ]
        [<-     DCR       ->]
           [<- JTPR ->]

ins1: 1st Instruction
ins2: 2nd Instruction
ins3: 3rd Instruction
IA:  Insertion Address
JTPR: Jump Target Prohibition Region
DCR: Detoured Code Region


The replacement procedure of djpopbes is 6 steps:

(1) copying instruction(s) in DCR
(2) putting break point instruction at IA
(3) scheduling works on each CPU
(4) executing CPU safety check on each work
(5) replacing original instruction(s) with jump instruction without
first byte and serializing code
(6) replacing break point instruction with first byte of jump instruction

Further explanation is given below.

(1) copying instruction(s) in DCR

Djprobe copies replaced instruction(s) to the region that djprobe allocates.
The replaced instructions must include the instruction that includes the byte 
at IA+4. Therefore the size of DCR must be 5 byte or more. The size of DCR 
must be given by djprobes user.

(2) putting break point instruction at IA

Djprobe replaces a break point instruction at Insertion Point. After this 
replacement, the djprobe act like kprobes.

(3) scheduling works on each CPU

Djprobe schedules work(s) that execute CPU safety check on each CPU, and wait 
till those works finished.

(4) executing CPU safety check on each work

Current Djprobe suppose that the context switch must NOT occur on extension 
of interruption, which means that every interruption must return before 
executing context switch.

Therefore, execution of scheduled works itself is the proof that every 
interruption stack (and every process stack) doesn't include any address 
in JTPR.

The last CPU that executes safety check work wakes the waiting process up.

(5) replacing original instruction(s) with jump instruction without first 
byte and serializing code

After all safety check works are scheduled, djprobe can replace the codes 
in JTPR safely. Because, now, any CPU is not executing JTPR. Even if a CPU 
tries to execute the instructions in the top of DCR again, the CPU is 
interrupted by kprobe and is led to execute the copied instructions. So 
any CPU does not touch the instructions in the JTPR.

Djprobe replaces the bytes in the area from IA+1 to IA+4 with jump 
instruction that doesn't contain first byte.
And it serializes the replaced code on every CPU.

(6) replacing breakpoint instruction with first byte of jump instruction

Djprobe replaces breakpoint instruction that is put by themselves with the 
first byte of jump instruction.


3. Further considerations

There are many difficulties on implementation of djprobe. In this section, 
we discuss restrictions of djprobe to understand these difficulties.

3.1 the way to confirm safety of DCR(dynamic analysis)

Djprobe tries to replace the code that includes one instruction or more.
This replacement usually accompanies changing the boundaries of instructions.
Therefore djprobe must ensure that the other CPUs don't execute DCR or every 
stack doesn't contain the address in JTPR.

3.2 confirmation of safety of DCR(static analysis)

Djprobe must also avoid JTPR must not be targeted by any jump or call 
instruction. Basically this must be extremely difficult to take place.
But some point such as function entry point can be expected that is not 
target of jump or call instruction (because function entry point contains 
fixed form that ensures the code convention.)

4. Djprobe Features

- Djprobe can probe entries of almost all functions without any interruption.

5. Architecture Supported

- i386


6. Configuring Djprobe
When configuring the kernel using make menuconfig/xconfig/oldconfig, ensure
that CONFIG_DJPROBE is set to "y".  Under "Instrumentation Support", 
look for "Direct Jump probe". You may have to enable "Kprobes" and to 
*DISABLE* "Preemptible Kernel".

7. API Reference 
The Djprobe API includes "register_djprobe" function and 
"unregister_djprobe" function. Here are specifications for these functions
and the associated probe handlers.

7.1 register_djprobe

#include <linux/djprobe.h>
int register_djprobe(struct djprobe *djp, void *addr, int size);

Inserts a jump instruction at the address addr. When the jump is
hit, Djprobe calls djp->handler.

register_djprobe() returns 0 on success, or a negative errno otherwise.

User's probe handler (djp->handler):
#include <linux/djprobe.h>
#include <linux/ptrace.h>
void handler(struct djprobe *djp, struct pt_regs *regs);

Called with p pointing to the djprobe associated with the probe point,
and regs pointing to the struct containing the registers saved when
the probe point was hit.

7.2 unregister_djprobe

#include <linux/djprobe.h>
void unregister_djprobe(struct djprobe *djp);

Removes the specified probe.  The unregister function can be called
at any time after the probe has been registered.


8. TODO

(1)support architecture transparent interface.
   (Djprobe interface emulated by kprobes)
(2)bulk registeration interface support
(3)kprobe interoperability (coexistance in same address)
(4)other architectures support

9. FAQ
Direct Jump Probe Q&A

Q: What is the Direct Jump Probe (Djprobe)?
A: Djprobe is a low overhead probe method for linux kernel. 

Q: What is different from Kprobes?
A: The most different feature is that the djprobe uses a jump instruction 
code instead of breakpoint instruction code. It can reduce overheads of 
probing especially when the probes are executed frequently.

Q: How does the djprobe work?
A: First, Djprobe copies some instructions modified by a jump instruction 
into the middle of a stub code buffer. Next, it overwrites the instructions 
with the jump instruction whose destination is the top of that stub code 
buffer. In the top of the stub code buffer, there is a call instruction 
which calls a probe function. And, in the bottom of the stub code buffer, 
there is a jump instruction whose destination is the next of the modified 
instructions. 
 On the other hand, Kprobe copies only one instruction which will be 
modified by breakpoint instruction, and overwrites it breakpoint 
instruction. When breakpoint interruption handling, it executes the copied 
instruction with the trap flag. When trap interruption handling, it 
corrects IP(*) for returning to the kernel code.
 So, djprobe's work sequence is "jump", "probe", "execute copies" and 
"jump", whereas kprobes' sequence is "break", "probe", "execute copies", 
and "trap".

(*)Instruction Pointer

Q: Does the djprobe need to modify kernel source code?
A: No. The djprobe is one of the dynamic probes. It can be inserted into 
running kernel.

Q: Can djprobe work with CPU-hotplug?
A: Yes, djprobe locks cpu-hotplug in the critical section.

Q: Where can the djprobe be inserted in?
A: Djprobe can be inserted in almost all kernel code including the head of 
almost kernel functions. The insertion area must satisfy the assumptions 
described below. 

(In i386 architecture)
         IA
         | 
[-2][-1][0][1][2][3][4][5][6][7]
        [ins1][ins2][  ins3 ]
        [<-     DCR       ->]
           [<- JTPR ->]

ins1: 1st Instruction
ins2: 2nd Instruction
ins3: 3rd Instruction
IA:  Insertion Address
DCR (Detoured Code Region): The area which is including the instructions 
whose first byte is in the range in 5 bytes (this size is from the size of 
jump instruction) from the insertion address. These instructions are copied 
into the middle of a stub code buffer.
JTPR (Jump Target Prohibition Region): The area which is including the 
codes among codes rewritten in the jump instruction by djprobe except the 
first one byte.

Assumptions:
i) The insertion address points the first byte of an instruction.
  This is for avoidance of a bad instruction exception.
ii) There are no instructions which refer IP (ex. relative jmp) in DCR.
  EIP has been changed when copied instruction is executed.
iii) There are no instructions which occur context-switch (ex. call 
     schedule()) in DCR.
  If a context-switch occurs in DCR, the next address of an instruction 
 (ex. the address of "ins2") is stored in the call stack of previous thread. 
 After that, djprobe overwrites the instruction with jump instruction. When 
 the previous thread switches back, it resumes execution from the stored 
 address. So it will cause a bad instruction exception.
 iv) Destination address of jump or call is not included in JTPR.
  This is for avoidance of a bad instruction exception too.

Q: Can several djprobes be inserted in the same address?
A: Yes. Several djprobes which are inserted in the same address are 
aggregated and share one instance. 
NOTE: When a new djprobe's insertion address is in another djprobe's JTPR 
(above described), or the another djprobe's insertion address is in the new 
djprobe's JTPR, register_djprobe() fails to register the new djprobe and 
returns -EEXIST error code.

Q: Can djprobe be used with kprobes in same address?
A: No, currently djprobe can not coexist with kprobes in same address. But 
we will support this feature as soon as possible.

Q: Should the jump instruction be with in a page boundary to avoid access 
 violation and page fault?
A: No. The x86 processors can handle non-aligned instructions correctly. We 
can see many non-aligned instructions in the kernel binary. And, in the 
kernel space, there is no page fault. Kernel code pages are always mapped 
to the kernel page table. 
So it is not necessary to care of page boundaries in x86 architecture.

Q: How does the djprobe resolve problems about self/cross-modifying code? 
 In Pentium Series, Unsynchronized cross-modifying code operations except 
 the first byte of an instruction can cause unexpected instruction 
 execution results.
A: Djprobe uses a trick code to resolve the problems. It modifies the 
 instructions as following.
1) Register special handler as a kprobe handler. (And a break point 
  instruction is written on the first byte of the insertion address by 
  kprobes.)
2) Check safety (this is described in the next question's answer).
3) Write only the destination address part of jump instruction on the 
  kernel code. (This operation is not synchronized)
4) Call "cpuid" on each processor for synchronization.
5) Write the first byte of the jump instruction. (This operation is 
  synchronized automatically)

Q: How does the djprobe guarantee no threads and no processors are  
 executing the modifying area? The IP of that area may be stored in the 
 stack memory of those threads.
A: The problem would be caused for three reasons:
 i) Problem caused by the multi processor system
  Another processor may be executing the area which is overwritten by jump 
 instruction. Djprobe should guarantee no processor is executing those 
 instructions when modify it.
 ii) Problem caused by the interruption
  An interruption might have occurred in the area which is going to be 
 overwritten by jump instruction. Djprobe should guarantee all 
 interruptions which occurred in the area have finished.
 iii) Problem caused by full preempt kernel
  In case of Problem (iii), it is described in the next question's answer. 

The Djprobe uses the workqueue to resolve Problem (i) and (ii). The 
solution is described below:
1) Copy the entire of the DCR (described above) into the middle of a stub 
 code buffer.
2) Register special handler as a kprobe handler. This special handler 
 changes kprobe's resume point to the stub code buffer. 
3) Clear the safety flags of all processors.
4) Register a safety checking work to the workqueue on each processor. And 
 wait till those works are scheduled.
5) When keventd thread is scheduled on a processor, it executes the work. 
 In this time, this processor is not executing the area which is 
 overwritten by jump instruction. And also it has finished all 
 interruptions. Because, in the case of voluntary preemption or non 
 preemption kernel, the context switch does not occur in the extension of 
 interruption. 
6) The all works are scheduled, djprobe writes the jump instruction.

Q: Can the djprobe work with kernel full preemption?
A: No, but you can use the djprobe's interface. When kernel full preemption 
 is enabled, we can't ensure that no threads are executing the modified 
 area. It may be stored in the stack of the threads. In this case, the 
 djprobe interfaces are emulated by using kprobe.
 The latest linux kernel supports not only full preemption but also the 
 voluntarily preemption. In the case of voluntarily preemption, threads 
 are scheduled from only limited addresses. So it is easy to check that 
 the preemption can not occur in the modified area.


--------------010809030509090004050606--
