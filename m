Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbVCARiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbVCARiI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 12:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbVCARhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 12:37:46 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59341 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261987AbVCARhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 12:37:32 -0500
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       barryn@pobox.com, marado@student.dei.uc.pt,
       acpi-devel@lists.sourceforge.net
Subject: Re: 2.6.11-rc4-mm1: something is wrong with swsusp powerdown
References: <20050228231721.GA1326@elf.ucw.cz>
	<20050301015231.091b5329.akpm@osdl.org>
	<m1u0nvr5cn.fsf@ebiederm.dsl.xmission.com>
	<20050301120843.GN1345@elf.ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 01 Mar 2005 10:33:54 -0700
In-Reply-To: <20050301120843.GN1345@elf.ucw.cz>
Message-ID: <m1ll97qni5.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> > I threw it together to test a specific code path, and the fact it
> > fails in software suspend is actually almost confirmation that I am on
> > the right track.  This actually fixed the case I was testing.
> > 
> > In this case the failure is simply because system_state is
> > not set to SYSTEM_POWER_OFF before
> > kernel/power/disk.c:power_down() calls device_shutdown().
> > The appropriate reboot notifier is also not called..
> 
> Can you suggest patch to do it right? Or perhaps there should be
> just_plain_power_machine_down() that does all neccessary
> trickery?

I would call it kernel_power_down() and that
is what I am suggesting is the right fix.

We have it open coded in kernel/sys.c:sys_reboot()
in the switch case for: LINUX_REBOOT_CMD_POWER_OFF

So after the code gets factored out from there all
of the cases that call machine_power_off() and pm_power_off()
directly need to be updated.

There are similar cases for machine_restart() and machine_halt().
But the power off case seems to be the most acute.

My biggest problem with this is I get into the recursive code
cleanup problem.  Where I fix one piece and a bug is exposed somewhere
else.  And that then requires investigation and fixing.

Fixing the callers of machine_power_off() is about the fifth bug
fix down the chain triggered by disabling UP interrupts in
device_shutdown(), SMP interrupts have always been disabled.  With the
first bug fix was to create system devices in the device tree..

I haven't a clue where fixing this one will lead.  Recursive
code fixes are a hard thing to schedule :(

Eric
