Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310206AbSDDTUP>; Thu, 4 Apr 2002 14:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293632AbSDDTUH>; Thu, 4 Apr 2002 14:20:07 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:52929 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S293603AbSDDTSW>;
	Thu, 4 Apr 2002 14:18:22 -0500
Message-ID: <3CACA6E5.9080005@acm.org>
Date: Thu, 04 Apr 2002 13:17:57 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Patrick R. McManus" <mcmanus@ducksong.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre4-ac4 kills my gdm
In-Reply-To: <20020404142308.GA1177@ducksong.com> <E16t8yO-00068s-00@the-village.bc.nu> <20020404162112.GA1171@ducksong.com>
Content-Type: multipart/mixed;
 boundary="------------040400050600030902020804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040400050600030902020804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

  Patrick R. McManus wrote:

>Alan,
>
>mea culpa on this one - my problem appears to be with the only other
>patch I was running - I believed I was also running it on ac3, but it
>now appears that I was thinking of another box.
>
>The other patch was corey minyard's "allow signal handler to not call
>handler" patch that I was interested in seeing its impact on a
>userspace project of mine. It kills gdm (at least with ac4.. maybe
>others?)
>
>thanks,
>-Pat
>
Yet, it does seem to kill gdm. xdm and kdm seem to work fine.

Ok, I see the problem. I've fixed it, booted and tried gdm, and it works 
fine. The SA_ONESHOT was checked in the wrong place, the handler is set 
in the frame_setup routines, so I have to check and set the handler due 
to the SA_ONESHOT flag after this. The patch is attached.

-Corey



--------------040400050600030902020804
Content-Type: text/plain;
 name="linux-nocallhndlr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-nocallhndlr.patch"

--- ./arch/i386/kernel/signal.c.nocallhndlr	Wed Mar 27 10:56:29 2002
+++ ./arch/i386/kernel/signal.c	Thu Apr  4 13:10:30 2002
@@ -558,22 +558,25 @@
 		}
 	}
 
-	/* Set up the stack frame */
-	if (ka->sa.sa_flags & SA_SIGINFO)
-		setup_rt_frame(sig, ka, info, oldset, regs);
-	else
-		setup_frame(sig, ka, oldset, regs);
+	/* Set up the stack frame if we are calling the handler. */
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
+	}
 
 	if (ka->sa.sa_flags & SA_ONESHOT)
 		ka->sa.sa_handler = SIG_DFL;
-
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sigmask_lock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
-		sigaddset(&current->blocked,sig);
-		recalc_sigpending(current);
-		spin_unlock_irq(&current->sigmask_lock);
-	}
 }
 
 /*
--- ./include/asm-i386/signal.h.nocallhndlr	Wed Mar 27 10:56:12 2002
+++ ./include/asm-i386/signal.h	Thu Apr  4 13:02:07 2002
@@ -91,6 +91,7 @@
 #define SA_RESTART	0x10000000
 #define SA_NODEFER	0x40000000
 #define SA_RESETHAND	0x80000000
+#define SA_NOCALLHNDLR	0x00800000 /* Don't really call the handler. */
 
 #define SA_NOMASK	SA_NODEFER
 #define SA_ONESHOT	SA_RESETHAND

--------------040400050600030902020804--

