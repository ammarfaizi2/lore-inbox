Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267253AbTBIN5t>; Sun, 9 Feb 2003 08:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267261AbTBIN5t>; Sun, 9 Feb 2003 08:57:49 -0500
Received: from kim.it.uu.se ([130.238.12.178]:36227 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S267253AbTBIN5q>;
	Sun, 9 Feb 2003 08:57:46 -0500
Date: Sun, 9 Feb 2003 15:07:27 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200302091407.PAA14076@kim.it.uu.se>
To: pavel@ucw.cz
Subject: Re: Switch APIC (+nmi, +oprofile) to driver model
Cc: levon@movementarian.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Feb 2003 12:32:01 +0100, Pavel Machek wrote:
>Here's next attempt at moving APIC (+nmi, +oprofile) to the driver
>model. If it looks good I'l submit it to Linus.

I'm sorry to be a killjoy, but this still doesn't look right.

>--- clean/arch/i386/kernel/apic.c	2003-01-05 22:58:18.000000000 +0100
>+++ linux-swsusp/arch/i386/kernel/apic.c	2003-02-03 16:36:41.000000000 +0100
>-static void apic_pm_resume(void *data)
>+static int apic_resume(struct device *dev, u32 level)
> {
> 	unsigned int l, h;
> 	unsigned long flags;
> 
>+	if (level != RESUME_POWER_ON)
>+		return 0;
>+
>+	set_fixmap_nocache(FIX_APIC_BASE, apic_phys);		/* FIXME: this is needed for S3 resume, but why? */

This is horrible! The only reason this might be needed is if
the page tables weren't restored properly at resume, and that
indicates a bug somewhere else.

Also, apic_phys is (or should be) APIC_DEFAULT_PHYS_BASE, so
you shouldn't need to make apic_phys global.

>+static struct device_driver apic_driver = {
>+	.name		= "apic",
>+	.bus		= &system_bus_type,
>+	.resume		= apic_resume,
>+	.suspend	= apic_suspend,
>+};
...
>+static int __init init_apic_devicefs(void)
> {
>+	driver_register(&apic_driver);
> 	if (apic_pm_state.active)
>-		pm_register(PM_SYS_DEV, 0, apic_pm_callback);
>+		return sys_device_register(&device_apic);
>+	return 0;
...
>+device_initcall(init_apic_devicefs);

init_apic_devicefs() registers apic_driver even if active is false.
This probably breaks any machine where cpu_has_apic is false, since
apic_suspend/resume will access non-existent APIC registers & MSRs.

I don't like the idea of registering apic_driver when !cpu_has_apic,
but it might be needed for the local-APIC NMI watchdog. A fix could
be to guard apic_suspend/resume with "if(!cpu_has_apic)return;".

>--- clean/arch/i386/kernel/nmi.c	2003-01-05 22:58:19.000000000 +0100
>+++ linux-swsusp/arch/i386/kernel/nmi.c	2003-02-09 11:43:29.000000000 +0100
>@@ -118,10 +121,6 @@
> 	 * missing bits. Right now Intel P6/P4 and AMD K7 only.
> 	 */
> 	if ((nmi == NMI_LOCAL_APIC) &&
>-			(boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) &&
>-			(boot_cpu_data.x86 == 6 || boot_cpu_data.x86 == 15))
>-		nmi_watchdog = nmi;
>-	if ((nmi == NMI_LOCAL_APIC) &&
> 			(boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
> 	  		(boot_cpu_data.x86 == 6 || boot_cpu_data.x86 == 15))
> 		nmi_watchdog = nmi;

You just killed NMI_LOCAL_APIC support on Intel.

>+static int __init init_nmi_devicefs(void)
>+{
>+	driver_register(&nmi_driver);
>+
>+	device_nmi.parent = &device_apic.dev;
>+        return device_register(&device_nmi);
>+}
> 
>-#define __pminit	__init
>+device_initcall(init_nmi_devicefs);

Doesn't this require that init_apic_devicefs() has been done?
Can you guarantee that?

> 
>+#define __pminit
> #endif	/* CONFIG_PM */

__pminit is no longer defined when !CONFIG_PM, which will
cause compile errors. Possibly the remaining uses of __pminit
should be removed.

>--- clean/arch/i386/oprofile/nmi_int.c	2003-01-05 22:58:19.000000000 +0100
>+++ linux-swsusp/arch/i386/oprofile/nmi_int.c	2003-02-09 12:16:52.000000000 +0100
...
>+	if (nmi_watchdog == NMI_LOCAL_APIC) {
>+		disable_apic_nmi_watchdog();
>+		nmi_watchdog = NMI_LOCAL_APIC_SUSPENDED_BY_OPROFILE;
>+	}
...
>+	if (nmi_watchdog == NMI_LOCAL_APIC_SUSPENDED_BY_OPROFILE) {
>+		nmi_watchdog = NMI_LOCAL_APIC_SUSPENDED_BY_OPROFILE;
>+		setup_apic_nmi_watchdog();
>+	}
...
>--- clean/include/asm-i386/apic.h	2002-10-20 16:22:45.000000000 +0200
>+++ linux-swsusp/include/asm-i386/apic.h	2003-02-09 11:46:09.000000000 +0100
>@@ -95,6 +95,7 @@
> #define NMI_IO_APIC	1
> #define NMI_LOCAL_APIC	2
> #define NMI_INVALID	3
>+#define NMI_LOCAL_APIC_SUSPENDED_BY_OPROFILE	4

This is ugly like h*ll. Surely oprofile could just do:

static unsigned int prev_nmi_watchdog;
..
prev_nmi_watchdog = nmi_watchdog;
if (prev_nmi_watchdog == NMI_LOCAL_APIC) {
	disable_apic_nmi_watchdog();
	nmi_watchdog = NMI_NONE;
}
...
if (prev_nmi_watchdog == NMI_LOCAL_APIC) {
	nmi_watchdog = NMI_LOCAL_APIC;
	setup_apic_nmi_watchdog();
}

without having to add crap to the global namespace?

/Mikael
