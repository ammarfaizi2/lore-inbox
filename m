Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276527AbRI2PhV>; Sat, 29 Sep 2001 11:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276526AbRI2PhM>; Sat, 29 Sep 2001 11:37:12 -0400
Received: from pc2-camb4-0-cust1.cam.cable.ntl.com ([213.107.105.1]:1152 "EHLO
	eden.lincnet") by vger.kernel.org with ESMTP id <S276530AbRI2Pg7>;
	Sat, 29 Sep 2001 11:36:59 -0400
Date: Sat, 29 Sep 2001 16:37:31 +0100 (BST)
From: Carl Ritson <critson@perlfu.co.uk>
X-X-Sender: <critson@eden.lincnet>
To: <linux-kernel@vger.kernel.org>
cc: <alan@lxorguk.ukuu.org.uk>
Subject: PROBLEM: Hang on mounting fd0 - 2.4.9-ac16
Message-ID: <Pine.LNX.4.33.0109291618270.1016-100000@eden.lincnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This problem occurs on 2.4.9-ac16 and ac17 (not on ac15 or less), when
mounting a floppy disk the system Soft-Hangs, Sys-Rq still works.
If the floppy disk doesn't have an FS it doesn't hang, just rejects the
floppy (like it should).

This is an SMP box, 2xPIII 866Mhz, 512Mb of RAM.

It spits out the flowing text (hand typed):

<text from console>
wait_on_irq, CPU0
irq: 0 [ 0 0 ]
bh: 1 [ 0 1 ]

Stack Dumps:
CPU1: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
        00000000 00000000 00000000 00000000 00000000 00000000 00000000
0000000
       00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
Call Trace:

CPU0: cl8bbf28 c027623d 00000000 00000000 ffffffff 00000000 c0108632
c0276252
        00000001 d2ea7000 00000001 c01b377e d2ea7368 c02e6c44 c18bbf74
c18ba648
       c18ba000 c011b2ad d2ea7000 d2ea7130 c02e6c44 c18ba000 00000000
c0122be5
Call Trace: [<c0108632>] [<c01b377e>] [<c011b2ad>] [<c0122be5>]
[c0122aa0>]
        [<c0105000>] [<c0105656>] [<c0122aa0>]

</text>

Feeding this through ksymoops I get the flowing report.

<oops report>
[critson@eden linux-ac17]$ ksymoops -m System.map -K -v vmlinux < ~/bug
ksymoops 2.4.0 on i686 2.4.9-ac16.  Options used
     -v vmlinux (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.9-ac16/ (default)
     -m System.map (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
wait_on_irq, CPU0
irq: 0 [ 0 0 ]
bh: 1 [ 0 1 ]
Stack Dumps:
        00000000 00000000 00000000 00000000 00000000 00000000 00000000
0000000
       00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
        00000001 d2ea7000 00000001 c01b377e d2ea7368 c02e6c44 c18bbf74
c18ba648
       c18ba000 c011b2ad d2ea7000 d2ea7130 c02e6c44 c18ba000 00000000
c0122be5
Call Trace: [<c0108632>] [<c01b377e>] [<c011b2ad>] [<c0122be5>]
[c0122aa0>]
        [<c0105000>] [<c0105656>] [<c0122aa0>]
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c0108632 <__global_cli+e2/170>
Trace; c01b377e <flush_to_ldisc+9e/120>
Trace; c011b2ad <__run_task_queue+5d/70>
Trace; c0122be5 <context_thread+145/200>
Trace; c0105000 <_stext+0/0>
Trace; c0105656 <kernel_thread+26/30>
Trace; c0122aa0 <context_thread+0/200>


1 warning issued.  Results may not be reliable.
</oops>

I have looking around and I believe that the source of this maybe in the
softirq changes. I will continue to hunt around.

I can provide my .config on request.

Related to the Softirq changes, wouldn't the following patch make them
cleaner, rather than having gotos?
Forgive me if I am wrong, I am a Newbie Kernel Hacker :)

<patch>
--- linux-ac17/kernel/softirq.c Sat Sep 29 15:29:03 2001
+++ linux-ac16/kernel/softirq.c Sat Sep 29 15:41:05 2001
@@ -386,21 +386,16 @@
        ksoftirqd_task(cpu) = current;

        for (;;) {
-back:
                do {
                        do_softirq();
-                       if (current->need_resched)
-                               goto preempt;
+                       if (current->need_resched) {
+                               __set_current_state(TASK_RUNNING);
+                               break;
+                       }
                } while (softirq_pending(cpu));
                schedule();
                __set_current_state(TASK_INTERRUPTIBLE);
        }
-
-preempt:
-       __set_current_state(TASK_RUNNING);
-       schedule();
-       __set_current_state(TASK_INTERRUPTIBLE);
-       goto back;
 }

 static __init int spawn_ksoftirqd(void)
</patch>

Again just a thought :)

Carl Ritson
critson@perlfu.co.uk

