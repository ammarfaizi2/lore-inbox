Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263006AbSJBJKx>; Wed, 2 Oct 2002 05:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263007AbSJBJKx>; Wed, 2 Oct 2002 05:10:53 -0400
Received: from mx2.elte.hu ([157.181.151.9]:27581 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S263006AbSJBJKv>;
	Wed, 2 Oct 2002 05:10:51 -0400
Date: Wed, 2 Oct 2002 11:22:46 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] dump_stack() cleanup, BK-curr
Message-ID: <Pine.LNX.4.44.0210021112020.6201-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i think it is quite unnecessery to dump the top portion of the stack in
dump_stack(). What matters for all these places (such as the atomic
schedule checker) is the actual backtrace - the printed stack only
contains the local variables of schedule() - not quite helpful for 99.9%
of the cases.

And yet another argument to skip the dumping of the stack: many people
have written down such dumps from screen - including the quite useless
'Stack:' information.

The attached (tested) patch modifies x86's dump_stack() to print out the
much friendlier backtrace. The patch also adds one more whitespace after
the numeric EIP value. The old dump looked this way:

bad: scheduling while atomic!
Stack: ffffffff c041c72f 0000006a 00000068 000000f0 c13e1f28 c04c49c0 c13e1f28
       c02a4099 c04c49c0 000000f0 00000000 00003104 c012592e 00003104 00003104
       ffffffff 34000286 00000282 00000000 00000000 c13e1f28 c04c49c0 c04c4468
Call Trace:
 [<c011f009>]sys_gettimeofday+0x89/0x90
 [<c0113e40>]do_page_fault+0x0/0x49e
 [<c0107d63>]syscall_call+0x7/0xb

the new output is:

bad: scheduling while atomic!
Call Trace:
 [<c011f009>] sys_gettimeofday+0x89/0x90
 [<c0113e40>] do_page_fault+0x0/0x49e
 [<c0107d63>] syscall_call+0x7/0xb

much nicer and much more compact i think.

(The stack dump can still be useful in a number of other situations, so
having it in the real oops output is still good i think.)

	Ingo

--- linux/arch/i386/kernel/traps.c.orig	Wed Oct  2 11:07:25 2002
+++ linux/arch/i386/kernel/traps.c	Wed Oct  2 11:14:12 2002
@@ -144,7 +144,7 @@
 	while (((long) stack & (THREAD_SIZE-1)) != 0) {
 		addr = *stack++;
 		if (kernel_text_address(addr)) {
-			printk(" [<%08lx>]", addr);
+			printk(" [<%08lx>] ", addr);
 			print_symbol("%s\n", addr);
 		}
 	}
@@ -189,7 +189,9 @@
  */
 void dump_stack(void)
 {
-	show_stack(0);
+	unsigned long stack;
+
+	show_trace(&stack);
 }
 
 void show_registers(struct pt_regs *regs)

