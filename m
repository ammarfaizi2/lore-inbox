Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSGUK3d>; Sun, 21 Jul 2002 06:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311898AbSGUK3d>; Sun, 21 Jul 2002 06:29:33 -0400
Received: from [196.26.86.1] ([196.26.86.1]:13280 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S311885AbSGUK3c>; Sun, 21 Jul 2002 06:29:32 -0400
Date: Sun, 21 Jul 2002 12:50:32 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Russell King <rmk@arm.linux.org.uk>
Cc: Brad Hards <bhards@bigpond.net.au>, Andrew Rodland <arodland@noln.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -ac] Panicking in morse code v3
In-Reply-To: <20020721100818.A22176@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207211234270.32636-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jul 2002, Russell King wrote:

> Otherwise it becomes a "toy" feature that doesn't have much value.
> What would be more useful would be to disable the console blank
> timer on a panic() so it doesn't blank half-way through someone
> reading the oops, leaving them with no way to read the rest of it!

I actually thought of that last night when it happened whilst examining an 
oops.

--- linux-2.5.25/kernel/panic.c.orig	Sun Jul 21 12:45:56 2002
+++ linux-2.5.25/kernel/panic.c	Sun Jul 21 12:09:42 2002
@@ -49,6 +49,9 @@
         unsigned long caller = (unsigned long) __builtin_return_address(0);
 #endif
 
+#ifdef CONFIG_VT
+	disable_console_blank();
+#endif
 	bust_spinlocks(1);
 	va_start(args, fmt);
 	vsprintf(buf, fmt, args);
--- linux-2.5.25/drivers/char/console.c.orig	Sun Jul 21 12:46:18 2002
+++ linux-2.5.25/drivers/char/console.c	Sun Jul 21 12:24:31 2002
@@ -2758,6 +2758,12 @@
 	timer_do_blank_screen(0, 1);
 }
 
+void disable_console_blank(void)
+{
+	del_timer_sync(&console_timer);
+	blankinterval = 0;
+}
+
 void poke_blanked_console(void)
 {
 	del_timer(&console_timer);
--- linux-2.5.25/include/linux/console.h.orig	Sun Jul 21 12:47:01 2002
+++ linux-2.5.25/include/linux/console.h	Sun Jul 21 12:25:42 2002
@@ -112,6 +112,7 @@
 extern void release_console_sem(void);
 extern void console_conditional_schedule(void);
 extern void console_unblank(void);
+extern void disable_console_blank(void);
 
 /* VESA Blanking Levels */
 #define VESA_NO_BLANKING        0

-- 
function.linuxpower.ca


