Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131162AbRAIKcl>; Tue, 9 Jan 2001 05:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131522AbRAIKcd>; Tue, 9 Jan 2001 05:32:33 -0500
Received: from www.wen-online.de ([212.223.88.39]:47880 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131516AbRAIKcY>;
	Tue, 9 Jan 2001 05:32:24 -0500
Date: Tue, 9 Jan 2001 11:32:26 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [testcase] madvise->semaphore deadlock 2.4.0
Message-ID: <Pine.Linu.4.10.10101091113020.2510-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

While trying to configure ftpsearch, the process hangs while running
it's madvise confidence test below.  It appears to be taking a fault
in madvise_fixup_middle():atomic_add(2, &vma->vm_file->f_count) and
immediately deadlocking forever on mm->mmap_sem per IKD.  (Virgin 2.4.0
agrees)

Accesses to /proc afterward (ie ps) leaves hangers.

kdb> bp sys_madvise
Instruction(i) BP #0 at 0xc0129aa4 (sys_madvise)
    is enabled globally adjust 1
kdb> go
Instruction(i) breakpoint #0 at 0xc0129aa4 (adjusted)
0xc0129aa4 sys_madvise:   0xc0129aa4 sys_madviseint3   

Entering kdb (current=0xc4232000, pid 260) due to Breakpoint @ 0xc0129aa4
kdb> bp __down_failed
Instruction(i) BP #1 at 0xc0107c84 (__down_failed)
    is enabled globally adjust 1
kdb> go
Instruction(i) breakpoint #1 at 0xc0107c84 (adjusted)
0xc0107c84 __down_failed:   0xc0107c84 __down_failedint3   

Entering kdb (current=0xc4232000, pid 260) due to Breakpoint @ 0xc0107c84
kdb> sr z
SysRq: Suspending trace
kdb> rd
eax = 0x00000000 ebx = 0xc4232000 ecx = 0xc7f6963c edx = 0x00000010 
esi = 0xc7f69620 edi = 0xc4232000 esp = 0xc4233e58 eip = 0xc0107c84 
ebp = 0xc4233efc xss = 0x00000018 xcs = 0x00000010 eflags = 0x00000296 
xds = 0x00000018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xc4233e24
kdb> bt
    EBP       EIP         Function(args)
0xc4233efc 0xc0107c84 __down_failed (0xc4232000, 0x2, 0xc0114c00, 0x0, 0x3)
                               kernel .text 0xc0100000 0xc0107c84 0xc0107c9c
           0xc0226571 stext_lock+0x12d
                               kernel .text.lock 0xc0226444 0xc0226444 0xc0227840
           0xc0114c77 do_page_fault+0x77 (0xc4233f0c, 0x2, 0xc370bd20, 0x40170000, 0x2)
                               kernel .text 0xc0100000 0xc0114c00 0xc0115060
           0xc0109284 error_code+0x34
                               kernel .text 0xc0100000 0xc0109250 0xc010928c
Interrupt registers:
eax = 0x00000000 ebx = 0xc370bd20 ecx = 0x40170000 edx = 0x00000002 
esi = 0xc370bce0 edi = 0xc370bca0 esp = 0xc4233f40 eip = 0xc012964a 
ebp = 0xc4233f50 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010202 
xds = 0x00000018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xc4233f0c
           0xc012964a madvise_fixup_middle+0xb6 (0xc370bca0, 0x40160000, 0x40170000, 0x0)
                               kernel .text 0xc0100000 0xc0129594 0xc01296fc
0xc4233f74 0xc0129789 madvise_behavior+0x8d (0xc370bca0, 0x40160000, 0x40170000, 0x0)
                               kernel .text 0xc0100000 0xc01296fc 0xc0129798
0xc4233f90 0xc0129a7d madvise_vma+0x35 (0xc370bca0, 0x40160000, 0x40170000, 0x0)
                               kernel .text 0xc0100000 0xc0129a48 0xc0129aa4
0xc4233fbc 0xc0129b48 sys_madvise+0xa4 (0x40160000, 0x10000, 0x0, 0x4000e6d0, 0xbffff86c)
                               kernel .text 0xc0100000 0xc0129aa4 0xc0129b94
more> 
           0xc0109154 system_call+0x3c
                               kernel .text 0xc0100000 0xc0109118 0xc0109158
kdb> go
pid 260 starving for fork.c205
pid 260 starving for fork.c205
pid 260 starving for fork.c205

ksymoops 2.3.5 on i686 2.4.0.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0/ (default)
     -m /lib/modules/2.4.0/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Call Trace: [<c010791d>] [<c0107a68>] [<c020989d>] [<c0112ef4>] [<c012b805>] [<c012206c>] [<c01220fa>] 
       [<c0122260>] [<c0113037>] [<c0108e80>] [<c0125965>] [<c0125a9f>] [<c0125d60>] [<c0125e1a>] [<c0108d63>] 
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c010791d <__down+55/9c>
Trace; c0107a68 <__down_failed+8/c>
Trace; c020989d <stext_lock+11d/13ba>
Trace; c0112ef4 <do_page_fault+0/40c>
Trace; c012b805 <__alloc_pages+dd/2d0>
Trace; c012206c <do_anonymous_page+30/8c>
Trace; c01220fa <do_no_page+32/b0>
Trace; c0122260 <handle_mm_fault+e8/154>
Trace; c0113037 <do_page_fault+143/40c>
Trace; c0108e80 <error_code+34/3c>
Trace; c0125965 <madvise_fixup_middle+a9/160>
Trace; c0125a9f <madvise_behavior+83/90>
Trace; c0125d60 <madvise_vma+2c/54>
Trace; c0125e1a <sys_madvise+92/e8>
Trace; c0108d63 <system_call+33/38>


2 warnings issued.  Results may not be reliable.

#include <sys/types.h>
#include <sys/mman.h>


int main(int argc,char **argv)
{
  char *dummy;
  char *base;
  dummy = malloc(2 * 64 * 1024 );
  base = (char *) (( ((unsigned long) dummy) + 64 * 1024UL - 1 ) & - (64 * 1024UL));
  if (madvise(base,64*1024,MADV_NORMAL))
    exit(1);
  if (madvise(base,64*1024,MADV_RANDOM))
    exit(1);
  if (madvise(base,64*1024,MADV_SEQUENTIAL))
    exit(1);
  if (madvise(base,64*1024,MADV_WILLNEED))
    exit(1);
  if (madvise(base,64*1024,MADV_DONTNEED))
    exit(1);
  exit(0);
}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
