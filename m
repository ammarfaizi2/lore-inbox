Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136789AbREBCrj>; Tue, 1 May 2001 22:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136790AbREBCr2>; Tue, 1 May 2001 22:47:28 -0400
Received: from smarty.smart.net ([207.176.80.102]:10257 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S136789AbREBCrR>;
	Tue, 1 May 2001 22:47:17 -0400
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200105020229.WAA13179@smarty.smart.net>
Subject: inserting a Forth-like language into the Linux kernel
To: linux-kernel@vger.kernel.org
Date: Tue, 1 May 2001 22:29:07 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

( H3sm is my 3-stack Forth variant. )

I have a Linux 2.4.0-test10 kernel building and booting nicely with H3sm
partially installed as an in-kernel thread ala kswapd, the virtual memory
swapper. This means H3sm runs in cooperative multitasking with the Linux
schuduler, i.e. it's something of a co-kernel with Linux. H3sm looks like
this from the Linux side in the unix /proc pseudo-filesystem of system
information...

Name:   kspamd
State:  Z (zombie)
Pid:    4
PPid:   1
TracerPid:      0
Uid:    0       0       0       0
Gid:    0       0       0       0
FDSize: 0
Groups:
SigPnd: 0000000000000000
SigBlk: 0000000000000000
SigIgn: 0000000000000000
SigCgt: 0000000000000000
SigCgt: 0000000000000000
CapInh: 0000000000000000
CapPrm: 00000000ffffffff
CapEff: 00000000fffffeff

H3sm is of course the 4th process ;o)  (kspamd) is the Linux-side wrapper
for H3sm....

:;ps
PID     TTY     STAT    RSS     COMMAND
1       0       S       89      (init)
2       0       S       0       (kswapd)
3       0       S       0       (kreclaimd)
4       0       Z       0       (kspamd)
5       0       S       0       (kflushd)
6       0       S       0       (kupdate)
12      1026    S       157     (bash)
19      1027    S       143     (bash)
20      1028    S       141     (bash)
21      1029    S       137     (bash)
22      1030    S       142     (bash)
23      1031    S       137     (bash)
24      1032    S       137     (bash)
25      1033    S       137     (bash)
26      1034    S       137     (bash)
27      1035    S       137     (bash)
28      1036    S       137     (bash)
44      0       S       83      (mouse)
67      0       S       101     (syslogd)
80      1029    S       140     (bash)
81      1029    S       339     (browse)
83      1088    S       148     (pppd)
85      1028    S       84      (irc)
88      1028    S       311     (ircii-EPIC4pre2)
89      1028    S       63      (in.identd)
91      1027    S       1287    (slrn)
92      1027    S       108     (edit)
94      1030    S       345     (browse)
95      1031    R       2       (ps)

H3sm doesn't yet survive the boot process, and gets killed and becomes a a
unix "zombie process" (the Z's in the listings). I just spent 3 days
running around in circles at the lowest level to no avail, other than I
think I may have arrived at a realization that I badly mis-concieved
H3sm's behavior requirements trying to do "file" reads as part of the
kernel. H3sm opens the file namespace representation of the first virtual
console just fine, namely /dev/tty1. It can beep the console before going
zombie, which is a "file" write of one character, ASCII 7. (I've left
/dev/tty1 unallocated in the usual init process on the Linux side, so that
when H3sm does work it won't be competing with a getty or shell for user
input.)

For reading user input, the regular userland H3sm was doing a blocking
read, i.e. it would call the form of read syscall that pauses the process
until the "file" replies somehow. This is asking a bit much of kernel
code, to say the least. The userland H3sm lets the console driver provide
it with line-wise communications from the user. I just hope it's possible
to do a character-wise version from the kernel, or some other work-around.

If it is possible to read a virtual terminal from the kernel the
possibilities are outrageous. The more general cases of file IO and
terminal IO are proven possible. This approach could be applied to various
Forths, for those who like thier stacks in matched pairs.

H3sm is built into the kernel by sneaking in behind the real in-kernel
daemons in mm/vmscan.c. This avoids a lot of #include complexity.  A
wrapper mimicing the outermost code of kpiod or kreclaimd is what the
kspamd is on the Linux side. Playing around in there you see neat examples
of the cooperative multi-tasking at the core of Linux. You can hog the
CPU, grab it periodically, mark your self runnable and keep CPU use at
100% while still switching to Linux, and so on. You relinquish the CPU
from the H3sm/Forth/whatever side with the Linux "schedule" call. Syscalls
are as per usual, except with the more fundamental coordination issues.
Here's some of H3sm in x86 gas and m4...
......................................................................
top_loop_of_H3sm:
        pushf
        pusha
                call schedule   # exuent to host
        popa
        popf

        call token
                YES(            mozygote)
                        call interpret
mov A to 0  [note to c.l.f: This is my debugging hook. Do a Linux "oops"
                here.]
ELL(                                    top_loop_of_H3sm)
        #zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
mozygote:
                call beep
#               call Source
 #                      call zero
  #              call store
   #             call pdrop
#                call cr
                call refill
                call drop
ELL(                    top_loop_of_H3sm)
initialdp:

......................................................................

When the H3sm zombies the rest of Linux boots without it.

Here's some of the mm/vmscan.c in question....
...................................................................
int kspamd(void *unused)
{
        struct task_struct *tsk = current;
        pg_data_t *pgdat;

        tsk->session = 1;
        tsk->pgrp = 1;
        strcpy(tsk->comm, "kspamd");
/*      sigfillset(&tsk->blocked);
        current->flags |= PF_MEMALLOC;
*/
        mainH3sm();
}


static int __init kswapd_init(void)
{
        printk("Starting kswapd v1.8\n");
        swap_setup();
        kernel_thread(kswapd, NULL, CLONE_FS | CLONE_FILES |
                        CLONE_SIGNAL);
        kernel_thread(kreclaimd, NULL, CLONE_FS | CLONE_FILES |
                        CLONE_SIGNAL);
        kernel_thread(kspamd, NULL, CLONE_FS | CLONE_SIGNAL );
        printk("Starting kspamd v0.00.00.00.01\n");
        return 0;
}
........................................................................

That code is left over from some tests without H3sm that accepted the CPU
on every scheduling opportunity, resulting in the CPU use pegged at 1.0 or
more, but otherwise normal operation of Linux.

An ed script and some hand renaming suffixes all the labels in H3sm with
"H3sm" to eliminate name conflicts with Linux labels.

This is not how kdb works. That is an in-kernel debugger invoked on
breakpoint traps and so on. I don't know about kgdb, which is a wrapper
for the userland GNU symbolic debugger. gdb requires compiling the kernel
with debugging information inserted everywhere.

Rick Hohensee
www.clienux.com

