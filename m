Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129987AbRCDCZd>; Sat, 3 Mar 2001 21:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129991AbRCDCZY>; Sat, 3 Mar 2001 21:25:24 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:56024 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S129987AbRCDCZK>;
	Sat, 3 Mar 2001 21:25:10 -0500
Date: Sun, 4 Mar 2001 03:24:52 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200103040224.DAA15179@harpo.it.uu.se>
To: alan@lxorguk.ukuu.org.uk, fg@mandrakesoft.com
Subject: Re: [PATCH] 2.4.2: cure the kapm-idled taking (100-epsilon)% CPU
Cc: jgarzik@mandrakesoft.com, kernel@linux-mandrake.com,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Mar 2001 23:35:34 +0000 (GMT), Alan Cox wrote:

>> Well, from reading the source, I don't see how this can break APM... What=
>>  am I
>> missing?
>
>If you've stopped kapm-idled from using cpu then you've stopped it from going
>into the bios suspend one presumes.

Maybe, maybe not.

Short story: CONFIG_APM_CPU_IDLE is broken on three machines I run,
including one laptop. It actually _prevents_ the CPU from "idling".

Long story: While working on the UP-APIC patch I was trying to figure
why I was seeing a near-perfect 100Hz NMI count on an otherwise idle
machine, while other people were seeing much lower rates. An idle
machine is supposed to "hlt" frequently, which also suspends UP-APIC
NMI generation.

As it turned out, I had CONFIG_APM_CPU_IDLE=y in my .configs. So
apm_mainloop() dutifully called APM_FUNC_IDLE whenever it felt the
machine was idle. Problem is, APM_FUNC_IDLE doesn't actually _do_
anything on these machines [maybe apm_bios_call_simple() is buggy,
maybe the BIOSen are, I don't know]. So instead apm_mainloop() was
sitting there in a tight loop calling APM_FUNC_IDLE like crazy:
my 800Mhz Coppermine was doing 1.3 million of these calls per second,
and kapm-idled was taking >95% of CPU time [sound familiar?].

After I disabled CONFIG_APM_CPU_IDLE the Coppermine is running about
15 degrees C cooler than before. kapm-idled takes almost no CPU time
since it basically just sleeps waiting for APM events. The kernel's
regular idle loop "hlt":s the box most of the time between timer irqs.

It's easy enough to check if you've got a broken CONFIG_APM_CPU_IDLE:
define a counter, increment it in apm.c:apm_do_idle(), and print
it at the end of irq.c:get_irq_list(). On an idle machine, cat
/proc/interrupts, sleep 5 seconds, and cat /proc/interrupts again.
Note the difference in the apm_do_idle() counter.
Similarly, you can also add a counter to process.c:default_idle()
to see how often the kernel "hlt":s.

/Mikael
