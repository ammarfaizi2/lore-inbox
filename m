Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbVAYLt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVAYLt2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 06:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVAYLtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 06:49:23 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:4564 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261925AbVAYLmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 06:42:20 -0500
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
       Andrew Morton <akpm@osdl.org>, fastboot@lists.osdl.org,
       Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 4/29] x86-i8259-shutdown
References: <x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com>
	<1106623970.2399.205.camel@d845pe> <20050125035930.GG13394@redhat.com>
	<m1sm4phpor.fsf@ebiederm.dsl.xmission.com>
	<20050125094350.GA6372@ip68-4-98-123.oc.oc.cox.net>
	<m1brbdhl3l.fsf@ebiederm.dsl.xmission.com>
	<20050125104904.GB5906@ip68-4-98-123.oc.oc.cox.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Jan 2005 04:40:14 -0700
In-Reply-To: <20050125104904.GB5906@ip68-4-98-123.oc.oc.cox.net>
Message-ID: <m17jm1hh41.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok Looking at the code I have finally tracked where apci_power_off()
lives. drives/acpi/poweroff/sleep.c And it has companions in
drivers/acpi/hardware/hwsleep.c

Why I did not find this when I wall looking for things that
set pm_power_off earlier I haven't a clue because it showed up this
time.

One of the functions called by acpi_enter_sleep_state_prep has
this to say.
/******************************************************************************
 *
 * FUNCTION:    acpi_enter_sleep_state_prep
 *
 * PARAMETERS:  sleep_state         - Which sleep state to enter
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Prepare to enter a system sleep state (see ACPI 2.0 spec p 231)
 *              This function must execute with interrupts enabled.
 *              We break sleeping into 2 stages so that OSPM can handle
 *              various OS-specific tasks between the two steps.
 *
 ******************************************************************************/

Since I clearly have interrupts disabled at this point we clearly have
an issue.  Not if we were using apics we would never have had interrupts
enabled when we got here so this code as coded is also broken in
an SMP context.

Cool I wonder how many more bugs work on kexec can flush out?

So the question becomes where is a good place to call 
acpi_enter_sleep_state_prep()?


"Barry K. Nathan" <barryn@pobox.com> writes:

> On Tue, Jan 25, 2005 at 03:14:06AM -0700, Eric W. Biederman wrote:
> > "Barry K. Nathan" <barryn@pobox.com> writes:
> > 
> > > On Tue, Jan 25, 2005 at 01:35:00AM -0700, Eric W. Biederman wrote:
> > > > So I will ask again, as I did when Andrew first pointed this in my
> > > > direction.  What code path in the kernel could possibly care if we
> > > > disable the i8259 after we have disabled all of the other hardware in
> > > > the system.
> > > 
> > > This may be a foolish question, but, are there possibly any code paths
> > > in the *BIOS* that could care?
> > 
> > Fairly unlikely at this point, as the state we have traditionally
> > reprogrammed the i8259 to, delivers interrupts to different vectors
> > than the firmware uses.   So I don't see how telling it not
> > to deliver interrupts where the firmware won't expect them
> > is likely to change things.
> 
> FWIW I've noticed something quirky. I guess this is only likely to show
> up in a contrived scenario, but I have actually reproduced this (by
> accident, even), so maybe it's worth mentioning.
> 
> 1. System is booted with both APM and ACPI disabled. (To be exact, ACPI
> is not compiled into the kernel I tested in this case, and APM is, but
> the BIOS lacks APM support.)
> 2. Ultra-minimal /sbin/init does shutdown syscall.
> 3. "Shutdown: hda
>     Power down."
> 
> You (or I, at least) would expect things to stop here, but we enter the
> Twilight Zone instead:

So would I.
 
> 4. "Kernel panic - not syncing: Attempted to kill init!" (Nothing this
> weird ever happens if I have ACPI enabled. In that case it either
> freezes or properly shuts down.)

What lines are printed just before that?  It would be nice
to know which part of the kernel panic if we can.

At least if you can reproduce this that would be nice.

I wonder if APM is really disabled at this point.  I guess since
I have found the ACPI bug we can save the APM bug for later.

> 5. The admin (that's me) then tries to reboot box without resorting to the
> power or reset buttons. (Actually the chassis in this case doesn't have
> a reset button, and I want to avoid unnecessarily power-cycling the
> thing.)
> 
> Without the i8259 shutdown patch applied, I can reboot with Alt-SysRq-B.
> With the patch, the computer doesn't respond to Alt-SysRq-B and I have
> to use the power button.

That is probably the one legitimate glitch with this patch.  It disables
interrupts so the keyboard becomes unresponsive.  Of course if the
system is really powered down that is not an issue but...

> If anyone's interested, the source code to my minimal /sbin/init is
> here:
> http://bugme.osdl.org/attachment.cgi?id=4398&action=view

Interesting.  

I am wondering if you see the same symptoms if you make this
your /init in a initcpio.gz.  I am wondering if some of the
issues might be related to something not being shutdown properly.

> > It could be that ACPI AML code is trying something at an inappropriate 
> > time.  But I can not even find the ACPI soft power code path.  pm_power_off
> > never seems to get hooked. 
> > 
> > Or it could one of the other kexec related patches for all I know.
> 
> The problem occurs even with no other kexec patches applied. And
> applying all kexec patches except the i8259 shutdown patch fails to
> reproduce the problem.

Very odd.   I was wondering how many test cases had run, before I found
the acpi bug above.  If the problem was not 100% the correlation with
this patch might have been a fluke.  I just want to be certain.

> > Until I get a good data point or a reproducer I can't do anything.
> > It doesn't even make sense to drop the patch because then
> > I won't get a good data point.  And I won't know if similar symptoms
> > crop of if I need to do something else.
> 
> It's only happening on 1 of 4 tested boxes here, too (the other three
> are not affected, but they don't have the same motherboard either). :(

Well if you can help me track this down I would appreciate it.

Do you think you would have time to try some test patches?

Eric
