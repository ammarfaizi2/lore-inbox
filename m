Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317367AbSFXFpK>; Mon, 24 Jun 2002 01:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317374AbSFXFpJ>; Mon, 24 Jun 2002 01:45:09 -0400
Received: from [213.22.182.84] ([213.22.182.84]:20686 "HELO promiscua.org")
	by vger.kernel.org with SMTP id <S317367AbSFXFpI>;
	Mon, 24 Jun 2002 01:45:08 -0400
Date: 24 Jun 2002 05:49:59 -0000
Message-ID: <20020624054959.19187.qmail@promiscua.org>
From: pah@promiscua.org
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	I've just found a bug (an unsignificant bug) in the panic() function!
	There's a possible buffer overflow if the formated string exceeds
1024 characters (I think that the problem is in all kernel releases).
	The problem is in the use of vsprintf() insted of vsnprintf()!

	I know that this doesn't compromise any exploitation by an uid
different than zero, but should be fixed in the case of panic()'s arguments
exceeds the buffer limit (probably by an lkm or something like that) and
cause (probably) a system crash.

	Here is the exploitation by an lkm:


/************** LKM ***********/

/*
 * panic()'s buffer overflow test
 *
 * By: Pedro Hortas
 * E-Mail: pah@promiscua.org
 *
 */

#define __KERNEL__
#define MODULE

#define _LOOSE_KERNEL_NAMES

#include <linux/module.h>
#include <linux/kernel.h>

int init_module(void) {
        char foo[2048];
        int i;

        for (i = 0; i < sizeof(foo); i++)
                foo[i] = '\x90';
        foo[i - 1] = 0;
        panic("Overflowing panic()'s buffer: %s\n", foo);

        return 0;
}

int cleanup_module(void) {
        return 0;
}

/************* END OF LKM ************/


	And here is the patch to fix the problem:


/************* PATCH **************/

diff -urP linux/kernel/panic.c linux-patched/kernel/panic.c
--- linux/kernel/panic.c        Sun Sep 30 20:26:08 2001
+++ linux-patched/kernel/panic.c        Mon Jun 24 06:18:12 2002
@@ -51,7 +51,7 @@

        bust_spinlocks(1);
        va_start(args, fmt);
-       vsprintf(buf, fmt, args);
+       vsnprintf(buf, sizeof(buf), fmt, args);
        va_end(args);
        printk(KERN_EMERG "Kernel panic: %s\n",buf);
        if (in_interrupt())

/************** END OF PATCH *************/



	Pedro Hortas
	pah@promiscua.org
