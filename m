Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbVKWV2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbVKWV2b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 16:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbVKWV2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 16:28:30 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:36307 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932534AbVKWV22
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 16:28:28 -0500
Subject: Re: [patch] SMP alternatives
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Gerd Knorr <kraxel@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20051123165923.GJ20775@brahms.suse.de>
References: <4378A7F3.9070704@suse.de>
	 <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de>
	 <437A0649.7010702@suse.de> <437B5A83.8090808@suse.de>
	 <438359D7.7090308@suse.de> <p7364qjjhqx.fsf@verdi.suse.de>
	 <1132764133.7268.51.camel@localhost.localdomain>
	 <20051123163906.GF20775@brahms.suse.de>
	 <1132766489.7268.71.camel@localhost.localdomain>
	 <20051123165923.GJ20775@brahms.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 23 Nov 2005 22:00:43 +0000
Message-Id: <1132783243.13095.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-11-23 at 17:59 +0100, Andi Kleen wrote:
> You mean it might break an insane hack in someone's ECC scrubbing
> implementation. But last time I talked to people about this
> they suggested just using an uncacheable mapping instead of 
> this horrible thing. Uncached is actually what you want there,
> not relying on some undocumented lock bus cycle behaviour.

I reviewed your suggestions before:

1. The lock behaviour *is* defined for main memory access by all bus
masters.
2. Uncached mappings are unworkable for this because we must never have
a page mapped with conflicting cache types - thats ugly, and plain
horrific on SMP.
3. Uncached has undefined semantics when racing a PCI master. Lock has
defined semantics. An uncached add #0 is permitted to read the memory
and then write it back as two different cycles and I suspect does.
4. The AMD BIOS guide requires both that LOCK is enabled by default and
that the "lock affects the external bus" bit is clear to enable locking
on the external bus.

The problems we would have would be if some smartarse chip designed
optimised lock addl #0 to a no-op and the fact we possibly ought to
wbinvd the page and read it again to check the ECC recovery worked.

> Which drivers? I don't think there is anything in tree. I went
> over all the drivers early in the x86-64 port.

eepro100 used to from memory but it now carefully does a 16bit I/O.

> I'm sure I would have noticed because they very likely needed inline
> assembly for this and this generally broke when moving to x86-64.

Or use xchg() which is implied lock on x86 so isn't magically made
non-atomic by the LOCK macros. I did a sweep for xchg and didn't see any
problem.

> DRM did some tricks, but generally not with the hardware I believe,
> only between user/kernel space.

It does it extensively for user/kernel. Whether it does it with the GPU
in user space I can't say. The cards I am familar with do not.

Alan

