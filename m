Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267268AbTBIOc5>; Sun, 9 Feb 2003 09:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267270AbTBIOc5>; Sun, 9 Feb 2003 09:32:57 -0500
Received: from kim.it.uu.se ([130.238.12.178]:39299 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S267268AbTBIOc4>;
	Sun, 9 Feb 2003 09:32:56 -0500
Date: Sun, 9 Feb 2003 15:42:37 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200302091442.PAA14138@kim.it.uu.se>
To: levon@movementarian.org
Subject: Re: Switch APIC (+nmi, +oprofile) to driver model
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Feb 2003 14:11:42 +0000, John Levon wrote:
>On Sun, Feb 09, 2003 at 03:07:27PM +0100, Mikael Pettersson wrote:
>
>> I don't like the idea of registering apic_driver when !cpu_has_apic,
>> but it might be needed for the local-APIC NMI watchdog.
>
>Really ?

Pavel's patch changes nmi.c to include:

extern struct sys_device device_apic;

static int __init init_nmi_devicefs(void)
{
	driver_register(&nmi_driver);

	device_nmi.parent = &device_apic.dev;
        return device_register(&device_nmi);
}

device_initcall(init_nmi_devicefs);

so nmi.c will unconditionally register a device with the local
APIC's device as parent. I strongly suspect this will break if
&device_apic hasn't itself been device_register():d.

The NMI driver's suspend/resume procedures check nmi_active before
doing anything, so registering the NMI device unconditionally
is _probably_ safe. (Although I personally think it should be
conditional.)

>as long as it's exported to modules. I'd probably prefer
>to just have :
>
>	disable_nmi_watchdog();
>	...
>	enable_nmi_watchdog();
>
>and have those do the right thing depending on a (nmi.c local)
>nmi_watchdog.

Yeah, that's nicer. disable_nmi_watchdog() could easily stash away
the previous state, and enable_nmi_watchdog() could check that copy
and conditionally call setup_apic_nmi_watchdog().

/Mikael
