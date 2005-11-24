Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbVKXN7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbVKXN7V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 08:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbVKXN7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 08:59:21 -0500
Received: from [81.2.110.250] ([81.2.110.250]:49070 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750904AbVKXN7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 08:59:20 -0500
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
In-Reply-To: <20051124131310.GE20775@brahms.suse.de>
References: <4379ECC1.20005@suse.de> <437A0649.7010702@suse.de>
	 <437B5A83.8090808@suse.de> <438359D7.7090308@suse.de>
	 <p7364qjjhqx.fsf@verdi.suse.de>
	 <1132764133.7268.51.camel@localhost.localdomain>
	 <20051123163906.GF20775@brahms.suse.de>
	 <1132766489.7268.71.camel@localhost.localdomain>
	 <20051123165923.GJ20775@brahms.suse.de>
	 <1132783243.13095.17.camel@localhost.localdomain>
	 <20051124131310.GE20775@brahms.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Nov 2005 14:30:50 +0000
Message-Id: <1132842650.13095.101.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-11-24 at 14:13 +0100, Andi Kleen wrote:
> > 1. The lock behaviour *is* defined for main memory access by all bus
> > masters.
> 
> For uncached memory, right?

For all memory. Same as processor to processor. 

> > 2. Uncached mappings are unworkable for this because we must never have
> > a page mapped with conflicting cache types - thats ugly, and plain
> > horrific on SMP.
> 
> For kernel mapping change_page_attr() takes care of it,
> and for user space memory following all mappings is the only
> reliable way to find out which process needs to be killed
> anyways - and when you do that you can as well unmap
> or just kill.

You are working from a kernel view address of a page that may be user
space. You don't need or want to kill anything because you are scrubbing
a corrected error.

> 
> > 3. Uncached has undefined semantics when racing a PCI master. Lock has
> > defined semantics. An uncached add #0 is permitted to read the memory
> > and then write it back as two different cycles and I suspect does.
> 
> Consider what happens with such a race: either the PCI master
> gets an bus abort because it still sees the corrupted data.
> Or it already accesses the repaired data. Both is ok.

This is a correctable error so there would be no abort. And there is a
race if you think for a microsecond or two

		Scrubber reads   (add #0 load of input)
		Bus master writes #FFFFFFFF
		Scrubber writes back #0

The lock prefix ensures that doesn't occur.

> > 4. The AMD BIOS guide requires both that LOCK is enabled by default and
> > that the "lock affects the external bus" bit is clear to enable locking
> > on the external bus.
> 
> The "Linux guidelines" might be different.

Then the EDAC code will reconfigure the registers back as expected by
the PC architecture. I've no problem with that and if EDAC is the only
person requiring a semantic that is more expensive it can flip the bits
back and forth. No need for anyone else to pay that cost.

Alan
