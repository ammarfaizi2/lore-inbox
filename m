Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269049AbTBXBMj>; Sun, 23 Feb 2003 20:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269047AbTBXBMj>; Sun, 23 Feb 2003 20:12:39 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:60869 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S269039AbTBXBMV>; Sun, 23 Feb 2003 20:12:21 -0500
Date: Sun, 23 Feb 2003 20:22:33 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: State of sparc32 union
Message-ID: <20030223202233.A20072@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I'm trolling l-k just this one time, to see what crawls out of
woodwork. --P3]

Status: The port floats, but barely. It self-compiles the kernel,
but I'm afraid to think about re-doing glibc, compilers, etc.
Modules may have problems with dots in names. No SMP yet.

List of '##' problems for 2003/02/23 follows. For most of them DaveM
outlined solutions already, somone only has to code the fixes.

 ## (De-)Alias
flush_user_windows is the same code as WINDOW_FLUSH, but
WINDOW_FLUSH is used on sun4m only. Make generic? Add calls to .S?

From: DaveM

WINDOW_FLUSH is a macro of assembly merely for the convenience of
the sun4m cache/tlb flushing code.  Calling out to a common routine
isn't easy because we want to keep these timing critical cache/tlb
flush routines from needing to allocate a stack frame.

I suggest to put this on backburner for now.

 ## Get rid of fork_kpsr, fork_kwim. See comment above sparc64 sys_vfork.

 ## CONFIG_PREEMPT - rtrap.S

 ## Fix nonzero phys_base (account in page_to_phys, etc.)
 ## ak:
<zaitcev> Suppose, that I have a Linux box with RAM not starting at physical 
           address zero. Will pfn be an index into mem_map, or a (phys_addr >> 
           PAGE_SHIFT) ?
<freitag> zaitcev: it's normally both (at least on i386)
<freitag> mem_map mapping the hole
<freitag> if you don't want that you need CONFIG_DISCONTIG
<zaitcev> Oh

From: DaveM

Please, use sparc64 as model, it is much simpler.

Actually... looking to current {srmmu,sun4c}.c, it makes precisely
the same thing as sparc64, passing lowest pfn to
free_area_init_node().

The only missing part is fixing mem_map[] indexing to take
(phys_base >> PAGE_SHIFT) into account.  Again, look to sparc64
for guidance.

 ## Eradicate smp_num_cpus

 ## Rewrite ioport.c, keep local directory of resources (indexed).
-- Make sure unaligned "reg" is forwarded from 2.4

 ## omit or not omit [the frame pointer], that is the question.
  sparc-unknown-linux-gnu-gcc -Wp,-MD,./.sched.o.d -D__KERNEL__
 -I/q/zaitcev/ksrc/linux-2.5.24-sparc/include
 -Wall -Wstrict-prototypes -Wno-trigraphs -O2
 -fomit-frame-pointer -fno-strict-aliasing -fno-common
 -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7 -nostdinc
 -iwithprefix include    -fno-omit-frame-pointer -DKBUILD_BASENAME=sched
 -c -o sched.o sched.c

My precise suggestion is some CONFIG_SCHED_NO_NEED_FRAME_POINTER, bool
it to 'y' on IA64, sparc32, sparc64.  In kernel/Makefile replace that
ugly CONFIG_IA64 test and comment a test on the new config option.

 ## copy_thread seems to have a LOT of redundancy.

From: DaveM
I don't see it, PSR_PS case is remarkably different set of operations
than !PSR_PS case.

 ## JavaStation userland -- grab the userland and try it out.
"Chris Newport" <crn@netunix.com>
ftp://ftp.netunix.co.uk/pub/splack/splack-current/tftpboot/README.JAVASTATION

 ## Remove __irq_itoa
Very sophisticated on sparc64 (irq is a pointer).
Ask DaveM to make it index into ivector_table[].
-- We now have sun4d, restore that first and compare.

