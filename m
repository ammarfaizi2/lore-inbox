Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266559AbRHPU5S>; Thu, 16 Aug 2001 16:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261289AbRHPU5J>; Thu, 16 Aug 2001 16:57:09 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:45991 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S271636AbRHPU4j>;
	Thu, 16 Aug 2001 16:56:39 -0400
Date: Thu, 16 Aug 2001 22:56:46 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200108162056.WAA18756@harpo.it.uu.se>
To: georgn@somanetworks.com, linux-kernel@vger.kernel.org
Subject: Re: Dell I8000, 2.4.8-ac5 and APM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Aug 2001 15:57:22 -0400, Georg Nikodym wrote:

>> On my Dell I8000, when running 2.48-ac5 pulling the AC plug out (or
>> plugging it back) causes the box to hang for a while prior to shutting
>> itself off.
>> 
>> I first reported this in 2.4.5-ac13 but didn't have the time to poke
>> around.
>
>Looking at apm.c, there's not enough difference to account for this
>regression so I started looking more broadly.  I found that in the -ac
>tree there's a bunch of power management code that's been added to
>arch/i386/kernel/apic.c (by Mikael Petterson).

The PM code in apic.c is _required_ if you want power management to
work at all with a local APIC enabled kernel.
The problem is that on most UP boxes, the BIOS boots the OS with the
local APIC disabled, and it expects the local APIC to stay disabled,
especially at suspend when the BIOS SMM is activated. Failure of the
OS to disable the local APIC before suspend can cause the machine to
hang hard. The PM code in apic.c and nmi.c is there to prevent this.

Concerning your problem with pulling the AC plug on your Dell I8000,
my suspicion is that either (a) the BIOS isn't notifying apm.c of the
event, or (b) apm.c fails to propagate the event to its PM clients.

(Case (b) is known to cause problems for "apm --standby" since apm.c
[for whatever reason] doesn't propagate STANDBY events to PM clients.
See the "2.4.5-ac8 hardlocks when going to standby" thread from early
June this year.)

>Disabling APIC solves my immediate problem, so personally I'm happy.
>
>Obviously, that not The Right Thing (tm) so Mikael, if you want a
>debugging guinea pig, feel free to contact me.

Try the patch below and configure with CONFIG_X86_UP_APIC disabled.
Reboot. Pull the AC plug. What debug output did apm.c dump in the
kernel log? If it said something about send_event() ignoring some
event, then that's a prime suspect.

/Mikael

--- linux-2.4.8-ac5/arch/i386/kernel/apm.c.~1~	Thu Aug 16 21:32:36 2001
+++ linux-2.4.8-ac5/arch/i386/kernel/apm.c	Thu Aug 16 21:58:40 2001
@@ -347,7 +347,7 @@
 static long			clock_cmos_diff;
 static int			got_clock_diff;
 #endif
-static int			debug;
+static int			debug = 1;
 static int			apm_disabled = -1;
 #ifdef CONFIG_SMP
 static int			power_off;
@@ -947,6 +947,13 @@
 		/* map all resumes to ACPI D0 */
 		(void) pm_send_all(PM_RESUME, (void *)0);
 		break;
+	default:
+		if (debug)
+			printk(KERN_DEBUG "apm: send_event() ignored event 0x%02x (%s)\n",
+			       event,
+			       (event > NR_APM_EVENT_NAME)
+			       ? "unknown"
+			       : apm_event_name[event - 1]);
 	}
 
 	return 1;
