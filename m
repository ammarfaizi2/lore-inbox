Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272601AbTG3BtK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 21:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272615AbTG3BtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 21:49:10 -0400
Received: from [66.212.224.118] ([66.212.224.118]:50193 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S272601AbTG3BtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 21:49:04 -0400
Date: Tue, 29 Jul 2003 21:37:26 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Jamie Lokier <jamie@shareable.org>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       James Simmons <jsimmons@infradead.org>, Charles Lepple <clepple@ghz.cc>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Turning off automatic screen clanking
In-Reply-To: <20030730012533.GA18663@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.53.0307292136050.11053@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0307291750170.5874-100000@phoenix.infradead.org>
 <Pine.LNX.4.53.0307291338260.6166@chaos> <Pine.LNX.4.53.0307292015580.11053@montezuma.mastecende.com>
 <20030730012533.GA18663@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jul 2003, Jamie Lokier wrote:

> One of Richard's points is that there is presently no way to fix the
> box in userspace.  If the kernel crashes during boot, it will blank
> the screen and there is no way to unblank it in that state.

Well something like this should work without complicating things during 
panic.

Index: linux-2.6.0-test2/arch/i386/kernel/traps.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test2/arch/i386/kernel/traps.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 traps.c
--- linux-2.6.0-test2/arch/i386/kernel/traps.c	30 Jul 2003 00:06:00 -0000	1.1.1.1
+++ linux-2.6.0-test2/arch/i386/kernel/traps.c	30 Jul 2003 01:34:12 -0000
@@ -248,6 +248,7 @@ bug:
 }
 
 spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
+int dont_blank_on_panic;
 
 void die(const char * str, struct pt_regs * regs, long err)
 {
@@ -261,8 +262,11 @@ void die(const char * str, struct pt_reg
 	show_registers(regs);
 	bust_spinlocks(0);
 	spin_unlock_irq(&die_lock);
-	if (in_interrupt())
+	if (in_interrupt()) {
+		dont_blank_on_panic = 1;
+		barrier();
 		panic("Fatal exception in interrupt");
+	}
 
 	if (panic_on_oops) {
 		printk(KERN_EMERG "Fatal exception: panic in 5 seconds\n");
Index: linux-2.6.0-test2/drivers/char/vt.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test2/drivers/char/vt.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vt.c
--- linux-2.6.0-test2/drivers/char/vt.c	30 Jul 2003 00:06:17 -0000	1.1.1.1
+++ linux-2.6.0-test2/drivers/char/vt.c	30 Jul 2003 01:33:41 -0000
@@ -2696,10 +2696,11 @@ static void vesa_powerdown_screen(unsign
 
 static void timer_do_blank_screen(int entering_gfx, int from_timer_handler)
 {
+	extern int dont_blank_on_panic;
 	int currcons = fg_console;
 	int i;
 
-	if (console_blanked)
+	if (console_blanked || dont_blank_on_panic)
 		return;
 
 	/* entering graphics mode? */
-- 
function.linuxpower.ca
