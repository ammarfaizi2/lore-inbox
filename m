Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262689AbVENG6C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbVENG6C (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 02:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262690AbVENG6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 02:58:02 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52711 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262689AbVENG55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 02:57:57 -0400
Date: Sat, 14 May 2005 02:57:53 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tickle nmi watchdog whilst doing serial writes.
Message-ID: <20050514065753.GA28213@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050513184806.GA24166@redhat.com> <20050513234331.0d097cb1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050513234331.0d097cb1.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 11:43:31PM -0700, Andrew Morton wrote:
 > Dave Jones <davej@redhat.com> wrote:
 > >
 > > This was fun. I inserted a music CD with some obnoxious copy-protection
 > >  on it into the drive, and lots of SCSI errors went zipping over to
 > >  the serial console. Unfortunatly, the box was also compiling a kernel,
 > >  playing oggs, and doing a number of other things at the same time,
 > >  so this happened..
 > > 
 > >  NMI Watchdog detected LOCKUP on CPU2CPU 2
 > 
 > OK..  But calling touch_nmi_watchdog() at 1MHz seems a bit excessive, and
 > might perturb the finely-tuned timing in there.
 > 
 > How's about this?

Umm..  Despite it being past my bedtime, I'm pretty sure I'm
missing something here...

 > +		while (!(serial_in(up, UART_MSR) & UART_MSR_CTS) && --tmout)
 >  			udelay(1);

I don't see how this is any better than the current code.
We're doing 1000000 udelays. Whilst we're doing that,
the nmi watchdog goes bonkers.
 
 > +		if (tmout < 1000000)
 > +			touch_nmi_watchdog();

So by the time we do this, its already triggered.

How about..

--- linux-2.6.11/drivers/serial/8250.c~	2005-05-14 02:49:02.000000000 -0400
+++ linux-2.6.11/drivers/serial/8250.c	2005-05-14 02:54:30.000000000 -0400
@@ -40,6 +40,7 @@
 #include <linux/serial_core.h>
 #include <linux/serial.h>
 #include <linux/serial_8250.h>
+#include <linux/nmi.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -2099,8 +2100,15 @@ static inline void wait_for_xmitr(struct
 	if (up->port.flags & UPF_CONS_FLOW) {
 		tmout = 1000000;
 		while (--tmout &&
-		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0))
+		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0)) {
+			int cnt=0;
 			udelay(1);
+			cnt++;
+			if (cnt==100) {
+				touch_nmi_watchdog();
+				cnt=0;
+			}
+		}
 	}
 }
 
Signed-off-by: Dave Jones <davej@redhat.com>

totally uncompiled & untested. I'm not even sure about
that magic '100'. I'll let someone less sleep-deprived
than myself choose a better number.

		Dave


