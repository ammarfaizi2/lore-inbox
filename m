Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbTLTBwL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 20:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbTLTBwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 20:52:11 -0500
Received: from palrel11.hp.com ([156.153.255.246]:63134 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S263769AbTLTBwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 20:52:06 -0500
Date: Fri, 19 Dec 2003 17:52:00 -0800
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200312200152.hBK1q0I4016741@napali.hpl.hp.com>
To: ganesh@veritas.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: quick hack to make ipaq USB serial driver work again
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ipaq USB driver in 2.6.0 didn't work for me.  I got the attached
"Badness in local_bh_enable" backtrace when ppp tried to connect to my
iPaq.  The quick and dirty patch to avoid the problem is this patch:

===== drivers/usb/serial/ipaq.c 1.34 vs edited =====
--- 1.34/drivers/usb/serial/ipaq.c	Tue Sep 16 03:52:04 2003
+++ edited/drivers/usb/serial/ipaq.c	Fri Dec 19 17:28:20 2003
@@ -222,7 +222,11 @@
 	 * discipline instead of queueing.
 	 */
 
+#if 0
 	port->tty->low_latency = 1;
+#else
+	port->tty->low_latency = 0;
+#endif
 	port->tty->raw = 1;
 	port->tty->real_raw = 1;
 

I'm not quite sure of the root-cause of the problem.  It's quite
likely that the console output caused by WARN_ON() in softirq.c slows
down execution enough for the connection to fail, but clearly calling
local_bh_enable() with interrupts disabled isn't kosher either.

With the above workaround applied, I can now use SynCE's "pstatus" and
"pls" commands and they both seem to work fine.

Thanks,

	--david

Badness in local_bh_enable at kernel/softirq.c:121

Call Trace:
[<a00000010001bee0>] show_stack+0x80/0xa0
[<a0000001000a1870>] local_bh_enable+0x150/0x160
[<a0000002001f7070>] ppp_asynctty_receive+0x670/0x1080 [ppp_async]
[<a000000100348460>] flush_to_ldisc+0x140/0x260
[<a0000002001b9080>] ipaq_read_bulk_callback+0x360/0x640 [ipaq]
[<a000000100564b50>] usb_hcd_giveback_urb+0x150/0x240
[<a0000002001814a0>] finish_urb+0xe0/0x220 [ohci_hcd]
[<a0000002001831c0>] dl_done_list+0x260/0x320 [ohci_hcd]
[<a000000200185980>] ohci_irq+0x140/0x960 [ohci_hcd]
[<a000000100566ec0>] usb_hcd_irq+0xa0/0x120
[<a000000100018940>] handle_IRQ_event+0xa0/0x140
[<a0000001000195b0>] do_IRQ+0x2b0/0x440
[<a00000010001b050>] ia64_handle_irq+0x70/0x140
[<a000000100014fa0>] ia64_leave_kernel+0x0/0x260
[<a00000010037fb00>] serial_in+0x300/0x400
[<a0000001003858b0>] serial8250_console_write+0xf0/0x720
[<a000000100097b50>] __call_console_drivers+0x130/0x180
[<a000000100098440>] _call_console_drivers+0x1c0/0x1e0
[<a000000100098880>] release_console_sem+0x420/0x580
[<a000000100098ea0>] printk+0x300/0x4e0
[<a0000002001b9cd0>] ipaq_write+0x610/0x700 [ipaq]
[<a000000200148f50>] serial_write+0x1d0/0x2e0 [usbserial]
[<a0000002001f5d10>] ppp_async_push+0x250/0xd00 [ppp_async]
[<a0000002001f69d0>] ppp_async_send+0xd0/0x100 [ppp_async]
[<a000000200215ff0>] ppp_push+0x230/0x260 [ppp_generic]
[<a000000200216e10>] ppp_xmit_process+0x730/0xe80 [ppp_generic]
[<a0000002002184f0>] ppp_write+0x3d0/0x400 [ppp_generic]
[<a00000010011b4a0>] vfs_write+0x1c0/0x2e0
[<a00000010011b700>] sys_write+0x60/0xe0
[<a000000100014e20>] ia64_ret_from_syscall+0x0/0x20
