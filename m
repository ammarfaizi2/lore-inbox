Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132483AbRDNReq>; Sat, 14 Apr 2001 13:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132496AbRDNReg>; Sat, 14 Apr 2001 13:34:36 -0400
Received: from colorfullife.com ([216.156.138.34]:8965 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132483AbRDNRe2>;
	Sat, 14 Apr 2001 13:34:28 -0400
Message-ID: <3AD88A00.DF54EC12@colorfullife.com>
Date: Sat, 14 Apr 2001 19:33:52 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: alan@lxorguk.ukuu.org.uk
CC: Rod Stewart <stewart@dystopia.lab43.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Re: 8139too: defunct threads
In-Reply-To: <Pine.LNX.4.33.0104141219450.11838-100000@dystopia.lab43.org>
Content-Type: multipart/mixed;
 boundary="------------F59FABA7589B6F1D8C3B84C9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F59FABA7589B6F1D8C3B84C9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Alan,

Rod's init version (from RH 7.0) doesn't reap children that died before
it was started. Is that an init bug or should the kernel reap them
before the execve?
The attached patch reaps all zombies before the execve("/sbin/init").

I also found a bug in kernel/context.c: it doesn't acquire the sigmask
spinlock around the call to recalc_sigpending.

Rod Stewart wrote:
> 
> Yes, that fixes my problem.  No more defunct eth? processes when IP_PNP is
> compiled in.  With the fix you said to the patch; replacing curtask with
> current.
>
Fortunately you don't use SMP - spin_lock_irq();...;spin_lock_irq()
instead of spin_lock_irq();...;spin_unlock_irq();

--
	Manfred
--------------F59FABA7589B6F1D8C3B84C9
Content-Type: text/plain; charset=us-ascii;
 name="patch-child"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-child"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 3
//  EXTRAVERSION = -ac3
--- 2.4/init/main.c	Sat Apr  7 22:02:27 2001
+++ build-2.4/init/main.c	Sat Apr 14 19:18:34 2001
@@ -883,6 +883,13 @@
 
 	(void) dup(0);
 	(void) dup(0);
+
+	while (waitpid(-1, (unsigned int *)0, __WALL|WNOHANG) > 0)
+		;
+	spin_lock_irq(&current->sigmask_lock);
+	flush_signals(current);
+	recalc_sigpending(current);
+	spin_unlock_irq(&current->sigmask_lock);
 	
 	/*
 	 * We try each of these until one succeeds.
--- 2.4/kernel/context.c	Fri Feb  2 15:20:37 2001
+++ build-2.4/kernel/context.c	Sat Apr 14 19:09:10 2001
@@ -101,8 +101,10 @@
 		if (signal_pending(curtask)) {
 			while (waitpid(-1, (unsigned int *)0, __WALL|WNOHANG) > 0)
 				;
+			spin_lock_irq(&curtask->sigmask_lock);
 			flush_signals(curtask);
 			recalc_sigpending(curtask);
+			spin_unlock_irq(&curtask->sigmask_lock);
 		}
 	}
 }



--------------F59FABA7589B6F1D8C3B84C9--


