Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317192AbSFXCXJ>; Sun, 23 Jun 2002 22:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317230AbSFXCXI>; Sun, 23 Jun 2002 22:23:08 -0400
Received: from insgate.stack.nl ([131.155.140.2]:763 "EHLO skynet.stack.nl")
	by vger.kernel.org with ESMTP id <S317192AbSFXCXH>;
	Sun, 23 Jun 2002 22:23:07 -0400
Date: Mon, 24 Jun 2002 04:23:08 +0200 (CEST)
From: Serge van den Boom <svdb@stack.nl>
To: linux-kernel@vger.kernel.org
Subject: On the forgotten ptrace EIP bug (patch included)
Message-ID: <20020624042057.R24485-100000@toad.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've come across a bug where the EIP of a process would be incorrectly
decremented by 2 after being modified by ptrace when it was interrupted
in a system call.
After some searching through the linux-kernel archives it appeared this
bug was already known, but the patch that was supposed to fix it had been
reverted as it broke more than it fixed.

On Sep 02 2000 Silvio Cesare formulated the problem as follows:
> Noteably, if the eip changes and a syscall was interrupted, the signal
> handling code will subtract 2 from the eip thinking its trying to restart
> the syscall (obviously, only on systems that restart slow syscalls).

He proposed the following patch:
> My fix would be to change orig_eax to -1 if the eip register is modified.
> Thus the signal handling code wouldnt think it needed to restart any
> syscalls.
> This is untested code btw.
> in the putreg function
>     case EIP:
>         put_stack_long(child, 4*ORIG_EAX - sizeof(struct pt_regs), -1);
>         break;

This patch was applied into 2.4.0test8-pre4 and reverted when it broke
several programs. The original bug has remained in the kernel since.

I think I found out what the problem is.
4*ORIG_EAX - sizeof(struct pt_regs)' is not the offset of the original
EAX on the child's stack. There are no FS and GS on the stack (which
would come before ORIG_EAX) so, analogous to EFLAGS, it should be
'(ORIG_EAX-2)*4-sizeof(struct pt_regs)'. The original form would
instead point to CS on the child's stack.

Also, by changing orig_eax to -1, we not only prevent the EIP from being
decremented, but we're preventing EAX from being restored from ORIG_EAX
as well. I think this is undesired, which means EAX will have to be
restored manually.

The patch below should fix these issues.
I have tested it on my machine, where it appears to work.


--- arch/i386/kernel/ptrace.c.org	Mon Jun 24 01:39:13 2002
+++ arch/i386/kernel/ptrace.c	Mon Jun 24 04:14:58 2002
@@ -34,9 +34,11 @@
 #define TRAP_FLAG 0x100

 /*
- * Offset of eflags on child stack..
+ * Offset of several registers on child stack..
  */
-#define EFL_OFFSET ((EFL-2)*4-sizeof(struct pt_regs))
+#define EAX_OFFSET       (EAX*4-sizeof(struct pt_regs))
+#define ORIG_EAX_OFFSET  ((ORIG_EAX-2)*4-sizeof(struct pt_regs))
+#define EFL_OFFSET       ((EFL-2)*4-sizeof(struct pt_regs))

 /*
  * this routine will get a word off of the processes privileged stack.
@@ -100,6 +102,19 @@
 			value &= FLAG_MASK;
 			value |= get_stack_long(child, EFL_OFFSET) & ~FLAG_MASK;
 			break;
+		case EIP: {
+			/* If the child was interrupted in a system call, set ORIG_EAX
+			 * to -1 so that no attempt will be made to restart it.
+			 * EAX needs to be restored manually in this case. */
+			long tmp;
+			tmp = get_stack_long(child, ORIG_EAX_OFFSET);
+			if (tmp >= 0) {
+				/* The child was interrupted in a system call */
+				put_stack_long(child, EAX_OFFSET, tmp);
+				put_stack_long(child, ORIG_EAX_OFFSET, -1);
+			}
+			break;
+		}
 	}
 	if (regno > GS*4)
 		regno -= 2*4;


Note that I'm pretty inexperienced with Linux kernel internals, so some of
what I have written or assumed might not be correct, though I'm pretty
confident the patch will do the trick.


Serge


-- 
Heisenberg knew exactly how fast his car-keys were travelling.



