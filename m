Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264910AbUGGFPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264910AbUGGFPp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 01:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264911AbUGGFPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 01:15:45 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:6505 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264910AbUGGFPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 01:15:42 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.6.7-mm6
Date: Wed, 7 Jul 2004 00:15:37 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20040705023120.34f7772b.akpm@osdl.org> <200407061251.18702.dtor_core@ameritech.net> <20040706231256.GV21066@holomorphy.com>
In-Reply-To: <20040706231256.GV21066@holomorphy.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407070015.39507.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 July 2004 06:12 pm, William Lee Irwin III wrote:
> On Tuesday 06 July 2004 07:54 am, William Lee Irwin III wrote:
> >> Uneventful on alpha, needed a make rpm compilefix Andi's got queued for
> >> the next merge on x86-64 and otherwise uneventful there.
> >> OTOH, various things made sparc64 a living Hell that took about 9
> >> hours of solid compile/boot/crash drudgery to carry out bisection
> >> search on to find the offending patches.
> >> First, I had to back out bk-input because it has a sysfsification patch
> >> that deadlocks sunzilog.c at boot.
> 
> On Tue, Jul 06, 2004 at 12:51:16PM -0500, Dmitry Torokhov wrote:
> > Ok, I think I know what the problem is - it should be an oops rather than a
> > deadlock though - serial drivers are initialized before serio core when serio
> > bus structure is not registered with driver core yet. Could you please try
> > the patch below - I do not have hardware to test it:
> 
> Unfortunately this didn't repair it. Bootlog attached. The failure to
> respond to "send brk" indicates deadlock with interrupts disabled.
> 

The only suspicious thing that I see is that sunzilog tries to register its
serio ports with spinlock held and interrupts off. I wonder if that is what
causing a deadlock. Could you please try applying this patch on top of the
changes to the drivers/Makefile that I sent earlier.

-- 
Dmitry


===== drivers/serial/sunzilog.c 1.44 vs edited =====
--- 1.44/drivers/serial/sunzilog.c	2004-06-28 22:45:23 -05:00
+++ edited/drivers/serial/sunzilog.c	2004-07-06 23:46:54 -05:00
@@ -1529,7 +1529,6 @@
 static void __init sunzilog_init_kbdms(struct uart_sunzilog_port *up, int channel)
 {
 	int baud, brg;
-	struct serio *serio;
 
 	if (channel == KEYBOARD_LINE) {
 		up->flags |= SUNZILOG_FLAG_CONS_KEYB;
@@ -1546,8 +1545,15 @@
 	up->curregs[R15] = BRKIE;
 	brg = BPS_TO_BRG(baud, ZS_CLOCK / ZS_CLOCK_DIVISOR);
 	sunzilog_convert_to_zs(up, up->cflag, 0, brg);
+	sunzilog_set_mctrl(&up->port, TIOCM_DTR | TIOCM_RTS);
+	__sunzilog_startup(up);
+}
 
 #ifdef CONFIG_SERIO
+static void __init sunzilog_register_serio(struct uart_sunzilog_port *up, int channel)
+{
+	struct serio *serio;
+
 	up->serio = serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
 	if (serio) {
 
@@ -1576,11 +1582,8 @@
 		printk(KERN_WARNING "zs%d: not enough memory for serio port\n",
 			channel);
 	}
-#endif
-
-	sunzilog_set_mctrl(&up->port, TIOCM_DTR | TIOCM_RTS);
-	__sunzilog_startup(up);
 }
+#endif
 
 static void __init sunzilog_init_hw(void)
 {
@@ -1624,6 +1627,11 @@
 		}
 
 		spin_unlock_irqrestore(&up->port.lock, flags);
+
+#ifdef CONFIG_SERIO
+		if (i == KEYBOARD_LINE || i == MOUSE_LINE)
+			sunzilog_register_serio(up, i);
+#endif
 	}
 }
 