From: DaveM
sun4d IRQ scheme is almost identical to sparc64 sun4u one,
in fact sun5 architecture is basically sun4d + improvements.
I am fine to make sparc64 irq into an index.

 ## JSFLASH bitrotted
-- Migrate to MTD

 ## How about getting current back to g6, and extract current_thread_info()
from the stack pointer. Be "cycle counting maniac".

From: DaveM
To be honest, if you take my advice and move most of thread stuff
into thread_info, 'current' becomes much much less important.

 ## Large software PMD, to make PTE a full page.
-- DONE, Document somewhere!!!
-- Make sun4c not suffer? Takes sun4/sun4c specific kernel?

<riel> zaitcev: just put 4 1kB page tables into one page at a time and fill in 
           4 PGD entries at once
<riel> zaitcev: so you have 4 kB sized page tables as far as Linux is concerned
<riel> zaitcev: and your set_pmd macro just fills in 4 entries at a time

<zaitcev> pmd_t is shared between sun4c and sun4m
<zaitcev> Gawd
<riel> zaitcev: well, you only need to change set_pmd and clear_pmd
<riel> zaitcev: for testing you only need to test the first pmd ;)

rmk:
http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2002-March/008089.html

-- 2003/01/10 s390 does the same thing for no apparent reason. What foresight!
   I reused that for highpte, works like a charm. Never documented anywhere,
   poke Martin & Ulrich to explain and document...

 ## Galvanize STRICT_MM_TYPECHECKS
Dave says he'd run it all the time, but structure passing convention
puts all them on stack. -- deferred. Ask Jakub to change C ABI?

 ## Get rid of srmmu_early_allocate_ptable_skeleton and __nocache_fix
Perhaps not that easy; consider what if we do large page mapping.

 ## Kill pg0 .. pg3. Only used on sun4c, what for?
From: DaveM
It is used to build the VMALLOC pmds/pte_tables at boot time
so that we don't need to do it later.  This was needed for some
reason, but it escapes me now.

 ## srmmu_pte_alloc_one is a bunch of longish macros. Shorten? Profile?

 ## ppc.bkbits.net/for-linus-ppc64 -- for quick checks

 ## %l5, %l6 they are used to call do_signal. Only syscall path sets them.
RESTORE_ALL gets to them.

        clr     %o0
        mov     %l5, %o2
        mov     %l6, %o3
        call    C_LABEL(do_signal)
         add    %sp, REGWIN_SZ, %o1     ! pt_regs ptr

From: DaveM

RESTORE_ALL clears l6, which makes l5 be ignored by do_signal().

This is almost identical to how sparc64 works, l6 non-zero means that
we are returning from a syscall.  Zero value means we are not.

-- Cannot believe it works, but it does

 ## Merge sunsu.c with the new (2.5.32) generic serial, 8250. kgdb anew?
 ## su_inb vs. serial_inp in su.c: should be uniform.
-- sunsu.c same.
-- Investigate a move to 8250.c instead.
 ##
sunsu.c: In function `wait_for_xmitr':
sunsu.c:1309: warning: implicit declaration of function `udelay'
 ## SysRq does not work on su console

 ## Kill cli, sti, save_and_cli from arch code. Be proactive.

 ## Implement user_tid argument of do_fork.
<davem> user_tid is passed to do_fork via UREG_G2

 ## Finish the kgdb: remove sparc-stub.c	-- NO. MAY BE USED AGAIN.
 ## ...
[DaveM] I zapped all the SERIAL/CONSOLE checks and the kgdb references
[DaveM] from sparc64
[DaveM] CONFIG_SERIAL_CONSOLE is just plain remnant...
[DaveM] look it only exists as define_bool in sparc config.in now
[DaveM] we have to add some machinery to drivers/serial/Config.in if you want 
           user to be able to switch this

 ## Make sure we do not cause actual assignment of *dir (a BIIIG struct).
