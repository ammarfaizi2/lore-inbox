Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVAYKtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVAYKtV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 05:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVAYKtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 05:49:21 -0500
Received: from orb.pobox.com ([207.8.226.5]:1165 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261882AbVAYKtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 05:49:13 -0500
Date: Tue, 25 Jan 2005 02:49:05 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Barry K. Nathan" <barryn@pobox.com>, linux-kernel@vger.kernel.org,
       Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       fastboot@lists.osdl.org, Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 4/29] x86-i8259-shutdown
Message-ID: <20050125104904.GB5906@ip68-4-98-123.oc.oc.cox.net>
References: <x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com> <1106623970.2399.205.camel@d845pe> <20050125035930.GG13394@redhat.com> <m1sm4phpor.fsf@ebiederm.dsl.xmission.com> <20050125094350.GA6372@ip68-4-98-123.oc.oc.cox.net> <m1brbdhl3l.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1brbdhl3l.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 03:14:06AM -0700, Eric W. Biederman wrote:
> "Barry K. Nathan" <barryn@pobox.com> writes:
> 
> > On Tue, Jan 25, 2005 at 01:35:00AM -0700, Eric W. Biederman wrote:
> > > So I will ask again, as I did when Andrew first pointed this in my
> > > direction.  What code path in the kernel could possibly care if we
> > > disable the i8259 after we have disabled all of the other hardware in
> > > the system.
> > 
> > This may be a foolish question, but, are there possibly any code paths
> > in the *BIOS* that could care?
> 
> Fairly unlikely at this point, as the state we have traditionally
> reprogrammed the i8259 to, delivers interrupts to different vectors
> than the firmware uses.   So I don't see how telling it not
> to deliver interrupts where the firmware won't expect them
> is likely to change things.

FWIW I've noticed something quirky. I guess this is only likely to show
up in a contrived scenario, but I have actually reproduced this (by
accident, even), so maybe it's worth mentioning.

1. System is booted with both APM and ACPI disabled. (To be exact, ACPI
is not compiled into the kernel I tested in this case, and APM is, but
the BIOS lacks APM support.)
2. Ultra-minimal /sbin/init does shutdown syscall.
3. "Shutdown: hda
    Power down."

You (or I, at least) would expect things to stop here, but we enter the
Twilight Zone instead:

4. "Kernel panic - not syncing: Attempted to kill init!" (Nothing this
weird ever happens if I have ACPI enabled. In that case it either
freezes or properly shuts down.)

5. The admin (that's me) then tries to reboot box without resorting to the
power or reset buttons. (Actually the chassis in this case doesn't have
a reset button, and I want to avoid unnecessarily power-cycling the
thing.)

Without the i8259 shutdown patch applied, I can reboot with Alt-SysRq-B.
With the patch, the computer doesn't respond to Alt-SysRq-B and I have
to use the power button.

If anyone's interested, the source code to my minimal /sbin/init is
here:
http://bugme.osdl.org/attachment.cgi?id=4398&action=view

> It could be that ACPI AML code is trying something at an inappropriate 
> time.  But I can not even find the ACPI soft power code path.  pm_power_off
> never seems to get hooked. 
> 
> Or it could one of the other kexec related patches for all I know.

The problem occurs even with no other kexec patches applied. And
applying all kexec patches except the i8259 shutdown patch fails to
reproduce the problem.

> Until I get a good data point or a reproducer I can't do anything.
> It doesn't even make sense to drop the patch because then
> I won't get a good data point.  And I won't know if similar symptoms
> crop of if I need to do something else.

It's only happening on 1 of 4 tested boxes here, too (the other three
are not affected, but they don't have the same motherboard either). :(

-Barry K. Nathan <barryn@pobox.com>

