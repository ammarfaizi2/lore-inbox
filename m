Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbUJWUw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbUJWUw0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 16:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbUJWUwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 16:52:25 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26119 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261310AbUJWUtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 16:49:53 -0400
Date: Sat, 23 Oct 2004 21:49:46 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/7] Input: remove pm_dev from core
Message-ID: <20041023214946.A13521@flint.arm.linux.org.uk>
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
	Vojtech Pavlik <vojtech@suse.cz>,
	LKML <linux-kernel@vger.kernel.org>
References: <200410210223.45498.dtor_core@ameritech.net> <200410210230.04156.dtor_core@ameritech.net> <20041021101358.B3089@flint.arm.linux.org.uk> <200410210825.00133.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200410210825.00133.dtor_core@ameritech.net>; from dtor_core@ameritech.net on Thu, Oct 21, 2004 at 08:25:00AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 08:25:00AM -0500, Dmitry Torokhov wrote:
> On Thursday 21 October 2004 04:13 am, Russell King wrote:
> > On Thu, Oct 21, 2004 at 02:30:02AM -0500, Dmitry Torokhov wrote:
> > > ChangeSet@1.1971, 2004-10-20 00:57:45-05:00, dtor_core@ameritech.net
> > >   Input: get rid of pm_dev in input core as it is deprecated and
> > >          nothing uses it anyway.
> > 
> > You might as well remove it completely - anything which uses the
> > driver model PM implementation will never call these methods, and
> > ARM uses the driver model PM implementation.
> > 
> > Therefore, any driver using the obsolete pm_register() functions
> > won't receive any PM events.
> > 
> > Same is true on x86 btw.
> > 
> 
> Hmm, I admit I missed arm case but for x86 should work actually:
> 
> in arch/i386/kernel/apm.c:
> static int suspend(int vetoable)
> {
>         int             err;
>         struct apm_user *as;
> 
>         if (pm_send_all(PM_SUSPEND, (void *)3)) {
>                 /* Vetoed */
>                 if (vetoable) {
>                         if (apm_info.connection_version > 0x100)
>                                 set_system_power_state(APM_STATE_REJECT);
>                         err = -EBUSY;
>                         ignore_sys_suspend = 0;
>                         printk(KERN_WARNING "apm: suspend was vetoed.\n");
>                         goto out;
>                 }
>                 printk(KERN_CRIT "apm: suspend was vetoed, but suspending anyway.\n");
>         }
> 
>         device_suspend(3);
>         device_power_down(3);
> ...
> 
> but since you say arm does not care I think we'll proceed with the patch.

Sure, it works for x86 using APM.  Don't forget there's ACPI and the
device model PM implementation (and swsusp).  The latter two did not
call the old interfaces last time I checked.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
