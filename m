Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265318AbRFVHwl>; Fri, 22 Jun 2001 03:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265363AbRFVHwc>; Fri, 22 Jun 2001 03:52:32 -0400
Received: from ns.suse.de ([213.95.15.193]:30734 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S265318AbRFVHwN>;
	Fri, 22 Jun 2001 03:52:13 -0400
To: Davide Libenzi <davidel@xmailserver.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: About I/O callbacks ...
In-Reply-To: <XFMail.20010621184645.davidel@xmailserver.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 22 Jun 2001 09:49:40 +0200
In-Reply-To: Davide Libenzi's message of "22 Jun 2001 03:46:44 +0200"
Message-ID: <ouplmml6jjf.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi <davidel@xmailserver.org> writes:

> I was just thinking to implement I/O callbacks inside the kernel and test which
> kind of performance could result compared to a select()/poll() implementation.
> I prefer IO callbacks against async-io coz in this way is more direct to
> implement an I/O driven state machine + coroutines.
> This is a first draft :

They already exist since several years in Linux. 

It is called queued SIGIO; when you set a realtime signal
using F_SETSIG for a fd and enable async IO. The callback is a signal
handler or alternatively an event processing loop using sigwaitinfo*(). 
The necessary information like which fd got an event is passed in the 
siginfo_t. 

With that mechanism you could easily implement your API in user space.

Currently it doesn't work for block devices of course; there is no real
kernel async block IO in linux kernel; but fine for networking and some
other devices.

It works fine in most cases. Most annoying design bug is that it can be
only sent to the current thread for non root processes (that is caused
by an older overzealous security fix); unfortunately fixing it is 2.5
material because it requires storing the sender credentials in the socket
for this case. Also some people don't like the behaviour on signal queue 
overflow. Signal delivery is currently not the most optimized path in 
Linux, but I doubt that you could get it much faster because essentially your 
callbacks have to do the same work as signals. Also you would need to solve
the exact same problems, as efficient overload handling.

The SSE2 changes in 2.4 hurt somewhat because it now saves a big SSE
context.  For one application I implemented a SA_NOFP flag which brings
the signal deliver to near 2.2 speed again if you don't need FP in the signal 
handler.

--- arch/i386/kernel/i387.c-NOFP	Sat Mar 10 01:24:00 2001
+++ arch/i386/kernel/i387.c	Mon May  7 14:59:18 2001
@@ -323,11 +323,6 @@
 	if ( !current->used_math )
 		return 0;
 
-	/* This will cause a "finit" to be triggered by the next
-	 * attempted FPU operation by the 'current' process.
-	 */
-	current->used_math = 0;
-
 	if ( HAVE_HWFP ) {
 		if ( cpu_has_fxsr ) {
 			return save_i387_fxsave( buf );
@@ -335,6 +330,11 @@
 			return save_i387_fsave( buf );
 		}
 	} else {
+		/* This will cause a "finit" to be triggered by the next
+		 * attempted FPU operation by the 'current' process.
+		 */
+		current->used_math = 0;
+       
 		return save_i387_soft( &current->thread.i387.soft, buf );
 	}
 }
--- arch/i386/kernel/signal.c-NOFP	Sun Feb 18 15:00:22 2001
+++ arch/i386/kernel/signal.c	Mon May  7 14:55:42 2001
@@ -316,11 +316,11 @@
 
 static int
 setup_sigcontext(struct sigcontext *sc, struct _fpstate *fpstate,
-		 struct pt_regs *regs, unsigned long mask)
+		 struct pt_regs *regs, unsigned long mask, int fp)
 {
-	int tmp, err = 0;
+	int err = 0;
+	int tmp;
 
-	tmp = 0;
 	__asm__("movl %%gs,%0" : "=r"(tmp): "0"(tmp));
 	err |= __put_user(tmp, (unsigned int *)&sc->gs);
 	__asm__("movl %%fs,%0" : "=r"(tmp): "0"(tmp));
@@ -344,11 +344,12 @@
 	err |= __put_user(regs->esp, &sc->esp_at_signal);
 	err |= __put_user(regs->xss, (unsigned int *)&sc->ss);
 
-	tmp = save_i387(fpstate);
-	if (tmp < 0)
+	if (fp)
+	  fp = save_i387(fpstate);
+	if (fp < 0)
 	  err = 1;
 	else
-	  err |= __put_user(tmp ? fpstate : NULL, &sc->fpstate);
+	  err |= __put_user(fp ? fpstate : NULL, &sc->fpstate);
 
 	/* non-iBCS2 extensions.. */
 	err |= __put_user(mask, &sc->oldmask);
@@ -404,7 +405,8 @@
 	if (err)
 		goto give_sigsegv;
 
-	err |= setup_sigcontext(&frame->sc, &frame->fpstate, regs, set->sig[0]);
+	err |= setup_sigcontext(&frame->sc, &frame->fpstate, regs, set->sig[0], 
+				!!(ka->sa.sa_flags&SA_NOFP));
 	if (err)
 		goto give_sigsegv;
 
@@ -485,7 +487,7 @@
 			  &frame->uc.uc_stack.ss_flags);
 	err |= __put_user(current->sas_ss_size, &frame->uc.uc_stack.ss_size);
 	err |= setup_sigcontext(&frame->uc.uc_mcontext, &frame->fpstate,
-			        regs, set->sig[0]);
+			        regs, set->sig[0], !!(ka->sa.sa_flags&SA_NOFP));
 	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
 	if (err)
 		goto give_sigsegv;
--- include/asm-i386/signal.h-NOFP	Wed Sep 13 23:29:16 2000
+++ include/asm-i386/signal.h	Mon May  7 14:41:37 2001
@@ -80,6 +80,7 @@
  * SA_RESETHAND clears the handler when the signal is delivered.
  * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
  * SA_NODEFER prevents the current signal from being masked in the handler.
+ * SA_NOFP    Don't save FP state.	
  *
  * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
  * Unix names RESETHAND and NODEFER respectively.
@@ -97,6 +98,7 @@
 #define SA_INTERRUPT	0x20000000 /* dummy -- ignored */
 
 #define SA_RESTORER	0x04000000
+#define SA_NOFP		0x02000000
 
 /* 
  * sigaltstack controls




-Andi
