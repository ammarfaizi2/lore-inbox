Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVG0XL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVG0XL4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 19:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVG0XJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 19:09:33 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48281 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261214AbVG0XIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 19:08:36 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/23] reboot-fixes
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<20050727025923.7baa38c9.akpm@osdl.org>
	<m1k6jc9sdr.fsf@ebiederm.dsl.xmission.com>
	<20050727104123.7938477a.akpm@osdl.org>
	<m18xzs9ktc.fsf@ebiederm.dsl.xmission.com>
	<20050727224711.GA6671@elf.ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 27 Jul 2005 17:07:52 -0600
In-Reply-To: <20050727224711.GA6671@elf.ucw.cz> (Pavel Machek's message of
 "Thu, 28 Jul 2005 00:47:11 +0200")
Message-ID: <m1y87r7sqf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
>
> Yes, I think we should do device_suspend(PMSG_FREEZE) in reboot path.
>
>> My gut feel is the device_suspend calls are the right direction
>> as it allows us to remove code from the drivers and possible
>> kill device_shutdown completely. 
>> 
>> But this close to 2.6.13 I'm not certain what the correct solution
>> is.  With this we have had issues with both ide and the e1000.
>> But those are among the few drivers that do anything in either
>> device_shutdown() or the reboot_notifier.
> ..
>> Looking at it more closely the code is confusing because
>> FREEZE and SUSPEND are actually the same message, and in
>> addition to what shutdown does they place the device in
>
> Not in -mm; I was finally able to fix that one.

Cool.

>> My gut feel is that device_suspend(PMSG_FREEZE) should be
>> removed from kernel_restart until is a different message
>> from PMSG_SUSPEND at which point it should be equivalent
>> to device_shutdown and we can remove that case.
>
> PMSG_FREEZE != PMSG_SUSPEND in current -mm, but I'm not sure if we can
> push that to 2.6.13...

Currently device_suspend(PMSG_FREEZE) in the reboot path breaks
the e1000 and the ide driver.  Which is common enough hardware it
effectively breaks reboots in 2.6.13 despite the fact that nearly
everything thing else works.

To make device_suspend(PMSG_FREEZE) solid in the reboot path I think
it would take pushing and stabilizing all of PMSG_FREEZE != PMSG_SUSPEND.
It will certainly take a bunch of digging to make certain reboots keep
working.  Since the number of drivers that implement either a reboot
notifier or a shutdown method is small the it is conceivable we could
track down all of the serious issues before 2.6.13.  However I'm
not ready to take point on the bug hunt.

So unless you are really ambitious I'd like to take
device_suspend(PMSG_FREEZE) out of the reboot path for
2.6.13, put in -mm where people can bang on it for a bit
and see that it is coming and delay the merge with the stable
branch until the bugs with common hardware have been sorted out.

Eric





