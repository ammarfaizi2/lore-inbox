Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266603AbUHOLkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266603AbUHOLkF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 07:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266622AbUHOLkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 07:40:05 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:50694 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266603AbUHOLjj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 07:39:39 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] HOWTO find oops location, v2
Date: Sun, 15 Aug 2004 14:39:31 +0300
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200408151439.31891.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got some useful feedback. This is v2 of the HOWTO.

CFLAGS="-g -Wa,-a,-ad" trick almost, but not quite works.

--- cut here ------ cut here ------ cut here ------ cut here ---

Okay, so you've got an oops and want to find out what happened?

In this HOWTO, I presume you did not delete and did not
tamper with your kernel build tree. Also, I recommend you
to enable these options in the .config:

CONFIG_DEBUG_SLAB=y
CONFIG_FRAME_POINTER=y

First one makes use-after-free bug hunt easy, second gives
you much more reliable stacktraces.

Ok, let's take a look at example OOPS. ^^^^ marks are mine.

Unable to handle kernel NULL pointer dereference at virtual address 00000e14
 printing eip:
c0162887
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: eeprom snd_seq_oss snd_seq_midi_event..........
CPU:    0
EIP:    0060:[<c0162887>]    Not tainted
EFLAGS: 00010206   (2.6.7-nf2)
EIP is at prune_dcache+0x147/0x1c0
          ^^^^^^^^^^^^^^^^^^^^^^^^
eax: 00000e00   ebx: d1bde050   ecx: f1b3c050   edx: f1b3ac50
esi: f1b3ac40   edi: c1973000   ebp: 00000036   esp: c1973ef8
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 65, threadinfo=c1973000 task=c1986050)
Stack: d7721178 c1973ef8 0000007a 00000000 c1973000 f7ffea48 c0162d1f 0000007a
       c0139a2b 0000007a 000000d0 00025528 049dbb00 00000000 000001fa 00000000
       c0364564 00000001 0000000a c0364440 c013add1 00000080 000000d0 00000000
Call Trace:
 [<c0162d1f>] shrink_dcache_memory+0x1f/0x30
 [<c0139a2b>] shrink_slab+0x14b/0x190
 [<c013add1>] balance_pgdat+0x1b1/0x200
 [<c013aee7>] kswapd+0xc7/0xe0
 [<c0114270>] autoremove_wake_function+0x0/0x60
 [<c0103e9e>] ret_from_fork+0x6/0x14
 [<c0114270>] autoremove_wake_function+0x0/0x60
 [<c013ae20>] kswapd+0x0/0xe0
 [<c01021d1>] kernel_thread_helper+0x5/0x14
Code: 8b 50 14 85 d2 75 27 89 34 24 e8 4a 2b 00 00 8b 73 0c 89 1c

Let's try to find out where did that exactly happen.
Grep in your kernel tree for prune_dcache. Aha, it is defined in
fs/dcache.c! Ok, execute these two commands:

# objdump -d fs/dcache.o > fs/dcache.disasm
# make fs/dcache.s

Now in fs/ you should have:

dcache.c - source code
dcache.o - compiled object file
dcache.s - assembler output of C compiler ('half-compiled' code)
dcache.disasm - disasembled object file

Open dcache.disasm and find "prune_dcache":

00000540 <prune_dcache>:
     540:       55                      push   %ebp

We need to find prune_dcache+0x147. Using shell,

# printf "0x%x\n" $((0x540+0x147))
0x687

and in dcache.disasm:

     683:       85 c0                   test   %eax,%eax
     685:       74 07                   je     68e <prune_dcache+0x14e>
     687:       8b 50 14                mov    0x14(%eax),%edx    <======== OOPS
     68a:       85 d2                   test   %edx,%edx
     68c:       75 27                   jne    6b5 <prune_dcache+0x175>
     68e:       89 34 24                mov    %esi,(%esp)
     691:       e8 fc ff ff ff          call   692 <prune_dcache+0x152>
     696:       8b 73 0c                mov    0xc(%ebx),%esi
     699:       89 1c 24                mov    %ebx,(%esp)
     69c:       e8 9f f9 ff ff          call   40 <d_free>

