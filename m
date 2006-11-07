Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753385AbWKGVgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385AbWKGVgK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 16:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753397AbWKGVgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 16:36:09 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43660 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1753385AbWKGVgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 16:36:07 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: olson@pathscale.com
Cc: "Bryan O'Sullivan" <bos@serpentine.com>, Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc4: known unfixed regressions (v3)
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
	<20061105064801.GV13381@stusta.de>
	<m1lkmpq5we.fsf@ebiederm.dsl.xmission.com>
	<20061107042214.GC8099@stusta.de> <45501730.8020802@serpentine.com>
	<m1psbzbpxw.fsf@ebiederm.dsl.xmission.com>
	<4550B22C.1060307@serpentine.com>
	<m18xinb1qn.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0611070934570.25925@topaz.pathscale.com>
	<m1mz739l0b.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0611071228230.8122@topaz.pathscale.com>
	<m1wt677zgr.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0611071258220.8122@topaz.pathscale.com>
Date: Tue, 07 Nov 2006 14:35:23 -0700
In-Reply-To: <Pine.LNX.4.64.0611071258220.8122@topaz.pathscale.com> (Dave
	Olson's message of "Tue, 7 Nov 2006 13:01:44 -0800 (PST)")
Message-ID: <m1hcxb7xes.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Olson <olson@pathscale.com> writes:

> On Tue, 7 Nov 2006, Eric W. Biederman wrote:
> | > Displaying something that might change is a fact of life, and no
> | > different than the PCI world.  It's still best to keep things as
> | > correct as possible.
> | 
> | No.  I was thinking of the rat hole in pci config space you have to
> | access to read these registers.  You have to actively write a pci
> | config value to select which register you are going to read.
> | 
> | So by default it is not safe to touch this value from user space,
> | because you could mess up the kernel, if the kernel is updating the
> | value.
>
> Nonetheless, as root, lspci already does that (it displays the MSI
> interrupt info).  I  wasn't talking about fixing that, just saying
> that having the data being as correct as possible, is highly
> desirable.   We can't know everything that everybody is doing with
> the data.

I think we are talking past each other.  I think it is fine but silly
to set a standard register that isn't actually used.  It probably makes
debugging a little easier but it might also make things a little more
confusing because we are doing something totally unnecessary.

The pci capability is fine.  The issue with the hyptertrasnport interrupt
capability is that it is 8 bytes long and controls up to 1024 bytes of data.
It is not nor can I ever it image it being safe for lspci to write the
window address register to read back the interrupt routing register.
Someone poking at this with setpci and lspci is fine.

In general reads of random registers are racy but harmless.  Writes of
registers that the kernel needs to have a specific value should never
ever be done by default, because bad nasty things may happen.  It is
a very good way to shoot yourself in the foot.

> Improvements in the pciutils library and locking with respect to the
> kernel may well be desirable, but are an independent issue from
> correctness.

This is not a race issue this is a true correctness issue.  There
is an address register and a data register.  It will never be correct
for any user space program to write to the address register without
first proving that the kernel does not care what value that register
takes on, or the user has sufficient privileges and says do it anyway
I know what I am doing.

These are not ordinary pci config space registers, although they are standard
registers for hypertransport devices.


Eric
