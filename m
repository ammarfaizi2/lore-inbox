Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272963AbTHFAHf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 20:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272964AbTHFAHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 20:07:35 -0400
Received: from colin2.muc.de ([193.149.48.15]:48913 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S272963AbTHFAHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 20:07:22 -0400
Date: 6 Aug 2003 02:07:16 +0200
Date: Wed, 6 Aug 2003 02:07:16 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Export touch_nmi_watchdog
Message-ID: <20030806000716.GA68984@colin2.muc.de>
References: <20030805211416.GD31598@colin2.muc.de> <Pine.LNX.4.44.0308051503220.2835-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308051503220.2835-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 03:14:00PM -0700, Linus Torvalds wrote:
> 	#ifdef CONFIG_WATCHDOG
> 	#warning This driver does bad things and will not work
> 	#endif

Well the problem is that many of my multiple CPU testboxes have a fusion
controller (it's the standard on board chip on the AMD Quartet and Newisys
systems). 

At least for my testing it would be quite inconvenient to not
have the watchdog. I also don't see anybody comming around and fixing
the SCSI error handler of that driver (scsi error handlers seem
to be always very bad code, undoubtedly because it's a ugly problem)

(fortunately errors happen only infrequently, usually when I break
something else...) 

But still I would prefer the NMI watchdog not triggering then.

> So let the user know. Don't just silently say "let's kick the watchdog".

How about this approach: 

Define a new function driver_touch_watchdog() for export and it printks
something the first time it is used.

--- linux-2.6.0test2-amd64/arch/i386/kernel/nmi.c-o	2003-07-11 03:09:18.000000000 +0200
+++ linux-2.6.0test2-amd64/arch/i386/kernel/nmi.c	2003-08-06 02:03:41.000000000 +0200
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/nmi.h>
 #include <linux/sysdev.h>
+#include <linux/kallsyms.h>
 
 #include <asm/smp.h>
 #include <asm/mtrr.h>
@@ -455,3 +456,18 @@
 EXPORT_SYMBOL(enable_lapic_nmi_watchdog);
 EXPORT_SYMBOL(disable_timer_nmi_watchdog);
 EXPORT_SYMBOL(enable_timer_nmi_watchdog);
+
+/* Deprecated function to silence the NMI watchdog for long waits.
+   Better fix the driver instead of using this. */
+void driver_touch_watchdog(void)
+{ 
+	static int used; 
+	if (!used) { 
+		print_symbol(KERN_ERR "Function %s uses driver_touch_watchdog.\n",
+			     __builtin_return_address(0));
+	} 
+	used = 1;
+	touch_nmi_watchdog();
+}  
+
+EXPORT_SYMBOL(driver_touch_watchdog);

-Andi