Comparing with "Code: 8b 50 14 85 d2 75 27" - match!

We need to find matching line in dcache.s and, eventually, in dcache.c.
It's easy to find prune_dcache in dcache.s:

prune_dcache:
        pushl   %ebp

but even though it is not too hard to find matching instruction:

        movl    8(%edi), %eax
        decl    20(%edi)
        testb   $8, %al
        jne     .L593
.L517:
        movl    68(%ebx), %eax
        testl   %eax, %eax
        je      .L532
        movl    20(%eax), %edx  <========= OOPS
        testl   %edx, %edx
        jne     .L594
.L532:
        movl    %esi, (%esp)
        call    iput
.L565:
        movl    12(%ebx), %esi
        movl    %ebx, (%esp)
        call    d_free

it is unclear to which part of .c code it belongs:

static void prune_dcache(int count)
{
        spin_lock(&dcache_lock);
        for (; count ; count--) {
                struct dentry *dentry;
                struct list_head *tmp;
                tmp = dentry_unused.prev;
                if (tmp == &dentry_unused)
                        break;
                list_del_init(tmp);
                prefetch(dentry_unused.prev);
                dentry_stat.nr_unused--;
                dentry = list_entry(tmp, struct dentry, d_lru);
                spin_lock(&dentry->d_lock);
                /*
                 * We found an inuse dentry which was not removed from
                 * dentry_unused because of laziness during lookup.  Do not free
                 * it - just keep it off the dentry_unused list.
                 */
                if (atomic_read(&dentry->d_count)) {
                        spin_unlock(&dentry->d_lock);
                        continue;
                }
                /* If the dentry was recently referenced, don't free it. */
                if (dentry->d_flags & DCACHE_REFERENCED) {
                        dentry->d_flags &= ~DCACHE_REFERENCED;
                        list_add(&dentry->d_lru, &dentry_unused);
                        dentry_stat.nr_unused++;
                        spin_unlock(&dentry->d_lock);
                        continue;
                }
                prune_one_dentry(dentry);
        }
        spin_unlock(&dcache_lock);
}

What now?! Well, I have a silly method which helps to find
C code line corresponding to that asm one. Edit your
prune_dcache in dcache.c like this:

static void prune_dcache(int count)
{
        spin_lock(&dcache_lock);
        for (; count ; count--) {
                struct dentry *dentry;
                struct list_head *tmp;
asm("#1");
                tmp = dentry_unused.prev;
asm("#2");
                if (tmp == &dentry_unused)
                        break;
asm("#3");
                list_del_init(tmp);
asm("#4");
                prefetch(dentry_unused.prev);
asm("#5");
                dentry_stat.nr_unused--;
asm("#6");
...
...
asm("#e");
                prune_one_dentry(dentry);
        }
asm("#f");
        spin_unlock(&dcache_lock);
}

and do "make fs/dcache.s" again. Look into new dcache.s.
Nasty surprize:

APP
        #e
#NO_APP
        testb   $16, %al
        jne     .L495
        orl     $16, %eax
        leal    72(%ecx), %esi
        movl    %eax, 4(%ebx)
        movl    4(%esi), %edx
        movl    72(%ecx), %eax
        testl   %eax, %eax
        movl    %eax, (%edx)
        je      .L493
        movl    %edx, 4(%eax)
.L493:
        movl    $2097664, 4(%esi)
.L495:
        leal    40(%ebx), %ecx
        movl    40(%ebx), %eax
        movl    4(%ecx), %edx
        movl    %edx, 4(%eax)
        movl    %eax, (%edx)
        movl    $2097664, 4(%ecx)
        movl    $1048832, 40(%ebx)
        decl    dentry_stat
        movl    8(%ebx), %esi
        testl   %esi, %esi
        je      .L536
        leal    56(%ebx), %eax
        movl    $0, 8(%ebx)
        movl    56(%ebx), %edx
        movl    4(%eax), %ecx
        movl    %ecx, 4(%edx)
        movl    %edx, (%ecx)
        movl    %eax, 4(%eax)
        movl    %eax, 56(%ebx)
        movl    8(%edi), %eax
        decl    20(%edi)
        testb   $8, %al
        jne     .L592
