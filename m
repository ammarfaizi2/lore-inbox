Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266820AbUIMOJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266820AbUIMOJe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 10:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266802AbUIMOJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 10:09:33 -0400
Received: from [209.88.178.130] ([209.88.178.130]:5884 "EHLO constg.qlusters")
	by vger.kernel.org with ESMTP id S266820AbUIMOF6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 10:05:58 -0400
Message-ID: <4145A8E1.8010409@qlusters.com>
Date: Mon, 13 Sep 2004 17:04:17 +0300
From: Constantine Gavrilov <constg@qlusters.com>
Reply-To: Constantine Gavrilov <constg@qlusters.com>
Organization: Qlusters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bugs@x86-64.org, linux-kernel@vger.kernel.org
Subject: Calling syscalls from x86-64 kernel results in a crash on Opteron
 machines
Content-Type: multipart/mixed;
 boundary="------------050603000600000103030405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050603000600000103030405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello:

We have a piece of kernel code that calls some system calls in kernel 
context (from a process with mm and a daemonized kernel thread that does 
not have mm). This works fine on IA64 and i386 architectures.

When I try this on x86-64 kernel on Opteron machines, it results in 
immediate crash. I have tried standard _syscall() macros from 
asm/unistd.h. The system panics when returning from the system call.
The disassembled code shows that gcc has often a hard time deciding 
which registers (32-bit or 64-bit) it will use. For example, it puts the 
system call number to eax, while it should put it to rax. However, this 
register thing is not a problem. I have tried my own gcc hand-crafted 
inline assembly and glibc inline syscall assembly that results in 
"correct" disassembled code. The result is always the same -- kernel 
crash when calling a function defined by _syscall() macros or when using 
an "inline" block defined by glibc macros.

