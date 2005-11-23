Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030437AbVKWXJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030437AbVKWXJh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030489AbVKWXJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:09:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8874 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030437AbVKWXJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:09:35 -0500
Date: Wed, 23 Nov 2005 15:08:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Jacobowitz <dan@debian.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
       Andi Kleen <ak@suse.de>, Gerd Knorr <kraxel@suse.de>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
In-Reply-To: <20051123222056.GA25078@nevyn.them.org>
Message-ID: <Pine.LNX.4.64.0511231502250.13959@g5.osdl.org>
References: <1132764133.7268.51.camel@localhost.localdomain>
 <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain>
 <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com>
 <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain>
 <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org> <20051123214835.GA24044@nevyn.them.org>
 <Pine.LNX.4.64.0511231416490.13959@g5.osdl.org> <20051123222056.GA25078@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Nov 2005, Daniel Jacobowitz wrote:
> 
> Why should we use a silicon based solution for this, when I posit that
> there are simpler and equally effective userspace solutions?

Name them.

In user space, doing things like clever run-time linking things is 
actually horribly bad. It causes COW faults at startup, and/or makes the 
compiler have to do indirections unnecessarily.  Both of which actually 
make caches less effective, because now processes that really effectively 
do have exactly the same contents have them in different pages.

The other alternative (which apparently glibc actually does use) is to 
dynamically branch over the lock prefixes, which actually works better: 
it's more work dynamically, but it's much cheaper from a startup 
standpoint and there's no memory duplication, so while it is the "stupid" 
approach, it's actually better than the clever one.

The third alternative is to know at link-time that the process never does 
anything threaded, but that needs more developer attention and 
non-standard setups, and you _will_ get it wrong (some library will create 
some thread without the developer even realizing). It also has the 
duplicated library overhead (but at least now the duplication is just 
twice, not "each process duplicates its own private pointer")

In short, there simply isn't any good alternatives. The end result is that 
thread-safe libraries are always in practice thread-safe even on UP, even 
though that serializes the CPU altogether unnecessarily.

I'm sure you can make up alternatives every time you hit one _particular_ 
library, but that just doesn't scale in the real world.

In contrast, the simple silicon support scales wonderfully well. Suddenly 
libraries can be thread-safe _and_ efficient on UP too. You get to eat 
your cake and have it too.

		Linus
