Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261755AbSJMXoo>; Sun, 13 Oct 2002 19:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261756AbSJMXoo>; Sun, 13 Oct 2002 19:44:44 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30327 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261755AbSJMXon>; Sun, 13 Oct 2002 19:44:43 -0400
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: eblade@blackmagik.dynup.net, linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
References: <200210132214.PAA00953@adam.yggdrasil.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Oct 2002 17:49:09 -0600
In-Reply-To: <200210132214.PAA00953@adam.yggdrasil.com>
Message-ID: <m11y6tnbm2.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


O.k.  After having been away from active development on the kernel
for a while I have now reviewed what you are seeing and I have a much
firmer grasp of what is going on.

The change that merged device_shutdown and device_suspend was buggy.
There really should have been a second state added so no behaviour
would change.  This does not affect the reboot case, but it does
affect the other users of SUSPEND_POWER_DOWN which does request
devices be powered off.  Which is noticeably from what you want in
device_shutdown() which is the preparation for reboot/halt.

The change that went into 2.5.42 was the behavior of the ide
driver changed.  device_shutdown has always called device->remove,
and it has been in the reboot path for a very long time.  The ide
driver just implemented a remove method, replacing it's reboot
notifier, and in that change the ide driver started spinning down disk
on reboot as well as shutdown.  So please talk to the author of the
ide change if you do not like the current ide behaviour.  


machine_restart returns control to the BIOS.  
It works this way on both x86 and alpha.  And the BIOS does
not always toggle the RESET line on the machine.  The frequent case
of devices not working in Linux after rebooting from windows, and
visa versa is evidence of this.  On alpha the SRM doesn't even
pretend to reset the machine.

Therefore the reboot code needs to put devices in a sane state, and
given the general perversity of hardware and that there is not a
defined way to do this generically except resetting the pci bus
the device drivers need to be involved.  A reboot notifier is an ugly
way to do this, and walking the power management tree is a much
cleaner way to accomplish this.  Additionally it was decided quite a
while ago that calling device->remove() was the correct way to
accomplish this.

Reboot problems show up more clearly when booting linux from linux but
that just makes it more explicit.  It does not introduce any new
potentials for problems, in this area.

Eric
