Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbVJFIhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbVJFIhb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 04:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbVJFIha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 04:37:30 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:8359 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750753AbVJFIh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 04:37:29 -0400
Date: Thu, 6 Oct 2005 04:37:16 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: Mark Knecht <markknecht@gmail.com>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: 2.6.14-rc3-rt2
In-Reply-To: <20051006081055.GA20491@elte.hu>
Message-ID: <Pine.LNX.4.58.0510060433010.28535@localhost.localdomain>
References: <20051004130009.GB31466@elte.hu>
 <5bdc1c8b0510040944q233f14e6g17d53963a4496c1f@mail.gmail.com>
 <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com>
 <1128450029.13057.60.camel@tglx.tec.linutronix.de>
 <5bdc1c8b0510041158m3620f5dcy2dafda545ad3cd5e@mail.gmail.com>
 <1128458707.13057.68.camel@tglx.tec.linutronix.de>
 <5bdc1c8b0510041349g1a4f2484qd17a11812c8ccac3@mail.gmail.com>
 <20051005105605.GA27075@elte.hu> <5bdc1c8b0510051014q3bb02d5bl80d2c88cc884fe35@mail.gmail.com>
 <Pine.LNX.4.58.0510060403210.28535@localhost.localdomain> <20051006081055.GA20491@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Oct 2005, Ingo Molnar wrote:

>
> * Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > Found the problem.  You're using a 64 bit machine and flags in the
> > acpi code is defined as u32 and not unsigned long.  Ingo's tests put
> > some checks in the flags at the MSBs and these are being truncated.
>
> ahh ... I would not be surprised if this caused actual problems on x64
> in the upstream kernel too: using save_flags() over u32 will corrupt a
> word on the stack ...
>

Actually, it's still safe upstream.  The locks are taken via a function
defined as:

unsigned long acpi_os_acquire_lock(acpi_handle handle)
{
	unsigned long flags;
	spin_lock_irqsave((spinlock_t *) handle, flags);
	return flags;
}

So a u32 flags with

  flags = acpi_os_acquire_lock(lock);

would be safe, unless a 64 bit machine stored the value of IR in the upper
word, which I don't know of any archs that do that.

-- Steve