.L518:
        movl    8(%edi), %eax
        decl    20(%edi)
        testb   $8, %al
        jne     .L593
.L517:
        movl    68(%ebx), %eax
        testl   %eax, %eax
        je      .L532
        movl    20(%eax), %edx    <======== OOPS
        testl   %edx, %edx
        jne     .L594
.L532:
        movl    %esi, (%esp)
        call    iput

How come one line of C code expanded in so much asm?!
Hmm... asm("#e") was directly before prune_one_dentry(dentry),
what's that?

static inline void prune_one_dentry(struct dentry * dentry)
{
        struct dentry * parent;
        __d_drop(dentry);
        list_del(&dentry->d_child);
        dentry_stat.nr_dentry--;        /* For d_free, below */
        dentry_iput(dentry);
        parent = dentry->d_parent;
        d_free(dentry);
        if (parent != dentry)
                dput(parent);
        spin_lock(&dcache_lock);
}

Argh! An inline function. Do asm trick to it too:

static inline void prune_one_dentry(struct dentry * dentry)
{
        struct dentry * parent;
asm("#A");
        __d_drop(dentry);
asm("#B");
        list_del(&dentry->d_child);
asm("#C");
        dentry_stat.nr_dentry--;        /* For d_free, below */
asm("#D");
        dentry_iput(dentry);
asm("#E");
...
...
}

"make fs/dcache.s", rinse, repeat. You will discover that OOPS
happened after #D mark, inside dentry_iput wich is an inline too.
Will this ever end? Luckily, yes. After yet another round of asm
insertion, we arrive at:

