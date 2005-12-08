Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVLHHk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVLHHk4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 02:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbVLHHk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 02:40:56 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58572 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750715AbVLHHkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 02:40:55 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Raj, Ashok" <ashok.raj@intel.com>, Andi Kleen <ak@suse.de>,
       Dave Jones <davej@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Don't attempt to power off if power off is not implemented.
References: <Pine.LNX.4.61.0511270115020.20046@montezuma.fsmlabs.com>
	<20051127135833.GH20775@brahms.suse.de>
	<m1wtiufa9z.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.61.0511270836120.20046@montezuma.fsmlabs.com>
	<m1psolfqvt.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0512021221210.13220@montezuma.fsmlabs.com>
	<m1iru7dlww.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0512050014000.6637@montezuma.fsmlabs.com>
	<m1zmncb0n5.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0512072158500.2557@montezuma.fsmlabs.com>
	<m1vey0azeu.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0512072249000.2557@montezuma.fsmlabs.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 08 Dec 2005 00:39:33 -0700
In-Reply-To: <Pine.LNX.4.64.0512072249000.2557@montezuma.fsmlabs.com> (Zwane
 Mwaikambo's message of "Wed, 7 Dec 2005 22:53:13 -0800 (PST)")
Message-ID: <m1k6egavgq.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The problem.  It is expected that /sbin/halt -p works
exactly like /sbin/halt, when the kernel does not
implement power off functionality.  

The kernel can do a lot of work in the reboot notifiers and in
device_shutdown before we even get to machine_power_off.  Some of that
shutdown is not safe if you are leaving the power on, and it
definitely gets in the way of using sysrq or pressing ctrl-alt-del.
Since the shutdown happens in generic code there is no way
to fix this in architecture specific code :(

Some machines are kernel oopsing today because of this.

The simple solution is to turn LINUX_REBOOT_CMD_POWER_OFF into
LINUX_REBOOT_CMD_HALT if power_off functionality is not implemented.  

This has the unfortunate side effect of disabling the
power off functionality on architectures that leave
pm_power_off to null and still implement something
in machine_power_off.   And it will break the build on some
architectures that don't have a pm_power_off variable at all.

On both counts I say tough.

For architectures like alpha that don't implement the pm_power_off
variable pm_power_off is declared in linux/pm.h and it is a generic
part of our power management code, and all architectures should
implement it.

For architectures like parisc that have a default power off method
in machine_power_off if pm_power_off is not implemented or
fails.  It is easy enough to set the pm_power_off variable.  And
nothing bad happens there, the machines just stop powering off.

The current semantics are impossible without a flag at
the top level so we can avoid the problem code if
a power off is not implemented.  pm_power_off is as good
a flag as any with the bonus that it works without modification
on at least x86, x86_64, powerpc, and ppc today.

Andrew can you pick this up and put this in the mm tree.  Kernels
that don't compile or don't power off seem saner than kernels that
oops or panic.  Until we get the arch specific patches for the problem
architectures this probably isn't smart to push into the stable kernel.
Unfortunately I don't have the time at the moment to walk through
every architecture and make them work.  And even if I did I couldn't
test it :(

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

diff --git a/kernel/sys.c b/kernel/sys.c
index bce933e..bf5842f 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -488,6 +488,12 @@ asmlinkage long sys_reboot(int magic1, i
 	                magic2 != LINUX_REBOOT_MAGIC2C))
 		return -EINVAL;
 
+	/* Instead of trying to make the power_off code look like
+	 * halt when pm_power_off is not set do it the easy way.
+	 */
+	if ((cmd == LINUX_REBOOT_CMD_POWER_OFF) && !pm_power_off)
+		cmd = LINUX_REBOOT_CMD_HALT;
+
 	lock_kernel();
 	switch (cmd) {
 	case LINUX_REBOOT_CMD_RESTART:
