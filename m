Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbVHIR0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbVHIR0j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 13:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbVHIR0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 13:26:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36276 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932544AbVHIR0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 13:26:38 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-pm@osdl.org,
       =?iso-8859-15?q?Martin_MOKREJ=A6?= 
	<mmokrejs@ribosome.natur.cuni.cz>,
       Zlatko Calusic <zlatko.calusic@iskon.hr>,
       =?iso-8859-1?q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@24x7linux.com>,
       john@illhostit.com, sjordet@gmail.com, fastboot@lists.osdl.org,
       linux-kernel@24x7linux.com, ncunningham@cyclades.com,
       Greg KH <greg@kroah.com>
Subject: Re: FYI: device_suspend(...) in kernel_power_off().
References: <42E8439E.9030103@ribosome.natur.cuni.cz>
	<20050727193911.2cb4df88.akpm@osdl.org>
	<42F121CD.5070903@ribosome.natur.cuni.cz>
	<20050803200514.3ddb8195.akpm@osdl.org>
	<20050805140837.GA5556@localhost>
	<42F52AC5.1060109@ribosome.natur.cuni.cz>
	<m1hde2xy74.fsf@ebiederm.dsl.xmission.com>
	<m13bplykt3.fsf_-_@ebiederm.dsl.xmission.com>
	<20050807190222.GF1024@openzaurus.ucw.cz>
	<m1u0i1wmvr.fsf@ebiederm.dsl.xmission.com>
	<20050807211104.GE3100@elf.ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 09 Aug 2005 11:25:31 -0600
In-Reply-To: <20050807211104.GE3100@elf.ucw.cz> (Pavel Machek's message of
 "Sun, 7 Aug 2005 23:11:04 +0200")
Message-ID: <m1pssnvx84.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
>
>> >> There as been a fair amount of consensus that calling
>> >> device_suspend(...) in the reboot path was inappropriate now, because
>> >> the device suspend code was too immature.   With this latest
>> >> piece of evidence it seems to me that introducing device_suspend(...)
>> >> in kernel_power_off, kernel_halt, kernel_reboot, or kernel_kexec
>> >> can never be appropriate.
>> >
>> > Code is not ready now => it can never be fixed? Thats quite a strange
>> > conclusion to make.
>> 
>> It seems there is an fundamental incompatibility with ACPI power off.
>> As best as I can tell the normal case of device_suspend(PMSG_SUSPEND)
>> works reasonably well in 2.6.x.
>
> Powerdown is going to have the same problems as the powerdown at the
> end of suspend-to-disk. Can you ask people reporting broken shutdown
> to try suspend-to-disk?

Everyone I know of who is affected has been copied on this thread.
However your request is just nonsense.  There is a device_resume in
the code before we get to the device_shutdown so there should be no
effect at all.  Are we looking at the same kernel?

>> >From what I can tell there are some fairly fundamental semantic
>> differences, on that code path.  The most peculiar problem I tracked
>> is someone had a machine that would go into power off state and then
>> wake right back up because of the device_suspend(PMSG_SUSPEND)
>> change.
>
> So something is wrong with ACPI wakeup GPEs. It would hurt in
> suspend-to-disk case, too.

Something was wrong.  I can't possibly see how the suspend-to-disk
case would be affected.

>> I won't call it impossible to resolve the problems, but the people
>
> Good.

Nope.  Now that I have read the code I would just call it nonsense.

>> So yes without a darn good argument as to why it should work.  I will
>> go with the experimental evidence that it fails miserably and
>> trivially because of semantic incompatibility and can therefore
>> never be fixed.
>
> I do not think any "semantic" issues exist. We need to pass detailed
> info down to the drivers that care, and we need to fix all the bugs in
> the drivers. That should be pretty much it.

Given that acpi and other platform firmware is involved there are
pieces we cannot fix.  We either match the spec or we are incorrect.

I haven't a clue how suspend/resume is expected to interact with
things in suspend to disk scenario.  Reading through the code
the power message is PMSG_FREEZE not PMSG_SUSPEND (as you
implemented).  All of the hardware is actually resumed before
we device_shutdown() is called.

I want to see the correlation between device_suspend(PMSG_FREEZE) and
the code in device_shutdown(), but I don't see it.
device_suspend(...) is all about allowing the state of a device to be
preserved.  device_shutdown() is really about stopping it.  These are
really quite different operations. 

With the pm_suspend_disk calling kernel_power_off it appears that we
currently have complete code reuse of the relevant code on that path.

Currently I see no true redundancy between the two cases at all.
The methods do different things for different purposes.  Which is
about the largest semantic difference I can think of.  The fact
that the methods at first glance look like they do the same
thing is probably the real surprise.

Calling device_suspend(...) from kernel_power_off, kernel_halt,
kernel_kexec, or kernel_restart seems pointless, useless and silly.

Eric
