Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752649AbVHGTrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbVHGTrt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 15:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752650AbVHGTrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 15:47:49 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54682 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1752649AbVHGTrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 15:47:49 -0400
To: Pavel Machek <pavel@suse.cz>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
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
References: <dny87s6oe9.fsf@magla.zg.iskon.hr>
	<m1r7dk82a4.fsf@ebiederm.dsl.xmission.com>
	<42E8439E.9030103@ribosome.natur.cuni.cz>
	<20050727193911.2cb4df88.akpm@osdl.org>
	<42F121CD.5070903@ribosome.natur.cuni.cz>
	<20050803200514.3ddb8195.akpm@osdl.org>
	<20050805140837.GA5556@localhost>
	<42F52AC5.1060109@ribosome.natur.cuni.cz>
	<m1hde2xy74.fsf@ebiederm.dsl.xmission.com>
	<m13bplykt3.fsf_-_@ebiederm.dsl.xmission.com>
	<20050807190222.GF1024@openzaurus.ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 07 Aug 2005 13:46:48 -0600
In-Reply-To: <20050807190222.GF1024@openzaurus.ucw.cz> (Pavel Machek's
 message of "Sun, 7 Aug 2005 21:02:23 +0200")
Message-ID: <m1u0i1wmvr.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> Hi!
>
>> There as been a fair amount of consensus that calling
>> device_suspend(...) in the reboot path was inappropriate now, because
>> the device suspend code was too immature.   With this latest
>> piece of evidence it seems to me that introducing device_suspend(...)
>> in kernel_power_off, kernel_halt, kernel_reboot, or kernel_kexec
>> can never be appropriate.
>
> Code is not ready now => it can never be fixed? Thats quite a strange
> conclusion to make.

It seems there is an fundamental incompatibility with ACPI power off.
As best as I can tell the normal case of device_suspend(PMSG_SUSPEND)
works reasonably well in 2.6.x.

>From what I can tell there are some fairly fundamental semantic
differences, on that code path.  The most peculiar problem I tracked
is someone had a machine that would go into power off state and then
wake right back up because of the device_suspend(PMSG_SUSPEND) change.
If acpi power off doesn't expect the hardware to be suspended I don't
see how you can make device_suspend(PMSG_SUSPEND) a default in 2.6.x.

I won't call it impossible to resolve the problems, but the people
doing it must be extremely sensitive to the subtle semantic
differences that exist and the burden of proof for showing things work
better need to be extremely high.  And the developer who reintroduces
it gets to own all of the reboot/halt/power off problems in the stable
tree when it gets merged.

Pavel the fact that you did not articulate a possibility that your
change could have caused most of the problems that were seen with
it is what scares me the most.  The fairly trivial and obvious
problems were not addressed when the patch was merged much less the
subtle ones.  Your initial patch did not even touch all of the code
paths necessary to achieve what it was trying to do.

So yes without a darn good argument as to why it should work.  I will
go with the experimental evidence that it fails miserably and
trivially because of semantic incompatibility and can therefore
never be fixed.

Eric