static inline void dentry_iput(struct dentry * dentry)
{
        struct inode *inode = dentry->d_inode;
        if (inode) {
asm("#K");
                dentry->d_inode = NULL;
asm("#L");
                list_del_init(&dentry->d_alias);
asm("#M");
                spin_unlock(&dentry->d_lock);
asm("#N");
                spin_unlock(&dcache_lock);
asm("#O");
                if (dentry->d_op && dentry->d_op->d_iput)
{
asm("#P");
                        dentry->d_op->d_iput(dentry, inode);
}
                else
...

Which corresponds to this part of new dcache.s:

.L517:
#APP
        #O
#NO_APP
        movl    68(%ebx), %eax
        testl   %eax, %eax
        je      .L532
        movl    20(%eax), %edx   <=== OOPS
        testl   %edx, %edx
        jne     .L594
.L532:
#APP
        #Q
#NO_APP

This is "if (dentry->d_op && dentry->d_op->d_iput)" condition
check, and it is oopsing trying to do second check. dentry->d_op
contains bogus pointer value 0x00000e00.



======================================================
Date:	Sat, 14 Aug 2004 11:06:42 -0300
From:	Marcelo Tosatti <marcelo.tosatti@cyclades.com>
======================================================

Might be also worth mentioning "gcc -c file.c -g -Wa,-a,-ad  > file.s"
which makes gcc output C code mixed with asm output.

Sometimes its not as effective as the comment method you describe,
but it will be less work for sure :)
======================================================

Yes, this would be useful as soon as we will figure out
how to to preserve exact build environment.
I tried

make CFLAGS="-g -Wa,-a,-ad" fs/dcache.o >dcache.asm

but result was very dirrerent because in this case gcc was run
without these flags:

-Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
-fno-common -pipe -msoft-float -mpreferred-stack-boundary=2
-march=i486 -I/.1/usr/srcdevel/kernel/linux-2.6.7-bk20.src/include/asm-i386/mach-default
-Iinclude/asm-i386/mach-default -O2 -falign-functions=1 -falign-labels=1 -falign-loops=1
-falign-jumps=1

and dcache.asm was useless.



==============================================
Date:	Sat, 14 Aug 2004 09:41:10 -0400 (EDT)
From:	Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [RFC] HOWTO find oops location
==============================================

There are a few very simple methods i use all the time:

compile with CONFIG_DEBUG_INFO (it's safe to select the option and
recompile after the oops even) and then;

Unable to handle kernel NULL pointer dereference at virtual address 0000000c
 printing eip:
c046a188
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
Modules linked in:
CPU:    0
EIP:    0060:[<c046a188>]    Not tainted VLI
EFLAGS: 00010246   (2.6.6-mm3)
EIP is at serial_open+0x38/0x170
[...]

# gdb vmlinux
GNU gdb 5.2
Copyright 2002 Free Software Foundation, Inc.
...
(gdb) list *serial_open+0x38
0xc046a188 is in serial_open (drivers/usb/serial/usb-serial.c:465).
460
461             /* get the serial object associated with this tty pointer */
462             serial = usb_serial_get_by_index(tty->index);
463
464             /* set up our port structure making the tty driver remember our port object, and us it */
465             portNumber = tty->index - serial->minor;
466             port = serial->port[portNumber];
467             tty->driver_data = port;
468
469             port->tty = tty;

And then for cases where you deadlock and the NMI watchdog triggers with
%eip in a lock section:

NMI Watchdog detected LOCKUP on CPU0,
eip c0119e5e, registers:
Modules linked in:
CPU:    0
EIP:    0060:[<c0119e5e>]    Tainted:
EFLAGS: 00000086   (2.6.7)
EIP is at .text.lock.sched+0x89/0x12b
[...]

(gdb) disassemble 0xc0119e5e
Dump of assembler code for function Letext:
[...]
0xc0119e59 <Letext+132>:        repz nop
0xc0119e5b <Letext+134>:        cmpb   $0x0,(%edi)
0xc0119e5e <Letext+137>:        jle    0xc0119e59 <Letext+132>
0xc0119e60 <Letext+139>:        jmp    0xc0118183 <scheduler_tick+487>

(gdb) list *scheduler_tick+487
0xc0118183 is in scheduler_tick (include/asm/spinlock.h:124).
119             if (unlikely(lock->magic != SPINLOCK_MAGIC)) {
120                     printk("eip: %p\n", &&here);
121                     BUG();
122             }
123     #endif
124             __asm__ __volatile__(
125                     spin_lock_string
126                     :"=m" (lock->lock) : : "memory");
127     }

But that's not much help since it's pointing to an inline function and not
the real lock location, so just subtract a few bytes:

(gdb) list *scheduler_tick+450
0xc011815e is in scheduler_tick (kernel/sched.c:2021).
2016            cpustat->system += sys_ticks;
2017
2018            /* Task might have expired already, but not scheduled off yet */
2019            if (p->array != rq->active) {
2020                    set_tsk_need_resched(p);
2021                    goto out;
2022            }
2023            spin_lock(&rq->lock);

So we have our lock location. Then there are cases where there is a "Bad
EIP" most common ones are when a bad function pointer is followed or if
some of the kernel text or a module got unloaded/unmapped (e.g. via
__init). You can normally determine which is which by noting that bad eip
for unloaded text normally looks like a valid virtual address.

Unable to handle kernel NULL pointer dereference at virtual address 00000000
00000000
*pde = 00000000
Oops: 0000 [#1]
CPU: 0
EIP: 0060:[<00000000>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210246
[...]
Call Trace:
 [<c01dbbfb>] smb_readdir+0x4fb/0x6e0
 [<c0165560>] filldir64+0x0/0x130
 [<c016524a>] vfs_readdir+0x8a/0x90
 [<c0165560>] filldir64+0x0/0x130
 [<c01656fd>] sys_getdents64+0x6d/0xa6
 [<c0165560>] filldir64+0x0/0x130
 [<c010adff>] syscall_call+0x7/0xb
Code: Bad EIP value.

>From there you're best off examining the call trace to find the culprit.
======================================================
--
vda