static inline void free_one_pmd(mmu_gather_t *tlb, pmd_t * dir)
{
        struct page *page;

        if (pmd_none(*dir))
                return;
        if (pmd_bad(*dir)) {
                pmd_ERROR(*dir);
                pmd_clear(dir);
                return;
        }
        page = pmd_page(*dir);
        pmd_clear(dir);
        pgtable_remove_rmap(page);
        pte_free_tlb(tlb, page);
}
-- Bug Riel.

 ## Shortcut __nocache_va, __nocache_pa. Goddamn mess.

 ## Implement a debugging mode for spin_unlock_irq_restore which compares
CWP with the stored value and tracebacks instead of blowing up unpredictably.

 ## Make System.map corresponding to arch/sparc/boot/image.
-- Fixed by RobR, a little crude, but works (runs nm twice)
-- diff System.map arch/sparc/boot/System.map
[zaitcev@lebethron linux-2.5.62-sbus]$ grep ROOT_DEV System.map
f0232e04 B ROOT_DEV
[zaitcev@lebethron linux-2.5.62-sbus]$ grep ROOT_DEV arch/sparc/boot/System.map
f0233e04 B ROOT_DEV
[zaitcev@lebethron linux-2.5.62-sbus]$
  They are offset by a whole page, is this ok? Why? btfixup?

 ## 2002/10/02 pci_alloc_consistent out of vmalloc-ed space
Mary Ann Diehl <mdiehl1@stny.rr.com>
mem_map_reserve(virt_to_page(return_value_from_pci_alloc_consistent));
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0210.0/0807.html
DaveM: Put this on hold, more thought is needed. (cache coherency)

 ## Make sure ntpd continues to work with "fixed" do_gettimeofday().

 ## IDE
<zaitcev> BTW, does sparc64 work with IDE in 2.5.42..43 ?
<davem> zaitcev: not yet, IDE_DATA reg endiannes still not fixed
<davem> zaitcev: It is easy to hack in a quick fix
<davem> zaitcev: replace all IDE_DATA register accesses with native endian I/O

 ##
btfix.s is not destroyed when the command returned non-zero.

 ## Add specific build instructions to Documentation/sparc/.
"make image" vs. "make vmlinux".
elftoaout
-- See "make image" vs "make"

 ## div64.h only uses 32 lower bits (silently)?!
-- Davem sent fix outline, implement.
-- Use hw div and %y on v8's.

 ## Test sunzilog.c on ancient sun4c's (my IPC got OBP 2.x, need 1.6).

 ## Recover Makefile.libs
-- Duh, forgot what was broken  2002/12/03

 ## Check we do it right
<paulus> so, inside an interrupt handler, current_thread_info()->preempt_count
           & HARDIRQ_MASK should be non-zero
<zwane_> thats the problem
<zwane_> gimme a sec
<zwane_> not all the bases where covered
<zwane_> its in traps.c
<zwane_> do_nmi
<zwane_> needs irq_enter
<wli> hehe
<zwane_> well thats nifty
<willy> bingo ;-)

 ## Down with NEW_GAS
From: DaveM

Actually, the right fix is to remove the NEW_GAS altogether, every
binutils people should be using now to build kernels should be able to
grok those options and specifying them when elf32-sparc is the default
is totally harmless.

... blow away all of the a.out build support cruft.
There is zero use for any of this ancient crap anymore.

This means C_SYMBOL() et al. may die as well.

I had been meaning to do this for years.

 ## sun4c never oopses properly, instead it loops overflowing stack.
kernel BUG at mm/slab.c:1087!z
Watchdog reset
Window Underflow
ok 

call f0022bfc    from f00147a0	sun4c_fault_fromuser + 38  -> do_sun4c_fault
    24 w  %o0-%o5: ( ff001378        0        0        0        0    33785 )
call f0022bfc    from f00147a0	sun4c_fault_fromuser + 38  -> do_sun4c_fault
    26 w  %o0-%o5: ( ff001470        0        0 5a5a5000   2c4000     1000 )
