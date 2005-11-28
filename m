Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbVK1C2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbVK1C2v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 21:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbVK1C2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 21:28:51 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42152 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750792AbVK1C2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 21:28:50 -0500
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Raj, Ashok" <ashok.raj@intel.com>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] i386/x86_64: Don't IPI to offline cpus on shutdown
References: <Pine.LNX.4.61.0511270115020.20046@montezuma.fsmlabs.com>
	<20051127135833.GH20775@brahms.suse.de>
	<m1wtiufa9z.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.61.0511270836120.20046@montezuma.fsmlabs.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 27 Nov 2005 19:27:50 -0700
In-Reply-To: <Pine.LNX.4.61.0511270836120.20046@montezuma.fsmlabs.com> (Zwane
 Mwaikambo's message of "Sun, 27 Nov 2005 08:45:47 -0800 (PST)")
Message-ID: <m1psolfqvt.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> writes:

> On Sun, 27 Nov 2005, Eric W. Biederman wrote:
>
>> Andi Kleen <ak@suse.de> writes:
>> 
>> > On Sun, Nov 27, 2005 at 02:05:45AM -0800, Zwane Mwaikambo wrote:
>> >> http://bugzilla.kernel.org/show_bug.cgi?id=5203
>> >> 
>> >> There is a small race during SMP shutdown between the processor issuing 
>> >> the shutdown and the other processors clearing themselves off the 
>> >> cpu_online_map as they do this without using the normal cpu offline 
>> >> synchronisation. To avoid this we should wait for all the other processors
>> >> to clear their corresponding bits and then proceed. This way we can safely
>> >> make the cpu_online test in smp_send_reschedule, it's safe during normal 
>> >> runtime as smp_send_reschedule is called with a lock held / preemption 
>> >> disabled.
>> >
>> > Looking at the backtrace in the bug - how can sys_reboot call do_exit???
>> > I would say the problem is in whatever causes that. It shouldn't 
>> > do that. sys_reboot shouldn't schedule, it's that simple.
>> > Your patch is just papering over that real bug.
>> 
>> sys_reboot in the case of halt (after everything else is done)
>> has directly called do_exit for years.
>> 
>> There are some very subtle interactions there.  The one
>> I always remember (having found it the hard way) is that
>> interrupts must be left on so ctrl-alt-del still works.
>> 
>> This do_exit may be something similar, although I can't
>> think of how it could be useful.
>
> I wondered the same thing, perhaps i am papering over the bug, what 
> exactly is do_exit doing there?

So I just looked at a couple of kernels I have lying around.
the do_exit has been in halt since 1.2.?  In 1.0 the halt
case was not even implemented.  

So I think not coping with the do_exit is a problem, as every
other architecture and every other kernel has been able to.

To handle ctrl-alt-del after a halt (or any other action) being able
to schedule sounds important.

As Andi Kleen indicated the problem with do_exit is that it schedules.
I strongly disagree that simply scheduling after halting is a bug.

So why are we calling smp_send_stop from machine_halt?

We don't.

Looking more closely at the bug report the problem here
is that halt -p is called which triggers not a halt but
an attempt to power off.  

machine_power_off calls machine_shutdown which calls smp_send_stop.

If pm_power_off is set we should never make it out machine_power_off
to the call of do_exit.  So pm_power_off must not be set in this case.
When pm_power_off is not set we expect machine_power_off to devolve
into machine_halt.

So how do we fix this?

Playing too much with smp_send_stop is dangerous because it
must also be safe to be called from panic.

It looks like the obviously correct fix is to only call
machine_shutdown when pm_power_off is defined.  Doing
that will make Andi's assumption about not scheduling
true and generally simplify what must be supported.

This turns machine_power_off into a noop like machine_halt
when pm_power_off is not defined.

If the expected behavior is that sys_reboot(LINUX_REBOOT_CMD_POWER_OFF)
becomes sys_reboot(LINUX_REBOOT_CMD_HALT) if pm_power_off is NULL
this is not quite a comprehensive fix as we pass a different parameter
to the reboot notifier and we set system_state to a different value
before calling device_shutdown().

Unfortunately any fix more comprehensive I can think of is not
obviously correct.  The core problem is that there is no architecture
independent way to detect if machine_power will become a noop, without
calling it.

Eric

diff --git a/arch/i386/kernel/reboot.c b/arch/i386/kernel/reboot.c
index 350ea66..2a8cb44 100644
--- a/arch/i386/kernel/reboot.c
+++ b/arch/i386/kernel/reboot.c
@@ -12,6 +12,7 @@
 #include <linux/efi.h>
 #include <linux/dmi.h>
 #include <linux/ctype.h>
+#include <linux/pm.h>
 #include <asm/uaccess.h>
 #include <asm/apic.h>
 #include <asm/desc.h>
@@ -347,10 +348,10 @@ void machine_halt(void)
 
 void machine_power_off(void)
 {
-	machine_shutdown();
-
-	if (pm_power_off)
+	if (pm_power_off) {
+		machine_shutdown();
 		pm_power_off();
+	}
 }
 
 
diff --git a/arch/x86_64/kernel/reboot.c b/arch/x86_64/kernel/reboot.c
index 75235ed..57117b8 100644
--- a/arch/x86_64/kernel/reboot.c
+++ b/arch/x86_64/kernel/reboot.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/ctype.h>
 #include <linux/string.h>
+#include <linux/pm.h>
 #include <asm/io.h>
 #include <asm/kdebug.h>
 #include <asm/delay.h>
@@ -154,10 +155,11 @@ void machine_halt(void)
 
 void machine_power_off(void)
 {
-	if (!reboot_force) {
-		machine_shutdown();
-	}
-	if (pm_power_off)
+	if (pm_power_off) {
+		if (!reboot_force) {
+			machine_shutdown();
+		}
 		pm_power_off();
+	}
 }
 
