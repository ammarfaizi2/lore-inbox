Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbTDMAhg (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 20:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbTDMAhg (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 20:37:36 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:10386 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262623AbTDMAhf (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 20:37:35 -0400
Date: Sun, 13 Apr 2003 02:44:03 +0200 (MEST)
Message-Id: <200304130044.h3D0i3lQ029020@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: pavel@ucw.cz
Subject: Re: APIC is not properly suspending in 2.5.67 on UP
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       trivial@rustcorp.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Apr 2003 23:47:01 +0200, Pavel Machek wrote:
>This is needed otherwise APIC thinks it is not active, does not
>suspend properly, and kills machine.

This can only happen with UP if the machine boots with local
APIC enabled and the BIOS announces an MP table.

If this is the case, then yes apic_pm_activate() needs to be done.

> Extra whitespace killed (looks
>ugly). Please apply,

I think some fixes are needed first:
- You're calling apic_pm_activate() from setup_local_APIC(), which
  is before its definition. This will cause a compile warning, and
  a linkage error if CONFIG_PM=n.
- While calling apic_pm_activate() from setup_local_APIC() sort of
  works in the UP case, it's wrong since setup_local_APIC() is called
  for each CPU in SMP, and we must not run the suspend and resume
  code if there is more than one CPU in the machine.
  I don't have a good solution for this right now: I don't think
  cpu_online_map is valid when init_lapi_devicefs() runs, and I
  don't know how else to check the number of CPUs.
  Changing the #ifdef CONFIG_PM block to be #if defined(CONFIG_PM)
  && !defined(CONFIG_SMP) would fix UP kernels, but SMP kernels on
  UP HW would lose PM. Adding "if (num_online_cpus() > 1) return;"
  to the suspend & resume procedures is ugly but should work.

/Mikael