jmpl  5a5a5a5a    from f00eca8c	<----- trap window under %wim, not used??
    27 w  %o0-%o5: (        0 ff00159c 5a5a5a5a 5a5a5a5a       69        0 )
call f001e12c    from f0014180	mna_handler	-> kernel_unaligned_trap
    28 w  %o0-%o5: ( ff001568 d2060000       d0 f2fa5d24 f02cb628        4 )

 ## 2002/11/13 Benchmark? Cute assembly trick? Deprecate Cypress support?
<zaitcev> Dave, why are you against masking CWP in setipl?
<davem> It's expensive
<davem> If you do it, then fine, but move setipl into external function because
           it is too fat to inline
<zaitcev> Hmm... In CPUs I worked with, writing PSR was expensive
<zaitcev> Oh
<davem> Every damn spinlock,rwlock,softint,etc. operation makes this
<zaitcev> That's even worse
<zaitcev> OK, I see your point
<davem> :)

 ## 2002/11/13 Incorporate Ravnborg's build cleanups
-- make clean does not work right - retest
-- what the hell does "make help" do?

 ## URL
http://bugme.osdl.org/buglist.cgi?short_desc_type=allwordssubstr&short_desc=&product=Platform+Specific%2FHardware&component=S390-31&component=S390-64&component=SPARC32&component=SPARC64&long_desc_type=allwordssubstr&long_desc=&emailassigned_to1=1&emailtype1=substring&email1=&emailassigned_to2=1&emailreporter2=1&emailcc2=1&emailtype2=substring&email2=&bugidtype=include&bug_id=&changedin=&chfieldfrom=&chfieldto=Now&chfieldvalue=&cmdtype=doit&newqueryname=&order=Reuse+same+sort+as+last+time&field0-0-0=noop&type0-0-0=noop&value0-0-0=

 ## Make panics more compact for 80 column terminals
%l=  f5f43080 f0017b08  f018fef0 00000010  00000000 00000000  f0428000 f0065804
%i=  f04002b8 00000021  00000000 f5de443c  0000000a 00000000  f000fe80 f0017b4c
 ## Add %wim to panic printouts

 ## New modutils
http://www.kernel.org/pub/linux/kernel/people/rusty/module-init-tools-0.7.tar.gz
http://www.kernel.org/pub/linux/kernel/people/rusty/modules

 ## E's patch
http://marc.theaimsgroup.com/?l=linux-ultrasparc&m=103653103608133&w=2

 ## I do not remember adding this. WTF?
+       ld      [%o0 + 0x00], %o0       /* XXX vma->vm_mm GROSS XXX */

From: DaveM

It is my comment, flush_* take vma args, but these assembler routines
need to work with mm_struct.

Some routines actually want to get at other 'vma' members (for
exmaple, tsunami_flush_cache_page).

Longer term, once conversion away from flush_page_to_ram() to
flush_dcache_page et al. interfaces occur, 'vma' arg will be even more
important to flush_cache_foo() implementation.

 ## flush_page_to_ram will be deprecated soon.
Easiest conversion is probably:

1) Run sed s'/flush_page_to_ram/sparc_page_to_ram/' on all sparc
   sources.

2) #define flush_page_to_ram(page) do { } while (0)

3) #define flush_dcache_page(page) sparc_page_to_ram(page)
4) #define clear_user_page(addr, vaddr, page) \
           do { clear_page(addr); \
                sparc_page_to_ram(page); \
           } while (0)
   #define copy_user_page(to, from, vaddr, page) \
           do { copy_page(to, from); \
                sparc_page_to_ram(page); \
           } while (0)

But, like I said, in longer term full conversion to sparc64'like
flush_dcache_page is nearly mandatory.  I can give implementation
outline, it actually isn't much work.

-- 2003/02/01 Willy does the conversion, hurray!

 ## Migrate to thread_into & TI_FOO.
