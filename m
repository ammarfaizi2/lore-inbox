Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264088AbUFKPqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264088AbUFKPqo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 11:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbUFKPqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 11:46:43 -0400
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:47915 "EHLO
	smtp-out2.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S264088AbUFKPqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 11:46:14 -0400
Message-ID: <40C9D3C1.4040108@blueyonder.co.uk>
Date: Fri, 11 Jun 2004 16:46:09 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm1 (nforce2 lockup)
References: <A6974D8E5F98D511BB910002A50A6647615FD33E@hdsmsx403.hd.intel.com> <200406050937.29163.bjorn.helgaas@hp.com> <40C2444B.4080403@blueyonder.co.uk> <200406101651.23895.bjorn.helgaas@hp.com>
In-Reply-To: <200406101651.23895.bjorn.helgaas@hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jun 2004 15:46:14.0465 (UTC) FILETIME=[3A155B10:01C44FCB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch applied, boot with "lnoapic" and without works. In 
/var/log/boot.msg there were lines saying "APIC enabled" and "APIC probe 
not done" with option "lnoapic", sorry I didn't save boot.msg that time.
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
Regards
Sid.

Bjorn Helgaas wrote:

>Hi Sid,
>
>Can you try the attached patch, please?  I reproduced the problem on
>my Proliant DL360, and this patch fixes it for me.
>
>The problem was that drivers/serial/8250_acpi.c found COM1 in the
>ACPI namespace and called acpi_register_gsi() to set up its IRQ.
>ACPI tells us that the COM1 IRQ is edge triggered, active high,
>but acpi_register_gsi() was ignoring the edge_level argument,
>so it blindly set the COM1 IRQ to be level-triggered.
>
>This is against 2.6.7-rc3-mm1.
>
>diff -u -Nur linux-2.6.7-rc3-mm1.orig/arch/i386/kernel/acpi/boot.c linux-2.6.7-rc3-mm1/arch/i386/kernel/acpi/boot.c
>--- linux-2.6.7-rc3-mm1.orig/arch/i386/kernel/acpi/boot.c	2004-06-10 16:26:55.000000000 -0600
>+++ linux-2.6.7-rc3-mm1/arch/i386/kernel/acpi/boot.c	2004-06-10 16:30:22.000000000 -0600
>@@ -451,10 +451,12 @@
> 		static u16 irq_mask;
> 		extern void eisa_set_level_irq(unsigned int irq);
> 
>-		if ((gsi < 16) && !((1 << gsi) & irq_mask)) {
>-			Dprintk(KERN_DEBUG PREFIX "Setting GSI %u as level-triggered\n", gsi);
>-			irq_mask |= (1 << gsi);
>-			eisa_set_level_irq(gsi);
>+		if (edge_level == ACPI_LEVEL_SENSITIVE) {
>+			if ((gsi < 16) && !((1 << gsi) & irq_mask)) {
>+				Dprintk(KERN_DEBUG PREFIX "Setting GSI %u as level-triggered\n", gsi);
>+				irq_mask |= (1 << gsi);
>+				eisa_set_level_irq(gsi);
>+			}
> 		}
> 	}
> #endif
>
>
>
>  
>


-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
===== LINUX ONLY USED HERE =====

