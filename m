Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbVLIUri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbVLIUri (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 15:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbVLIUri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 15:47:38 -0500
Received: from cantor2.suse.de ([195.135.220.15]:8326 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932428AbVLIUri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 15:47:38 -0500
Date: Fri, 9 Dec 2005 21:47:36 +0100
From: Olaf Hering <olh@suse.de>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Sachin Sant <sachinp@in.ibm.com>
Subject: Re: [PATCH] Adding ctrl-o sysrq hack support to 8250 driver
Message-ID: <20051209204736.GA5637@suse.de>
References: <20051209140559.GA23868@suse.de> <20051209152530.GE15372@harddisk-recovery.com> <20051209153433.GB26963@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20051209153433.GB26963@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Dec 09, Olaf Hering wrote:

> > If it is a POWER4-only problem, why isn't there a dependency on
> > CONFIG_POWER4 over here? I don't like to have the ctrl-o sysrq stuff
> > enabled on my regular PC if it only matters to some rare (in absolute
> > numbers) system.

The system with the build tree on it just crashed hard.
Thats what I saved from the screen session:

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
+               if (arch_8250_sysrq_via_ctrl_o(ch, &up->port))
+                       goto ignore_char;
+
                flag = TTY_NORMAL;
                up->port.icount.rx++;

Index: linux-2.6.15-rc5-olh/include/asm-powerpc/serial.h
===================================================================
--- linux-2.6.15-rc5-olh.orig/include/asm-powerpc/serial.h
+++ linux-2.6.15-rc5-olh/include/asm-powerpc/serial.h
@@ -15,4 +15,11 @@
 /* Default baud base if not found in device-tree */
 #define BASE_BAUD ( 1843200 / 16 )

+
+#if defined(SUPPORT_SYSRQ) && defined(CONFIG_PPC_PSERIES)
+       /* Handle the SysRq ^O Hack, but only on the system console */
+#undef arch_8250_sysrq_via_ctrl_o
+#define arch_8250_sysrq_via_ctrl_o(ch, port) ((ch) == '\x0f' && uart_handle_break((port)))
+#endif
+
 #endif /* _PPC64_SERIAL_H */



-- 
short story of a lazy sysadmin:
 alias appserv=wotan
