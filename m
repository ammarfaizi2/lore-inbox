Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269452AbUJSPPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269452AbUJSPPV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 11:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269456AbUJSPPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 11:15:20 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2432 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S269452AbUJSPPD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 11:15:03 -0400
Date: Tue, 19 Oct 2004 11:14:47 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Register corruption --patch
Message-ID: <Pine.LNX.4.61.0410191112100.4820@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This 'C' compiler destroys parameters passed to functions
even though the code does not alter that parameter.

gcc (GCC) 3.3.3 20040412 (Red Hat Linux 3.3.3-7)
Copyright (C) 2003 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

For instance:

asmlinkage void __up(struct semaphore *sem)
{
     wake_up(&sem->wait);
}

This was from /usr/src/linux-2.6.9/arch/i386/kernel/semaphore.c
It this case, the value of 'sem' is destroyed which means that
certain assembly-language helper functions no longer work.

This was discovered by Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>

I have been having trouble with mysterious things like:

(1) Code that sleeps while holding a semaphore sometimes never
releases that semaphore.
(2) SCSI disk files disappearing after boot.
(3) SCSI disk corruption preventing mounting after a boot.
(4) Data errors in email.
(5) Network connections failing to go away `netstat -c` shows
hundreds of lines of very old history.
... etc.

The 'C' compiler is provided in a recent Fedora distribution.

The following patch seems to fix it all!


--- linux-2.6.9/arch/i386/kernel/semaphore.c.orig	2004-08-14 01:36:56.000000000 -0400
+++ linux-2.6.9/arch/i386/kernel/semaphore.c	2004-10-19 08:06:15.000000000 -0400
@@ -198,9 +198,11 @@
  #endif
  	"pushl %eax\n\t"
  	"pushl %edx\n\t"
-	"pushl %ecx\n\t"
+	"pushl %ecx\n\t"	// Register to save
+	"pushl %ecx\n\t"	// Passed parameter
  	"call __down\n\t"
-	"popl %ecx\n\t"
+	"addl $0x04, %esp\t\n"	// Bypass corrupted parameter
+	"popl %ecx\n\t"		// Restore original
  	"popl %edx\n\t"
  	"popl %eax\n\t"
  #if defined(CONFIG_FRAME_POINTER)
@@ -220,9 +222,11 @@
  	"movl  %esp,%ebp\n\t"
  #endif
  	"pushl %edx\n\t"
-	"pushl %ecx\n\t"
+	"pushl %ecx\n\t"	// Save register
+	"pushl %ecx\n\t"	// Passed parameter
  	"call __down_interruptible\n\t"
-	"popl %ecx\n\t"
+	"addl $0x04, %esp\n\t"	// Bypass corrupted parameter
+	"popl %ecx\n\t"		// Restore register
  	"popl %edx\n\t"
  #if defined(CONFIG_FRAME_POINTER)
  	"movl %ebp,%esp\n\t"
@@ -241,9 +245,11 @@
  	"movl  %esp,%ebp\n\t"
  #endif
  	"pushl %edx\n\t"
-	"pushl %ecx\n\t"
+	"pushl %ecx\n\t"		// Save register
+	"pushl %ecx\n\t"		// Passed parameter
  	"call __down_trylock\n\t"
-	"popl %ecx\n\t"
+	"addl $0x04, %esp\n\t"		// Bypass corrupted parameter
+	"popl %ecx\n\t"			// Restore register
  	"popl %edx\n\t"
  #if defined(CONFIG_FRAME_POINTER)
  	"movl %ebp,%esp\n\t"
@@ -259,9 +265,11 @@
  "__up_wakeup:\n\t"
  	"pushl %eax\n\t"
  	"pushl %edx\n\t"
-	"pushl %ecx\n\t"
+	"pushl %ecx\n\t"	// Save register
+	"pushl %ecx\n\t"	// Passed parameter
  	"call __up\n\t"
-	"popl %ecx\n\t"
+	"addl $0x04, %esp\n\t"	// Bypass corrupted parameter
+	"popl %ecx\n\t"		// Restore register
  	"popl %edx\n\t"
  	"popl %eax\n\t"
  	"ret"


I think these 'helper' functions are no longer useful because
they counted on a certain behavior of a 'C' compiler. This
behavior may not continue to exist. This patch is a temporary
solution to the observed problem. The correct solution is
probably to get rid of these 'helper' functions altogether.

Linus, please check this out.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
Why is the government concerned about the lunitic fringe? Think about it!

