Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbVKWRDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbVKWRDJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 12:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbVKWRDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 12:03:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55992 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932104AbVKWRDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 12:03:06 -0500
Date: Wed, 23 Nov 2005 09:02:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andi Kleen <ak@suse.de>, Gerd Knorr <kraxel@suse.de>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
In-Reply-To: <1132766489.7268.71.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org> 
 <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de> 
 <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de> 
 <437A0649.7010702@suse.de> <437B5A83.8090808@suse.de>  <438359D7.7090308@suse.de>
 <p7364qjjhqx.fsf@verdi.suse.de>  <1132764133.7268.51.camel@localhost.localdomain>
  <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Nov 2005, Alan Cox wrote:
> 
> The MSR bits will break things like ECC scrubbing however. That can be
> addressed although the test patch I have just refuses to load EDAC if
> the BIOS writers didn't follow the BIOS guidelines.
> 
> Certainly it would be cleaner and easier to save the MSR, scrub and put
> it back than do the fixup magic. Some drivers would need auditing as
> they seem to use locked ops or xchg (implicit lock) to lock with a PCI
> DMA master.

What I suggested to Intel at the Developer Days is to have a MSR (or, 
better yet, a bit in the page table pointer %cr0) that disables "lock" in 
_user_ space. Ie a lock would be a no-op when in CPL3, and only with 
certain processes.

The kernel really isn't that critical. We always need the locks in SMP 
(unlike user space, which never needs them if the process isn't threaded), 
and in the kernel space we occasionally need it even with UP to protect 
against devices. And we _can_ do these instruction rewrites, and they are 
even pretty trivial for the non-hotplug case.

User space is actually a lot more important. People spend more time in 
user space, and there the lock prefix is much more often totally useless 
and cannot just be edited away once per boot.

		Linus
