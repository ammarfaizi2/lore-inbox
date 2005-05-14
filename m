Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262687AbVENGoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbVENGoW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 02:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbVENGoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 02:44:22 -0400
Received: from fire.osdl.org ([65.172.181.4]:20151 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262687AbVENGoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 02:44:16 -0400
Date: Fri, 13 May 2005 23:43:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tickle nmi watchdog whilst doing serial writes.
Message-Id: <20050513234331.0d097cb1.akpm@osdl.org>
In-Reply-To: <20050513184806.GA24166@redhat.com>
References: <20050513184806.GA24166@redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> This was fun. I inserted a music CD with some obnoxious copy-protection
>  on it into the drive, and lots of SCSI errors went zipping over to
>  the serial console. Unfortunatly, the box was also compiling a kernel,
>  playing oggs, and doing a number of other things at the same time,
>  so this happened..
> 
>  NMI Watchdog detected LOCKUP on CPU2CPU 2

OK..  But calling touch_nmi_watchdog() at 1MHz seems a bit excessive, and
might perturb the finely-tuned timing in there.

How's about this?

--- 25/drivers/serial/8250.c~tickle-nmi-watchdog-whilst-doing-serial-writes	2005-05-13 23:37:57.000000000 -0700
+++ 25-akpm/drivers/serial/8250.c	2005-05-13 23:41:36.000000000 -0700
@@ -40,6 +40,7 @@
 #include <linux/serial_core.h>
 #include <linux/serial.h>
 #include <linux/serial_8250.h>
+#include <linux/nmi.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -2098,9 +2099,10 @@ static inline void wait_for_xmitr(struct
 	/* Wait up to 1s for flow control if necessary */
 	if (up->port.flags & UPF_CONS_FLOW) {
 		tmout = 1000000;
-		while (--tmout &&
-		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0))
+		while (!(serial_in(up, UART_MSR) & UART_MSR_CTS) && --tmout)
 			udelay(1);
+		if (tmout < 1000000)
+			touch_nmi_watchdog();
 	}
 }
 
_

