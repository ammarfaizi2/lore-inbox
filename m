Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264722AbTF0ToW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 15:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264733AbTF0ToW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 15:44:22 -0400
Received: from sponsa.its.UU.SE ([130.238.7.36]:8627 "EHLO sponsa.its.uu.se")
	by vger.kernel.org with ESMTP id S264722AbTF0ToR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 15:44:17 -0400
Date: Fri, 27 Jun 2003 21:58:14 +0200 (MEST)
Message-Id: <200306271958.h5RJwEmw023766@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org, shrybman@sympatico.ca
Subject: Re: 2.5.73-mm1 Uninitialised timer warnings
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Jun 2003 11:23:59 -0400, Shane Shrybman wrote:
>Below is my dmesg output which contains several uninitialized timer
>warnings. I assume someone wants to see them or else why print the
>warning. :-)
>
>BTW: Only three warnings during the compile of this kernel!
>
>Linux version 2.5.73-mm1 (shane@mars.goatskin.org) (gcc version 2.96
>20000731 (Mandrake Linux 8.2 2.96-0.76mdk)) #1 Fri Jun 27 10:47:16 EDT
>2003
...
>Uninitialised timer!
>This is just a warning.  Your computer is OK
>function=0xc01e9d60, data=0x0
>Call Trace:
> [<c0123a6e>] check_timer_failed+0x3e/0x50
> [<c01e9d60>] floppy_shutdown+0x0/0xb0
> [<c0123de8>] del_timer+0x18/0xb0
> [<c01e0321>] blk_init_queue+0x111/0x130
> [<c01e7ac1>] reschedule_timeout+0x21/0xa0
> [<c0304274>] floppy_init+0x144/0x530
> [<c01ec080>] do_fd_request+0x0/0x90
> [<c02f2789>] do_initcalls+0x39/0x90
> [<c0105098>] init+0x38/0x1a0
> [<c0105060>] init+0x0/0x1a0
> [<c0108a19>] kernel_thread_helper+0x5/0xc
>
>Floppy drive(s): fd0 is 1.44M

These warnings as the same as those resulting from building
2.5.73 with gcc-2.95, i.e., they are the result of gcc miscompiling
the empty structs that spinlocks reduce to on UP.

It's interesting to note that your Mandrake gcc-2.96 has this bug,
which previously was thought to be limited to gcc-2.95 and older.

Anyway, the fix is to revert patch-2.5.73's change to linux/spinlock.h.
The latest 2.5.73-bk includes the fix, or apply the patch below.

/Mikael

--- linux-2.5.73/include/linux/spinlock.h.~1~	2003-06-23 13:07:39.000000000 +0200
+++ linux-2.5.73/include/linux/spinlock.h	2003-06-23 22:58:29.000000000 +0200
@@ -146,8 +146,13 @@
 /*
  * gcc versions before ~2.95 have a nasty bug with empty initializers.
  */
-typedef struct { } spinlock_t;
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { }
+#if (__GNUC__ > 2)
+  typedef struct { } spinlock_t;
+  #define SPIN_LOCK_UNLOCKED (spinlock_t) { }
+#else
+  typedef struct { int gcc_is_buggy; } spinlock_t;
+  #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
+#endif
 
 /*
  * If CONFIG_SMP is unset, declare the _raw_* definitions as nops
