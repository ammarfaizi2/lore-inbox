Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290069AbSAWUs2>; Wed, 23 Jan 2002 15:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290070AbSAWUsI>; Wed, 23 Jan 2002 15:48:08 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:26568 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S290069AbSAWUsF>; Wed, 23 Jan 2002 15:48:05 -0500
Date: Wed, 23 Jan 2002 14:00:45 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: [PATCH] kdb/mdb hardware breakpoints broken 2.4.17/18
Message-ID: <20020123140045.A17976@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Please find a patch that corrects the problem with hardware 
breakpoints not working with kdb.  I have noticed that gdb uses 
inserted int3 (0xCC) breakpoints (as does kdb) for soft breakpoint
support, so this fix may not affect these programs.  It is not 
clear why every signal handled is writing a 0 t the DR7 register.

Patch submitted to Keith Owens and Linux kernel.

Jeff


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-0123.kdb"

diff -Naur ./arch/i386/kernel/signal.c ../linux-new/./arch/i386/kernel/signal.c
--- ./arch/i386/kernel/signal.c	Fri Sep 14 15:15:40 2001
+++ ../linux-new/./arch/i386/kernel/signal.c	Wed Jan 23 13:26:07 2002
@@ -698,7 +698,9 @@
 		 * have been cleared if the watchpoint triggered
 		 * inside the kernel.
 		 */
-		__asm__("movl %0,%%db7"	: : "r" (current->thread.debugreg[7]));
+
+		if (current->thread.debugreg[7])
+		   __asm__("movl %0,%%db7"	: : "r" (current->thread.debugreg[7]));
 
 		/* Whee!  Actually deliver the signal.  */
 		handle_signal(signr, ka, &info, oldset, regs);

--SLDf9lqlvOQaIe6s--
