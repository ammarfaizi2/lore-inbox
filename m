Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbTBJS4U>; Mon, 10 Feb 2003 13:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262500AbTBJS4U>; Mon, 10 Feb 2003 13:56:20 -0500
Received: from kim.it.uu.se ([130.238.12.178]:53123 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S262492AbTBJS4T>;
	Mon, 10 Feb 2003 13:56:19 -0500
Date: Mon, 10 Feb 2003 20:05:59 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200302101905.UAA14874@kim.it.uu.se>
To: pavel@ucw.cz
Subject: Re: Switch APIC (+nmi, +oprofile) to driver model
Cc: levon@movementarian.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2003 12:01:09 +0100, Pavel Machek wrote:
>> Also, apic_phys is (or should be) APIC_DEFAULT_PHYS_BASE, so
>> you shouldn't need to make apic_phys global.
>
>Really?
>
>        /*
>         * If no local APIC can be found then set up a fake all
>         * zeroes page to simulate the local APIC and another
>         * one for the IO-APIC.
>         */
>        if (!smp_found_config && detect_init_APIC()) {
>                apic_phys = (unsigned long) alloc_bootmem_pages(PAGE_SIZE);
>                apic_phys = __pa(apic_phys);
>        } else
>                apic_phys = mp_lapic_addr;
>
>        set_fixmap_nocache(FIX_APIC_BASE, apic_phys);
>
>So it seems to me it really is variable.

The original code has the property that apic_pm_state.active is
true if and only if detect_init_APIC() was called and succeeded,
which implies that apic_phys == mp_lapic_addr == APIC_DEFAULT_PHYS_BASE.
You can also see that apic_pm_resume() writes APIC_DEFAULT_PHYS_BASE
to MSR_IA32_APICBASE, which only makes sense in this situation.

You moved the apic_pm_state.active = 1 assignment from detect_init_APIC(),
which is specific to UP_APIC, to setup_local_APIC(), which is called
also in the SMP case. Do you intend to do suspend and resume on SMP boxes
as well? If this is intensional, shouldn't device_apic be per-cpu?

/Mikael
