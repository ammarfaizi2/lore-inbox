Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbVINW2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbVINW2U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbVINW2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:28:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65441 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965077AbVINW1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:27:37 -0400
Date: Wed, 14 Sep 2005 15:27:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Peter Osterlund <petero2@telia.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.14-rc1 on ATI hangs when executing _STA and _INI methods
In-Reply-To: <m3y85z8flv.fsf@telia.com>
Message-ID: <Pine.LNX.4.58.0509141521370.26803@g5.osdl.org>
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org> <m3y85z8flv.fsf@telia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Sep 2005, Peter Osterlund wrote:
> 
> My Compaq Presario R3057EA hangs during ACPI initialization. The last
> message is "Executing all Device _STA and _INI methods". git bisect
> told me that:
> 
>   66759a01adbfe8828dd063e32cf5ed3f46696181 is first bad commit
>   diff-tree 66759a01adbfe8828dd063e32cf5ed3f46696181 (from 049cdefe19f95b67b06b70915cd8e4ae7173337a)
>   Author: Chuck Ebbert <76306.1226@compuserve.com>
>   Date:   Mon Sep 12 18:49:25 2005 +0200
> 
>     [PATCH] x86-64: i386/x86-64: Fix time going twice as fast problem on ATI Xpress chipsets
> 
> Passing enable_timer_pin_1 as a kernel boot parameter doesn't help,
> but this patch does:

Ok. That patch has been one big pain, and was clearly totally half-baked.  
I think I'll disable the automated checks, since they are clearly wrong.
You can still enable it manually with a kernel command line.

So something like this.. I assume this works for you?

		Linus

----
diff --git a/arch/i386/kernel/acpi/earlyquirk.c b/arch/i386/kernel/acpi/earlyquirk.c
--- a/arch/i386/kernel/acpi/earlyquirk.c
+++ b/arch/i386/kernel/acpi/earlyquirk.c
@@ -7,7 +7,6 @@
 #include <linux/pci.h>
 #include <asm/pci-direct.h>
 #include <asm/acpi.h>
-#include <asm/apic.h>
 
 static int __init check_bridge(int vendor, int device)
 {
@@ -16,15 +15,6 @@ static int __init check_bridge(int vendo
 	if (vendor == PCI_VENDOR_ID_NVIDIA) {
 		acpi_skip_timer_override = 1;
 	}
-#ifdef CONFIG_X86_LOCAL_APIC
-	/*
-	 * ATI IXP chipsets get double timer interrupts.
-	 * For now just do this for all ATI chipsets.
- 	 * FIXME: this needs to be checked for the non ACPI case too.
-	 */
-	if (vendor == PCI_VENDOR_ID_ATI)
-		disable_timer_pin_1 = 1;
-#endif
 	return 0;
 }
 
diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -299,15 +299,6 @@ void __init check_ioapic(void) 
 #endif
 					/* RED-PEN skip them on mptables too? */
 					return;
-				case PCI_VENDOR_ID_ATI:
-					/* All timer interrupts on atiixp
-				           are doubled. Disable one. */
-					if (disable_timer_pin_1 == 0) {
-						disable_timer_pin_1 = 1;
-						printk(KERN_INFO
-		"ATI board detected. Disabling timer pin 1.\n");
-					}
-					return;
 				} 
 
 				/* No multi-function device? */
