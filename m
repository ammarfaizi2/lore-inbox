Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292229AbSC0Vq2>; Wed, 27 Mar 2002 16:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292466AbSC0VqS>; Wed, 27 Mar 2002 16:46:18 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:42411 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S292229AbSC0VqE>;
	Wed, 27 Mar 2002 16:46:04 -0500
Message-ID: <3CA23D99.6030900@acm.org>
Date: Wed, 27 Mar 2002 15:46:01 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch] Threads performance - allow signal handler to not call handler
Content-Type: multipart/mixed;
 boundary="------------030200030608020501090708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030200030608020501090708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch modfies i386 to add a flag to sa_flags in sigaction that will 
cause the signal handler to not be called (but all other side effects to 
occur).  This may seem unusual, but signals are often used between 
threads to wake each other up, the signal handler is just a dummy and is 
pure overhead.  With this patch, if the flag is set, the signal handler 
won't get called (thus saving the overhead of going in and out of 
userland for the handler), but it will still wake up sigsuspend() and 
select().  The beauty of this is the flag will be ignored on kernels 
without it, so it will still work, with just lower performance.

-Corey

--------------030200030608020501090708
Content-Type: text/plain;
 name="linux-nocallhndlr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-nocallhndlr.patch"

--- ./arch/i386/kernel/signal.c.nocallhndlr	Wed Mar 27 10:56:29 2002
+++ ./arch/i386/kernel/signal.c	Wed Mar 27 11:04:45 2002
@@ -558,21 +558,24 @@
 		}
 	}
 
-	/* Set up the stack frame */
-	if (ka->sa.sa_flags & SA_SIGINFO)
-		setup_rt_frame(sig, ka, info, oldset, regs);
-	else
-		setup_frame(sig, ka, oldset, regs);
-
 	if (ka->sa.sa_flags & SA_ONESHOT)
 		ka->sa.sa_handler = SIG_DFL;
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sigmask_lock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
-		sigaddset(&current->blocked,sig);
-		recalc_sigpending(current);
-		spin_unlock_irq(&current->sigmask_lock);
+	/* Set up the stack frame */
+	if (! (ka->sa.sa_flags & SA_NOCALLHNDLR)) {
+		if (ka->sa.sa_flags & SA_SIGINFO)
+			setup_rt_frame(sig, ka, info, oldset, regs);
+		else
+			setup_frame(sig, ka, oldset, regs);
+
+		if (!(ka->sa.sa_flags & SA_NODEFER)) {
+			spin_lock_irq(&current->sigmask_lock);
+			sigorsets(&current->blocked,&current->blocked,
+				  &ka->sa.sa_mask);
+			sigaddset(&current->blocked,sig);
+			recalc_sigpending(current);
+			spin_unlock_irq(&current->sigmask_lock);
+		}
 	}
 }
 
--- ./include/asm-i386/signal.h.nocallhndlr	Wed Mar 27 10:56:12 2002
+++ ./include/asm-i386/signal.h	Wed Mar 27 11:17:38 2002
@@ -91,6 +91,7 @@
 #define SA_RESTART	0x10000000
 #define SA_NODEFER	0x40000000
 #define SA_RESETHAND	0x80000000
+#define SA_NOCALLHNDLR	0x00800000 /* Don't really call the handler. */
 
 #define SA_NOMASK	SA_NODEFER
 #define SA_ONESHOT	SA_RESETHAND

--------------030200030608020501090708--

