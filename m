Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbVLLKD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbVLLKD3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 05:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVLLKD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 05:03:29 -0500
Received: from ns.suse.de ([195.135.220.2]:50114 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751178AbVLLKD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 05:03:28 -0500
Date: Mon, 12 Dec 2005 11:03:18 +0100
From: Olaf Hering <olh@suse.de>
To: Erik Mouw <erik@harddisk-recovery.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Sachin Sant <sachinp@in.ibm.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] Adding ctrl-o sysrq hack support to 8250 driver
Message-ID: <20051212100318.GA10040@suse.de>
References: <20051209140559.GA23868@suse.de> <20051209152530.GE15372@harddisk-recovery.com> <20051209170841.GB31708@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20051209170841.GB31708@flint.arm.linux.org.uk>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Dec 09, Russell King wrote:

> On Fri, Dec 09, 2005 at 04:25:31PM +0100, Erik Mouw wrote:
> > If you really want to use ctrl-o, could you make a way that pressing
> > ctrl-o twice sends a single ctrl-o to the process attached to the
> > console?
> 
> That's already handled by adding uart_handle_break() - the first call
> to this function will set sysrq status and return 1 (ignore character).
> The second call will clear sysrq status and return 0 (don't ignore).

Russel,
are you ok with the arch specific approach? I could trim it down further
by checking the model type in the device-tree, somewhere in
arch/powerpc/kernel/setup-common.c.


 drivers/serial/8250.c        |    6 ++++++
 include/asm-powerpc/serial.h |   19 +++++++++++++++++++
 2 files changed, 25 insertions(+)

Index: linux-2.6.15-rc5-olh/drivers/serial/8250.c
===================================================================
--- linux-2.6.15-rc5-olh.orig/drivers/serial/8250.c
+++ linux-2.6.15-rc5-olh/drivers/serial/8250.c
@@ -85,6 +85,8 @@ static unsigned int share_irqs = SERIAL8
 #define CONFIG_SERIAL_MANY_PORTS 1
 #endif
 
+#define arch_8250_sysrq_via_ctrl_o(x) (0)
+
 /*
  * HUB6 is always on.  This will be removed once the header
  * files have been cleaned.
@@ -1154,6 +1156,10 @@ receive_chars(struct uart_8250_port *up,
 			 */
 		}
 		ch = serial_inp(up, UART_RX);
+
+		if (arch_8250_sysrq_via_ctrl_o(ch, &up->port))
+			goto ignore_char;
+
 		flag = TTY_NORMAL;
 		up->port.icount.rx++;
 
Index: linux-2.6.15-rc5-olh/include/asm-powerpc/serial.h
===================================================================
--- linux-2.6.15-rc5-olh.orig/include/asm-powerpc/serial.h
+++ linux-2.6.15-rc5-olh/include/asm-powerpc/serial.h
@@ -15,4 +15,23 @@
 /* Default baud base if not found in device-tree */
 #define BASE_BAUD ( 1843200 / 16 )
 
+
+#if defined(SUPPORT_SYSRQ) && defined(CONFIG_PPC_PSERIES)
+	/*
+	 * Handle the SysRq ^O Hack also via ttyS0 on POWER4 systems
+	 * but only on the system console
+	 * affected Models:
+	 * p690 7040-681
+	 * p670 7040-671
+	 * p655 7039-651
+	 * p650 7038-6M2
+	 * p630 7028-6E4 tower
+	 * p630 7028-6C4 rack
+	 * p615 7029-6E3 tower
+	 * p615 7029-6C3 rack
+	 */
+#undef arch_8250_sysrq_via_ctrl_o
+#define arch_8250_sysrq_via_ctrl_o(ch, port) ((ch) == '\x0f' && uart_handle_break((port)))
+#endif
+
 #endif /* _PPC64_SERIAL_H */
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
