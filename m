Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265211AbTA1MKX>; Tue, 28 Jan 2003 07:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265238AbTA1MKX>; Tue, 28 Jan 2003 07:10:23 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:53469 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S265211AbTA1MKW>;
	Tue, 28 Jan 2003 07:10:22 -0500
Date: Tue, 28 Jan 2003 13:19:40 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200301281219.NAA03575@harpo.it.uu.se>
To: pavel@suse.cz
Subject: Re: Switch APIC to driver model (and make S3 sleep with APIC on)
Cc: ak@suse.de, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2003 10:26:09 +0100, Pavel Machek wrote:
>>    - You're hardcoding that the local-APIC NMI watchdog is the
>>      only possible sub-client of the local APIC. Not true.
>>    - perfctr_pmdev exists precisely to handle both these cases
>>      in a clean way.
>
>While being as ugly as night, which is even noted in sources:
>
>-       /* 'perfctr_pmdev' is here because the current (2.4.1) PM
>-          callback system doesn't handle hierarchical dependencies */
>
>Nothing prevents more clients from registering as subtrees to APIC. I
>did not do that for NMI watchdog because it is hardcoded in Makefile,
>anyway.

Not "more" clients, OTHER clients. They're exclusive.
The NMI watchdog simply happens to be the default client, but it
needs to unregister itself before any other client can take over
the performance counters and the local APIC's LVTPC entry.
(And that's what happens today.)

If the device model handles hierarchical dependencies correctly,
there should be no need to hardcode calls from the local APIC's
PM routines to whoever happens to be its current sub-client.

(And if it doesn't do this correctly, please fix the device
model first before migrating apic.c/nmi.c to it.)

>I'll fix APM to call device model methods.

Good.

>Because PM_SUSPEND/PM_RESUME is ugly and can not be made to work
>(devices are hierarchical, and PM_SUSPEND/PM_RESUME system does not
>honour that).

Agreed, but existing PM users do work. Most are leaves in the
dependency tree (e.g. sound cards). The only one I know of that
isn't is apic.c, and it has a local workaround as you noted.

Given that we're supposed to be in a feature freeze getting 2.5
into some kind of 2.6-worthy shape soonish, I think PM should
be hooked into the device model as a legacy API.

/Mikael