-  ({ ELF_CORE_COPY_REGS((*(__elf_regs)), (__tsk)->thread_info->kregs); 1; })
+  ({ ELF_CORE_COPY_REGS((*(__elf_regs)), (__tsk)->thread.kregs); 1; })

But this is one of many reasons I want the sparc32 thread_info stuff
to match what sparc64 does.  I wouldn't have made this trivial error
if things were consolidated.

 ## make image
Date: Mon, 02 Dec 2002 02:27:25 -0800 (PST)
From: "David S. Miller" <davem@redhat.com>

I really think "make image" is very non-intuitive.  The problem
is that it isn't the primary build target, so I type plain "make",
get "vmlinux" and think that I'm done.

This is very error prone.

From: Keith Owens <kaos@ocs.com.au>
Date: Mon, 02 Dec 2002 21:35:22 +1100

Which is why kbuild 2.5 had a single standard build target - make
installable.  It was up the .config and arch dependent rules to decide
what was required to build an installable system.

-- The problem is that top Makefile says:
#       That's our default target when none is given on the command line
all:    vmlinux

 ## davem's switch_to clobber
BTW, if ever bored a good audit for sparc32 would be to verify
all inline asm's, the two most common errors are:

1) Output constraints are wrong.  In multi instruction asm's
   producing some output, you almost always must use =&r
   for output operands.  Otherwise gcc may allocate the same
   register to some input as one of the outputs, but if the
   output is clobbered before all the inputs are used it will
   be wrong.

2) Missing "cc" clobber when condition codes change as a result
   of the asm.

-- script the thing

 ## Remove silly comments in system.h
From: davem

XXX prepare_arch_switch() is much smarter than this in sparc64, are we sure?
XXX Cosider if doing it the flush_user_windows way is faster (by uwinmask).

We must flush all user and kernel register windows here, it sanitizes
things so that the current register window is the only valid one
present in the cpu.  This is why sparc64 makes flushw_all() instead
of flushw_user().

We are not just trying to flush user register windows here.
switch_to() depends upon the state this creates.

The "more clever" stuff in sparc64 is all about avoiding a deadlock.
If the mm switching code takes mm->page_table_lock, then you would need
to do the clever stuff sparc64 does.

Otherwise, duplicating what x86 does is the best way to go, of course
with the register window flush added. :-)

 ## gcc-3 (see davem's mail)
3) prepare_arch_switch() has to execute in the same stack frame
   as switch_to() for it to flush the correct register windows.

 ## E's interrupt -> pil  sbint_new.diff 2002/12/04
 ## Eric's way to generate tables - add to source comments.
>From OBP: "sbus-intr>cpu"
More specifically, something like "1 sbus-intr>cpu ." etc, etc.
-- DONE? Verify.
-- 2.4 - get people to test, goddamit

 ## HIGHMEM is needed for sun4c: Dave's e-mail near "ravnborg" thread.

 ## Reif's VME interrups, cleanup of sun4m masking. 2002/12/07

 ##
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?

 ##
From: Robert Reif

Looks like xconfig doesn't like the changes from:
    if [ "$ARCH" = "sparc" -o "$ARCH" = "sparc64" ]; then
to
    if [ "$CONFIG_SPARC32" = "y" -o "$CONFIG_SPARC64" = "y" ]; then
in 2.4.20.

 ##
Serial: Sun Zilog driver (2 chips).
ioremap: done with statics, switching to malloc
zs2 at 0xfd014004 (irq = 44) is a Zilog8530
zs3 at 0xfd014000 (irq = 44) is a Zilog8530
ttyS0 at MMIO 0x0 (irq = 44) is a SunZilog
ttyS1 at MMIO 0x0 (irq = 44) is a SunZilog
              ^^^ ?!

 ##
scsi HBA driver Sun ESP 100/100a/200 didn't set a release method, please fix the template

 ## Verify that low 16K are used for something (put into the memory map)

 ## Oopses on break on closed console (already marked XXX). up->info==NULL.

 ## mallorn
