Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVDRW1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVDRW1r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 18:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVDRW1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 18:27:47 -0400
Received: from aun.it.uu.se ([130.238.12.36]:31999 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261184AbVDRW1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 18:27:44 -0400
Date: Tue, 19 Apr 2005 00:27:29 +0200 (MEST)
Message-Id: <200504182227.j3IMRTXm013594@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: alexn@dsv.su.se
Subject: Re: 2.6.12-rc2-mm3
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2005 11:56:15 +0200, Alexander Nyberg wrote:
>> >This patch fixes the NMI checking problems in -mm x64 for me. It 
>> 
>> What problems?
>> 
>
>Sorry, in -mm on x64 check_nmi_watchdog() has started to be run as a
>late_initcall(). Currently it reports the NMIs as stuck on a few systems
>although they are not, both of mine are reported as stuck. This appears
>to be because the current event mask uses don't appear to tick much
>running mdelay() on opteron (in my case).

Please provide a complete dmesg log up to and including the failure
point where the kernel complains about stuck NMIs.

I tried 2.6.12-rc2-mm3 SMP on UP amd64 and I immediately found a
bug triggering bogus stuck NMI failures, and I want to check if
what you're seeing is caused by the same bug.

> Also in -mm because nmi_hz is
>set to 1 in setup_k7_watchdog() the NMI watchdog checking takes 10
>seconds, a bit much.

Orthogonal issue. Let's ignore this one for now.

>Patch below uses RETIRED_UOPS for a more constant rate of NMI sending, 

This may or may not work as you intend. There is _no_ documented reason
to assume that RETIRED_UOPS would provide a more steady stream of events
than CYCLES_PROCESSOR_IS_RUNNING. Both events are likely to be idle in
HLT states, for instance.

The local APIC + performance counter driven NMI watchdog simply cannot
provide wall-clock like behaviour. You need the I/O-APIC driven watchdog
for that, or to prevent the kernel from using HLT when idle.

>@@ -68,7 +69,7 @@
> #define K7_EVNTSEL_INT		(1 << 20)
> #define K7_EVNTSEL_OS		(1 << 17)
> #define K7_EVNTSEL_USR		(1 << 16)
>-#define K7_EVENT_CYCLES_PROCESSOR_IS_RUNNING	0x76
>+#define K7_EVENT_CYCLES_PROCESSOR_IS_RUNNING	0xC1 /* Retired uops */
> #define K7_NMI_EVENT		K7_EVENT_CYCLES_PROCESSOR_IS_RUNNING

This is as bogus as "#define ONE 2". CYCLES_PROCESSOR_IS_RUNNING
_is_ event 0x76 (AMD renamed it recently, but that's irrelevant).
Using RETIRED_UOPS requires a new define, and a modification to
the K7_NMI_EVENT #define.

/Mikael
