Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154556-18252>; Thu, 19 Nov 1998 09:55:56 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:9305 "EHLO penguin.e-mind.com" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <156550-18252>; Thu, 19 Nov 1998 04:51:44 -0500
Date: Thu, 19 Nov 1998 11:45:40 +0100 (CET)
From: Andrea Arcangeli <andrea@e-mind.com>
Reply-To: Andrea Arcangeli <andrea@e-mind.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.rutgers.edu
Subject: entry.S mess with %ebx (&current pointer)
In-Reply-To: <Pine.LNX.3.96.981117202922.556D-100000@dragon.bogus>
Message-ID: <Pine.LNX.3.96.981119112030.27027A-100000@dragon.bogus>
X-PgP-Public-Key-URL: http://e-mind.com/~andrea/aa.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Tue, 17 Nov 1998, Andrea Arcangeli wrote:

>I run the fork-test on 2.1.127 + patch IKD. It never hanged in two hours
>(under any kind of load). It was used to hang in arca-22 after some
>minutes.  So the bug is hided very well by the IKD tracing slowdown :-(.

I am sure that the kernel run do_signal() from signal_return, even if
sigpending is 0.  This mean that %ebx got corrupted somewhere (and this
explain very well also the need_resched flood I suspected some days ago).
A patch for 2.1.128 that fix the UP hang fine here is this: 

Index: linux/arch/i386/kernel/entry.S
===================================================================
RCS file: /var/cvs/linux/arch/i386/kernel/entry.S,v
retrieving revision 1.1.1.1.16.1
diff -u -r1.1.1.1.16.1 entry.S
--- linux/arch/i386/kernel/entry.S	1998/10/31 00:35:56	1.1.1.1.16.1
+++ entry.S	1998/11/19 10:08:16
@@ -184,6 +184,7 @@
 	andl SYMBOL_NAME(bh_active),%eax
 	jne handle_bottom_half
 ret_with_reschedule:
+	GET_CURRENT(%ebx)
 	cmpl $0,need_resched(%ebx)
 	jne reschedule
 	cmpl $0,sigpending(%ebx)
@@ -197,16 +198,16 @@
 	movl %esp,%eax
 	jne v86_signal_return
 	xorl %edx,%edx
-	call SYMBOL_NAME(do_signal)
-	jmp restore_all
+	pushl $restore_all
+	jmp SYMBOL_NAME(do_signal)
 
 	ALIGN
 v86_signal_return:
 	call SYMBOL_NAME(save_v86_state)
 	movl %eax,%esp
 	xorl %edx,%edx
-	call SYMBOL_NAME(do_signal)
-	jmp restore_all
+	pushl $restore_all
+	jmp SYMBOL_NAME(do_signal)
 
 	ALIGN
 tracesys:
@@ -215,8 +216,8 @@
 	movl ORIG_EAX(%esp),%eax
 	call *SYMBOL_NAME(sys_call_table)(,%eax,4)
 	movl %eax,EAX(%esp)		# save the return value
-	call SYMBOL_NAME(syscall_trace)
-	jmp ret_from_sys_call
+	pushl $ret_from_sys_call
+	jmp SYMBOL_NAME(syscall_trace)
 badsys:
 	movl $-ENOSYS,EAX(%esp)
 	jmp ret_from_sys_call


The only important thing is the added GET_CURRENT(). All other parts are
only strightforward and sensible performance optimizations. Note that
2.1.128 was used to run a do_signal() without any signal pending many many
times so fixing this bug should improve performance a lot (plus the
improvement I made replacing all `call(function)' with `pushl retaddress;
jmp function'. 

I had to think a bit more before say that the bug is due a gcc
miscompilation. Are we sure that %ebx is supposed to been not clobbered
across functions? Could be the somewhere used regparm attribute that
caused the miscompilation? This would explain also because why the IDK
kernel is immune from the stall. In the IKD kernel we #define FASTCALL(x) 
x, and I hacked ~all function in the kernel to handle the x86 normal
calling conventions (btw, in __switch_to() I used the
__attribute__((stdcall)) to avoid having to release the stack by hand in
the asm and to avoid having to use `call' in the calling asm :-).

I suggest everybody on x86 to try this patch also in SMP machines that was
used to hang frequently... Now _everything_ works __fine__ here on UP
with an UP kernel. I don' t know right now why the SMP kernel on UP
hardware was not reproducing the problem... If there will be further
signal problems let me know...

Andrea Arcangeli

PS. This patch and a lot of other things will be in the soon arca-23.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