version 0 swap is no longer supported. Use mkswap -v1 /dev/sda2
swapon: /dev/sda2: Invalid argument

[root@mallorn /root]# mkswap -v1 /dev/sdb2
Usage: mkswap [-c] /dev/name [blocks]
[root@mallorn /root]# mkswap -v 1 /dev/sdb2
Usage: mkswap [-c] /dev/name [blocks]
[root@mallorn /root]#

 ## Partitioning mismatch 2.5.54
On 2.5:
 sda: sda1 sda2 sda3 sda4 sda5 <=========== must be sda6, not sda5
[/sbin/fsck.ext2] fsck.ext2 -a /dev/sda6
fsck.ext2: Device not configured while trying to open /dev/sda6
Possibly non-existent or swap device?
 -- fixed in Dave's tree.
 -- fixed in 2.5.60 Linus?

 ## (mallorn, but should be generic). 2.5.54 with fixed zilog R9.
Give root password for maintenance
(or type Control-D for normal startup):
  <--- Then no input on console. Not even break.
-- Rx_INT lost, fixed

 ## Same bug on 2.4.21-pre3! (no input)
Give root password for maintenance
(or type Control-D for normal startup):
-- Works in some situations, but not others - root fs or non-root fs?

 ## Al's swapoff bug. 2003/01/13
It looks like something is raising SIGSEGV on the exit from syscall - after
sys_swapon() had done its thing (and no, it's not sys_swapon() itself - happens
even if you call it as non-root, so it just checks capabilities and sods off).
-- we do not see it due to -v1 problem (no swap :)

 ## Renumber MAP_GROWSDOWN as in sparc64
From: Jamie Lokier <jamie@shareable.org>
Date:   Sat, 18 Jan 2003 03:29:40 +0000

 ## prof_counter use per-cpu 2003/01/13 -- do soon
-- oh crap, this is getting stale 2003/02/12

 ## Dot in exported symbols - Rusty is stirring trouble.
Kai says - move EXPORT_SYMBOL_DOT to generic, or it will break over and over.
 ##
<kai> anton: The compiler cannot know that we're currently creating a module, so it'll just put a direct call to .function in the code. When that code is loaded as a module, you'll thus see an unresolved symbol .function. The generic code puts the value of the descriptor "function" in there instead, and then the arch code when doing the relocations creates a trampoline, putting the actual function address from the descriptor right into it. Sounds righ
<kai> t?
<anton> yep! :)
<anton> i wonder how ia64 handles it, it has function descriptors too
.....
<zaitcev> I'm the victim of .mul and .div
<anton> rusty has his sights on them :)
<f> what do function descriptors have to do with modules? I thought the trampolines were to be able to put modules everywhere in the virtual space, but not using 64bit jumps.
<anton> f: they do 2 things, yes they are also needed to put modules everywhere
<anton> f: but since we have a different TOC (effectively a GOT, referenced by offsets to r2) we need to load/restore it
<kai> zaitcev: I had a new EXPORT_SYMBOL_DOT() for sparc. But since we just blindly skip '.' now for ppc64, it's not necessary, the EXPORT_SYMBOL() works.
<kai> However, at least I understand why now, and I'm still not quite happy. Just skipping blindly isn't very clean IMO.
<anton> f: with rusty's patch to created shared .o files this work would be done for us
<anton> but it broke badly on mips i think, so its not happening for 2.6
<kai> anton: I think that was rth's patch. Anyway, I don't know how much that affects the generic kernel/module.c, apart from that there's nothing preventing ppc64 to add "-shared" to LDFLAGS_module.
<anton> kai: yeah I think you are right, rth did all that work

 ## Whaaat... use CONFIG_SPIN_LOCK_DEBUG, compare w/i386
#define SPIN_LOCK_DEBUG

 ## ps does not show anything but kernel threads
