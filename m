Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbTDQKYV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 06:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbTDQKYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 06:24:21 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:30870 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261301AbTDQKYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 06:24:20 -0400
Date: Thu, 17 Apr 2003 12:36:07 +0200 (MEST)
Message-Id: <200304171036.h3HAa7nw024924@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: 0@pervalidus.tk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: CONFIG_X86_UP_APIC and CONFIG_X86_UP_IOAPIC won't allow me to connect with my ADSL
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, 16 Apr 2003 21:53:21 -0300 (BRT), 0@pervalidus.tk wrote:
>I just installed an ECS K7VTA3 5.0 and ADSL. I was using an
>ASUS A7S333 and cable modem.
>
>With a kernel compiled with CONFIG_X86_UP_APIC and
>CONFIG_X86_UP_IOAPIC adsl-start will timeout. adsl-connect also
>fails.

Any APIC or interrupt-related errors in the kernel log?

>With a kernel compiled without CONFIG_X86_UP_APIC and
>CONFIG_X86_UP_IOAPIC I can succesfully establish a connection.
...
>My APIC enabled dmesg is available at
>http://www.fredlwm.hpg.com.br/dmesg-2.4.20-APIC

Nothing suspicious in this one.

First thing to try:
Keep UP_APIC enabled but disable UP_IOAPIC.

If this doesn't help:
Apply the patch below, which fixes a known problem on some mainboards.

If the patch doesn't help:
Accept that your mainboard doesn't work with APIC (local or I/O) enabled.

/Mikael

--- linux-2.4.21-pre7/arch/i386/kernel/apic.c.~1~	2003-04-05 12:35:30.000000000 +0200
+++ linux-2.4.21-pre7/arch/i386/kernel/apic.c	2003-04-05 13:10:51.000000000 +0200
@@ -649,7 +649,6 @@
 	}
 	set_bit(X86_FEATURE_APIC, &boot_cpu_data.x86_capability);
 	mp_lapic_addr = APIC_DEFAULT_PHYS_BASE;
-	boot_cpu_physical_apicid = 0;
 	if (nmi_watchdog != NMI_NONE)
 		nmi_watchdog = NMI_LOCAL_APIC;
 
@@ -1169,8 +1168,7 @@
 
 	connect_bsp_APIC();
 
-	phys_cpu_present_map = 1;
-	apic_write_around(APIC_ID, boot_cpu_physical_apicid);
+	phys_cpu_present_map = 1 << boot_cpu_physical_apicid;
 
 	apic_pm_init2();
 
