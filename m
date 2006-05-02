Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbWEBS37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbWEBS37 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 14:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbWEBS37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 14:29:59 -0400
Received: from cantor2.suse.de ([195.135.220.15]:10664 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964960AbWEBS37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 14:29:59 -0400
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.17-rc1-mm3: time-i386-clocksource-drivers*.patch broke userspace apps
Date: Tue, 2 May 2006 20:29:04 +0200
User-Agent: KMail/1.9.1
Cc: Laurent Riffard <laurent.riffard@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Andrew Morton <akpm@osdl.org>
References: <4454B4A1.4060304@free.fr> <1146593819.21288.2.camel@cog.beaverton.ibm.com>
In-Reply-To: <1146593819.21288.2.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605022029.05333.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 May 2006 20:16, john stultz wrote:

> It looks like its from the patch:
> 	i386-x86-64-fix-acpi-disabled-lapic-handling.patch
> 
> 
> The second chunk adds:
> 
> +       if (!cpu_has_apic)
> +               return -ENODEV;
> +
> 
> Right before we probe for the ACPI PM timer.
> 
> 
> Andi, is there some way we can move that to after the ACPI PM probe?


Yes there was some merging trouble with this and some of the hunks 
applied to the wrong places and I didn't remove the wrong one 
in the first fixup patch. Sorry. This should fix it up.

Andrew, can you send that one to Linus please?

-Andi

Remove wrong cpu_has_apic checks that came from mismerging.

We only need to check cpu_has_apic in the IO-APIC/L-APIC parsing,
not for all of ACPI.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/i386/kernel/acpi/boot.c
===================================================================
--- linux.orig/arch/i386/kernel/acpi/boot.c
+++ linux/arch/i386/kernel/acpi/boot.c
@@ -1102,9 +1102,6 @@ int __init acpi_boot_table_init(void)
 	dmi_check_system(acpi_dmi_table);
 #endif
 
-	if (!cpu_has_apic)
-		return -ENODEV;
-
 	/*
 	 * If acpi_disabled, bail out
 	 * One exception: acpi=ht continues far enough to enumerate LAPICs
@@ -1151,9 +1148,6 @@ int __init acpi_boot_init(void)
 
 	acpi_table_parse(ACPI_BOOT, acpi_parse_sbf);
 
-	if (!cpu_has_apic)
-		return -ENODEV;
-
 	/*
 	 * set sci_int and PM timer address
 	 */
