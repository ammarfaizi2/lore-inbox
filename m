Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266615AbSKUNPA>; Thu, 21 Nov 2002 08:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266649AbSKUNPA>; Thu, 21 Nov 2002 08:15:00 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:37030
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266615AbSKUNO7>; Thu, 21 Nov 2002 08:14:59 -0500
Date: Thu, 21 Nov 2002 08:15:35 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Dave Jones <davej@codemonkey.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][2.5] Add TAINT_UNKNOWN_STATE
In-Reply-To: <20021121130052.GB9883@suse.de>
Message-ID: <Pine.LNX.4.44.0211210811120.1628-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2002, Dave Jones wrote:

>  While you're in panic.c, want to add the missing flag for 
>  TAINT_FORCED_RMMOD that Rusty missed ? Maybe 'R' ?

Sure...

Index: linux-2.5.48/include/linux/kernel.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.48/include/linux/kernel.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 kernel.h
--- linux-2.5.48/include/linux/kernel.h	18 Nov 2002 05:11:13 -0000	1.1.1.1
+++ linux-2.5.48/include/linux/kernel.h	20 Nov 2002 06:29:39 -0000
@@ -103,6 +103,7 @@
 #define TAINT_FORCED_MODULE		(1<<1)
 #define TAINT_UNSAFE_SMP		(1<<2)
 #define TAINT_FORCED_RMMOD		(1<<3)
+#define TAINT_UNKNOWN_STATE		(1<<4)
 
 extern void dump_stack(void);
 
Index: linux-2.5.48/kernel/panic.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.48/kernel/panic.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 panic.c
--- linux-2.5.48/kernel/panic.c	18 Nov 2002 05:13:12 -0000	1.1.1.1
+++ linux-2.5.48/kernel/panic.c	21 Nov 2002 13:10:35 -0000
@@ -114,10 +114,12 @@
 {
 	static char buf[20];
 	if (tainted) {
-		snprintf(buf, sizeof(buf), "Tainted: %c%c%c",
+		snprintf(buf, sizeof(buf), "Tainted: %c%c%c%c%c",
 			tainted & TAINT_PROPRIETORY_MODULE ? 'P' : 'G',
 			tainted & TAINT_FORCED_MODULE ? 'F' : ' ',
-			tainted & TAINT_UNSAFE_SMP ? 'S' : ' ');
+			tainted & TAINT_UNSAFE_SMP ? 'S' : ' ',
+			tainted & TAINT_FORCED_RMMOD ? 'R' : ' ',
+			tainted & TAINT_UNKNOWN_STATE ? 'U' : ' ');
 	}
 	else
 		snprintf(buf, sizeof(buf), "Not tainted");
Index: linux-2.5.48/arch/i386/mm/fault.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.48/arch/i386/mm/fault.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 fault.c
--- linux-2.5.48/arch/i386/mm/fault.c	18 Nov 2002 05:11:52 -0000	1.1.1.1
+++ linux-2.5.48/arch/i386/mm/fault.c	21 Nov 2002 06:46:43 -0000
@@ -135,6 +135,7 @@
 	console_loglevel = 15;		/* NMI oopser may have shut the console up */
 	printk(" ");
 	console_loglevel = loglevel_save;
+	tainted |= TAINT_UNKNOWN_STATE;	/* flag that we've gone through one oops 'U' */
 }
 
 asmlinkage void do_invalid_op(struct pt_regs *, unsigned long);
Index: linux-2.5.48/lib/bust_spinlocks.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.48/lib/bust_spinlocks.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 bust_spinlocks.c
--- linux-2.5.48/lib/bust_spinlocks.c	18 Nov 2002 05:12:57 -0000	1.1.1.1
+++ linux-2.5.48/lib/bust_spinlocks.c	21 Nov 2002 06:46:12 -0000
@@ -34,6 +34,7 @@
 		printk(" ");
 		console_loglevel = loglevel_save;
 	}
+	tainted |= TAINT_UNKNOWN_STATE;	/* flag that we've gone through one oops 'U' */
 }
 
 
-- 
function.linuxpower.ca