Attached please find a test module that tries to call the umask() (JUST 
TO DEMONSTRATE a problem) via the syscall machanism. Both methods (the 
_syscall1() marco and GLIBC INLINE_SYCALL() were used.

The assembly dump of the umask() called via _syscall(1) and via 
INLINE_SYSCALL() as well as the disassembly of umask() from glibc are 
provided in a separate attachement. The crash dump (captured with a 
serial console) is provided along with disassembly of the main module 
function.

It seems that segmentation is changed during the syscall and not 
restored properly, or some other REALLY BAD THING happens. The entry.S 
for x86_64 architecture is very informative, but I am not an expert in 
Opteron architecture and I do not know how the syscall instruction is 
supposed to work.

Can someone explain the reason for the crash? Can you think of a 
workaround? Comments and ideas are very welcome (except of the kind that 
it can be implemented in the user space or with a help of a user proxy 
process).

Thanks. Please CC to me. I am not subscribed to the lists.

Additional info:
uname -a
Linux dev83 2.4.21-4.ELsmp #1 SMP Fri Oct 3 17:32:58 EDT 2003 x86_64 
x86_64 x86_64 GNU/Linux

cat /proc/cpuinfo:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 240
stepping        : 1
cpu MHz         : 1394.254
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov
pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext 3dnow
bogomips        : 2778.72
TLB size        : 1088 4K pages
clflush size    : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts ttp

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 240
stepping        : 1
cpu MHz         : 1394.254
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov 
          pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 
3dnowext 3dnow
bogomips        : 2785.28
TLB size        : 1088 4K pages
clflush size    : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts ttp


  cat /proc/meminfo
         total:    used:    free:  shared: buffers:  cached:
Mem:  6137491456 84901888 6052589568        0 12132352 22863872
Swap: 1048698880        0 1048698880
MemTotal:      5993644 kB
MemFree:       5910732 kB
MemShared:           0 kB
Buffers:         11848 kB
Cached:          22328 kB
SwapCached:          0 kB
Active:          37588 kB
ActiveAnon:       7232 kB
ActiveCache:     30356 kB
Inact_dirty:      3816 kB
Inact_laundry:       0 kB
Inact_clean:         0 kB
Inact_target:     8280 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      5993644 kB
LowFree:       5910732 kB
SwapTotal:     1024120 kB
SwapFree:      1024120 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB



-- 
----------------------------------------
Constantine Gavrilov
Kernel Developer
Qlusters Software Ltd
1 Azrieli Center, Tel-Aviv
Phone: +972-3-6081977
Fax:   +972-3-6081841
----------------------------------------

--------------050603000600000103030405
Content-Type: text/plain;
 name="syscall_test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syscall_test.c"

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <asm/uaccess.h>
#include <asm/unistd.h>

static  long errno;

MODULE_AUTHOR("Constantine Gavrilov");
MODULE_DESCRIPTION("Simple test for syscall interface");
MODULE_LICENSE("GPL");

#ifdef CONFIG_X86_64
#include "gsyscall.h"
static long wrapper_umask (mode_t mask)
{
	long res = INLINE_SYSCALL(umask, 1, mask);
	return res;
}
#endif

static _syscall1(long, umask, int, mode);

static int __init syscall_test_init(void)
{
	long res;

	printk(KERN_INFO "syscall_test: via syscall macro\n");
	res=umask(0666);
	printk(KERN_INFO "syscall_test: via syscall macro -- result is %ld\n", res);
#ifdef CONFIG_X86_64
	printk(KERN_INFO "syscall_test: via INLINE_SYSCALL\n");
	res=wrapper_umask(0666);
	printk(KERN_INFO "syscall_test: via INLINE_SYSCALL -- result is %ld\n", res);
#endif
	return 0;
}

static void __exit syscall_test_exit(void)
{
	return;
}

module_init(syscall_test_init);
module_exit(syscall_test_exit);

--------------050603000600000103030405
Content-Type: text/plain;
 name="syscall_dumps"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syscall_dumps"

_syscall1() dump:
Dump of assembler code for function umask:
0x0000000000000030 <umask+0>:   mov    $0x5f,%eax
0x0000000000000035 <umask+5>:   movslq %edi,%rdi
0x0000000000000038 <umask+8>:   syscall
0x000000000000003a <umask+10>:  cmp    $0xffffffffffffff80,%rax
0x000000000000003e <umask+14>:  jbe    0x51 <umask+33>
0x0000000000000040 <umask+16>:  neg    %rax
0x0000000000000043 <umask+19>:  mov    %rax,0(%rip)        # 0x4a <umask+26>
0x000000000000004a <umask+26>:  mov    $0xffffffffffffffff,%rax
0x0000000000000051 <umask+33>:  retq
0x0000000000000052 <umask+34>:  data16
0x0000000000000053 <umask+35>:  data16
0x0000000000000054 <umask+36>:  data16
0x0000000000000055 <umask+37>:  nop
0x0000000000000056 <umask+38>:  data16
0x0000000000000057 <umask+39>:  data16
0x0000000000000058 <umask+40>:  data16
0x0000000000000059 <umask+41>:  nop
0x000000000000005a <umask+42>:  data16
0x000000000000005b <umask+43>:  data16
0x000000000000005c <umask+44>:  nop
0x000000000000005d <umask+45>:  data16
0x000000000000005e <umask+46>:  data16
0x000000000000005f <umask+47>:  nop

INLINE_SYCALL() dump:
Dump of assembler code for function wrapper_umask:
0x0000000000000000 <wrapper_umask+0>:   mov    %edi,%edi
0x0000000000000002 <wrapper_umask+2>:   mov    $0x5f,%rax
0x0000000000000009 <wrapper_umask+9>:   syscall
0x000000000000000b <wrapper_umask+11>:  cmp    $0xfffffffffffff000,%rax
0x0000000000000011 <wrapper_umask+17>:  jbe    0x24 <wrapper_umask+36>
0x0000000000000013 <wrapper_umask+19>:  neg    %rax
0x0000000000000016 <wrapper_umask+22>:  mov    %rax,0(%rip)        # 0x1d <wrapper_umask+29>
0x000000000000001d <wrapper_umask+29>:  mov    $0xffffffffffffffff,%rax
0x0000000000000024 <wrapper_umask+36>:  retq
0x0000000000000025 <wrapper_umask+37>:  data16
0x0000000000000026 <wrapper_umask+38>:  data16
0x0000000000000027 <wrapper_umask+39>:  data16
0x0000000000000028 <wrapper_umask+40>:  nop
0x0000000000000029 <wrapper_umask+41>:  data16
0x000000000000002a <wrapper_umask+42>:  data16
0x000000000000002b <wrapper_umask+43>:  data16
0x000000000000002c <wrapper_umask+44>:  nop
0x000000000000002d <wrapper_umask+45>:  data16
0x000000000000002e <wrapper_umask+46>:  data16
0x000000000000002f <wrapper_umask+47>:  nop


Disassemble of umask() from a statically linked prog:

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main()
{
        umask(666);
        return 0;
}


Dump of assembler code for function umask:
0x0000000000406a20 <umask+0>:   mov    $0x5f,%rax
0x0000000000406a27 <umask+7>:   syscall
0x0000000000406a29 <umask+9>:   retq
0x0000000000406a2a <umask+10>:  nop
0x0000000000406a2b <umask+11>:  nop
0x0000000000406a2c <umask+12>:  nop
0x0000000000406a2d <umask+13>:  nop
0x0000000000406a2e <umask+14>:  nop
0x0000000000406a2f <umask+15>:  nop




--------------050603000600000103030405
Content-Type: text/plain;
 name="syscall_crash"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syscall_crash"

page_fault: wrong gs 0 expected ffffffff805fb4c0
Unable to handle kernel NULL pointer dereference at virtual address 000000000000
0008
 printing rip:
ffffffff80110053
PML4 17becb067 PGD 17bec5067 PMD 0 
Oops: 0002
CPU 0 
Pid: 2218, comm: insmod Not tainted
RIP: 0010:[<ffffffff80110053>]{system_call+3}
RSP: 0018:000001017becde30  EFLAGS: 00010012
RAX: 000000000000005f RBX: ffffffff8040ed20 RCX: ffffffffa00810fa
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000001b6
RBP: ffffffffa0081000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000212 R12: 0000000000554030
R13: 00000000000000b8 R14: 000000000000000c R15: 000001017c504740
FS:  0000002a9557d4c0(0000) GS:ffffffff805fb4c0(0000) knlGS:ffffffff805fb4c0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 0000000000101000 CR4: 00000000000006e0

Call Trace: [<ffffffffa008113c>]{:syscall_test:syscall_test_init+28} 
       [<ffffffff801256b6>]{sys_init_module+1686} [<ffffffffa00810b8>] 
       [<ffffffff801100c7>]{system_call+119} 
Process insmod (pid: 2218, stackpage=1017becd000)
Stack: 000001017becde30 0000000000000018 ffffffffa008113c 0000000000554030 
       ffffffff801256b6 000001017be78000 000001017e893680 000001017e893640 
       00000000005542c6 000001017be78000 000001017be7a000 ffffff00000e5000 
       0000000000000246 00000000000000b8 ffffffffa007c000 ffffffffa00810b8 
       00000000000006a8 0000000000000000 0000000000000000 0000000000000000 
       0000000000000000 0000000000000000 0000000000000000 0000000000000000 
       0000000000000000 0000000000000000 0000000000000000 0000000000000000 
       0000000000000000 0000000000000000 0000000000000000 0000000000000000 
       0000000000000000 0000000000000000 0000000000000000 0000000000000000 
       0000002a958aa6c0 0000000000000000 00000000005539d0 00000000005514e0 
Call Trace: [<ffffffffa008113c>]{:syscall_test:syscall_test_init+28} 
       [<ffffffff801256b6>]{sys_init_module+1686} [<ffffffffa00810b8>] 
       [<ffffffff801100c7>]{system_call+119} 

Code: 65 48 89 24 25 08 00 00 00 65 48 8b 24 25 00 00 00 00 fb 48

Kernel panic: Fatal exception
=================================

syscall_test_init() dump:

0x0000000000000060 <syscall_test_init+0>:       sub    $0x8,%rsp
0x0000000000000064 <syscall_test_init+4>:       mov    $0x0,%rdi
0x000000000000006b <syscall_test_init+11>:      xor    %eax,%eax
0x000000000000006d <syscall_test_init+13>:      callq  0x72 <syscall_test_init+18>
0x0000000000000072 <syscall_test_init+18>:      mov    $0x1b6,%edi
0x0000000000000077 <syscall_test_init+23>:      callq  0x30 <umask>
0x000000000000007c <syscall_test_init+28>:      mov    $0x0,%rdi
0x0000000000000083 <syscall_test_init+35>:      mov    %rax,%rsi
0x0000000000000086 <syscall_test_init+38>:      xor    %eax,%eax
0x0000000000000088 <syscall_test_init+40>:      callq  0x8d <syscall_test_init+45>
0x000000000000008d <syscall_test_init+45>:      mov    $0x0,%rdi
0x0000000000000094 <syscall_test_init+52>:      xor    %eax,%eax
0x0000000000000096 <syscall_test_init+54>:    callq  0x9b <syscall_test_init+59>
0x000000000000009b <syscall_test_init+59>:      mov    $0x1b6,%edi
0x00000000000000a0 <syscall_test_init+64>:      callq  0x0 <wrapper_umask>
0x00000000000000a5 <syscall_test_init+69>:      mov    $0x0,%rdi
0x00000000000000ac <syscall_test_init+76>:      mov    %rax,%rsi
0x00000000000000af <syscall_test_init+79>:      xor    %eax,%eax
0x00000000000000b1 <syscall_test_init+81>:      callq  0xb6 <syscall_test_init+86>
0x00000000000000b6 <syscall_test_init+86>:      xor    %eax,%eax
0x00000000000000b8 <syscall_test_init+88>:      add    $0x8,%rsp
0x00000000000000bc <syscall_test_init+92>:      retq
0x00000000000000bd <syscall_test_init+93>:      data16
0x00000000000000be <syscall_test_init+94>:      data16
0x00000000000000bf <syscall_test_init+95>:      nop

--------------050603000600000103030405
Content-Type: text/plain;
 name="inline_crash"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="inline_crash"


The block that tests the call to umask via syscall
was commented out in this case and the module was
recompiled.

==================================================
page_fault: wrong gs 0 expected ffffffff805fb540
Unable to handle kernel NULL pointer dereference at virtual address 000000000000
0008
 printing rip:
ffffffff80110053
PML4 17bb83067 PGD 17bb7d067 PMD 0 
Oops: 0002
CPU 1 
Pid: 2218, comm: insmod Not tainted
RIP: 0010:[<ffffffff80110053>]{system_call+3}
RSP: 0018:000001017bb85e30  EFLAGS: 00010012
RAX: 000000000000005f RBX: ffffffff8040ed20 RCX: ffffffffa00810cb
RDX: 0000000001000000 RSI: 0000000000000000 RDI: 00000000000001b6
RBP: ffffffffa0081000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000212 R12: 0000000000553f30
R13: 00000000000000b8 R14: 000000000000000c R15: 000001017e95b3c0
FS:  0000002a9557d4c0(0000) GS:ffffffff805fb540(0000) knlGS:ffffffff805fb540
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 0000000018216000 CR4: 00000000000006e0

Call Trace: [<ffffffffa008113c>]{:syscall_test:syscall_test_init+28} 
       [<ffffffff801256b6>]{sys_init_module+1686} [<ffffffffa00810b8>] 
       [<ffffffff801100c7>]{system_call+119} 
Process insmod (pid: 2218, stackpage=1017bb85000)
Stack: 000001017bb85e30 0000000000000018 ffffffffa008113c 0000000000553f30 
       ffffffff801256b6 000001017bb30000 000001017e99b440 000001017e99b400 
       0000000000554126 000001017bb30000 000001017bb32000 ffffff00000e5000 
       0000000000000246 00000000000000b8 ffffffffa007c000 ffffffffa00810b8 
       0000000000000608 0000000000000000 0000000000000000 0000000000000000 
       0000000000000000 0000000000000000 0000000000000000 0000000000000000 
       0000000000000000 0000000000000000 0000000000000000 0000000000000000 
       0000000000000000 0000000000000000 0000000000000000 0000000000000000 
       0000000000000000 0000000000000000 0000000000000000 0000000000000000 
       0000002a958aa6c0 0000000000000000 00000000005538d0 00000000005514e0 
Call Trace: [<ffffffffa008113c>]{:syscall_test:syscall_test_init+28} 
       [<ffffffff801256b6>]{sys_init_module+1686} [<ffffffffa00810b8>] 
       [<ffffffff801100c7>]{system_call+119} 

Code: 65 48 89 24 25 08 00 00 00 65 48 8b 24 25 00 00 00 00 fb 48

Kernel panic: Fatal exception

=========================================

syscall_test_init() dump:

0x0000000000000060 <syscall_test_init+0>:       sub    $0x8,%rsp
0x0000000000000064 <syscall_test_init+4>:       mov    $0x0,%rdi
0x000000000000006b <syscall_test_init+11>:      xor    %eax,%eax
0x000000000000006d <syscall_test_init+13>:      callq  0x72 <syscall_test_init+18>
0x0000000000000072 <syscall_test_init+18>:      mov    $0x1b6,%edi
0x0000000000000077 <syscall_test_init+23>:      callq  0x0 <wrapper_umask>
0x000000000000007c <syscall_test_init+28>:      mov    $0x0,%rdi
0x0000000000000083 <syscall_test_init+35>:      mov    %rax,%rsi
0x0000000000000086 <syscall_test_init+38>:      xor    %eax,%eax
0x0000000000000088 <syscall_test_init+40>:      callq  0x8d <syscall_test_init+45>
0x000000000000008d <syscall_test_init+45>:      xor    %eax,%eax
0x000000000000008f <syscall_test_init+47>:      add    $0x8,%rsp
0x0000000000000093 <syscall_test_init+51>:      retq
0x0000000000000094 <syscall_test_init+52>:      data16
0x0000000000000095 <syscall_test_init+53>:      data16
0x0000000000000096 <syscall_test_init+54>:      data16
0x0000000000000097 <syscall_test_init+55>:      nop
0x0000000000000098 <syscall_test_init+56>:      data16
0x0000000000000099 <syscall_test_init+57>:      data16
0x000000000000009a <syscall_test_init+58>:      data16
0x000000000000009b <syscall_test_init+59>:      nop
0x000000000000009c <syscall_test_init+60>:      data16
0x000000000000009d <syscall_test_init+61>:      data16
0x000000000000009e <syscall_test_init+62>:      data16
0x000000000000009f <syscall_test_init+63>:      nop


--------------050603000600000103030405--

