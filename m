Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286660AbRLVDy7>; Fri, 21 Dec 2001 22:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286661AbRLVDyu>; Fri, 21 Dec 2001 22:54:50 -0500
Received: from 12-233-63-23.client.attbi.com ([12.233.63.23]:2688 "EHLO
	adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S286660AbRLVDyc>; Fri, 21 Dec 2001 22:54:32 -0500
Date: Fri, 21 Dec 2001 19:54:25 -0800
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200112220354.fBM3sP902014@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: "se d" <seandarcy@hotmail.com>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] [gcc-3.10-0.1] Re: 2.4.17 build fails at network.o
In-Reply-To: <F236jsdO0S5MVdnE0bN0000a020@hotmail.com>
In-Reply-To: <F236jsdO0S5MVdnE0bN0000a020@hotmail.com>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mailing-lists.linux-kernel, you wrote:

> I'm trying to build 2.4.17. It fails as follows:
>
> net/network.o: In function `__rpc_schedule':
> net/network.o(.text+0x49a0d): undefined reference to `rpciod_tcp_dispatcher'

I've seen this problem while trying to compile recent kernels with
RedHat Rawhide's gcc-3.10-0.1, are you using that?

I traced the problem to a conflict in include/linux/sunrpc/clnt.h.  It
declares rpciod_tcp_dispatcher as extern, but it also includes
linux/sunrpc/xprt.h, which has a static inline definition of
rpciod_tcp_dispatcher.  Previous versions of gcc seem to choose the
static inline definition, while gcc-3.10-0.1 chooses the extern
declaration.  So I simply deleted the extern declaration from
linux/sunrpc/clnt.h.

With this change, the kernel compiles but oopses in do_signal()
shortly after booting.  jakub@redhat.com logged a similar conflict in
RedHat Bugzilla 57413, which I paraphrase here:  do_signal() is
delcared as asmlinkage int FASTCALL in arch/i386/kernel/signal.c, but
asmlinkage gives the attribute regparm(0), while FASTCALL gives the
attribute regparm(3).  Again, prior versions of gcc chose regparm(3),
while gcc-3.1-0.10 chooses regparm(0).  So I simply deleted the
asmlinkage declaration.

With these two small changes, kernel 2.4.17 compiles with gcc-3.1-0.10
and boots on my i386 machine OK.  In fact, I'm writing this under it
now.  However:

[whitney@pizza linux-2.4.17-gcc-3.1-0.10]$ grep -r "asmlinkage.*FASTCALL" .
./arch/i386/kernel/vm86.c:asmlinkage struct pt_regs * FASTCALL(save_v86_state(struct kernel_vm86_regs * regs));
./arch/s390/kernel/signal.c:asmlinkage int FASTCALL(do_signal(struct pt_regs *regs, sigset_t *oldset));
./arch/s390x/kernel/signal.c:asmlinkage int FASTCALL(do_signal(struct pt_regs *regs, sigset_t *oldset));
./arch/s390x/kernel/signal32.c:asmlinkage int FASTCALL(do_signal(struct pt_regs *regs, sigset_t *oldset));

Maybe some of these need cleaning up?  I'll have to leave that to the
experts, I'm more of a grease monkey.

Cheers,
Wayne

diff -rup linux-2.4.17/include/linux/sunrpc/clnt.h linux-2.4.17-gcc-3.1-0.10/include/linux/sunrpc/clnt.h
--- linux-2.4.17/include/linux/sunrpc/clnt.h	Tue Dec 11 13:05:03 2001
+++ linux-2.4.17-gcc-3.1-0.10/include/linux/sunrpc/clnt.h	Fri Dec 21 19:21:25 2001
@@ -136,7 +136,6 @@ rpc_set_timeout(struct rpc_clnt *clnt, u
 	xprt_set_timeout(&clnt->cl_timeout, retr, incr);
 }
 
-extern void rpciod_tcp_dispatcher(void);
 extern void rpciod_wake_up(void);
 
 /*
diff -rup linux-2.4.17/arch/i386/kernel/signal.c linux-2.4.17-gcc-3.1-0.10/arch/i386/kernel/signal.c
--- linux-2.4.17/arch/i386/kernel/signal.c	Sun Sep 23 13:50:09 2001
+++ linux-2.4.17-gcc-3.1-0.10/arch/i386/kernel/signal.c	Fri Dec 21 17:28:51 2001
@@ -28,7 +28,7 @@
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
-asmlinkage int FASTCALL(do_signal(struct pt_regs *regs, sigset_t *oldset));
+int FASTCALL(do_signal(struct pt_regs *regs, sigset_t *oldset));
 
 int copy_siginfo_to_user(siginfo_t *to, siginfo_t *from)
 {