[zaitcev@mallorn zaitcev]$ ps auxw
USER       PID %CPU %MEM  SIZE   RSS TTY STAT START   TIME COMMAND
root         1  0.2  1.9  1300   576  ?  S    15:58   0:01 init
root         2  0.0  0.0     0     0  ?  SWN  15:58   0:00 (ksoftirqd/0)
root         3  0.0  0.0     0     0  ?  SW   15:58   0:00 (events/0)
root         4  0.0  0.0     0     0  ?  SW   15:58   0:00 (pdflush)
root         5  0.0  0.0     0     0  ?  SW   15:58   0:00 (pdflush)
root         6  0.0  0.0     0     0  ?  SW   15:58   0:00 (kswapd0)
root         7  0.0  0.0     0     0  ?  SW   15:58   0:00 (aio/0)
root         8  0.0  0.0     0     0  ?  SW   15:58   0:00 (scsi_eh_0)
[zaitcev@mallorn zaitcev]$
Need new userland, apparently.

 ## sunzilog
Discuss with DaveM. I want to print from under cli.
        if (ZS_IS_CONS(up)) {
                /* TX still busy?  Just wait for the next TX done interrupt.
                 *
                 * It can occur because of how we do serial console writes.  It
would
                 * be nice to transmit console writes just like we normally would for
                 * a TTY line. (ie. buffered and TX interrupt driven).  That is
not
                 * easy because console writes cannot sleep.  One solution might be
                 * to poll on enough port->xmit space becomming free.  -DaveM
                 */

 ## 2.4 Spot cannot build modules for sun4 2003/01/27

 ## Run NON-CONSOLE Zilog real hard (getty+uucp).

 ## 2.4 modprobe does not use path. 2.4.21-pre3
[root@mallorn zaitcev]# modprobe openpromfs
modprobe: Can't locate module openpromfs
[root@mallorn zaitcev]# insmod openpromfs.o
openpromfs.o: openpromfs.o: No such file or directory
[root@mallorn zaitcev]# insmod /lib/modules/2.4.21-pre3-sparc/kernel/fs/openpromfs/openpromfs.o
[root@mallorn zaitcev]# lsmod
Module                  Size  Used by
openpromfs             12128   0  (unused)
[root@mallorn zaitcev]#
-- Ancient modutils

 ## 2.4 self compilation
make -C acpi fastdep
make[4]: Entering directory `/q/zaitcev/linux-2.4.21-pre4-sparc/drivers/acpi'
/q/zaitcev/linux-2.4.21-pre4-sparc/scripts/mkdep -D__KERNEL__ -I/q/zaitcev/linux-2.4.21-pre4-sparc/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7 -D_LINUX -I/include -nostdinc -iwithprefix include -- acpi_ksyms.c driver.c os.c > .depend
realpath(/include) failed, No such file or directory
make[4]: *** [fastdep] Error 1

-- $(CURDIR) idiocy. How does it work on x86?!!
===> update make, you moron. CURDIR is a fresh make... Documentation/Changes

 ## 2.4 self
Kernel debugging (CONFIG_DEBUG_KERNEL) [N/y/?] (NEW) y
  Debug high memory support (CONFIG_DEBUG_HIGHMEM) [N/y/?] (NEW)
scripts/Configure: Can't reopen pipe to command substitution (fd 5): No child processes
  Debug memory allocations (CONFIG_DEBUG_SLAB) [N/y/?] (NEW)

 ## 2.5 (possibly 2.4 as well - can we do I/O into unmapped pages on 2.4?)
-- page_address() returns NULL here:
static void iommu_get_scsi_sgl_gflush(struct scatterlist *sg, int sz, struct sbus_bus *sbus)
{
        flush_page_for_dma(0);
        while (sz != 0) {
                --sz;
                sg[sz].dvma_address = (__u32) (page_address(sg[sz].page) + sg[sz].offset);
                sg[sz].dvma_length = (__u32) (sg[sz].length);
        }
}
-- The solution is to use iommu properly.
-- See DaveM's mail -> must use all 256M range to postpone oo-iommu panics
