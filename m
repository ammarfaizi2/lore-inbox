Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbUCDWZx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 17:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbUCDWZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 17:25:53 -0500
Received: from smtp1.xandros.com ([209.87.236.18]:17123 "EHLO xandros.com")
	by vger.kernel.org with ESMTP id S261988AbUCDWZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 17:25:47 -0500
Message-ID: <4047AC21.2090102@netwinder.org>
Date: Thu, 04 Mar 2004 17:22:25 -0500
From: Woody Suwalski <woody@netwinder.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040216 Debian/1.6.x.1-10
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] Fix i8042 PS/2 mouse on ARM
References: <20040304192257.A13227@flint.arm.linux.org.uk>
In-Reply-To: <20040304192257.A13227@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Almost works.

Somehow the expectations of the line

/* defined in include/asm-arm/arch-*/irqs.h */

fails - the arch-ebsa285/irgs.h is not pulled in in time when compiling 
i8042.
Temporary hardcoded the I8042_KBD_IRQ and I8042_AUX_IRQ to test out, 
mouse works OK (good news!!!)

So small tweak to the build include sequence is still needed...

Woody


Russell King wrote:

>Vojtech,
>
>This patch is required on ARM so that we pick up the correct AUX
>interrupt number.  Some machines (eg, NetWinders) use IRQ5 instead
>of IRQ12 for the PS/2 mouse.
>
>Please comment, and let me know if you're happy to apply it, or
>whether you're happy for me to do so.
>
>Thanks.
>
>--- orig/drivers/input/serio/i8042-io.h	Tue Jun 17 12:56:28 2003
>+++ linux/drivers/input/serio/i8042-io.h	Thu Mar  4 19:21:28 2004
>@@ -25,6 +25,8 @@
> #elif defined(__ia64__)
> # define   isa_irq_to_vector(1)
> # define I8042_AUX_IRQ isa_irq_to_vector(12)
>+#elif defined(__arm__)
>+/* defined in include/asm-arm/arch-*/irqs.h */
> #else
> # define I8042_KBD_IRQ	1
> # define I8042_AUX_IRQ	12
>--- orig/include/asm-arm/arch-ebsa285/irqs.h	Mon May  5 17:40:03 2003
>+++ linux/include/asm-arm/arch-ebsa285/irqs.h	Thu Mar  4 19:20:22 2004
>@@ -91,8 +91,8 @@
> 
> #undef RTC_IRQ
> #define RTC_IRQ		IRQ_ISA_RTC_ALARM
>-#undef AUX_IRQ
>-#define AUX_IRQ		(machine_is_netwinder() ? IRQ_NETWINDER_PS2MOUSE : IRQ_ISA_PS2MOUSE)
>+#define I8042_KBD_IRQ	IRQ_ISA_KEYBOARD
>+#define I8042_AUX_IRQ	(machine_is_netwinder() ? IRQ_NETWINDER_PS2MOUSE : IRQ_ISA_PS2MOUSE)
> #define IRQ_FLOPPYDISK	IRQ_ISA_FLOPPY
> 
> #define irq_canonicalize(_i)	(((_i) == IRQ_ISA_CASCADE) ? IRQ_ISA_2 : _i)
>--- orig/include/asm-arm/arch-shark/irqs.h	Thu Nov 28 16:45:28 2002
>+++ linux/include/asm-arm/arch-shark/irqs.h	Thu Mar  4 19:21:02 2004
>@@ -8,5 +8,6 @@
> 
> #define IRQ_ISA_KEYBOARD	 1
> #define RTC_IRQ			 8
>-#define AUX_IRQ			12
>+#define I8042_KBD_IRQ		 1
>+#define I8042_AUX_IRQ		12
> #define IRQ_HARDDISK            14
>
>  
>

