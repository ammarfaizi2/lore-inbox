Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267321AbTBJKv0>; Mon, 10 Feb 2003 05:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267441AbTBJKv0>; Mon, 10 Feb 2003 05:51:26 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:15620 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267321AbTBJKvY>; Mon, 10 Feb 2003 05:51:24 -0500
Date: Mon, 10 Feb 2003 12:01:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: levon@movementarian.org, linux-kernel@vger.kernel.org
Subject: Re: Switch APIC (+nmi, +oprofile) to driver model
Message-ID: <20030210110108.GE2838@atrey.karlin.mff.cuni.cz>
References: <200302091407.PAA14076@kim.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302091407.PAA14076@kim.it.uu.se>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Here's next attempt at moving APIC (+nmi, +oprofile) to the driver
> >model. If it looks good I'l submit it to Linus.
> 
> I'm sorry to be a killjoy, but this still doesn't look right.
> 
> >--- clean/arch/i386/kernel/apic.c	2003-01-05 22:58:18.000000000 +0100
> >+++ linux-swsusp/arch/i386/kernel/apic.c	2003-02-03 16:36:41.000000000 +0100
> >-static void apic_pm_resume(void *data)
> >+static int apic_resume(struct device *dev, u32 level)
> > {
> > 	unsigned int l, h;
> > 	unsigned long flags;
> > 
> >+	if (level != RESUME_POWER_ON)
> >+		return 0;
> >+
> >+	set_fixmap_nocache(FIX_APIC_BASE, apic_phys);		/* FIXME: this is needed for S3 resume, but why? */
> 
> This is horrible! The only reason this might be needed is if
> the page tables weren't restored properly at resume, and that
> indicates a bug somewhere else.
> 
> Also, apic_phys is (or should be) APIC_DEFAULT_PHYS_BASE, so
> you shouldn't need to make apic_phys global.

Really?

        /*
         * If no local APIC can be found then set up a fake all
         * zeroes page to simulate the local APIC and another
         * one for the IO-APIC.
         */
        if (!smp_found_config && detect_init_APIC()) {
                apic_phys = (unsigned long) alloc_bootmem_pages(PAGE_SIZE);
                apic_phys = __pa(apic_phys);
        } else
                apic_phys = mp_lapic_addr;

        set_fixmap_nocache(FIX_APIC_BASE, apic_phys);

So it seems to me it really is variable.

> >--- clean/arch/i386/kernel/nmi.c	2003-01-05 22:58:19.000000000 +0100
> >+++ linux-swsusp/arch/i386/kernel/nmi.c	2003-02-09 11:43:29.000000000 +0100
> >@@ -118,10 +121,6 @@
> > 	 * missing bits. Right now Intel P6/P4 and AMD K7 only.
> > 	 */
> > 	if ((nmi == NMI_LOCAL_APIC) &&
> >-			(boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) &&
> >-			(boot_cpu_data.x86 == 6 || boot_cpu_data.x86 == 15))
> >-		nmi_watchdog = nmi;
> >-	if ((nmi == NMI_LOCAL_APIC) &&
> > 			(boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
> > 	  		(boot_cpu_data.x86 == 6 || boot_cpu_data.x86 == 15))
> > 		nmi_watchdog = nmi;
> 
> You just killed NMI_LOCAL_APIC support on Intel.

Oops, sorry, I seen two identical blocks of code... and they were not
identical. Sorry.

> >--- clean/arch/i386/oprofile/nmi_int.c	2003-01-05 22:58:19.000000000 +0100
> >+++ linux-swsusp/arch/i386/oprofile/nmi_int.c	2003-02-09 12:16:52.000000000 +0100
> ...
> >+	if (nmi_watchdog == NMI_LOCAL_APIC) {
> >+		disable_apic_nmi_watchdog();
> >+		nmi_watchdog = NMI_LOCAL_APIC_SUSPENDED_BY_OPROFILE;
> >+	}
> ...
> >+	if (nmi_watchdog == NMI_LOCAL_APIC_SUSPENDED_BY_OPROFILE) {
> >+		nmi_watchdog = NMI_LOCAL_APIC_SUSPENDED_BY_OPROFILE;
> >+		setup_apic_nmi_watchdog();
> >+	}
> ...
> >--- clean/include/asm-i386/apic.h	2002-10-20 16:22:45.000000000 +0200
> >+++ linux-swsusp/include/asm-i386/apic.h	2003-02-09 11:46:09.000000000 +0100
> >@@ -95,6 +95,7 @@
> > #define NMI_IO_APIC	1
> > #define NMI_LOCAL_APIC	2
> > #define NMI_INVALID	3
> >+#define NMI_LOCAL_APIC_SUSPENDED_BY_OPROFILE	4
> 
> This is ugly like h*ll. Surely oprofile could just do:

Yes, whole oprofile/nmi interaction is ugly like hell. This way it is
at least explicit, so people *know* its ugly.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
