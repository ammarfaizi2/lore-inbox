Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267568AbTBKKy7>; Tue, 11 Feb 2003 05:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267575AbTBKKxX>; Tue, 11 Feb 2003 05:53:23 -0500
Received: from [195.39.17.254] ([195.39.17.254]:11780 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267568AbTBKKvy>;
	Tue, 11 Feb 2003 05:51:54 -0500
Date: Mon, 10 Feb 2003 17:10:31 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: levon@movementarian.org, linux-kernel@vger.kernel.org
Subject: Re: Switch APIC (+nmi, +oprofile) to driver model
Message-ID: <20030210161031.GA443@elf.ucw.cz>
References: <200302091407.PAA14076@kim.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302091407.PAA14076@kim.it.uu.se>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >+	set_fixmap_nocache(FIX_APIC_BASE, apic_phys);		/* FIXME: this is needed for S3 resume, but why? */
> 
> This is horrible! The only reason this might be needed is if
> the page tables weren't restored properly at resume, and that
> indicates a bug somewhere else.

Pagetables should be restored okay, I do not know what is going on.

> >+static int __init init_apic_devicefs(void)
> > {
> >+	driver_register(&apic_driver);
> > 	if (apic_pm_state.active)
> >-		pm_register(PM_SYS_DEV, 0, apic_pm_callback);
> >+		return sys_device_register(&device_apic);
> >+	return 0;
> ...
> >+device_initcall(init_apic_devicefs);
> 
> init_apic_devicefs() registers apic_driver even if active is false.
> This probably breaks any machine where cpu_has_apic is false, since
> apic_suspend/resume will access non-existent APIC registers & MSRs.
> 
> I don't like the idea of registering apic_driver when !cpu_has_apic,
> but it might be needed for the local-APIC NMI watchdog. A fix could
> be to guard apic_suspend/resume with "if(!cpu_has_apic)return;".

cpu_has_apic test seems wrong: AFAICS, there are CPUs that have apic
but linux does not know how to use it.

> > 		nmi_watchdog = nmi;
> 
> You just killed NMI_LOCAL_APIC support on Intel.

Fixed.

> >+device_initcall(init_nmi_devicefs);
> 
> Doesn't this require that init_apic_devicefs() has been done?
> Can you guarantee that?

Moved to late_initcall().

> > 
> >+#define __pminit
> > #endif	/* CONFIG_PM */
> 
> __pminit is no longer defined when !CONFIG_PM, which will
> cause compile errors. Possibly the remaining uses of __pminit
> should be removed.

Fixed.
								Pavel

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
