Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbTFGKUz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 06:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbTFGKUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 06:20:55 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:51434 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262955AbTFGKUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 06:20:53 -0400
Date: Sat, 7 Jun 2003 12:34:20 +0200 (MEST)
Message-Id: <200306071034.h57AYKoq021460@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: mochel@osdl.org
Subject: Re: [RFC] New system device API
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jun 2003 18:18:30 -0700 (PDT), Patrick Mochel wrote:
>--- 1.38/arch/i386/kernel/apic.c	Sun May 25 23:19:09 2003
>+++ edited/arch/i386/kernel/apic.c	Fri Jun  6 17:45:42 2003
...
>-static struct device_driver lapic_driver = {
>-	.name		= "lapic",
>-	.bus		= &system_bus_type,
>+
>+static struct sysdev_class lapic_sysclass = {
>+	set_kset_name("lapic"),
> 	.resume		= lapic_resume,
> 	.suspend	= lapic_suspend,
> };
> 
>-/* not static, needed by child devices */
>-struct sys_device device_lapic = {
>-	.name		= "lapic",
>-	.id		= 0,
>-	.dev		= {
>-		.name	= "lapic",
>-		.driver	= &lapic_driver,
>-	},
>+static struct sys_device device_lapic = {
>+	.id	= 0,
>+	.cls	= &lapic_sysclass,
> };
>-EXPORT_SYMBOL(device_lapic);

Why did you ignore the 'not static' comment, and why remove
the EXPORT? They're there for a reason...

>--- 1.18/arch/i386/kernel/nmi.c	Sat Apr 12 14:26:35 2003
>+++ edited/arch/i386/kernel/nmi.c	Fri Jun  6 17:46:05 2003
...
>-static struct device_driver lapic_nmi_driver = {
>-	.name		= "lapic_nmi",
>-	.bus		= &system_bus_type,
>+
>+static struct sysdev_class nmi_sysclass = {
>+	set_kset_name("lapic_nmi"),
> 	.resume		= lapic_nmi_resume,
> 	.suspend	= lapic_nmi_suspend,
> };
> 
> static struct sys_device device_lapic_nmi = {
>-	.name		= "lapic_nmi",
>-	.id		= 0,
>-	.dev		= {
>-		.name	= "lapic_nmi",
>-		.driver	= &lapic_nmi_driver,
>-		.parent = &device_lapic.dev,
>-	},
>+	.id	= 0,
>+	.cls	= &nmi_sysclass,
> };

Unless I'm missing something, you've just broken the hierarchical
relationship that exists between the local APIC device and its
client devices (NMI watchdog, oprofile [which you didn't convert],
and perfctr [not merged into Linus' tree]).

It's very important that the clients devices are suspended before
the local APIC is, and that the local APIC is resumed before the
clients are. I don't see how your rewrite can ensure this ordering.

/Mikael
