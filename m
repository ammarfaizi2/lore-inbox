Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbUK0GC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbUK0GC6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 01:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbUK0DpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:45:23 -0500
Received: from zeus.kernel.org ([204.152.189.113]:17604 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262662AbUKZTfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:35:46 -0500
Date: Fri, 26 Nov 2004 11:40:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch, 2.6.10-rc2-mm3, x86] fix reboot hang / APIC errors
Message-ID: <20041126104022.GA23827@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch fixes SMP/x86 systems to not hang during reboot in
certain circumstances, printing out an endless stream of:

 APIC error on CPU1: 00(04)
 APIC error on CPU1: 04(04)
 APIC error on CPU1: 04(04)

The bug is this: sys_reboot() calls device_shutdown(), which calls each
registered driver and shuts it down. One of them is lapic0, which is
lethal: it will disable the local APIC on the currently executing CPU.
This is buggy in a number of ways 1) there's no guarantee that the
reboot process wont migrate to another CPU at this point (it's still a
fully functioning kernel) 2) if another CPU tries to send an cross-CPU
IPI message after this CPU's local APIC has been disabled, that other
CPU will get an infinite stream of APIC error interrupts - locking the
system up in a flood of messages. The reboot never happens.

the fix is to do what we always did: only disable the local APIC in the
very final moments, as part of the smp_send_stop() logic.

AFAICS, this is a fresh changeset that came in over the ACPI BK tree, it
has not been committed to Linus' tree yet. This bug was found via
PREEMPT_RT where the race is much more likely to trigger, but there's no
reason why this could not occur in the generic kernel.

similarly, i think it's unfortunate that the IO-APIC driver has a
shutdown handler as well - while i cannot see a bug scenario right now,
i think it's quite fragile to disable all external interrupts (including
the timer interrupt!) at this point. Again, this is best done in
machine_restart(). (which already does it.)

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/arch/i386/kernel/apic.c.orig
+++ linux/arch/i386/kernel/apic.c
@@ -654,9 +654,12 @@ static int lapic_resume(struct sys_devic
 }
 
 
+/*
+ * This device has no shutdown method - fully functioning local APICs
+ * are needed on every CPU up until machine_halt/restart/poweroff.
+ */
 static struct sysdev_class lapic_sysclass = {
 	set_kset_name("lapic"),
-	.shutdown	= lapic_shutdown,
 	.resume		= lapic_resume,
 	.suspend	= lapic_suspend,
 };

