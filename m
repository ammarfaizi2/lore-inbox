Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276361AbRI1Wtz>; Fri, 28 Sep 2001 18:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276362AbRI1Wtp>; Fri, 28 Sep 2001 18:49:45 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:10910 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S276361AbRI1Wth>;
	Fri, 28 Sep 2001 18:49:37 -0400
Date: Sat, 29 Sep 2001 00:50:03 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200109282250.AAA16038@harpo.it.uu.se>
To: rutt@chezrutt.com
Subject: Re: 2.4.10 problem with APM on Inspiron 8000
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2001 11:40:19 -0400, John Ruttenberg wrote:

>My Inspiron 8k loves kernels 2.4.* up to 2.4.9, but has problems with 2.4.10.
>In particular, it seems that any APM event (suspend, etc.) causes a hard
>freeze.  In fact, on 2.4.9 and lower, I can even use the function-setup key
>which lets me examine/change bios while the kernel is running.  On 2.4.10,
>this causes a kernel freeze.
>
>My .config files are essentially identical for 2.4.9 and for 2.4.10.
>
>On thing I noticed that seems a little suspicious is this start up message:
>
>    Local APIC disabled by BIOS -- reenabling.
>    Found and enabled local APIC!
>
>For 2.4.9, I get:
>
>    mapped APIC to ffffe000 (01442000)

The I8000 again (sigh). You apparently have SMP or UP IOAPIC enabled.
In this case, 2.4.10 will enable the local APIC if the BIOS didn't.

To help debug the freeze, please try the patch below: it will cause
the kernel to log any APM event sent to it from the BIOS. Run this
in an SMP&UP_IOAPIC-less kernel. Do one of the actions above that
would freeze the APIC-enabled kernel (like the key sequence to enter
the BIOS setup screens). Check the kernel log. Did APM log any event,
and if so, which one?

My suspicion (from this and other reports) is that the Inspiron 8000's
BIOS SMM can't handle an enabled local APIC, or it passes an APM event
that apm.c ignores. Either case can be lethal.

/Mikael

--- linux-2.4.10/arch/i386/kernel/apm.c.~1~	Sun Sep 23 21:06:30 2001
+++ linux-2.4.10/arch/i386/kernel/apm.c	Sat Sep 29 00:11:23 2001
@@ -927,6 +927,7 @@
 
 static int send_event(apm_event_t event)
 {
+	printk(__FUNCTION__ ": event %u\n", event);
 	switch (event) {
 	case APM_SYS_SUSPEND:
 	case APM_CRITICAL_SUSPEND:
